Return-Path: <stable+bounces-102886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C89EF3EF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3612F286BBB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48D2253E0;
	Thu, 12 Dec 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXPYoh4a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47622969B;
	Thu, 12 Dec 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022861; cv=none; b=BYPRDdM8YQ/xxnbhS4JmXQsqD11Ju8iy8V2cvXo7iF2oUpIufrxvtUenM+QS6rrqJZlMdD0l4wizoHYxX7o5m2qqxQ6A5hbou4+UZf2wR/4Y4HXTyDwNMX+O6ZizBUbxBjdSwLa/xVQK2td/dGeUVPXxWHypPOlyJ50LLLxpu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022861; c=relaxed/simple;
	bh=I2SzrSOhr88tRDOdcrC6N/Lch95PYNhJ6NA/Vn2qPDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC96W/oi3vjHFxYvpAO69k9xOSVh3cYoQdcWTEmV7iEnCPmJ+9iKe0ZpdwRMK7mOK/Ay8do6Dzwa51CZnxKMY6yNjVPdyajWNY1dwENghlc5bOCY7dHUD8/WN2RGkES94fjRTAjY7I4QHPBaS9biepUlIuALqD3TDkN1BXxPjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXPYoh4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC2DC4CECE;
	Thu, 12 Dec 2024 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022861;
	bh=I2SzrSOhr88tRDOdcrC6N/Lch95PYNhJ6NA/Vn2qPDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXPYoh4atCJopa8Ls4qoYAdbW0dnIasVIhKwTqFxbGoCbHYLiMK4j7iPF+xyHhf49
	 OL/WMFX2C3c7N2+N+l4NO0Hm/lsOxrzd6OkVl2UY45fmLiK0faaOvBNR57f9XNH9D5
	 OkXDoaKUB0QxYvcExoDdyegshdqAmUL8glGiEvRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew McClain <mmcclain@noprivs.com>,
	Sai Kumar Cholleti <skmr537@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 5.15 325/565] gpio: exar: set value when external pull-up or pull-down is present
Date: Thu, 12 Dec 2024 15:58:40 +0100
Message-ID: <20241212144324.447168123@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sai Kumar Cholleti <skmr537@gmail.com>

commit 72cef64180de04a7b055b4773c138d78f4ebdb77 upstream.

Setting GPIO direction = high, sometimes results in GPIO value = 0.

If a GPIO is pulled high, the following construction results in the
value being 0 when the desired value is 1:

$ echo "high" > /sys/class/gpio/gpio336/direction
$ cat /sys/class/gpio/gpio336/value
0

Before the GPIO direction is changed from an input to an output,
exar_set_value() is called with value = 1, but since the GPIO is an
input when exar_set_value() is called, _regmap_update_bits() reads a 1
due to an external pull-up.  regmap_set_bits() sets force_write =
false, so the value (1) is not written.  When the direction is then
changed, the GPIO becomes an output with the value of 0 (the hardware
default).

regmap_write_bits() sets force_write = true, so the value is always
written by exar_set_value() and an external pull-up doesn't affect the
outcome of setting direction = high.

The same can happen when a GPIO is pulled low, but the scenario is a
little more complicated.

$ echo high > /sys/class/gpio/gpio351/direction
$ cat /sys/class/gpio/gpio351/value
1

$ echo in > /sys/class/gpio/gpio351/direction
$ cat /sys/class/gpio/gpio351/value
0

$ echo low > /sys/class/gpio/gpio351/direction
$ cat /sys/class/gpio/gpio351/value
1

Fixes: 36fb7218e878 ("gpio: exar: switch to using regmap")
Co-developed-by: Matthew McClain <mmcclain@noprivs.com>
Signed-off-by: Matthew McClain <mmcclain@noprivs.com>
Signed-off-by: Sai Kumar Cholleti <skmr537@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241105071523.2372032-1-skmr537@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-exar.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -80,11 +80,13 @@ static void exar_set_value(struct gpio_c
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
 	unsigned int addr = exar_offset_to_lvl_addr(exar_gpio, offset);
 	unsigned int bit = exar_offset_to_bit(exar_gpio, offset);
+	unsigned int bit_value = value ? BIT(bit) : 0;
 
-	if (value)
-		regmap_set_bits(exar_gpio->regmap, addr, BIT(bit));
-	else
-		regmap_clear_bits(exar_gpio->regmap, addr, BIT(bit));
+	/*
+	 * regmap_write_bits() forces value to be written when an external
+	 * pull up/down might otherwise indicate value was already set.
+	 */
+	regmap_write_bits(exar_gpio->regmap, addr, BIT(bit), bit_value);
 }
 
 static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,



