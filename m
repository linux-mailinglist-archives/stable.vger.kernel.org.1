Return-Path: <stable+bounces-189875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE041C0AD4F
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD84C3B3545
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12316218AB4;
	Sun, 26 Oct 2025 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQgSbnGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DF12080C8
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495933; cv=none; b=s/lD8UdcdDSV5C8TgNeuOSXIBopJFr4SPHVnkSLy4tFTgyd+KZzYNWo1CIH0gwPG/+JkmWxRfr34IeJX4mVs3SKIHbcP0frhSAz4Ry8O/kE6YwzpzKeHcPFrvrXhm6CkqjkVRJUWQmH8hUCAfW4jXt9eJ3i4vCaT6SIGhdpU4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495933; c=relaxed/simple;
	bh=3Y2qYsRm7Pht7RH/XTvW6RnaJdfFfqsu2INs5mn9RZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv5bgIW/+6UdytbYWh7jmaia9Zh69+TYtEsJwGeIlBPgjsvAuppQUn/Aqyu8iDuATY6ylfjxIH8TUz94uDsX8baDfdyq9p8ge4DQUBMC2kot3miMXfwL8WR5mfhwBsQzHR4rtw3et+u3tNs05fqswh/qfbiPEU+fHtGJbn4j3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQgSbnGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1D7C4CEFB;
	Sun, 26 Oct 2025 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495933;
	bh=3Y2qYsRm7Pht7RH/XTvW6RnaJdfFfqsu2INs5mn9RZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQgSbnGR8iWJyn2Bgkm+pe8h7tp8nPJWBAzwIGVDfPoI1cXnsqFqx21+LcPkxJCs9
	 EB3KlW6lJqp3QQplluLAdna+b2aTFdRlbF2o21mVsKA/UMduZ4KHpeW2ZaE2Sse4vb
	 JBtY2ZZxkJ1+F7nSxPGlWMwmDAOACgRZjFwcxKCKN5NDGA3R+W1h6lJ8WtKTK6KKQR
	 Zogl86vY1MP3q4/Gxx3geWMYumwqFkEdeMF0Afb+jFxrZfiIAUhmlCxmA/gwWrsbFa
	 IujOH1dxJwk57UR5vkVUYT3qLQzS/YiuLBLjRDKKpFjA/iamP8P3+AlIrzzRCAYo1R
	 CKJ5dNOFlGzNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
Date: Sun, 26 Oct 2025 12:25:28 -0400
Message-ID: <20251026162528.110183-3-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-idio-16.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 0103be977c66b..4fbae6f6a4972 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -6,6 +6,7 @@
 
 #define DEFAULT_SYMBOL_NAMESPACE "GPIO_IDIO_16"
 
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -107,6 +108,7 @@ int devm_idio_16_regmap_register(struct device *const dev,
 	struct idio_16_data *data;
 	struct regmap_irq_chip *chip;
 	struct regmap_irq_chip_data *chip_data;
+	DECLARE_BITMAP(fixed_direction_output, IDIO_16_NGPIO);
 
 	if (!config->parent)
 		return -EINVAL;
@@ -164,6 +166,9 @@ int devm_idio_16_regmap_register(struct device *const dev,
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


