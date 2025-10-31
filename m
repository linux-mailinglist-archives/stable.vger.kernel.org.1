Return-Path: <stable+bounces-191796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C38C242DE
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8048F4F0A81
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A554329E6D;
	Fri, 31 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRikSg6D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E71328B77
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903230; cv=none; b=M17Cajt+4LJy+CtC4STzltzXVB20jkr1JHUGgpUkxIrEIH1uU2oDj1LMVrZcXuGlUIQ1lB+vhhKFSlnuXOKxtmVd5XZxxFDkk5y6ZnKSeGZG8cCGl+iojNLIi0ZTwmsBeD/icSSSLy8M8tl7TLbnjquYi71uWCyInU0HC40r3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903230; c=relaxed/simple;
	bh=JwagV3AmykhXaXbI7jvjIH8TJCBqDwxlPWCtygmqmZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGVVtEQztmnGZW5WRenOH/dMCHaArGWeXpJzrQJsUqcvaVOX8XNC9nysJehuUGr+NI9BJBaV+QHF4/1lJ3MwYScG8H+Q/hax678Psw8KM5o4sQI2jVT3rI/+cUCGzJFRZAGLHlcDW27xrBzegAq5s5bsY2PDM+x/ruzQjvA/iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRikSg6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7578C4CEF1;
	Fri, 31 Oct 2025 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761903229;
	bh=JwagV3AmykhXaXbI7jvjIH8TJCBqDwxlPWCtygmqmZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRikSg6DzJ910TjgffBlZOvxDXhk50p3hTx6IZJHds6G/d7LwIkud2Tl30AdmPdw5
	 ru6jJFDe08SATp3ogt5ZgHgFXWn8k5/4+95pgMkZIrX99n9iV3lVKNUnuHV4GPW4YX
	 DyyqOax8QHMMCsLaU7rgEWSN8Mw7PUL0GQnH4pUPkiAY0c6a7gVL+sfhOQs+BS7H2P
	 6B+EgrU3GAMBtykMnKLsR5g6fRt8cMzUugq5XhUBQgK6+otMDnZoOW09qOc/Kxs1Tv
	 i2W/BQqF3coV21IJMQazcGdDTgoTnVptEWKO42tz8LJt+tL/1y7mkDNFdtUaVuuFHb
	 ZuAIMFwyjM8zw==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.12.y 4/5] gpio: regmap: add the .fixed_direction_output configuration parameter
Date: Fri, 31 Oct 2025 18:33:18 +0900
Message-ID: <20251031093326.517803-4-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-shortage-tabby-5157@gregkh>
References: <2025102619-shortage-tabby-5157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=wbg@kernel.org; h=from:subject; bh=CcKjb8dooi21GMS+8lwsP6tX2xlcQsEQ8qduFkJnqBY=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksTUKlemeTDls+zdNpZn0bp1j0PjfoT87NhCPXXDbem Zg5w/ZsRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjAR3X+MDN1mTGoKAukMaips 5S+OmWTYL38QkqXfZJe0QfmdVc9HK4Z/ZlfcdmdeX5TQ88ahdZv1rr8OLWZ7tsonZa+//kQjpe4 ECwA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 00aaae60faf554c27c95e93d47f200a93ff266ef ]

There are GPIO controllers such as the one present in the LX2160ARDB
QIXIS FPGA which have fixed-direction input and output GPIO lines mixed
together in a single register. This cannot be modeled using the
gpio-regmap as-is since there is no way to present the true direction of
a GPIO line.

In order to make this use case possible, add a new configuration
parameter - fixed_direction_output - into the gpio_regmap_config
structure. This will enable user drivers to provide a bitmap that
represents the fixed direction of the GPIO lines.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 2ba5772e530f ("gpio: idio-16: Define fixed direction of the GPIO lines")
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 drivers/gpio/gpio-regmap.c  | 26 ++++++++++++++++++++++++--
 include/linux/gpio/regmap.h |  5 +++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index a9fd1398070e..fed9af5ff9ec 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -29,6 +29,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	unsigned long *fixed_direction_output;
 
 #ifdef CONFIG_REGMAP_IRQ
 	int regmap_irq_line;
@@ -122,6 +123,13 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 	unsigned int base, val, reg, mask;
 	int invert, ret;
 
+	if (gpio->fixed_direction_output) {
+		if (test_bit(offset, gpio->fixed_direction_output))
+			return GPIO_LINE_DIRECTION_OUT;
+		else
+			return GPIO_LINE_DIRECTION_IN;
+	}
+
 	if (gpio->reg_dat_base && !gpio->reg_set_base)
 		return GPIO_LINE_DIRECTION_IN;
 	if (gpio->reg_set_base && !gpio->reg_dat_base)
@@ -280,9 +288,20 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 		chip->direction_output = gpio_regmap_direction_output;
 	}
 
+	if (config->fixed_direction_output) {
+		gpio->fixed_direction_output = bitmap_alloc(chip->ngpio,
+							    GFP_KERNEL);
+		if (!gpio->fixed_direction_output) {
+			ret = -ENOMEM;
+			goto err_free_gpio;
+		}
+		bitmap_copy(gpio->fixed_direction_output,
+			    config->fixed_direction_output, chip->ngpio);
+	}
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
-		goto err_free_gpio;
+		goto err_free_bitmap;
 
 #ifdef CONFIG_REGMAP_IRQ
 	if (config->regmap_irq_chip) {
@@ -291,7 +310,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 						 config->regmap_irq_line, config->regmap_irq_flags,
 						 0, config->regmap_irq_chip, &gpio->irq_chip_data);
 		if (ret)
-			goto err_free_gpio;
+			goto err_free_bitmap;
 
 		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
 	} else
@@ -308,6 +327,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 err_remove_gpiochip:
 	gpiochip_remove(chip);
+err_free_bitmap:
+	bitmap_free(gpio->fixed_direction_output);
 err_free_gpio:
 	kfree(gpio);
 	return ERR_PTR(ret);
@@ -326,6 +347,7 @@ void gpio_regmap_unregister(struct gpio_regmap *gpio)
 #endif
 
 	gpiochip_remove(&gpio->gpio_chip);
+	bitmap_free(gpio->fixed_direction_output);
 	kfree(gpio);
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_unregister);
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 76f6c73106dc..cf55202aaec2 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -37,6 +37,10 @@ struct regmap;
  *			offset to a register/bitmask pair. If not
  *			given the default gpio_regmap_simple_xlate()
  *			is used.
+ * @fixed_direction_output:
+ *			(Optional) Bitmap representing the fixed direction of
+ *			the GPIO lines. Useful when there are GPIO lines with a
+ *			fixed direction mixed together in the same register.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -82,6 +86,7 @@ struct gpio_regmap_config {
 	int reg_stride;
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
+	unsigned long *fixed_direction_output;
 
 #ifdef CONFIG_REGMAP_IRQ
 	struct regmap_irq_chip *regmap_irq_chip;
-- 
2.51.0


