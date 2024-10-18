Return-Path: <stable+bounces-86814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054189A3BA7
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482361F224FA
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F520103E;
	Fri, 18 Oct 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvdTOc6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69033201008;
	Fri, 18 Oct 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247671; cv=none; b=FXYJDNzYiMjF/ZyTRLBPWWHPebp+VEfbT6zE/cVAeedri7uE8Z0/1c7ATTHsXU4gK+hlklEaWXlXalT30W2WG46YolkBHN9DqdpPwAh8oe9fWvw2wUQqU7cBSGfSVZ7Nf3LnAEpzGukVrcL8Wk7rOX30xUddngk/sQRKewjtJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247671; c=relaxed/simple;
	bh=Ej1BIrrsDJs4QscaMx4lSwK7ap55ndgJAikupKjb3rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzAN0uNR65gxiyu552LFGUEnbrzk79r2OlHbLppwvVMKWTw2vDjMCQ7kOWKpQ5w/cpUUsSMzh8AiNoobtJ34XsddPUPGJ0mQkV4/1sQr4VZQbvxM8TeScxdAXTrnc7PCkB9EVd2SKZkLG0kW1mo1Z3p+gAFf8Bc6B/fsr2aBGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvdTOc6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536FC4CEC7;
	Fri, 18 Oct 2024 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729247671;
	bh=Ej1BIrrsDJs4QscaMx4lSwK7ap55ndgJAikupKjb3rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvdTOc6bTgCMtzIjDCRtNAIKu63z3ffmpY5FEHle7KyJIgrBA3RZziF39ZswAymic
	 oACoPjGlzEdQSw2J3WLeH1w/elvXJFUv8xWgQPrkypQiXCC9dt4OSFr2vUjSCKDmAm
	 3sDI0IAcUNxqPu/3skuzv4AlvrgXZKOL7EE0Mb/N4HM0wNDMYosDHPlmMV8/2DdFGp
	 8V0hbrrdOfERgS2wuuhO6wxA9AoTTZbEdkEhRqT/LV+OrOygQiZGASnVqa3splp3T7
	 DYPaMlatmnWfjlBMvz2iPMP5HBb8xujxuSP9yPOCahEd3CpDrh2BEGFfehfsd5DWuL
	 7Gsu1EuMbAqZw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
	Cong Wang <cong.wang@bytedance.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.11.y] mptcp: prevent MPC handshake on port-based signal endpoints
Date: Fri, 18 Oct 2024 12:33:57 +0200
Message-ID: <20241018103356.2167155-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024101809-refinish-concave-f892@gregkh>
References: <2024101809-refinish-concave-f892@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12367; i=matttbe@kernel.org; h=from:subject; bh=CJI8yl4gWmGpn5dk9LP7s9k7zJf+60V1UIRnf9iR1Jk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEjmUVN8QCzuWeDsHQOk4sdVJm3HUPLzsbCK04 4zDUH82fk6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxI5lAAKCRD2t4JPQmmg c6KTEADkz1gjTMM1syX5+gADQu65Jn1m8x05FACWIN0ErxRK3Fq5RE6YKnIZfjuoqI7Rw3NO7TD DqTUBdkovodIaCLomMfFVShs3TSXCEvg1ltkhlIGtsLNfNz0eytIUmdaSylKZxtHQvVFBSCjMsh OHfZ6uMQP3FFR+8XaZmI1pSAejzsFFdwliMso226OL95NzYdb3crc/xVCMrVZ9AowiuJFvqziWA MyF8lbw/1QGkg7JVru3mU4nxUrSxBl0g26BsS7f2+SaqwJYHGhcy8790Pj+Lurml2MNeB62oGLU q3StQVahE1qQwhcYaktaTIkmuMwKI3L+SsPSFj/lAg9aeHJswH2agkv9gI0rFNC4WZdbjZGXElh z3atCZLvIU4ly9r1q2EyLx/P2SlORwalvicGhe1IZLhLuwG2AXpX2CMOanrfMXH1XHQ95voHUHn hZjVTPbwCv70qGWrVwxcRNptl3x9uo2uGrrvc8D2L9K7DQLeP6uyUUI40EJyrB3vx5yfHWukaoH KjyzJGVrMx9Czy+Nm78qQ6V1XD4QD6uHd/0eROxHF4NOhEyg+UAZ7V12zflr7jklL6QlxQfEFAL IakIkNjsxYJW4sGTIbAym+9FqP+1tbqDGxRNcIyeRk8GHjbYnsJD6042hWhKb59E6QK3/AIMkWP wnf9zqGBrRtCO1A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 3d041393ea8c815f773020fb4a995331a69c0139 upstream.

