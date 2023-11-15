Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F847ECFCE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjKOTu5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjKOTu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1222D1A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22885C433CA;
        Wed, 15 Nov 2023 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077852;
        bh=By93fAJnBR95+E+YIiTvos8n4TuBCp/MgOczEBrSpnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Ods1wnHzQgTlgs2gKA0OoVySWTnEt8B0A5lw0/d7R3x5d/waQ08q3KS61VwQvTot
         Butkk7LunkjA24LC3n+ASFuwfL45WZIVWXjrzGfkAxo9DSIb7Mac6PW3I4qMCjZRRr
         mRlgzY8jGBr46GGCO3a8BksREP6CdY2pFp9hAtDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 559/603] net/smc: put sk reference if close work was canceled
Date:   Wed, 15 Nov 2023 14:18:24 -0500
Message-ID: <20231115191650.332711290@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: D. Wythe <alibuda@linux.alibaba.com>

[ Upstream commit aa96fbd6d78d9770323b21e2c92bd38821be8852 ]

Note that we always hold a reference to sock when attempting
to submit close_work. Therefore, if we have successfully
canceled close_work from pending, we MUST release that reference
to avoid potential leaks.

Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD link groups")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_close.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 449ef454b53be..10219f55aad14 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct smc_sock *smc)
 	struct sock *sk = &smc->sk;
 
 	release_sock(sk);
-	cancel_work_sync(&smc->conn.close_work);
+	if (cancel_work_sync(&smc->conn.close_work))
+		sock_put(sk);
 	cancel_delayed_work_sync(&smc->conn.tx_work);
 	lock_sock(sk);
 }
-- 
2.42.0



