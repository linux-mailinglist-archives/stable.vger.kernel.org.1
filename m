Return-Path: <stable+bounces-91728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72809BF80F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 21:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A682844AF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E220C479;
	Wed,  6 Nov 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hsL7sM9r"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2720C33D
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925372; cv=none; b=SW49h0DlugF3+2KY0cdAENjV6Ws+yOSqixKYIQTVNz/RuKdbtbkUEAtzdWeDm2Iq5Mm31NUqKp6vPpV/Ip6nO7bDmXJJXaqKKQtWZgxE5vkKlcK8qmefFfsY3J/3wbnUduApf6yecSVNfNk0/VJeG9jgA0HLaPNqrqkjg+HN9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925372; c=relaxed/simple;
	bh=DDan4rb3ZDfZooaIPdGKMHpMdyXPRM8PAAJJ+ibuzD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YyNRziFVQGaI6VI6jkq4quEzbkbJ7LAX0WKJrooC/HNqOvfhMD0WqCN2PtlrkccSzCqHmNIHpMj8r2DvIlFl6vgBfzLoZW7MJWiwx/3PppVE3aQlLml+BhHd/WdbSSxzwNZtz8mXWtQs/mQFICWlo09kIzybWpX5autBOvRb6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hsL7sM9r; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbe3e99680so1328336d6.3
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730925369; x=1731530169; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDv+Zw29UPJy5Wu1eDDdz3Y9nEtJru0vhbk85035bL8=;
        b=hsL7sM9rQLJaKg6ZTjk7LJnDi5wQOFKuGL3sTeNnwXA8y4Bq3JnLjYuCliyg2FRIJz
         3C2+KTOcTun8dfE3/YZA6zvo/ER9vnooEnP+KKNCg3JeuElGIKrYupMd2pFPuH5fkcHS
         DGBgfPKdH2mOAL9lVaPxu4v0ymV9NmpJLoQsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730925369; x=1731530169;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDv+Zw29UPJy5Wu1eDDdz3Y9nEtJru0vhbk85035bL8=;
        b=XT8VdaSC3MPmUyr3JIJ2LKSFTerLDNEAiVodHxEsz8QfkwqCVnshufXpNesH940jJn
         voT7GhrRWGZiIrBpbfYB0zgCmwjXT3/ihKNfBrkdSO0rSLaPzM7LI2vTJdsx9NWLThsd
         6DCrnDk3z1ligH9xZ230B9QvDJBwMP9JVxOCIPlJlmq1rB/2l1dP27jAB5Hiqt7Bnr9L
         6AvlSdAfz7EWAcjrrOkGvMtyh4VIMPegrOuBgXsiFqfe9fN7sM/UPpVUMa3wUnuOKoRu
         uCN90p+QRjnFm1HkxyEeeTIBB9cwh33/Oa/deIIAqOumKwov3bH2DqRDa8ovEbn/FbqY
         WkHg==
X-Forwarded-Encrypted: i=1; AJvYcCW4D+oTysd/z1i0prBe0Qr34/f86mSg605fKeQuzZL4fbBAt96cNqzj5zKkOZBKN4qqaik05Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy857p3K74jxl4uccOPX0fwFHVBDkH4MkA9HCayxFfVqz1pFzR9
	4xDapy43M0k9QX1Y9v5gjbHN5Ia3AWuOrkA2mcBYQuzQZdWzKikargvzSQsXSg==
X-Google-Smtp-Source: AGHT+IGneR3U1qsCjlwemlshVx6J+SNXK0Oj1alprvpKqgmhnx9tb/oDytUpxjX089+aCQwqJcBjVg==
X-Received: by 2002:a05:6214:3990:b0:6cb:ef1f:d1ab with SMTP id 6a1803df08f44-6d1856fa3dfmr624113066d6.30.1730925369092;
        Wed, 06 Nov 2024 12:36:09 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9f1f6sm76449816d6.27.2024.11.06.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:36:08 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 06 Nov 2024 20:36:07 +0000
Subject: [PATCH v6] media: uvcvideo: Fix crash during unbind if gpio unit
 is in use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org>
X-B4-Tracking: v=1; b=H4sIADbTK2cC/33PwW7DIAyA4VepOI8JA3bCTnuPagdGTMMhZYIVd
 ary7qO9TNqyHH9L/mTfROWSuIqXw00UbqmmfO5BTwcRZn8+sUxTb6GVtqAMyEsLMhRf57IseZJ
 ENLGJwYEF0Zc+Csd0fYDHt95zqp+5fD38Bvfpv1QDCVKhi4zOvAPTa5hLXtJlec7lJO5a0z8CK
 Pwj6C6gHQKTJ0eaNwSzL5guBOXQhdEpmsyGYPcFK5Xs/zHaMSo3+A0B9wXsN4ykTfQIfrDxl7C
 u6zc62tpQtwEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v6:
- Rename cleanup as deinit
- Move cleanup to the beginning of the uvc_unregister_video.
- Fix commit message.
- Link to v5: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v5-1-8623fa51a74f@chromium.org

Changes in v5:
- Revert non refcount, that belongs to a different set
- Move cleanup to a different function
- Link to v4: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v4-0-410e548f097a@chromium.org

Changes in v4: Thanks Laurent.
- Remove refcounted cleaup to support devres.
- Link to v3: https://lore.kernel.org/r/20241105-uvc-crashrmmod-v3-1-c0959c8906d3@chromium.org

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
 drivers/media/usb/uvc/uvc_driver.c | 28 +++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a96f6ca0889f..cd13bf01265d 100644
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
 

---
base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
change-id: 20241031-uvc-crashrmmod-666de3fc9141

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


