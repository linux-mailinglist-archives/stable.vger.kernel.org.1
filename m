Return-Path: <stable+bounces-94826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7C9D6F71
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA56281A53
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F51EC010;
	Sun, 24 Nov 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUyKN9lf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330E1EC003;
	Sun, 24 Nov 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452647; cv=none; b=MwUgmdn0XHyrc1/7aR68QAVuBuWulLR+F8ttblAKkd3Vsq+jLSVD4t8pT7T79MHwB4ZHiEpv5u/aAmMv0CRNro/eutBy8yMPsnrr34FCIIWbdEmutr4h8yQKEaLwQi4qp4wMWQeAG+RkZvEWltWfw+GVwxNuWf891mBIpwNnpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452647; c=relaxed/simple;
	bh=SUm48HcYKDKR6wUc3VpZvhgjuViI2lQ8T7bFKafhnSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L75JO/eRkPTN1dVfEjt9kwx+US+mYEGsIS0D26cANCFM9z/oKt1UOUqOn+RWBFtWrKiBnKtIolerSP8b//A1K0985QZHXctYwYBcQ8U21RXg9XUkO54wm51VXYNPVTgKr4bDBnJvxxjhkWG6t3FAJbGrMzSemz53oVFcjefIK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUyKN9lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532C0C4CECC;
	Sun, 24 Nov 2024 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452646;
	bh=SUm48HcYKDKR6wUc3VpZvhgjuViI2lQ8T7bFKafhnSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUyKN9lf8DT3NO8avNQAtAv9BwBjjzpmq3XLWuFPN4Mh+qtEfgYTj8SNn9bQRE+XQ
	 0+0QzVjw7XLRM1GcBOQ7WMw3bcWxdAtCoCWuHad91x4lfFFHQ4SUOuxMU4WHf593tK
	 zc53xG41gfOuPnM3qcU6vxgpBCt0dZuYWZKknIGB0jlvZASD7BUnBGL8dUNbOw/XJO
	 aYCfunNqM+jP4//sCJGDPkgSJB5rQhPgms9dkzg0c39t+fu+4XEw8sq62lGadgjo+N
	 rWoHfhbOc3g+cINCyiWuoZqV4JP9XrO9lXothzKiG1WPIK4zISwngxQrYwv/XuwcAr
	 3Oirr1z4g6KJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 21/23] USB: gadget: pxa27x_udc: Avoid using GPIOF_ACTIVE_LOW
Date: Sun, 24 Nov 2024 07:48:32 -0500
Message-ID: <20241124124919.3338752-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124919.3338752-1-sashal@kernel.org>
References: <20241124124919.3338752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 62d2a940f29e6aa5a1d844a90820ca6240a99b34 ]

Avoid using GPIOF_ACTIVE_LOW as it's deprecated and subject to remove.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20241104093609.156059-6-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 1a6317e4b2a32..ea79f85f8e0bb 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2355,18 +2355,19 @@ static int pxa_udc_probe(struct platform_device *pdev)
 	struct pxa_udc *udc = &memory;
 	int retval = 0, gpio;
 	struct pxa2xx_udc_mach_info *mach = dev_get_platdata(&pdev->dev);
-	unsigned long gpio_flags;
 
 	if (mach) {
-		gpio_flags = mach->gpio_pullup_inverted ? GPIOF_ACTIVE_LOW : 0;
 		gpio = mach->gpio_pullup;
 		if (gpio_is_valid(gpio)) {
 			retval = devm_gpio_request_one(&pdev->dev, gpio,
-						       gpio_flags,
+						       GPIOF_OUT_INIT_LOW,
 						       "USB D+ pullup");
 			if (retval)
 				return retval;
 			udc->gpiod = gpio_to_desc(mach->gpio_pullup);
+
+			if (mach->gpio_pullup_inverted ^ gpiod_is_active_low(udc->gpiod))
+				gpiod_toggle_active_low(udc->gpiod);
 		}
 		udc->udc_command = mach->udc_command;
 	} else {
-- 
2.43.0


