Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EEC73FCD6
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjF0N0a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjF0N0Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 09:26:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4B1701
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:26:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbab489490so1055865e9.1
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687872381; x=1690464381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWlBhUNVT62cj3h3kz4dSaxFhqxE88dlbopTjdtTfdA=;
        b=dLrXRomIKk0YuOvJ54+iWW2GZQhsJkQDaGrbSeMMZUyQd4nDscYN+9D3FG1z+9EJUf
         NaftCu41Us4Pje9t9+/CQfEY6zHEGHjMCTx/ItyXiNvuxs/m6/FgypWgEs/hAF8uGNpE
         ND2a6t5rB0iUe17NIXAMupdLF/6Y3BzUMf0Ro8bNhCfbS5uidNIf/PHukatunzTzLltT
         8LRfeku+aE0yqz2mrmx8oGKiYfYDbZ6wuknSN2un1BsqarPHIX/ANoRVBP9QVlwfqOkQ
         yY5K3zjQwIxSpXQ91y7mUNUh6i4TtSWfN782JFfBd4yE44282LjMITXbyM7wxtoSg5rJ
         5dCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872381; x=1690464381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWlBhUNVT62cj3h3kz4dSaxFhqxE88dlbopTjdtTfdA=;
        b=XHya5fj+y1tMztyB/Ag5+yu0cTxPX2YPr4HGSUPCHyzmE95KbEA+sjOEfTjh48IrT6
         poXGKwnzFP5iVsDYko5fUG0BRWRqVF93SIONUju7U+ZAziXWugx6bLsBDHLb4XweeFYU
         shujyIE/0pBexhCfV4bhR3JU2gpFNFs11Dw0GiPZuOcEESVbUwGJjsFfyQPlmhQtQAUq
         nFXmvaFV7fCAGqyM3W/Q7mF8Lo29SKjHQ1NkyTPE+2Xcu5BGkM3sCl8hFEupYryhwtSc
         YlgvFvD5cCVe8mBr7HQmMTr6KdtTd0dCkMv1lPSY+vzviOvtFSVyNWoHhhaHshEV+lpX
         joGw==
X-Gm-Message-State: AC+VfDysaacYHrmIhZUkGftWplaNAv1aJut/O3wzFCnLEtC20s+VtPb/
        Jip5qAAJCqb3foWQ5EGwSPiky2NGjtzJsBFafdDy+Q==
X-Google-Smtp-Source: ACHHUZ7GKlCvvYbowKiVm1KrhiBE7UVnJFVzGeXZxvlDT3BJlGw/ePnXgYC/lPNfWFcOCd96vDVwPQ==
X-Received: by 2002:a7b:c045:0:b0:3f7:b1dd:9553 with SMTP id u5-20020a7bc045000000b003f7b1dd9553mr24245964wmc.14.1687872381267;
        Tue, 27 Jun 2023 06:26:21 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fa95890484sm6304157wml.20.2023.06.27.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:26:21 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: consolidate fallback and non fallback state machine
Date:   Tue, 27 Jun 2023 15:25:57 +0200
Message-Id: <20230627132557.2266416-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062315-example-anger-442b@gregkh>
References: <2023062315-example-anger-442b@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7638; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=CN96ELKGRjLa4KJ0CNGYUqfWNPaG8acjQiaOCFGc8hU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkmuNl2gd4hyBlRvMotsfK7QADV4n/T7Fes30pB
 kDAG9y2vMuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJrjZQAKCRD2t4JPQmmg
 c18YEADEEmtE+TPkIp3wxmTnQ5LTAktWsNhnxm7+7lv4iE7JfFMTRHHPd3lT2jPgQ5hxiLvFn/V
 wY7XQO8X5g8hakyqLDJ+Nm0sXtCuNxL9cBRKZnwpuuGXo6y9qaTww86CEbVzaagdZ/q4Jmh9muI
 iMXIKtglFZSLF3TiE4A7/XzLEcumbW3gN3JMRC5vEV64x2kyOz6VkVcYbBG0GPUiyxfTKUNCqhZ
 veTaJDIdQCVU6fbIfpJ7D8F6sNrkAkJGpOxFh6LxQBdjnr2iJXA/hXtMNlcHnxEPHtyBj3ufv3F
 rqYWwohkfDiXBfw2cDJaNR/yTxrTS9e9C8lmgAI7FVhRLMMKTVuWIap6YxNyrujdreC7MxvcINy
 EPYtbKetRm2LYcBGNyhCmAYzTzoeIy6tkQZ9xBeV/4iXoFUTy3S7cbNZLsYJdLeEhqVc/ZNRe0R
 j++H9LYhLARUtSIYZfysYrYvcS3ME4pgcPR3HSkJePdAxQ+fFcn3k6/eDLTTMLaMEbtmhAeun5k
 QX30v0phmhC7JQ9nT46v6Sf5j1YdJ494cy2KU/bLL3y3XdKRh5Wy2hPtnUNrcYjmY+DJ1vFyyPe
 SirvKtW1e+HsaS7wQuTmRYCtrP4VV7kqOR3/SrBfPqulVOCbCPDi463k5n7otCQPFIkpNOdH4NV vAcYK14c48nl5JQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 81c1d029016001f994ce1c46849c5e9900d8eab8 upstream.

