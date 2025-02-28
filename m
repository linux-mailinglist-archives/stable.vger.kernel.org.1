Return-Path: <stable+bounces-119899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E4A49262
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BA616E08D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC4146A66;
	Fri, 28 Feb 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QpmkXNrh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15617276D12
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728775; cv=none; b=P11JLGu8456a+HWU0J4SbXTLVAiZ7vrAHDFe+ZuS6zt9+3fHNIu9lFrGjoOPlsxn/l6pdWLs0rN9foE/hisegd473wFarqJYvJof0wdDgAYBAF8T52TQ4AfjMaFiQU2mg/QY9GjGEzWLzFPEeFckookNFMUcyyetfq6Jt7Wq5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728775; c=relaxed/simple;
	bh=HLFgHxr4h55dTYtNXjajQcjiBfoVH3GIW5LbNleQsm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvrtSMeTpeWo+s3KDnqJrDzmM+PRNK2ecI+0XAy5sEz7jYflcU7s3Np/z3t4xOiR7Yh3lO4sHx/aDUNJvc0OY9kv6Iu8MuRg3tozFTDnE482ACFPvCU0ZkOLFHMug75yZnp42EPM709iREy+W84b6QHRumsutV/j0pr9RgNks8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QpmkXNrh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47201625705so28900751cf.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740728772; x=1741333572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhM7Smr9YZP+gi2QWuUcdxkdlqN0yh4E8xCgDW30pJo=;
        b=QpmkXNrh97g3tGnvj/rWI04vcCaJ+LsjFXSnpVCSsOSsHHqSNqpLFhC3j3TngnfxaH
         HckY1xo7BkvRHaV28rWsNEdQxCoAqYdgqD7lYwdS4p/GhlusDhJMMIowhguEPUI0o1Kq
         7mD7Khbep0MZABQIvdh/r9RAMBQKd4YnU2Dg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740728772; x=1741333572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhM7Smr9YZP+gi2QWuUcdxkdlqN0yh4E8xCgDW30pJo=;
        b=PhYGXEtEYa60fuPyZi3vAW+EvNyI2y4QNVp8klRvAxKMiFI7sSq1GVu/BPz0fMwm4f
         d2jsDQN6GRS/2D3KbFgMJ6CcHVJQket8xxbIhihJREdx99PZt6ZdgiqBZL1Bw8xlgK//
         ueh+EhwGLo28zNsgBAO+pu3mQyv60bl7mAiBwk4kedihGwVhtZguslzJPzfhp7uPjgyg
         RuGEURzLyhxP7E2RZqHx8okR2PLXkwuScMaE9Ch/4/ce9nxEDmehgezM+bu9Q83Ndxcu
         SCcwOHj5dg2Z3f9YF5kt0Z/3mjBvOoZqRQzWjsuYZGrvCMpnuqdFFAdoEn4PGGvGKxaj
         E0Pw==
X-Gm-Message-State: AOJu0Yy++XUEjWNhHbB1HdOODw9nxk2561H+DbyFIxdWsgs7VDHIRMGp
	x2NgMvEkZWkSoEg6tbavh0g7yBdZ1kYW6wPsZmvWKKtC0EEe8r+Ox9/ilJkjRNIFuzcewBJfVhl
	EoQ==
X-Gm-Gg: ASbGncvjfvOGTJvpuhTrEgSY4HaHdJFrnU1KhqHlQawoCfoHSYSFiY4OGo8in83on5L
	cfLreCk9IB/DlDsF/vsXwiRPa9Hu0QeAG0HmsYz9yBcQjzo+44UQ4upRN9CIHg9pddQic7F5qin
	fqW+Fx+Hu0yVkGH95onjhrtNpUaU/FWZCt2PYN8HNg00bWeH9eFV4E1BkH7thxV7XCUAnaiqDWT
	JYnXXkDXRn9R5ArQ+L4uco8eoVpU7YCV/4DlPgwWV5OjdguC954Gs9T24LjD5hfuhuz/1uV9PX3
	eU/DGOe7D3Ei44cr4NVSDxxRlUPSp8Rapqiw99NxMbyc+n618fB+IQ1Vd+zWggi5uv2jBHJK1yj
	mPO2LHC50
X-Google-Smtp-Source: AGHT+IHnL4vcHyo52Xh85dhF/Bz2zeTGiqWLe4bTEDmMcNOZfW1I0EdhNJuLZqwT8viV3hx8VfWMEw==
X-Received: by 2002:a05:622a:20b:b0:471:f9bc:fe53 with SMTP id d75a77b69052e-473e55b6a2cmr107802831cf.26.1740728772569;
        Thu, 27 Feb 2025 23:46:12 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a2427sm21775291cf.16.2025.02.27.23.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:46:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15.y] media: uvcvideo: Fix crash during unbind if gpio unit is in use
Date: Fri, 28 Feb 2025 07:46:06 +0000
Message-ID: <20250228074607.2609635-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021032-zipping-fedora-af63@gregkh>
References: <2025021032-zipping-fedora-af63@gregkh>
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
index 1942b9e210cc..c4b272c7aacc 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1530,18 +1530,15 @@ static int uvc_gpio_parse(struct uvc_device *dev)
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
 
 	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
 				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
@@ -1567,15 +1564,27 @@ static int uvc_gpio_parse(struct uvc_device *dev)
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
@@ -2168,6 +2177,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	uvc_gpio_deinit(dev);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		/* Nothing to do here, continue. */
 		if (!video_is_registered(&stream->vdev))
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 1aa2cc98502d..f7fc620c790a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -368,6 +368,7 @@ struct uvc_entity {
 			u8  *bmControls;
 			struct gpio_desc *gpio_privacy;
 			int irq;
+			bool initialized;
 		} gpio;
 	};
 
-- 
2.48.1.711.g2feabab25a-goog


