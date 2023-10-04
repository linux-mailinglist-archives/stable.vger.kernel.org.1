Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B07B81BB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbjJDOFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbjJDOFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:05:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2634CE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:05:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E666CC433C7;
        Wed,  4 Oct 2023 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696428315;
        bh=5vBRk850wk2s/rXB743e6dUtLdayd+5qfi5x0MVsD1g=;
        h=Subject:To:Cc:From:Date:From;
        b=k+HfaoUOA//WOafRjwFdv8YRjijiq4oxXZ4cct3lIq3d3D/NqVr3mzuCanaRHToSJ
         LFQifWcHEElKnZwQs8okMGI3lgbcPiPuwOWMn9kypHGeCEAkujMVV92otcyUfoHXkC
         Bh5Rg9ngsEcW2G2JsNvK7NygIEMQKYFuDWx3z1Nk=
Subject: FAILED: patch "[PATCH] mptcp: rename timer related helper to less confusing names" failed to apply to 5.15-stable tree
To:     pabeni@redhat.com, davem@davemloft.net, martineau@kernel.org,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:05:02 +0200
Message-ID: <2023100402-launder-percent-3d59@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f6909dc1c1f4452879278128012da6c76bc186a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100402-launder-percent-3d59@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6909dc1c1f4452879278128012da6c76bc186a5 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 16 Sep 2023 12:52:48 +0200
Subject: [PATCH] mptcp: rename timer related helper to less confusing names

The msk socket uses to different timeout to track close related
events and retransmissions. The existing helpers do not indicate
clearly which timer they actually touch, making the related code
quite confusing.

Change the existing helpers name to avoid such confusion. No
functional change intended.

This patch is linked to the next one ("mptcp: fix dangling connection
hang-up"). The two patches are supposed to be backported together.

Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c96b8da71df..c8f38f303a90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -405,7 +405,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	return false;
 }
 
-static void mptcp_stop_timer(struct sock *sk)
+static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -911,12 +911,12 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
 	}
 }
 
-static bool mptcp_timer_pending(struct sock *sk)
+static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
 }
 
-static void mptcp_reset_timer(struct sock *sk)
+static void mptcp_reset_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
@@ -1050,10 +1050,10 @@ static void __mptcp_clean_una(struct sock *sk)
 out:
 	if (snd_una == READ_ONCE(msk->snd_nxt) &&
 	    snd_una == READ_ONCE(msk->write_seq)) {
-		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
-			mptcp_stop_timer(sk);
+		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
+			mptcp_stop_rtx_timer(sk);
 	} else {
-		mptcp_reset_timer(sk);
+		mptcp_reset_rtx_timer(sk);
 	}
 }
 
@@ -1626,8 +1626,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_push_release(ssk, &info);
 
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 	if (do_check_data_fin)
 		mptcp_check_send_data_fin(sk);
 }
@@ -1690,8 +1690,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
@@ -2260,7 +2260,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
-static void mptcp_timeout_timer(struct timer_list *t)
+static void mptcp_tout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
@@ -2629,14 +2629,14 @@ static void __mptcp_retrans(struct sock *sk)
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 }
 
 /* schedule the timeout timer for the relevant event: either close timeout
  * or mp_fail timeout. The close timeout takes precedence on the mp_fail one
  */
-void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
+void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 {
 	struct sock *sk = (struct sock *)msk;
 	unsigned long timeout, close_timeout;
@@ -2669,7 +2669,7 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
 
-	mptcp_reset_timeout(msk, 0);
+	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2758,7 +2758,7 @@ static void __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -2849,8 +2849,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
-			if (!mptcp_timer_pending(sk))
-				mptcp_reset_timer(sk);
+			if (!mptcp_rtx_timer_pending(sk))
+				mptcp_reset_rtx_timer(sk);
 		}
 		break;
 	}
@@ -2933,7 +2933,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
@@ -3053,7 +3053,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_timeout(msk, 0);
+		mptcp_reset_tout_timer(msk, 0);
 	}
 
 	return do_cancel_work;
@@ -3116,7 +3116,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
 	if (msk->token)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7254b3562575..5e2026815c8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,7 +718,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
-void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout);
+void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2f40c23fdb0d..433f290984c8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1226,7 +1226,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(subflow->fail_tout, fail_tout);
 	tcp_send_ack(ssk);
 
-	mptcp_reset_timeout(msk, subflow->fail_tout);
+	mptcp_reset_tout_timer(msk, subflow->fail_tout);
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)

