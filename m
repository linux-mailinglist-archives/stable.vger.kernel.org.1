Return-Path: <stable+bounces-192096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C709C29A0D
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73E53AC51B
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1E13D539;
	Sun,  2 Nov 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsnUvMfp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CF34D396
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762126059; cv=none; b=OKClUgHGGE4c/YWulcZR9vwMyDD3hPJ2yOHZ/P1ReEbn7KdF5XNW45Q5f7XuAVPobMN76tc7LCJC4ptEST0fsz0hcNk26svrGyaujtmVNPF58pnQMuhBaMUxVHUYcAXrgNowVGI21ccJ0htPY2dME3AQK9wKKUcTeT8x0uzbtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762126059; c=relaxed/simple;
	bh=BKmc/Hpc+y+Hk4ET+NYqX5NhJDkNCIICys7g7jdQ+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi4gTqIX/+h6AIBABkaAzTKZDiByFi41B/oH4xayk3ih7XFBLk56B1JI56vEjR+ksckspsYk4oz3c/dP+7CoEwO9TJRTulyWobwzLrZwC2NSTcEEFmmdXSOliQxxtP9R7d9Xdk2R3Uymo5mwLxTlcLN5MTS8spZO1Fu/w71o7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsnUvMfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F5BC116B1;
	Sun,  2 Nov 2025 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762126059;
	bh=BKmc/Hpc+y+Hk4ET+NYqX5NhJDkNCIICys7g7jdQ+Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsnUvMfpjwiU/5LccV03De58BbCCVeugpsNLqZ4bKf7WUTs1WWyRzBxaxQ2sHzRGz
	 Vopl9ZCcReK3xxg98MnybAnrUA42icS5N7RehY7N1Ibtq4WY6MP5AEHLr3+xQmj18D
	 3rsM4N1iWVJ6zGn4ILZdfOHzGBKAFCyja8KbQb8/7TxevQ1wfrGCuob9UY5KhjWCVu
	 DROhm36VMJtpwt4+DPAy+k/KIJOhqPB6Vs7Tp1j8zlRcxvhuJPdGM9SbZI7TcMqdDl
	 W/RehsCaxo69chWWofd4SmCIj7H+gTHNRcxL9OUltvyAteJ99rYZr0DKWCftqqQpKS
	 vMqpoBlFn//FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] mptcp: cleanup mem accounting
Date: Sun,  2 Nov 2025 18:27:33 -0500
Message-ID: <20251102232735.3652847-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102232735.3652847-1-sashal@kernel.org>
References: <2025110208-pond-pouring-512d@gregkh>
 <20251102232735.3652847-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 6639498ed85fdb135dfb0dfbcc0f540b2d4ad6a6 ]

After the previous patch, updating sk_forward_memory is cheap and
we can drop a lot of complexity from the MPTCP memory accounting,
removing the custom fwd mem allocations for rmem.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-4-4a47d90d7998@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c |   2 +-
 net/mptcp/protocol.c | 115 +++----------------------------------------
 net/mptcp/protocol.h |   4 +-
 3 files changed, 10 insertions(+), 111 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 305f4c48ec158..ebcc04fae5269 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -51,7 +51,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
-	mptcp_set_owner_r(skb, sk);
+	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	mptcp_sk(sk)->bytes_received += skb->len;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21ffb8615fed4..85a6ea13a44db 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -118,17 +118,6 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static void mptcp_rmem_fwd_alloc_add(struct sock *sk, int size)
-{
-	WRITE_ONCE(mptcp_sk(sk)->rmem_fwd_alloc,
-		   mptcp_sk(sk)->rmem_fwd_alloc + size);
-}
-
-static void mptcp_rmem_charge(struct sock *sk, int size)
-{
-	mptcp_rmem_fwd_alloc_add(sk, -size);
-}
-
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 			       struct sk_buff *from)
 {
@@ -150,7 +139,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	 * negative one
 	 */
 	atomic_add(delta, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, delta);
+	sk_mem_charge(sk, delta);
 	kfree_skb_partial(from, fragstolen);
 
 	return true;
@@ -165,44 +154,6 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 	return mptcp_try_coalesce((struct sock *)msk, to, from);
 }
 
