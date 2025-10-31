Return-Path: <stable+bounces-191797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56694C242E1
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED60F4F0FBE
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B507329E49;
	Fri, 31 Oct 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm8hEI1u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A4328B77
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903231; cv=none; b=Xo45fm3wjJ7kLbh4mxYxydRKWZiHPp41wJAGnhhXcBvIrcuMoVCEs2VfvWElAsfSMYfs57wrjfK4/VwFg2ODHx5+fUBEEKeVz4a3M6xo8pQTX0wWfUNtXmEwSZnPXfWnJx7gvh91xz/QjaoUMLq9yLDmyB2oC7WqwvDXW++7iXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903231; c=relaxed/simple;
	bh=pMM3DyV1WkugxoFGZ0qgeHqiGaFBFplx+K8RRmUwM3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlsy9fNLSUCvzRzwERg0/72kmvzrOhQ05TUgPoA8RkIpvwPLVzBpgRzBT1KlssgRtEjaiBoG+uddkCZU4Vi5mACWvs9/N5PI67WI7e9N/WhVtvSiYWFlDz4cY33gVFpFV/qvAJ+NGxG/XqX0iLwY75a1f14ZERGvaEL9W5jinEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm8hEI1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E191C4CEE7;
	Fri, 31 Oct 2025 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761903231;
	bh=pMM3DyV1WkugxoFGZ0qgeHqiGaFBFplx+K8RRmUwM3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hm8hEI1uw5FBsqidfQMDcGLPyHh42wtlmccSZhoi9e4prmJWH9Z7FYEAcA7w5T6SX
	 X0wleDj/wT6PgyE73rg4CRqT1DE7Xo0nXF4QjLpYXmZjf1ua+nfv0AGOJ03pO6ie6J
	 ACCXKrcjCQnbCt9N8keuAIVZGXrXXz2pfvwG9dC2j00YinjNcpcvVMg4IjXvJZxclx
	 GWo/7zf42ycTBT+j+1zzfoS5+ZQlugZN0UnlQ4BlPpd7Vs54A0KUQPZSjeKhlAoF87
	 b5SdYRqdDVah8ev+RpMH7NRi6hV/PrVQvY4yso6ms7HkebSVxxyKGzxYuABOO5Xpl1
	 kC/8inV9wYKVQ==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.12.y 5/5] gpio: idio-16: Define fixed direction of the GPIO lines
Date: Fri, 31 Oct 2025 18:33:19 +0900
Message-ID: <20251031093326.517803-5-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-shortage-tabby-5157@gregkh>
References: <2025102619-shortage-tabby-5157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=wbg@kernel.org; h=from:subject; bh=pMM3DyV1WkugxoFGZ0qgeHqiGaFBFplx+K8RRmUwM3U=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksTWI7ZKbl3Q4KUw27uTmJx3vVrxy9MxGc7oFXjm248 Mw37fvNjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiVccYGdYYhOa4zl75ZZ99 +PVXV95cXrJb8vvL0JmlTk+MdzY8i0llZHjqrft7R96W8B2GdQfi6/9mRJ28dW6TlG9hrUrccsn DFswA
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
index 2c9512589297..f7e557c2c9cd 100644
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


