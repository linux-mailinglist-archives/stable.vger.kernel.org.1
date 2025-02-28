Return-Path: <stable+bounces-119914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665AA493C0
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1D1892C47
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930C250C16;
	Fri, 28 Feb 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZuKF6Hh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1B8F6B
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732015; cv=none; b=duhhZC/HHDrH5+KoTDLt77ax5JJPyzEX3B4UKXedMOnpjc1Esmd6D4IBvUE7T/DEFbKDirWKGhfkiu04JSFN2giGSiz4UoqzO69u7rCe183fLU6uLwfOd2tkqChe2uPjRlOfbSEPDYXZ+KpmhL/+4R3t07aMPl4wj4hYpNagZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732015; c=relaxed/simple;
	bh=Uj5P7ywi9WcX5GkCYpOOKjPMjt5OtubwhCXiia9AGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUxiE8wOe3P85Wjke8X7P6GXLYcO17XsUkQpJR3QyxSkcKO48Tz+uaPdVzIh8RVA2hObW8BEku8JfYb26TGYRPOY7PcoZSzLBlb5JNuDrdxiea2SQbDiST9B/baNjCV8q6KvnIev+fpCg4ditDAhWTNd0h+DF85CgG0B8qkUaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XZuKF6Hh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8f28172dso146882285a.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740732013; x=1741336813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LKgqQTazvtki7VSp5f9mXiMp0gLK3VDkGgr+P1NNdU=;
        b=XZuKF6Hh8luhuCs6/cvsrRyLFW9ovtetUxuMGR+Qay1FiWRqsbA5vWCN+Nytm3jRu9
         wDuWCpVY78YczZEon61beM0gLx5ZMQ/fC20J85Q2cE36Uf8i3bNSoHuMvrsP19ek4g4+
         FQnNtjc6ip2OD4heMjYTpU4dn3rYjD9FP6zBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732013; x=1741336813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LKgqQTazvtki7VSp5f9mXiMp0gLK3VDkGgr+P1NNdU=;
        b=i3rTmojnECi3r/Ve97SZuzh/1OMw5H8x3/57Jk2vXCQcZsQWr2QQHwARir3T+kFleC
         WmY9lD0h+hZJCA9Idi84/Ab5E6r2hD2MSW6QbXdngraYmLMfkjv5YNnqo9pGrmU09u8g
         JpuRsBOflIMWNg/RRYPJpOsA+rM/mfg4cZQLakMl82UcznqYYQ6oJt9iAHt829V9IIF/
         c4oK4l9DSrYW5R7vGPOshiwdswelUTuQjWUz6cLEH8vTk9ix4Su0gfugBJnKnEixDOsy
         zRREBQGTfeV4CNvDtz1hGklpKN1LjDdGCcfBEO9b3WIIyhV6JZhZcJ6LHOA4+DZFxg74
         MgpQ==
X-Gm-Message-State: AOJu0Ywqe4/Onmccgbz07Oce5YeDyial/xu8sfuQh2IlkFrce8Oy190F
	/598BBBovYPdnlR4L8v1ZntCfVwF149LsjD+HH7LCNlzh8J3Ox0ZhsSBqRXnZtrsUm5bgjsaUKL
	MVQ==
X-Gm-Gg: ASbGncuz1DO3xDKVWn5nAyqT0A4p3iMxq2lZjY8JFxCYZhd5SYasBkpZpDh2GEsoBq6
	l5uZwFLV1zBSURwGQtUGoRQ3TFDNCDYLHycBFSecPvFByUQy3XbCrCAmCM6d5cTVA3GgkB3uk3t
	MBIFoYMtbrbOqQN38xMae4fBv3Ukl3ssUoKialns9tKvFkuYopg6MNOwCOReXIDf6fy2nfdChES
	pOtas/SLlgHO0XrkFNBsFOtygRhO7MeuC3VGOv6bNK5vpZuP768FtbMf+FMEJOW7Y+qDSEivTdF
	/bn50QJqsmBqkgqVZjTAphVA3CvIgMbk8PxB3UFiN3bHBaxD2A7Mah1G3vYrPVvwDe9ngPm6Tlh
	igaj2KfAA
X-Google-Smtp-Source: AGHT+IGWPfWCbQ5373qIoeyfvmqHR4wdjE9L3rkOwVM04dQss8ggFmWBTj/TusNLjN4iB7IjASUBHg==
X-Received: by 2002:a05:6214:2509:b0:6e6:5bb2:c1a8 with SMTP id 6a1803df08f44-6e8a0d90e9dmr36405816d6.34.1740732012718;
        Fri, 28 Feb 2025 00:40:12 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbefsm19693526d6.85.2025.02.28.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:40:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10.y] media: uvcvideo: Remove dangling pointers
Date: Fri, 28 Feb 2025 08:40:03 +0000
Message-ID: <20250228084003.2730264-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021037-broadcast-cradling-b8a6@gregkh>
References: <2025021037-broadcast-cradling-b8a6@gregkh>
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
index fbd9e0073cf7..2220560df7a6 100644
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
@@ -2371,6 +2406,30 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
index b40a2b904ace..7ad00ba0b99f 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -593,6 +593,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_trace(UVC_TRACE_CALLS, "uvc_v4l2_release\n");
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index c3241cf5f7b4..60a8749c97a9 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -453,7 +453,11 @@ struct uvc_video_chain {
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
@@ -699,6 +703,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -871,6 +876,8 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
 			   unsigned int n_terms, unsigned int threshold);
-- 
2.48.1.711.g2feabab25a-goog


