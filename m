Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28FD78AAD5
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjH1KZd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjH1KZH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE69136
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A22F63998
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A95AC433C8;
        Mon, 28 Aug 2023 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218302;
        bh=JpRqgb4VxKHwc5dE9FWCUVkbhEbms/ASmDBVrZVRmuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5flMfJMl4K9CZKSguGgo8EEZxb5MSvnKZXfnlBxNgH8/kLVfdoQRLsooIzz32Qxi
         HBLSSl0HLFDuYKTO0gmxVnXws2keUWz2ID+NFIG17dCfpxqRqicZXFpvmLKpleye7i
         NvyX2fsH1WA4ms05UCEdxiAHtbHwTdUhWebEBQXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/129] mmc: tmio: move tmio_mmc_set_clock() to platform hook
Date:   Mon, 28 Aug 2023 12:12:13 +0200
Message-ID: <20230828101154.602392791@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 0196c8db8363f7627df6f78615271ae0ba430500 ]

tmio_mmc_set_clock() is full of quirks because different SoC vendors
extended this in different ways.

The original IP defines the divisor range 1/2 ... 1/512.

 bit 7 is set:    1/512
 bit 6 is set:    1/256
   ...
 bit 0 is set:    1/4
 all bits clear:  1/2

It is platform-dependent how to achieve the 1/1 clock.

I guess the TMIO-MFD variant uses the clock selector outside of this IP,
as far as I see tmio_core_mmc_clk_div() in drivers/mfd/tmio_core.c

I guess bit[7:0]=0xff is Renesas-specific extension.

Socionext (and Panasonic) uses bit 10 (CLKSEL) for 1/1.  Also, newer
versions of UniPhier SoC variants use bit 16 for 1/1024.

host->clk_update() is only used by the Renesas variants, whereas
host->set_clk_div() is only used by the TMIO-MFD variants.

To cope with this mess, promote tmio_mmc_set_clock() to a new
platform hook ->set_clock(), and melt the old two hooks into it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 71150ac12558 ("mmc: bcm2835: fix deferred probing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 62 ++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.c          | 48 +++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  4 +-
 drivers/mmc/host/tmio_mmc_core.c     | 92 +++-------------------------
 4 files changed, 117 insertions(+), 89 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index eabfcb5bbafff..a2c44cc8e2e7c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -155,6 +155,66 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
+static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+}
+
+static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+}
+
+static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
+				   unsigned int new_clock)
+{
+	u32 clk = 0, clock;
+
+	if (new_clock == 0) {
+		renesas_sdhi_clk_stop(host);
+		return;
+	}
+	/*
+	 * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
+	 * set 400MHz to distinguish the CPG settings in HS400.
+	 */
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+	    host->pdata->flags & TMIO_MMC_HAVE_4TAP_HS400 &&
+	    new_clock == 200000000)
+		new_clock = 400000000;
+
+	clock = renesas_sdhi_clk_update(host, new_clock) / 512;
+
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	/* 1/1 clock is option */
+	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1)) {
+		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
+			clk |= 0xff;
+		else
+			clk &= ~0xff;
+	}
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+
+	renesas_sdhi_clk_start(host);
+}
+
 static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -621,8 +681,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	host->write16_hook	= renesas_sdhi_write16_hook;
 	host->clk_enable	= renesas_sdhi_clk_enable;
-	host->clk_update	= renesas_sdhi_clk_update;
 	host->clk_disable	= renesas_sdhi_clk_disable;
+	host->set_clock		= renesas_sdhi_set_clock;
 	host->multi_io_quirk	= renesas_sdhi_multi_io_quirk;
 	host->dma_ops		= dma_ops;
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 43a2ea5cff24f..b031a776c12e0 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
@@ -23,6 +24,52 @@
 
 #include "tmio_mmc.h"
 
