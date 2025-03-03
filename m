Return-Path: <stable+bounces-120181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAADA4CB98
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E9116B07F
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EFC233D91;
	Mon,  3 Mar 2025 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SW4UHc+V"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB45231CAE
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028838; cv=none; b=qGGw4yR5E+GSej9VJiX4qNsc8Srzodhcu4ULsaX6f1o3vivFJo7I5bVZ9T2Ij0ukpOT3YtvurpELCeN5Kt+Q5ub7/f+0w4iyYjuIdVXVTgBq2nzG0TC2Q2DhnyPkG206tOxjtv6lZLpZRX0jltR+o9nduKgjIAASFZbSQqRP/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028838; c=relaxed/simple;
	bh=zwKv15o7Jo/9fgFeCeS3GYugU2qgxl7huykM3V6apSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9VVrW2FDx6Rx1s4xT1m31lnzEr/52jbor5RgwTJP8Wv5H1NNfdzHV3LkCWxQvkmGS9McWJJWFY3W8dXdTvgCY1aDYI9Y/fsjCh/6Bzk+m9vlxvWk4+LL1zvL2MdrqbGPDpOJEE1Fp43tmTvT2UGft72boVh83hm0/DUQul0G1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SW4UHc+V; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-474f0c1e1c6so12196261cf.1
        for <stable@vger.kernel.org>; Mon, 03 Mar 2025 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741028833; x=1741633633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8Gxk9vB5xla0tvwCl8Ds7W2l2MwxkkWMXQxVGtphCo=;
        b=SW4UHc+VNeQadA0BI0YXHxoHnIzwokI2ZDq80cev7H/Y7t6MdxTtJaXjy4m5qyiOSA
         1Sex0aJarUpORl75xVe97ao4T6T97bHrawc63MMA+2C0/TCB/0yPhheBuyCIr1pO1M+B
         +oYWFhBU6d0oITBxUUohKopCb/ZaNQTMRvHj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028833; x=1741633633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8Gxk9vB5xla0tvwCl8Ds7W2l2MwxkkWMXQxVGtphCo=;
        b=Fim1tKQOawKanNH50R87GqGvOPJCdpNEgZRP6GyIeRxd7/eHp3Ikde4+k9hRwHPpu0
         uEZMKV7mdtETaOR+ErhnG4fO98heo0KPPrNswCBTp14yozQYrvTUKjxAE1JRWrm0QF2k
         MjMZcZAIDf9E0Vtb5cTkTAce2fhlrIIwbUPwkAgCCm9VtC1TFKqgKbvpb1OTjB/U13tU
         YcGdbax0ktF0q0BcX1yahGjZrGKbNoLCymIQ3UU6B2GpUqPYjpYLrzEQ2hpczgpEoPuX
         OyFJbF2VrlratNfbwWmSwrWhhmPKiJPw5/jD0SEUiXEeKluvF5RpfEH4mnOaUArM+/od
         7xYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfoPlVcfNi7W+e9xoUM8dCFQ/j9bX+cslzayqXPeFgL8D4ktu/6j2AmHWyJGLTTrSHsjUabUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUVgCrsPGBq2FF7Lr5cXGvWkjI2Vn42C8JE3tIUFQWEt+fDGH
	qw6PGovVXdd5JnTvU9CR+BP9AHfKnIaZ8ily7nu6x+Piw5X5gHC8qj5AXBz7z4Yg/32EDcJuCPn
	LEw==
X-Gm-Gg: ASbGncuh60dRKSPCXtTmFCg2fBa6Y9+RAfjCkr2YlW+nQwA4b08EPYsbzd9w+GEyi07
	JmHkOqA7X+eA7SCiUIzPdna6x+UNXebDC1aQPejsxH1ZrWej444U83LQ/irgbb20HTVc4cYgZ+R
	e5lLG8js30SCajz1Xj7KuLke+/J1i16s1/4c4bY5V7W0wSaqLyABRj9tVXnHNiSyUCHjmLBHfJ2
	3W5o4v32q7RKfxBFTongLC33myKXfWP9n49UQHBSaMyaGPxoNjFmIbcutUJxPN8xBrErt+Nxepe
	qHHPk0lj8GVa137f+a+nadW09c37BMbG+zLNi5I67SW55/v70MQ0yCJWxks1aTpuAZfJJ9LH7mb
	Sg0ibavevXD0byohtx5HuFg==
X-Google-Smtp-Source: AGHT+IHNtHwExEby6G65UwGqmP6x3/NpxGPVOKVUd7HVUEskMl+/Yh0StRkgXpJdIyW8qdJRBCX/Ug==
X-Received: by 2002:a05:622a:152:b0:471:f539:481c with SMTP id d75a77b69052e-474bc0f6308mr195158551cf.39.1741028833678;
        Mon, 03 Mar 2025 11:07:13 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f1b76856sm10218651cf.16.2025.03.03.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:07:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:07:08 +0000
Subject: [PATCH v2 1/2] media: uvcvideo: Fix deferred probing error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-eprobedefer-v2-1-be7c987cc3ca@chromium.org>
References: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org>
In-Reply-To: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.1

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
index deadbcea5e22..e966bdb9239f 100644
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
2.48.1.711.g2feabab25a-goog