An orphaned msk releases the used resources via the worker,
when the latter first see the msk in CLOSED status.

If the msk status transitions to TCP_CLOSE in the release callback
invoked by the worker's final release_sock(), such instance of the
workqueue will not take any action.

Additionally the MPTCP code prevents scheduling the worker once the
socket reaches the CLOSE status: such msk resources will be leaked.

The only code path that can trigger the above scenario is the
__mptcp_check_send_data_fin() in fallback mode.

Address the issue removing the special handling of fallback socket
in __mptcp_check_send_data_fin(), consolidating the state machine
for fallback and non fallback socket.

Since non-fallback sockets do not send and do not receive data_fin,
the mptcp code can update the msk internal status to match the next
step in the SM every time data fin (ack) should be generated or
received.

As a consequence we can remove a bunch of checks for fallback from
the fastpath.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Conflicting with:
- 0522b424c4c2 ("mptcp: add do_check_data_fin to replace copied")
- 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")

I took the new modifications but leaving the old variable name for
"copied" instead of "do_check_data_fin" and the calls to
__mptcp_flush_join_list()

Applied on top of d2efde0d1c2e ("Linux 5.15.119-rc1").

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 39 +++++++++++++++------------------------
 net/mptcp/subflow.c  | 17 ++++++++++-------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2977201f8fa..82b1583f709d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -51,7 +51,7 @@ enum {
 static struct percpu_counter mptcp_sockets_allocated;
 
 static void __mptcp_destroy_sock(struct sock *sk);
-static void __mptcp_check_send_data_fin(struct sock *sk);
+static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -355,8 +355,7 @@ static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return !__mptcp_check_fallback(msk) &&
-	       ((1 << sk->sk_state) &
+	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
 	       msk->write_seq == READ_ONCE(msk->snd_una);
 }
@@ -509,9 +508,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk))
-		return ret;
-
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
 	 * msk->rcv_data_fin was set when parsing the incoming options
@@ -549,7 +545,8 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		}
 
 		ret = true;
-		mptcp_send_ack(msk);
+		if (!__mptcp_check_fallback(msk))
+			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -1612,7 +1609,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (copied)
-		__mptcp_check_send_data_fin(sk);
+		mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
@@ -2451,7 +2448,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_check_data_fin_ack(sk);
 	mptcp_flush_join_list(msk);
 
 	mptcp_check_fastclose(msk);
@@ -2462,7 +2458,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
 
 	/* There is no point in keeping around an orphaned sk timedout or
@@ -2591,6 +2588,12 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			pr_debug("Fallback");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
+
+			/* simulate the data_fin ack reception to let the state
+			 * machine move forward
+			 */
+			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
+			mptcp_schedule_work(sk);
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
@@ -2630,7 +2633,7 @@ static int mptcp_close_state(struct sock *sk)
 	return next & TCP_ACTION_FIN;
 }
 
-static void __mptcp_check_send_data_fin(struct sock *sk)
+static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2648,18 +2651,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
-	/* fallback socket will not get data_fin/ack, can move to the next
-	 * state now
-	 */
-	if (__mptcp_check_fallback(msk)) {
-		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
-			mptcp_close_wake_up(sk);
-		} else if (sk->sk_state == TCP_FIN_WAIT1) {
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
-		}
-	}
-
 	mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
@@ -2680,7 +2671,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_destroy_sock(struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9b89999062c9..666f6720db76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1653,14 +1653,16 @@ static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
+	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
+	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
-		mptcp_rcv_space_init(mptcp_sk(parent), sk);
-		pr_fallback(mptcp_sk(parent));
+		mptcp_rcv_space_init(msk, sk);
+		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_set_connected(parent);
 	}
@@ -1676,11 +1678,12 @@ static void subflow_state_change(struct sock *sk)
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
-	    !subflow->rx_eof && subflow_is_done(sk)) {
-		subflow->rx_eof = 1;
-		mptcp_subflow_eof(parent);
-	}
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+		mptcp_schedule_work(parent);
 }
 
 static int subflow_ulp_init(struct sock *sk)
-- 
2.40.1

