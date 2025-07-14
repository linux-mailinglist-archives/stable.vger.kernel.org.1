Return-Path: <stable+bounces-161874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D10B045BD
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684087B003B
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F622641EA;
	Mon, 14 Jul 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKTEww1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF3264A61;
	Mon, 14 Jul 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511323; cv=none; b=GN/i9NIuPiQWAKSbwX3OefLQXp39e6cHU+OG2N/XXjNkAoeIWGULj20cCIn9rwc8Tf2m8aVyTdd6534V4IxE9w2mZ+dOCKqXB2UUlQTew2K3Yd4WNsQ2kN7Jr5G4AqppHEJAjimR33xolJyMqHS7fJ+ezNzMbIw7KNuf4V3dmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511323; c=relaxed/simple;
	bh=2C6nvDLCBC+pg05jlEocFKKcGvO6Biio/MRqJFiD4Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvjZoAZh/nb79jphJma+1+6SAD5CmKIQqSd6wOUeDTfJTpa2otQXprKeXviLjwASPANrOi6o9fdpdP+bEJUpPZTipkahGLYvNi7O7Lo8HmcZDQv4/FFycW3H1pqkCCdYqxiWi2un7lUpiYRNOKGnHu4t+IyOxGhmcNsInW1tYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKTEww1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6C4C4CEF5;
	Mon, 14 Jul 2025 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752511323;
	bh=2C6nvDLCBC+pg05jlEocFKKcGvO6Biio/MRqJFiD4Tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hKTEww1YF2YvWWoWxfbnC1r0j0Wu9mTO0hBlYxWEYjj83Hm1L9FrU6zxGM8Uk4WnO
	 6EiW8rGAWkV7/s8DgUOr0WW3LIXb4pr5LMovkE6G2YzBBz1BUHoM7eWFdU0Y9DO4/d
	 1hmFarZBcrv2tyjZDWKKDrhobXGlzR4pBDppkQ+8OY/VUfgIUcGt37F99C2dbsBJx6
	 62+8MFJen09cU8gDKHP6KqwQSdT32CPXWFQlgQeMftGCZ/8kdyLJDffANpQ3zhB6e9
	 AN4GqxSkv9FXSQ76Z0zvrQ2oFHxATaeG9yfGYm6tLGJznpACcyalbRaNqdOSvkN4eY
	 jXi+ylqBGqL4w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Jul 2025 18:41:44 +0200
Subject: [PATCH net 1/3] mptcp: make fallback action and fallback decision
 atomic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-net-mptcp-fallback-races-v1-1-391aff963322@kernel.org>
