Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54A726C21
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjFGUa7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjFGUao (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8602113
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE78E644A8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9F7C4339C;
        Wed,  7 Jun 2023 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169839;
        bh=cWQsk801mYWJ/p1NlRo+kI+kx33HxlJKhA8YIWmDMwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScvmXeHHq5Ok2FYLmhUjaQE4pHVjY0AYuUITHBEEx4rI0mcRjCve4oEFn7QX3muWu
         TtrtxYrI2B5HcxocfvaeOwDqa8f4db3Y7NpyYNQdrlexjnOtsG72Rna0s1qob5hwvf
         kPte+lQ5ndw3TwtYMANTo7R1HuKOkyzN9z9Lz3Xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.3 226/286] mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order
Date:   Wed,  7 Jun 2023 22:15:25 +0200
Message-ID: <20230607200930.662135431@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

commit 0b5d5c436a5c572a45f976cfd34a6741e143e5d9 upstream.

Chapter "5.3 Power-Up/Down Sequence" of WILC1000 [1] and WILC3000 [2]
states that CHIP_EN must be pulled HIGH first, RESETN second. Fix the
order of these signals in the driver.

Use the mmc_pwrseq_ops as driver data as the delay between signals is
specific to SDIO card type anyway.

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/WSG/ProductDocuments/DataSheets/ATWILC1000-MR110XB-IEEE-802.11-b-g-n-Link-Controller-Module-DS70005326E.pdf
[2] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/IEEE-802.11-b-g-n-Link-Controller-Module-with-Integrated-Bluetooth-5.0-DS70005327B.pdf

Fixes: b2832b96fcf5 ("mmc: pwrseq: sd8787: add support for wilc1000")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230513192352.479627-1-marex@denx.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/pwrseq_sd8787.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -28,7 +28,6 @@ struct mmc_pwrseq_sd8787 {
 	struct mmc_pwrseq pwrseq;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *pwrdn_gpio;
-	u32 reset_pwrdwn_delay_ms;
 };
 
 #define to_pwrseq_sd8787(p) container_of(p, struct mmc_pwrseq_sd8787, pwrseq)
@@ -39,7 +38,7 @@ static void mmc_pwrseq_sd8787_pre_power_
 
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
 
-	msleep(pwrseq->reset_pwrdwn_delay_ms);
+	msleep(300);
 	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
 }
 
@@ -51,17 +50,37 @@ static void mmc_pwrseq_sd8787_power_off(
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
 }
 
+static void mmc_pwrseq_wilc1000_pre_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
+
+	/* The pwrdn_gpio is really CHIP_EN, reset_gpio is RESETN */
+	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
+	msleep(5);
+	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+}
+
+static void mmc_pwrseq_wilc1000_power_off(struct mmc_host *host)
+{
+	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
+
+	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
+	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 0);
+}
+
 static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
 	.pre_power_on = mmc_pwrseq_sd8787_pre_power_on,
 	.power_off = mmc_pwrseq_sd8787_power_off,
 };
 
-static const u32 sd8787_delay_ms = 300;
-static const u32 wilc1000_delay_ms = 5;
+static const struct mmc_pwrseq_ops mmc_pwrseq_wilc1000_ops = {
+	.pre_power_on = mmc_pwrseq_wilc1000_pre_power_on,
+	.power_off = mmc_pwrseq_wilc1000_power_off,
+};
 
 static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
-	{ .compatible = "mmc-pwrseq-sd8787", .data = &sd8787_delay_ms },
-	{ .compatible = "mmc-pwrseq-wilc1000", .data = &wilc1000_delay_ms },
+	{ .compatible = "mmc-pwrseq-sd8787", .data = &mmc_pwrseq_sd8787_ops },
+	{ .compatible = "mmc-pwrseq-wilc1000", .data = &mmc_pwrseq_wilc1000_ops },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
@@ -77,7 +96,6 @@ static int mmc_pwrseq_sd8787_probe(struc
 		return -ENOMEM;
 
 	match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
-	pwrseq->reset_pwrdwn_delay_ms = *(u32 *)match->data;
 
 	pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
 	if (IS_ERR(pwrseq->pwrdn_gpio))
@@ -88,7 +106,7 @@ static int mmc_pwrseq_sd8787_probe(struc
 		return PTR_ERR(pwrseq->reset_gpio);
 
 	pwrseq->pwrseq.dev = dev;
-	pwrseq->pwrseq.ops = &mmc_pwrseq_sd8787_ops;
+	pwrseq->pwrseq.ops = match->data;
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 


