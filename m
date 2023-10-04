Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8D7B81B5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbjJDOEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbjJDOEx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:04:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F0D9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:04:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EF2C433C8;
        Wed,  4 Oct 2023 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696428289;
        bh=MXVRJxW0sZA7hQym2ffWQpNYaj6s6PsiE0Sn/SDmbYs=;
        h=Subject:To:Cc:From:Date:From;
        b=L1w6ii3qHyXkjCIhDperccDtgNsb9Y3lk6vOCBvfSYmjvrAUz2SKkxmBrupOHFs/v
         FQzqc5pP2Izi43SRu+dXkyP12yvrHFTUnmltF+q5AeaN6S/fkC+oZfoEDNhNYOJoNg
         HsmeK9lXrFHyIACt3WoFQotS78LZOoOfn/FXlcQk=
Subject: FAILED: patch "[PATCH] mptcp: process pending subflow error on close" failed to apply to 6.1-stable tree
To:     pabeni@redhat.com, davem@davemloft.net, martineau@kernel.org,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:04:46 +0200
Message-ID: <2023100446-wasp-granny-2378@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1a98813b4b686482e5ef3c9d998581cace0ba6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100446-wasp-granny-2378@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f1a98813b4b686482e5ef3c9d998581cace0ba6 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 16 Sep 2023 12:52:47 +0200
Subject: [PATCH] mptcp: process pending subflow error on close

On incoming TCP reset, subflow closing could happen before error
propagation. That in turn could cause the socket error being ignored,
and a missing socket state transition, as reported by Daire-Byrne.

Address the issues explicitly checking for subflow socket error at
close time. To avoid code duplication, factor-out of __mptcp_error_report()
a new helper implementing the relevant bits.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/429
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 915860027b1a..1c96b8da71df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -770,40 +770,44 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
+{
+	int err = sock_error(ssk);
+	int ssk_state;
+
+	if (!err)
+		return false;
+
+	/* only propagate errors on fallen-back sockets or
+	 * on MPC connect
+	 */
+	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
+		return false;
+
+	/* We need to propagate only transition to CLOSE state.
+	 * Orphaned socket will see such state change via
+	 * subflow_sched_work_if_closed() and that path will properly
+	 * destroy the msk as needed.
+	 */
+	ssk_state = inet_sk_state_load(ssk);
+	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+		inet_sk_state_store(sk, ssk_state);
+	WRITE_ONCE(sk->sk_err, -err);
+
+	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+	smp_wmb();
+	sk_error_report(sk);
+	return true;
+}
+
 void __mptcp_error_report(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
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
+	mptcp_for_each_subflow(msk, subflow)
+		if (__mptcp_subflow_error_report(sk, mptcp_subflow_tcp_sock(subflow)))
+			break;
 }
 
 /* In most cases we will be able to lock the mptcp socket.  If its already
@@ -2428,6 +2432,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	}
 
 out_release:
+	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
 	sock_put(ssk);