References: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
In-Reply-To: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15777; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=a8DHtspzAJBofI3McAEob0tr2bvatRQEHugsArv3dww=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJKjYN2bmp0Mp5d5ji9o+Ph0kWTd++Slcqx0n31dmV7U
 fqspg0xHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP51cbwT2/FN9X/ceo35u8V
 47L2vnDGxSxq8nuRtdPd41Wu7tp23peRYeOV/OdL1+3J4wwL0jc2TF87i+HzT815tW8m93/gyb+
 7iA0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Syzkaller reported the following splat:

  WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 __mptcp_do_fallback net/mptcp/protocol.h:1223 [inline]
  WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 mptcp_do_fallback net/mptcp/protocol.h:1244 [inline]
  WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 check_fully_established net/mptcp/options.c:982 [inline]
  WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 mptcp_incoming_options+0x21a8/0x2510 net/mptcp/options.c:1153
  Modules linked in:
  CPU: 1 UID: 0 PID: 7704 Comm: syz.3.1419 Not tainted 6.16.0-rc3-gbd5ce2324dba #20 PREEMPT(voluntary)
  Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:__mptcp_do_fallback net/mptcp/protocol.h:1223 [inline]
  RIP: 0010:mptcp_do_fallback net/mptcp/protocol.h:1244 [inline]
  RIP: 0010:check_fully_established net/mptcp/options.c:982 [inline]
  RIP: 0010:mptcp_incoming_options+0x21a8/0x2510 net/mptcp/options.c:1153
  Code: 24 18 e8 bb 2a 00 fd e9 1b df ff ff e8 b1 21 0f 00 e8 ec 5f c4 fc 44 0f b7 ac 24 b0 00 00 00 e9 54 f1 ff ff e8 d9 5f c4 fc 90 <0f> 0b 90 e9 b8 f4 ff ff e8 8b 2a 00 fd e9 8d e6 ff ff e8 81 2a 00
  RSP: 0018:ffff8880a3f08448 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff8880180a8000 RCX: ffffffff84afcf45
  RDX: ffff888090223700 RSI: ffffffff84afdaa7 RDI: 0000000000000001
  RBP: ffff888017955780 R08: 0000000000000001 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: ffff8880180a8910 R14: ffff8880a3e9d058 R15: 0000000000000000
  FS:  00005555791b8500(0000) GS:ffff88811c495000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000110c2800b7 CR3: 0000000058e44000 CR4: 0000000000350ef0
  Call Trace:
   <IRQ>
   tcp_reset+0x26f/0x2b0 net/ipv4/tcp_input.c:4432
   tcp_validate_incoming+0x1057/0x1b60 net/ipv4/tcp_input.c:5975
   tcp_rcv_established+0x5b5/0x21f0 net/ipv4/tcp_input.c:6166
   tcp_v4_do_rcv+0x5dc/0xa70 net/ipv4/tcp_ipv4.c:1925
   tcp_v4_rcv+0x3473/0x44a0 net/ipv4/tcp_ipv4.c:2363
   ip_protocol_deliver_rcu+0xba/0x480 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x2f1/0x500 net/ipv4/ip_input.c:233
   NF_HOOK include/linux/netfilter.h:317 [inline]
   NF_HOOK include/linux/netfilter.h:311 [inline]
   ip_local_deliver+0x1be/0x560 net/ipv4/ip_input.c:254
   dst_input include/net/dst.h:469 [inline]
   ip_rcv_finish net/ipv4/ip_input.c:447 [inline]
   NF_HOOK include/linux/netfilter.h:317 [inline]
   NF_HOOK include/linux/netfilter.h:311 [inline]
   ip_rcv+0x514/0x810 net/ipv4/ip_input.c:567
   __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:5975
   __netif_receive_skb+0x1f/0x120 net/core/dev.c:6088
   process_backlog+0x301/0x1360 net/core/dev.c:6440
   __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7453
   napi_poll net/core/dev.c:7517 [inline]
   net_rx_action+0xb44/0x1010 net/core/dev.c:7644
   handle_softirqs+0x1d0/0x770 kernel/softirq.c:579
   do_softirq+0x3f/0x90 kernel/softirq.c:480
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0xed/0x110 kernel/softirq.c:407
   local_bh_enable include/linux/bottom_half.h:33 [inline]
   inet_csk_listen_stop+0x2c5/0x1070 net/ipv4/inet_connection_sock.c:1524
   mptcp_check_listen_stop.part.0+0x1cc/0x220 net/mptcp/protocol.c:2985
   mptcp_check_listen_stop net/mptcp/mib.h:118 [inline]
   __mptcp_close+0x9b9/0xbd0 net/mptcp/protocol.c:3000
   mptcp_close+0x2f/0x140 net/mptcp/protocol.c:3066
   inet_release+0xed/0x200 net/ipv4/af_inet.c:435
   inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:487
   __sock_release+0xb3/0x270 net/socket.c:649
   sock_close+0x1c/0x30 net/socket.c:1439
   __fput+0x402/0xb70 fs/file_table.c:465
   task_work_run+0x150/0x240 kernel/task_work.c:227
   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
   exit_to_user_mode_loop+0xd4/0xe0 kernel/entry/common.c:114
   exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
   syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
   syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
   do_syscall_64+0x245/0x360 arch/x86/entry/syscall_64.c:100
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fc92f8a36ad
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffcf52802d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
  RAX: 0000000000000000 RBX: 00007ffcf52803a8 RCX: 00007fc92f8a36ad
  RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
  RBP: 00007fc92fae7ba0 R08: 0000000000000001 R09: 0000002800000000
  R10: 00007fc92f700000 R11: 0000000000000246 R12: 00007fc92fae5fac
  R13: 00007fc92fae5fa0 R14: 0000000000026d00 R15: 0000000000026c51
   </TASK>
  irq event stamp: 4068
  hardirqs last  enabled at (4076): [<ffffffff81544816>] __up_console_sem+0x76/0x80 kernel/printk/printk.c:344
  hardirqs last disabled at (4085): [<ffffffff815447fb>] __up_console_sem+0x5b/0x80 kernel/printk/printk.c:342
  softirqs last  enabled at (3096): [<ffffffff840e1be0>] local_bh_enable include/linux/bottom_half.h:33 [inline]
  softirqs last  enabled at (3096): [<ffffffff840e1be0>] inet_csk_listen_stop+0x2c0/0x1070 net/ipv4/inet_connection_sock.c:1524
  softirqs last disabled at (3097): [<ffffffff813b6b9f>] do_softirq+0x3f/0x90 kernel/softirq.c:480

Since we need to track the 'fallback is possible' condition and the
fallback status separately, there are a few possible races open between
the check and the actual fallback action.

Add a spinlock to protect the fallback related information and use it
close all the possible related races. While at it also remove the
too-early clearing of allow_infinite_fallback in __mptcp_subflow_connect():
the field will be correctly cleared by subflow_finish_connect() if/when
the connection will complete successfully.

If fallback is not possible, as per RFC, reset the current subflow.

