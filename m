Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFE7BDE15
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbjJINPm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376880AbjJINPl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:15:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEF9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:15:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D86C433CA;
        Mon,  9 Oct 2023 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857337;
        bh=R2Me6Z53dBWYTWVQLz/mw4BQ4gthC++NgqVEM4jtBV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyLhbn3rXqxBppWibPQcw1AonzfFx/9RKiYGRwMxLTHUixiumfGARjtOIL4iVjW7x
         EUr7VnLeBXDZluNeGnunQoIETste1nD9wkFBTbrtb0wFmP/IsPjBqSdYkRMLCb01Tv
         LHSFVGcsG/oYB0FC7REtgbpIYJ239bh6SvbDGxm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/162] mptcp: move __mptcp_error_report in protocol.c
Date:   Mon,  9 Oct 2023 14:59:54 +0200
Message-ID: <20231009130123.315839116@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit d5fbeff1ab812b6c473b6924bee8748469462e2c ]

This will simplify the next patch ("mptcp: process pending subflow error
on close").

No functional change intended.

Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84f107854eac9..193f2bdc8fe1b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -765,6 +765,42 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
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
index 032661c8273f2..b93b08a75017b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1305,42 +1305,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = tcp_full_space(sk);
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
-- 
2.40.1



