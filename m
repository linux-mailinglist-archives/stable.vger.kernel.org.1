Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCDE7ECE51
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjKOTmV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjKOTmU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003DB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B939BC433C8;
        Wed, 15 Nov 2023 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077336;
        bh=bcHvMbLb7vWkvbEo5/SDstdUijiJi2tPArpK3wdnx+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7hOCRwAGlbop/AzBdeu9JwbyO7jPaczQFZkZDhsHN5SvmqEv7XGHSMzEy9aU8dCT
         amSRzABo+18Wfw3yIRAcO6U6izB1im91PgKO7bxe8m8GAHVCf3KxxpJ51iG7pqWPWr
         FKTwfQs0wyP827M54S+ROhcUm9wuL6gfsnxKkb+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vaishnav Achath <vaishnav.a@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 213/603] spi: omap2-mcspi: Fix hardcoded reference clock
Date:   Wed, 15 Nov 2023 14:12:38 -0500
Message-ID: <20231115191628.014654206@linuxfoundation.org>
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

From: Vaishnav Achath <vaishnav.a@ti.com>

[ Upstream commit 2d9f4877988f64f0f336983de65c365b6a7debfb ]

A hardcoded reference clock of 48 MHz is used to calculate the
clock divisor values, but the reference clock frequency can be
different across devices and can be configured which can cause
a mismatch between the reported frequency and actual SPI clock
frequency observed. Fix this by fetching the clock rate from
the clock provider and falling back to hardcoded reference only
if the clock is not supplied.

Fixes: 2cd7d393f461 ("arm64: dts: ti: k3-am654: Add McSPI DT nodes")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20230926113812.30692-1-vaishnav.a@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 79888e6c54c25..ddf1c684bcc7d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -125,10 +125,12 @@ struct omap2_mcspi {
 	struct omap2_mcspi_dma	*dma_channels;
 	struct device		*dev;
 	struct omap2_mcspi_regs ctx;
+	struct clk		*ref_clk;
 	int			fifo_depth;
 	bool			target_aborted;
 	unsigned int		pin_dir:1;
 	size_t			max_xfer_len;
+	u32			ref_clk_hz;
 };
 
 struct omap2_mcspi_cs {
@@ -880,12 +882,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	return count - c;
 }
 
-static u32 omap2_mcspi_calc_divisor(u32 speed_hz)
+static u32 omap2_mcspi_calc_divisor(u32 speed_hz, u32 ref_clk_hz)
 {
 	u32 div;
 
 	for (div = 0; div < 15; div++)
-		if (speed_hz >= (OMAP2_MCSPI_MAX_FREQ >> div))
+		if (speed_hz >= (ref_clk_hz >> div))
 			return div;
 
 	return 15;
@@ -897,7 +899,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
-	u32 l = 0, clkd = 0, div, extclk = 0, clkg = 0;
+	u32 ref_clk_hz, l = 0, clkd = 0, div, extclk = 0, clkg = 0;
 	u8 word_len = spi->bits_per_word;
 	u32 speed_hz = spi->max_speed_hz;
 
@@ -911,14 +913,15 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	if (t && t->speed_hz)
 		speed_hz = t->speed_hz;
 
-	speed_hz = min_t(u32, speed_hz, OMAP2_MCSPI_MAX_FREQ);
-	if (speed_hz < (OMAP2_MCSPI_MAX_FREQ / OMAP2_MCSPI_MAX_DIVIDER)) {
-		clkd = omap2_mcspi_calc_divisor(speed_hz);
-		speed_hz = OMAP2_MCSPI_MAX_FREQ >> clkd;
+	ref_clk_hz = mcspi->ref_clk_hz;
+	speed_hz = min_t(u32, speed_hz, ref_clk_hz);
+	if (speed_hz < (ref_clk_hz / OMAP2_MCSPI_MAX_DIVIDER)) {
+		clkd = omap2_mcspi_calc_divisor(speed_hz, ref_clk_hz);
+		speed_hz = ref_clk_hz >> clkd;
 		clkg = 0;
 	} else {
-		div = (OMAP2_MCSPI_MAX_FREQ + speed_hz - 1) / speed_hz;
-		speed_hz = OMAP2_MCSPI_MAX_FREQ / div;
+		div = (ref_clk_hz + speed_hz - 1) / speed_hz;
+		speed_hz = ref_clk_hz / div;
 		clkd = (div - 1) & 0xf;
 		extclk = (div - 1) >> 4;
 		clkg = OMAP2_MCSPI_CHCONF_CLKG;
@@ -1448,8 +1451,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	ctlr->cleanup = omap2_mcspi_cleanup;
 	ctlr->target_abort = omap2_mcspi_target_abort;
 	ctlr->dev.of_node = node;
-	ctlr->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
-	ctlr->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
 	ctlr->use_gpio_descriptors = true;
 
 	platform_set_drvdata(pdev, ctlr);
@@ -1519,6 +1520,14 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_ctlr;
 	}
 
+	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (mcspi->ref_clk)
+		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
+	else
+		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
+	ctlr->max_speed_hz = mcspi->ref_clk_hz;
+	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
-- 
2.42.0



