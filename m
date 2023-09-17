Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C067A3AF4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjIQULN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbjIQUKp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:10:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ACFB5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:10:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC5BC433C9;
        Sun, 17 Sep 2023 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981439;
        bh=4giGb3eGkgqwrvCJLG0BP/IpFLtq0rRjgqC7q0gINio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3MPhTBAJFgdp6T2SfnvbybHFyvNg+fdyjh4dnuI9hTJWCnyXhBUKhCvaf+p2P6z9
         QEYJpKFPl4UPDdQjkhMfIenmoi4oltcFuhRVfXRzrdjvE9XJzb/UC7+Bq9rENHNHcx
         uj1s1RWRy0/q1OrOeJKC5kUVoHI+vz9zVeUeysXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/219] net: read sk->sk_family once in sk_mc_loop()
Date:   Sun, 17 Sep 2023 21:13:37 +0200
Message-ID: <20230917191044.223813685@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

[ Upstream commit a3e0fdf71bbe031de845e8e08ed7fba49f9c702c ]

syzbot is playing with IPV6_ADDRFORM quite a lot these days,
and managed to hit the WARN_ON_ONCE(1) in sk_mc_loop()

We have many more similar issues to fix.

WARNING: CPU: 1 PID: 1593 at net/core/sock.c:782 sk_mc_loop+0x165/0x260
Modules linked in:
CPU: 1 PID: 1593 Comm: kworker/1:3 Not tainted 6.1.40-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_power_efficient gc_worker
RIP: 0010:sk_mc_loop+0x165/0x260 net/core/sock.c:782
Code: 34 1b fd 49 81 c7 18 05 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ff e8 25 36 6d fd 4d 8b 37 eb 13 e8 db 33 1b fd <0f> 0b b3 01 eb 34 e8 d0 33 1b fd 45 31 f6 49 83 c6 38 4c 89 f0 48
RSP: 0018:ffffc90000388530 EFLAGS: 00010246
RAX: ffffffff846d9b55 RBX: 0000000000000011 RCX: ffff88814f884980
RDX: 0000000000000102 RSI: ffffffff87ae5160 RDI: 0000000000000011
RBP: ffffc90000388550 R08: 0000000000000003 R09: ffffffff846d9a65
R10: 0000000000000002 R11: ffff88814f884980 R12: dffffc0000000000
R13: ffff88810dbee000 R14: 0000000000000010 R15: ffff888150084000
FS: 0000000000000000(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 000000014ee5b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<IRQ>
[<ffffffff8507734f>] ip6_finish_output2+0x33f/0x1ae0 net/ipv6/ip6_output.c:83
[<ffffffff85062766>] __ip6_finish_output net/ipv6/ip6_output.c:200 [inline]
[<ffffffff85062766>] ip6_finish_output+0x6c6/0xb10 net/ipv6/ip6_output.c:211
[<ffffffff85061f8c>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
[<ffffffff85061f8c>] ip6_output+0x2bc/0x3d0 net/ipv6/ip6_output.c:232
[<ffffffff852071cf>] dst_output include/net/dst.h:444 [inline]
[<ffffffff852071cf>] ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
[<ffffffff83618fb4>] ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:483 [inline]
[<ffffffff83618fb4>] ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:529 [inline]
[<ffffffff83618fb4>] ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
[<ffffffff83618fb4>] ipvlan_queue_xmit+0x1174/0x1be0 drivers/net/ipvlan/ipvlan_core.c:677
[<ffffffff8361ddd9>] ipvlan_start_xmit+0x49/0x100 drivers/net/ipvlan/ipvlan_main.c:229
[<ffffffff84763fc0>] netdev_start_xmit include/linux/netdevice.h:4925 [inline]
[<ffffffff84763fc0>] xmit_one net/core/dev.c:3644 [inline]
[<ffffffff84763fc0>] dev_hard_start_xmit+0x320/0x980 net/core/dev.c:3660
[<ffffffff8494c650>] sch_direct_xmit+0x2a0/0x9c0 net/sched/sch_generic.c:342
[<ffffffff8494d883>] qdisc_restart net/sched/sch_generic.c:407 [inline]
[<ffffffff8494d883>] __qdisc_run+0xb13/0x1e70 net/sched/sch_generic.c:415
[<ffffffff8478c426>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
[<ffffffff84796eac>] net_tx_action+0x7ac/0x940 net/core/dev.c:5247
[<ffffffff858002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:599
[<ffffffff814c3fe8>] invoke_softirq kernel/softirq.c:430 [inline]
[<ffffffff814c3fe8>] __irq_exit_rcu+0xc8/0x170 kernel/softirq.c:683
[<ffffffff814c3f09>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:695

Fixes: 7ad6848c7e81 ("ip: fix mc_loop checks for tunnels with multicast outer addresses")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230830101244.1146934-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index fc475845c94d5..fa988063630db 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -761,7 +761,8 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	switch (sk->sk_family) {
+	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.40.1



