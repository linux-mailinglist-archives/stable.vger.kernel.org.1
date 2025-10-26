Return-Path: <stable+bounces-189777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF3C0A9B4
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 089B734943E
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1023C8C5;
	Sun, 26 Oct 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I6hXFTG5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16C219302
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488611; cv=none; b=klRdKzy7llkcHN4GHSYxkq7E28tcER8wyL/aQlNc22neE6CWpvP9XHCh/LWsW9m1Tjg5/bgY2/1OnHVsQb4gEp4+a0GgZeFfCr3nWiPlgj2N+6+ceADP3Vl04VprpukSyK5Dr2gnW8bJof4Br3zCCurqYm+gjslUwRCKhNiAuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488611; c=relaxed/simple;
	bh=DBGQeLDezISWslAI45iBNwsqJZadZoCnYG5YzbLCm8k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bdmi2XqHzK1Z9OjA0vJmyrvckqLFUaOLz1ssIiaxMvnQj1f7hd+4URhr7ey79DENHGlJYL0mU5bl9qJ3cEJdok20qvgTh0DPqN500EOHObw+PbwFVmPBWeDsp5NMxhtbmPxOe83AtXnrSfEY6Cmef+KSFWbUpPKEEWoLlaqAT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I6hXFTG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC2AC4CEE7;
	Sun, 26 Oct 2025 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488610;
	bh=DBGQeLDezISWslAI45iBNwsqJZadZoCnYG5YzbLCm8k=;
	h=Subject:To:Cc:From:Date:From;
	b=I6hXFTG5iu5a6yJgRoCq18ewDy9y3N3hA44zQ85Wq0uVFEfnF0wRedXpjoDwIbvOy
	 JKwiS2dOHM0xXcE2NjoT3SZWhbog50ah8z+yo1dh8wE0HQT5xtO9hOw1nUeOpAB6sw
	 x9v/h4JG10QpGyndVNQX2+JawGzeR/qSyyCS1XPI=
Subject: FAILED: patch "[PATCH] gpio: idio-16: Define fixed direction of the GPIO lines" failed to apply to 6.6-stable tree
To: wbg@kernel.org,andriy.shevchenko@linux.intel.com,bartosz.golaszewski@linaro.org,linus.walleij@linaro.org,mark.caveayland@nutanix.com,mwalle@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:23:19 +0100
Message-ID: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2ba5772e530f73eb847fb96ce6c4017894869552
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102619-plaster-sitting-ed2e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