Since the fallback operation can now fail and return value should be
checked, rename the helper accordingly.

Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
Cc: stable@vger.kernel.org
Reported-by: Matthieu Baerts <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/570
Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/555
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  3 ++-
 net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h | 26 +++++++++++++++++++-------
 net/mptcp/subflow.c  | 11 +++++------
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 421ced0312890b98dde560932b5f9437a15c4030..1f898888b22357be395a2fd3e585df2375c8b2d2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -978,8 +978,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
+		if (!mptcp_try_fallback(ssk))
+			goto reset;
 		pr_fallback(msk);
-		mptcp_do_fallback(ssk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index edf14c2c20622e38b697f3a291838282ef5a8ddb..b08a42fcbb650b8851f9b44090e61503f3dcad67 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -560,10 +560,9 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (READ_ONCE(msk->allow_infinite_fallback)) {
+	if (mptcp_try_fallback(ssk)) {
 		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-		mptcp_do_fallback(ssk);
 	} else {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
@@ -803,6 +802,14 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
+	spin_lock_bh(&msk->fallback_lock);
+	if (__mptcp_check_fallback(msk)) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	mptcp_subflow_joined(msk, ssk);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* attach to msk socket only after we are sure we will deal with it
 	 * at close time
 	 */
@@ -811,7 +818,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
-	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
 	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
@@ -1136,10 +1142,14 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
+	if (!mptcp_try_fallback(ssk)) {
+		mptcp_subflow_reset(ssk);
+		return;
+	}
+
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
-	mptcp_do_fallback(ssk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
@@ -2543,9 +2553,9 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 static void __mptcp_retrans(struct sock *sk)
 {
+	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
 	int ret, err;
@@ -2590,6 +2600,18 @@ static void __mptcp_retrans(struct sock *sk)
 			info.sent = 0;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
+
+			/*
+			 * make the whole retrans decision, xmit, disallow
+			 * fallback atomic
+			 */
+			spin_lock_bh(&msk->fallback_lock);
+			if (__mptcp_check_fallback(msk)) {
+				spin_unlock_bh(&msk->fallback_lock);
+				release_sock(ssk);
+				return;
+			}
+
 			while (info.sent < info.limit) {
 				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 				if (ret <= 0)
@@ -2605,6 +2627,7 @@ static void __mptcp_retrans(struct sock *sk)
 					 info.size_goal);
 				WRITE_ONCE(msk->allow_infinite_fallback, false);
 			}
+			spin_unlock_bh(&msk->fallback_lock);
 
 			release_sock(ssk);
 		}
@@ -2738,6 +2761,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_ack_recv = tcp_jiffies32;
 
 	mptcp_pm_data_init(msk);
+	spin_lock_init(&msk->fallback_lock);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -3524,7 +3548,13 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
+		spin_lock_bh(&msk->fallback_lock);
+		if (__mptcp_check_fallback(msk)) {
+			spin_unlock_bh(&msk->fallback_lock);
+			return false;
+		}
 		mptcp_subflow_joined(msk, ssk);
+		spin_unlock_bh(&msk->fallback_lock);
 		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3dd11dd3ba16e8c1d3741b6eb5b526bb4beae15b..2a60c3c71651b917c8b9b33d16f8e831c76cfc82 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -350,6 +350,10 @@ struct mptcp_sock {
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+
+	spinlock_t	fallback_lock;	/* protects fallback and
+					 * allow_infinite_fallback
+					 */
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -1216,15 +1220,21 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
+static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 {
 	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
-		return;
+		return true;
 	}
-	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
-		return;
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	spin_unlock_bh(&msk->fallback_lock);
+	return true;
 }
 
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
@@ -1236,14 +1246,15 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 			TCPF_SYN_RECV | TCPF_LISTEN));
 }
 
-static inline void mptcp_do_fallback(struct sock *ssk)
+static inline bool mptcp_try_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	__mptcp_do_fallback(msk);
+	if (!__mptcp_try_fallback(msk))
+		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
 
@@ -1255,6 +1266,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 		tcp_shutdown(ssk, SEND_SHUTDOWN);
 		ssk->sk_allocation = saved_allocation;
 	}
+	return true;
 }
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
@@ -1264,7 +1276,7 @@ static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
 {
 	pr_fallback(msk);
 	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
+	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
 }
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15613d691bfef6800268ae75b62508736865f44a..a6a35985e551e0967f998c3ae928b76376fa97fd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -544,9 +544,11 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
+			if (!mptcp_try_fallback(sk))
+				goto do_reset;
+
 			MPTCP_INC_STATS(sock_net(sk),
 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-			mptcp_do_fallback(sk);
 			pr_fallback(msk);
 			goto fallback;
 		}
@@ -1395,7 +1397,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!READ_ONCE(msk->allow_infinite_fallback)) {
+		if (!mptcp_try_fallback(ssk)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1413,8 +1415,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-
-		mptcp_do_fallback(ssk);
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
@@ -1679,7 +1679,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	mptcp_stop_tout_timer(sk);
 	return 0;
 
@@ -1851,7 +1850,7 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_do_fallback(sk);
+		WARN_ON_ONCE(!mptcp_try_fallback(sk));
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);

-- 
2.48.1


