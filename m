Return-Path: <stable+bounces-127735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC8A7AA13
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6889A3B97EE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60C25743F;
	Thu,  3 Apr 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk+vFDIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDA257425;
	Thu,  3 Apr 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706978; cv=none; b=mUDkbjHZSKSMffbzDIB/8rUN9TcRfkUbwCfAZXUem7AJOBavLJEUibWF3cTfQGewb2YYqLE3RFUzhdJ0T/dfRA/n520DWSpoGawT8P3c/chToI9emfxQIYlrB9y6RmCmjjWpROAxf78C71tLlYN49Eezl0MA8aYH1/YSwwCZg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706978; c=relaxed/simple;
	bh=5bPkxCBE16IpdyWmPvOTLfT0XzT/sLnSvfPU3kl+gUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGLWh/JNXlrJD5yBqYFOKIPziHKZ1CbPDlRwQQh0G/QquncaDjJAOJhPaqwDXLzyiJ/cti/Ub8MT9mHRVw+kIbW9tZHQZQLEeufJbkbeiMB6oJqBkzuESmWU7hjnKBjfvadkB3+WgeC+g1px/MkgK0Mc1goCuReQDB9WWA4qld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk+vFDIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306C0C4CEE8;
	Thu,  3 Apr 2025 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706978;
	bh=5bPkxCBE16IpdyWmPvOTLfT0XzT/sLnSvfPU3kl+gUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gk+vFDIxTHhIno1dy2vix/e5iz9H7IwSGU2bNYGIp9iOq/luc/s16+i4J900cpDOC
	 UkVp59Uxl/iQt+uMCdwB+upJwGxBduoTqMnLlFhu0kwsZ/24cvK2sb8hs2FA/W+ecw
	 WZc0HfWST/HCV+J/xYTsLlyhE8+BU2tcOgts330u51YDqgCQa/OudElWDNzh2TI0Sr
	 nU6g7WfdXPaMDnczc6cRFlunbk/PhwNw36cjBcFKX0JCB1U4jaP46XyH2GEbXxlX7l
	 +q4fr++UytAdgf4UTSYzW8FksBFo61uRGfciiaVxjI8vqsGRTQiwIEmiOYWlDX8gPZ
	 4M8PmUod4jzAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 20/54] mptcp: move the whole rx path under msk socket lock protection
Date: Thu,  3 Apr 2025 15:01:35 -0400
Message-Id: <20250403190209.2675485-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit bc68b0efa1bf923cef1294a631d8e7416c7e06e4 ]

After commit c2e6048fa1cf ("mptcp: fix race in release_cb") we can
move the whole MPTCP rx path under the socket lock leveraging the
release_cb.

We can drop a bunch of spin_lock pairs in the receive functions, use
a single receive queue and invoke __mptcp_move_skbs only when subflows
ask for it.

This will allow more cleanup in the next patch.

Some changes are worth specific mention:

The msk rcvbuf update now always happens under both the msk and the
subflow socket lock: we can drop a bunch of ONCE annotation and
consolidate the checks.

When the skbs move is delayed at msk release callback time, even the
msk rcvbuf update is delayed; additionally take care of such action in
__mptcp_move_skbs().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-3-4a47d90d7998@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c |   1 +
 net/mptcp/protocol.c | 123 ++++++++++++++++++++-----------------------
 net/mptcp/protocol.h |   2 +-
 3 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index a29ff901df758..305f4c48ec158 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -49,6 +49,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	mptcp_data_lock(sk);
+	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
 	mptcp_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6bd8190474706..3117c06f5362e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -643,18 +643,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 	bool more_data_avail;
 	struct tcp_sock *tp;
 	bool done = false;
-	int sk_rbuf;
-
-	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
-
-	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
-
-		if (unlikely(ssk_rbuf > sk_rbuf)) {
-			WRITE_ONCE(sk->sk_rcvbuf, ssk_rbuf);
-			sk_rbuf = ssk_rbuf;
-		}
-	}
 
 	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
@@ -722,7 +710,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail = mptcp_subflow_data_available(ssk);
 
-		if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf) {
 			done = true;
 			break;
 		}
@@ -846,11 +834,30 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved > 0;
 }
 
+static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
+{
+	if (unlikely(ssk->sk_rcvbuf > sk->sk_rcvbuf))
+		WRITE_ONCE(sk->sk_rcvbuf, ssk->sk_rcvbuf);
+}
+
+static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	__mptcp_rcvbuf_update(sk, ssk);
+
+	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
+	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+		return;
+
+	/* Wake-up the reader only for in-sequence data */
+	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int sk_rbuf, ssk_rbuf;
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -859,19 +866,11 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	if (unlikely(subflow->disposable))
 		return;
 
