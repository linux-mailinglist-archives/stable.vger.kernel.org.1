Return-Path: <stable+bounces-24040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDE869259
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E7293EBB
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0713B7A2;
	Tue, 27 Feb 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rNVgtsEF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1513B7A0;
	Tue, 27 Feb 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040862; cv=none; b=QKJr1FszX4aauiSrLR6pK7OiYAhxoeZFAppWTFVv62oqs3KfdGHBc55vfiy/awJwt3uORzXsMzqEeBU4VoInMC0tWTfcpGO2qEZxf86LYiTD2kJJcDNXerd6NaVB2NMSwIw1RNmFouCFYu2bKqBJVDGsfF2PuWivqUXXCKTzQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040862; c=relaxed/simple;
	bh=YGL53HKMduTAceAxkB5VZeQ1VTkDxmmtuC5y5Zyr1Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/YJJTv+7OIg+TaYRyNaJblwARt5ExOtY6Mr4bPnnLlBW2KYlKpYg+Ovm6geY7ghlsar1ALMZKp/qUymvDsBT6aOzxo7EyR1jimslz21j+Y4fj9eQADS1O0uR8h1pbHXOIAHRQeOBuDZU/FLhVY0RhvaIKuT/R3seS1Q7n6Brag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rNVgtsEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBF3C433C7;
	Tue, 27 Feb 2024 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040862;
	bh=YGL53HKMduTAceAxkB5VZeQ1VTkDxmmtuC5y5Zyr1Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNVgtsEFoGWzYid/UR8PZhANt1uWD9VA66QftoSlFhFm72drUr5EYGMJ2jTWYhh02
	 IW0wsbjL6FjBk3Hyj5JcJp+GHgza0n0oT7n9i+jRwZJvD4jtmwUAQgkuYNvRkLYv1m
	 bI+LiqqOoyXhBU7XmC6LfkgO36HQkqFrAd1LSlLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 136/334] mptcp: corner case locking for rx path fields initialization
Date: Tue, 27 Feb 2024 14:19:54 +0100
Message-ID: <20240227131634.852076344@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit e4a0fa47e816e186f6b4c0055d07eeec42d11871 ]

Most MPTCP-level related fields are under the mptcp data lock
protection, but are written one-off without such lock at MPC
complete time, both for the client and the server

Leverage the mptcp_propagate_state() infrastructure to move such
initialization under the proper lock client-wise.

The server side critical init steps are done by
mptcp_subflow_fully_established(): ensure the caller properly held the
relevant lock, and avoid acquiring the same lock in the nested scopes.

There are no real potential races, as write access to such fields
is implicitly serialized by the MPTCP state machine; the primary
goal is consistency.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/fastopen.c |  6 ++---
 net/mptcp/options.c  |  9 +++----
 net/mptcp/protocol.c |  9 ++++---
 net/mptcp/protocol.h |  9 +++----
 net/mptcp/subflow.c  | 56 +++++++++++++++++++++++++-------------------
 5 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 74698582a2859..ad28da655f8bc 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -59,13 +59,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_unlock(sk);
 }
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt)
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb;
 
-	mptcp_data_lock(sk);
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
@@ -77,5 +76,4 @@ void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_
 	}
 
 	pr_debug("msk=%p ack_seq=%llx", msk, msk->ack_seq);
-	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d2527d189a799..e3e96a49f9229 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -962,9 +962,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
-		subflow->fully_established = 1;
-		WRITE_ONCE(msk->fully_established, true);
-		goto check_notify;
+		goto set_fully_established;
 	}
 
 	/* If the first established packet does not contain MP_CAPABLE + data
@@ -986,7 +984,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
-	mptcp_subflow_fully_established(subflow, mp_opt);
+
+	mptcp_data_lock((struct sock *)msk);
+	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
 	/* if the subflow is not already linked into the conn_list, we can't
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 436a6164b2724..fcd09afb98823 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3200,6 +3200,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
@@ -3240,7 +3241,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
-	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	subflow = mptcp_subflow_ctx(ssk);
+	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
 	/* new mpc subflow takes ownership of the newly
@@ -3255,6 +3257,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+
+	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
@@ -3530,8 +3535,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0aae9acef80f7..8ab87d16b1b70 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -622,8 +622,9 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
-void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
+void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
+				       struct mptcp_subflow_context *subflow,
+				       const struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
 void mptcp_check_and_set_pending(struct sock *sk);
 void __mptcp_push_pending(struct sock *sk, unsigned int flags);
@@ -952,8 +953,8 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt);
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c2df34ebcf284..c34ecadee1200 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -441,20 +441,6 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	}
 }
 
-static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk)) {
-		__mptcp_sync_state(sk, ssk->sk_state);
-	} else {
-		msk->pending_state = ssk->sk_state;
-		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
-	}
-	mptcp_data_unlock(sk);
-}
-
 static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
@@ -476,6 +462,31 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
 
+static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
+				  struct mptcp_subflow_context *subflow,
+				  const struct mptcp_options_received *mp_opt)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_data_lock(sk);
+	if (mp_opt) {
+		/* Options are available only in the non fallback cases
+		 * avoid updating rx path fields otherwise
+		 */
+		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
+		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
+		subflow_set_remote_key(msk, subflow, mp_opt);
+	}
+
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_sync_state(sk, ssk->sk_state);
+	} else {
+		msk->pending_state = ssk->sk_state;
+		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
+	}
+	mptcp_data_unlock(sk);
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -510,10 +521,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		if (mp_opt.deny_join_id0)
 			WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 		subflow->mp_capable = 1;
-		subflow_set_remote_key(msk, subflow, &mp_opt);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, &mp_opt);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
@@ -556,7 +566,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 	return;
 
@@ -741,17 +751,16 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 	kfree_rcu(ctx, rcu);
 }
 
-void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt)
+void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
+				       struct mptcp_subflow_context *subflow,
+				       const struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	subflow->fully_established = 1;
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
-		mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
+		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
@@ -844,7 +853,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 * mpc option
 			 */
 			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK) {
-				mptcp_subflow_fully_established(ctx, &mp_opt);
 				mptcp_pm_fully_established(owner, child);
 				ctx->pm_notified = 1;
 			}
@@ -1756,7 +1764,7 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_do_fallback(sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
-- 
2.43.0




