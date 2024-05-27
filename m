Return-Path: <stable+bounces-47330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF01F8D0D8D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3CEB2101B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9A15FA9F;
	Mon, 27 May 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HHBZbLPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5F17727;
	Mon, 27 May 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838269; cv=none; b=s28xrg9id6XxZqKwbimI16jlviArkTsxjUCwasaCF92uTFmo/vR3EMT4V4DKvdkUjz0YkELimGeqYPFrxHv/1oSweAnEzSgYZaY0tnsABxV0wsSeVobeHja6FU0sBqb/sqI2JtR7mk4AwiQBvqYvWeJv0Nk0qCJijPKT3YZyFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838269; c=relaxed/simple;
	bh=cBr+gMQG7LlJHVKgbEodbaayBO5LQ0M/DRcd9K/i1JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWPJ5B3DSMvjMPTWyW0/0mr0kmWqnjp/VOW2n1M7jJr76zL1qu7B2DtC7AwfF+pPwku7L6oTKAWnZwm7tfLRiS55jZcWc6+IkC4+jmsK/3Dd0wxRM057NghNxfQssA4G1QbHMt+E00SOJhcCUsirNBTezAansWGWO9wf7RPvoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HHBZbLPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A08AC2BBFC;
	Mon, 27 May 2024 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838268;
	bh=cBr+gMQG7LlJHVKgbEodbaayBO5LQ0M/DRcd9K/i1JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHBZbLPbPjZcMy/2OYKCOKy5ZE3UWO+B+KRJvG1BwTQmK8RYZc0pz3+lR1KwtjbX/
	 n6sTC6YUl3vdZelN4K4SEbOdtF8PT+caTXdCN4fmaair3OwrflzFKstZEoVE+f3nK6
	 Ev1oEbQt6rQ+J4BXd2WrlaodwuYCO04US5EX4yyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 329/493] mptcp: implement TCP_NOTSENT_LOWAT support
Date: Mon, 27 May 2024 20:55:31 +0200
Message-ID: <20240527185641.029704459@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 29b5e5ef87397963ca38d3eec0d296ad1c979bbc ]

Add support for such socket option storing the user-space provided
value in a new msk field, and using such data to implement the
_mptcp_stream_memory_free() helper, similar to the TCP one.

To avoid adding more indirect calls in the fast path, open-code
a variant of sk_stream_memory_free() in mptcp_sendmsg() and add
direct calls to the mptcp stream memory free helper where possible.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/464
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 39 ++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h | 28 +++++++++++++++++++++++++++-
 net/mptcp/sockopt.c  | 12 ++++++++++++
 3 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fcd85adc621c1..54e29ab911f0d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1757,6 +1757,30 @@ static int do_copy_data_nocache(struct sock *sk, int copy,
 	return 0;
 }
 
+/* open-code sk_stream_memory_free() plus sent limit computation to
+ * avoid indirect calls in fast-path.
+ * Called under the msk socket lock, so we can avoid a bunch of ONCE
+ * annotations.
+ */
+static u32 mptcp_send_limit(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 limit, not_sent;
+
+	if (sk->sk_wmem_queued >= READ_ONCE(sk->sk_sndbuf))
+		return 0;
+
+	limit = mptcp_notsent_lowat(sk);
+	if (limit == UINT_MAX)
+		return UINT_MAX;
+
+	not_sent = msk->write_seq - msk->snd_nxt;
+	if (not_sent >= limit)
+		return 0;
+
+	return limit - not_sent;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1801,6 +1825,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		struct mptcp_data_frag *dfrag;
 		bool dfrag_collapsed;
 		size_t psize, offset;
+		u32 copy_limit;
+
+		/* ensure fitting the notsent_lowat() constraint */
+		copy_limit = mptcp_send_limit(sk);
+		if (!copy_limit)
+			goto wait_for_memory;
 
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
@@ -1808,9 +1838,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		dfrag = mptcp_pending_tail(sk);
 		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
 		if (!dfrag_collapsed) {
-			if (!sk_stream_memory_free(sk))
-				goto wait_for_memory;
-
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
@@ -1825,6 +1852,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		offset = dfrag->offset + dfrag->data_len;
 		psize = pfrag->size - offset;
 		psize = min_t(size_t, psize, msg_data_left(msg));
+		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
 
 		if (!sk_wmem_schedule(sk, total_ts))
@@ -3761,6 +3789,7 @@ static struct proto mptcp_prot = {
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
 	.forward_alloc_get	= mptcp_forward_alloc_get,
+	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
 	.memory_allocated	= &tcp_memory_allocated,
@@ -3932,12 +3961,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
-	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
 	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
-	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b83869ef7938..2f17f295d7c8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -305,6 +305,7 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	u32		notsent_lowat;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -789,11 +790,36 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline u32 mptcp_notsent_lowat(const struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	u32 val;
+
+	val = READ_ONCE(mptcp_sk(sk)->notsent_lowat);
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+}
+
+static inline bool mptcp_stream_memory_free(const struct sock *sk, int wake)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 notsent_bytes;
+
+	notsent_bytes = READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
+	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);
+}
+
+static inline bool __mptcp_stream_is_writeable(const struct sock *sk, int wake)
+{
+	return mptcp_stream_memory_free(sk, wake) &&
+	       __sk_stream_is_writeable(sk, wake);
+}
+
 static inline void mptcp_write_space(struct sock *sk)
 {
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
-	sk_stream_write_space(sk);
+	if (mptcp_stream_memory_free(sk, 1))
+		sk_stream_write_space(sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 82d0cd0819f09..f2fe28a3912a9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -810,6 +810,16 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
+	case TCP_NOTSENT_LOWAT:
+		ret = mptcp_get_int_option(msk, optval, optlen, &val);
+		if (ret)
+			return ret;
+
+		lock_sock(sk);
+		WRITE_ONCE(msk->notsent_lowat, val);
+		mptcp_write_space(sk);
+		release_sock(sk);
+		return 0;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_CORK:
@@ -1343,6 +1353,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
+	case TCP_NOTSENT_LOWAT:
+		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	}
 	return -EOPNOTSUPP;
 }
-- 
2.43.0




