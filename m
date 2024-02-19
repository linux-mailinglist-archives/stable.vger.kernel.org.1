Return-Path: <stable+bounces-20565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F985A821
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E354D1F214CD
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97B3B786;
	Mon, 19 Feb 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ThD54Ep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5473B19C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358721; cv=none; b=jOvXE6b/sUoa8t/DZnxje5l31QQDJJXb9pP1lIfMRqW42ggH+t3l5wvGPBrS0RGvvUFjv9lgpabtydSa/fqjMlv4T125DH6kUFpjLJEzGv0Ho2S0834aKwUre128GVRhkYqX5jv/EVzM1BhhnXvXYsBo4etyYUO4wsrT0Lf9L0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358721; c=relaxed/simple;
	bh=nXgeSEsLx5/r/gFOLCJA9OGlL9HIob2VGgyORn6LyAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iOKUCUGKcoKG/cbJJx9B06Vcq0Z+0nuDtXsKlPaYBSw6jpKOlNPrfeKfHY7UkkiIzIp9QaTJGVJSHAcOVQpG0XjpZD8/1NF9K7oqtbK0arNJFJaC3wfNn4N0UHSpZ//kfmzHVyvTj5PzPsuifgu7BBvBZ6O7sQBDaUtlRwfZ2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ThD54Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802EDC433C7;
	Mon, 19 Feb 2024 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358721;
	bh=nXgeSEsLx5/r/gFOLCJA9OGlL9HIob2VGgyORn6LyAI=;
	h=Subject:To:Cc:From:Date:From;
	b=0ThD54EpFLERRdfhWxEu9Df8SujfNAh8oXjys3FAN0/IWCS075kNBzMNjkU8z7Xhk
	 REQGLWq5YoaouqaP/wZgyipXagKOgIBpAlBlYJuuRPj7upztJ/tmwLLHC0yDyRnwC0
	 FJRwxYXC74B0m4h2omGwSJsgMPByXYGMpjdaZXXo=
Subject: FAILED: patch "[PATCH] mptcp: corner case locking for rx path fields initialization" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,davem@davemloft.net,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:05:06 +0100
Message-ID: <2024021906-wobbling-village-0fc3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e4a0fa47e816e186f6b4c0055d07eeec42d11871
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021906-wobbling-village-0fc3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e4a0fa47e816 ("mptcp: corner case locking for rx path fields initialization")
3f83d8a77eee ("mptcp: fix more tx path fields initialization")
013e3179dbd2 ("mptcp: fix rcv space initialization")
c693a8516429 ("mptcp: use mptcp_set_state")
4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
d109a7767273 ("mptcp: fix possible NULL pointer dereference on close")
8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
a5efdbcece83 ("mptcp: fix delegated action races")
27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
f6909dc1c1f4 ("mptcp: rename timer related helper to less confusing names")
9f1a98813b4b ("mptcp: process pending subflow error on close")
d5fbeff1ab81 ("mptcp: move __mptcp_error_report in protocol.c")
e3b2870b6d22 ("mptcp: add a new sysctl scheduler")
ebc1e08f01eb ("mptcp: drop last_snd and MPTCP_RESET_SCHEDULER")
e263691773cd ("mptcp: Remove unnecessary test for __mptcp_init_sock()")
39880bd808ad ("mptcp: get rid of msk->subflow")
3f326a821b99 ("mptcp: change the mpc check helper to return a sk")
3aa362494170 ("mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()")
f0bc514bd5c1 ("mptcp: avoid additional indirection in sockopt")
40f56d0c7043 ("mptcp: avoid additional indirection in mptcp_listen()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4a0fa47e816e186f6b4c0055d07eeec42d11871 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 8 Feb 2024 19:03:52 +0100
Subject: [PATCH] mptcp: corner case locking for rx path fields initialization

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

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 74698582a285..ad28da655f8b 100644
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
index d2527d189a79..e3e96a49f922 100644
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
index 8cb6a873dae9..8ef2927ebca2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3186,6 +3186,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
@@ -3226,7 +3227,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
-	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	subflow = mptcp_subflow_ctx(ssk);
+	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
 	/* new mpc subflow takes ownership of the newly
@@ -3241,6 +3243,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+
+	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
@@ -3478,8 +3483,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9f5ee82e3473..fefcbf585411 100644
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
index c2df34ebcf28..c34ecadee120 100644
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


