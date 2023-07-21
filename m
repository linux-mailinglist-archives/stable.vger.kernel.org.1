Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10975C0C8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGUIGn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGUIGn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 04:06:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115A270A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 01:06:41 -0700 (PDT)
Received: from [185.206.209.215] (helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qMl9s-0000ey-4M; Fri, 21 Jul 2023 10:06:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     stable@vger.kernel.org
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14.y] hwrng: imx-rngc - fix the timeout for init and self check
Date:   Fri, 21 Jul 2023 10:04:12 +0200
Message-Id: <20230721080412.437845-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023072142-childless-postbox-af6e@gregkh>
References: <2023072142-childless-postbox-af6e@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Fix the timeout that is used for the initialisation and for the self
test. wait_for_completion_timeout expects a timeout in jiffies, but
RNGC_TIMEOUT is in milliseconds. Call msecs_to_jiffies to do the
conversion.

Cc: stable@vger.kernel.org
Fixes: 1d5449445bd0 ("hwrng: mx-rngc - add a driver for Freescale RNGC")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
(cherry picked from commit d744ae7477190967a3ddc289e2cd4ae59e8b1237)
---
 drivers/char/hw_random/imx-rngc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 48194d1a6076..5a31887867d6 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -104,7 +104,7 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, RNGC_TIMEOUT);
+	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 	if (!ret) {
 		imx_rngc_irq_mask_clear(rngc);
 		return -ETIMEDOUT;
@@ -187,9 +187,7 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-				RNGC_TIMEOUT);
-
+		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 		if (!ret) {
 			imx_rngc_irq_mask_clear(rngc);
 			return -ETIMEDOUT;
-- 
2.30.2

