Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CAA703B4E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbjEOSBv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244828AbjEOSBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E9F19F0C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6573863027
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D189DC433EF;
        Mon, 15 May 2023 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173521;
        bh=3N52IChlMEOdaRuvwdIhVQhuhkE/QANRpTzxBEAWAus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPBsbiEeNVDJNBzRc2YRE/EjoZ2BTCdwmnDfZoWlNOV38LNk50b3eohItC9SyDtWp
         MRzyad5yP3SFMn2s+Rqa3lz/z4XhMCp3cEyljAuiZv7ut9GUHv7Vms/uOZr/6vWlMm
         o/zfnXOyJQfux0njydxCck4dhbg3VM4/rIw1IHJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/282] spi: imx/fsl-lpspi: Convert to GPIO descriptors
Date:   Mon, 15 May 2023 18:28:19 +0200
Message-Id: <20230515161725.863084393@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 8cdcd8aeee2819199ec7f68114b77b04c10611d3 ]

This converts the two Freescale i.MX SPI drivers
Freescale i.MX (CONFIG_SPI_IMX) and Freescale i.MX LPSPI
(CONFIG_SPI_FSL_LPSPI) to use GPIO descriptors handled in
the SPI core for GPIO chip selects whether defined in
the device tree or a board file.

The reason why both are converted at the same time is
that they were both using the same platform data and
platform device population helpers when using
board files intertwining the code so this gives a cleaner
cut.

The platform device creation was passing a platform data
container from each boardfile down to the driver using
struct spi_imx_master from <linux/platform_data/spi-imx.h>,
but this was only conveying the number of chipselects and
an int * array of the chipselect GPIO numbers.

The imx27 and imx31 platforms had code passing the
now-unused platform data when creating the platform devices,
this has been repurposed to pass around GPIO descriptor
tables. The platform data struct that was just passing an
array of integers and number of chip selects for the GPIO
lines has been removed.

The number of chipselects used to be passed from the board
file, because this number also limits the number of native
chipselects that the platform can use. To deal with this we
just augment the i.MX (CONFIG_SPI_IMX) driver to support 3
chipselects if the platform does not define "num-cs" as a
device property (such as from the device tree). This covers
all the legacy boards as these use <= 3 native chip selects
(or GPIO lines, and in that case the number of chip selects
is determined by the core from the number of available
GPIO lines). Any new boards should use device tree, so
this is a reasonable simplification to cover all old
boards.

The LPSPI driver never assigned the number of chipselects
and thus always fall back to the core default of 1 chip
select if no GPIOs are defined in the device tree.

The Freescale i.MX driver was already partly utilizing
the SPI core to obtain the GPIO numbers from the device tree,
so this completes the transtion to let the core handle all
of it.

All board files and the core i.MX boardfile registration
code is augmented to account for these changes.

This has been compile-tested with the imx_v4_v5_defconfig
and the imx_v6_v7_defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Trent Piepho <tpiepho@impinj.com>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Link: https://lore.kernel.org/r/20200625200252.207614-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 11951c9e3f36 ("spi: imx: Don't skip cleanup in remove's error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/devices-imx27.h            | 10 +--
 arch/arm/mach-imx/devices-imx31.h            | 10 +--
 arch/arm/mach-imx/devices/devices-common.h   |  5 +-
 arch/arm/mach-imx/devices/platform-spi_imx.c |  9 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            | 40 ++++++---
 arch/arm/mach-imx/mach-mx31_3ds.c            | 13 +--
 arch/arm/mach-imx/mach-mx31lilly.c           | 14 +--
 arch/arm/mach-imx/mach-mx31lite.c            | 19 +---
 arch/arm/mach-imx/mach-mx31moboard.c         | 12 +--
 arch/arm/mach-imx/mach-pca100.c              | 21 +++--
 arch/arm/mach-imx/mach-pcm037_eet.c          |  7 +-
 drivers/spi/spi-fsl-lpspi.c                  | 47 +---------
 drivers/spi/spi-imx.c                        | 92 ++++----------------
 include/linux/platform_data/spi-imx.h        | 33 -------
 14 files changed, 88 insertions(+), 244 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-imx.h

diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index f89f4ae0e1ca6..583a1d773d682 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -75,11 +75,11 @@ extern const struct imx_mxc_w1_data imx27_mxc_w1_data;
 	imx_add_mxc_w1(&imx27_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx27_cspi_data[];
-#define imx27_add_cspi(id, pdata)	\
-	imx_add_spi_imx(&imx27_cspi_data[id], pdata)
-#define imx27_add_spi_imx0(pdata)	imx27_add_cspi(0, pdata)
-#define imx27_add_spi_imx1(pdata)	imx27_add_cspi(1, pdata)
-#define imx27_add_spi_imx2(pdata)	imx27_add_cspi(2, pdata)
+#define imx27_add_cspi(id, gtable) \
+	imx_add_spi_imx(&imx27_cspi_data[id], gtable)
+#define imx27_add_spi_imx0(gtable)	imx27_add_cspi(0, gtable)
+#define imx27_add_spi_imx1(gtable)	imx27_add_cspi(1, gtable)
+#define imx27_add_spi_imx2(gtable)	imx27_add_cspi(2, gtable)
 
 extern const struct imx_pata_imx_data imx27_pata_imx_data;
 #define imx27_add_pata_imx() \
diff --git a/arch/arm/mach-imx/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
index 5a4ba35a47ed0..f7cc623725322 100644
--- a/arch/arm/mach-imx/devices-imx31.h
+++ b/arch/arm/mach-imx/devices-imx31.h
@@ -69,11 +69,11 @@ extern const struct imx_mxc_w1_data imx31_mxc_w1_data;
 	imx_add_mxc_w1(&imx31_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx31_cspi_data[];
-#define imx31_add_cspi(id, pdata)	\
-	imx_add_spi_imx(&imx31_cspi_data[id], pdata)
-#define imx31_add_spi_imx0(pdata)	imx31_add_cspi(0, pdata)
-#define imx31_add_spi_imx1(pdata)	imx31_add_cspi(1, pdata)
-#define imx31_add_spi_imx2(pdata)	imx31_add_cspi(2, pdata)
+#define imx31_add_cspi(id, gtable) \
+	imx_add_spi_imx(&imx31_cspi_data[id], gtable)
+#define imx31_add_spi_imx0(gtable)	imx31_add_cspi(0, gtable)
+#define imx31_add_spi_imx1(gtable)	imx31_add_cspi(1, gtable)
+#define imx31_add_spi_imx2(gtable)	imx31_add_cspi(2, gtable)
 
 extern const struct imx_pata_imx_data imx31_pata_imx_data;
 #define imx31_add_pata_imx() \
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 2a685adec1df7..f8f3e4967c31f 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_data/dma-imx-sdma.h>
 
 extern struct device mxc_aips_bus;
@@ -276,7 +277,6 @@ struct platform_device *__init imx_add_sdhci_esdhc_imx(
 		const struct imx_sdhci_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata);
 
-#include <linux/platform_data/spi-imx.h>
 struct imx_spi_imx_data {
 	const char *devid;
 	int id;
@@ -285,8 +285,7 @@ struct imx_spi_imx_data {
 	int irq;
 };
 struct platform_device *__init imx_add_spi_imx(
-		const struct imx_spi_imx_data *data,
-		const struct spi_imx_master *pdata);
+	const struct imx_spi_imx_data *data, struct gpiod_lookup_table *gtable);
 
 struct platform_device *imx_add_imx_dma(char *name, resource_size_t iobase,
 					int irq, int irq_err);
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index f2cafa52c1872..27747bf628a31 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2009-2010 Pengutronix
  * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
  */
+#include <linux/gpio/machine.h>
 #include "../hardware.h"
 #include "devices-common.h"
 
@@ -57,8 +58,7 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_spi_imx(
-		const struct imx_spi_imx_data *data,
-		const struct spi_imx_master *pdata)
+	const struct imx_spi_imx_data *data, struct gpiod_lookup_table *gtable)
 {
 	struct resource res[] = {
 		{
@@ -71,7 +71,8 @@ struct platform_device *__init imx_add_spi_imx(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-
+	if (gtable)
+		gpiod_add_lookup_table(gtable);
 	return imx_add_platform_device(data->devid, data->id,
-			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 7b8325fb5b413..51204521b903b 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -304,18 +304,34 @@ static struct imx_ssi_platform_data mx27_3ds_ssi_pdata = {
 };
 
 /* SPI */
-static int spi1_chipselect[] = {SPI1_SS0};
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.chipselect	= spi1_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi1_chipselect),
+static struct gpiod_lookup_table mx27_spi1_gpiod_table = {
+	.dev_id = "imx27-cspi.0", /* Actual device name for spi1 */
+	.table = {
+		/*
+		 * The i.MX27 has the i.MX21 GPIO controller, the SPI1 CS GPIO
+		 * SPI1_SS0 is numbered IMX_GPIO_NR(4, 28).
+		 *
+		 * This is in "bank 4" which is subtracted by one in the macro
+		 * so this is actually bank 3 on "imx21-gpio.3".
+		 */
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 28, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
-static int spi2_chipselect[] = {SPI2_SS0};
-
-static const struct spi_imx_master spi2_pdata __initconst = {
-	.chipselect	= spi2_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
+static struct gpiod_lookup_table mx27_spi2_gpiod_table = {
+	.dev_id = "imx27-cspi.1", /* Actual device name for spi2 */
+	.table = {
+		/*
+		 * The i.MX27 has the i.MX21 GPIO controller, the SPI2 CS GPIO
+		 * SPI2_SS0 is numbered IMX_GPIO_NR(4, 21).
+		 *
+		 * This is in "bank 4" which is subtracted by one in the macro
+		 * so this is actually bank 3 on "imx21-gpio.3".
+		 */
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 21, "cs", 0, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static struct imx_fb_videomode mx27_3ds_modes[] = {
@@ -389,8 +405,8 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_imx2_wdt();
 
-	imx27_add_spi_imx1(&spi2_pdata);
-	imx27_add_spi_imx0(&spi1_pdata);
+	imx27_add_spi_imx1(&mx27_spi2_gpiod_table);
+	imx27_add_spi_imx0(&mx27_spi1_gpiod_table);
 
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
 	imx27_add_imx_fb(&mx27_3ds_fb_data);
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 716d2ad511035..99295ce8d0549 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -364,15 +364,6 @@ static struct imx_ssi_platform_data mx31_3ds_ssi_pdata = {
 	.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
-/* SPI */
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
 static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
 	{
 		.modalias	= "mc13783",
@@ -548,14 +539,14 @@ static void __init mx31_3ds_init(void)
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
-	imx31_add_spi_imx1(&spi1_pdata);
+	imx31_add_spi_imx1(NULL);
 
 	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	imx31_add_imx2_wdt();
 	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
 
-	imx31_add_spi_imx0(&spi0_pdata);
+	imx31_add_spi_imx0(NULL);
 	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 8f725248299e1..4b955ccc92cdc 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -215,16 +215,6 @@ static void __init lilly1131_usb_init(void)
 		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 }
 
-/* SPI */
-
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.num_chipselect = 3,
-};
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.num_chipselect = 3,
-};
-
 static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 	.flags = MC13XXX_USE_RTC | MC13XXX_USE_TOUCHSCREEN,
 };
@@ -281,8 +271,8 @@ static void __init mx31lilly_board_init(void)
 	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS1__SS1, "SPI2_SS1");
 	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS2__SS2, "SPI2_SS2");
 
-	imx31_add_spi_imx0(&spi0_pdata);
-	imx31_add_spi_imx1(&spi1_pdata);
+	imx31_add_spi_imx0(NULL);
+	imx31_add_spi_imx1(NULL);
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 }
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index c0055f57c02dd..aaccf52f7ac16 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -73,11 +73,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-/* SPI */
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
 static const struct mxc_nand_platform_data
 mx31lite_nand_board_info __initconst  = {
 	.width = 1,
@@ -111,16 +106,6 @@ static struct platform_device smsc911x_device = {
 	},
 };
 
-/*
- * SPI
- *
- * The MC13783 is the only hard-wired SPI device on the module.
- */
-
-static const struct spi_imx_master spi1_pdata __initconst = {
-	.num_chipselect	= 1,
-};
-
 static struct mc13xxx_platform_data mc13783_pdata __initdata = {
 	.flags = MC13XXX_USE_RTC,
 };
@@ -246,13 +231,13 @@ static void __init mx31lite_init(void)
 				      "mx31lite");
 
 	imx31_add_imx_uart0(&uart_pdata);
-	imx31_add_spi_imx0(&spi0_pdata);
+	imx31_add_spi_imx0(NULL);
 
 	/* NOR and NAND flash */
 	platform_device_register(&physmap_flash_device);
 	imx31_add_mxc_nand(&mx31lite_nand_board_info);
 
-	imx31_add_spi_imx1(&spi1_pdata);
+	imx31_add_spi_imx1(NULL);
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 }
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 36f08f45b0cad..96845a4eaf57e 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -143,10 +143,6 @@ static const struct imxi2c_platform_data moboard_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
-static const struct spi_imx_master moboard_spi1_pdata __initconst = {
-	.num_chipselect	= 3,
-};
-
 static struct regulator_consumer_supply sdhc_consumers[] = {
 	{
 		.dev_name = "imx31-mmc.0",
@@ -287,10 +283,6 @@ static struct spi_board_info moboard_spi_board_info[] __initdata = {
 	},
 };
 
-static const struct spi_imx_master moboard_spi2_pdata __initconst = {
-	.num_chipselect	= 2,
-};
-
 #define SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_ATA_CS0)
 #define SDHC1_WP IOMUX_TO_GPIO(MX31_PIN_ATA_CS1)
 
@@ -514,8 +506,8 @@ static void __init mx31moboard_init(void)
 	imx31_add_imx_i2c0(&moboard_i2c0_data);
 	imx31_add_imx_i2c1(&moboard_i2c1_data);
 
-	imx31_add_spi_imx1(&moboard_spi1_pdata);
-	imx31_add_spi_imx2(&moboard_spi2_pdata);
+	imx31_add_spi_imx1(NULL);
+	imx31_add_spi_imx2(NULL);
 
 	mx31moboard_init_cam();
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 2e28e1b5cddfd..27a3678e0658a 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 
@@ -188,11 +189,19 @@ static struct spi_board_info pca100_spi_board_info[] __initdata = {
 	},
 };
 
-static int pca100_spi_cs[] = {SPI1_SS0, SPI1_SS1};
-
-static const struct spi_imx_master pca100_spi0_data __initconst = {
-	.chipselect	= pca100_spi_cs,
-	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
+static struct gpiod_lookup_table pca100_spi0_gpiod_table = {
+	.dev_id = "imx27-cspi.0", /* Actual device name for spi0 */
+	.table = {
+		/*
+		 * The i.MX27 has the i.MX21 GPIO controller, port D is
+		 * bank 3 and thus named "imx21-gpio.3".
+		 * SPI1_SS0 is GPIO_PORTD + 28
+		 * SPI1_SS1 is GPIO_PORTD + 27
+		 */
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 28, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("imx21-gpio.3", 27, "cs", 1, GPIO_ACTIVE_LOW),
+		{ },
+	},
 };
 
 static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
@@ -362,7 +371,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
-	imx27_add_spi_imx0(&pca100_spi0_data);
+	imx27_add_spi_imx0(&pca100_spi0_gpiod_table);
 
 	imx27_add_imx_fb(&pca100_fb_data);
 
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 51f5142920cf5..8b0e03a595c19 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -52,11 +52,6 @@ static struct spi_board_info pcm037_spi_dev[] = {
 	},
 };
 
-/* Platform Data for MXC CSPI */
-static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
-	.num_chipselect = 2,
-};
-
 /* GPIO-keys input device */
 static struct gpio_keys_button pcm037_gpio_keys[] = {
 	{
@@ -163,7 +158,7 @@ int __init pcm037_eet_init_devices(void)
 
 	/* SPI */
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
-	imx31_add_spi_imx0(&pcm037_spi1_pdata);
+	imx31_add_spi_imx0(NULL);
 
 	imx_add_gpio_keys(&pcm037_gpio_keys_platform_data);
 
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 58b2da91be1c0..a813c192a018d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -11,7 +11,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -19,11 +18,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dma-imx.h>
-#include <linux/platform_data/spi-imx.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -227,20 +224,6 @@ static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 	return 0;
 }
 
-static int fsl_lpspi_prepare_message(struct spi_controller *controller,
-				     struct spi_message *msg)
-{
-	struct fsl_lpspi_data *fsl_lpspi =
-					spi_controller_get_devdata(controller);
-	struct spi_device *spi = msg->spi;
-	int gpio = fsl_lpspi->chipselect[spi->chip_select];
-
-	if (gpio_is_valid(gpio))
-		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
-
-	return 0;
-}
-
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -835,13 +818,10 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
-	struct spi_imx_master *lpspi_platform_info =
-		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int i, ret, irq;
+	int ret, irq;
 	u32 temp;
 	bool is_slave;
 
@@ -871,6 +851,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->dev.of_node = pdev->dev.of_node;
 	controller->bus_num = pdev->id;
 	controller->slave_abort = fsl_lpspi_slave_abort;
+	if (!fsl_lpspi->is_slave)
+		controller->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
@@ -878,29 +860,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		goto out_controller_put;
 	}
 
-	if (!fsl_lpspi->is_slave) {
-		for (i = 0; i < controller->num_chipselect; i++) {
-			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
-
-			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
-				cs_gpio = lpspi_platform_info->chipselect[i];
-
-			fsl_lpspi->chipselect[i] = cs_gpio;
-			if (!gpio_is_valid(cs_gpio))
-				continue;
-
-			ret = devm_gpio_request(&pdev->dev,
-						fsl_lpspi->chipselect[i],
-						DRIVER_NAME);
-			if (ret) {
-				dev_err(&pdev->dev, "can't get cs gpios\n");
-				goto out_controller_put;
-			}
-		}
-		controller->cs_gpios = fsl_lpspi->chipselect;
-		controller->prepare_message = fsl_lpspi_prepare_message;
-	}
-
 	init_completion(&fsl_lpspi->xfer_done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9d593675257e0..90793fc321358 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -8,7 +8,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -21,10 +20,9 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/property.h>
 
 #include <linux/platform_data/dma-imx.h>
-#include <linux/platform_data/spi-imx.h>
 
 #define DRIVER_NAME "spi_imx"
 
@@ -727,7 +725,7 @@ static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
 		reg |= MX31_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpiod)
 		reg |= (spi->chip_select) <<
 			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
 						  MX31_CSPICTRL_CS_SHIFT);
@@ -827,7 +825,7 @@ static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
 		reg |= MX21_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
-	if (!gpio_is_valid(spi->cs_gpio))
+	if (!spi->cs_gpiod)
 		reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
@@ -1056,20 +1054,6 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
 
-static void spi_imx_chipselect(struct spi_device *spi, int is_active)
-{
-	int active = is_active != BITBANG_CS_INACTIVE;
-	int dev_is_lowactive = !(spi->mode & SPI_CS_HIGH);
-
-	if (spi->mode & SPI_NO_CS)
-		return;
-
-	if (!gpio_is_valid(spi->cs_gpio))
-		return;
-
-	gpio_set_value(spi->cs_gpio, dev_is_lowactive ^ active);
-}
-
 static void spi_imx_set_burst_len(struct spi_imx_data *spi_imx, int n_bits)
 {
 	u32 ctrl;
@@ -1535,15 +1519,6 @@ static int spi_imx_setup(struct spi_device *spi)
 	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
-	if (spi->mode & SPI_NO_CS)
-		return 0;
-
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_direction_output(spi->cs_gpio,
-				      spi->mode & SPI_CS_HIGH ? 0 : 1);
-
-	spi_imx_chipselect(spi, BITBANG_CS_INACTIVE);
-
 	return 0;
 }
 
@@ -1601,20 +1576,14 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 			of_match_device(spi_imx_dt_ids, &pdev->dev);
-	struct spi_imx_master *mxc_platform_info =
-			dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, irq, spi_drctl;
+	int ret, irq, spi_drctl;
 	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 	bool slave_mode;
-
-	if (!np && !mxc_platform_info) {
-		dev_err(&pdev->dev, "can't get the platform data\n");
-		return -EINVAL;
-	}
+	u32 val;
 
 	slave_mode = devtype_data->has_slavemode &&
 			of_property_read_bool(np, "spi-slave");
@@ -1637,6 +1606,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->bus_num = np ? -1 : pdev->id;
+	master->use_gpio_descriptors = true;
 
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
@@ -1645,28 +1615,17 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data = devtype_data;
 
-	/* Get number of chip selects, either platform data or OF */
-	if (mxc_platform_info) {
-		master->num_chipselect = mxc_platform_info->num_chipselect;
-		if (mxc_platform_info->chipselect) {
-			master->cs_gpios = devm_kcalloc(&master->dev,
-				master->num_chipselect, sizeof(int),
-				GFP_KERNEL);
-			if (!master->cs_gpios)
-				return -ENOMEM;
-
-			for (i = 0; i < master->num_chipselect; i++)
-				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
-		}
-	} else {
-		u32 num_cs;
-
-		if (!of_property_read_u32(np, "num-cs", &num_cs))
-			master->num_chipselect = num_cs;
-		/* If not preset, default value of 1 is used */
-	}
+	/*
+	 * Get number of chip selects from device properties. This can be
+	 * coming from device tree or boardfiles, if it is not defined,
+	 * a default value of 3 chip selects will be used, as all the legacy
+	 * board files have <= 3 chip selects.
+	 */
+	if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
+		master->num_chipselect = val;
+	else
+		master->num_chipselect = 3;
 
-	spi_imx->bitbang.chipselect = spi_imx_chipselect;
 	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
 	spi_imx->bitbang.master->setup = spi_imx_setup;
@@ -1751,31 +1710,12 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	/* Request GPIO CS lines, if any */
-	if (!spi_imx->slave_mode && master->cs_gpios) {
-		for (i = 0; i < master->num_chipselect; i++) {
-			if (!gpio_is_valid(master->cs_gpios[i]))
-				continue;
-
-			ret = devm_gpio_request(&pdev->dev,
-						master->cs_gpios[i],
-						DRIVER_NAME);
-			if (ret) {
-				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
-					master->cs_gpios[i]);
-				goto out_spi_bitbang;
-			}
-		}
-	}
-
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
 	clk_disable(spi_imx->clk_per);
 	return ret;
 
-out_spi_bitbang:
-	spi_bitbang_stop(&spi_imx->bitbang);
 out_clk_put:
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
diff --git a/include/linux/platform_data/spi-imx.h b/include/linux/platform_data/spi-imx.h
deleted file mode 100644
index 328f670d10bd7..0000000000000
--- a/include/linux/platform_data/spi-imx.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __MACH_SPI_H_
-#define __MACH_SPI_H_
-
-/*
- * struct spi_imx_master - device.platform_data for SPI controller devices.
- * @chipselect: Array of chipselects for this master or NULL.  Numbers >= 0
- *              mean GPIO pins, -ENOENT means internal CSPI chipselect
- *              matching the position in the array.  E.g., if chipselect[1] =
- *              -ENOENT then a SPI slave using chip select 1 will use the
- *              native SS1 line of the CSPI.  Omitting the array will use
- *              all native chip selects.
-
- *              Normally you want to use gpio based chip selects as the CSPI
- *              module tries to be intelligent about when to assert the
- *              chipselect:  The CSPI module deasserts the chipselect once it
- *              runs out of input data.  The other problem is that it is not
- *              possible to mix between high active and low active chipselects
- *              on one single bus using the internal chipselects.
- *              Unfortunately, on some SoCs, Freescale decided to put some
- *              chipselects on dedicated pins which are not usable as gpios,
- *              so we have to support the internal chipselects.
- *
- * @num_chipselect: If @chipselect is specified, ARRAY_SIZE(chipselect),
- *                  otherwise the number of native chip selects.
- */
-struct spi_imx_master {
-	int	*chipselect;
-	int	num_chipselect;
-};
-
-#endif /* __MACH_SPI_H_*/
-- 
2.39.2



