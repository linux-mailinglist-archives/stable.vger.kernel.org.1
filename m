Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916A77BDD3E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376734AbjJINIv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376748AbjJINIt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D79D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD25C433C8;
        Mon,  9 Oct 2023 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856925;
        bh=12eWUA1S8vmKDS2isfhP9Rjt6edTUaGMIHV8fV7wknc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTp+zK8ukL/A/hSRfzf70ie4Vd+xsar2sWhnp0TLdwWBqz6yBvPMZRvakScwqO7Ee
         SqUnQKtPk/jo6m5TrSExBf/8hWHJNyIvojUFpRgjXyK7/zG7uoNbCQN8Ci+6DtSeFy
         ueB6eiPEGNad3HVIdDS+lsq2BHdeIoW3UWaxZwNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 010/163] mptcp: rename timer related helper to less confusing names
Date:   Mon,  9 Oct 2023 14:59:34 +0200
Message-ID: <20231009130124.303404878@linuxfoundation.org>
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

[ Upstream commit f6909dc1c1f4452879278128012da6c76bc186a5 ]

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
Stable-dep-of: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0aae76f1465b8..3c85b4c107b2a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -407,7 +407,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	return false;
 }
 
-static void mptcp_stop_timer(struct sock *sk)
+static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -913,12 +913,12 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
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
@@ -1052,10 +1052,10 @@ static void __mptcp_clean_una(struct sock *sk)
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
 
@@ -1606,8 +1606,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 out:
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 	if (do_check_data_fin)
 		mptcp_check_send_data_fin(sk);
 }
@@ -1663,8 +1663,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
@@ -2235,7 +2235,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
-static void mptcp_timeout_timer(struct timer_list *t)
+static void mptcp_tout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
@@ -2607,14 +2607,14 @@ static void __mptcp_retrans(struct sock *sk)
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
@@ -2647,7 +2647,7 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
 
-	mptcp_reset_timeout(msk, 0);
+	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2736,7 +2736,7 @@ static void __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -2821,8 +2821,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
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
@@ -2905,7 +2905,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 
@@ -3024,7 +3024,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_timeout(msk, 0);
+		mptcp_reset_tout_timer(msk, 0);
 	}
 
 	return do_cancel_work;
@@ -3087,7 +3087,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
 	if (msk->token)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba2a873a4d2e6..4e31b5cf48299 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -699,7 +699,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
-void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout);
+void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7bd99b8e7b7a..0506d33177f3d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1226,7 +1226,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(subflow->fail_tout, fail_tout);
 	tcp_send_ack(ssk);
 
-	mptcp_reset_timeout(msk, subflow->fail_tout);
+	mptcp_reset_tout_timer(msk, subflow->fail_tout);
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
-- 
2.40.1



