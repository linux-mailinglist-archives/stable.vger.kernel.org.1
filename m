Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B723674C324
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjGIL2v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGIL1y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8590B1AB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0664D60BEB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CDEC433C8;
        Sun,  9 Jul 2023 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902072;
        bh=d8KXM6zNOLHtK2ETmfcjl5NQUFFmS8LgIItknJ0VzVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vnqBQEdgzB/HlV1DpdBpj3nL269r9pglhB6C9zajUMc/k3KHNdP3BxWuuUBTPdECr
         THH5ztBac1SH8t230xEuEQaj/RfvjNwLnH5IkLjd75kFLGdUuaqsAEzJ8wN5dSumP7
         XqAbZszf+tPUAVtamx+EJJjrSapdZ0objhT1gRiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 217/431] ARM: omap1: Remove reliance on GPIO numbers from PalmTE
Date:   Sun,  9 Jul 2023 13:12:45 +0200
Message-ID: <20230709111456.249575063@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 4c40db6249ff1da335b276bdd6c3c3462efbc2ab ]

It appears this happens because the OMAP driver now
allocates GPIO numbers dynamically, so all that is
references by number is a bit up in the air.

Utilize the NULL device to define some board-specific
GPIO lookups and use these to immediately look up the
same GPIOs, convert to IRQ numbers and pass as resources
to the devices. This is ugly but should work.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-palmte.c | 51 ++++++++++++++++++------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index f79c497f04d57..49b7757cb2fd3 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -13,7 +13,8 @@
  *
  * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
  */
-#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -187,23 +188,6 @@ static struct spi_board_info palmte_spi_info[] __initdata = {
 	},
 };
 
-static void __init palmte_misc_gpio_setup(void)
-{
-	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
-	if (gpio_request(PALMTE_PINTDAV_GPIO, "TSC2102 PINTDAV") < 0) {
-		printk(KERN_ERR "Could not reserve PINTDAV GPIO!\n");
-		return;
-	}
-	gpio_direction_input(PALMTE_PINTDAV_GPIO);
-
-	/* Set USB-or-DC-IN pin as input (unused) */
-	if (gpio_request(PALMTE_USB_OR_DC_GPIO, "USB/DC-IN") < 0) {
-		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
-		return;
-	}
-	gpio_direction_input(PALMTE_USB_OR_DC_GPIO);
-}
-
 #if IS_ENABLED(CONFIG_MMC_OMAP)
 
 static struct omap_mmc_platform_data _palmte_mmc_config = {
@@ -231,8 +215,23 @@ static void palmte_mmc_init(void)
 
 #endif /* CONFIG_MMC_OMAP */
 
+static struct gpiod_lookup_table palmte_irq_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		/* GPIO used for TSC2102 PINTDAV IRQ */
+		GPIO_LOOKUP("gpio-0-15", PALMTE_PINTDAV_GPIO, "tsc2102_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used for USB or DC input detection */
+		GPIO_LOOKUP("gpio-0-15", PALMTE_USB_OR_DC_GPIO, "usb_dc_irq",
+			    GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static void __init omap_palmte_init(void)
 {
+	struct gpio_desc *d;
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
@@ -243,9 +242,21 @@ static void __init omap_palmte_init(void)
 
 	platform_add_devices(palmte_devices, ARRAY_SIZE(palmte_devices));
 
-	palmte_spi_info[0].irq = gpio_to_irq(PALMTE_PINTDAV_GPIO);
+	gpiod_add_lookup_table(&palmte_irq_gpio_table);
+	d = gpiod_get(NULL, "tsc2102_irq", GPIOD_IN);
+	if (IS_ERR(d))
+		pr_err("Unable to get TSC2102 IRQ GPIO descriptor\n");
+	else
+		palmte_spi_info[0].irq = gpiod_to_irq(d);
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
-	palmte_misc_gpio_setup();
+
+	/* We are getting this just to set it up as input */
+	d = gpiod_get(NULL, "usb_dc_irq", GPIOD_IN);
+	if (IS_ERR(d))
+		pr_err("Unable to get USB/DC IRQ GPIO descriptor\n");
+	else
+		gpiod_put(d);
+
 	omap_serial_init();
 	omap1_usb_init(&palmte_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
-- 
2.39.2



