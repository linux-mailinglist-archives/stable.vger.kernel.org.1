Return-Path: <stable+bounces-189776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112CC0A9EA
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F148A1892D75
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF79022A7F2;
	Sun, 26 Oct 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tYCg7lPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CA219302
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488602; cv=none; b=D9boy3TVba3SIJfiVWb9ByUtV4B610AMQ0A9IHrfZqaci5kk5cNOBgQV6k7i7jOEz7+uwviBgCI1IxwRfOLdUV9yoaGthj5FBXoyE5HNcSV3wgnRnstrTpthmO/HT1Vs12UbuASU1A9dVeiIwkgTqJU79KdQa04q9X4UFlRFeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488602; c=relaxed/simple;
	bh=gCenRzNdKSDJYZ5+T1YXbCmWEAksJEigzKF1edpZzjk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iV3pdL0jLjVwIHYB0B39xS5vLCVVZnVsUW1ma/rZxRQ2cwv37XAxl9T5WbgpXrQAM2AHBIA4+oRAPzWaXj+zN9XMmmNNI7cHeVz3RqbVjcfLXQ2X1UkSvxvdNGoAnVhOytqlQ8L+5CUwAStoSjkpWMCyiYcJ/nGt9bxhYeA7pas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tYCg7lPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3275C4CEE7;
	Sun, 26 Oct 2025 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488602;
	bh=gCenRzNdKSDJYZ5+T1YXbCmWEAksJEigzKF1edpZzjk=;
	h=Subject:To:Cc:From:Date:From;
	b=tYCg7lPmzDjp5P2N58vXoIOEnqXnTAFS80QxyFq/iKJUdchF53+ovo4CydkW0+p3i
	 gxt8dJn29CXf5lIM5+tRhvmUtSAIHmpy1nwkLhNu5G7Clk5hHz0jKLjxCcyiBVkmMX
	 fBitRj0MKh6YPgabiz9meGQ9JQGimZEfGUp++79U=
Subject: FAILED: patch "[PATCH] gpio: idio-16: Define fixed direction of the GPIO lines" failed to apply to 6.12-stable tree
To: wbg@kernel.org,andriy.shevchenko@linux.intel.com,bartosz.golaszewski@linaro.org,linus.walleij@linaro.org,mark.caveayland@nutanix.com,mwalle@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:23:19 +0100
Message-ID: <2025102619-shortage-tabby-5157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2ba5772e530f73eb847fb96ce6c4017894869552
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102619-shortage-tabby-5157@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ba5772e530f73eb847fb96ce6c4017894869552 Mon Sep 17 00:00:00 2001
From: William Breathitt Gray <wbg@kernel.org>
Date: Mon, 20 Oct 2025 17:51:46 +0900
Subject: [PATCH] gpio: idio-16: Define fixed direction of the GPIO lines

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

diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 0103be977c66..4fbae6f6a497 100644
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


