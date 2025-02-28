Return-Path: <stable+bounces-119917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFEA493E4
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2444B18948C1
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4E2505CA;
	Fri, 28 Feb 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNtYs5Vk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169C276D3B
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732429; cv=none; b=ZZz+mVeNpaYtcci3jl6xPhOofzMaWbx3OZ3iZFeMRhdeYMHoq/Z2Pmgh9GLocI4lTUszSqsA65yZagesgsWs9DhSyn6kPf9uITsKoqUDq3+FNc64NC+Oql0O0u2DKFvWbkvpBTjA/hAzkKauGJJPQldKzrNBfHeu6gWckn9f884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732429; c=relaxed/simple;
	bh=dOzV03jTg9szaB/b+9CICAYPBTA8TNg//ViI5A0YU9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD2GlCWhRXLWsWCX0wd89jpekLyhLr5mBhIEq8g4IGdCuapjgkBJGFlkNUIAPW3oAO0iL52bknQqB3jABO900/QGiDlkb7RsfO5MWwZ69O8vbIDXIi/KTxvZHFLxkutawJ6UmUkUdMtb81hmpHLOZ+nKqQ+g4Gp4BfunSftn/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lNtYs5Vk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4721f53e6ecso18898711cf.1
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740732425; x=1741337225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5BmX2o+z2Vqlg7EUbRT9/1VFodmumg7eQ23GqBAoxY=;
        b=lNtYs5VkR1qETzPrT/c4puoreC3PztIZn7snbhI6VXiUZIJzENQtkHAiOmFRcEbZBz
         DjoeHtA2EdkeBvZUP1P/EjXQrtU67YZPSd3QUl05PfVxv9h1d4d+jASBwmiGvJjXV7EU
         8txWpp64LLolbyM2sdZKaFOVDxkAVaQiPBIqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732425; x=1741337225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5BmX2o+z2Vqlg7EUbRT9/1VFodmumg7eQ23GqBAoxY=;
        b=Zw7wj73CAgfRFh3Vd9Oza8VE4db24NTqcU8ntX88YEaN4oLE3diQYhE8N1bce3N7Xl
         lgVe/RyviGwpxNp4iaA8Cu6495Nm2EaC/5kvUgPsWbPfrDMeMkttLNHJU2sb8taxq8c9
         slmDYkqMLJsGN+jer8e80zlPejtm3oREmZmmCw01Nf2Czo86ymQyjTxjGZ7H7k7dB7Wk
         i3QpyL+4EKSpgv+piJDXXzKCK5XKi7AOL+mxB6CDsmEohFALHEkOUl6qggX68cEzNErg
         YrKj2flIu8G4bvKHVjJoJnW3j8Tmff16dV+qy1t7qvB5HnX15z09icKE6lkYf/jY+NoF
         JhTw==
X-Gm-Message-State: AOJu0YwgZ1VcR58QpAoSs+RTxLObz/ZMPf4OFYQHdUTxlPyFBPYDO7bo
	oIjLprhkog2i8toy/459V0o+MUWL/quI93+Ma7TaScPJitc+MCOUbfBhSurVAk3cR5ViauoSjbL
	rzQ==
X-Gm-Gg: ASbGnctD01i5KkCWlA8BAIbq63vpF4kKntzKlFqGgkZoarkF5Vf2i8GaOlm4/M/k+PG
	UPv9PLefmgRjM3R9DJE44tt7WDdOYVdox0XAWl1pBxjTFgOTKm6RsoDmf8ISvtmSfvjI4YwDrc7
	LUl3iiFDiu4Xv6B3ZXrDSKo0+sZKHzRosFMHqg5vW7BgZGEattOGA2IY9LVDLVoFwxec2ypmz+k
	Y0hKrh3l0ZmpRCVrsgRUQUvzlNbFet0HjrmIGOMYuM6U3966DSci2hxYZ/b3Ai/+vgHpL6J+9cM
	0bNlmWcdwvF2kmU9aZBLCdHwPvU5pKh4A+oH9uEORwjZ6moEob2PbA3V/XTJmGd4XyyZ1ZXWfbU
	FrLKn2xym
X-Google-Smtp-Source: AGHT+IGn7O+2+pTlX0yLM4Nqtdi/7ZIRoCjy7d3lSD12ntAvtLer0lJO0C09nCrDlYJfJgnkoyLFpg==
X-Received: by 2002:a05:622a:1349:b0:472:108e:2a18 with SMTP id d75a77b69052e-474bc0f4beemr35670901cf.38.1740732425063;
        Fri, 28 Feb 2025 00:47:05 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4747243102bsm21912531cf.76.2025.02.28.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:47:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.1.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 08:46:59 +0000
Message-ID: <20250228084659.2752002-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021036-footwork-entryway-f39c@gregkh>
References: <2025021036-footwork-entryway-f39c@gregkh>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 59 ++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 96b747bf0494..f133c203cb88 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1470,6 +1470,40 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
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
@@ -1480,7 +1514,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_set_handle(handle, ctrl, NULL);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1754,7 +1789,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;
@@ -2664,6 +2699,26 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
+			if (entity->controls[i].handle != handle)
+				continue;
+			uvc_ctrl_set_handle(handle, &entity->controls[i], NULL);
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
index 950b42d78a10..bd4677a6e653 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -607,6 +607,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 33e7475d4e64..56ebab339fd6 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -330,7 +330,11 @@ struct uvc_video_chain {
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
@@ -584,6 +588,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -768,6 +773,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);
-- 
2.48.1.711.g2feabab25a-goog


