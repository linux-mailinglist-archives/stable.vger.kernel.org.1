Return-Path: <stable+bounces-191820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8311C25345
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0D7134AB76
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B434B187;
	Fri, 31 Oct 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbLN3VJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A155347BCC
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916339; cv=none; b=Bg/Zhu3QhiJOXORbph7AaiELD+VeRyKS8JsFLotJ2AEXjSuwXgJ1IZ70u0oHCVX5F4Fh14ifSDNEzte6VWM2IpALxtjwV/4tG+oLHG8F2NPTWDyMwNovxmjfNyhQoD+hVwhJOUWI4oYJj3nCeKDY+N4svvoGfeiqk1UITvKCYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916339; c=relaxed/simple;
	bh=KunnmldYojxfHdEqE9Lx1qV9IjVG7Y5/nZPhkKcFJyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzPSAmXuFMF5nk90wCFQEDsBf/hLOZdG9ndkBQ9ruxKm21FEMhtRBsVubc4S7SUEqBRSimllNzt1ryubVfEbRAYCvZS5Dt3dbhjmb4FpXsaSLkh7mgimPYn7C/886HgyQSpLqVsi0o/Gox7HCr/v6NVXmkByJWzpVY58C37YeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbLN3VJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0577C4CEE7;
	Fri, 31 Oct 2025 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916339;
	bh=KunnmldYojxfHdEqE9Lx1qV9IjVG7Y5/nZPhkKcFJyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbLN3VJIFbaDUHSfjWFc5HR47Xi7INtgMPm8aZfKK050KUqMfVACNe88UI90QoGzz
	 gsQsdTIOT01qUiZMW8gXC63o5nziS1UPvPgA40KDFXMUlhO2a7xuLAttN1J4V0RXC9
	 68tlAO7qNVOtAo9TRiGpxKbenj6NNmjdVvnXH8imm3BDfuaIMW4YcoQUsX9n2wHXaC
	 I7aPy0xrQSzbqjiHLD+vKlUFuH7qLiyqomFJ0UNv4LYFYHL0uWUQW7fEsZ7/77uB3s
	 JjkkVt3jeGmckHlKpjb4GJI6TF1jVKMdRIkJQCZS0RMhzLYOPC6Krstt0ypL6hWqUI
	 VVDEhZDds7thw==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.6.y 5/5] gpio: idio-16: Define fixed direction of the GPIO lines
Date: Fri, 31 Oct 2025 22:12:01 +0900
Message-ID: <20251031131203.973066-5-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-plaster-sitting-ed2e@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=wbg@kernel.org; h=from:subject; bh=KunnmldYojxfHdEqE9Lx1qV9IjVG7Y5/nZPhkKcFJyI=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksm2ctb2vsu+rxQ2RV/hbt+ewaQpHP3USmVUqeZVcyV 9xcWbmxo5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjIAj2G/1mKNRZlWxe9nVH+ 7LJ9FJvtCcYQYfEw4Ubdkm1vZYR7FjAynAxfJNZddampKE3fa6b8lsfO56d0SO///XLfo8Cov+L ZrAA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

[ Upstream commit 2ba5772e530f73eb847fb96ce6c4017894869552 ]

The direction of the IDIO-16 GPIO lines is fixed with the first 16 lines
as output and the remaining 16 lines as input. Set the gpio_config
fixed_direction_output member to represent the fixed direction of the
GPIO lines.

Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nutanix.com
Suggested-by: Michael Walle <mwalle@kernel.org>
Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fixed_direction_output configuration parameter
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 drivers/gpio/gpio-idio-16.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 53b1eb876a12..e978fd0898aa 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -3,6 +3,7 @@
  * GPIO library for the ACCES IDIO-16 family
  * Copyright (C) 2022 William Breathitt Gray
  */
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -106,6 +107,7 @@ int devm_idio_16_regmap_register(struct device *const dev,
 	struct idio_16_data *data;
 	struct regmap_irq_chip *chip;
 	struct regmap_irq_chip_data *chip_data;
+	DECLARE_BITMAP(fixed_direction_output, IDIO_16_NGPIO);
 
 	if (!config->parent)
 		return -EINVAL;
@@ -163,6 +165,9 @@ int devm_idio_16_regmap_register(struct device *const dev,
 	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
 	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
 
+	bitmap_from_u64(fixed_direction_output, GENMASK_U64(15, 0));
+	gpio_config.fixed_direction_output = fixed_direction_output;
+
 	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
-- 
2.51.0


