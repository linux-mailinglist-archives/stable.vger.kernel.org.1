Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9A746313
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGCS50 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGCS5Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA28DE76
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E8861015
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B84C433C8;
        Mon,  3 Jul 2023 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410642;
        bh=cpJZEsQMdqQHkbjouKTadWuOH6KX38Cgcyv6Sn/HRj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8Qeu3du8oxl9LBQpqLZdSDvsSoYZLQf7rlsoTwdmEKLeyPd3zNbboXMKcwrUJ2pv
         Ei5JJYp/Wsbz+nboY2KxLLnP48sSw84OMtqXA7tAGhO7rbW7Ng8Hd2xIjVshwLgL0x
         74V+HqFCShyRjGswP4qNj2b5K2UdofGI5xneMcOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 02/15] mptcp: consolidate fallback and non fallback state machine
Date:   Mon,  3 Jul 2023 20:54:47 +0200
Message-ID: <20230703184518.962554478@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184518.896751186@linuxfoundation.org>
References: <20230703184518.896751186@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 net/mptcp/protocol.c |   39 +++++++++++++++------------------------
 net/mptcp/subflow.c  |   17 ++++++++++-------
 2 files changed, 25 insertions(+), 31 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -51,7 +51,7 @@ enum {
 static struct percpu_counter mptcp_sockets_allocated;
 
 static void __mptcp_destroy_sock(struct sock *sk);
-static void __mptcp_check_send_data_fin(struct sock *sk);
+static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -355,8 +355,7 @@ static bool mptcp_pending_data_fin_ack(s
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return !__mptcp_check_fallback(msk) &&
-	       ((1 << sk->sk_state) &
+	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
 	       msk->write_seq == READ_ONCE(msk->snd_una);
 }
@@ -509,9 +508,6 @@ static bool mptcp_check_data_fin(struct
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk))
-		return ret;
-
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
 	 * msk->rcv_data_fin was set when parsing the incoming options
@@ -549,7 +545,8 @@ static bool mptcp_check_data_fin(struct
 		}
 
 		ret = true;
-		mptcp_send_ack(msk);
+		if (!__mptcp_check_fallback(msk))
+			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -1612,7 +1609,7 @@ out:
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (copied)
-		__mptcp_check_send_data_fin(sk);
+		mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
@@ -2451,7 +2448,6 @@ static void mptcp_worker(struct work_str
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_check_data_fin_ack(sk);
 	mptcp_flush_join_list(msk);
 
 	mptcp_check_fastclose(msk);
@@ -2462,7 +2458,8 @@ static void mptcp_worker(struct work_str
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
 
 	/* There is no point in keeping around an orphaned sk timedout or
@@ -2591,6 +2588,12 @@ void mptcp_subflow_shutdown(struct sock
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
@@ -2630,7 +2633,7 @@ static int mptcp_close_state(struct sock
 	return next & TCP_ACTION_FIN;
 }
 
-static void __mptcp_check_send_data_fin(struct sock *sk)
+static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2648,18 +2651,6 @@ static void __mptcp_check_send_data_fin(
 
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
@@ -2680,7 +2671,7 @@ static void __mptcp_wr_shutdown(struct s
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_destroy_sock(struct sock *sk)
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1653,14 +1653,16 @@ static void subflow_state_change(struct
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
@@ -1676,11 +1678,12 @@ static void subflow_state_change(struct
 
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


