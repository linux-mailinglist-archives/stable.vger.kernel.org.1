Return-Path: <stable+bounces-95429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA7C9D8CF8
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98707284BCD
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B331C4A24;
	Mon, 25 Nov 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHBY6daE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CB1B3945
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564156; cv=none; b=ChYQxlUWuIkvFcAjHxifFnAd0WJ1kRr0Eq6AV66aH/0M3rFLFUjJUtpH8lNzD+SL1UbT9wLfvu5Snc2XXqOk0tbCd7Wp+vMtQ3v9VV0YIil4BG25kXYy83WlFlY6NO7zYd4RJAZ07pvsKndrfeIZHOR6FisiFvVT46Rf26157S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564156; c=relaxed/simple;
	bh=lLyFcTzGusxxZ21/v0MWLEmZZoMBS5DH1ioIK8mdVvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DK2ZiPIcsqmZGMX/EijfxA0d1rD+Jci3o+k8t/aHZFoEkQNnTn1Zld98fe5LpQSyvOyYkoTQr5B+JTkEI24v2RcCCo9JdVUSlfwkYYQuXR/ceJyQizqUzjJ8t8lBWjbDa67iblKY0c82HR9iPIQf0sWjaoCOJO15n9EmGyFbgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JHBY6daE; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4af36cafc51so39315137.2
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732564152; x=1733168952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=py4Kjpl4jbTKIyOvWht4p3oY/tRKB4Qm/pLkP0cvLL0=;
        b=JHBY6daETy8Q7UiGJRsUAQTh8Tl99slpPu8pN95/j+DeXW8sDR83aB1LSnW1l0a6b+
         1NoZ8PAP0zY0gJIiNLWZDHg3nBnnoL3OsPQeXnip77/sHNDjPMsDOzQBIX/Y7Ne90Q5l
         zblRRpRKzihiNSiz9hxIP0SHJIkCDd9VMMtNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564152; x=1733168952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=py4Kjpl4jbTKIyOvWht4p3oY/tRKB4Qm/pLkP0cvLL0=;
        b=ikyOuZasSxLE2lAl0iPvx04PhEzicybOSAG3BYxhpccFL2yPRuiqI7QasArz0XPu1g
         1SHlnyhoPENgTIU5OzMnNeQNGwx0j/uOTSyiIuiOhjK4X5lPlXBKLkGrD5UMH3TKcuJU
         Q68t31PzOFySRITyhfUsCgg0hXeVaaOoyVNSCdPggCHu2K7CeKbT9FQVxmrDINz4LrUa
         dl1L5GNSnJC3XhIn+BwJSB3L+IvaGCy7wAsBe+BQdztSRo4aixqsfLykYP8Xthz2XYhe
         yC8lqZ/7sUehAMR2HCaPe8Y+7b9LzSQ0lm5uY2PC5b0DufVVcAXjX2o8AMFLt4cKBBho
         aiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1kFeEnpR04HVpE3+YDHD4HAGSkDWANFOeeViPgaMegmupvMlFwyvPQ2NBG0UGbje9RyV74pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLYy1ekTZ0WnRE5cgxCWPx7aRZ7dmzHXTgfgHJViWDrOJETKP
	/YYG/GpW65L3P0olTmJNhu6jP5FH5V+F+ngLHRnKvnQdRx3Bq1IcjZR3yMyZIQ==
X-Gm-Gg: ASbGncsnipT8X4WFEtOcanakkQID2mlOdlb+nLepIaWHBmJ3nQFRIBHWKtiCEUi4gaM
	TNbydsDe+u2vw8dZ/7FX1sVeVbJ6T8qcch9JplnS00k/Bq9Mj9VhDMm1C/sOspYzsR1xVwVqZ7O
	B5O/C6B90bWK22HHuVfVyyxsgIFZojKIPbdy63qHsgEOgeI68JUjvt7ph65EPifo/pGXSyu0VD9
	3EKnMmOIgXcysuAsMKYFCvvCjml/0Y//gOmNrBQjyFC0WvDCPhAJzK6TzFrhoSmqhsvuGbhnuUp
	C5+RTPpwjA/uVcNd3uEtEuQ8
X-Google-Smtp-Source: AGHT+IHfh1sCJDgpwH9FQG7v6MoIzU1s9FsJav5t2RwVsg04Z8JYUaPat8uKJz8SaNOSIJeURGbBwA==
X-Received: by 2002:a05:6102:5093:b0:4af:15db:6cf2 with SMTP id ada2fe7eead31-4af15db6f6bmr6232541137.22.1732564151982;
        Mon, 25 Nov 2024 11:49:11 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358d2f9asm75324137.23.2024.11.25.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:49:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 19:49:06 +0000
Subject: [PATCH v4 1/7] media: uvcvideo: Fix crash during unbind if gpio
 unit is in use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-uvc-subdev-v4-1-51e040599f1a@chromium.org>
References: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
In-Reply-To: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

We used the wrong device for the device managed functions. We used the
usb device, when we should be using the interface device.

If we unbind the driver from the usb interface, the cleanup functions
are never called. In our case, the IRQ is never disabled.

If an IRQ is triggered, it will try to access memory sections that are
already free, causing an OOPS.

We cannot use the function devm_request_threaded_irq here. The devm_*
clean functions may be called after the main structure is released by
uvc_delete.

Luckily this bug has small impact, as it is only affected by devices
with gpio units and the user has to unbind the device, a disconnect will
not trigger this error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 28 +++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index faf5386cb061..6d34c910a659 100644
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
@@ -1329,15 +1329,27 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 static int uvc_gpio_init_irq(struct uvc_device *dev)
 {
 	struct uvc_entity *unit = dev->gpio_unit;
+	int ret;
 
 	if (!unit || unit->gpio.irq < 0)
 		return 0;
 
-	return devm_request_threaded_irq(&dev->udev->dev, unit->gpio.irq, NULL,
-					 uvc_gpio_irq,
-					 IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
-					 IRQF_TRIGGER_RISING,
-					 "uvc_privacy_gpio", dev);
+	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
+				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
+				   IRQF_TRIGGER_RISING,
+				   "uvc_privacy_gpio", dev);
+
+	unit->gpio.initialized = !ret;
+
+	return ret;
+}
+
+static void uvc_gpio_deinit(struct uvc_device *dev)
+{
+	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
+		return;
+
+	free_irq(dev->gpio_unit->gpio.irq, dev);
 }
 
 /* ------------------------------------------------------------------------
@@ -1934,6 +1946,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	uvc_gpio_deinit(dev);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		/* Nothing to do here, continue. */
 		if (!video_is_registered(&stream->vdev))
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..965a789ed03e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -234,6 +234,7 @@ struct uvc_entity {
 			u8  *bmControls;
 			struct gpio_desc *gpio_privacy;
 			int irq;
+			bool initialized;
 		} gpio;
 	};
 

-- 
2.47.0.338.g60cca15819-goog


