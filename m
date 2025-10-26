Return-Path: <stable+bounces-189873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A671C0AD46
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B7E18963D3
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B321E0AD;
	Sun, 26 Oct 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqYebNTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093CB2080C8
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495933; cv=none; b=A8QSDGzqUFV/uxl2gNS5GGYwKNIJZJPBNeJTMYrj70DluiYDwk0Arl2vSBu7p0YrNMyZ7lRRnOMW21E2TfKoYP8IQ7NVp7a1wAUPbhcDk8IjSO/ZdDoaUmHZCUkOI2OcmAHx4pl3hSpgzGbaumWanJd3PAnHKmCpTACxcx3ONnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495933; c=relaxed/simple;
	bh=srEJgazbk4+HtfMJg7aaoUTBwprQM0kOhuWxM4FQTNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9wtpNCu4WGQsTayNpFcErELCnk2tXrJvZp2a+7bebVpKMeivd2d003NQWfAmziJzHw1PQB1/2DqXX8Wjn/SARHmNI43xiScRYt+l+Cz/H1tNRYGzCMJ86uj4Tpu6HAw1TwcRk0lstYZUMXmtvx+md2OXr4XE2KaX8P7mimFnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqYebNTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43DEC116B1;
	Sun, 26 Oct 2025 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495932;
	bh=srEJgazbk4+HtfMJg7aaoUTBwprQM0kOhuWxM4FQTNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqYebNTD4UHwuTNtJ06w33BdckJZ1Vkwm4ljleEflBraR5g+rpC2P3JWzzqDkaLwq
	 oU5a27Owai5O5fYregjRkPSY+KlegjvZPXutpW5Ml7vubVRnXBfMoatJaWpDXAClFs
	 lTQehuv1YnbKMcr/fPxu1vRwJYWBd4QKIA5VtcpV/t4UoFxLyAvz6DmyHC1G9shOm8
	 RODrCBP5DiPNvFzvNgox6JmWZBfJKhrhaKMThvBs6wuE2dZLViiUxlCuQYLem286NF
	 QRsRr+vwStqx3seddbY4W6CIQX47HSswTbhcVAtMbiWdC22A1q8QRzCxkR2/GmXPl1
	 POlx5zpmER8DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/3] gpio: regmap: add the .fixed_direction_output configuration parameter
Date: Sun, 26 Oct 2025 12:25:27 -0400
Message-ID: <20251026162528.110183-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026162528.110183-1-sashal@kernel.org>
References: <2025102610-dissuade-tamer-7d92@gregkh>
 <20251026162528.110183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-regmap.c  | 26 ++++++++++++++++++++++++--
 include/linux/gpio/regmap.h |  5 +++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 7633c24ba27cd..170d13b00ae72 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -31,6 +31,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	unsigned long *fixed_direction_output;
 
 #ifdef CONFIG_REGMAP_IRQ
 	int regmap_irq_line;
@@ -134,6 +135,13 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
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
@@ -283,6 +291,17 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			goto err_free_gpio;
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
 	/* if not set, assume there is only one register */
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	if (!gpio->ngpio_per_reg)
@@ -299,7 +318,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
-		goto err_free_gpio;
+		goto err_free_bitmap;
 
 #ifdef CONFIG_REGMAP_IRQ
 	if (config->regmap_irq_chip) {
@@ -308,7 +327,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 						 config->regmap_irq_line, config->regmap_irq_flags,
 						 0, config->regmap_irq_chip, &gpio->irq_chip_data);
 		if (ret)
-			goto err_free_gpio;
+			goto err_free_bitmap;
 
 		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
 	} else
@@ -325,6 +344,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 err_remove_gpiochip:
 	gpiochip_remove(chip);
+err_free_bitmap:
+	bitmap_free(gpio->fixed_direction_output);
 err_free_gpio:
 	kfree(gpio);
 	return ERR_PTR(ret);
@@ -343,6 +364,7 @@ void gpio_regmap_unregister(struct gpio_regmap *gpio)
 #endif
 
 	gpiochip_remove(&gpio->gpio_chip);
+	bitmap_free(gpio->fixed_direction_output);
 	kfree(gpio);
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_unregister);
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 19b52ac03a5de..e14ff69eaba1b 100644
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


