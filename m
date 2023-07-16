Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE689755344
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGPURN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGPURM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B49E40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B6C60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C255CC433C7;
        Sun, 16 Jul 2023 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538627;
        bh=lrSTKECLh5UyieDOYBCmMbD/hbAb3/C1glw8GSIIOGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlAh8k1XMZ2gr0GdTIL9fNuQPwv68gtgAFxSqIKbGDyVLyf1BumGnsgPGdV51VHsF
         VuhblqzYNpnkk8VaEkh6a+X11eFAh8rjSeydvm9Ft/Xrg/PbIYBd1nEuDkYu5WmOjZ
         4U5bDn+khWvWR2l4n4IM0wK77I0Od58aFUI7tqyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Kaiser <martin@kaiser.cx>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 518/800] hwrng: st - keep clock enabled while hwrng is registered
Date:   Sun, 16 Jul 2023 21:46:11 +0200
Message-ID: <20230716195001.127316095@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Kaiser <martin@kaiser.cx>

[ Upstream commit 501e197a02d4aef157f53ba3a0b9049c3e52fedc ]

The st-rng driver uses devres to register itself with the hwrng core,
the driver will be unregistered from hwrng when its device goes out of
scope. This happens after the driver's remove function is called.

However, st-rng's clock is disabled in the remove function. There's a
short timeframe where st-rng is still registered with the hwrng core
although its clock is disabled. I suppose the clock must be active to
access the hardware and serve requests from the hwrng core.

Switch to devm_clk_get_enabled and let devres disable the clock and
unregister the hwrng. This avoids the race condition.

Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/st-rng.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
index 15ba1e6fae4d2..6e9dfac9fc9f4 100644
--- a/drivers/char/hw_random/st-rng.c
+++ b/drivers/char/hw_random/st-rng.c
@@ -42,7 +42,6 @@
 
 struct st_rng_data {
 	void __iomem	*base;
-	struct clk	*clk;
 	struct hwrng	ops;
 };
 
@@ -85,26 +84,18 @@ static int st_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	ddata->ops.priv	= (unsigned long)ddata;
 	ddata->ops.read	= st_rng_read;
 	ddata->ops.name	= pdev->name;
 	ddata->base	= base;
-	ddata->clk	= clk;
-
-	dev_set_drvdata(&pdev->dev, ddata);
 
 	ret = devm_hwrng_register(&pdev->dev, &ddata->ops);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register HW RNG\n");
-		clk_disable_unprepare(clk);
 		return ret;
 	}
 
@@ -113,15 +104,6 @@ static int st_rng_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_rng_remove(struct platform_device *pdev)
-{
-	struct st_rng_data *ddata = dev_get_drvdata(&pdev->dev);
-
-	clk_disable_unprepare(ddata->clk);
-
-	return 0;
-}
-
 static const struct of_device_id st_rng_match[] __maybe_unused = {
 	{ .compatible = "st,rng" },
 	{},
@@ -134,7 +116,6 @@ static struct platform_driver st_rng_driver = {
 		.of_match_table = of_match_ptr(st_rng_match),
 	},
 	.probe = st_rng_probe,
-	.remove = st_rng_remove
 };
 
 module_platform_driver(st_rng_driver);
-- 
2.39.2



