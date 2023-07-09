Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3474C311
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGIL16 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGIL15 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9613D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C900C60B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC43EC433C7;
        Sun,  9 Jul 2023 11:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902075;
        bh=SLJ9YWUEtU+W/QUmpPNUZ+LwYHmU9pFdsIE9St+jDcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9SpmrQ8RuZVyy+z0VMPf8t4+JLR47mrBS8Rik07IWV8mlGl76fYpVHJkyxDsix/1
         aTkFvHvCVJvPd1NHvxDEfD08Z1r9BuVd3pO/PBIrZLcYfWMlBZFOKSqbb7RmEDJeXz
         kmqnqnDBiGyZz7A121zqVoeaFHutuDkrEyTXD+dQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 218/431] ARM: omap1: Remove reliance on GPIO numbers from SX1
Date:   Sun,  9 Jul 2023 13:12:46 +0200
Message-ID: <20230709111456.272764621@linuxfoundation.org>
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

[ Upstream commit 480c82daa3e41873421dc2c9e2918ad7e21d7a0b ]

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
 arch/arm/mach-omap1/board-sx1.c | 40 +++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 0c0cdd5e77c79..a13c630be7b7f 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -11,7 +11,8 @@
 * Maintainters : Vladimir Ananiev (aka Vovan888), Sergge
 *		oslik.ru
 */
-#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -304,8 +305,23 @@ static struct platform_device *sx1_devices[] __initdata = {
 
 /*-----------------------------------------*/
 
+static struct gpiod_lookup_table sx1_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP("gpio-0-15", 1, "irda_off",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0-15", 11, "switch",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0-15", 15, "usb_on",
+			    GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static void __init omap_sx1_init(void)
 {
+	struct gpio_desc *d;
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
@@ -320,15 +336,25 @@ static void __init omap_sx1_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap1_usb_init(&sx1_usb_config);
 	sx1_mmc_init();
+	gpiod_add_lookup_table(&sx1_gpio_table);
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); can't do it here because i2c is not ready */
-	gpio_request(1, "A_IRDA_OFF");
-	gpio_request(11, "A_SWITCH");
-	gpio_request(15, "A_USB_ON");
-	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
-	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
-	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
+	d = gpiod_get(NULL, "irda_off", GPIOD_OUT_HIGH);
+	if (IS_ERR(d))
+		pr_err("Unable to get IRDA OFF GPIO descriptor\n");
+	else
+		gpiod_put(d);
+	d = gpiod_get(NULL, "switch", GPIOD_OUT_LOW);
+	if (IS_ERR(d))
+		pr_err("Unable to get SWITCH GPIO descriptor\n");
+	else
+		gpiod_put(d);
+	d = gpiod_get(NULL, "usb_on", GPIOD_OUT_LOW);
+	if (IS_ERR(d))
+		pr_err("Unable to get USB ON GPIO descriptor\n");
+	else
+		gpiod_put(d);
 
 	omapfb_set_lcd_config(&sx1_lcd_config);
 }
-- 
2.39.2



