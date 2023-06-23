Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F373B39E
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFWJbX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjFWJbV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F2010D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7963C619F4
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85718C433C0;
        Fri, 23 Jun 2023 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512678;
        bh=AjnOiYRP8+OGSoTqRGZifzlfX5P8idfIRG/D4OPZ70w=;
        h=Subject:To:Cc:From:Date:From;
        b=xgFw8fJoi52aFAQ7AooLS4Kj4SjVbKd/zBTBOP9qEx0i73JgceQeX5Q2g5H9jor79
         Un9xfad3rXpRip2zT3hKmGhHRps41z1mt+Vjw7qshErLzOEJfP9MYq1yVgLA3tbIjz
         SCPSSc2kF+Ik3BjijIsICV11EoTUq0QkpoHUL/NM=
Subject: FAILED: patch "[PATCH] mptcp: consolidate fallback and non fallback state machine" failed to apply to 5.15-stable tree
To:     pabeni@redhat.com, kuba@kernel.org, martineau@kernel.org,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:31:16 +0200
Message-ID: <2023062315-example-anger-442b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 81c1d029016001f994ce1c46849c5e9900d8eab8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062315-example-anger-442b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81c1d029016001f994ce1c46849c5e9900d8eab8 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Jun 2023 18:24:21 +0200
Subject: [PATCH] mptcp: consolidate fallback and non fallback state machine

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

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a40dae31cec..27d206f7af62 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -44,7 +44,7 @@ enum {
 static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_smp;
 
 static void __mptcp_destroy_sock(struct sock *sk);
-static void __mptcp_check_send_data_fin(struct sock *sk);
+static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -424,8 +424,7 @@ static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return !__mptcp_check_fallback(msk) &&
-	       ((1 << sk->sk_state) &
+	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
 	       msk->write_seq == READ_ONCE(msk->snd_una);
 }
@@ -583,9 +582,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk))
-		return ret;
-
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
 	 * msk->rcv_data_fin was set when parsing the incoming options
@@ -623,7 +619,8 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		}
 
 		ret = true;
-		mptcp_send_ack(msk);
+		if (!__mptcp_check_fallback(msk))
+			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -1609,7 +1606,7 @@ out:
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (do_check_data_fin)
-		__mptcp_check_send_data_fin(sk);
+		mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
@@ -2680,8 +2677,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_check_data_fin_ack(sk);
-
 	mptcp_check_fastclose(msk);
 
 	mptcp_pm_nl_work(msk);
@@ -2689,7 +2684,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
 
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
@@ -2828,6 +2824,12 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
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
@@ -2867,7 +2869,7 @@ static int mptcp_close_state(struct sock *sk)
 	return next & TCP_ACTION_FIN;
 }
 
-static void __mptcp_check_send_data_fin(struct sock *sk)
+static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2885,19 +2887,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 
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
 
@@ -2917,7 +2906,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_destroy_sock(struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4688daa6b38b..d9c8b21c6076 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1749,14 +1749,16 @@ static void subflow_state_change(struct sock *sk)
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
@@ -1772,11 +1774,12 @@ static void subflow_state_change(struct sock *sk)
 
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

