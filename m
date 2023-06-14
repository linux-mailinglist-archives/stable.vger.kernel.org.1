Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36702713E86
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjE1TgV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjE1TgU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ABAB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2294F61E27
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43253C433EF;
        Sun, 28 May 2023 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302577;
        bh=TemH313PQSx4ZxTxGv53JDB7lqWYwRpk/QFvpNpGzN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlUjHnZ5RgTlPuBEK0Hn0JsCN5HqWvtLkWs1shOyQDo/s4XKczL3o4rz6ILL4Ri+T
         OjGyXdbkspI3qrOa/oXCpivVqWn1kDGQwqG2wMynLl+XTBHP2Ztyz5Acc/sHZPbaQA
         ffUuKkzprs9H/0rUB9dZU1vn+wCP1l/c1YsU43aA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+444ca0907e96f7c5e48b@syzkaller.appspotmail.com,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 059/119] udplite: Fix NULL pointer dereference in __sk_mem_raise_allocated().
Date:   Sun, 28 May 2023 20:10:59 +0100
Message-Id: <20230528190837.412169615@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit ad42a35bdfc6d3c0fc4cb4027d7b2757ce665665 upstream.

syzbot reported [0] a null-ptr-deref in sk_get_rmem0() while using
IPPROTO_UDPLITE (0x88):

  14:25:52 executing program 1:
  r0 = socket$inet6(0xa, 0x80002, 0x88)

We had a similar report [1] for probably sk_memory_allocated_add()
in __sk_mem_raise_allocated(), and commit c915fe13cbaa ("udplite: fix
NULL pointer dereference") fixed it by setting .memory_allocated for
udplite_prot and udplitev6_prot.

To fix the variant, we need to set either .sysctl_wmem_offset or
.sysctl_rmem.

Now UDP and UDPLITE share the same value for .memory_allocated, so we
use the same .sysctl_wmem_offset for UDP and UDPLITE.

[0]:
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 6829 Comm: syz-executor.1 Not tainted 6.4.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:sk_get_rmem0 include/net/sock.h:2907 [inline]
RIP: 0010:__sk_mem_raise_allocated+0x806/0x17a0 net/core/sock.c:3006
Code: c1 ea 03 80 3c 02 00 0f 85 23 0f 00 00 48 8b 44 24 08 48 8b 98 38 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <0f> b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 0f 8d 6f 0a 00 00 8b
RSP: 0018:ffffc90005d7f450 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90004d92000
RDX: 0000000000000000 RSI: ffffffff88066482 RDI: ffffffff8e2ccbb8
RBP: ffff8880173f7000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000030000
R13: 0000000000000001 R14: 0000000000000340 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0063) knlGS:00000000f7f1cb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002e82f000 CR3: 0000000034ff0000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 __sk_mem_schedule+0x6c/0xe0 net/core/sock.c:3077
 udp_rmem_schedule net/ipv4/udp.c:1539 [inline]
 __udp_enqueue_schedule_skb+0x776/0xb30 net/ipv4/udp.c:1581
 __udpv6_queue_rcv_skb net/ipv6/udp.c:666 [inline]
 udpv6_queue_rcv_one_skb+0xc39/0x16c0 net/ipv6/udp.c:775
 udpv6_queue_rcv_skb+0x194/0xa10 net/ipv6/udp.c:793
 __udp6_lib_mcast_deliver net/ipv6/udp.c:906 [inline]
 __udp6_lib_rcv+0x1bda/0x2bd0 net/ipv6/udp.c:1013
 ip6_protocol_deliver_rcu+0x2e7/0x1250 net/ipv6/ip6_input.c:437
 ip6_input_finish+0x150/0x2f0 net/ipv6/ip6_input.c:482
 NF_HOOK include/linux/netfilter.h:303 [inline]
 NF_HOOK include/linux/netfilter.h:297 [inline]
 ip6_input+0xa0/0xd0 net/ipv6/ip6_input.c:491
 ip6_mc_input+0x40b/0xf50 net/ipv6/ip6_input.c:585
 dst_input include/net/dst.h:468 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
 NF_HOOK include/linux/netfilter.h:303 [inline]
 NF_HOOK include/linux/netfilter.h:297 [inline]
 ipv6_rcv+0x250/0x380 net/ipv6/ip6_input.c:309
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5491
 __netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5605
 netif_receive_skb_internal net/core/dev.c:5691 [inline]
 netif_receive_skb+0x133/0x7a0 net/core/dev.c:5750
 tun_rx_batched+0x4b3/0x7a0 drivers/net/tun.c:1553
 tun_get_user+0x2452/0x39c0 drivers/net/tun.c:1989
 tun_chr_write_iter+0xdf/0x200 drivers/net/tun.c:2035
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f21579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f1c590 EFLAGS: 00000282 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 0000000020000040
RDX: 0000000000000083 RSI: 00000000f734e000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:

Link: https://lore.kernel.org/netdev/CANaxB-yCk8hhP68L4Q2nFOJht8sqgXGGQO2AftpHs0u1xyGG5A@mail.gmail.com/ [1]
Fixes: 850cbaddb52d ("udp: use it's own memory accounting schema")
Reported-by: syzbot+444ca0907e96f7c5e48b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=444ca0907e96f7c5e48b
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230523163305.66466-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udplite.c |    2 ++
 net/ipv6/udplite.c |    2 ++
 2 files changed, 4 insertions(+)

--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -64,6 +64,8 @@ struct proto 	udplite_prot = {
 	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp_sock),
 	.h.udp_table	   = &udplite_table,
 };
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -60,6 +60,8 @@ struct proto udplitev6_prot = {
 	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem	   = sysctl_udp_mem,
+	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp6_sock),
 	.h.udp_table	   = &udplite_table,
 };