Syzkaller reported a lockdep splat:

  ============================================
  WARNING: possible recursive locking detected
  6.11.0-rc6-syzkaller-00019-g67784a74e258 #0 Not tainted
  --------------------------------------------
  syz-executor364/5113 is trying to acquire lock:
  ffff8880449f1958 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  ffff8880449f1958 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

  but task is already holding lock:
  ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(k-slock-AF_INET);
    lock(k-slock-AF_INET);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  7 locks held by syz-executor364/5113:
   #0: ffff8880449f0e18 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
   #0: ffff8880449f0e18 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x153/0x1b10 net/mptcp/protocol.c:1806
   #1: ffff88803fe39ad8 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
   #1: ffff88803fe39ad8 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg_fastopen+0x11f/0x530 net/mptcp/protocol.c:1727
   #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
   #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
   #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x5f/0x1b80 net/ipv4/ip_output.c:470
   #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
   #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
   #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1390 net/ipv4/ip_output.c:228
   #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
   #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x33b/0x15b0 net/core/dev.c:6104
   #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
   #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
   #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x230/0x5f0 net/ipv4/ip_input.c:232
   #6: ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
   #6: ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

  stack backtrace:
  CPU: 0 UID: 0 PID: 5113 Comm: syz-executor364 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:93 [inline]
   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
   check_deadlock kernel/locking/lockdep.c:3061 [inline]
   validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
   __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328
   mptcp_sk_clone_init+0x32/0x13c0 net/mptcp/protocol.c:3279
   subflow_syn_recv_sock+0x931/0x1920 net/mptcp/subflow.c:874
   tcp_check_req+0xfe4/0x1a20 net/ipv4/tcp_minisocks.c:853
   tcp_v4_rcv+0x1c3e/0x37f0 net/ipv4/tcp_ipv4.c:2267
   ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
   __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
   __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
   process_backlog+0x662/0x15b0 net/core/dev.c:6108
   __napi_poll+0xcb/0x490 net/core/dev.c:6772
   napi_poll net/core/dev.c:6841 [inline]
   net_rx_action+0x89b/0x1240 net/core/dev.c:6963
   handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
   do_softirq+0x11b/0x1e0 kernel/softirq.c:455
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
   local_bh_enable include/linux/bottom_half.h:33 [inline]
   rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
   __dev_queue_xmit+0x1763/0x3e90 net/core/dev.c:4450
   dev_queue_xmit include/linux/netdevice.h:3105 [inline]
   neigh_hh_output include/net/neighbour.h:526 [inline]
   neigh_output include/net/neighbour.h:540 [inline]
   ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
   ip_local_out net/ipv4/ip_output.c:129 [inline]
   __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
   __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
   tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6542 [inline]
   tcp_rcv_state_process+0x2c32/0x4570 net/ipv4/tcp_input.c:6729
   tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1934
   sk_backlog_rcv include/net/sock.h:1111 [inline]
   __release_sock+0x214/0x350 net/core/sock.c:3004
   release_sock+0x61/0x1f0 net/core/sock.c:3558
   mptcp_sendmsg_fastopen+0x1ad/0x530 net/mptcp/protocol.c:1733
   mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1812
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x1a6/0x270 net/socket.c:745
   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
   ___sys_sendmsg net/socket.c:2651 [inline]
   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2737
   __do_sys_sendmmsg net/socket.c:2766 [inline]
   __se_sys_sendmmsg net/socket.c:2763 [inline]
   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2763
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f04fb13a6b9
  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffd651f42d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04fb13a6b9
  RDX: 0000000000000001 RSI: 0000000020000d00 RDI: 0000000000000004
  RBP: 00007ffd651f4310 R08: 0000000000000001 R09: 0000000000000001
  R10: 0000000020000080 R11: 0000000000000246 R12: 00000000000f4240
  R13: 00007f04fb187449 R14: 00007ffd651f42f4 R15: 00007ffd651f4300
   </TASK>

As noted by Cong Wang, the splat is false positive, but the code
path leading to the report is an unexpected one: a client is
attempting an MPC handshake towards the in-kernel listener created
by the in-kernel PM for a port based signal endpoint.

Such connection will be never accepted; many of them can make the
listener queue full and preventing the creation of MPJ subflow via
such listener - its intended role.

Explicitly detect this scenario at initial-syn time and drop the
incoming MPC request.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
Cc: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241014-net-mptcp-mpc-port-endp-v2-1-7faea8e6b6ae@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mib.[ch], because commit 6982826fe5e5 ("mptcp: fallback
  to TCP after SYN+MPC drops"), and commit 27069e7cb3d1 ("mptcp: disable
  active MPTCP in case of blackhole") are linked to new features, not
  available in this version. Resolving the conflicts is easy, simply
  adding the new lines declaring the new "endpoint attempt" MIB entry. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c        |  1 +
 net/mptcp/mib.h        |  1 +
 net/mptcp/pm_netlink.c |  1 +
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 11 +++++++++++
 5 files changed, 15 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 79f2278434b9..3dc49c3169f2 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -15,6 +15,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableEndpAttempt", MPTCP_MIB_MPCAPABLEENDPATTEMPT),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 3f4ca290be69..ac574a790465 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -10,6 +10,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
+	MPTCP_MIB_MPCAPABLEENDPATTEMPT,	/* Prohibited MPC to port-based endp */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6c586b2b377b..62f395cb0959 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1117,6 +1117,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
+	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
 	err = __inet_listen_sk(ssk, backlog);
 	if (!err)
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3b22313d1b86..049af90589ae 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -528,6 +528,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7d14da95a283..d4d1fddea44f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -132,6 +132,13 @@ static void subflow_add_reset_reason(struct sk_buff *skb, u8 reason)
 	}
 }
 
+static int subflow_reset_req_endp(struct request_sock *req, struct sk_buff *skb)
+{
+	SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEENDPATTEMPT);
+	subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+	return -EPERM;
+}
+
 /* Init mptcp request socket.
  *
  * Returns an error code if a JOIN has failed and a TCP reset
@@ -165,6 +172,8 @@ static int subflow_check_req(struct request_sock *req,
 	if (opt_mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 
+		if (unlikely(listener->pm_listener))
+			return subflow_reset_req_endp(req, skb);
 		if (opt_mp_join)
 			return 0;
 	} else if (opt_mp_join) {
@@ -172,6 +181,8 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (mp_opt.backup)
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
+	} else if (unlikely(listener->pm_listener)) {
+		return subflow_reset_req_endp(req, skb);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
-- 
2.45.2


