Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1B7ECE08
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjKOTkH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjKOTkG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FCD55
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC520C433C8;
        Wed, 15 Nov 2023 19:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077193;
        bh=Dlr5PzhwHGJNfQIAFZE35V2ay0pKgsaZTSK1md8XApw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvroT4+rowoaeKrni1tZxGI/NK2mfeKKIOLOaNz74uBF73xKBLMXOv99m1OBONDAe
         4GddWwYnm2dExjTgxYUvc7MpePxhpUpBdO+xws3PWWocJWUB4XY1VRCV6bPkRxQMla
         lFW2nEYgtldEiVOIAn4rp0xLunG1k8pxujJjkWzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Wragg <dwragg@cloudflare.com>,
        Yan Zhai <yan@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 154/603] ipv6: avoid atomic fragment on GSO packets
Date:   Wed, 15 Nov 2023 14:11:39 -0500
Message-ID: <20231115191623.842982124@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 03d6c848bfb406e9ef6d9846d759e97beaeea113 ]

When the ipv6 stack output a GSO packet, if its gso_size is larger than
dst MTU, then all segments would be fragmented. However, it is possible
for a GSO packet to have a trailing segment with smaller actual size
than both gso_size as well as the MTU, which leads to an "atomic
fragment". Atomic fragments are considered harmful in RFC-8021. An
Existing report from APNIC also shows that atomic fragments are more
likely to be dropped even it is equivalent to a no-op [1].

Add an extra check in the GSO slow output path. For each segment from
the original over-sized packet, if it fits with the path MTU, then avoid
generating an atomic fragment.

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
Reported-by: David Wragg <dwragg@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Link: https://lore.kernel.org/r/90912e3503a242dca0bc36958b11ed03a2696e5e.1698156966.git.yan@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_output.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 54fc4c711f2c5..1121082901b99 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -162,7 +162,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last GSO segment can be smaller than gso_size (and MTU).
+		 * Adding a fragment header would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021). Avoid that.
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
 		if (err && ret == 0)
 			ret = err;
 	}
-- 
2.42.0