-static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
-{
-	amount >>= PAGE_SHIFT;
-	mptcp_rmem_charge(sk, amount << PAGE_SHIFT);
-	__sk_mem_reduce_allocated(sk, amount);
-}
-
-static void mptcp_rmem_uncharge(struct sock *sk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int reclaimable;
-
-	mptcp_rmem_fwd_alloc_add(sk, size);
-	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
-
-	/* see sk_mem_uncharge() for the rationale behind the following schema */
-	if (unlikely(reclaimable >= PAGE_SIZE))
-		__mptcp_rmem_reclaim(sk, reclaimable);
-}
-
-static void mptcp_rfree(struct sk_buff *skb)
-{
-	unsigned int len = skb->truesize;
-	struct sock *sk = skb->sk;
-
-	atomic_sub(len, &sk->sk_rmem_alloc);
-	mptcp_rmem_uncharge(sk, len);
-}
-
-void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
-{
-	skb_orphan(skb);
-	skb->sk = sk;
-	skb->destructor = mptcp_rfree;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
-	mptcp_rmem_charge(sk, skb->truesize);
-}
-
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -315,25 +266,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 
 end:
 	skb_condense(skb);
-	mptcp_set_owner_r(skb, sk);
-}
-
-static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int amt, amount;
-
-	if (size <= msk->rmem_fwd_alloc)
-		return true;
-
-	size -= msk->rmem_fwd_alloc;
-	amt = sk_mem_pages(size);
-	amount = amt << PAGE_SHIFT;
-	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
-		return false;
-
-	mptcp_rmem_fwd_alloc_add(sk, amount);
-	return true;
+	skb_set_owner_r(skb, sk);
 }
 
 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -351,7 +284,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	skb_orphan(skb);
 
 	/* try to fetch required memory from subflow */
-	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize)) {
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		goto drop;
 	}
@@ -375,7 +308,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
 			return true;
 
-		mptcp_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
@@ -2011,9 +1944,10 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* we will bulk release the skb memory later */
+			/* avoid the indirect call, we know the destructor is sock_wfree */
 			skb->destructor = NULL;
-			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
+			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			__kfree_skb(skb);
 			msk->bytes_consumed += count;
@@ -2127,18 +2061,6 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static void __mptcp_update_rmem(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (!msk->rmem_released)
-		return;
-
-	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
-	mptcp_rmem_uncharge(sk, msk->rmem_released);
-	WRITE_ONCE(msk->rmem_released, 0);
-}
-
 static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2162,7 +2084,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 			break;
 
 		slowpath = lock_sock_fast(ssk);
-		__mptcp_update_rmem(sk);
 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 
 		if (unlikely(ssk->sk_err))
@@ -2170,12 +2091,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
 		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 
-	ret = moved > 0;
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
-	    !skb_queue_empty(&sk->sk_receive_queue)) {
-		__mptcp_update_rmem(sk);
-		ret |= __mptcp_ofo_queue(msk);
-	}
+	ret = moved > 0 || __mptcp_ofo_queue(msk);
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
 	return ret;
@@ -2854,8 +2770,6 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
-	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 
@@ -3083,8 +2997,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(READ_ONCE(msk->rmem_fwd_alloc));
-	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
@@ -3453,8 +3365,6 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
-	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3550,8 +3460,6 @@ static void mptcp_release_cb(struct sock *sk)
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
 	}
-
-	__mptcp_update_rmem(sk);
 }
 
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
@@ -3727,12 +3635,6 @@ static void mptcp_shutdown(struct sock *sk, int how)
 		__mptcp_wr_shutdown(sk);
 }
 
-static int mptcp_forward_alloc_get(const struct sock *sk)
-{
-	return READ_ONCE(sk->sk_forward_alloc) +
-	       READ_ONCE(mptcp_sk(sk)->rmem_fwd_alloc);
-}
-
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 {
 	const struct sock *sk = (void *)msk;
@@ -3891,7 +3793,6 @@ static struct proto mptcp_prot = {
 	.hash		= mptcp_hash,
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
-	.forward_alloc_get	= mptcp_forward_alloc_get,
 	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 044260e775d19..17320a7998b02 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -280,7 +280,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	u64		bytes_consumed;
-	int		rmem_fwd_alloc;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
@@ -295,7 +294,6 @@ struct mptcp_sock {
 	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
-	int		rmem_released;
 	unsigned long	flags;
 	unsigned long	cb_flags;
 	bool		recovery;		/* closing subflow write queue reinjected */
@@ -392,7 +390,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
  */
 static inline int __mptcp_rmem(const struct sock *sk)
 {
-	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
+	return atomic_read(&sk->sk_rmem_alloc);
 }
 
 static inline int mptcp_win_from_space(const struct sock *sk, int space)
-- 
2.51.0


