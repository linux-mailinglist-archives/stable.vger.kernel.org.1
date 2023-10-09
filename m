Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE857BDD3F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376732AbjJINIv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376672AbjJINIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC6D6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7563C433C9;
        Mon,  9 Oct 2023 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856928;
        bh=MwQjLTtuEdam3L62t2wIDRUW4uRl4izgVvIqZezBN2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEiCme4yTn1IgqRjMujNFEJvp2WYHTKApxhqQvFJQ4OQ6V0Y5lBp3mMd+w1uEh3PV
         kk1hC7VZFbFXCrY/eKU1f7XQ0NPpqCkSfSoe5jQQhXGrLmrA1S6ngWSOBEii+U4esu
         hRWd8l0XmgI5vWC1dlcgfoq6nfpOwbAeWN/ahaLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 011/163] mptcp: fix dangling connection hang-up
Date:   Mon,  9 Oct 2023 14:59:35 +0200
Message-ID: <20231009130124.330622383@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 27e5ccc2d5a50ed61bb73153edb1066104b108b3 ]

According to RFC 8684 section 3.3:

  A connection is not closed unless [...] or an implementation-specific
  connection-level send timeout.

Currently the MPTCP protocol does not implement such timeout, and
connection timing-out at the TCP-level never move to close state.

Introduces a catch-up condition at subflow close time to move the
MPTCP socket to close, too.

That additionally allows removing similar existing inside the worker.

Finally, allow some additional timeout for plain ESTABLISHED mptcp
sockets, as the protocol allows creating new subflows even at that
point and making the connection functional again.

This issue is actually present since the beginning, but it is basically
impossible to solve without a long chain of functional pre-requisites
topped by commit bbd49d114d57 ("mptcp: consolidate transition to
TCP_CLOSE in mptcp_do_fastclose()"). When backporting this current
patch, please also backport this other commit as well.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++++----------------------
 net/mptcp/protocol.h | 22 ++++++++++++
 net/mptcp/subflow.c  |  1 +
 3 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c85b4c107b2a..3a08ad4ec5d2c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -894,6 +894,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
+	mptcp_stop_tout_timer(sk);
 	return true;
 }
 
@@ -2357,18 +2358,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	bool dispose_it, need_push = false;
 
 	/* If the first subflow moved to a close state before accept, e.g. due
-	 * to an incoming reset, mptcp either:
-	 * - if either the subflow or the msk are dead, destroy the context
-	 *   (the subflow socket is deleted by inet_child_forget) and the msk
-	 * - otherwise do nothing at the moment and take action at accept and/or
-	 *   listener shutdown - user-space must be able to accept() the closed
-	 *   socket.
+	 * to an incoming reset or listener shutdown, the subflow socket is
+	 * already deleted by inet_child_forget() and the mptcp socket can't
+	 * survive too.
 	 */
-	if (msk->in_accept_queue && msk->first == ssk) {
-		if (!sock_flag(sk, SOCK_DEAD) && !sock_flag(ssk, SOCK_DEAD))
-			return;
-
+	if (msk->in_accept_queue && msk->first == ssk &&
+	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
 		/* ensure later check in mptcp_worker() will dispose the msk */
+		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
 		sock_set_flag(sk, SOCK_DEAD);
 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
@@ -2435,6 +2432,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
+
+	/* Catch every 'all subflows closed' scenario, including peers silently
+	 * closing them, e.g. due to timeout.
+	 * For established sockets, allow an additional timeout before closing,
+	 * as the protocol can still create more subflows.
+	 */
+	if (list_is_singular(&msk->conn_list) && msk->first &&
+	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
+		if (sk->sk_state != TCP_ESTABLISHED ||
+		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
+			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_close_wake_up(sk);
+		} else {
+			mptcp_start_tout_timer(sk);
+		}
+	}
 }
 
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
@@ -2478,23 +2491,14 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 }
 
-static bool mptcp_should_close(const struct sock *sk)
+static bool mptcp_close_tout_expired(const struct sock *sk)
 {
-	s32 delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
-	struct mptcp_subflow_context *subflow;
-
-	if (delta >= TCP_TIMEWAIT_LEN || mptcp_sk(sk)->in_accept_queue)
-		return true;
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp ||
+	    sk->sk_state == TCP_CLOSE)
+		return false;
 
-	/* if all subflows are in closed status don't bother with additional
-	 * timeout
-	 */
-	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
-		if (inet_sk_state_load(mptcp_subflow_tcp_sock(subflow)) !=
-		    TCP_CLOSE)
-			return false;
-	}
-	return true;
+	return time_after32(tcp_jiffies32,
+		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2619,15 +2623,16 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	struct sock *sk = (struct sock *)msk;
 	unsigned long timeout, close_timeout;
 
-	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
+	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
+	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
+			TCP_TIMEWAIT_LEN;
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
 	 */
-	timeout = sock_flag(sk, SOCK_DEAD) ? close_timeout : fail_tout;
+	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
 	sk_reset_timer(sk, &sk->sk_timer, timeout);
 }
@@ -2646,8 +2651,6 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_subflow_reset(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
-
-	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2684,18 +2687,14 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
-	/* There is no point in keeping around an orphaned sk timedout or
-	 * closed, but we need the msk around to reply to incoming DATA_FIN,
-	 * even if it is orphaned and in FIN_WAIT2 state
-	 */
-	if (sock_flag(sk, SOCK_DEAD)) {
-		if (mptcp_should_close(sk))
-			mptcp_do_fastclose(sk);
+	if (mptcp_close_tout_expired(sk)) {
+		mptcp_do_fastclose(sk);
+		mptcp_close_wake_up(sk);
+	}
 
-		if (sk->sk_state == TCP_CLOSE) {
-			__mptcp_destroy_sock(sk);
-			goto unlock;
-		}
+	if (sock_flag(sk, SOCK_DEAD) && sk->sk_state == TCP_CLOSE) {
+		__mptcp_destroy_sock(sk);
+		goto unlock;
 	}
 
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
@@ -2987,7 +2986,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 cleanup:
 	/* orphan all the subflows */
-	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
@@ -3024,7 +3022,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_tout_timer(msk, 0);
+		mptcp_start_tout_timer(sk);
 	}
 
 	return do_cancel_work;
@@ -3088,7 +3086,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_stop_tout_timer(sk);
 
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4e31b5cf48299..0a2d9d3df522e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -700,6 +700,28 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
 void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
+
+static inline void mptcp_stop_tout_timer(struct sock *sk)
+{
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
+		return;
+
+	sk_stop_timer(sk, &sk->sk_timer);
+	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
+}
+
+static inline void mptcp_set_close_tout(struct sock *sk, unsigned long tout)
+{
+	/* avoid 0 timestamp, as that means no close timeout */
+	inet_csk(sk)->icsk_mtup.probe_timestamp = tout ? : 1;
+}
+
+static inline void mptcp_start_tout_timer(struct sock *sk)
+{
+	mptcp_set_close_tout(sk, tcp_jiffies32);
+	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
+}
+
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0506d33177f3d..40ac67b854074 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1552,6 +1552,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	mptcp_stop_tout_timer(sk);
 	return 0;
 
 failed_unlink:
-- 
2.40.1



