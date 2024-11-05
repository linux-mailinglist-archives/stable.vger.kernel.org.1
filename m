Return-Path: <stable+bounces-89826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25F9BCC2F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 12:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8785A1F22F59
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F11D47D2;
	Tue,  5 Nov 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L84srXcQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC11D45F0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807567; cv=none; b=D4lpxO9pquEVEulETMB7QMNHbC+HyAm9U40xZq4KpClbP/ibFix3U8NRU/sh6wuZsB3xuqtivTQizkR6tMgJdd+Pp/EGcS3o0ILzWn4GCrwAHsPnpKrGR9faoT9myGFoerfh5ab8VegRPRexbbQKc9mRqd0JKLXcT2W2uy7A/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807567; c=relaxed/simple;
	bh=gO46HY+G6XxQbiGiOKvV2bnssoW8+iRRfKm65pmUsTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JlFHgtFpRPrQCJV8kvF8LsWQ9GrPBCdqNqUvkWSXuIfeu2D71Q6f/vWH6XIyoiJ+uLE8o5CqJkmKMeZGJtETvudWTLuHZJ0daYQCuMiY5dxKGfOBVWUSaHhm7p4cGIHSyyZ9mtHvAP2BT3Y9YhSlHCRIHA5If2wDBrx8wDU0YPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L84srXcQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b14077ec5aso573074785a.1
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 03:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730807564; x=1731412364; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ofb4O5k7ScBTS9IwYW2RwcG1xUSVumFbac8Ekv8lGCE=;
        b=L84srXcQmT7sjUeB1KSNTjoxGiPSDdsVVaSO3X3909/cYEMQkPldg0HPadhds+MmIg
         zEwFhVXGEtTXUXaqewB9VMVpfQWYkCPL36pzeQeKyfNQT3sNUiaDMB7IyuQUHwXPaJiI
         mnYHA/eep4LNb2/niJzBG8KgVfB66G06Owzk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730807564; x=1731412364;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ofb4O5k7ScBTS9IwYW2RwcG1xUSVumFbac8Ekv8lGCE=;
        b=du23VvqomOK61eYcLuBGMICot1yJ0Rh476m4uznySr7wpaDjqB6urT8efQirtEY2um
         kDK4g2gv0CYpakbrTSFBsS0/+Co/65WoFn87qoInXcahHggp1D4mEJ4rbk7ciuZoP0Z4
         cnE9DI8dn8TvJeMQDHJIIGsunedxvjU6iIYJUhlXllpH8JOm6dbeDBBrgLqoQNriL2sp
         I41fSNmsZKpYkJY4n9XloSpwXi9GC+cIQCOIqfLZmAFND0pT/49YFO9ItjFzuVmIJLnK
         x0RJt3bgCzsbZ1q1+GE0a7oNwC4wGp+5Ab2Q4ngb9+ARbGBZ0gJ6Hp2agnRubADcBmcx
         grUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNRHRzNTjllbJhP8op0jp215AvSHC2qN8myguC+GNdOFO0qUyBBQ3YV7CNqWovc+CIW6Hmbtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpF7jMH4FodrhmAcoi4xe5+yaBfD5cou7aYUPUKm3iYxn3Jg+4
	IVFdnIy98p1Nr68p84qMMmRG70OuF6BLTi3+/RRKBlzoKgDazu0P1TsAQdXEOpJBy+9gP0dtTW4
	=
X-Google-Smtp-Source: AGHT+IE93fkW7NxOLpb23hENwHScNlWuN18Y4gga95Q7c30Pplx0GFukaYtqsIX1fHLp84oe/h2fyw==
X-Received: by 2002:a05:6214:4344:b0:6cc:44b:105a with SMTP id 6a1803df08f44-6d354306117mr326187606d6.20.1730807564660;
        Tue, 05 Nov 2024 03:52:44 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353e7a24asm59001756d6.0.2024.11.05.03.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:52:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 05 Nov 2024 11:52:43 +0000
Subject: [PATCH v3] media: uvcvideo: Fix crash during unbind if gpio unit
 is in use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-uvc-crashrmmod-v3-1-c0959c8906d3@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAoHKmcC/3XMQQ7CIBCF4asY1mIYKBhceQ/jotJpYUExgyWap
 neXdmOicfm/5H0zy0gBMzvtZkZYQg5prKH2O+Z8Ow7IQ1ebSSEbEAr4VBx31GZPMaaOG2M6VL2
 z0ACrpzthH54beLnW9iE/Er02v8C6/qUKcOBC2x61VTdAc3aeUgxTPCQa2KoV+RFA6B9BVkE3R
 4emNdZI/BKWZXkDjjQ79/EAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
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
Changes in v3: Thanks Sakari.
- Rename variable to initialized.
- Other CodeStyle.
- Link to v2: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v2-1-547ce6a6962e@chromium.org

Changes in v2: Thanks to Laurent.
- The main structure is not allocated with devres so there is a small
  period of time where we can get an irq with the structure free. Do not
  use devres for the IRQ.
- Link to v1: https://lore.kernel.org/r/20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c | 27 ++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a96f6ca0889f..2a907e3e3f81 100644
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
+static void uvc_gpio_cleanup(struct uvc_device *dev)
+{
+	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
+		return;
+
+	free_irq(dev->gpio_unit->gpio.irq, dev);
 }
 
 /* ------------------------------------------------------------------------
@@ -1880,6 +1892,7 @@ static void uvc_delete(struct kref *kref)
 	struct uvc_device *dev = container_of(kref, struct uvc_device, ref);
 	struct list_head *p, *n;
 
+	uvc_gpio_cleanup(dev);
 	uvc_status_cleanup(dev);
 	uvc_ctrl_cleanup_device(dev);
 
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
 

---
base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
change-id: 20241031-uvc-crashrmmod-666de3fc9141

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


