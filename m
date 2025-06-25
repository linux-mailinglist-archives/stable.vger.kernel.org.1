Return-Path: <stable+bounces-158552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B91AE836B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AE7B654F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E8262FC0;
	Wed, 25 Jun 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4QZaT8P"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFF25B315
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856149; cv=none; b=Ng/sKu1hAcQgl4LuCUz21i6hj/zS/v4hFDzHQWiq/JuUafrVdEwXiN8JcbOi/Wxxzro1rgqWwQT4BeB9ed4MAF8SKHxfFANWX/QYm+xY7oojLY8aOmTUBA/Jjo/d0n5dUUIIap89hwgqaDOjUXNpeH0XO0cOObuaEXr4NEeBphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856149; c=relaxed/simple;
	bh=UVQpx+J9DhoMW1cLhDJlsTx7sfYkmMaOPhm/X4hiyDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5w2AgOBh1S96kpezM6R+mh8k2K3JBcTDOJcF8O3zLuZMxfcuaxGuOQjb6rf9jpG2BBgEiuMohXhJ5lshABZANYjhPaPP5T4jIk029ezqfdcGChbkyIuW+1DxZi5skRpxSi1hzo1/5sXbliXGLRjTyooMr9j6LYsSz8qYZlu/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4QZaT8P; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ade3723adso76126671fa.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750856145; x=1751460945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F32Uf0FCsjaaHDpaeeZM3bNuZwjaC0jj1YHK82N/4qE=;
        b=K4QZaT8P5/X2BvY6VSLUCRkpVGzd0o13OSxJgdnFo77K+JMRBHA8qlwZTTkeWWNU9x
         tG6vh0q15/2nxqaMFJxf7C3qKntU4egNQjMDWSWwRWUnzwbqQi1xc4WVOj8Frr89WL6f
         lXm069oBZjCoJ437jVggO4m7pUGWRq0q9oVRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856145; x=1751460945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F32Uf0FCsjaaHDpaeeZM3bNuZwjaC0jj1YHK82N/4qE=;
        b=IoY55ujRRX5bNcs1VzYyTihhbD+OSSq33TIZO999/bctcpOS3gxbbov7o1xlCJl1C7
         047KGVsfXFSlxC6DErmq81lpLSbuZWyXoladYKUImnq1bEIP764wNC+ymek47Eyeolrh
         noPwBs9TuWpOYi1xXgrHN00BBeVojCamSjl1GiQbX2/vgD9ZetRIEBuKaI6eSKbh23+N
         Pho8J5V1TGNVg+wyalqteOFg+b+6PoEgNN1K9zyy+bonRk/9u6iwhRXN5LTQ5XbwHEnc
         1EK0PQ3NDU+O3JPlswLSN0danGwLcO9WVN2wSve7n75nkNWvlehiRWVzTpxF6D51g9aQ
         kZ7Q==
X-Gm-Message-State: AOJu0YyisGwOVnDJjlv59gAmZDKkdRpJ26/znH6cN9BWxiz3YaeGlyuD
	rJpJHAGmlVR8KxNHzRPCEVNL9e9nuyATIxw/3AWTqWVJUqMgztWWTECloQayk0dkCRxtYhCNp02
	6doM=
X-Gm-Gg: ASbGnctDN6+kJgtRe4fLw99E+vHMvCC+oGRWOjl00EkD1GYkSCp2FUcnAPGDZWqLFQw
	6gXMBd/yT2UtP94EsLem6JxNnKQCUMUW1WSF8t9ybLBp+8zbVRwOEAER772vhvh/VJ98Yyqwpll
	C1UYuGy9AYmyg0jdycPn0WRe2CBU0clPOR46zmplOLSES3GtTj+TzXHeOjXiYZck/ZSDPe4fW9f
	ie8Fwhrmo2fWvMj+LJFHaPTIwTA59wa5opv0AbWqsjQ3SSXIspSiB+xr3vkpAEVFx/uadMk49og
	igXPgdRlcN8iE6wCzyM+v3+mXVNs3lqqanVnU1i7A7iT2NxK6jHMDWggASyOqY23eqQm7ZKR4ED
	PyaojVDId63bsAqdwvy0zea/WlbEqM8xqx4BCjYMAF2j8pUI=
X-Google-Smtp-Source: AGHT+IH1NjKGibvN0ql88mWyR7hCbG84bLmfApwcHYbjgWP2QDV3qdddjnZ/+rssj/Fiv8JmBP8/KA==
X-Received: by 2002:a2e:a582:0:b0:32a:710f:5a0 with SMTP id 38308e7fff4ca-32cc64fb1e0mr6230011fa.11.1750856145352;
        Wed, 25 Jun 2025 05:55:45 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ca873a713sm12299411fa.5.2025.06.25.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:55:45 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 12:55:42 +0000
Message-ID: <20250625125542.587528-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625125542.587528-1-ribalda@chromium.org>
References: <2025062016-duress-pronto-30e6@gregkh>
 <20250625125542.587528-1-ribalda@chromium.org>
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
index afd9c2d9596c..f37198839a8a 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1697,7 +1697,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1725,8 +1725,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1738,17 +1736,24 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
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
 
@@ -1779,7 +1784,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1790,17 +1796,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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


