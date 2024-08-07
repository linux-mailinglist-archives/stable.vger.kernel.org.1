Return-Path: <stable+bounces-65770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1794ABD4
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332D31C21A66
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDE80BF8;
	Wed,  7 Aug 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyOusG5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2227448;
	Wed,  7 Aug 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043362; cv=none; b=QcuCTtCySn772eHogq1kTbcTthULIHWbVAG1Xno5x9qtOzbr0Bpb4fHs6hw7TRCXQ989Fqeol95V0R+JZAQjfqP0r6cM2BMvcPIqjHQXGk3IK3au+AWZuzpoNRvLkFbLxiB2kajyTNQTigfNL3yz5ij/f6GhVv/1XdYhIVzK9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043362; c=relaxed/simple;
	bh=dIJ3XKvk9KMhqkduAefcnW4Wges1uprK9nKAvEv6YDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0uIoV33xRKncCmo/ivZR3YkTN/3JS5bAtL1PXUfs+o+Dl2Y8//y+9b6JIGUgo8smKKOFWfbXQNj8qDTZVTj3aNxCPAdnBbPRNxLkOSVirAQCimRSlOXgNZPNgORKy/RYdoGTze6/yfjDnFsTpdA1Yx7zF6agtEW2+iUiopp63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyOusG5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA5FC4AF0D;
	Wed,  7 Aug 2024 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043362;
	bh=dIJ3XKvk9KMhqkduAefcnW4Wges1uprK9nKAvEv6YDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dyOusG5qEKIgnTuqCHtW9pudVTe5ViuxI79WB919utdtWeVYAuoyLKzo9wiQS/k1d
	 6I6ZX2ZMkOB3d1Oi0tzyAK22W6gSJ9FmNF2gQYgHiQXTqwK6pu5bIJaPZDtwcDrGCr
	 rTvpgL1YK+5x4nkVIByRcBnWrDQjQs2uZGG7AjiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/121] mptcp: give rcvlowat some love
Date: Wed,  7 Aug 2024 16:59:55 +0200
Message-ID: <20240807150021.472831688@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 5684ab1a0effbfeb706f47d85785f653005b97b1 ]

The MPTCP protocol allow setting sk_rcvlowat, but the value there
is currently ignored.

Additionally, the default subflows sk_rcvlowat basically disables per
subflow delayed ack: the MPTCP protocol move the incoming data from the
subflows into the msk socket as soon as the TCP stacks invokes the subflow
data_ready callback. Later, when __tcp_ack_snd_check() takes action,
the subflow-level copied_seq matches rcv_nxt, and that mandate for an
immediate ack.

Let the mptcp receive path be aware of such threshold, explicitly tracking
the amount of data available to be ready and checking vs sk_rcvlowat in
mptcp_poll() and before waking-up readers.

Additionally implement the set_rcvlowat() callback, to properly handle
the rcvbuf auto-tuning on sk_rcvlowat changes.

Finally to properly handle delayed ack, force the subflow level threshold
to 0 and instead explicitly ask for an immediate ack when the msk level th
is not reached.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231023-send-net-next-20231023-2-v1-5-9dc60939d371@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 05f76b2d634e ("tcp: Adjust clamping window for applications specifying SO_RCVBUF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 24 +++++++++++-------------
 net/mptcp/protocol.h | 20 ++++++++++++++++++++
 net/mptcp/sockopt.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 12 ++++++++++--
 4 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbf2b26760731..d2edd02a137bd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -849,9 +849,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk))
+	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
-
 	mptcp_data_unlock(sk);
 }
 
@@ -1918,6 +1917,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			if (!(flags & MSG_PEEK)) {
 				MPTCP_SKB_CB(skb)->offset += count;
 				MPTCP_SKB_CB(skb)->map_seq += count;
+				msk->bytes_consumed += count;
 			}
 			break;
 		}
@@ -1928,6 +1928,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
 			__skb_unlink(skb, &msk->receive_queue);
 			__kfree_skb(skb);
