Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F097ED328
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjKOUqr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjKOUqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31022130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38563C433C9;
        Wed, 15 Nov 2023 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081187;
        bh=f/SWgx8vmRVj+GIEEnzDoGnZXptUnen3eHgk9TFs25o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZC/Nq+5MQ85XMvQMGGsn0t2iRpVMn0aW6Ym7Yj+wnnZGnpp0ZqMk50aLauePxhELJ
         xDJpxPL8okSXvyp14tyF7C/tiAPIM6OSUdX0CGG5qGV7WkvNNSAYcErow7wkREkXvz
         ZuSJKZXmRwowmzkAg3c9nTDBmPTwht9EziGpLbbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 78/88] net/smc: postpone release of clcsock
Date:   Wed, 15 Nov 2023 15:36:30 -0500
Message-ID: <20231115191430.769764496@linuxfoundation.org>
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

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit b03faa1fafc8018295401dc558bdc76362d860a4 ]

According to RFC7609 (http://www.rfc-editor.org/info/rfc7609)
first the SMC-R connection is shut down and then the normal TCP
connection FIN processing drives cleanup of the internal TCP connection.
The unconditional release of the clcsock during active socket closing
has to be postponed if the peer has not yet signalled socket closing.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5211c9729484 ("net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/af_smc.c    | 33 +++++++++++++++++----------------
 net/smc/smc_close.c |  7 ++++++-
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index dcd00b514c3f9..6f342f6cc4876 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -143,32 +143,33 @@ static int smc_release(struct socket *sock)
 		rc = smc_close_active(smc);
 		sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
-	}
-
-	sk->sk_prot->unhash(sk);
-
-	if (smc->clcsock) {
-		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
+	} else {
+		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
+			sock_put(sk); /* passive closing */
+		if (sk->sk_state == SMC_LISTEN) {
 			/* wake up clcsock accept */
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
 		}
-		mutex_lock(&smc->clcsock_release_lock);
-		sock_release(smc->clcsock);
-		smc->clcsock = NULL;
-		mutex_unlock(&smc->clcsock_release_lock);
-	}
-	if (smc->use_fallback) {
-		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
-			sock_put(sk); /* passive closing */
 		sk->sk_state = SMC_CLOSED;
 		sk->sk_state_change(sk);
 	}
 
+	sk->sk_prot->unhash(sk);
+
+	if (sk->sk_state == SMC_CLOSED) {
+		if (smc->clcsock) {
+			mutex_lock(&smc->clcsock_release_lock);
+			sock_release(smc->clcsock);
+			smc->clcsock = NULL;
+			mutex_unlock(&smc->clcsock_release_lock);
+		}
+		if (!smc->use_fallback)
+			smc_conn_free(&smc->conn);
+	}
+
 	/* detach socket */
 	sock_orphan(sk);
 	sock->sk = NULL;
-	if (!smc->use_fallback && sk->sk_state == SMC_CLOSED)
-		smc_conn_free(&smc->conn);
 	release_sock(sk);
 
 	sock_put(sk); /* final sock_put */
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 092696d738c00..3e7858793d485 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -415,8 +415,13 @@ static void smc_close_passive_work(struct work_struct *work)
 	if (old_state != sk->sk_state) {
 		sk->sk_state_change(sk);
 		if ((sk->sk_state == SMC_CLOSED) &&
-		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket))
+		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
 			smc_conn_free(conn);
+			if (smc->clcsock) {
+				sock_release(smc->clcsock);
+				smc->clcsock = NULL;
+			}
+		}
 	}
 	release_sock(sk);
 	sock_put(sk); /* sock_hold done by schedulers of close_work */
-- 
2.42.0



