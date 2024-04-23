Return-Path: <stable+bounces-41153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66C8AFA83
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FF5289E1C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF0149DFD;
	Tue, 23 Apr 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gczYJcKG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B1144313;
	Tue, 23 Apr 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908713; cv=none; b=BNnRjX/qGCx7lH7IfYwKdb1XyogpUUWOZ7JHEdWb8CmyrTQOf+FK98MNWhI6zw5RajCRRFKLzWQBXrulosbO4omWk6zTjD/1JTWFKbhKRRiLV1dJTzr55bwdKFDk45H9dfVZT2tvaZZSWJjUmWDwMrQyzgKSZ+KM5ilIRCBVexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908713; c=relaxed/simple;
	bh=xisLmC9lovTu4RuSTrnMbU3uSvsk3tv/oEXpqVJKIoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAcKYL4nQZcYX5jcyoR77uBdGT0DpSvk3TRKzLPBSaivRyYOZyUgQQuGyMxyIBYVjNNo2DnByvzqOoQ0oS51So9WN5Ca3VfnIRVWeufsN5wimEkSfK3w1YxiQt/90qCz2/FSd8CEstfR3/rxDfVSIMjrojKvVD2ghna3l9FpJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gczYJcKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FB9C116B1;
	Tue, 23 Apr 2024 21:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908713;
	bh=xisLmC9lovTu4RuSTrnMbU3uSvsk3tv/oEXpqVJKIoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gczYJcKGrF664gVo22feZqAP2QkO8qtrPIJ8+GSV6hAUzwW0CPrh0aHlCBEiN1AgL
	 bJMkeglxd6MPpqPqd7vwswpweNq9pWoh5jtSBMhJgZ3Dx42ckFagdvVoTJXrJxhl78
	 C0l0YxeU79roaEQQ/9y9G8R6Ne2ArmV9Q2wrXnQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/141] ASoC: ti: Convert Pandora ASoC to GPIO descriptors
Date: Tue, 23 Apr 2024 14:38:59 -0700
Message-ID: <20240423213855.524110962@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 319e6ac143b9e9048e527ab9dd2aabb8fdf3d60f ]

The Pandora uses GPIO descriptors pretty much exclusively, but not
for ASoC, so let's fix it. Register the pins in a descriptor table
in the machine since the ASoC device is not using device tree.

Use static locals for the GPIO descriptors because I'm not able
to experient with better state storage on any real hardware. Others
using the Pandora can come afterwards and improve this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Link: https://lore.kernel.org/r/20230926-descriptors-asoc-ti-v1-4-60cf4f8adbc5@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 10 +++++
 sound/soc/ti/omap3pandora.c        | 63 +++++++++++-------------------
 2 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index baba73fd6f11e..3499a97714e62 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -256,9 +256,19 @@ static struct platform_device pandora_backlight = {
 	.id	= -1,
 };
 
+static struct gpiod_lookup_table pandora_soc_audio_gpios = {
+	.dev_id = "soc-audio",
+	.table = {
+		GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0-15", 14, "amp", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static void __init omap3_pandora_legacy_init(void)
 {
 	platform_device_register(&pandora_backlight);
+	gpiod_add_lookup_table(&pandora_soc_audio_gpios);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index a287e9747c2a1..fa92ed97dfe3b 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -7,7 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
@@ -21,12 +21,11 @@
 
 #include "omap-mcbsp.h"
 
-#define OMAP3_PANDORA_DAC_POWER_GPIO	118
-#define OMAP3_PANDORA_AMP_POWER_GPIO	14
-
 #define PREFIX "ASoC omap3pandora: "
 
 static struct regulator *omap3pandora_dac_reg;
+static struct gpio_desc *dac_power_gpio;
+static struct gpio_desc *amp_power_gpio;
 
 static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
@@ -78,9 +77,9 @@ static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
 			return ret;
 		}
 		mdelay(1);
-		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
+		gpiod_set_value(dac_power_gpio, 1);
 	} else {
-		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
+		gpiod_set_value(dac_power_gpio, 0);
 		mdelay(1);
 		regulator_disable(omap3pandora_dac_reg);
 	}
@@ -92,9 +91,9 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 1);
+		gpiod_set_value(amp_power_gpio, 1);
 	else
-		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
+		gpiod_set_value(amp_power_gpio, 0);
 
 	return 0;
 }
@@ -229,35 +228,10 @@ static int __init omap3pandora_soc_init(void)
 
 	pr_info("OMAP3 Pandora SoC init\n");
 
-	ret = gpio_request(OMAP3_PANDORA_DAC_POWER_GPIO, "dac_power");
-	if (ret) {
-		pr_err(PREFIX "Failed to get DAC power GPIO\n");
-		return ret;
-	}
-
-	ret = gpio_direction_output(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
-	if (ret) {
-		pr_err(PREFIX "Failed to set DAC power GPIO direction\n");
-		goto fail0;
-	}
-
-	ret = gpio_request(OMAP3_PANDORA_AMP_POWER_GPIO, "amp_power");
-	if (ret) {
-		pr_err(PREFIX "Failed to get amp power GPIO\n");
-		goto fail0;
-	}
-
-	ret = gpio_direction_output(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
-	if (ret) {
-		pr_err(PREFIX "Failed to set amp power GPIO direction\n");
-		goto fail1;
-	}
-
 	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
 	if (omap3pandora_snd_device == NULL) {
 		pr_err(PREFIX "Platform device allocation failed\n");
-		ret = -ENOMEM;
-		goto fail1;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
@@ -268,6 +242,20 @@ static int __init omap3pandora_soc_init(void)
 		goto fail2;
 	}
 
+	dac_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
+					"dac", GPIOD_OUT_LOW);
+	if (IS_ERR(dac_power_gpio)) {
+		ret = PTR_ERR(dac_power_gpio);
+		goto fail3;
+	}
+
+	amp_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
+					"amp", GPIOD_OUT_LOW);
+	if (IS_ERR(amp_power_gpio)) {
+		ret = PTR_ERR(amp_power_gpio);
+		goto fail3;
+	}
+
 	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
 	if (IS_ERR(omap3pandora_dac_reg)) {
 		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
@@ -283,10 +271,7 @@ static int __init omap3pandora_soc_init(void)
 	platform_device_del(omap3pandora_snd_device);
 fail2:
 	platform_device_put(omap3pandora_snd_device);
-fail1:
-	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
-fail0:
-	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
+
 	return ret;
 }
 module_init(omap3pandora_soc_init);
@@ -295,8 +280,6 @@ static void __exit omap3pandora_soc_exit(void)
 {
 	regulator_put(omap3pandora_dac_reg);
 	platform_device_unregister(omap3pandora_snd_device);
-	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
-	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
 }
 module_exit(omap3pandora_soc_exit);
 
-- 
2.43.0




