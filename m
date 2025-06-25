Return-Path: <stable+bounces-158549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CEAE836D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91B86A3880
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DF262FD2;
	Wed, 25 Jun 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnl+Kgek"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F82609F7
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855943; cv=none; b=mDOs56vOxsaC8L55HQUjkLl72y8jQd9a8qOvl5e44qBssqrc5MBRxtNZbB5luFcQkmrLjzvroBPAGmZZLRb8NW7MIL2RKFjt83HXR21+bnr0xfnlzE2RgfepUzCJnaiQnZZBMIaBMl/n3XRL8fF646OKziY5qiSP2sev+cU2KSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855943; c=relaxed/simple;
	bh=r4LPD4AYtG6QR0Zv62rjx9xgHnjK9HuRWUYZp+gROEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSEdeaI7mIA0f7Htz4V7brrqKLkpjk0vZ+UZ3NCzzfO0n6wTlJnusFOFXIyt9K1wdxGsBCNPhP48YQN6NTonrAHpWsIK/l5Mum/JwtIMreEOPwgml3KLn6A+dkLkl1c0c69X4JThiMYqWVyIOQPEP1FIDJtpKBocvwmlDAcS3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cnl+Kgek; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso18028551fa.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855939; x=1751460739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVfdP9hxolQdArVaNVp0y2dKsmGU3Ige1GBBrwhRdn4=;
        b=cnl+KgekTIqvFAI7etfJjY9GdS6Jv1ZDvYEDwgMAd9sqXpyd5wQ2k4JvCbv38ogmUI
         fw3bYds+5JGuSdNuWrpzjtEtHPj+K41ChEe8bJIERNlWxH/3Oi+cANIDnWnK8M2LtFU7
         dtCP0csTFYr/ZpKsVU/uKDUH0PMe5MrX7Bek0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855939; x=1751460739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVfdP9hxolQdArVaNVp0y2dKsmGU3Ige1GBBrwhRdn4=;
        b=xT2rsDZnOq8yX0NLVJUxBBPkzK9ux6NSh9CSsEbM1Nhq+dNGiyHKAYMJM0T5pCKepr
         Cs1oBIFj9jx+TWK3OkD+Z1CkxDgyhB1STHKaO8EGoAO2KLYv9koKrPLlqAJmIZB9E8AM
         7cyuHTiLksGFI8YwNH3Zy93GTjKMXSyS5D52x9GC45JPpjoCqdfryRSGxxLbDSrSKkXT
         FuwmpnboCpg+Gjv6LJILklU9+utm1wOGnaOsWn0E7FMW9gOZ3O8FD6nPX1KNYgxGkOzP
         OsG9++J5Fxlv8bO89z5J5QbU0Eeylp335/sKRB6d5Cwhcl3YyXzjPyF1LCjKugzvCnGE
         qfQg==
X-Gm-Message-State: AOJu0YzfzBOZcrwm/dqbTzlGP/uvHcKWTkPSnnzg4aNoJDeTe6h5EvWE
	rbS7APDhSmv76nz50/9vTu4IChnQZ0zCQubEwn1mqhGrqjCCQoN2SJ7/AcKZM9567XVaC+9y25Y
	zCZE=
X-Gm-Gg: ASbGncuhBYTTylks/oLHHT0s8jzJd3IGWaExmq/SP5j5eacVdci5MP8HDMTJjgmPXVf
	2QprkBK14oS9CxvfOZyrF85/9U2w3J1vxnjK30WoyaE9fRDqNmU22kmMmuVQciVsugkjIuI/xfL
	afhuLMO8Xt+YelxfCct28qWoh+K1dmQH8tSfpiNtLi5xK6en/KwURvQYdN9WNFUd8Lr5zBaOlOJ
	SGz87r45T6u6bOSRyXxTQGeeYWmr1URihhO4bFZkBqTKRPxWIdcmDlCMzt5djjS25u2ePaJFpv3
	ldBmlsq832MZcPUJFLIk0AYgt9KqGY/W+Mvp9lVkr9P6XeV8Ac1mM9t5SwHdoJGsbv6Btl4ZFHH
	fuN61jLMWSS/fj0DRWHWwp0qL8RoWRil7RchS/32TeOB1ND0=
X-Google-Smtp-Source: AGHT+IF382Clh4/6mNNx2Oh0zczVhOyJTOi+eF/wvKYk7TQv61i60OKTYlupEYBZ4a7qvnWH7LjVLg==
X-Received: by 2002:a2e:8881:0:b0:32b:8e4a:5717 with SMTP id 38308e7fff4ca-32cc658e524mr6470701fa.25.1750855939484;
        Wed, 25 Jun 2025 05:52:19 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a3668sm19795981fa.57.2025.06.25.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:52:19 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 12:52:07 +0000
Message-ID: <20250625125207.566757-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625125207.566757-1-ribalda@chromium.org>
References: <2025062015-vocalist-panning-1ddc@gregkh>
 <20250625125207.566757-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we fail to commit an entity, we need to restore the
UVC_CTRL_DATA_BACKUP for the other uncommitted entities. Otherwise the
control cache and the device would be out of sync.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Closes: https://lore.kernel.org/linux-media/fe845e04-9fde-46ee-9763-a6f00867929a@redhat.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-3-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit a70705d3c020d0d5c3ab6a5cc93e011ac35e7d48)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 40 +++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 618e66784d0e..466f947ef440 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1752,7 +1752,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1781,8 +1781,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1794,17 +1792,24 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0) {
+		if (!rollback && handle && !ret &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			uvc_ctrl_set_handle(handle, ctrl, handle);
+
+		if (ret < 0 && !rollback) {
 			if (err_ctrl)
 				*err_ctrl = ctrl;
-			return ret;
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
 		}
-
-		if (!rollback && handle &&
-		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1835,7 +1840,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1846,17 +1852,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 				ctrls->error_idx =
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
-			goto done;
+			/*
+			 * When we fail to commit an entity, we need to
+			 * restore the UVC_CTRL_DATA_BACKUP for all the
+			 * controls in the other entities, otherwise our cache
+			 * and the hardware will be out of sync.
+			 */
+			rollback = 1;
+
+			ret_out = ret;
 		} else if (ret > 0 && !rollback) {
 			uvc_ctrl_send_events(handle, entity,
 					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	ret = 0;
-done:
 	mutex_unlock(&chain->ctrl_mutex);
-	return ret;
+	return ret_out;
 }
 
 int uvc_ctrl_get(struct uvc_video_chain *chain,
-- 
2.50.0.727.gbf7dc18ff4-goog


