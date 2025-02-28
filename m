Return-Path: <stable+bounces-119915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8ECA493D3
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B942160F81
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BF2512E3;
	Fri, 28 Feb 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MlgHRFW7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526C2528EA
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732275; cv=none; b=sB8SXbCo2N1zITRpyZPST3o8Me/lBfKWiUngIwq0iTuwoiRtYPkfVszLuSF803Y74/nfFtp6HUH8ene4Ka1T3oICcfpMkXutncrSaLMn3P/R/OzVUaBluLNplaRj3iOBC8GeIsJwcekSPdWJpAyijUBReyIxFypyto7Co0ZjR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732275; c=relaxed/simple;
	bh=F85Iz9UOSz07MVh93OS+UwM9EjkQjj4WIyyXezjn3QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paW3yaACfD+hNfHON5G7LxfhRrTEOhYOI4azYrszeFaCZcNFuLMyHTAmd7FFoh7nn8h3aOOHmooYlRNi9L2P9FSYjKYhq7IrLa0PRumnsBhG3uqrmzzhfNv3pVQrYbXxcEuisHc5CpqVXNLZKsQ5HUIJIorUPaON3ySjkYEUw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MlgHRFW7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso28744536d6.2
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740732270; x=1741337070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzmtCATS/3HLGsynHaQHZJHDeDhJ55VRWZKKAUFeYGk=;
        b=MlgHRFW70EMaCE2/183wTvkiWMnu1U5MhatSpw5eyX2Wfkr0KxYQmExvNwZfO/XnFk
         bS2sLpK/uk1VS86g8SFYy+8cCvYvdWWRSw7uAeHVHVmbQoi8jqB0en35BDTUuskY8xpa
         ds+STAfmrHLP0cBsjTl6ZoQpjg2nimAcwmWF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732270; x=1741337070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzmtCATS/3HLGsynHaQHZJHDeDhJ55VRWZKKAUFeYGk=;
        b=wpNTnzpxK99KmWh+zo6DvMy5646mzodX/3vAL0p/7qpIXE7dxaQbP4dKR1HeHc2kiB
         zDJ1YvCXZLfTbr/YHvqWggPSL1Ix0ZDCQ78jWvX5HZBOmjNoGRjA5ht0yw2NkVa3HTRK
         mumiuQRlb1Zpd3wI6J4PAGh+7HthV75y8X0xnlZoHOXzsTkklp4vgqUHcuIsBUEYtJJs
         3mmYwj7pMzn7pG7AMvLlvs4tpGica1PV9IU6H8raLKo3cGqEwBWZLA9fzjKPo1WVzk5S
         vxaTiq3TuWhLjWOukkZIJo6XVS7ax+9ZF3zoLoTM1j8eCjsvxUpyrduaj32jAebHD8V6
         WslQ==
X-Gm-Message-State: AOJu0YyYs7U1FnZZhRchx/8MQ06ZUkbk36aXjj3FhM4pj8kX8QdPzHzt
	a8rWUx9yCmyJc4LZkJBeFVwkLY/6K04yuOILKqJ6Rw3WyJAXsUTK31Xaroctw0P8e8dpz7tYylA
	PLQ==
X-Gm-Gg: ASbGncvje4kJ9w+RSFsYGpZoanIG0GJup97gzHpySzZKdwYxXYUasQ7bk3FtXnpSx/d
	XMIdm3iZZgD04RvI1UmtHL5PJPhAq3pmP6kT/+xV5bWC0h6lKyJfYpVaikZuH60ALJO5INPpPBT
	C3/ioRK6SSE3ZTN9lGLxFnoBCUIyl7fZt2gkLG5SXwUUtuS9xs5hINqrIsqpUcb3/7Kjk33pQHa
	e2SvPRCLHG4QpYEGZN4cXeD/lKrGv67P21im29egxqg7+CNrdl8P4CpbYUB6A+4LZDsNLbzZqQ6
	aS1UrJE5rLO4ChRkIS3bLTRgSX7iLcsnSepr2FjhuC35APztEjOqvSR+b2xz6bhjN5uqgmRs2Yo
	y1nsv9nhz
X-Google-Smtp-Source: AGHT+IEpOQej622Qs689k+zp2iDdb9PMZMXPzPVbdWL5p8xOlMum1nrm1tac7lXaIqg/6AXviRsHjg==
X-Received: by 2002:a05:6214:1c49:b0:6e6:5ec3:8688 with SMTP id 6a1803df08f44-6e8a0d8b1cbmr45392996d6.45.1740732269671;
        Fri, 28 Feb 2025 00:44:29 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbb9sm19716496d6.92.2025.02.28.00.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:44:28 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 08:44:24 +0000
Message-ID: <20250228084424.2738674-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021036-shrouded-exposable-96da@gregkh>
References: <2025021036-shrouded-exposable-96da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-3-26c867231118@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit 221cd51efe4565501a3dbf04cc011b537dcce7fb)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 63 +++++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvc_v4l2.c |  2 +
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9b8e7e31cf59..fd26bb516b97 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1417,6 +1417,40 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
 	uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
 }
 
+static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
+				struct uvc_fh *new_handle)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (new_handle) {
+		if (ctrl->handle)
+			dev_warn_ratelimited(&handle->stream->dev->udev->dev,
+					     "UVC non compliance: Setting an async control with a pending operation.");
+
+		if (new_handle == ctrl->handle)
+			return;
+
+		if (ctrl->handle) {
+			WARN_ON(!ctrl->handle->pending_async_ctrls);
+			if (ctrl->handle->pending_async_ctrls)
+				ctrl->handle->pending_async_ctrls--;
+		}
+
+		ctrl->handle = new_handle;
+		handle->pending_async_ctrls++;
+		return;
+	}
+
+	/* Cannot clear the handle for a control not owned by us.*/
+	if (WARN_ON(ctrl->handle != handle))
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
@@ -1427,7 +1461,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_set_handle(handle, ctrl, NULL);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1696,7 +1731,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;
@@ -2524,6 +2559,30 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 	return 0;
 }
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
+{
+	struct uvc_entity *entity;
+
+	mutex_lock(&handle->chain->ctrl_mutex);
+
+	if (!handle->pending_async_ctrls) {
+		mutex_unlock(&handle->chain->ctrl_mutex);
+		return;
+	}
+
+	list_for_each_entry(entity, &handle->chain->dev->entities, list) {
+		unsigned int i;
+		for (i = 0; i < entity->ncontrols; ++i) {
+			if (entity->controls[i].handle != handle)
+				continue;
+			uvc_ctrl_set_handle(handle, &entity->controls[i], NULL);
+		}
+	}
+
+	WARN_ON(handle->pending_async_ctrls);
+	mutex_unlock(&handle->chain->ctrl_mutex);
+}
+
 /*
  * Cleanup device controls.
  */
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index ab535e550158..ee315db5902b 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -602,6 +602,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 1aa2cc98502d..9d3224213e4e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -471,7 +471,11 @@ struct uvc_video_chain {
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
@@ -723,6 +727,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -908,6 +913,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
 			   unsigned int n_terms, unsigned int threshold);
-- 
2.48.1.711.g2feabab25a-goog


