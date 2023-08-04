Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3677770160
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHDNWs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHDNWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 09:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CB49D7
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 06:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F42561FBA
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 13:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF06C433C8;
        Fri,  4 Aug 2023 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691155237;
        bh=l6yUCdV+tTxUKCzuRFduUvzyNkBBDSTZLQ3K7CaZFHw=;
        h=Subject:To:From:Date:From;
        b=MpjF0EcJ/iiqidaYQiMjvM8qr6LMWiopHszy7RKszFhczUocU2IoAcpwJNuvrCB8K
         L69iNa75L8O3hb0rkpJ4ieS4xvytz4MoKwcadgC+QjKrt0QoDyv/dM8i9WH/HWLVFr
         L9GyLiN3k2sIzPtD0X9Mx7aNwdq5wgGYIgwZdusk=
Subject: patch "iio: adc: meson: fix core clock enable/disable moment" added to char-misc-linus
To:     gnstark@sberdevices.ru, Jonathan.Cameron@huawei.com,
        stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 04 Aug 2023 15:20:17 +0200
Message-ID: <2023080417-hardship-commodity-b24b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    iio: adc: meson: fix core clock enable/disable moment

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 09738ccbc4148c62d6c8c4644ff4a099d57f49ad Mon Sep 17 00:00:00 2001
From: George Stark <gnstark@sberdevices.ru>
Date: Fri, 21 Jul 2023 13:23:08 +0300
Subject: iio: adc: meson: fix core clock enable/disable moment

Enable core clock at probe stage and disable it at remove stage.
Core clock is responsible for turning on/off the entire SoC module so
it should be on before the first module register is touched and be off
at very last moment.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: George Stark <gnstark@sberdevices.ru>
Link: https://lore.kernel.org/r/20230721102413.255726-2-gnstark@sberdevices.ru
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/meson_saradc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index af6bfcc19075..eb78a6f17fd0 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -916,12 +916,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 		goto err_vref;
 	}
 
-	ret = clk_prepare_enable(priv->core_clk);
-	if (ret) {
-		dev_err(dev, "failed to enable core clk\n");
-		goto err_core_clk;
-	}
-
 	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
 			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
@@ -948,8 +942,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
 			   MESON_SAR_ADC_REG3_ADC_EN, 0);
 	meson_sar_adc_set_bandgap(indio_dev, false);
-	clk_disable_unprepare(priv->core_clk);
-err_core_clk:
 	regulator_disable(priv->vref);
 err_vref:
 	meson_sar_adc_unlock(indio_dev);
@@ -977,8 +969,6 @@ static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 
 	meson_sar_adc_set_bandgap(indio_dev, false);
 
-	clk_disable_unprepare(priv->core_clk);
-
 	regulator_disable(priv->vref);
 
 	if (!ret)
@@ -1211,7 +1201,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clkin))
 		return dev_err_probe(dev, PTR_ERR(priv->clkin), "failed to get clkin\n");
 
-	priv->core_clk = devm_clk_get(dev, "core");
+	priv->core_clk = devm_clk_get_enabled(dev, "core");
 	if (IS_ERR(priv->core_clk))
 		return dev_err_probe(dev, PTR_ERR(priv->core_clk), "failed to get core clk\n");
 
@@ -1294,15 +1284,26 @@ static int meson_sar_adc_remove(struct platform_device *pdev)
 static int meson_sar_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 
 	meson_sar_adc_hw_disable(indio_dev);
 
+	clk_disable_unprepare(priv->core_clk);
+
 	return 0;
 }
 
 static int meson_sar_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->core_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable core clk\n");
+		return ret;
+	}
 
 	return meson_sar_adc_hw_enable(indio_dev);
 }
-- 
2.41.0


