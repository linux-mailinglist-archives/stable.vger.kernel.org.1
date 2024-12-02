Return-Path: <stable+bounces-96043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCF9E0961
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB81AB33784
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1A205AC2;
	Mon,  2 Dec 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQt+Cel/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C17204F8C
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149487; cv=none; b=baw7atdRX6r2S2ejwz6XZgPZuK6W9NL9lfMXUT9tTnpp602qYqpsTWxkQ2rqwmdQFalV/LXVKT1Nnby7avzNyPgMfpNojZ76JUIvj1sE+d6bT5bHkijc5mtYBSownI53EGd7B77Wtpsu41zR0pfNAqfzuL9z23VpqrZQstPptMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149487; c=relaxed/simple;
	bh=2CouL6TauW+OfYTjBFsOKvayyxDlTHWIFYpffgKYGh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dteN7Rt8RK1j8GpDTLq+PWgQ/YM0qStt4DbhJvR7EZLpNbc9GDvMUP6eMUDEV+hTa0YHnH+GsadtGl2+O0dhwW0nGlsvOZiE+yFxpk86/HLk4Sq7lAxb3vh+n49g40BoqxGmZhh3XoX13t0WJkXEcS6qIFInt8ts8jKGUOlW3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QQt+Cel/; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f22ea6d645so1167774eaf.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149483; x=1733754283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLNHXjJlr/6qPBJLlmj7xWzEmuF7V3Sn4z0szK5h1CI=;
        b=QQt+Cel/9pcHXIo351Fm6cSzKXJJH94/WB2pyW+SWXCWffVvlENBc0OnhJU1p7dje8
         4xfu8pOaZKteALYVyIaBWsg9a4/DzzLrcf7sUI8p+cpjOuo/WLgurrnTWtb4yIdZ0V31
         2ok4xPPtxO9w/VfDXN0WFKwNyd0XL12YBtJjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149483; x=1733754283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLNHXjJlr/6qPBJLlmj7xWzEmuF7V3Sn4z0szK5h1CI=;
        b=lXwdDX/2glm1dMj92ibEvNqRMrUkarZUeUZfdRLQoiaYrdDGOz4lM5bOXj584IBFVv
         ybELdWTwhWHKmDvPSwJ6zhREMr+znt7wqBHF1G0K/HcRwiwBjc5/EU9we/6Zwc+Lvxi4
         WQxJQ7NJ2XPJLzy3kcazxF4INquuPmdefpzVv/LjJDjNNenykf0W7BYkQ9BVHKq9/13J
         6kDiLd52c5YGj5xVoiTnaDuFsUwle/mn5Lg9mSzOFjgwnQLNhri6/5pNcuj2qViWLhd2
         GWaMTMg5GPw3KMf0WZwuue4m/anMEOyv7dsGwQbnC4AevXTmS8gcsFzkOwb3RBLBYm7U
         7qew==
X-Forwarded-Encrypted: i=1; AJvYcCUmsX1z6ThVF7SxpfHlQrmPZq6B0EjIsSIqrQXdLWNNJk82aU4jJt1/o585qEYtwU6Xf3yuGuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5ShCGKheA7drAYXmXkadi45pBL/uoU7lY26PPwG0cCQFwO7i
	XU+hObk5PIAK77gUCSM+W1i7Kj30pR49WoSetfG5yW3U6z2sDNvqz/Io3sqqSQ==
X-Gm-Gg: ASbGnctzLgs6KZjbZGKY7N1Vuoegu7k8RoQXpL2OZqiLick77cMCxtuNU8xu1CYlplN
	cbnUsFNy0q7RCFzqF3/s2YFPM5XDbV10vfXYt8Z7EJmp8ZkePsHMjncjOrGmHrW1Igd3YyNBPPn
	k0rR/UBJrH9QHN77eqBeIpjA61/ZhVnQscg8CGXeRtBngOiXoYk+SFKHlq1nVS0LKN/FjuXFRjN
	o75uMcGMtOOnT6EQdCbTbGcKI+q3/5RtqQuRTu20E2S0uTu/VqZP/TLoCGSFfSSIwn6NepLOPoK
	lpnKAA5j9cR/ydgE3vY+bAnP
X-Google-Smtp-Source: AGHT+IHOmHK950Sz16eLfZ56imS30OV+bUBssh4g96SgnL/6rRx0a78AipUgKMzMa352e4qpARm5UA==
X-Received: by 2002:a05:6358:50ca:b0:1b8:3283:ec6e with SMTP id e5c5f4694b2df-1cab169cf8emr614679055d.24.1733149483059;
        Mon, 02 Dec 2024 06:24:43 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:41 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 14:24:36 +0000
Subject: [PATCH v5 2/5] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-uvc-fix-async-v5-2-6658c1fe312b@chromium.org>
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
In-Reply-To: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
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
operation), a counter has been introduced with some logic to make sure
that it is properly handled.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9a80a7d8e73a..af1e38f5c6e9 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1579,6 +1579,37 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
 	uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
 }
 
+static void uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (ctrl->handle)
+		dev_warn_ratelimited(&handle->stream->dev->udev->dev,
+				     "UVC non compliance: Setting an async control with a pending operation.");
+
+	if (handle == ctrl->handle)
+		return;
+
+	if (ctrl->handle)
+		ctrl->handle->pending_async_ctrls--;
+
+	ctrl->handle = handle;
+	handle->pending_async_ctrls++;
+}
+
+static void uvc_ctrl_put_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (ctrl->handle != handle) /* Nothing to do here.*/
+		return;
+
+	ctrl->handle = NULL;
+	if (WARN_ON(!handle->pending_async_ctrls))
+		return;
+	handle->pending_async_ctrls--;
+}
+
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 			   struct uvc_control *ctrl, const u8 *data)
 {
@@ -1589,7 +1620,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_put_handle(handle, ctrl);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1865,7 +1897,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_get_handle(handle, ctrl);
 	}
 
 	return 0;
@@ -2774,6 +2806,22 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
+	list_for_each_entry(entity, &handle->chain->dev->entities, list)
+		for (unsigned int i = 0; i < entity->ncontrols; ++i)
+			uvc_ctrl_put_handle(handle, &entity->controls[i]);
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
index 07f9921d83f2..92ecdd188587 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -337,7 +337,11 @@ struct uvc_video_chain {
 	struct uvc_entity *processing;		/* Processing unit */
 	struct uvc_entity *selector;		/* Selector unit */
 
-	struct mutex ctrl_mutex;		/* Protects ctrl.info */
+	struct mutex ctrl_mutex;		/*
+						 * Protects ctrl.info,
+						 * ctrl.handle and
+						 * uvc_fh.pending_async_ctrls
+						 */
 
 	struct v4l2_prio_state prio;		/* V4L2 priority state */
 	u32 caps;				/* V4L2 chain-wide caps */
@@ -612,6 +616,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -797,6 +802,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
2.47.0.338.g60cca15819-goog


