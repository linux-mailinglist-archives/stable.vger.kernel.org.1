Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639637872BF
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjHXO4p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbjHXO4W (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068D19B2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE45612C4
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4BBC433C8;
        Thu, 24 Aug 2023 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888979;
        bh=lo5MGI7j44sqCsS4mng3fchd2K9GQH3eSmS1MHIvV5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAp4NRzbdbYkbxhnPbb4UmERhvd4UDgfb8C9s30gBCWgHRWwftRKPc2N58kJa4rqE
         88AgKnQbesN95P7x1MF3wWn5brc8O5vhg5iL43R6LeeoMo5Yu3yxXgqgqVF4pEzJXC
         rEgc1f0j/JMKWxpPzigkuWm2EdcH90P20ZMSDb7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 082/139] xfrm: fix slab-use-after-free in decode_session6
Date:   Thu, 24 Aug 2023 16:50:05 +0200
Message-ID: <20230824145027.203639748@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 53223f2ed1ef5c90dad814daaaefea4e68a933c8 ]

When the xfrm device is set to the qdisc of the sfb type, the cb field
of the sent skb may be modified during enqueuing. Then,
slab-use-after-free may occur when the xfrm device sends IPv6 packets.

The stack information is as follows:
BUG: KASAN: slab-use-after-free in decode_session6+0x103f/0x1890
Read of size 1 at addr ffff8881111458ef by task swapper/3/0
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.4.0-next-20230707 #409
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
Call Trace:
<IRQ>
dump_stack_lvl+0xd9/0x150
print_address_description.constprop.0+0x2c/0x3c0
kasan_report+0x11d/0x130
decode_session6+0x103f/0x1890
__xfrm_decode_session+0x54/0xb0
xfrmi_xmit+0x173/0x1ca0
dev_hard_start_xmit+0x187/0x700
sch_direct_xmit+0x1a3/0xc30
__qdisc_run+0x510/0x17a0
__dev_queue_xmit+0x2215/0x3b10
neigh_connected_output+0x3c2/0x550
ip6_finish_output2+0x55a/0x1550
ip6_finish_output+0x6b9/0x1270
ip6_output+0x1f1/0x540
ndisc_send_skb+0xa63/0x1890
ndisc_send_rs+0x132/0x6f0
addrconf_rs_timer+0x3f1/0x870
call_timer_fn+0x1a0/0x580
expire_timers+0x29b/0x4b0
run_timer_softirq+0x326/0x910
__do_softirq+0x1d4/0x905
irq_exit_rcu+0xb7/0x120
sysvec_apic_timer_interrupt+0x97/0xc0
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:intel_idle_hlt+0x23/0x30
Code: 1f 84 00 00 00 00 00 f3 0f 1e fa 41 54 41 89 d4 0f 1f 44 00 00 66 90 0f 1f 44 00 00 0f 00 2d c4 9f ab 00 0f 1f 44 00 00 fb f4 <fa> 44 89 e0 41 5c c3 66 0f 1f 44 00 00 f3 0f 1e fa 41 54 41 89 d4
RSP: 0018:ffffc90000197d78 EFLAGS: 00000246
RAX: 00000000000a83c3 RBX: ffffe8ffffd09c50 RCX: ffffffff8a22d8e5
RDX: 0000000000000001 RSI: ffffffff8d3f8080 RDI: ffffe8ffffd09c50
RBP: ffffffff8d3f8080 R08: 0000000000000001 R09: ffffed1026ba6d9d
R10: ffff888135d36ceb R11: 0000000000000001 R12: 0000000000000001
R13: ffffffff8d3f8100 R14: 0000000000000001 R15: 0000000000000000
cpuidle_enter_state+0xd3/0x6f0
cpuidle_enter+0x4e/0xa0
do_idle+0x2fe/0x3c0
cpu_startup_entry+0x18/0x20
start_secondary+0x200/0x290
secondary_startup_64_no_verify+0x167/0x16b
</TASK>
Allocated by task 939:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
__kasan_slab_alloc+0x7f/0x90
kmem_cache_alloc_node+0x1cd/0x410
kmalloc_reserve+0x165/0x270
__alloc_skb+0x129/0x330
inet6_ifa_notify+0x118/0x230
__ipv6_ifa_notify+0x177/0xbe0
addrconf_dad_completed+0x133/0xe00
addrconf_dad_work+0x764/0x1390
process_one_work+0xa32/0x16f0
worker_thread+0x67d/0x10c0
kthread+0x344/0x440
ret_from_fork+0x1f/0x30
The buggy address belongs to the object at ffff888111145800
which belongs to the cache skbuff_small_head of size 640
The buggy address is located 239 bytes inside of
freed 640-byte region [ffff888111145800, ffff888111145a80)

As commit f855691975bb ("xfrm6: Fix the nexthdr offset in
_decode_session6.") showed, xfrm_decode_session was originally intended
only for the receive path. IP6CB(skb)->nhoff is not set during
transmission. Therefore, set the cb field in the skb to 0 before
sending packets.

Fixes: f855691975bb ("xfrm6: Fix the nexthdr offset in _decode_session6.")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_interface_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 694eec6ca147e..ded752e33dacd 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -399,8 +399,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		if (!dst) {
 			fl.u.ip6.flowi6_oif = dev->ifindex;
 			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
@@ -414,8 +414,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		if (!dst) {
 			struct rtable *rt;
 
-- 
2.40.1



