Return-Path: <stable+bounces-189869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F1CC0AD2D
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36407189DE4C
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92B19AD90;
	Sun, 26 Oct 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHJ4QGT0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7545C0B
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495086; cv=none; b=c+4nxuDN23EXoT8Kw+5wP7KoKtr842oQklBfHmhM3ZK56C3xNdS2l8Anv2dd22iLc60Nbdic8piS3DFtFbBVLP+CAu9RShM9DCOVyjvZpvFVHHWIBSUT0zGx+05YSsoI76tTvBzhJia9P9TTZ8agwxZCl6Za0BiAy7NLsSQ/OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495086; c=relaxed/simple;
	bh=iw4Ig86xLWeyC0pu6prZYaNR1jyK4JxDqbS2XjwUyrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6C/lVf5DzUlnRna15WdNw59CP175LYm54HKIYFeQV3Go20/V0wG9CF/WtJOaGQi7nHjarI7yDSiKYTIqgzqGgfpBGJ70RM3mcLJWKBrBIjv6ueDU9Wp4/lrq1EyC00o2zN9D+IQr71OCyT4/CzI4MEpw47/H1Xvo0QtKSJhcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHJ4QGT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B985C4CEE7;
	Sun, 26 Oct 2025 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495085;
	bh=iw4Ig86xLWeyC0pu6prZYaNR1jyK4JxDqbS2XjwUyrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHJ4QGT0LOhOjTGXA/su6XVbT7kta6dEUaobXi5UzE3dJEnAkPsn38FTGjKW/GoCN
	 vSlQs2a/TucurzEdUt0JsLsMfPEOz3iP6/SEXrTfg9yaQOnUTDHXykvEgWiUBy3HPD
	 RreA2ZuOM8SL/UP0VhJ3qFUutQxG0Cew/ZXCJ5qhxvoU/OgB9fw0RON7aw54mbnB0U
	 6R2GWl7w4K5tk0MvyLIWSLDTJ6Cb2Gy3E6u0DH2o9Or5x7fG+vQvW5jOCdQ0vMqrHA
	 wqsMKEjsXBmNfT3fRyUmgjpUacTDJl6UIUgRWO5XXjm7Zwzt6ScCZQy16roBBB+8sU
	 xWJH0Jidt2dyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] gpio: regmap: Allow to allocate regmap-irq device
Date: Sun, 26 Oct 2025 12:11:19 -0400
Message-ID: <20251026161121.102839-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102645-grueling-ramrod-c231@gregkh>
References: <2025102645-grueling-ramrod-c231@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-regmap.c  | 29 +++++++++++++++++++++++++++--
 include/linux/gpio/regmap.h | 11 +++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 3f8b72311f8e8..7633c24ba27cd 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -32,6 +32,11 @@ struct gpio_regmap {
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
@@ -215,6 +220,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
  */
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
 {
+	struct irq_domain *irq_domain;
 	struct gpio_regmap *gpio;
 	struct gpio_chip *chip;
 	int ret;
@@ -295,8 +301,22 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
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
@@ -317,6 +337,11 @@ EXPORT_SYMBOL_GPL(gpio_regmap_register);
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
index c722c67668c6e..19b52ac03a5de 100644
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


