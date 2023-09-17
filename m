Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F617A3B35
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbjIQUO2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbjIQUOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19276101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BD2C433C7;
        Sun, 17 Sep 2023 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981647;
        bh=aauDOwrWEy3JawhNqfyHPYY2witrGt1TMf/YjCUA9LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIUKYuXq8Of3JzxAR3FHibO3VeH74WCJaLYczqNzdPsdutjkSARhFwl/6hNCVbNug
         4pqGKZxI1YGdutB/GctS+Cho7dKNw1s4CYiO8u7YYmJdhQ8t1qgdJhCC2QNQMLYc+d
         5RAjCHgXkGTmYGzvtzJ8vGBTfVz5AQcax4wl1BOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Kaiser <martin@kaiser.cx>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/511] hwrng: pic32 - use devm_clk_get_enabled
Date:   Sun, 17 Sep 2023 21:08:30 +0200
Message-ID: <20230917191115.875110483@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit 6755ad74aac0fb1c79b14724feb81b2f6ff25847 ]

Use devm_clk_get_enabled in the pic32 driver. Ensure that the clock is
enabled as long as the driver is registered with the hwrng core.

Fixes: 7ea39973d1e5 ("hwrng: pic32 - Use device-managed registration API")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/pic32-rng.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index 99c8bd0859a14..e04a054e89307 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -36,7 +36,6 @@
 struct pic32_rng {
 	void __iomem	*base;
 	struct hwrng	rng;
-	struct clk	*clk;
 };
 
 /*
@@ -70,6 +69,7 @@ static int pic32_rng_read(struct hwrng *rng, void *buf, size_t max,
 static int pic32_rng_probe(struct platform_device *pdev)
 {
 	struct pic32_rng *priv;
+	struct clk *clk;
 	u32 v;
 	int ret;
 
@@ -81,13 +81,9 @@ static int pic32_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* enable TRNG in enhanced mode */
 	v = TRNGEN | TRNGMOD;
@@ -98,15 +94,11 @@ static int pic32_rng_probe(struct platform_device *pdev)
 
 	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
 	if (ret)
-		goto err_register;
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
-
-err_register:
-	clk_disable_unprepare(priv->clk);
-	return ret;
 }
 
 static int pic32_rng_remove(struct platform_device *pdev)
@@ -114,7 +106,6 @@ static int pic32_rng_remove(struct platform_device *pdev)
 	struct pic32_rng *rng = platform_get_drvdata(pdev);
 
 	writel(0, rng->base + RNGCON);
-	clk_disable_unprepare(rng->clk);
 	return 0;
 }
 
-- 
2.40.1



