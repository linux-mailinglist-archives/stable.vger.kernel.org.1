Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5316FAC1B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjEHLUy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjEHLUw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6381238F09
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED07762C90
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC07C433EF;
        Mon,  8 May 2023 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544850;
        bh=bcymKhKH7LHzTjrUPVkh0qE5nI59hjDOuuGm63rXG0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/db0cJcGx/8iBaSewasTB7bDcWkVKE5Ol3U49UZ17gnOUjGxRNOf5XA3S+WuzUBU
         CUHmHpLeipslXSShyV3v5svySSsKu4oCw8CaFe07Ceh0bFqfcM08V4egN5QOGXtByd
         FqcIIRRasvxO0L1VMzk28o0oyUYk4ITvPOr3zoo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Herring <robh@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 513/694] spi: mpc5xxx-psc: Remove unused platform_data
Date:   Mon,  8 May 2023 11:45:48 +0200
Message-Id: <20230508094450.833150644@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 04725901d9933b3134e6dee6b5bc1efb67f8d43f ]

The platform_data for the MPC5xxx PSC SPI controllers is never used, so
remove it and the resulting code which depends on it.

Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230217-dt-mpc5xxx-spi-v1-1-3be8602fce1e@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 45d2af82e0e6 ("spi: mchp-pci1xxxx: Fix improper implementation of disabling chip select lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mpc512x-psc.c | 28 ++++---------------------
 drivers/spi/spi-mpc52xx-psc.c | 39 +++--------------------------------
 2 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 03630359ce70d..0b4d49ef84de8 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -22,7 +22,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
-#include <linux/fsl_devices.h>
 #include <asm/mpc52xx_psc.h>
 
 enum {
@@ -51,8 +50,6 @@ enum {
 	__ret; })
 
 struct mpc512x_psc_spi {
-	void (*cs_control)(struct spi_device *spi, bool on);
-
 	/* driver internal data */
 	int type;
 	void __iomem *psc;
@@ -128,26 +125,16 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	mps->bits_per_word = cs->bits_per_word;
 
 	if (spi->cs_gpiod) {
-		if (mps->cs_control)
-			/* boardfile override */
-			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
-		else
-			/* gpiolib will deal with the inversion */
-			gpiod_set_value(spi->cs_gpiod, 1);
+		/* gpiolib will deal with the inversion */
+		gpiod_set_value(spi->cs_gpiod, 1);
 	}
 }
 
 static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
 {
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
-
 	if (spi->cs_gpiod) {
-		if (mps->cs_control)
-			/* boardfile override */
-			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
-		else
-			/* gpiolib will deal with the inversion */
-			gpiod_set_value(spi->cs_gpiod, 0);
+		/* gpiolib will deal with the inversion */
+		gpiod_set_value(spi->cs_gpiod, 0);
 	}
 }
 
@@ -474,7 +461,6 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 					      u32 size, unsigned int irq)
 {
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc512x_psc_spi *mps;
 	struct spi_master *master;
 	int ret;
@@ -490,12 +476,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->type = (int)of_device_get_match_data(dev);
 	mps->irq = irq;
 
-	if (pdata) {
-		mps->cs_control = pdata->cs_control;
-		master->bus_num = pdata->bus_num;
-		master->num_chipselect = pdata->max_chipselect;
-	}
-
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = mpc512x_psc_spi_setup;
 	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 609311231e64b..604868df913c4 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/fsl_devices.h>
 #include <linux/slab.h>
 #include <linux/of_irq.h>
 
@@ -28,10 +27,6 @@
 #define MCLK 20000000 /* PSC port MClk in hz */
 
 struct mpc52xx_psc_spi {
-	/* fsl_spi_platform data */
-	void (*cs_control)(struct spi_device *spi, bool on);
-	u32 sysclk;
-
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
 	struct mpc52xx_psc_fifo __iomem *fifo;
@@ -101,17 +96,6 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 		ccr |= (MCLK / 1000000 - 1) & 0xFF;
 	out_be16((u16 __iomem *)&psc->ccr, ccr);
 	mps->bits_per_word = cs->bits_per_word;
-
-	if (mps->cs_control)
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
-}
-
-static void mpc52xx_psc_spi_deactivate_cs(struct spi_device *spi)
-{
-	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
-
-	if (mps->cs_control)
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 }
 
 #define MPC52xx_PSC_BUFSIZE (MPC52xx_PSC_RFNUM_MASK + 1)
@@ -220,14 +204,9 @@ int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
 		m->actual_length += t->len;
 
 		spi_transfer_delay_exec(t);
-
-		if (cs_change)
-			mpc52xx_psc_spi_deactivate_cs(spi);
 	}
 
 	m->status = status;
-	if (status || !cs_change)
-		mpc52xx_psc_spi_deactivate_cs(spi);
 
 	mpc52xx_psc_spi_transfer_setup(spi, NULL);
 
@@ -269,7 +248,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	int ret;
 
 	/* default sysclk is 512MHz */
-	mclken_div = (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
+	mclken_div = 512000000 / MCLK;
 	ret = mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
 	if (ret)
 		return ret;
@@ -317,7 +296,6 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
 static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 				u32 size, unsigned int irq, s16 bus_num)
 {
-	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc52xx_psc_spi *mps;
 	struct spi_master *master;
 	int ret;
@@ -333,19 +311,8 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 
 	mps->irq = irq;
-	if (pdata == NULL) {
-		dev_warn(dev,
-			 "probe called without platform data, no cs_control function will be called\n");
-		mps->cs_control = NULL;
-		mps->sysclk = 0;
-		master->bus_num = bus_num;
-		master->num_chipselect = 255;
-	} else {
-		mps->cs_control = pdata->cs_control;
-		mps->sysclk = pdata->sysclk;
-		master->bus_num = pdata->bus_num;
-		master->num_chipselect = pdata->max_chipselect;
-	}
+	master->bus_num = bus_num;
+	master->num_chipselect = 255;
 	master->setup = mpc52xx_psc_spi_setup;
 	master->transfer_one_message = mpc52xx_psc_spi_transfer_one_message;
 	master->cleanup = mpc52xx_psc_spi_cleanup;
-- 
2.39.2



