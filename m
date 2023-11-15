Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2977ED329
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKOUqr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjKOUqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED019D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7DC433C8;
        Wed, 15 Nov 2023 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081188;
        bh=mGArqo7pK38Twhafrd1USJ8tq4vdrWCzrcs4wbDzttc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsGTq6DpJI0frpH3IxHk8JLmoGmKSgDA0V6udC1/rzh+mXmIXiUH46KSNMFhZj0YT
         rVmjilQNE+XajGtSf6Od51j27YDNnESgW2X8+yWYJxwYZxGQUmmt/RBwL0VIjpUKdf
         sLJufCwhJ8k3TiyIbNeJRWsT2bg7mk1stMW4esdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 79/88] net/smc: wait for pending work before clcsock release_sock
Date:   Wed, 15 Nov 2023 15:36:31 -0500
Message-ID: <20231115191430.830506616@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit fd57770dd198f5b2ddd5b9e6bf282cf98d63adb9 ]

When the clcsock is already released using sock_release() and a pending
smc_listen_work accesses the clcsock than that will fail. Solve this
by canceling and waiting for the work to complete first. Because the
work holds the sock_lock it must make sure that the lock is not hold
before the new helper smc_clcsock_release() is invoked. And before the
smc_listen_work starts working check if the parent listen socket is
still valid, otherwise stop the work early.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5211c9729484 ("net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/af_smc.c    | 14 ++++++++------
 net/smc/smc_close.c | 25 +++++++++++++++++++++----
 net/smc/smc_close.h |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6f342f6cc4876..6b30bec54b624 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -158,10 +158,9 @@ static int smc_release(struct socket *sock)
 
 	if (sk->sk_state == SMC_CLOSED) {
 		if (smc->clcsock) {
-			mutex_lock(&smc->clcsock_release_lock);
-			sock_release(smc->clcsock);
-			smc->clcsock = NULL;
-			mutex_unlock(&smc->clcsock_release_lock);
+			release_sock(sk);
+			smc_clcsock_release(smc);
+			lock_sock(sk);
 		}
 		if (!smc->use_fallback)
 			smc_conn_free(&smc->conn);
@@ -1014,13 +1013,13 @@ static void smc_listen_out(struct smc_sock *new_smc)
 	struct smc_sock *lsmc = new_smc->listen_smc;
 	struct sock *newsmcsk = &new_smc->sk;
 
-	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
+		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
+		release_sock(&lsmc->sk);
 	} else { /* no longer listening */
 		smc_close_non_accepted(newsmcsk);
 	}
-	release_sock(&lsmc->sk);
 
 	/* Wake up accept */
 	lsmc->sk.sk_data_ready(&lsmc->sk);
@@ -1216,6 +1215,9 @@ static void smc_listen_work(struct work_struct *work)
 	int rc = 0;
 	u8 ibport;
 
+	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
+		return smc_listen_out_err(new_smc);
+
 	if (new_smc->use_fallback) {
 		smc_listen_out_connected(new_smc);
 		return;
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 3e7858793d485..cac0773f5ebd9 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -21,6 +21,22 @@
 
 #define SMC_CLOSE_WAIT_LISTEN_CLCSOCK_TIME	(5 * HZ)
 
+/* release the clcsock that is assigned to the smc_sock */
+void smc_clcsock_release(struct smc_sock *smc)
+{
+	struct socket *tcp;
+
+	if (smc->listen_smc && current_work() != &smc->smc_listen_work)
+		cancel_work_sync(&smc->smc_listen_work);
+	mutex_lock(&smc->clcsock_release_lock);
+	if (smc->clcsock) {
+		tcp = smc->clcsock;
+		smc->clcsock = NULL;
+		sock_release(tcp);
+	}
+	mutex_unlock(&smc->clcsock_release_lock);
+}
+
 static void smc_close_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
@@ -331,6 +347,7 @@ static void smc_close_passive_work(struct work_struct *work)
 						   close_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	struct smc_cdc_conn_state_flags *rxflags;
+	bool release_clcsock = false;
 	struct sock *sk = &smc->sk;
 	int old_state;
 
@@ -417,13 +434,13 @@ static void smc_close_passive_work(struct work_struct *work)
 		if ((sk->sk_state == SMC_CLOSED) &&
 		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
 			smc_conn_free(conn);
-			if (smc->clcsock) {
-				sock_release(smc->clcsock);
-				smc->clcsock = NULL;
-			}
+			if (smc->clcsock)
+				release_clcsock = true;
 		}
 	}
 	release_sock(sk);
+	if (release_clcsock)
+		smc_clcsock_release(smc);
 	sock_put(sk); /* sock_hold done by schedulers of close_work */
 }
 
diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index 19eb6a211c23c..e0e3b5df25d24 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -23,5 +23,6 @@ void smc_close_wake_tx_prepared(struct smc_sock *smc);
 int smc_close_active(struct smc_sock *smc);
 int smc_close_shutdown_write(struct smc_sock *smc);
 void smc_close_init(struct smc_sock *smc);
+void smc_clcsock_release(struct smc_sock *smc);
 
 #endif /* SMC_CLOSE_H */
-- 
2.42.0