-	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
-	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
-	if (unlikely(ssk_rbuf > sk_rbuf))
-		sk_rbuf = ssk_rbuf;
-
-	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf)
-		return;
-
-	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
-		sk->sk_data_ready(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_data_ready(sk, ssk);
+	else
+		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
 	mptcp_data_unlock(sk);
 }
 
@@ -1944,16 +1943,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
-static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
+static int __mptcp_recvmsg_mskq(struct sock *sk,
 				struct msghdr *msg,
 				size_t len, int flags,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
 	int copied = 0;
 
-	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
+	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
 		u32 offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
 		u32 count = min_t(size_t, len - copied, data_len);
@@ -1988,7 +1988,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			/* we will bulk release the skb memory later */
 			skb->destructor = NULL;
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
-			__skb_unlink(skb, &msk->receive_queue);
+			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 			msk->bytes_consumed += count;
 		}
@@ -2113,54 +2113,46 @@ static void __mptcp_update_rmem(struct sock *sk)
 	WRITE_ONCE(msk->rmem_released, 0);
 }
 
-static void __mptcp_splice_receive_queue(struct sock *sk)
+static bool __mptcp_move_skbs(struct sock *sk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
-}
-
-static bool __mptcp_move_skbs(struct mptcp_sock *msk)
-{
-	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
 	bool ret, done;
 
+	/* verify we can move any data from the subflow, eventually updating */
+	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		mptcp_for_each_subflow(msk, subflow)
+			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
+
+	if (__mptcp_rmem(sk) > sk->sk_rcvbuf)
+		return false;
+
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
 
-		/* we can have data pending in the subflows only if the msk
-		 * receive buffer was full at subflow_data_ready() time,
-		 * that is an unlikely slow path.
-		 */
-		if (likely(!ssk))
+		if (unlikely(!ssk))
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		mptcp_data_lock(sk);
 		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-		mptcp_data_unlock(sk);
 
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 
-	/* acquire the data lock only if some input data is pending */
 	ret = moved > 0;
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
-		mptcp_data_lock(sk);
+	    !skb_queue_empty(&sk->sk_receive_queue)) {
 		__mptcp_update_rmem(sk);
 		ret |= __mptcp_ofo_queue(msk);
-		__mptcp_splice_receive_queue(sk);
-		mptcp_data_unlock(sk);
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+	return ret;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
@@ -2168,7 +2160,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
 
-	skb = skb_peek(&msk->receive_queue);
+	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
 		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
 
@@ -2214,7 +2206,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2223,7 +2215,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
+		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -2249,7 +2241,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
 				 */
-				if (__mptcp_move_skbs(msk))
+				if (__mptcp_move_skbs(sk))
 					continue;
 				break;
 			}
@@ -2293,9 +2285,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
-		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
-		 skb_queue_empty(&msk->receive_queue), copied);
+	pr_debug("msk=%p rx queue empty=%d copied=%d\n",
+		 msk, skb_queue_empty(&sk->sk_receive_queue), copied);
 
 	release_sock(sk);
 	return copied;
@@ -2822,7 +2813,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 	INIT_WORK(&msk->work, mptcp_worker);
-	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
@@ -3405,12 +3395,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
 
-	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
-	mptcp_data_lock(sk);
-	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
-	mptcp_data_unlock(sk);
 
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
@@ -3453,7 +3439,8 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
-				      BIT(MPTCP_FLUSH_JOIN_LIST))
+				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
+				      BIT(MPTCP_DEQUEUE))
 
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
@@ -3487,6 +3474,11 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
+		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
+			/* notify ack seq update */
+			mptcp_cleanup_rbuf(msk, 0);
+			sk->sk_data_ready(sk);
+		}
 
 		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
@@ -3724,7 +3716,8 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 			return -EINVAL;
 
 		lock_sock(sk);
-		__mptcp_move_skbs(msk);
+		if (__mptcp_move_skbs(sk))
+			mptcp_cleanup_rbuf(msk, 0);
 		*karg = mptcp_inq_hint(sk);
 		release_sock(sk);
 		break;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad21925af0612..2f4e3188cf3b2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
+#define MPTCP_DEQUEUE		8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -324,7 +325,6 @@ struct mptcp_sock {
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-	struct sk_buff_head receive_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
-- 
2.39.5


