Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775EC7ED387
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjKOUxP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjKOUxO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD2B7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC0CC4E778;
        Wed, 15 Nov 2023 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081591;
        bh=4fMpjqvjedOX2UHqJ4KzzAs3sBDw2c+D0IfE3l5N0cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgCaCQSbkEFjJeF0+VzxZBevPk9dkpRXCeWQSOq4wdXtGBEfVezFyK5zf5TxmBqfu
         9vd0YUkFk0kMR4filXGarFrEHKwYhHTc5ECF2MHkPG2O1RoBkR4fS8mb6YNy2ND6w6
         +zy3m4UYYvq8Rs4mrxVZoMAAY+W7jMSxGKvlnSYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 225/244] net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
Date:   Wed, 15 Nov 2023 15:36:57 -0500
Message-ID: <20231115203601.847839513@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: D. Wythe <alibuda@linux.alibaba.com>

[ Upstream commit 5211c9729484c923f8d2e06bd29f9322cc42bb8f ]

Considering scenario:

				smc_cdc_rx_handler
__smc_release
				sock_set_flag
smc_close_active()
sock_set_flag

__set_bit(DEAD)			__set_bit(DONE)

Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
in smc_close_passive_work:

if (sock_flag(sk, SOCK_DEAD) &&
	smc_close_sent_any_close(conn)) {
	sk->sk_state = SMC_CLOSED;
} else {
	/* just shutdown, but not yet closed locally */
	sk->sk_state = SMC_APPFINCLOSEWAIT;
}

Replace sock_set_flags or __set_bit to set_bit will fix this problem.
Since set_bit is atomic.

Fixes: b38d732477e4 ("smc: socket closing and linkgroup cleanup")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/af_smc.c    | 4 ++--
 net/smc/smc.h       | 5 +++++
 net/smc/smc_cdc.c   | 2 +-
 net/smc/smc_close.c | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9cdb7df0801f3..49cf523a783a2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -145,7 +145,7 @@ static int __smc_release(struct smc_sock *smc)
 
 	if (!smc->use_fallback) {
 		rc = smc_close_active(smc);
-		sock_set_flag(sk, SOCK_DEAD);
+		smc_sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	} else {
 		if (sk->sk_state != SMC_CLOSED) {
@@ -1334,7 +1334,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
-		sock_set_flag(new_sk, SOCK_DEAD);
+		smc_sock_set_flag(new_sk, SOCK_DEAD);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 930544f7b2e2c..57e376756b913 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -315,4 +315,9 @@ static inline bool using_ipsec(struct smc_sock *smc)
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
 void smc_close_non_accepted(struct sock *sk);
 
+static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
+{
+	set_bit(flag, &sk->sk_flags);
+}
+
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 41b23f71c29a2..0823961ec2e63 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -370,7 +370,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
 		if (smc->clcsock && smc->clcsock->sk)
 			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
-		sock_set_flag(&smc->sk, SOCK_DONE);
+		smc_sock_set_flag(&smc->sk, SOCK_DONE);
 		sock_hold(&smc->sk); /* sock_put in close_work */
 		if (!queue_work(smc_close_wq, &conn->close_work))
 			sock_put(&smc->sk);
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 149a59ecd299f..0790cac9ae3ee 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -170,7 +170,7 @@ void smc_close_active_abort(struct smc_sock *smc)
 		break;
 	}
 
-	sock_set_flag(sk, SOCK_DEAD);
+	smc_sock_set_flag(sk, SOCK_DEAD);
 	sk->sk_state_change(sk);
 
 	if (release_clcsock) {
-- 
2.42.0



