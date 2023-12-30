Return-Path: <stable+bounces-8729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD8820474
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E31C20C3C
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A51FCF;
	Sat, 30 Dec 2023 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p8U4dVjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B12561
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044B0C433C7;
	Sat, 30 Dec 2023 11:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703934002;
	bh=9oxmMS9GnTKLSAy7I2LcSUZbTZMKeGy9dFKHvHjJs58=;
	h=Subject:To:Cc:From:Date:From;
	b=p8U4dVjWrCvNeugjtjj+PfPDyH/1fuMTq/YgL3jsj41R2dIVX4vdLsXvlvBzpVFYP
	 ZrbdGO0veTiqgG27ormEGg9phap9iGr62yPyuZxY0XTCwA88TqlTpkHhzT8PI7zyqJ
	 6GYb+Pkn1aGiBHlD+9l3ievFrcgTFa2ldT3Pw57s=
Subject: FAILED: patch "[PATCH] mptcp: fix inconsistent state on fastopen race" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org,syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:59:59 +0000
Message-ID: <2023123059-ardently-giver-2441@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4fd19a30701659af5839b7bd19d1f05f05933ebe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123059-ardently-giver-2441@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
d109a7767273 ("mptcp: fix possible NULL pointer dereference on close")
8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fd19a30701659af5839b7bd19d1f05f05933ebe Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 15 Dec 2023 17:04:25 +0100
Subject: [PATCH] mptcp: fix inconsistent state on fastopen race

The netlink PM can race with fastopen self-connect attempts, shutting
down the first subflow via:

MPTCP_PM_CMD_DEL_ADDR -> mptcp_nl_remove_id_zero_address ->
  mptcp_pm_nl_rm_subflow_received -> mptcp_close_ssk

and transitioning such subflow to FIN_WAIT1 status before the syn-ack
packet is processed. The MPTCP code does not react to such state change,
leaving the connection in not-fallback status and the subflow handshake
uncompleted, triggering the following splat:

  WARNING: CPU: 0 PID: 10630 at net/mptcp/subflow.c:1405 subflow_data_ready+0x39f/0x690 net/mptcp/subflow.c:1405
  Modules linked in:
  CPU: 0 PID: 10630 Comm: kworker/u4:11 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
  Workqueue: bat_events batadv_nc_worker
  RIP: 0010:subflow_data_ready+0x39f/0x690 net/mptcp/subflow.c:1405
  Code: 18 89 ee e8 e3 d2 21 f7 40 84 ed 75 1f e8 a9 d7 21 f7 44 89 fe bf 07 00 00 00 e8 0c d3 21 f7 41 83 ff 07 74 07 e8 91 d7 21 f7 <0f> 0b e8 8a d7 21 f7 48 89 df e8 d2 b2 ff ff 31 ff 89 c5 89 c6 e8
  RSP: 0018:ffffc90000007448 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff888031efc700 RCX: ffffffff8a65baf4
  RDX: ffff888043222140 RSI: ffffffff8a65baff RDI: 0000000000000005
  RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
  R10: 000000000000000b R11: 0000000000000000 R12: 1ffff92000000e89
  R13: ffff88807a534d80 R14: ffff888021c11a00 R15: 000000000000000b
  FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fa19a0ffc81 CR3: 000000007a2db000 CR4: 00000000003506f0
  DR0: 000000000000d8dd DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
  Call Trace:
   <IRQ>
   tcp_data_ready+0x14c/0x5b0 net/ipv4/tcp_input.c:5128
   tcp_data_queue+0x19c3/0x5190 net/ipv4/tcp_input.c:5208
   tcp_rcv_state_process+0x11ef/0x4e10 net/ipv4/tcp_input.c:6844
   tcp_v4_do_rcv+0x369/0xa10 net/ipv4/tcp_ipv4.c:1929
   tcp_v4_rcv+0x3888/0x3b30 net/ipv4/tcp_ipv4.c:2329
   ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x2e4/0x510 net/ipv4/ip_input.c:233
   NF_HOOK include/linux/netfilter.h:314 [inline]
   NF_HOOK include/linux/netfilter.h:308 [inline]
   ip_local_deliver+0x1b6/0x550 net/ipv4/ip_input.c:254
   dst_input include/net/dst.h:461 [inline]
   ip_rcv_finish+0x1c4/0x2e0 net/ipv4/ip_input.c:449
   NF_HOOK include/linux/netfilter.h:314 [inline]
   NF_HOOK include/linux/netfilter.h:308 [inline]
   ip_rcv+0xce/0x440 net/ipv4/ip_input.c:569
   __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5527
   __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5641
   process_backlog+0x101/0x6b0 net/core/dev.c:5969
   __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6531
   napi_poll net/core/dev.c:6600 [inline]
   net_rx_action+0x956/0xe90 net/core/dev.c:6733
   __do_softirq+0x21a/0x968 kernel/softirq.c:553
   do_softirq kernel/softirq.c:454 [inline]
   do_softirq+0xaa/0xe0 kernel/softirq.c:441
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:381
   spin_unlock_bh include/linux/spinlock.h:396 [inline]
   batadv_nc_purge_paths+0x1ce/0x3c0 net/batman-adv/network-coding.c:471
   batadv_nc_worker+0x9b1/0x10e0 net/batman-adv/network-coding.c:722
   process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
   process_scheduled_works kernel/workqueue.c:2703 [inline]
   worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
   kthread+0x33c/0x440 kernel/kthread.c:388
   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
   </TASK>

