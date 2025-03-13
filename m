Return-Path: <stable+bounces-124277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8DA5F428
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A250217DC7A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657982676CD;
	Thu, 13 Mar 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHTvzOkq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2222F150
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868444; cv=none; b=oU7nlvsG6uuv4zZB53YwiYGpxLXXdb52SzjCEH+0CMErngkzAylBgM9sxMv5+e4EgCpM4FWLisFtZm+0d6yhFm6+lcM3eIYvjJQJRLps8gHGNPWk/f5R7YvBYJWHKiQuh6ycYT+XcQ/PMvSNYdp+MA47+LdPikaRgm7Wdn7isM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868444; c=relaxed/simple;
	bh=AY58SoD+ZhVTBIYdcNttMGVWKza2+aUpZJjjxBBwdDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzTJlasbDKg1l8FrYitSHdXxm1G0AyEjUy5VWSVsFP8RCLm74AJtrEGKnnIRci7cVCbg6WgVnhZEqsW/hd36izygjcSFnjs7fqg7HhV57BByDb6VtF5x+BmwGTqomIyiYJS0JzXH73SY/8X717C8jvvlqVVfdrM91ikRM/Og0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gHTvzOkq; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8fb83e137so8203306d6.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741868441; x=1742473241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LaUbLtHwwn028SmzBwWRS6gnlRFgt6AH8li0LyjHLg=;
        b=gHTvzOkqtS5KplnkpiscnACQfhdZHXHOU96S4b8MdccUveMnf2VxZDoe/lTIi6/yEM
         XwoAUaMz4fVjPHOO5NHEQ7IYzIhj51E7xVrI+9NY6pnMOXF65NDxr7sTTkf0+FYQJ3yk
         1HO0vHJ6vsBX11ASHgqNI5g5Njj7WVLgHi3oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868441; x=1742473241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LaUbLtHwwn028SmzBwWRS6gnlRFgt6AH8li0LyjHLg=;
        b=is4BOCNpJ19lxjkoPOyTTBLXN+a119l+4ABdQnwvkB6EocfaOQTEGvrgfXALT9RmbI
         efkNagZ34ESWO2O7Qtm3HeIA3Ax/UW7tgpTIsM4Ka4trEk0SEjCEirGWpqiB5QWHEY0q
         mJQOGOnWtUUhUmrVKJLRSWwnJDgzutJb/TTGbUIhHzY4NfyGpCnAGt2oxeYe5tL1d8U0
         x/EwSlhhC0ogahJT7Jr/oj3I5vmtoRTweXCIzLxDARTr96O9vPtbO77MKLFw+XGhPFPO
         nlR5RnUiwHkT2G5+BfLZjbw2xuwuP/AfTvcYHIVjx0ITwNqZ9Pb7g25voOWpiDrXEUPC
         tiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR53FkprOBAiMLiiduL3/XzbrDP0ijzGDBmhP9susJFJj/7as8IJW4lGFW4CrtcB82jyfBosg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRtuQy0/PaBNmKVjohfysHjtEdGBF31mN7r+0KM0NdQj0QUSw
	xRjDTLTghaW7hzKi6EXY1JvRX9ukKyX6kujMu2XYCsl4OjsAt30RuhQcgx0d/Q==
X-Gm-Gg: ASbGnctn6mNkneKHcS6mOqE9sIWR7bvSVujkU8fhnJVIbcjswjlGEZ1+5IziKd8bKBH
	2zT9XGfR+Fguv/UU+HkRxQnMovCU3tR9CmZ74hoec9YQtvhvJe/F5+l3SZO7Qfcacr9C5pRqKtM
	a+9oReiW1d8gnDKk60OfIVRgWicKGS76FuCTFFyld/wIVXdzJj5/XQunVBEX/2SAWe1aQs6KPDd
	xfD9CkNKbH0QimB25XXt8fy/cr9OKS6jE3g0l4vo+ptFPBuNdSrZvl1pEUAw6kDizKCl/FDkTrY
	L593+GcYAOYgfUfMfFP26yCp0A/E3IczM2IXPEOwk6Y2vJ9/P66a73Nd6WDEMJOtHo2g7PvZdce
	QRPuL/HCdcueNudpOsA5wVQ==
X-Google-Smtp-Source: AGHT+IEITUBocDzG1BLH4x0HoF9i4dp788zMihFPD7doCspz6hQIiTeuZXkgdafnavqpm9lCQfQD7w==
X-Received: by 2002:a05:6214:1c43:b0:6e6:6713:3ea8 with SMTP id 6a1803df08f44-6e90060cc3emr410041766d6.23.1741868441393;
        Thu, 13 Mar 2025 05:20:41 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade235f9bsm9038616d6.29.2025.03.13.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:20:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Mar 2025 12:20:39 +0000
Subject: [PATCH v3 1/2] media: uvcvideo: Fix deferred probing error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-uvc-eprobedefer-v3-1-a1d312708eef@chromium.org>
References: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
In-Reply-To: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.2

uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
have not yet been probed. This return code should be propagated to the
caller of uvc_probe() to ensure that probing is retried when the required
GPIOs become available.

Currently, this error code is incorrectly converted to -ENODEV,
causing some internal cameras to be ignored.

This commit fixes this issue by propagating the -EPROBE_DEFER error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index deadbcea5e227c832976fd176c7cdbfd7809c608..e966bdb9239f345fd157588ebdad2b3ebe45168d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2231,13 +2231,16 @@ static int uvc_probe(struct usb_interface *intf,
 #endif
 
 	/* Parse the Video Class control descriptor. */
-	if (uvc_parse_control(dev) < 0) {
+	ret = uvc_parse_control(dev);
+	if (ret < 0) {
+		ret = -ENODEV;
 		uvc_dbg(dev, PROBE, "Unable to parse UVC descriptors\n");
 		goto error;
 	}
 
 	/* Parse the associated GPIOs. */
-	if (uvc_gpio_parse(dev) < 0) {
+	ret = uvc_gpio_parse(dev);
+	if (ret < 0) {
 		uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
 		goto error;
 	}
@@ -2263,24 +2266,32 @@ static int uvc_probe(struct usb_interface *intf,
 	}
 
 	/* Register the V4L2 device. */
-	if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
+	ret = v4l2_device_register(&intf->dev, &dev->vdev);
+	if (ret < 0)
 		goto error;
 
 	/* Scan the device for video chains. */
-	if (uvc_scan_device(dev) < 0)
+	if (uvc_scan_device(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	/* Initialize controls. */
-	if (uvc_ctrl_init_device(dev) < 0)
+	if (uvc_ctrl_init_device(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	/* Register video device nodes. */
-	if (uvc_register_chains(dev) < 0)
+	if (uvc_register_chains(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 #ifdef CONFIG_MEDIA_CONTROLLER
 	/* Register the media device node */
-	if (media_device_register(&dev->mdev) < 0)
+	ret = media_device_register(&dev->mdev);
+	if (ret < 0)
 		goto error;
 #endif
 	/* Save our data pointer in the interface data. */
@@ -2314,7 +2325,7 @@ static int uvc_probe(struct usb_interface *intf,
 error:
 	uvc_unregister_video(dev);
 	kref_put(&dev->ref, uvc_delete);
-	return -ENODEV;
+	return ret;
 }
 
 static void uvc_disconnect(struct usb_interface *intf)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


