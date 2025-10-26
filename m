Return-Path: <stable+bounces-189891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB8C0B666
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6B0E4E3253
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867B2FF643;
	Sun, 26 Oct 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy6DsEyG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054171BC5C
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519067; cv=none; b=h7+oRBrZo/6BxFFdZ4YnO6jo6eEy+bkqE2E3YsELr0NiUX3+K8uxD5GJ3RMqniDO6lg0sw8BtMskz/VopX8kw538GnBNYSAcWkB20/Uv6sh/6tiYH1qqe5jr2gZvAORzAVyT/tN3WWAucKI2S38YpixigUL6StQ2sijj5tYhVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519067; c=relaxed/simple;
	bh=vVzA9+gFsMFn266Ma3bhEZhxkHe0L7zmA5XF30rr3kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqwMFtirwMjuUEKm7xjhfBAwYctDQrZxfgS10kF/hdcPnhvP8pbzGXiYJu0IoLkSdr9lv23OOPcGQjNN8xHBxSj8YF8pqHU05n5iXbESyoPKaQyyezHzcUUr0zGZ+bu+neP6vb3NV4lQ3cDCGPp2i9vqjdlTuac7vCV2reFPiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy6DsEyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A849C4CEE7;
	Sun, 26 Oct 2025 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761519066;
	bh=vVzA9+gFsMFn266Ma3bhEZhxkHe0L7zmA5XF30rr3kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy6DsEyGe+ntaQ/tfcKhdFgMwHlhNIVaDCphxdVFztaT6kovXlIAp12YyWQdWQgsQ
	 4D4a68ZNOgA+QIICQ3aE+OlTCviCVFpVgYioAPaeobsPkhj4rAUGNOKTIJRFvL28pT
	 PX6ZoZAXwpkNTBAexKuyW+abzO/iPAq6CSUQwto5KYpJkuPO1miqxbR+XBRoY0MziK
	 jlsrgHREFjiUPpz7yx2lLrllWogfq3mnkhQ/lcduTMt8ZXOP+byPO0IDyLLAmKIuwm
	 262vdBUhGYKFSpo1p1ufLM3e5YT6ihBtlqkDnM+/QP49bc805pL9t7cGVoV6j6WOTp
	 5x2/njgwwrSKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gpio: idio-16: Define fixed direction of the GPIO lines
Date: Sun, 26 Oct 2025 18:51:03 -0400
Message-ID: <20251026225104.272662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-shortage-tabby-5157@gregkh>
References: <2025102619-shortage-tabby-5157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Breathitt Gray <wbg@kernel.org>

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-idio-16.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 2c95125892972..f7e557c2c9cd4 100644
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


