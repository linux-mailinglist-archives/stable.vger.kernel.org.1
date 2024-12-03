Return-Path: <stable+bounces-97983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729E9E26C4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB7E16D89A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F351F76DD;
	Tue,  3 Dec 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pksecljs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BA1F75AC;
	Tue,  3 Dec 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242404; cv=none; b=oW78idCofG912GpfGTxpLjWwTuj3oJRSNB79tmkkbDQ/o7n5RaYrmd2PZgCxR+IoJd/2LpqUYx1WZI0uwlqNpos6VyasxssYyX1uTNtJ6jtmLug+9WgYSY0m6R8OO7dGFDByVzqVpQMFVvk3qoB5FRW5wbN7pBukXg21NcE37GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242404; c=relaxed/simple;
	bh=n+ttjmG0O7b0d5aNV+otyn12wrzYPO4TUAc90vkoRjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP622rod/gZ8TjD3Pyg6Xlm0ttk9wRkMoyx9d2dg6Bsk0/58ke0i8UHbOLl4PRjomRYkk4LsuUeTehiAAzKY9PWPhLOk3XAozO//zcq1S1pgC7Nf+sc6XQPd7maUwx+TCnaBiGHyNO6p9Yh729htC4BtXyzKylOdu1fb4HwrImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pksecljs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E71C4CECF;
	Tue,  3 Dec 2024 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242404;
	bh=n+ttjmG0O7b0d5aNV+otyn12wrzYPO4TUAc90vkoRjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pksecljsLrHBQosPJVcLauBhE8hMrp4e0jRs7KtHqjiRdd4foBKlz1pExs6BRYfou
	 bq/UAUu067PRoKFp5S5Tb4bSCSystJmyYzJDHiBCjTUF8iJPEc0+ZZmPaPibqkq2rO
	 bs4c5w+KvKzSYhY/DNtUsDUz9sHQiNIEHmwBInC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew McClain <mmcclain@noprivs.com>,
	Sai Kumar Cholleti <skmr537@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.12 694/826] gpio: exar: set value when external pull-up or pull-down is present
Date: Tue,  3 Dec 2024 15:47:01 +0100
Message-ID: <20241203144810.829649622@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -99,11 +99,13 @@ static void exar_set_value(struct gpio_c
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



