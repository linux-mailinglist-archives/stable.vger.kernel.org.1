Return-Path: <stable+bounces-26368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E679870E44
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC31C20C81
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DE7BAED;
	Mon,  4 Mar 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFS/R4A/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752378B69;
	Mon,  4 Mar 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588539; cv=none; b=GicPeRktD+yEDHUhzGhx1YJhytgfs+ouFux4KAqI0imwAppvLEeFjVHIEbgNpk6S5kXCAs0KE/bAd55YfW7wtB0ZUlkIIwYcYwxyvQfPHp/t+REzqf0QvyIxLHn9t15PZgxYKnxQAVhVp2Wro+9aUMLevejYgKBQC6yKnL30NNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588539; c=relaxed/simple;
	bh=TtdtlpgJIz82AehYFF1Co87yb/FV0VUmVgeyoX2oFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjgcMidRHw68ge++ho4eVIHDX1oF7cnhm901WM2vW6kpbubqRO5n3Og/Jv7xgovyK9ytgHDwORUwA5tg3stm+LGri07tKB+xREoIQlXmaEDwQfHx6vJ9DsinSXfn1AusqcACjrLUNqVvY9JsSTdzs+vZT6Xahqi/NGQgbiTqAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFS/R4A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A23C433C7;
	Mon,  4 Mar 2024 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588539;
	bh=TtdtlpgJIz82AehYFF1Co87yb/FV0VUmVgeyoX2oFvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFS/R4A/BkCuntiSBHgZrDt4wU86er84UF0OupGmABU7lfKnyjF8T4gROlVG/qI1A
	 wCeB0pKZBwWY5qQjKQgojTjTK+bIAjqODr0IzF6Fh6bPeSPtT8zn1X4I6GBWBsGm9I
	 Adj9pMpIvvnFjuAnOR/mfuLzk8jUe5sIgC5ltYKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 130/143] gpiolib: Fix the error path order in gpiochip_add_data_with_key()
Date: Mon,  4 Mar 2024 21:24:10 +0000
Message-ID: <20240304211554.067199768@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit e4aec4daa8c009057b5e063db1b7322252c92dc8 ]

After shuffling the code, error path wasn't updated correctly.
Fix it here.

Fixes: 2f4133bb5f14 ("gpiolib: No need to call gpiochip_remove_pin_ranges() twice")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 71492d213ef4d..53ab4e62503fd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -925,11 +925,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_free_valid_mask(gc);
 err_remove_acpi_chip:
 	acpi_gpiochip_remove(gc);
+	gpiochip_remove_pin_ranges(gc);
 err_remove_of_chip:
 	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
 err_free_gpiochip_mask:
-	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
 	if (gdev->dev.release) {
 		/* release() has been registered by gpiochip_setup_dev() */
-- 
2.43.0




