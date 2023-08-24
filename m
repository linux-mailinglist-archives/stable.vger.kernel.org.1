Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C13787354
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbjHXPCL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbjHXPB4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:01:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09477C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CC8D615C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D7EC433C8;
        Thu, 24 Aug 2023 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889314;
        bh=F3RfGIfkvl2dYNNS1Gy/5PiHahAYehlU2nXHwrRRwB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yvtybwn8Nh3bUJfKOGeKq48dPOkHEGtIfstMYmzZb4hePqhoig0XFu6WEwb9GbPyq
         Ywoh7UZc0a8eyrCcRVBldeV+lonUP8VpnpgP1AJkdtzCiPh1v9KBE+HkN98PUsDh+f
         ZEoTHtV282KaL839hFs1tokPtZAY/VBOLovN/o0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 062/135] mmc: meson-gx: use devm_mmc_alloc_host
Date:   Thu, 24 Aug 2023 16:50:05 +0200
Message-ID: <20230824145029.568472167@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 418f7c2de1334b70fbee790911a1b46503230137 ]

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/728f159b-885f-c78a-1a3d-f55c245250e1@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: b8ada54fa1b8 ("mmc: meson-gx: fix deferred probing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 52 +++++++++++----------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e89bd6f4b317c..8a345ee2e6cf5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1122,7 +1122,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct meson_host));
 	if (!mmc)
 		return -ENOMEM;
 	host = mmc_priv(mmc);
@@ -1138,46 +1138,33 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto free_host;
+		return ret;
 
 	ret = mmc_of_parse(mmc);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_warn(&pdev->dev, "error parsing DT: %d\n", ret);
-		goto free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "error parsing DT\n");
 
 	host->data = (struct meson_mmc_data *)
 		of_device_get_match_data(&pdev->dev);
-	if (!host->data) {
-		ret = -EINVAL;
-		goto free_host;
-	}
+	if (!host->data)
+		return -EINVAL;
 
 	ret = device_reset_optional(&pdev->dev);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "device reset failed\n");
-		goto free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "device reset failed\n");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->regs)) {
-		ret = PTR_ERR(host->regs);
-		goto free_host;
-	}
+	if (IS_ERR(host->regs))
+		return PTR_ERR(host->regs);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
-		goto free_host;
-	}
+	if (host->irq <= 0)
+		return -EINVAL;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		goto free_host;
-	}
+	if (IS_ERR(host->pinctrl))
+		return PTR_ERR(host->pinctrl);
 
 	host->pins_clk_gate = pinctrl_lookup_state(host->pinctrl,
 						   "clk-gate");
@@ -1188,14 +1175,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	host->core_clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(host->core_clk)) {
-		ret = PTR_ERR(host->core_clk);
-		goto free_host;
-	}
+	if (IS_ERR(host->core_clk))
+		return PTR_ERR(host->core_clk);
 
 	ret = clk_prepare_enable(host->core_clk);
 	if (ret)
-		goto free_host;
+		return ret;
 
 	ret = meson_mmc_clk_init(host);
 	if (ret)
@@ -1290,8 +1275,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->mmc_clk);
 err_core_clk:
 	clk_disable_unprepare(host->core_clk);
-free_host:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1315,7 +1298,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->mmc_clk);
 	clk_disable_unprepare(host->core_clk);
 
-	mmc_free_host(host->mmc);
 	return 0;
 }
 
-- 
2.40.1



