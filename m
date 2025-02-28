Return-Path: <stable+bounces-119912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25793A493AB
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DB5166F3E
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2712505A2;
	Fri, 28 Feb 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpRefxfz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E922512C1
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731712; cv=none; b=eIUrpHOQDd8w6+qJjP80MWQnQmPzZ6o/gLf+PzOzr+ga4aa5d0xJyRGPvx94ymQQ6hqvjoddwuo3fiH1JD9jbqgt6adVqjd8iHmIEfARAHibOg3xzm171KC/zQN2jrsJHJlDc+xwgsdm9PaxHHBb6Rx6XfVuPX9R/d4XgvvHH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731712; c=relaxed/simple;
	bh=xANVQ0HIxKvcfERtMXL0NJEAGhJg2XhWJkJqYrVM014=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4IJcB9OeXQ9XZz3tL+R0OjFHv6e2Mk6opBDpSmEav0pR0TjZFdf7h6X4ZDR36bo6/1rfdaqsARqflPhljwlnq8Xd+aa8Ejd3yKmVH6iGLLlFciC/qfGr4a7o3RiH8livkLM7XHw0Tkk0lwvq7pq77D/CPvtFO6FXqyL/pX777M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpRefxfz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0c5682c41so149980785a.2
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740731709; x=1741336509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDfduOe8YzOluQ8dYSPPN43Lgc2okH5UC7PyLRg18AY=;
        b=EpRefxfzkbPyobYJ82jGdwOtAYRzkJY7lDUg3ZNX3n9Zxx2UK6xsRc9N6RZblGMD47
         4vZ4OiOsYlBGVAOM1YpKCpSRjJIRzD0KfMroZyqR1TeEjou6Wp+iSB9IGzYNZGXV13lF
         wmXGA/jmBLDQlTC9Gr0iaQi2x20gAgehNFCEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731709; x=1741336509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDfduOe8YzOluQ8dYSPPN43Lgc2okH5UC7PyLRg18AY=;
        b=DXIXKdBDwTZxhYk1QZNGF/1wONDvpys+0FxTVV6bD9czyB1zTlWCSdwXR+BPUB5ino
         WL31iI5bYzW07zGD6lwGxEIcErn/0BskCnUhmtCtwf3x7mIh4Q0pGI22zOjL3l7FE0gg
         cpKN5kMV+K1DKX2rqR4Raf6kPXR5G+KEYpQggH4BMFgdi/6DlD0uVWcFyXmqoSHOkHgv
         qjL/4/I3+GbO3+dNf8pAQXyMkHgCRa4CoCXilB3m/ttxB/HVnGx13VY3cHSj6d8dlXhv
         eM+ACwZWLI10WsEqlbtGhefgiRZkOkntEKF3znieGrK8o66YAvJuFaOH0m+iwPRNQY8A
         3ptg==
X-Gm-Message-State: AOJu0YwShkoEQpvFViFKCk9ZVHgAa1Hv3dx15tmmTJB33KMmlQ9ZSozk
	HGq2uctcV3Alblh5Q2TPOFXBTGSIOcvVt0DRmMUp74L8P1QTVACaLT6yWEuS868barxOVca/WpY
	TSw==
X-Gm-Gg: ASbGncuda1OHED0Zi9I3ThTMSqsAYvRBtJ/8BRXb41NzPK1jHoxANHw29U+Wsfj91Ds
	c0m7+Zs8gLj6zJlzX7IK6EOn7cPxPThOYGSwOPuo9Ugzc7GmH1J2/BD8rpLtBu2Gv8jxNzDnkHh
	B7dFMSrFRhP9tqt+kXq3ZxbUb7FkHQ8KX4roiLT2iy4dH1tXQlYvlZIgEP6CEARVRoRnDz5DD4J
	4lBVthl+g36OttoHG0eoNcdYsrFOyotZ/wJydM4pdPv2cXvATp6myRiDs0WksJ17jzRvGBbZEpv
	tZGJfE2y9MNheI9oAatMK9TYLs59fV3icUpDxcrpCEgPgEL+wLnd//DOntCnc+hm+M7UOZ4BJ/H
	hc8XtMrL9
X-Google-Smtp-Source: AGHT+IFEC3tCLltiwGoyJnyZGCmCp9qYRdDjH0YlOpB9x3vcErxEaNh/Bmn4iuXDPnKxTGXUBzPZdg==
X-Received: by 2002:a05:620a:17aa:b0:7c0:c2a9:94e5 with SMTP id af79cd13be357-7c39c49d9bcmr399957485a.1.1740731709217;
        Fri, 28 Feb 2025 00:35:09 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36ff0f312sm220325785a.55.2025.02.28.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:35:08 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 08:35:04 +0000
Message-ID: <20250228083505.2713073-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021037-enactment-bartender-d80d@gregkh>
References: <2025021037-enactment-bartender-d80d@gregkh>
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
index 9fc84f0ac047..58465a9849b8 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1306,6 +1306,40 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
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
@@ -1316,7 +1350,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_set_handle(handle, ctrl, NULL);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1577,7 +1612,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;
@@ -2378,6 +2413,30 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
+	mutex_lock(&handle->chain->ctrl_mutex);
+}
+
 /*
  * Cleanup device controls.
  */
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 96ef64b6a232..32dfb8617074 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -589,6 +589,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_trace(UVC_TRACE_CALLS, "uvc_v4l2_release\n");
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 97817b350f98..6993cb33b357 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -447,7 +447,11 @@ struct uvc_video_chain {
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
@@ -693,6 +697,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -865,6 +870,8 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
 			   unsigned int n_terms, unsigned int threshold);
-- 
2.48.1.711.g2feabab25a-goog


