Return-Path: <stable+bounces-189871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CBC0AD2A
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158EA3B311E
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFF021CC4F;
	Sun, 26 Oct 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH0uzrCq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65D45C0B
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495088; cv=none; b=gY2LJGQhWJwQ6Ti0yKRQ70jemSd3u64R6KDm6m0dRktQdGRgVWewzxDbu6xzkQac+U1W50J/mVmEC5JWXaAnVuWbHphdgp2pOSrilQry7oif1K+jBMBYUJTRVKju+PSRI1uHpS2YJPf4D4njUobXm1kthHuR0+OchXidgxC5uP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495088; c=relaxed/simple;
	bh=3Y2qYsRm7Pht7RH/XTvW6RnaJdfFfqsu2INs5mn9RZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcn+/M7kHvMbGKBpgxTgL3CBPcRwjHLbnrVLXBx6oZeLjvTqTvvEw6iACmxuuILSzwobFhghJv+ErkO6jI29d3TdBOu2+JLyM6w7vFLbRRf8SIdCke49NmS+5Jj9Fwohrzd+Rsc91eMUvy3d1UviH56qd0kTT9j3N4IIoAZPTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH0uzrCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059F6C4CEE7;
	Sun, 26 Oct 2025 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495088;
	bh=3Y2qYsRm7Pht7RH/XTvW6RnaJdfFfqsu2INs5mn9RZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VH0uzrCq0xi4gvplRTN7PO7SeE77qkdp68tJffVyNzEJEV2wrU4jk9X2tquqEHK9b
	 Pb+dwnp8vvBI+vWD54s3GpZAk8cMEGkNSDvfNBe4TSAS8yMzOVJfIDh6/Q7tJ1rcdU
	 wbSBivOnvKoHnN9iYUUM7VXpYaIjp5udKHQI0qhjXu5YfwRVhKpNgHajLVwLWVJ4dn
	 NtoMGejOwaWUDPMfkRotrYGmjCePrQ5FGqlHrUp3RWZjLFtxe5IfPML/q8/jKA6Z90
	 0ldwNY3JLeCcmYALZgNHhZeV973uiCAtUdLVYHDRhQYQDgftt+55tNruCqC/0jnTBu
	 WuHLvRwWxo2kA==
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
Date: Sun, 26 Oct 2025 12:11:21 -0400
Message-ID: <20251026161121.102839-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026161121.102839-1-sashal@kernel.org>
References: <2025102645-grueling-ramrod-c231@gregkh>
 <20251026161121.102839-1-sashal@kernel.org>
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