+static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	usleep_range(10000, 11000);
+	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+	usleep_range(10000, 11000);
+}
+
+static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
+	usleep_range(10000, 11000);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	usleep_range(10000, 11000);
+}
+
+static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
+			       unsigned int new_clock)
+{
+	u32 clk = 0, clock;
+
+	if (new_clock == 0) {
+		tmio_mmc_clk_stop(host);
+		return;
+	}
+
+	clock = host->mmc->f_min;
+
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	host->pdata->set_clk_div(host->pdev, (clk >> 22) & 1);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
+	usleep_range(10000, 11000);
+
+	tmio_mmc_clk_start(host);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int tmio_mmc_suspend(struct device *dev)
 {
@@ -100,6 +147,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
+	host->set_clock = tmio_mmc_set_clock;
 
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7c40a7e1fea1c..358aa258cb159 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -133,7 +133,6 @@ struct tmio_mmc_host {
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
-	void (*set_clk_div)(struct platform_device *host, int state);
 
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
@@ -170,10 +169,9 @@ struct tmio_mmc_host {
 
 	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
+	void (*set_clock)(struct tmio_mmc_host *host, unsigned int clock);
 
 	/* Optional callbacks */
-	unsigned int (*clk_update)(struct tmio_mmc_host *host,
-				   unsigned int new_clock);
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 195f45a84282e..f819757e125e0 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -161,83 +161,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
-static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-		usleep_range(10000, 11000);
-	}
-}
-
-static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
-{
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-		usleep_range(10000, 11000);
-	}
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
-
-static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
-			       unsigned int new_clock)
-{
-	u32 clk = 0, clock;
-
-	if (new_clock == 0) {
-		tmio_mmc_clk_stop(host);
-		return;
-	}
-	/*
-	 * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
-	 * set 400MHz to distinguish the CPG settings in HS400.
-	 */
-	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
-	    host->pdata->flags & TMIO_MMC_HAVE_4TAP_HS400 &&
-	    new_clock == 200000000)
-		new_clock = 400000000;
-
-	if (host->clk_update)
-		clock = host->clk_update(host, new_clock) / 512;
-	else
-		clock = host->mmc->f_min;
-
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-		clock <<= 1;
-
-	/* 1/1 clock is option */
-	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) &&
-	    ((clk >> 22) & 0x1)) {
-		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
-			clk |= 0xff;
-		else
-			clk &= ~0xff;
-	}
-
-	if (host->set_clk_div)
-		host->set_clk_div(host->pdev, (clk >> 22) & 1);
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-
-	tmio_mmc_clk_start(host);
-}
-
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
@@ -1051,15 +974,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		tmio_mmc_set_clock(host, 0);
+		host->set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
 		tmio_mmc_power_on(host, ios->vdd);
-		tmio_mmc_set_clock(host, ios->clock);
+		host->set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	case MMC_POWER_ON:
-		tmio_mmc_set_clock(host, ios->clock);
+		host->set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	}
@@ -1245,7 +1168,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	int ret;
 
 	/*
-	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * Check the sanity of mmc->f_min to prevent host->set_clock() from
 	 * looping forever...
 	 */
 	if (mmc->f_min == 0)
@@ -1255,7 +1178,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 		_host->write16_hook = NULL;
 
 	_host->set_pwr = pdata->set_pwr;
-	_host->set_clk_div = pdata->set_clk_div;
 
 	ret = tmio_mmc_init_ocr(_host);
 	if (ret < 0)
@@ -1318,7 +1240,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
-	tmio_mmc_set_clock(_host, 0);
+	_host->set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
@@ -1402,7 +1324,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-		tmio_mmc_set_clock(host, 0);
+		host->set_clock(host, 0);
 
 	tmio_mmc_clk_disable(host);
 
@@ -1423,7 +1345,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	tmio_mmc_clk_enable(host);
 
 	if (host->clk_cache)
-		tmio_mmc_set_clock(host, host->clk_cache);
+		host->set_clock(host, host->clk_cache);
 
 	if (host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(host,
-- 
2.40.1



