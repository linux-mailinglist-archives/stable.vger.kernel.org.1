Return-Path: <stable+bounces-95621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881CF9DA788
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EA7162991
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47E1FBEAF;
	Wed, 27 Nov 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+UqrPhQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C21FBCA6
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709701; cv=none; b=DaFYJhUNhQu+GLIAwGjeY54iLggezU0kiLVEA4pMfT7+wKqRo0icpW2SX5Ty85Qov/VK/UZ4ItDQ/V6BzL1hTq9C7yUINa008gyHJy8t33fQckr7O9cyI0rQwoqsHcBKJW4X5xEMaQpE2I2pJE4SDT4imiT05pi0S1sdpGnFOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709701; c=relaxed/simple;
	bh=WhdTkzcqR6Bf+l9KubUuR4/DJ8IIJcn0RVpx0dWpsR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjbIjVuv5XMoJ8uAO0Sg41wkap7poELcaa5UFcNSfLq/GL6n5b+J703e3jiqAejUKxoq12PHxjb2AGpJGSJB74y29j1E+E9IjHyv6J8y8fQxawAWbGPby1VZSnK6utWFTEDRqei+8Icv0vNpvB7Jcnt0pHErhK4WnS03FXvV7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y+UqrPhQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b65d1c707aso280605585a.0
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709697; x=1733314497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0KHNn4es9DIQwBkLUHR0O3A+08DvzwFXH+1YhEGXA0=;
        b=Y+UqrPhQAPtBgpBCqlACR9fj87wmQeEX5Yd2Vuj6MGOrRL8wYIcQU6cKY56Kn4oIaF
         6Af93lMpqLk2qt2+C64L907THMur6bxxzVe9SBUvPn7Tcf0cykoOPpzjdbafFNYEIM2f
         ILPzsnQg1YsCoAMWW+WCGq3y8nyOCga2BlPao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709697; x=1733314497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0KHNn4es9DIQwBkLUHR0O3A+08DvzwFXH+1YhEGXA0=;
        b=H8ky+NEr1R4pINDfFBiS9gcVKLRZlJHRbvW3FPnIoGOEKUhta2wDE1hYZBa1jcEtm6
         gb8U+JBMd5IfIN7bgoVap4WORrkpH7mxH0Zqsmc82jg31cagCybz2WNqIRNbgJiMqKtm
         wf70OXLCWpl+Zxq/Kg5SVyqcfetfpJ3RV/JWoMmnEHpvg+jBmD3o97mqkZUU7+31pTnf
         TKjEEcRX50/PslQbanYdncfA1++lKImHCqL1LsjsHC9Q1Pji2JG6Ukv0W4vaCLsC0Tv2
         SlbgiolQvDTGr9o/CEhCk10oWv1OyhOtmfltXKWufv0LuNIPaCqlfO9LAWvWyBL0d2hx
         R7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWlyLyq+86tZ5beh6QpzcGY8ndKYamxFIrSv6JPf4jHuhpbplcq09l8/RH2ygcYfDo5n8Krx/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XcZ+qIW0oTUmkFxzsK1nviiND6Vn9tUNFmPuAilp8j3dJrvR
	T2at6jrmlP/R+fgueGBJDSW5E4e0gwq+07vOR/C1+nYLwWz2fqzsYU9OV64dY/S8MpfO5w8l2b8
	=
X-Gm-Gg: ASbGncuOBVac8ytK//ySWpvvS9KWtL2f1dB8Dsz70P7qrbcdnZmvuh1zUXioGmAEv/B
	UXkzdCuiPZQISnUsueytjt7AH7xu5TQFtf3K3HiuqnO5CpvjNtK3V/1JargbzxL8QYJAUIhoLj8
	58eoWqYwrYNu90KDw27oQ/HyHq6OPwwg3xyhQxkK3e3TLCQ4/VIR6cBDqCzS7nt7SG3i7GNYu8+
	PDnuy4bAo2LMrx1Ltw3MM2ebwVIBPPJnaOh/wr6SJj2z5EkE5y4fE26KQbsnks9TRAun2jOxn9n
	PX8cPis7M0wAdPIhhku3C+CO
X-Google-Smtp-Source: AGHT+IEdu8deXp9Whw6D3ODj6kf5vf4xXQ1BzDm2O19GNjsuQS6uwUGVVt/ypGSUyCnQ8eyQm4KPdA==
X-Received: by 2002:a05:620a:4095:b0:7b1:4b2e:3c0 with SMTP id af79cd13be357-7b67c263e59mr439636385a.14.1732709697396;
        Wed, 27 Nov 2024 04:14:57 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:14:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 12:14:49 +0000
Subject: [PATCH v2 1/4] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v2-1-510aab9570dd@chromium.org>
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

When an async control is written, we copy a pointer to the file handle
that started the operation. That pointer will be used when the device is
done. Which could be anytime in the future.

If the user closes that file descriptor, its structure will be freed,
and there will be one dangling pointer per pending async control, that
the driver will try to use.

Clean all the dangling pointers during release().

To avoid adding a performance penalty in the most common case (no async
operation). A counter has been introduced with some logic to make sure
that it is properly handled.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 38 ++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  8 +++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..b6af4ff92cbd 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle) {
+		ctrl->handle = NULL;
+		WARN_ON(!handle->pending_async_ctrls);
+		if (handle->pending_async_ctrls)
+			handle->pending_async_ctrls--;
+	}
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -2046,8 +2051,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
+		if (!ctrl->handle)
+			handle->pending_async_ctrls++;
 		ctrl->handle = handle;
+	}
 
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
@@ -2770,6 +2778,32 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 	return 0;
 }
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
+{
+	struct uvc_entity *entity;
+
+	guard(mutex)(&handle->chain->ctrl_mutex);
+
+	if (!handle->pending_async_ctrls)
+		return;
+
+	list_for_each_entry(entity, &handle->chain->dev->entities, list) {
+		for (unsigned int i = 0; i < entity->ncontrols; ++i) {
+			struct uvc_control *ctrl = &entity->controls[i];
+
+			if (ctrl->handle != handle)
+				continue;
+
+			ctrl->handle = NULL;
+			if (WARN_ON(!handle->pending_async_ctrls))
+				continue;
+			handle->pending_async_ctrls--;
+		}
+	}
+
+	WARN_ON(handle->pending_async_ctrls);
+}
+
 /*
  * Cleanup device controls.
  */
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 97c5407f6603..b425306a3b8c 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..c68659b70221 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -337,7 +337,10 @@ struct uvc_video_chain {
 	struct uvc_entity *processing;		/* Processing unit */
 	struct uvc_entity *selector;		/* Selector unit */
 
-	struct mutex ctrl_mutex;		/* Protects ctrl.info */
+	struct mutex ctrl_mutex;		/*
+						 * Protects ctrl.info and
+						 * uvc_fh.pending_async_ctrls
+						 */
 
 	struct v4l2_prio_state prio;		/* V4L2 priority state */
 	u32 caps;				/* V4L2 chain-wide caps */
@@ -612,6 +615,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -797,6 +801,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
2.47.0.338.g60cca15819-goog