To address the issue, catch the racing subflow state change and
use it to cause the MPTCP fallback. Such fallback is also used to
cause the first subflow state propagation to the msk socket via
mptcp_set_connected(). After this change, the first subflow can
additionally propagate the TCP_FIN_WAIT1 state, so rename the
helper accordingly.

Finally, if the state propagation is delayed to the msk release
callback, the first subflow can change to a different state in between.
Cache the relevant target state in a new msk-level field and use
such value to update the msk state at release time.

Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
Cc: stable@vger.kernel.org
Reported-by: <syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/458
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bc81ea53a049..5cd5c3f535a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3402,12 +3402,12 @@ static void mptcp_release_cb(struct sock *sk)
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
 	if (unlikely(msk->cb_flags)) {
-		/* be sure to set the current sk state before taking actions
+		/* be sure to sync the msk state before taking actions
 		 * depending on sk_state (MPTCP_ERROR_REPORT)
 		 * On sk release avoid actions depending on the first subflow
 		 */
-		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags) && msk->first)
-			__mptcp_set_connected(sk);
+		if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags) && msk->first)
+			__mptcp_sync_state(sk, msk->pending_state);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fe6f2d399ee8..aa1a93fe40ff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,7 @@
 #define MPTCP_ERROR_REPORT	3
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
-#define MPTCP_CONNECTED		6
+#define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
@@ -296,6 +296,9 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
+	u8		pending_state; /* A subflow asked to set this sk_state,
+					* protected by the msk data lock
+					*/
 	u8		mpc_endpoint_id;
 	u8		recvmsg_inq:1,
 			cork:1,
@@ -728,7 +731,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
-void __mptcp_set_connected(struct sock *sk);
+void __mptcp_sync_state(struct sock *sk, int state);
 void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
 
 static inline void mptcp_stop_tout_timer(struct sock *sk)
@@ -1115,7 +1118,7 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	return sk->sk_state == TCP_ESTABLISHED &&
+	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1) &&
 	       is_active_ssk(subflow) &&
 	       !subflow->conn_finished;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a4f3c27f0309..6d7684c35e93 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -419,22 +419,28 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 	return inet_sk(sk)->inet_dport != inet_sk((struct sock *)msk)->inet_dport;
 }
 
-void __mptcp_set_connected(struct sock *sk)
+void __mptcp_sync_state(struct sock *sk, int state)
 {
-	__mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	__mptcp_propagate_sndbuf(sk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
-		inet_sk_state_store(sk, TCP_ESTABLISHED);
+		inet_sk_state_store(sk, state);
 		sk->sk_state_change(sk);
 	}
 }
 
-static void mptcp_set_connected(struct sock *sk)
+static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
 	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk))
-		__mptcp_set_connected(sk);
-	else
-		__set_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->cb_flags);
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_sync_state(sk, ssk->sk_state);
+	} else {
+		msk->pending_state = ssk->sk_state;
+		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
+	}
 	mptcp_data_unlock(sk);
 }
 
@@ -496,7 +502,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow_set_remote_key(msk, subflow, &mp_opt);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
-		mptcp_set_connected(parent);
+		mptcp_propagate_state(parent, sk);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
@@ -540,7 +546,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(msk, sk);
-		mptcp_set_connected(parent);
+		mptcp_propagate_state(parent, sk);
 	}
 	return;
 
@@ -1740,7 +1746,7 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
-		mptcp_set_connected(parent);
+		mptcp_propagate_state(parent, sk);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection


