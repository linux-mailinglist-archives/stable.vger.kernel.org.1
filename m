Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34B47B882E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbjJDSNc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbjJDSNa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A48DC
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:13:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F2C433C7;
        Wed,  4 Oct 2023 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443205;
        bh=/Y4qqHvTqWQMY3wudMHiiIUG/mFmCjdPzcCZb8PyLDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAc83pbq7G2o9LddZEQxiKsAOZhfa1JPdapmXF9z3sZCKIp1QeQHn7VyQz7twbJF9
         Hb6udQdZGeUwtrfPdJgqyPlcRh+N8OQKxT7Joq/JnDo2348vYFfbaUHUv+pMVAZxOV
         xe/eNmJdrOR1e0xfVHjoU5kMj3r+NXVCVOF8/z1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        bridge@lists.linux-foundation.org, Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/259] net: bridge: use DEV_STATS_INC()
Date:   Wed,  4 Oct 2023 19:54:07 +0200
Message-ID: <20231004175220.784507505@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 44bdb313da57322c9b3c108eb66981c6ec6509f4 ]

syzbot/KCSAN reported data-races in br_handle_frame_finish() [1]
This function can run from multiple cpus without mutual exclusion.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

Handles updates to dev->stats.tx_dropped while we are at it.

[1]
BUG: KCSAN: data-race in br_handle_frame_finish / br_handle_frame_finish

read-write to 0xffff8881374b2178 of 8 bytes by interrupt on cpu 1:
br_handle_frame_finish+0xd4f/0xef0 net/bridge/br_input.c:189
br_nf_hook_thresh+0x1ed/0x220
br_nf_pre_routing_finish_ipv6+0x50f/0x540
NF_HOOK include/linux/netfilter.h:304 [inline]
br_nf_pre_routing_ipv6+0x1e3/0x2a0 net/bridge/br_netfilter_ipv6.c:178
br_nf_pre_routing+0x526/0xba0 net/bridge/br_netfilter_hooks.c:508
nf_hook_entry_hookfn include/linux/netfilter.h:144 [inline]
nf_hook_bridge_pre net/bridge/br_input.c:272 [inline]
br_handle_frame+0x4c9/0x940 net/bridge/br_input.c:417
__netif_receive_skb_core+0xa8a/0x21e0 net/core/dev.c:5417
__netif_receive_skb_one_core net/core/dev.c:5521 [inline]
__netif_receive_skb+0x57/0x1b0 net/core/dev.c:5637
process_backlog+0x21f/0x380 net/core/dev.c:5965
__napi_poll+0x60/0x3b0 net/core/dev.c:6527
napi_poll net/core/dev.c:6594 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6727
__do_softirq+0xc1/0x265 kernel/softirq.c:553
run_ksoftirqd+0x17/0x20 kernel/softirq.c:921
smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

read-write to 0xffff8881374b2178 of 8 bytes by interrupt on cpu 0:
br_handle_frame_finish+0xd4f/0xef0 net/bridge/br_input.c:189
br_nf_hook_thresh+0x1ed/0x220
br_nf_pre_routing_finish_ipv6+0x50f/0x540
NF_HOOK include/linux/netfilter.h:304 [inline]
br_nf_pre_routing_ipv6+0x1e3/0x2a0 net/bridge/br_netfilter_ipv6.c:178
br_nf_pre_routing+0x526/0xba0 net/bridge/br_netfilter_hooks.c:508
nf_hook_entry_hookfn include/linux/netfilter.h:144 [inline]
nf_hook_bridge_pre net/bridge/br_input.c:272 [inline]
br_handle_frame+0x4c9/0x940 net/bridge/br_input.c:417
__netif_receive_skb_core+0xa8a/0x21e0 net/core/dev.c:5417
__netif_receive_skb_one_core net/core/dev.c:5521 [inline]
__netif_receive_skb+0x57/0x1b0 net/core/dev.c:5637
process_backlog+0x21f/0x380 net/core/dev.c:5965
__napi_poll+0x60/0x3b0 net/core/dev.c:6527
napi_poll net/core/dev.c:6594 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6727
__do_softirq+0xc1/0x265 kernel/softirq.c:553
do_softirq+0x5e/0x90 kernel/softirq.c:454
__local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
__raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
_raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
spin_unlock_bh include/linux/spinlock.h:396 [inline]
batadv_tt_local_purge+0x1a8/0x1f0 net/batman-adv/translation-table.c:1356
batadv_tt_purge+0x2b/0x630 net/batman-adv/translation-table.c:3560
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x00000000000d7190 -> 0x00000000000d7191

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 14848 Comm: kworker/u4:11 Not tainted 6.6.0-rc1-syzkaller-00236-gad8a69f361b9 #0

Fixes: 1c29fc4989bc ("[BRIDGE]: keep track of received multicast packets")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230918091351.1356153-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_forward.c | 4 ++--
 net/bridge/br_input.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index bd54f17e3c3d8..4e3394a7d7d45 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -124,7 +124,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return -ENOMEM;
 	}
 
@@ -263,7 +263,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return;
 	}
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 68b3e850bcb9d..6bb272894c960 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -164,12 +164,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb)) {
 				local_rcv = true;
-				br->dev->stats.multicast++;
+				DEV_STATS_INC(br->dev, multicast);
 			}
 			mcast_hit = true;
 		} else {
 			local_rcv = true;
-			br->dev->stats.multicast++;
+			DEV_STATS_INC(br->dev, multicast);
 		}
 		break;
 	case BR_PKT_UNICAST:
-- 
2.40.1



