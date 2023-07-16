Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751FA755253
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGPUGc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGPUGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E0E43
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8835760EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C20C433C7;
        Sun, 16 Jul 2023 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537989;
        bh=zVCOs3Q5iKUn8JvqHpwVgOlHgOX6DcZgocMAUj+zYF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDMGylOhtbZIHzDJSno5Gt09R8AuvGe8d2bhjlHfRyhnNJMUexFVbwTNUmf1uJJSz
         5JFtfkpl0nmkumn7OQKuYQRP6AhiYARVFvUdLU+bK2gaOBF7GtS2V+G7lGIll0xtfo
         rKSDv7WSfJtYZgvCwGbf/RZDiIs5FFLc6NiSuavQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 292/800] ARM: omap1: Make serial wakeup GPIOs use descriptors
Date:   Sun, 16 Jul 2023 21:42:25 +0200
Message-ID: <20230716194955.866378569@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit df89de979f0e09e1896d59312362ce1657b848eb ]

The code in serial.c looks up GPIOs corresponding to a line
on the UART when muxed in as GPIO to use this as a wakeup
on serial activity for OMAP1.

Utilize the NULL device to define some board-specific
GPIO lookups and use these to immediately look up the
same GPIOs, set as input and convert to IRQ numbers,
then set these to wakeup IRQs. This is ugly but should work.

This is only needed on the OSK1 and Nokia 770 devices that
use the OMAP16xx.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-nokia770.c |  7 +++++++
 arch/arm/mach-omap1/board-osk.c      |  7 +++++++
 arch/arm/mach-omap1/serial.c         | 30 ++++++++++++++--------------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index dd1a8f439fac4..5ea27ca26abf2 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -294,6 +294,13 @@ static struct gpiod_lookup_table nokia770_irq_gpio_table = {
 		/* GPIO used for tahvo IRQ */
 		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
 			    GPIO_ACTIVE_HIGH),
+		/* GPIOs used by serial wakeup IRQs */
+		GPIO_LOOKUP_IDX("gpio-32-47", 5, "wakeup", 0,
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-16-31", 2, "wakeup", 1,
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-48-63", 1, "wakeup", 2,
+			    GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index a8ca8d427182d..463687b9ca52a 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -364,6 +364,13 @@ static struct gpiod_lookup_table osk_irq_gpio_table = {
 		/* GPIO used by the TPS65010 chip */
 		GPIO_LOOKUP("mpuio", 1, "tps65010",
 			    GPIO_ACTIVE_HIGH),
+		/* GPIOs used for serial wakeup IRQs */
+		GPIO_LOOKUP_IDX("gpio-32-47", 5, "wakeup", 0,
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-16-31", 2, "wakeup", 1,
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-48-63", 1, "wakeup", 2,
+			    GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index c7f5906457748..3adceb97138fb 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -4,7 +4,8 @@
  *
  * OMAP1 serial support.
  */
-#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -196,39 +197,38 @@ void omap_serial_wake_trigger(int enable)
 	}
 }
 
-static void __init omap_serial_set_port_wakeup(int gpio_nr)
+static void __init omap_serial_set_port_wakeup(int idx)
 {
+	struct gpio_desc *d;
 	int ret;
 
-	ret = gpio_request(gpio_nr, "UART wake");
-	if (ret < 0) {
-		printk(KERN_ERR "Could not request UART wake GPIO: %i\n",
-		       gpio_nr);
+	d = gpiod_get_index(NULL, "wakeup", idx, GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get UART wakeup GPIO descriptor\n");
 		return;
 	}
-	gpio_direction_input(gpio_nr);
-	ret = request_irq(gpio_to_irq(gpio_nr), &omap_serial_wake_interrupt,
+	ret = request_irq(gpiod_to_irq(d), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
-		gpio_free(gpio_nr);
-		printk(KERN_ERR "No interrupt for UART wake GPIO: %i\n",
-		       gpio_nr);
+		gpiod_put(d);
+		pr_err("No interrupt for UART%d wake GPIO\n", idx + 1);
 		return;
 	}
-	enable_irq_wake(gpio_to_irq(gpio_nr));
+	enable_irq_wake(gpiod_to_irq(d));
 }
 
+
 int __init omap_serial_wakeup_init(void)
 {
 	if (!cpu_is_omap16xx())
 		return 0;
 
 	if (uart1_ck != NULL)
-		omap_serial_set_port_wakeup(37);
+		omap_serial_set_port_wakeup(0);
 	if (uart2_ck != NULL)
-		omap_serial_set_port_wakeup(18);
+		omap_serial_set_port_wakeup(1);
 	if (uart3_ck != NULL)
-		omap_serial_set_port_wakeup(49);
+		omap_serial_set_port_wakeup(2);
 
 	return 0;
 }
-- 
2.39.2



