Return-Path: <stable+bounces-95548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E929D9B3D
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3F616753E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A41D90A9;
	Tue, 26 Nov 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgn8Km/S"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716B1D89ED
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638028; cv=none; b=oZg2hUEPAsVCqtkg8vkl1Dw9MnEpTyoxSAygwtiofZGUlsB1FUk+iMx3cPCoGXU3q6EiccFl1qH4UiPU1XvaxRdiGzL2bhkRt9w2aNH1QBVf6scF4Z+9WrdyE1KxB7871povD39kdk4cxWgGe0SMeJFf7mmVLVA0Y22xDFvo3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638028; c=relaxed/simple;
	bh=P7cJDdqJWrLuL8K2uEZRvjaoWn4MVm6+xAAkGWyiVYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZvoSvm3i1gHdDGBBHvJDo0LlnXZW27TtWfq3iIp7oOCloiZLLyxhPYOV8idHMdcFow8IM2dVLXQALAwKyRZtmfXfCAyAD4LK/ixAGLNQJjlIKCL7HdV+HsLwOo12UZ3Eh7fW2xxUdPln4S/uPA1Aqv4pOClylyEHAZKqZyx6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cgn8Km/S; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f1f5075cf2so899166eaf.0
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638025; x=1733242825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=cgn8Km/SwG/fy7Su2kBHmgQdxp4jgrnKQwgxfpOGNl+ypdIaiXrPknhCQbvMIZTfJt
         R/a0qS+xkU7kokODG50CKAm8vWLzvpdd08E7KhjxJu90MNRAOdLwjmZpuMmjCvI6v7Ao
         Ygjfa1A1G1bBqu0wWOTFffn5hwQpFNco8sVeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638025; x=1733242825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=Jn9GEiK4Jv/2jRRK5o5VqeH/B4xUACfA64o5A/TEcLMoCQq0RPxbXNSZ/Y8F/Xy02F
         /og9CnEeylrKm7yDUkpsJpW8jusbqIzLTOfJpdEZE/0yYfbTtCTFyE/EZq+tguYz4V/e
         ZHUN0mL02Eh/YwV4TYPqV19Hkg5rZdPiuV9a4lgYvm4YDWCaNBY1MSEK4a0le1lP4S5w
         m4YBqfkR0MfMP6tmfdKud0cY7mwlcfSYRK2Z+nSoLbKjZldPJ0wE2SQHcQxkyDJgTP7C
         wVS1sXOnxD9CKO+Ef5mBQ0oo6pjj0FnhTxqPdysI+GlBA5JLbv65BAwwSv28cZgb16ny
         V3xg==
X-Forwarded-Encrypted: i=1; AJvYcCV9UH5rlcXmVPDW74yVDlzAO2kIqoqAIUpRWabpMxjVOx2EliymMI+o6jmRZ38sFLRRn9NePrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZUDbz85ZIV7gP7nYmF6SPjz5ljqB4hsO7KpqlWtEYs/CDeSg
	8atZ3MM797MD04KX3Ju5rpxvQwAz4ifez5PYiiv28ATpRH3/GovYkBFVLNJcpQ==
X-Gm-Gg: ASbGncvx8EzEuQEc6Z1PMTvipzu2zFodZvhvA8pk1m6O9of7YKomHvgMaFxXIm2W2EN
	IlhJwhPV+a8xW0lBa/3iy0HBLF4SHmYcVtU9o8XKYlVEFEq/2mGY8AVuuec/NL1Fn7/uDhStX8u
	fXleIPjHhzGAHxT1dLczujPzwrsijggAXkt/dHEE0Lk/9DJAZUkVdGI3R6Pd2eA5gQTnvJTyKFS
	oSrg5E8Hdh8C1ss27skGp8I1MAlXV9/BLqxoFvbbqbmuUrAiY8tGHFfOo5SBXqsCLUrMDIBg1BR
	5nckbXWUo1pDB4khATqnP90U
X-Google-Smtp-Source: AGHT+IFdNgRDGrF5CTdu4yR9Csg3r8Ps+A7V5ZKG5GFvlDcY4AMEGEJVb3A2Xw6tVAlAoAPaVnBh7Q==
X-Received: by 2002:a05:6358:52c8:b0:1ca:9839:5d09 with SMTP id e5c5f4694b2df-1ca98395ef6mr446689555d.8.1732638024799;
        Tue, 26 Nov 2024 08:20:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:51 +0000
Subject: [PATCH 1/9] media: uvcvideo: Do not set an async control owned by
 other fh
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-1-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

If a file handle is waiting for a response from an async control, avoid
that other file handle operate with it.

Without this patch, the first file handle will never get the event
associated to that operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..5d3a28edf7f0 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		return -EACCES;
 
+	/* Other file handle is waiting a response from this async control. */
+	if (ctrl->handle && ctrl->handle != handle)
+		return -EBUSY;
+
 	/* Clamp out of range values. */
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_INTEGER:

-- 
2.47.0.338.g60cca15819-goog


