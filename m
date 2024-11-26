Return-Path: <stable+bounces-95549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10AE9D9B40
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB6284F68
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835581DA309;
	Tue, 26 Nov 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1pC5ZRk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA91D90A7
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638030; cv=none; b=YhGLYezfw3N8V39237S4VFZ8vZ9E/KZFbTbx+t5ZFmeu4d7YNA3R0PKElIWrlETPx6gXPoECtL6yjAAoDuaIk2D2j28q08DluSwhU7K+7E0QX3R5L/Wy3eUFI/4vvbmYwqnSGNqcUp2Scz/1GF473aPKZSFUxZs+Cx9IAam71tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638030; c=relaxed/simple;
	bh=bePKgiLEtOHWWqdfEmU/XMv+SebhE/yNQeG1T0V3x24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+g9HQr/+hDutSLY27X6KxyC/kSfo3vurgoDlamWjeEUEgClc+ropKa1ApmRW4CO1eyrP636cgtfcqmwjfQXUyJJxH6qYc1JotrHXvRExa6a9ZaYhBniMFp73NMaAmHc7W5U4QUvMf/+Z6HUvyUCiLowDHFZCXOFz+2b6HVd1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n1pC5ZRk; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f1cec20a77so1142976eaf.1
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638027; x=1733242827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWYCqdEsM1ywI2Gtcd8gKpH4aZIyvZJP5EwMGSKse/E=;
        b=n1pC5ZRkKg5+lJn6bXhLCgHK5vlrNXDky9eTBqNcXFgaLWiGc1qt/AJNdhX532ie8B
         J829HiOfuWSQwRcoI0sWJdPHYh4Cv3784OpX7uPAWuFguf4tGNvYrnz3Fb6AhtjefNlo
         iZCRXARmquTkCxhHk4Ff8nClZCF7S6MRVRf9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638027; x=1733242827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWYCqdEsM1ywI2Gtcd8gKpH4aZIyvZJP5EwMGSKse/E=;
        b=e+08Fy7MbvpM8zLsBRQFU1iGhQk/35WBhFCZDdRhxW622bzSw2+cspsLpiYtfJQbry
         KbWk3eRBlqyJpjL+pIcJ8daDwa+HAt4mTA5H0h9LlqCj3VooyJTuIXoRK8C78hfQhY7P
         OamuDA/ylB+3ObvdIYyO7Cmap/kAaV1dNlt01fOdBxfoccmZkJYV163G05IDP9flDgAK
         J7cgiaMvvC73RwK25BltQuVmldr8nDnk95avHB+6QWAhzT02PWoXV/5qU2QV0cydYn+Y
         t2Uy8hAZ/8nkaxi7U3IlGL5n6ERfCFI87DzCD8rTOq8E0BlDI+nUohRelgsjVxo0kAQn
         b/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUDYD3A7P+qqAjYLp8CdqeprIDBQvXpdbtP4ZiDvtnjiaB+nHzU0M4BazatWLOpLX3mJc35UAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbQAnLyjGCqU8snZttJ6ge2jZVbFM7XIMI5uvVsNA1FMaY8/W
	CzT1ftk2GlrQSt3fdKS1go0FneVwSPSwQ1ed6A9kvFFVv9aubbJ1jCGNUgafNQ==
X-Gm-Gg: ASbGnctJdF82eycGf0wRy6vFzk0+h/FSHO2S+fiJn9puhJAOMItC70ZF3IIDXxo4GTn
	xrnAfqScK24BZnc4oX1gOEINBNmQWGWtx+JsICeOAX+0+O5tXA1311Jdg+8aw+tQ/m9uJoWP0Rr
	+hASgWTNLtrskNHLc0TpYjOPPsHDCdWzBPkt3PU0JVubBVkAsLopbRXsDjdGvamH+RlIRz1K/1o
	+oRHpTD0dJz8gD/aUBvYQBXzEmLku4luWnawK/3c4UOF5sggUdawWM+Gdbe1KC5Dplp+P6jcBiV
	FBEcYwsSiR9aFEaLopxCC0pE
X-Google-Smtp-Source: AGHT+IFP7tn9XGl7nTv1mz1ZVEhZf7iMYG/c3Vw4razkI9b6q1iBbwoYYcil2Tl02KVex3tVQ1+aRw==
X-Received: by 2002:a05:6358:949f:b0:1c6:1d18:7c44 with SMTP id e5c5f4694b2df-1ca79708784mr853391955d.6.1732638026153;
        Tue, 26 Nov 2024 08:20:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:52 +0000
Subject: [PATCH 2/9] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-2-6312bf26549c@chromium.org>
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

When an async control is written, we copy a pointer to the file handle
that started the operation. That pointer will be used when the device is
done. Which could be anytime in the future.

If the user closes that file descriptor, its structure will be freed,
and there will be one dangling pointer per pending async control, that
the driver will try to use.

Keep a counter of all the pending async controls and clean all the
dangling pointers during release().

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  3 +++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5d3a28edf7f0..11287e81d91c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle) {
+		ctrl->handle = NULL;
+		WARN_ON(!handle->pending_async_ctrls)
+		if (handle->pending_async_ctrls)
+			handle->pending_async_ctrls--;
+	}
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -2050,8 +2055,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
@@ -2774,6 +2782,34 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
+		int i;
+
+		for (i = 0; i < entity->ncontrols; ++i) {
+			struct uvc_control *ctrl = &entity->controls[i];
+
+			if (!ctrl->handle || ctrl->handle != handle)
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
index 07f9921d83f2..2f8a9c48e32a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -612,6 +612,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls; /* Protected by ctrl_mutex. */
 };
 
 struct uvc_driver {
@@ -797,6 +798,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
2.47.0.338.g60cca15819-goog


