Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4D7B81A9
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbjJDOEg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbjJDOEg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:04:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAADBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:04:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35A4C433C7;
        Wed,  4 Oct 2023 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696428272;
        bh=li95z31d248jbLwk3WHRvucNiLzcnr6ACCAm208hJCY=;
        h=Subject:To:Cc:From:Date:From;
        b=isSMXCvSglbJk89jMothPnjrrC4q1XMcKD0Wi79FkyUuLl2WTmUQyZoheWQRPMTuH
         CXmnEQNts7IA7hhNByuWHwhaa975U8p3sBBM8tD6FmVqShyvjCM6DnYVmVPgQ68inU
         gD4zIDtXJRKlRCqxbr2eIpsCP95iluT3TZDG3YHw=
Subject: FAILED: patch "[PATCH] mptcp: move __mptcp_error_report in protocol.c" failed to apply to 5.10-stable tree
To:     pabeni@redhat.com, davem@davemloft.net, martineau@kernel.org,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:04:22 +0200
Message-ID: <2023100421-earthly-entail-0945@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d5fbeff1ab812b6c473b6924bee8748469462e2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100421-earthly-entail-0945@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5fbeff1ab812b6c473b6924bee8748469462e2c Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 16 Sep 2023 12:52:46 +0200
Subject: [PATCH] mptcp: move __mptcp_error_report in protocol.c

This will simplify the next patch ("mptcp: process pending subflow error
on close").

No functional change intended.

Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a7fc16f5175d..915860027b1a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -770,6 +770,42 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err = sock_error(ssk);
+		int ssk_state;
+
+		if (!err)
+			continue;
+
+		/* only propagate errors on fallen-back sockets or
+		 * on MPC connect
+		 */
+		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
+			continue;
+
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			inet_sk_state_store(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+		break;
+	}
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9bf3c7bc1762..2f40c23fdb0d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1362,42 +1362,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
-void __mptcp_error_report(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
-}
-
 static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;

