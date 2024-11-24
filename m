Return-Path: <stable+bounces-94886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4249D74D7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB61B3837F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBE51FCF5B;
	Sun, 24 Nov 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXyU5+M2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122791E0DF8;
	Sun, 24 Nov 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453085; cv=none; b=EDBalOcGZPVtuSguLj+OIE66Rpnfeao/t19xDigXshNNcaKt3RBMiXInJ7L4+3OdMmhmkdu2TZ2pMhYgFRpTUxAJ/rDFAFJAEOS8VeaTzPUrmhVYAsl/quTqhN3HOYPflC3YWZLrJMmxBC3LinC05gZk/11j116yS0l7BFadB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453085; c=relaxed/simple;
	bh=LholdvR3UhcQdCCDyRLxrggGRbNmQ48l0Ti9x/4pk/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOjm1UJMFfNxO0JdVA7fR9kD8aCQvKnGkVf6B21H5vNPzr2buHgu+lmCMaMFR3QzJtPl54kWid4sGa6CRqYKk2Jfi+ewVil05LVNHM7/nIuTES5Nr2Faw3IE1EzTggRFzmT5oV0a8n76s95VEdDEfFfLSMw82N9P+i+FPMIOUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXyU5+M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30374C4CECC;
	Sun, 24 Nov 2024 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453084;
	bh=LholdvR3UhcQdCCDyRLxrggGRbNmQ48l0Ti9x/4pk/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXyU5+M280T/ECn2NUNsRTOkmoTCVt9Ly/I41QmMHusfNiNOSd7+G62stDoxCX7Qb
	 6A9HCjpEp56Jn/tgq47YHdLS/hJi9bKCSWjoj/0Z552aUuKi8hsRmArlWDfpvXhJZL
	 yJZiEBBpTjMsC5xJrbkXBErMWf0meTY+f6Jq3Af/434tEQ6ZHMrVYZyXMh3bSTQ/Zs
	 LYnhBKmfjh/N8Q9m93bFWA9FQG4aE+1ewQLykH48rLmj7RXIrPLuYsd7sGM3fMq7AV
	 pM9QrrpaaH8O5Z8QIW7Jf7L85yX5uGKqgeQ2cuX3tcqacltG0J5PeQJHapiGpkAOqW
	 f8l7eW5N4hnQA==
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
Subject: [PATCH AUTOSEL 5.10 6/6] USB: gadget: pxa27x_udc: Avoid using GPIOF_ACTIVE_LOW
Date: Sun, 24 Nov 2024 07:57:08 -0500
Message-ID: <20241124125742.3341086-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125742.3341086-1-sashal@kernel.org>
References: <20241124125742.3341086-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index cfaeca457fa72..001f666eefffe 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2356,18 +2356,19 @@ static int pxa_udc_probe(struct platform_device *pdev)
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


