Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1347BA7E6
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjJERYd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjJERXv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 13:23:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B2E1B6
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 10:18:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BF2C433C8;
        Thu,  5 Oct 2023 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526315;
        bh=tMlToK1spTwANyFl64owqd/LY8i5Dk+TtKHGdJx+1KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ID8ylC66Y+XWuYbqOvqfAWT785nbKZKckU3Cro80IVhTx5/UMN1ltcJ1iZ77A8iRH
         sYOznPQ+DFemlcWjzGziGaqDBFggWOMnNnKWsjs6VpS/L7GcqwV7XVcKa0ZrOrTHYH
         r9xe0DB1llz0cZ63sUXMdz7/RGpmzT0XmtPUkLOXr/IkKUVzPZuH5QyXAqY95qB3/N
         2DzftSlu+KmuGlLnhz2kSd7yaj8QLk0wWjfB3XEgN/q/l6x6z5lVYcsqeX7dMNiDpk
         GjtVjGTLqLb5yVzG2Uk8B5/tsPCjTHMio8xH4gFAcatPJt1aGKiO9W0Bh1hIyt62tc
         7e0uwefV4e8MQ==
From:   matttbe@kernel.org
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.5.y] mptcp: rename timer related helper to less confusing names
Date:   Thu,  5 Oct 2023 19:18:13 +0200
Message-Id: <20231005171813.1831910-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023100400-example-ashen-2013@gregkh>
References: <2023100400-example-ashen-2013@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7082; i=matttbe@kernel.org; h=from:subject; bh=iP/M25+7srqBSQhlATuvqwDsFxNqep/eQikJ2lNc4SY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlHu/V6OSKt3lDO0Unrft07anSZ+3zQzzK93uk7 P1iwVMMVsuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZR7v1QAKCRD2t4JPQmmg cxRfEADCNT9z2uZUkh0HrN9wF3L7waQ8VpgZKSNW2I2y9FryzmeEc6Oca8BGkip3q7qSbHx5XV8 YaviRDiSHXj5ZfDi4MTIV24B6jL7/oT3Q9hbCecE3GIn5SSl9ERm5WWJHhJD1LV89bKcJzPpJLE gL+4k7UpMG60IWbkD/AOS7jOZdP1fJxpTtlSi6gTqO7TZnweuL3H8utV0AbtNTlKK3d8vmZ4wGQ jJMlQtj+uoueeldg2GgZzg9WyfSkQuT2t6fKzOxvdrW/dgs4tgTMYM933XyoAU61+92aAAkBqlH 642X+VAm7qdZ7xEXnQg/debNrguEL67XTBi9GptZogb6/cbvk0UEZyCD/gNzqrTIKb6c6kaUowU 1ig28PS/5NiIS2Nm3OaDd8wKizf/Wsz3IYcdasrTBZpxi4NSaAJ0OCg8ExGXNGCfcz+/JqUbHSH z2ZHdpNbx/3xfmwl8trJI9gE9yyVP3P+jkiuH5l9u+SbJd7XbM9dwFaFKfHLG9wIen+A40rpkpj GELTvsP004yM3MAX6UYN+pv8z3m/bUv5iiDOnQTO3GUxnkn2OxFt3ZB2VJkIjxzIWM82XXKfIv5 ScDcVWjXgQl+5ttuTELeqrvLMstMIvnPo/qoYxax+xs/kMjWxeYT4P2nRS6+okBNGYgcowrxsFa KwOSdEB9uSh4PrQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit f6909dc1c1f4452879278128012da6c76bc186a5 upstream.

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
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Backport notes:
  - It was conflicting with e263691773cd ("mptcp: Remove unnecessary
    test for __mptcp_init_sock()") removing code (return) in the same
    context.
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6947b4b2519c..450b106eb088 100644
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
@@ -2736,7 +2736,7 @@ static int __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 
 	return 0;
 }
@@ -2826,8 +2826,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
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
@@ -2910,7 +2910,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 
@@ -3029,7 +3029,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_timeout(msk, 0);
+		mptcp_reset_tout_timer(msk, 0);
 	}
 
 	return do_cancel_work;
@@ -3092,7 +3092,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
 	if (msk->token)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba2a873a4d2e..4e31b5cf4829 100644
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
index c7bd99b8e7b7..0506d33177f3 100644
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

