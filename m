Return-Path: <stable+bounces-191818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1650C2533F
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 866B534621E
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713F34A797;
	Fri, 31 Oct 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPk+pzvH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0916FF37
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916336; cv=none; b=fSEV34QukGEODSFR9B41KraFPIqga9YNZm1gTTKdfhDl+9s+nfnbiz1S1abfndS8BrGMCOFrrv+3Ufz+C32p/m9lYkYQ9y4C1YlLFzQLcviB4H9AaLra+3C5Y/Yj814dCTIign6yGAJgsvBsUHZ1l/VDB5SM91zrl8gJzBreRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916336; c=relaxed/simple;
	bh=ZEzUbwcwyY+mUO/2cZoZw/SBkD9X90pQxgk+UWjHbcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDGg5LeomlDyFccjDJcmZSnLQBXWuZoZUtgwJG8dH0k3ulb8ndmbFqu1nfw24TwRpfjcjXSmPs10i34lCm0qEOM9c0F8wXW3xXZ8u0TvqiDPS3EZB4c88iPbpL3yfDnfoPm020LhsRe0nEa93hmhBh/ARRGacdGgNwY+RlXHbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPk+pzvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CFAC4CEF8;
	Fri, 31 Oct 2025 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916336;
	bh=ZEzUbwcwyY+mUO/2cZoZw/SBkD9X90pQxgk+UWjHbcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jPk+pzvHxmEuaxBcCyj6GoHBSm5zaaBRCty5gLQbUpSeleBRqWMRJM1Wb0hfwXExa
	 WDHP4akn9zTJkABl109DAf66E8pi75DcgTMXuTfva0fW9n7/K+ADEBO8LSIFoFtYCR
	 TSITvs4JDr3RmHNMu+xnzFd6WlUbAW/zBsETkktFJFZFmuUY9O7npGs1HqtA7Gj8+E
	 Z3pV8QRG4hno6cFQXe+/wZNT08buQPjo9vVrez4MEnPkFJT7MU8uL+5nIjWo+LTLSv
	 XE9IBkW3VHVBsHIv08aAZrUOliFlRXD4OuRC+jhisdZMLbwWeJitdJnw9mhJDNltBv
	 mS+rKUDpwSI1Q==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Lee Jones <lee@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.6.y 3/5] gpio: regmap: Allow to allocate regmap-irq device
Date: Fri, 31 Oct 2025 22:11:59 +0900
Message-ID: <20251031131203.973066-3-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-plaster-sitting-ed2e@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100; i=wbg@kernel.org; h=from:subject; bh=HVbMB8bh5/vsDUmwlOsAeHFaliwlUT0v0pr+gjIfWAE=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksm2fdeHDL0UBeiEvnSu7RfX28djU9HZLXArYz2Etvs /n8WSuno5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZiIKi8jw1xb310X2Pe8X6Vz R//idhZZ+6oNNypZVorMEj3zoKU+LZPhn3mniPZOl5SFB6fu17yU6ZXIHnXXJCfU6uyUuw/WTr9 jywkA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

[ Upstream commit 553b75d4bfe9264f631d459fe9996744e0672b0e ]

GPIO controller often have support for IRQ: allow to easily allocate
both gpio-regmap and regmap-irq in one operation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Link: https://lore.kernel.org/r/20250824-mdb-max7360-support-v14-5-435cfda2b1ea@bootlin.com
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 2ba5772e530f ("gpio: idio-16: Define fixed direction of the GPIO lines")
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 drivers/gpio/gpio-regmap.c  | 29 +++++++++++++++++++++++++++--
 include/linux/gpio/regmap.h | 11 +++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index c08c8e528867..c789001241fd 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -30,6 +30,11 @@ struct gpio_regmap {
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
 
+#ifdef CONFIG_REGMAP_IRQ
+	int regmap_irq_line;
+	struct regmap_irq_chip_data *irq_chip_data;
+#endif
+
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
@@ -203,6 +208,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
  */
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
 {
+	struct irq_domain *irq_domain;
 	struct gpio_regmap *gpio;
 	struct gpio_chip *chip;
 	int ret;
@@ -278,8 +284,22 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (ret < 0)
 		goto err_free_gpio;
 
-	if (config->irq_domain) {
-		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);
+#ifdef CONFIG_REGMAP_IRQ
+	if (config->regmap_irq_chip) {
+		gpio->regmap_irq_line = config->regmap_irq_line;
+		ret = regmap_add_irq_chip_fwnode(dev_fwnode(config->parent), config->regmap,
+						 config->regmap_irq_line, config->regmap_irq_flags,
+						 0, config->regmap_irq_chip, &gpio->irq_chip_data);
+		if (ret)
+			goto err_free_gpio;
+
+		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
+	} else
+#endif
+	irq_domain = config->irq_domain;
+
+	if (irq_domain) {
+		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
 		if (ret)
 			goto err_remove_gpiochip;
 	}
@@ -300,6 +320,11 @@ EXPORT_SYMBOL_GPL(gpio_regmap_register);
  */
 void gpio_regmap_unregister(struct gpio_regmap *gpio)
 {
+#ifdef CONFIG_REGMAP_IRQ
+	if (gpio->irq_chip_data)
+		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
+#endif
+
 	gpiochip_remove(&gpio->gpio_chip);
 	kfree(gpio);
 }
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index a9f7b7faf57b..76f6c73106dc 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -40,6 +40,11 @@ struct regmap;
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
+ * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure. If
+ *			set, a regmap-irq device will be created and the IRQ
+ *			domain will be set accordingly.
+ * @regmap_irq_line	(Optional) The IRQ the device uses to signal interrupts.
+ * @regmap_irq_flags	(Optional) The IRQF_ flags to use for the interrupt.
  *
  * The ->reg_mask_xlate translates a given base address and GPIO offset to
  * register and mask pair. The base address is one of the given register
@@ -78,6 +83,12 @@ struct gpio_regmap_config {
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
 
+#ifdef CONFIG_REGMAP_IRQ
+	struct regmap_irq_chip *regmap_irq_chip;
+	int regmap_irq_line;
+	unsigned long regmap_irq_flags;
+#endif
+
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
-- 
2.51.0


