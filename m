Return-Path: <stable+bounces-94891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE09D748E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C02B27DEF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0D1FF7BD;
	Sun, 24 Nov 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2j5507Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C191E1A1C;
	Sun, 24 Nov 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453122; cv=none; b=TEzRjge1RZ8FGgur15sQb7BpocCDyD8/5wN2rGyAWoPsRbgxNNJpjDUcYYYDBmG+aWe+CqaLaWXW4crlcVfOdLOU5kczo47gdRL1nHf9YGfyYZci141LIQ7KnJz7SarAh4T9Cd/C7kjS9eWkrgT3p+2GobwGaeJTDwq+ngOgUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453122; c=relaxed/simple;
	bh=EYUPj0mv8QNgvzoMAVNtGMp7DumB52AqR8hSylp93w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKqQPUgWbLDNsel/06+RS76QXdqtTQ9HrzVwQYsyAmsZraeHfTOj/eLYzFmvtqEOyCR5j8qeAsLUNsLBSQ8/VsbFwTwmfOOLrLxVhLsLYZUYS7uqYg0XINjF7kN8Me6O8IpkIvzxjYzAive14hr6wDx+IVCRksurtMlQc0ZnJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2j5507Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68850C4CECC;
	Sun, 24 Nov 2024 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453122;
	bh=EYUPj0mv8QNgvzoMAVNtGMp7DumB52AqR8hSylp93w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2j5507Zj6Y4CnZ40A6HiQfNzCrpFS9pYT19UUBzUBqWcKnhPaSHA1fuWDEOmx0PJ
	 t1pkgNjMPIg7veZUzoe63GI7DjeRlpTiID8unNbWsj/Bg2VssqZvMlRqw2ezpZaWsV
	 djBJo6bfiqDJc82QxX3OPuEbiKbJlmWwKaCLD4kGurouegQh9/BhXWXX6oSGKJPnec
	 KI7NHhbaIZoIAnmdSfrG9BHyaFWxQ2xiakePNf0v/22PfGHA9RiK0zChL3IiIuc67R
	 r4vqodvUdEKhyYqs6C3VCaaFTb1s1fhMxie9a3eMS34QktTE7lUWyLkYYpZMnFaNak
	 wcQP33dCriEeA==
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
Subject: [PATCH AUTOSEL 5.4 5/5] USB: gadget: pxa27x_udc: Avoid using GPIOF_ACTIVE_LOW
Date: Sun, 24 Nov 2024 07:58:05 -0500
Message-ID: <20241124125817.3341248-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125817.3341248-1-sashal@kernel.org>
References: <20241124125817.3341248-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 014233252299c..43bb5c66b2b61 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2360,18 +2360,19 @@ static int pxa_udc_probe(struct platform_device *pdev)
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


