Return-Path: <stable+bounces-111124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE862A21D3A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBCA1676B0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFDD4A1A;
	Wed, 29 Jan 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N9oKnJFz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C81C27
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154392; cv=none; b=MDqgUXmBbeCvqENapqWTy2oRvlDCSnmeF8P1lbqfumfeMobAJ5d08ibqDDWfuZyPJrSYGeGGJ5Fgkh8LZZ2bvQqLrPeGJogSlEO+/H8NYv0LgB4XWxvNZi5lI4esau5ZgU+e+Gn3wxCBIm2pI1DPIjBsJ1ujbwcnPrWtw8t76/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154392; c=relaxed/simple;
	bh=NH8Q4niJs4pSZDYUZgmPJ182AMQXEiqV6qbRV/5nhqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TKhw1iJjwP7YNqT6zDjg8Yma05fa3cUaUqRR3Clv8ovNhJN310pDi5IZtFYNx5RMIBAKL1puJJSfrFAwf+0W+Pck9WbJKYn5GtnDBq6czz5WNLoR5yirFDk1fCXMKlkFN509aHlB9WmRUGYauIPn+NqKp6Cy13kgmcJyRpyGgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N9oKnJFz; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e8814842so770200485a.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738154389; x=1738759189; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLMpsfmYNeg8S0yCoo/BuyjCEBikFCujpB5IOWC6FmE=;
        b=N9oKnJFzBxZJY4X9sOjkCfCiBjeLn3/2bvwdvVLIebSmg6iXFGdX5vPIY2oQfv8LRT
         uZZAHbznBqEVFyOxDa+9hSG8YXhl4SVfKm152ODfursWyrcAgPwEfG6LBLUvqAzgHdC6
         3oGeFu6kHUeUWzgQVk06DYSF4bBAAB+sv99kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738154389; x=1738759189;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLMpsfmYNeg8S0yCoo/BuyjCEBikFCujpB5IOWC6FmE=;
        b=qLv1O70TJxUTuVJ6yPc2Np7oOI1rM0O0OxbSgIrJP002jS8Va8ZfV/8mAWc2jPzcJT
         EoxpNrvsIxZGtQHf1JrgnquZHbvODmS/AXQ2pd+TdAu6wiU3Np4Vw5T8zq/448IWN/Sz
         m2SQ8wLYELuOpcXTarA/zeUAW/URuOqGapHqabxgWGObBjwp+MURrBLTUXPPd5hY9z1K
         HV4vImOYbrIuosrNlvhq1WLqafyHIi3fY2SL/hXSSnnACChcRE7YG4dQVSayc8Uew5r1
         CfSWcUmlWNx77Fa9sHz8J+ZPoAEV1yffWnor/BobrTMWnAtgR3s6PXPziOD/V19W5T4n
         2Aew==
X-Forwarded-Encrypted: i=1; AJvYcCUP/z/pOe8/uPgXBk/8LKYdF3xRwweIMeghFMLcyKmf1054Fwb+hZwwAm6gU+igqzkTM9vdvDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyTsoj90Z6iRMP5p6siGPdm69w0rrV44uI7WpVZ5q8A/hF+8t
	eYzGCh+kNbDRO5umIB3fvyYbP/THraqkt6Ho+05JQe7OWu4K65hgRh00eMybHA==
X-Gm-Gg: ASbGnctzJyFNrTtQMb0/O2mSjADSRe/RMjneS0dTYROiM9qSNplJ3E/y9EJkQjXWvL7
	D5z8hhHu5iKXZw70PFKWWLWnqhN4MuYJZ/s8UkAURL3fqm7dtKxT0cBxKFOs2DtzQNEk9DwOcnx
	ACH6B09Pxhg3huFVPbJ4pXzQPKkBctB/jWlXH3kqzeEzTnEwirlvvglH4VgHrZIK7b1R3Hladpa
	s6DeAxzXB+U6MgyJF/IRVBspoWGXBbnPm8Rg8Alu5/yrij0obf7xV3nZH2xB6DUCSMYSf1xgvEt
	Zvo7jmRu+RI/4b8gHlbsh59255xX9njH5zMcWi9ZG7FffQMLV4iBeyA1g92YdD/+jlPDp9Ghpgv
	0
X-Google-Smtp-Source: AGHT+IFt0EbHXb6QlqMF4SNnfs9Wv+pT/TKw//M6O86iQrBWZWyL1ejpH5iUC3pvecax/9xQ/QpmNA==
X-Received: by 2002:a05:620a:454b:b0:7b6:d1ce:67d6 with SMTP id af79cd13be357-7bffcd736e1mr422788785a.39.1738154389613;
        Wed, 29 Jan 2025 04:39:49 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6686311asm61572791cf.15.2025.01.29.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 04:39:48 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 29 Jan 2025 12:39:46 +0000
Subject: [PATCH] media: uvcvideo: Fix deferred probing error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org>
X-B4-Tracking: v=1; b=H4sIAJEhmmcC/x3MQQ5AMBBG4avIrDWpUglXEQvT/pgNMg2RiLtrL
 L/Few8lqCBRXzykuCTJvmVUZUFhnbYFRmI2Oeu8rVxnzisYHLozImaoYQ/mJnJbh0C5OhSz3P9
 xGN/3AzsfaHRhAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
have not yet been probed. This return code should be propagated to the
caller of uvc_probe() to ensure that probing is retried when the required
GPIOs become available.

Currently, this error code is incorrectly converted to -ENODEV,
causing some internal cameras to be ignored.

This commit fixes this issue by propagating the -EPROBE_DEFER error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a10d4f4d9f95..73a7f23b616c 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2253,9 +2253,10 @@ static int uvc_probe(struct usb_interface *intf,
 	}
 
 	/* Parse the associated GPIOs. */
-	if (uvc_gpio_parse(dev) < 0) {
+	ret = uvc_gpio_parse(dev);
+	if (ret < 0) {
 		uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
-		goto error;
+		goto error_retcode;
 	}
 
 	dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
@@ -2328,9 +2329,11 @@ static int uvc_probe(struct usb_interface *intf,
 	return 0;
 
 error:
+	ret = -ENODEV;
+error_retcode:
 	uvc_unregister_video(dev);
 	kref_put(&dev->ref, uvc_delete);
-	return -ENODEV;
+	return ret;
 }
 
 static void uvc_disconnect(struct usb_interface *intf)

---
base-commit: c4b7779abc6633677e6edb79e2809f4f61fde157
change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


