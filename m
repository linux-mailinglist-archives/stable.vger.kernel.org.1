Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28175524B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGPUGK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjGPUGJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B3E123
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EBF60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D3BC433C7;
        Sun, 16 Jul 2023 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537966;
        bh=LwYh+/OP6RUY5udHQUnWWfkMZuIfY1s0LJg+JBO5MW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slGAt1A17kRxqJMfk3/aNcXBELvwLqPjLZBAk5/4lnVtSW8GnbuGYx9eX862JVM21
         h0K8uZMcnDGLHTMPS3If7FcK3E8eU5Q8uulHfVFpstfdZYU9oVFHHrFY5aaDswXgs1
         01udIByq0WwdcjqjFEfPy8FpNb/dHmUAqHXHBpK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        andy.shevchenko@gmail.com, Andreas Kemnade <andreas@kemnade.info>,
        Lee Jones <lee@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 285/800] ARM/mfd/gpio: Fixup TPS65010 regression on OMAP1 OSK1
Date:   Sun, 16 Jul 2023 21:42:18 +0200
Message-ID: <20230716194955.707364710@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit c32c81f3dbdfd68f6ab20a29ad86f811aed36e4e ]

Aaro reports problems on the OSK1 board after we altered
the dynamic base for GPIO allocations.

It appears this happens because the OMAP driver now
allocates GPIO numbers dynamically, so all that is
references by number is a bit up in the air.

Let's bite the bullet and try to just move the gpio_chip
in the tps65010 MFD driver over to using dynamic allocations.
Alter everything in the OSK1 board file to use a GPIO
descriptor table and lookups.

Utilize the NULL device to define some board-specific
GPIO lookups and use these to immediately look up the
same GPIOs, convert to IRQ numbers and pass as resources
to the devices. This is ugly but should work.

The .setup() callback for tps65010 was used for some GPIO
hogging, but since the OSK1 is the only user in the entire
kernel we can alter the signatures to something that
is helpful and make a clean transition.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: andy.shevchenko@gmail.com
Cc: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Lee Jones <lee@kernel.org>
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-osk.c | 139 ++++++++++++++++++++++----------
 drivers/mfd/tps65010.c          |  14 ++--
 include/linux/mfd/tps65010.h    |  11 +--
 3 files changed, 104 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index df758c1f92373..a8ca8d427182d 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -25,7 +25,8 @@
  * with this program; if not, write  to the Free Software Foundation, Inc.,
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -64,13 +65,12 @@
 /* TPS65010 has four GPIOs.  nPG and LED2 can be treated like GPIOs with
  * alternate pin configurations for hardware-controlled blinking.
  */
-#define OSK_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
-#	define OSK_TPS_GPIO_USB_PWR_EN	(OSK_TPS_GPIO_BASE + 0)
-#	define OSK_TPS_GPIO_LED_D3	(OSK_TPS_GPIO_BASE + 1)
-#	define OSK_TPS_GPIO_LAN_RESET	(OSK_TPS_GPIO_BASE + 2)
-#	define OSK_TPS_GPIO_DSP_PWR_EN	(OSK_TPS_GPIO_BASE + 3)
-#	define OSK_TPS_GPIO_LED_D9	(OSK_TPS_GPIO_BASE + 4)
-#	define OSK_TPS_GPIO_LED_D2	(OSK_TPS_GPIO_BASE + 5)
+#define OSK_TPS_GPIO_USB_PWR_EN	0
+#define OSK_TPS_GPIO_LED_D3	1
+#define OSK_TPS_GPIO_LAN_RESET	2
+#define OSK_TPS_GPIO_DSP_PWR_EN	3
+#define OSK_TPS_GPIO_LED_D9	4
+#define OSK_TPS_GPIO_LED_D2	5
 
 static struct mtd_partition osk_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
