Return-Path: <stable+bounces-89837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8679BCEAC
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6450282580
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2934B1D9697;
	Tue,  5 Nov 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q7YTCTM+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FC1D9353
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815573; cv=none; b=bIeeqCni8IQHGLI+aZjN/KgA+huZU7KBoptEZfrj1okXx7cYKS4kqFyQkxkG1KkOXWOr0DZIKE1+hTRl3tbBXF32mqi55ZTZTnig/D4PDZibKkgYpNCryq3GE5EMy8LJTUTwq5rs+sJmzBz3nW4T10G1JtMBKLg5mQKMjgJSJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815573; c=relaxed/simple;
	bh=QVb1o0qgKlSv/qhNBm0mM8Ma1splu8Yi7c/RKdK6kZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFPKwTqei8pNi7VeN281TbwrIsAUQzW6u3Ur41LRcewsHL29kRqBxBWODzovGVbgsRCOoHOaxh/XpuYc5JPDtYwn91L9gWkOxCf9rHZhfOJQ0B6rY7E+Jzk4YpHN4eVf61Cn255MNcvZ44MN919Pja2OcboYZtNiIUYfzqO8n/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q7YTCTM+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b31b66d2e3so26168985a.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730815571; x=1731420371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf0PBF4kMneT4CHz7Zgh8clF/HAKHaFSwjgqCM9cvPA=;
        b=Q7YTCTM+IjYnIZSWoNvmO0a3vBgwu4FvTww1mEK2vigGkojBKJgzml/v3ATwzhvZ1G
         1kGhNdlrA7UokNW9legHVLOozF1foDLSdEcU1ucNotwVtdB8gyaVA1WPLjytPihe6SqX
         nEYO7SO3mPZDTP2ZiedajikwPGVkc/VOn9JwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815571; x=1731420371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf0PBF4kMneT4CHz7Zgh8clF/HAKHaFSwjgqCM9cvPA=;
        b=xTKVVid3aLRXd/QqwLHgZ2biXwlOLJKefJrKBPYPIUSADa6MiSQD9IOc8rKie0jTer
         3uybeWha/84RN0y5fg36CVmxYEa6ts5YmXfkIrWCuR4u6UKu6APhRxTmPW9WdDoyrgGc
         T2QX3R0vCNwkmDO4RwNmGGruJzXxvm8I8fv0wDIx8giiBwsy8Eo1PbcrxuYUQG85fdP1
         fO1OqLMhNFVX7eyGA836NdP8EfAu47TfYo36EoOcQ7k0LkTjELIyOueexKXnvo/IYZ0S
         jZCQmSswH0zmj0o1svCiGbJR0YKVbAOBvNBAW5SpnYOKVJ7ao9PsOLUDGRPitr6ISoS/
         cZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAAkH/8FUn6XF8DHvY+UyD94U0H7/IVwAl0H6wI8d0MPASsFJWAWVDQHgDwohS5iqplCQzPNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jjAyVMzTbGerG5OvvGYNm+qmgffL63b5BOiUXkYdV+Hz/hyb
	zAXYtNCk3uWOXO9NQUi1Xv8h/yna05b3Pb6ffXxg2LueXeM1S3aiG2+hDTfzzw==
X-Google-Smtp-Source: AGHT+IEWVNYihrENoX/DowKpgEnulMjOF544+crUJdNi7nlfrQ1ImMrZyVSzPhhVwnMGSZIZ0F8ulQ==
X-Received: by 2002:a05:620a:45a4:b0:7b1:3754:7da2 with SMTP id af79cd13be357-7b193ed8335mr5096381185a.3.1730815571112;
        Tue, 05 Nov 2024 06:06:11 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a816afsm520422185a.101.2024.11.05.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:06:10 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 05 Nov 2024 14:06:07 +0000
Subject: [PATCH v4 2/2] media: uvcvideo: Fix crash during unbind if gpio
 unit is in use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-uvc-crashrmmod-v4-2-410e548f097a@chromium.org>
References: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
In-Reply-To: <20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

We used the wrong device for the device managed functions. We used the
usb device, when we should be using the interface device.

If we unbind the driver from the usb interface, the cleanup functions
are never called. In our case, the IRQ is never disabled.

If an IRQ is triggered, it will try to access memory sections that are
already free, causing an OOPS.

Luckily this bug has small impact, as it is only affected by devices
with gpio units and the user has to unbind the device, a disconnect will
not trigger this error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 2735fccdf454..c1b2fb7f1428 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1295,14 +1295,14 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	struct gpio_desc *gpio_privacy;
 	int irq;
 
-	gpio_privacy = devm_gpiod_get_optional(&dev->udev->dev, "privacy",
+	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
 					       GPIOD_IN);
 	if (IS_ERR_OR_NULL(gpio_privacy))
 		return PTR_ERR_OR_ZERO(gpio_privacy);
 
 	irq = gpiod_to_irq(gpio_privacy);
 	if (irq < 0)
-		return dev_err_probe(&dev->udev->dev, irq,
+		return dev_err_probe(&dev->intf->dev, irq,
 				     "No IRQ for privacy GPIO\n");
 
 	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
@@ -1333,7 +1333,7 @@ static int uvc_gpio_init_irq(struct uvc_device *dev)
 	if (!unit || unit->gpio.irq < 0)
 		return 0;
 
-	return devm_request_threaded_irq(&dev->udev->dev, unit->gpio.irq, NULL,
+	return devm_request_threaded_irq(&dev->intf->dev, unit->gpio.irq, NULL,
 					 uvc_gpio_irq,
 					 IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
 					 IRQF_TRIGGER_RISING,

-- 
2.47.0.199.ga7371fff76-goog


