Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E307D3208
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjJWLQC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjJWLPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:15:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC4D7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:15:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD7C433CB;
        Mon, 23 Oct 2023 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059748;
        bh=H0zgPKtooeFAF2VN/yn1l/unshUhBB9OMDQBmDIgOHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJ+VHJII0DK00cl/i/yReKW922wpnMam924obEVYwFSag86mkJkMPBSt8EpBp1y3O
         8BvNf8JFG2VZkzzgSLpnZy8kdlFKf/bF0+oa7obMWMRfs7AG1BgpAEAi8Z5F5VdrO1
         bHvlAiPs7usMbF4WJznS43uwgcDAbOK/vDaRTnfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.19 40/98] dev_forward_skb: do not scrub skb mark within the same name space
Date:   Mon, 23 Oct 2023 12:56:29 +0200
Message-ID: <20231023104815.011824493@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit ff70202b2d1ad522275c6aadc8c53519b6a22c57 upstream.

The goal is to keep the mark during a bpf_redirect(), like it is done for
legacy encapsulation / decapsulation, when there is no x-netns.
This was initially done in commit 213dd74aee76 ("skbuff: Do not scrub skb
mark within the same name space").

When the call to skb_scrub_packet() was added in dev_forward_skb() (commit
8b27f27797ca ("skb: allow skb_scrub_packet() to be used by tunnels")), the
second argument (xnet) was set to true to force a call to skb_orphan(). At
this time, the mark was always cleanned up by skb_scrub_packet(), whatever
xnet value was.
This call to skb_orphan() was removed later in commit
9c4c325252c5 ("skbuff: preserve sock reference when scrubbing the skb.").
But this 'true' stayed here without any real reason.

Let's correctly set xnet in ____dev_forward_skb(), this function has access
to the previous interface and to the new interface.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdevice.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3661,7 +3661,7 @@ static __always_inline int ____dev_forwa
 		return NET_RX_DROP;
 	}
 
-	skb_scrub_packet(skb, true);
+	skb_scrub_packet(skb, !net_eq(dev_net(dev), dev_net(skb->dev)));
 	skb->priority = 0;
 	return 0;
 }


