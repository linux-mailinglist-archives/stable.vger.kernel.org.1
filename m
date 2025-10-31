Return-Path: <stable+bounces-191819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C55C25342
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EEC42719A
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE834B185;
	Fri, 31 Oct 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGlnxdVC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173221E0BA
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916337; cv=none; b=i9Q6oaA6WMovUGDLzJ1SRnCdRWcMdS6tzI52tkUpcxr5Sg1cIys9ACaLHdQhBxtiwKOmYoIdOij/5A0C5DenzD38HLXg+ACLFdRsoiKMPhQtCgK0YP+YNB+OqdKENZr4L6BncN3FdlYV2HOEZkasipAA+uGfEYXDvivboEfHZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916337; c=relaxed/simple;
	bh=BX4GYmqzbWM3HC0PGYu4JcyUT/8zu4NlJZ1GDAFxrkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fkh0tYqfc4Wv3Lp7G6zXBhLw7bovVSkM4AQI00/bPL5Y+A6rZIe6OvZQPm5cgkeOEF98G2eQNz+Wwg060+chqR6rwaJkxvJBc6fgNgD7mKL6DasbyR2N7VOisfinhvhS6oJzBpUE1+8TUzGGfuXJvm9HHQsghTevuLlv0x5gLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGlnxdVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D891C4CEFD;
	Fri, 31 Oct 2025 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916337;
	bh=BX4GYmqzbWM3HC0PGYu4JcyUT/8zu4NlJZ1GDAFxrkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGlnxdVCCpu4rFqQ7L49LWEM4RB/WMURy3wa+aSc4P4yTUyJQiI/diM+rLhBRoNRW
	 gOKM+0TyD3/UTZBFspZkX487u9w9k18YOeGcnn/bd421WwX96XFAJKuuXh6Gm3KXc5
	 UqSMpM9s8ENfsSUxbtHE579z9kg6PFDeDsLke9i8y5ZBpcIvtDfTPSam1TpgdT4yZ4
	 tqA7PJXizgFDscwOAnFnYNJFyw+0WwWgvuh20Mq5QDARKESyXhVJKtr5Zmr0kLZXKE
	 ii7o7uZBvm0chIaUBdvJh1huinxHjIgcRKrpLs9UrPvB8l5Axe3ccFhgTaZr5Wbkw/
	 ojbdF0JNL2Osg==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.6.y 4/5] gpio: regmap: add the .fixed_direction_output configuration parameter
Date: Fri, 31 Oct 2025 22:12:00 +0900
Message-ID: <20251031131203.973066-4-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-plaster-sitting-ed2e@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=wbg@kernel.org; h=from:subject; bh=upjcETHBi2pKlm3UWUV6l75Ac2r/R1frfr5RsuY0mPY=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksm2e1LdO6tO6QgtP3zUkrZlXxOke6SAQd7WHyvLpq/ 4Fbfy+bdJSyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATkXBkZFjI72fSt8jmjtra FZ6Jd1Y6Tvp5hfetrUdv+Bu5Ep2VLw4y/NNhKhY5/Cbq5o31x7TLmFbfm94+McvZRfizgd9ax5B 1TpwA
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
index c789001241fd..fd986afa7db5 100644
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


