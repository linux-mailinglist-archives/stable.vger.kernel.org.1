Return-Path: <stable+bounces-189865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06664C0AC58
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A78188B8B0
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED424DCF9;
	Sun, 26 Oct 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq/rHlsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C21D5AC6
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761492617; cv=none; b=NraKrEoiHssnX2JvfgplcSXzPNXLMyXD0YlvnY4bJBqkZOUGZBdTLfwSq7FUY4erNN12BSECGQrDgfJCmoqQW23N5JLSJDL3tn85XMJl/4tXmaKAC2Fae1X8Ja4Qt4CQu7oarj11XkmYpZtIog3QiOhjbStwXH2UIPO+U71Rkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761492617; c=relaxed/simple;
	bh=h5a6Ge2h/DvaD4ODzl1xrkgroIxF8oiQMz0R0qQLdjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVawPl37+Ue5hYjFtsvrMzpN9otQVlmTjVSkRMbGvriHVFW/ClFwA6gHiuqEh7qY8thGALbMYpQsObUpiXUYlqFcL9TFHnxVheuuLyhCRmCEnDvTQOVyju/GEyBhL5bgDa/58p+IAFi3hLRTXjzts/R3cJi59qtPKi/p5U+l+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq/rHlsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A68C4CEE7;
	Sun, 26 Oct 2025 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761492617;
	bh=h5a6Ge2h/DvaD4ODzl1xrkgroIxF8oiQMz0R0qQLdjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oq/rHlsj5hfZEkZfMvTkUDUP6RzwuFVwh1R8twNtkvBLAsgqLW4onysar/xEzSf1P
	 Lhvm4hyLGLknhRe3r/xfRfeICT/ar3esr9cdMsSbCGYBarNw43UAHuEdKAwfCYa4id
	 9x602fERC50NVT4QUA09uDPig9Dhi+SdEwpLW673GArOVBK17NR4JC2OlLUb0KsTD5
	 A2YhPYjOqKLOvVcQ1VjYVUHVfCgqFWRuSBEJdVp6GQnIlEhbA4Hppa3ZOydIb8lvc2
	 6GN8XlLM07PAFm1DO/MEI4ZU9si9JH1pzeOkI45q/X3u3OzlC0WqRR0acLwd+9X5J6
	 PHv7e6h5edbtQ==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.6.y] gpio: idio-16: Define fixed direction of the GPIO lines
Date: Mon, 27 Oct 2025 00:29:43 +0900
Message-ID: <20251026152950.44505-1-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-plaster-sitting-ed2e@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349; i=wbg@kernel.org; h=from:subject; bh=h5a6Ge2h/DvaD4ODzl1xrkgroIxF8oiQMz0R0qQLdjc=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBn/7JLOWR+wfHbjsV3mn2ezThfYcy4U77Ja1rTRhml13 oGXjlp2HaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBENA8y/A/6sCpGhulZIv+x WoagUtOEFbeWL9vLVswzR2Hrz92tz/IYGS62/Qpa8iBzS4fuvfucNydbz99QsaBj4z1bkZ+SO3e lb+YGAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 2ba5772e530f73eb847fb96ce6c4017894869552)
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


