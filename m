Return-Path: <stable+bounces-106566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA839FE9B5
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2F91884D31
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86B1B4237;
	Mon, 30 Dec 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEvc1uEi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098D1B422F;
	Mon, 30 Dec 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582364; cv=none; b=TGXAX1MgO75eSdC3ideegFmrnNdPg9jI5MUz5Qu9XjtrWrLez8roHH+0kae3Hu1y7iphsnb9+zy0Gh+z5wun3C/Oyg9T1jioYvvq+woinyRaVcPiVGidGOmMsz8CCuo3wiVA+z40xxUFhD3biDgv1nMntMAaOl2sx7ySnMPh/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582364; c=relaxed/simple;
	bh=3GqWaHhVC/0zjocNJkbBBeolfjfYPgIi7irOgXC4Li4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMU9Qmuuxpki++/o3DR/eLGR5//lXcPQYZKy5ja8TyuKtfChHRydPrWb5AHnFfN/TV3a3WyoWWznDqN6nlVPrfoAUswzJ7CGcqaaGzhsawEzKEQD+kZg0YywN7ENvFxHhW5atPzjGi8upLR+U7nOIZ1FQKYjO6SW3dhwWmEvlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEvc1uEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D11C4CEDC;
	Mon, 30 Dec 2024 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735582364;
	bh=3GqWaHhVC/0zjocNJkbBBeolfjfYPgIi7irOgXC4Li4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gEvc1uEivzsD+8eEvf7J7gwSH/j20LBpmN0C8L86zuHMVV+F8S/fTjb0Oz7/lzqK1
	 00gwmHIO409e1GL0Q+OXZrwAITaA5lm1IQMx2D1LPft56bSe2U8HOpNe10K+qthy5s
	 VH/kdkBVH0r2dC6647EbFqb2tZ4qQGI/1uyoaXe7u4i1jjH6tXAWXNJ38VoAHBjA0D
	 t7nCvTYIj28pZq8NJ8chXKzPHsX04mPPqtcCWNYcrIHLf65CBGYkxutnIp1981cG73
	 6GJKSzuEKKTTQt7+oAFkunpspaIM6E8ex6D7BYBsrHPbSLkpYJz1ETS5sWdHR5l640
	 QCHTwTUpDAbEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 19:12:31 +0100
Subject: [PATCH net 2/3] mptcp: don't always assume copied data in
 mptcp_cleanup_rbuf()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-net-mptcp-rbuf-fixes-v1-2-8608af434ceb@kernel.org>
References: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
In-Reply-To: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Jro3OUYTwf1FzAnykhSaTE51ONTfgmuwBnXuZnwKsFY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncuKUQjeWgZgqaqtceD03cYI1BfAUEEP9QFL9e
 TQ6aSSAZmuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3LilAAKCRD2t4JPQmmg
 c+fKEACvo+mZTblRqvxv1tCjhYX1y+VYCe//3lYg+reklIPkDguhVzZQY5buVv0F9cwXTtAcIVG
 d5jNbcclXK1FeRho+e7brh89MssyK0yzLhm/fJBFPXlng3vc5MLZgcUzC31OwWjyJ8pgl5NtZ43
 6ni9gXzfI1cUgMI/8k6uI9o1t70pWtJK9CLGPpoIgH9k4oMUkOBsm4BDH/3B38s89fYvEtCy7uQ
 4o/kuqjfcH+aDr8PuoeRi627KykGAlf4TeiAYsTxC38FFFRnkD6V33Pd5zlsb0rtUOgD6/0YvHO
 RYA/rvVff6W2OrOG+DaDkmmbVbzSh9o20F+qgjDQkDlWJGrY4seovhcx7cxlpUItlNB9dJOVccy
 1WJtLe4Lzz+7eLxoKCqEy5rHpsys5tSunzUSb2uRisfVeUeLvsvYFGn9YlmdGUSQPdR1qKLnqMr
 TU//UYk9YkBuV4SQwW+KgiI77RtwtoLzIQ6J0iQhiqZ2bWHpBfyVg+qm28aKL2b93TkfVT+7zlN
 r/et6TPjJiCUjd1SFKXY5QyWr8ergx0aFFnr7NrLpQjwP/5iaC3zL+9OPG9KpUYNXw5PQfHeoEu
 mquZH2n1vV0KB8Hrhd1qjCH/dKtcExtp0/qT+sSiGgcNK/wgMVCjBzTqxZxX2TVDLPDUbqCi0yG
 Bq/qb8svc6MlLeQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Under some corner cases the MPTCP protocol can end-up invoking
mptcp_cleanup_rbuf() when no data has been copied, but such helper
assumes the opposite condition.

Explicitly drop such assumption and performs the costly call only
when strictly needed - before releasing the msk socket lock.

Fixes: fd8976790a6c ("mptcp: be careful on MPTCP-level ack.")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27afdb7e2071b16dbc4dfa1199b6e78c784f7a7c..5307fff9d995309591ed742801350078db519f79 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -528,13 +528,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		mptcp_subflow_send_ack(mptcp_subflow_tcp_sock(subflow));
 }
 
-static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
 	if (tcp_can_send_ack(ssk))
-		tcp_cleanup_rbuf(ssk, 1);
+		tcp_cleanup_rbuf(ssk, copied);
 	unlock_sock_fast(ssk, slow);
 }
 
@@ -551,7 +551,7 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
@@ -559,14 +559,14 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 	int space =  __mptcp_space(sk);
 	bool cleanup, rx_empty;
 
-	cleanup = (space > 0) && (space >= (old_space << 1));
-	rx_empty = !__mptcp_rmem(sk);
+	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
+	rx_empty = !__mptcp_rmem(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
-			mptcp_subflow_cleanup_rbuf(ssk);
+			mptcp_subflow_cleanup_rbuf(ssk, copied);
 	}
 }
 
@@ -2220,9 +2220,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		/* be sure to advertise window change */
-		mptcp_cleanup_rbuf(msk);
-
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
@@ -2271,6 +2268,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
+		mptcp_cleanup_rbuf(msk, copied);
 		err = sk_wait_data(sk, &timeo, NULL);
 		if (err < 0) {
 			err = copied ? : err;
@@ -2278,6 +2276,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
+	mptcp_cleanup_rbuf(msk, copied);
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)

-- 
2.47.1


