Return-Path: <stable+bounces-24424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC9869468
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C721F224F0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC6145351;
	Tue, 27 Feb 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DvI4K7T0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A521419AD;
	Tue, 27 Feb 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041962; cv=none; b=J7dNz84y8xcmQTZ2zBTtaDuDD3CSzDAP66bSnjjzssyIa9E9/umzYVJxRXg5xy64NMmtOcikoCYfzBIy1y5s7l+eswRpT/Mf5RRDDnwI+pkV7isx1lAF+AVrYc1Vd9F/BRphVgxmv73bjtRGbOJrdXzMK7iDtxRW3UPUf61MAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041962; c=relaxed/simple;
	bh=k0pVXXgDJLEp9ZCDFufYNZLHAhRTcHII0/fq42i2t08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh6K6IDfMUcpaYqyxJaE8T6Hs9KEDEKW6WlrfaaFMqh2u85hu7nHSk8y91R3NkzgcfKJvj8zwIsL2zqjuQDjm+oow1P4O//8NUctkuKwhqH3+hgCEHGz+aCwE2JlG5h60maS3W5fcqnsdMzwThiMJIIpOXEQuKsCwlOy4/mcX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DvI4K7T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E4C43390;
	Tue, 27 Feb 2024 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041961;
	bh=k0pVXXgDJLEp9ZCDFufYNZLHAhRTcHII0/fq42i2t08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvI4K7T0nosFWpz3dLWJGYxduGPEy0YveJnUIt0P2sK4WnaHOte5XlDCdGEIFDz5m
	 yjN7Cb1qYDPOuVI8peOtmqSkthNYE6sqV/vNYUYm6FROysHj8/9/G+Hpzua8H5bPQt
	 Z3pJoh0tvfLLOgO4HVqf8P9vuHGx9TvtyLX1tRpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 123/299] mptcp: corner case locking for rx path fields initialization
Date: Tue, 27 Feb 2024 14:23:54 +0100
Message-ID: <20240227131629.828054722@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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
index 55a90a7b7b517..d369274113108 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3195,6 +3195,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
@@ -3235,7 +3236,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
-	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	subflow = mptcp_subflow_ctx(ssk);
+	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
 	/* new mpc subflow takes ownership of the newly
@@ -3250,6 +3252,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+
+	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
@@ -3525,8 +3530,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 01778ffa86be1..c9516882cdd4c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -623,8 +623,9 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
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
@@ -938,8 +939,8 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt);
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba739e7009221..43d6ee4328141 100644
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
@@ -1748,7 +1756,7 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_do_fallback(sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
-- 
2.43.0