@@ -174,11 +174,20 @@ static const struct gpio_led tps_leds[] = {
 	/* NOTE:  D9 and D2 have hardware blink support.
 	 * Also, D9 requires non-battery power.
 	 */
-	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9",
-			.default_trigger = "disk-activity", },
-	{ .gpio = OSK_TPS_GPIO_LED_D2, .name = "d2", },
-	{ .gpio = OSK_TPS_GPIO_LED_D3, .name = "d3", .active_low = 1,
-			.default_trigger = "heartbeat", },
+	{ .name = "d9", .default_trigger = "disk-activity", },
+	{ .name = "d2", },
+	{ .name = "d3", .default_trigger = "heartbeat", },
+};
+
+static struct gpiod_lookup_table tps_leds_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		/* Use local offsets on TPS65010 */
+		GPIO_LOOKUP_IDX("tps65010", OSK_TPS_GPIO_LED_D9, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("tps65010", OSK_TPS_GPIO_LED_D2, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("tps65010", OSK_TPS_GPIO_LED_D3, NULL, 2, GPIO_ACTIVE_LOW),
+		{ }
+	},
 };
 
 static struct gpio_led_platform_data tps_leds_data = {
@@ -192,29 +201,34 @@ static struct platform_device osk5912_tps_leds = {
 	.dev.platform_data	= &tps_leds_data,
 };
 
-static int osk_tps_setup(struct i2c_client *client, void *context)
+/* The board just hold these GPIOs hogged from setup to teardown */
+static struct gpio_desc *eth_reset;
+static struct gpio_desc *vdd_dsp;
+
+static int osk_tps_setup(struct i2c_client *client, struct gpio_chip *gc)
 {
+	struct gpio_desc *d;
 	if (!IS_BUILTIN(CONFIG_TPS65010))
 		return -ENOSYS;
 
 	/* Set GPIO 1 HIGH to disable VBUS power supply;
 	 * OHCI driver powers it up/down as needed.
 	 */
-	gpio_request(OSK_TPS_GPIO_USB_PWR_EN, "n_vbus_en");
-	gpio_direction_output(OSK_TPS_GPIO_USB_PWR_EN, 1);
+	d = gpiochip_request_own_desc(gc, OSK_TPS_GPIO_USB_PWR_EN, "n_vbus_en",
+				      GPIO_ACTIVE_HIGH, GPIOD_OUT_HIGH);
 	/* Free the GPIO again as the driver will request it */
-	gpio_free(OSK_TPS_GPIO_USB_PWR_EN);
+	gpiochip_free_own_desc(d);
 
 	/* Set GPIO 2 high so LED D3 is off by default */
 	tps65010_set_gpio_out_value(GPIO2, HIGH);
 
 	/* Set GPIO 3 low to take ethernet out of reset */
-	gpio_request(OSK_TPS_GPIO_LAN_RESET, "smc_reset");
-	gpio_direction_output(OSK_TPS_GPIO_LAN_RESET, 0);
+	eth_reset = gpiochip_request_own_desc(gc, OSK_TPS_GPIO_LAN_RESET, "smc_reset",
+					      GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW);
 
 	/* GPIO4 is VDD_DSP */
-	gpio_request(OSK_TPS_GPIO_DSP_PWR_EN, "dsp_power");
-	gpio_direction_output(OSK_TPS_GPIO_DSP_PWR_EN, 1);
+	vdd_dsp = gpiochip_request_own_desc(gc, OSK_TPS_GPIO_DSP_PWR_EN, "dsp_power",
+					    GPIO_ACTIVE_HIGH, GPIOD_OUT_HIGH);
 	/* REVISIT if DSP support isn't configured, power it off ... */
 
 	/* Let LED1 (D9) blink; leds-gpio may override it */
@@ -232,15 +246,22 @@ static int osk_tps_setup(struct i2c_client *client, void *context)
 
 	/* register these three LEDs */
 	osk5912_tps_leds.dev.parent = &client->dev;
+	gpiod_add_lookup_table(&tps_leds_gpio_table);
 	platform_device_register(&osk5912_tps_leds);
 
 	return 0;
 }
 
+static void osk_tps_teardown(struct i2c_client *client, struct gpio_chip *gc)
+{
+	gpiochip_free_own_desc(eth_reset);
+	gpiochip_free_own_desc(vdd_dsp);
+}
+
 static struct tps65010_board tps_board = {
-	.base		= OSK_TPS_GPIO_BASE,
 	.outmask	= 0x0f,
 	.setup		= osk_tps_setup,
+	.teardown	= osk_tps_teardown,
 };
 
 static struct i2c_board_info __initdata osk_i2c_board_info[] = {
@@ -263,11 +284,6 @@ static void __init osk_init_smc91x(void)
 {
 	u32 l;
 
-	if ((gpio_request(0, "smc_irq")) < 0) {
-		printk("Error requesting gpio 0 for smc91x irq\n");
-		return;
-	}
-
 	/* Check EMIFS wait states to fix errors with SMC_GET_PKT_HDR */
 	l = omap_readl(EMIFS_CCS(1));
 	l |= 0x3;
@@ -279,10 +295,6 @@ static void __init osk_init_cf(int seg)
 	struct resource *res = &osk5912_cf_resources[1];
 
 	omap_cfg_reg(M7_1610_GPIO62);
-	if ((gpio_request(62, "cf_irq")) < 0) {
-		printk("Error requesting gpio 62 for CF irq\n");
-		return;
-	}
 
 	switch (seg) {
 	/* NOTE: CS0 could be configured too ... */
@@ -308,18 +320,17 @@ static void __init osk_init_cf(int seg)
 		seg, omap_readl(EMIFS_CCS(seg)), omap_readl(EMIFS_ACS(seg)));
 	omap_writel(0x0004a1b3, EMIFS_CCS(seg));	/* synch mode 4 etc */
 	omap_writel(0x00000000, EMIFS_ACS(seg));	/* OE hold/setup */
-
-	/* the CF I/O IRQ is really active-low */
-	irq_set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_FALLING);
 }
 
 static struct gpiod_lookup_table osk_usb_gpio_table = {
 	.dev_id = "ohci",
 	.table = {
 		/* Power GPIO on the I2C-attached TPS65010 */
-		GPIO_LOOKUP("tps65010", 0, "power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("tps65010", OSK_TPS_GPIO_USB_PWR_EN, "power",
+			    GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP(OMAP_GPIO_LABEL, 9, "overcurrent",
 			    GPIO_ACTIVE_HIGH),
+		{ }
 	},
 };
 
@@ -341,8 +352,25 @@ static struct omap_usb_config osk_usb_config __initdata = {
 
 #define EMIFS_CS3_VAL	(0x88013141)
 
+static struct gpiod_lookup_table osk_irq_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		/* GPIO used for SMC91x IRQ */
+		GPIO_LOOKUP(OMAP_GPIO_LABEL, 0, "smc_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used for CF IRQ */
+		GPIO_LOOKUP("gpio-48-63", 14, "cf_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used by the TPS65010 chip */
+		GPIO_LOOKUP("mpuio", 1, "tps65010",
+			    GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static void __init osk_init(void)
 {
+	struct gpio_desc *d;
 	u32 l;
 
 	osk_init_smc91x();
@@ -359,10 +387,31 @@ static void __init osk_init(void)
 
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
-	osk5912_smc91x_resources[1].start = gpio_to_irq(0);
-	osk5912_smc91x_resources[1].end = gpio_to_irq(0);
-	osk5912_cf_resources[0].start = gpio_to_irq(62);
-	osk5912_cf_resources[0].end = gpio_to_irq(62);
+
+	/*
+	 * Add the GPIOs to be used as IRQs and immediately look them up
+	 * to be passed as an IRQ resource. This is ugly but should work
+	 * until the day we convert to device tree.
+	 */
+	gpiod_add_lookup_table(&osk_irq_gpio_table);
+
+	d = gpiod_get(NULL, "smc_irq", GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get SMC IRQ GPIO descriptor\n");
+	} else {
+		irq_set_irq_type(gpiod_to_irq(d), IRQ_TYPE_EDGE_RISING);
+		osk5912_smc91x_resources[1] = DEFINE_RES_IRQ(gpiod_to_irq(d));
+	}
+
+	d = gpiod_get(NULL, "cf_irq", GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get CF IRQ GPIO descriptor\n");
+	} else {
+		/* the CF I/O IRQ is really active-low */
+		irq_set_irq_type(gpiod_to_irq(d), IRQ_TYPE_EDGE_FALLING);
+		osk5912_cf_resources[0] = DEFINE_RES_IRQ(gpiod_to_irq(d));
+	}
+
 	platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));
 
 	l = omap_readl(USB_TRANSCEIVER_CTRL);
@@ -372,13 +421,15 @@ static void __init osk_init(void)
 	gpiod_add_lookup_table(&osk_usb_gpio_table);
 	omap1_usb_init(&osk_usb_config);
 
+	omap_serial_init();
+
 	/* irq for tps65010 chip */
 	/* bootloader effectively does:  omap_cfg_reg(U19_1610_MPUIO1); */
-	if (gpio_request(OMAP_MPUIO(1), "tps65010") == 0)
-		gpio_direction_input(OMAP_MPUIO(1));
-
-	omap_serial_init();
-	osk_i2c_board_info[0].irq = gpio_to_irq(OMAP_MPUIO(1));
+	d = gpiod_get(NULL, "tps65010", GPIOD_IN);
+	if (IS_ERR(d))
+		pr_err("Unable to get TPS65010 IRQ GPIO descriptor\n");
+	else
+		osk_i2c_board_info[0].irq = gpiod_to_irq(d);
 	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
 }
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index fb733288cca3b..faea4ff44c6fe 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -506,12 +506,8 @@ static void tps65010_remove(struct i2c_client *client)
 	struct tps65010		*tps = i2c_get_clientdata(client);
 	struct tps65010_board	*board = dev_get_platdata(&client->dev);
 
-	if (board && board->teardown) {
-		int status = board->teardown(client, board->context);
-		if (status < 0)
-			dev_dbg(&client->dev, "board %s %s err %d\n",
-				"teardown", client->name, status);
-	}
+	if (board && board->teardown)
+		board->teardown(client, &tps->chip);
 	if (client->irq > 0)
 		free_irq(client->irq, tps);
 	cancel_delayed_work_sync(&tps->work);
@@ -619,7 +615,7 @@ static int tps65010_probe(struct i2c_client *client)
 				tps, DEBUG_FOPS);
 
 	/* optionally register GPIOs */
-	if (board && board->base != 0) {
+	if (board) {
 		tps->outmask = board->outmask;
 
 		tps->chip.label = client->name;
@@ -632,7 +628,7 @@ static int tps65010_probe(struct i2c_client *client)
 		/* NOTE:  only partial support for inputs; nyet IRQs */
 		tps->chip.get = tps65010_gpio_get;
 
-		tps->chip.base = board->base;
+		tps->chip.base = -1;
 		tps->chip.ngpio = 7;
 		tps->chip.can_sleep = 1;
 
@@ -641,7 +637,7 @@ static int tps65010_probe(struct i2c_client *client)
 			dev_err(&client->dev, "can't add gpiochip, err %d\n",
 					status);
 		else if (board->setup) {
-			status = board->setup(client, board->context);
+			status = board->setup(client, &tps->chip);
 			if (status < 0) {
 				dev_dbg(&client->dev,
 					"board %s %s err %d\n",
diff --git a/include/linux/mfd/tps65010.h b/include/linux/mfd/tps65010.h
index a1fb9bc5311de..5edf1aef11185 100644
--- a/include/linux/mfd/tps65010.h
+++ b/include/linux/mfd/tps65010.h
@@ -28,6 +28,8 @@
 #ifndef __LINUX_I2C_TPS65010_H
 #define __LINUX_I2C_TPS65010_H
 
+struct gpio_chip;
+
 /*
  * ----------------------------------------------------------------------------
  * Registers, all 8 bits
@@ -176,12 +178,10 @@ struct i2c_client;
 
 /**
  * struct tps65010_board - packages GPIO and LED lines
- * @base: the GPIO number to assign to GPIO-1
  * @outmask: bit (N-1) is set to allow GPIO-N to be used as an
  *	(open drain) output
  * @setup: optional callback issued once the GPIOs are valid
  * @teardown: optional callback issued before the GPIOs are invalidated
- * @context: optional parameter passed to setup() and teardown()
  *
  * Board data may be used to package the GPIO (and LED) lines for use
  * in by the generic GPIO and LED frameworks.  The first four GPIOs
@@ -193,12 +193,9 @@ struct i2c_client;
  * devices in their initial states using these GPIOs.
  */
 struct tps65010_board {
-	int				base;
 	unsigned			outmask;
-
-	int		(*setup)(struct i2c_client *client, void *context);
-	int		(*teardown)(struct i2c_client *client, void *context);
-	void		*context;
+	int		(*setup)(struct i2c_client *client, struct gpio_chip *gc);
+	void		(*teardown)(struct i2c_client *client, struct gpio_chip *gc);
 };
 
 #endif /*  __LINUX_I2C_TPS65010_H */
-- 
2.39.2



