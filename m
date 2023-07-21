Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19275D419
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjGUTR6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGUTR5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B51FD2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA5261D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE391C433C8;
        Fri, 21 Jul 2023 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967067;
        bh=JbVmS/ii7+KX3NhIZ+Z0Mh61XcuFPp+JdCj6MQfqD0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiNDnulvg6O4KM6FajETTF4arKmtd4FqAdCdxxfmpCgf5HNEdPVi2rKqGXT63Fdb1
         MLSL+vwf5tm27oAA1HGINLDNlPDPLkA6WlA94sPECQkxAfQX7G73Ritu4sXeYHoOV1
         UvtaHu4x8NgF/woHoDNYT1AQ8+aXqWPld5JvZTWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Kumlien <ian.kumlien@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/223] net: prevent skb corruption on frag list segmentation
Date:   Fri, 21 Jul 2023 18:04:46 +0200
Message-ID: <20230721160522.279811892@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit c329b261afe71197d9da83c1f18eb45a7e97e089 ]

Ian reported several skb corruptions triggered by rx-gro-list,
collecting different oops alike:

[   62.624003] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[   62.631083] #PF: supervisor read access in kernel mode
[   62.636312] #PF: error_code(0x0000) - not-present page
[   62.641541] PGD 0 P4D 0
[   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #364
[   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F, BIOS 1.7a 10/13/2022
[   62.663344] RIP: 0010:__udp_gso_segment (./include/linux/skbuff.h:2858
./include/linux/udp.h:23 net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
net/ipv4/udp_offload.c:277)
[   62.687193] RSP: 0018:ffffbd3a83b4f868 EFLAGS: 00010246
[   62.692515] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 0000000000000000
[   62.699743] RDX: ffffa124def8a000 RSI: 0000000000000079 RDI: ffffa125952a14d4
[   62.706970] RBP: ffffa124def8a000 R08: 0000000000000022 R09: 00002000001558c9
[   62.714199] R10: 0000000000000000 R11: 00000000be554639 R12: 00000000000000e2
[   62.721426] R13: ffffa125952a1400 R14: ffffa125952a1400 R15: 00002000001558c9
[   62.728654] FS:  0000000000000000(0000) GS:ffffa127efa40000(0000)
knlGS:0000000000000000
[   62.736852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.742702] CR2: 00000000000000c0 CR3: 00000001034b0000 CR4: 00000000003526e0
[   62.749948] Call Trace:
[   62.752498]  <TASK>
[   62.779267] inet_gso_segment (net/ipv4/af_inet.c:1398)
[   62.787605] skb_mac_gso_segment (net/core/gro.c:141)
[   62.791906] __skb_gso_segment (net/core/dev.c:3403 (discriminator 2))
[   62.800492] validate_xmit_skb (./include/linux/netdevice.h:4862
net/core/dev.c:3659)
[   62.804695] validate_xmit_skb_list (net/core/dev.c:3710)
[   62.809158] sch_direct_xmit (net/sched/sch_generic.c:330)
[   62.813198] __dev_queue_xmit (net/core/dev.c:3805 net/core/dev.c:4210)
net/netfilter/core.c:626)
[   62.821093] br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[   62.825652] maybe_deliver (net/bridge/br_forward.c:193)
[   62.829420] br_flood (net/bridge/br_forward.c:233)
[   62.832758] br_handle_frame_finish (net/bridge/br_input.c:215)
[   62.837403] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[   62.851417] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[   62.866114] __netif_receive_skb_list_core (net/core/dev.c:5570)
[   62.871367] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[   62.876795] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[   62.881004] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3191)
[   62.893534] __napi_poll (net/core/dev.c:6498)
[   62.897133] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[   62.905276] kthread (kernel/kthread.c:379)
[   62.913435] ret_from_fork (arch/x86/entry/entry_64.S:314)
[   62.917119]  </TASK>

In the critical scenario, rx-gro-list GRO-ed packets are fed, via a
bridge, both to the local input path and to an egress device (tun).

The segmentation of such packets unsafely writes to the cloned skbs
with shared heads.

This change addresses the issue by uncloning as needed the
to-be-segmented skbs.

Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
Tested-by: Ian Kumlien <ian.kumlien@gmail.com>
Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ef9772b12624c..b6c16db86c719 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4042,6 +4042,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
+	/* Ensure the head is writeable before touching the shared info */
+	err = skb_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
-- 
2.39.2



