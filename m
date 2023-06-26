Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EB73E7B4
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFZSRz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjFZSRy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C4E72
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D68060F21
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652E1C433C8;
        Mon, 26 Jun 2023 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803471;
        bh=owVyS5KbQN81B++Ee63EbD9iWu4QsnlJn7sP8qhdhdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRPDHw3HmisiO1oRXXYPuzmpVaYP0xgHPpFnqKbKTvXp2tyZ4Dqgpj00s71AJ+gf6
         8hxL2B4bilhY9SOmT1cUiw89D8LkPmyZjriXBUc5nASG+RaogDZXFbX3T2rFRur0qP
         u5OkVIPTBes4b68kE+915Oc5fSITu7NjrD3YrJbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 073/199] mptcp: consolidate fallback and non fallback state machine
Date:   Mon, 26 Jun 2023 20:09:39 +0200
Message-ID: <20230626180808.741437316@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   41 +++++++++++++++--------------------------
 net/mptcp/subflow.c  |   17 ++++++++++-------
 2 files changed, 25 insertions(+), 33 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -44,7 +44,7 @@ enum {
 static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_smp;
 
 static void __mptcp_destroy_sock(struct sock *sk);
-static void __mptcp_check_send_data_fin(struct sock *sk);
+static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -411,8 +411,7 @@ static bool mptcp_pending_data_fin_ack(s
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return !__mptcp_check_fallback(msk) &&
-	       ((1 << sk->sk_state) &
+	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
 	       msk->write_seq == READ_ONCE(msk->snd_una);
 }
@@ -570,9 +569,6 @@ static bool mptcp_check_data_fin(struct
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk))
-		return ret;
-
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
 	 * msk->rcv_data_fin was set when parsing the incoming options
@@ -610,7 +606,8 @@ static bool mptcp_check_data_fin(struct
 		}
 
 		ret = true;
-		mptcp_send_ack(msk);
+		if (!__mptcp_check_fallback(msk))
+			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -1596,7 +1593,7 @@ out:
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (do_check_data_fin)
-		__mptcp_check_send_data_fin(sk);
+		mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
@@ -2651,8 +2648,6 @@ static void mptcp_worker(struct work_str
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_check_data_fin_ack(sk);
-
 	mptcp_check_fastclose(msk);
 
 	mptcp_pm_nl_work(msk);
@@ -2660,7 +2655,8 @@ static void mptcp_worker(struct work_str
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
 
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
@@ -2803,6 +2799,12 @@ void mptcp_subflow_shutdown(struct sock
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
@@ -2842,7 +2844,7 @@ static int mptcp_close_state(struct sock
 	return next & TCP_ACTION_FIN;
 }
 
-static void __mptcp_check_send_data_fin(struct sock *sk)
+static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2860,19 +2862,6 @@ static void __mptcp_check_send_data_fin(
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
-	/* fallback socket will not get data_fin/ack, can move to the next
-	 * state now
-	 */
-	if (__mptcp_check_fallback(msk)) {
-		WRITE_ONCE(msk->snd_una, msk->write_seq);
-		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
-			mptcp_close_wake_up(sk);
-		} else if (sk->sk_state == TCP_FIN_WAIT1) {
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
-		}
-	}
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2892,7 +2881,7 @@ static void __mptcp_wr_shutdown(struct s
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_destroy_sock(struct sock *sk)
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1749,14 +1749,16 @@ static void subflow_state_change(struct
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
@@ -1772,11 +1774,12 @@ static void subflow_state_change(struct
 
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
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)


