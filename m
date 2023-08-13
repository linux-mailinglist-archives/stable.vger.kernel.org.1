Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6977AD7A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjHMVsf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjHMVsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A019B3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A03A661A2D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F50AC433C7;
        Sun, 13 Aug 2023 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962880;
        bh=W18NLKY+dTwgkdAYskxCO8TSKrbtqCSffGyB5GheuKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cg7UID4sU8XrxA5fllPpy6yML+QD9wbNOO7dqBECUGpQhcc9YCzo+zNpjwtRmBO35
         fXsEMQvClIRyj13cPGeLCDDkH9GIiQj9phm9MqntQZmARd60LORjHQCuXkgezhJ5pW
         B8N08/GhRm7hQn4fvMWjU7C8uvSQ5n0sEjwWFMo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 41/68] tunnels: fix kasan splat when generating ipv4 pmtu error
Date:   Sun, 13 Aug 2023 23:19:42 +0200
Message-ID: <20230813211709.404525368@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 6a7ac3d20593865209dceb554d8b3f094c6bd940 upstream.

If we try to emit an icmp error in response to a nonliner skb, we get

BUG: KASAN: slab-out-of-bounds in ip_compute_csum+0x134/0x220
Read of size 4 at addr ffff88811c50db00 by task iperf3/1691
CPU: 2 PID: 1691 Comm: iperf3 Not tainted 6.5.0-rc3+ #309
[..]
 kasan_report+0x105/0x140
 ip_compute_csum+0x134/0x220
 iptunnel_pmtud_build_icmp+0x554/0x1020
 skb_tunnel_check_pmtu+0x513/0xb80
 vxlan_xmit_one+0x139e/0x2ef0
 vxlan_xmit+0x1867/0x2760
 dev_hard_start_xmit+0x1ee/0x4f0
 br_dev_queue_push_xmit+0x4d1/0x660
 [..]

ip_compute_csum() cannot deal with nonlinear skbs, so avoid it.
After this change, splat is gone and iperf3 is no longer stuck.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Florian Westphal <fw@strlen.de>
Link: https://lore.kernel.org/r/20230803152653.29535-2-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -224,7 +224,7 @@ static int iptunnel_pmtud_build_icmp(str
 		.un.frag.__unused	= 0,
 		.un.frag.mtu		= ntohs(mtu),
 	};
-	icmph->checksum = ip_compute_csum(icmph, len);
+	icmph->checksum = csum_fold(skb_checksum(skb, 0, len, 0));
 	skb_reset_transport_header(skb);
 
 	niph = skb_push(skb, sizeof(*niph));


