Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9087832C1
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjHUUFc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjHUUFc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A000E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1718617E2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1134BC433C7;
        Mon, 21 Aug 2023 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648329;
        bh=wLVD/HOSWQgw3q2YFCLXbHQNj7pUc9Wn0reyOXHLfqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbIiF6mzM5OMMP5Qzf9mDcbIAEHwlpG7sPgpbo8M0s6kIQNP0hjlU13hOGg9zXvjl
         ggknNwALNJ2atiXp992F6O9EohFEmPEkJ44L1w7Sm0N8daKDUhR6DamoNve7mvtqpL
         7mTb1MuEgChS/aCM6bLXGbPnzzpI8hT7KJGk/HXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 137/234] ip6_vti: fix slab-use-after-free in decode_session6
Date:   Mon, 21 Aug 2023 21:41:40 +0200
Message-ID: <20230821194134.888738439@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

[ Upstream commit 9fd41f1ba638938c9a1195d09bc6fa3be2712f25 ]

When ipv6_vti device is set to the qdisc of the sfb type, the cb field
of the sent skb may be modified during enqueuing. Then,
slab-use-after-free may occur when ipv6_vti device sends IPv6 packets.

The stack information is as follows:
BUG: KASAN: slab-use-after-free in decode_session6+0x103f/0x1890
Read of size 1 at addr ffff88802e08edc2 by task swapper/0/0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-next-20230707-00001-g84e2cad7f979 #410
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
Call Trace:
<IRQ>
dump_stack_lvl+0xd9/0x150
print_address_description.constprop.0+0x2c/0x3c0
kasan_report+0x11d/0x130
decode_session6+0x103f/0x1890
__xfrm_decode_session+0x54/0xb0
vti6_tnl_xmit+0x3e6/0x1ee0
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
Allocated by task 9176:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
__kasan_slab_alloc+0x7f/0x90
kmem_cache_alloc_node+0x1cd/0x410
kmalloc_reserve+0x165/0x270
__alloc_skb+0x129/0x330
netlink_sendmsg+0x9b1/0xe30
sock_sendmsg+0xde/0x190
____sys_sendmsg+0x739/0x920
___sys_sendmsg+0x110/0x1b0
__sys_sendmsg+0xf7/0x1c0
do_syscall_64+0x39/0xb0
entry_SYSCALL_64_after_hwframe+0x63/0xcd
Freed by task 9176:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
kasan_save_free_info+0x2b/0x40
____kasan_slab_free+0x160/0x1c0
slab_free_freelist_hook+0x11b/0x220
kmem_cache_free+0xf0/0x490
skb_free_head+0x17f/0x1b0
skb_release_data+0x59c/0x850
consume_skb+0xd2/0x170
netlink_unicast+0x54f/0x7f0
netlink_sendmsg+0x926/0xe30
sock_sendmsg+0xde/0x190
____sys_sendmsg+0x739/0x920
___sys_sendmsg+0x110/0x1b0
__sys_sendmsg+0xf7/0x1c0
do_syscall_64+0x39/0xb0
entry_SYSCALL_64_after_hwframe+0x63/0xcd
The buggy address belongs to the object at ffff88802e08ed00
which belongs to the cache skbuff_small_head of size 640
The buggy address is located 194 bytes inside of
freed 640-byte region [ffff88802e08ed00, ffff88802e08ef80)

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
 net/ipv6/ip6_vti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 10b222865d46a..73c85d4e0e9cd 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -568,12 +568,12 @@ vti6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		    vti6_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	default:
 		goto tx_err;
-- 
2.40.1



