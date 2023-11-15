Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6017ED6F3
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjKOWEe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbjKOWEd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:04:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE691A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:04:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F404C433C7;
        Wed, 15 Nov 2023 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085869;
        bh=k34thhcKjO8ym9WUGSFrFhdGHJC1zxfjtt/Y5hhZSZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjMol86dshFYc0r8XVf/fcFt3a8yYEDcC3Yu+ZERDmGguwh/nbOszbRpmcO7C8dIQ
         wsCCllBGSRrCbT5p61XXja0sUAptFedk51tQxzwyvcbSbdcEZs1wfAqBy3KQvaWhZ0
         X7cOt/6dDeFAmaygpKn2h8ksVz0WyRe5w42z0pUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 107/119] net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
Date:   Wed, 15 Nov 2023 17:01:37 -0500
Message-ID: <20231115220135.968739928@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index b398d72a7bc39..e070b0e2a30c5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -136,7 +136,7 @@ static int __smc_release(struct smc_sock *smc)
 
 	if (!smc->use_fallback) {
 		rc = smc_close_active(smc);
-		sock_set_flag(sk, SOCK_DEAD);
+		smc_sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	} else {
 		if (sk->sk_state != SMC_CLOSED) {
@@ -928,7 +928,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
-		sock_set_flag(new_sk, SOCK_DEAD);
+		smc_sock_set_flag(new_sk, SOCK_DEAD);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 878313f8d6c17..8c46eaf014a75 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -265,4 +265,9 @@ static inline bool using_ipsec(struct smc_sock *smc)
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
 void smc_close_non_accepted(struct sock *sk);
 
+static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
+{
+	set_bit(flag, &sk->sk_flags);
+}
+
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index d0b0f4c865b40..68e1155126cf0 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -298,7 +298,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
 		if (smc->clcsock && smc->clcsock->sk)
 			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
-		sock_set_flag(&smc->sk, SOCK_DONE);
+		smc_sock_set_flag(&smc->sk, SOCK_DONE);
 		sock_hold(&smc->sk); /* sock_put in close_work */
 		if (!schedule_work(&conn->close_work))
 			sock_put(&smc->sk);
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 543948d970c52..a704234c1a2ba 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -164,7 +164,7 @@ static void smc_close_active_abort(struct smc_sock *smc)
 		break;
 	}
 
-	sock_set_flag(sk, SOCK_DEAD);
+	smc_sock_set_flag(sk, SOCK_DEAD);
 	sk->sk_state_change(sk);
 }
 
-- 
2.42.0