+			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2752,6 +2753,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->rmem_fwd_alloc = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
+	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -2984,16 +2986,9 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
+static __poll_t mptcp_check_readable(struct sock *sk)
 {
-	/* Concurrent splices from sk_receive_queue into receive_queue will
-	 * always show at least one non-empty queue when checked in this order.
-	 */
-	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
-	    skb_queue_empty_lockless(&msk->receive_queue))
-		return 0;
-
-	return EPOLLIN | EPOLLRDNORM;
+	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -3031,7 +3026,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_check_readable(msk) || timeout < 0) {
+	if (mptcp_data_avail(msk) || timeout < 0) {
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */
@@ -3157,6 +3152,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->snd_data_fin_enable = false;
 	msk->rcv_fastclose = false;
 	msk->use_64bit_ack = false;
+	msk->bytes_consumed = 0;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
@@ -3983,7 +3979,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(msk);
+		mask |= mptcp_check_readable(sk);
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
@@ -4021,6 +4017,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
+	.set_rcvlowat	   = mptcp_set_rcvlowat,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4122,6 +4119,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
+	.set_rcvlowat	   = mptcp_set_rcvlowat,
 };
 
 static struct proto mptcp_v6_prot;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93ba48f4ae386..305f4ed954b4b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,6 +268,7 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
+	u64		bytes_consumed;
 	int		rmem_fwd_alloc;
 	int		snd_burst;
 	int		old_wspace;
@@ -674,6 +675,24 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
+static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
+}
+
+static inline bool mptcp_epollin_ready(const struct sock *sk)
+{
+	/* mptcp doesn't have to deal with small skbs in the receive queue,
+	 * at it can always coalesce them
+	 */
+	return (mptcp_data_avail(mptcp_sk(sk)) >= sk->sk_rcvlowat) ||
+	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
+	       READ_ONCE(tcp_memory_pressure);
+}
+
+int mptcp_set_rcvlowat(struct sock *sk, int val);
+
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
 	/* only send if our side has not closed yet */
@@ -748,6 +767,7 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
 	       READ_ONCE(mptcp_sk(sk)->fully_established);
 }
+
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cc04b5e29dd35..6e254f10b41e6 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1521,9 +1521,51 @@ void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 
 	msk_owned_by_me(msk);
 
+	ssk->sk_rcvlowat = 0;
+
 	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
 		sync_socket_options(msk, ssk);
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
 	}
 }
+
+/* unfortunately this is different enough from the tcp version so
+ * that we can't factor it out
+ */
+int mptcp_set_rcvlowat(struct sock *sk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	int space, cap;
+
+	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		cap = sk->sk_rcvbuf >> 1;
+	else
+		cap = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]) >> 1;
+	val = min(val, cap);
+	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
+
+	/* Check if we need to signal EPOLLIN right now */
+	if (mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+
+	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
+		return 0;
+
+	space = __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, val);
+	if (space <= sk->sk_rcvbuf)
+		return 0;
+
+	/* propagate the rcvbuf changes to all the subflows */
+	WRITE_ONCE(sk->sk_rcvbuf, space);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		WRITE_ONCE(ssk->sk_rcvbuf, space);
+		tcp_sk(ssk)->window_clamp = val;
+		unlock_sock_fast(ssk, slow);
+	}
+	return 0;
+}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 23ee96c6abcbf..090bd05a78642 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1432,10 +1432,18 @@ static void subflow_data_ready(struct sock *sk)
 	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
 		     !subflow->mp_join && !(state & TCPF_CLOSE));
 
-	if (mptcp_subflow_data_available(sk))
+	if (mptcp_subflow_data_available(sk)) {
 		mptcp_data_ready(parent, sk);
-	else if (unlikely(sk->sk_err))
+
+		/* subflow-level lowat test are not relevant.
+		 * respect the msk-level threshold eventually mandating an immediate ack
+		 */
+		if (mptcp_data_avail(msk) < parent->sk_rcvlowat &&
+		    (tcp_sk(sk)->rcv_nxt - tcp_sk(sk)->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss)
+			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+	} else if (unlikely(sk->sk_err)) {
 		subflow_error_report(sk);
+	}
 }
 
 static void subflow_write_space(struct sock *ssk)
-- 
2.43.0




