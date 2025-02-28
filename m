Return-Path: <stable+bounces-119902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F9A49279
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCEB16F501
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12861C3F0A;
	Fri, 28 Feb 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePQBZdgR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5C276D12
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729162; cv=none; b=gPCnI0j8gS3JUP4Kv2W4bBCRgvolEIpqGa0eKfAjA7TUrU3UQv1wDGJ9nYyoyeCV2noeKgwEd+tawqnp2gQjETPU8Rr45g8vS92B8TfBGX8OYxnBUrS0DVz/upOLCzol6Q8PjmeGkQWLYybywzSoA1UHRigSbY5ZytEUw4SQwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729162; c=relaxed/simple;
	bh=5IwV3sel+SJV2/8QMA/UIjS+1J8HiqdQCgpAd2jnjAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjjJFlL04Q712fd6q1zKXpTiwuPEt+Ttb2qjOxekKLHbhIeCLoNt3Sao1n4pS+scDWnPvcRvpIHQKHOIGbq3LR6q5MEY0vlPbHgHd/yTilnDEP9DN5kLIa5T1hv8g4cAWlZcN5HgaSl4J1ti2kBo6VLUodOmIMIIeYBc8VjwGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ePQBZdgR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e44fda56e3so17246276d6.1
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740729159; x=1741333959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBkcEz1Rbw+VlzCs0bMooT5z0Jbto3y6Gll/guHpxgU=;
        b=ePQBZdgRnHEAKJsi2JNXV36JSeH0l03w5Y/SGwR9aHt1109b1OtOzUv+N2OzIqym9t
         CiHohggZqYNC3YIqTlC+uuk5ioOvR3Q+ZgrVa60OWND0AKpKYqf3j9XVd406837vs9Uo
         DVgSJhJS9iO+o2aDdEPipWxEE1pFAFN7nni9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729159; x=1741333959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBkcEz1Rbw+VlzCs0bMooT5z0Jbto3y6Gll/guHpxgU=;
        b=UbmcBctk4KBVOwMvNbZvLwBAqOezcTVP6q6s4qXAsEkKRpfFRqOEs+NU1tQ1Exq1vv
         zjDsSAynDq0HbbmfELorz6Mtd8rIHEyZyCNhZV7erbRb22VPEklaJlpfzqhDPP5zGN9a
         PQU20VuVacnjlRWW6S/SCul5kddmikTn3IiMweQ9QaGhCzR/8xBqObZcQVGeI6F/PvLy
         VyHl6ME9Lonzd852vAR/0JKtrFo5ExjmAURc004ALhEMM9TMLfB9b4+eaWtaqrJvxLhN
         LaP+JyOFCvKrnMc41dZYFmUqimPd7X8xtiRDBd+7SHCDJkayCeF+DLszB4zZAMXJLBiP
         Bv2A==
X-Gm-Message-State: AOJu0Yzzws+WnZNfd8tTDCOgQdXyaDbdCE7xp+C3Ajl+JBEMsVwL/Isd
	h/hx5ymvZUJJVxGtThTE40HI1RHGWzlHsCtpU4x2Q2l1NPW6pb0eL8aIHomyxc4BUgxUZc+dcDg
	U+Q==
X-Gm-Gg: ASbGncvq3t64Euf+MX6oFwPpRRbqvzs3vF2IUzkwvj0FuO8BbLUKLmVmWTgLKo33lNb
	3eqXzBX8SkJbPOCpPm4s5rlOyAkA21QjOVAtwdQvwCo1fWQKaK0P6uQZBv6BG5FQIhngvSjMbVw
	IsKHXY+hIxu6iCQsu4bySfeI3DKJUgYoMv0Tkj8EmoHfKNDRV6cLe5++6j2bWLkBXU6YSRCCyrq
	D5kRt9pfmx+7pB1RvNzxGbSugDgzZLsE/k2fmeba3jB5gh4DULYuoDiunW/bOyuzHUzxct8qxXc
	zR4GYxw4pSjhiYBe9XFQzkE/t8K2v5e9CmMD8am85EWgQqXaCQhNzNS4gJ9I5NpB2TDa6GQfcMp
	BqmujyYAj
X-Google-Smtp-Source: AGHT+IFzp35KzUVlbd2S8soEd547if8gyHjxXQgRyOv7bwH/HJIsAXEOBrbzjVbNhdEPrxpAvSni+g==
X-Received: by 2002:a05:6214:2241:b0:6e2:485d:fddd with SMTP id 6a1803df08f44-6e8a0c89bb2mr39210456d6.1.1740729159520;
        Thu, 27 Feb 2025 23:52:39 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634926sm19587336d6.9.2025.02.27.23.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:52:38 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.1.y] media: uvcvideo: Fix crash during unbind if gpio unit is in use
Date: Fri, 28 Feb 2025 07:52:28 +0000
Message-ID: <20250228075228.2623486-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021032-enlisted-headband-7a1c@gregkh>
References: <2025021032-enlisted-headband-7a1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit a9ea1a3d88b7947ce8cadb2afceee7a54872bbc5)
---
 drivers/media/usb/uvc/uvc_driver.c | 35 ++++++++++++++++++++----------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c8e72079b427..47a6cedd5578 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1247,18 +1247,15 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	struct gpio_desc *gpio_privacy;
 	int irq;
 
-	gpio_privacy = devm_gpiod_get_optional(&dev->udev->dev, "privacy",
+	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
 					       GPIOD_IN);
 	if (IS_ERR_OR_NULL(gpio_privacy))
 		return PTR_ERR_OR_ZERO(gpio_privacy);
 
 	irq = gpiod_to_irq(gpio_privacy);
-	if (irq < 0) {
-		if (irq != EPROBE_DEFER)
-			dev_err(&dev->udev->dev,
-				"No IRQ for privacy GPIO (%d)\n", irq);
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(&dev->intf->dev, irq,
+				     "No IRQ for privacy GPIO\n");
 
 	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
 	if (!unit)
@@ -1283,15 +1280,27 @@ static int uvc_gpio_parse(struct uvc_device *dev)
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
@@ -1885,6 +1894,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	uvc_gpio_deinit(dev);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		/* Nothing to do here, continue. */
 		if (!video_is_registered(&stream->vdev))
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 33e7475d4e64..475bf185be8a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -227,6 +227,7 @@ struct uvc_entity {
 			u8  *bmControls;
 			struct gpio_desc *gpio_privacy;
 			int irq;
+			bool initialized;
 		} gpio;
 	};
 
-- 
2.48.1.711.g2feabab25a-goog


