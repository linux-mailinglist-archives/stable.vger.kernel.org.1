Return-Path: <stable+bounces-158563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A0AE850F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231647A673B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DBF262FF0;
	Wed, 25 Jun 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3P98jPt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F2262FC8
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859119; cv=none; b=nIvQsl42vulQyYxNOSn5qlF+c9Vvm5+X08CePeVc+ECai2B4IxehIDP+FotjrR/LQg6GXWBMAIdI56y50nrzSqc2CThlO8BLAsHx4ZFS96zDHS1vojwa18q9Tq3I7RNEG3lQdN8CrHsfWPEbPZ55a4gwJUhmqIJzFBI4J5SZTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859119; c=relaxed/simple;
	bh=j2H6f8ck/avGSNZhqlKitdxpUcAguFRh8sKKxb0Gb30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5CYyX4bJX+mUqFcuznXwkS7qxmvyiOyP/kmfIjVftY+hiEBxwXHSFuCtcWGkYF+GYlUrQyCq+Y3Y0RpUyRyJpEQv7YicGMQjVJqHtZMYNMWj5FhOEJp4H/HuT4OiizNUZcndrF+dd5lpF/9Z/DpVzSag7j7T/WKvPMsd7apJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H3P98jPt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54998f865b8so1344980e87.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750859116; x=1751463916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3EHWT20KV+2D1jI5o6+LMbkEX54iBQ77nUZRAbqRWw=;
        b=H3P98jPtGwfTYEIHxRJNPRBJ867lSg28YkahqSTx2/Ey4MoHA9kNoISJFZ1soKs2Ha
         aemO58DNHwk2/gsPDVNVVKy+IVv7qdWUlbK61lRrLLOOBHo8iIU9HQb9Dv76CrqPwwkd
         6Kw9oZDixCV6spfLph4nyx2rLNbhcvE1gbu0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859116; x=1751463916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3EHWT20KV+2D1jI5o6+LMbkEX54iBQ77nUZRAbqRWw=;
        b=q5qX61ik7ytgwZPMV7SyJy3TnuJ9zZO6YuJLX2dnaSCg5yT4TsLd3uHGKjpNBPMKHC
         4OwZO48+7r0dgb+1mpc3NH9mdAesQF3lcde9f/P0WJTPHms2na0UDDBxG5waH04JSMG7
         x3LmMP6uqJ9BjpLizAydcOf2rgJrCRz4DSvPGkFNcQQeNv0635NWUCIA2TJD2A6NS578
         D7SpKOT4ok5JXbK2Ut4TtQOalzc9jwareByPiUy8jggBHK7MORJpV5MUglQAkXIDC+Ny
         ru9+QZIhdp3dHvBpUcliEOXqvMgdV0e5qb1SvPo7AE6RP2U/aVVOsbT9qHG4IVnY9DvH
         btTA==
X-Gm-Message-State: AOJu0Yys8dm/4OflFp0RWNCBJ3T/dEVHGgKCgWcN8cEgrdnbFK3GZrp1
	gQ8e+TwiQlpqLVtCgChnCYOmGZuNHaTl0BQB0SvV9T3RC2zJVBH9+5f9eHD7qI48ETgB8UbceWQ
	U8Do=
X-Gm-Gg: ASbGnctTTPqL4P7rmeUVPsta+BIEcm4JOmfoKc6KCOYRLXOFg8bnlYOOh5Zzws8Urk6
	vo+/wcw1bPzsJVuvpbQ06h+2Hg7/YjXZUk5qlYrUX5iW4zEBg4dTAyV0n86/Y8VUI4+iwvdbu1c
	hPa8PCByYq+rHdPNL6j74AIJzlNLEV5gFKPFKD2T3yOGh48CEwWefsqedtIXa7NPeLYPDktcQkk
	tofA7HS7A3OhY44SLbZydaggUxLGg4kLyitD/8lrsFRUKpqUT8Z5sAtRfE74LhNu02oeTfBDS1z
	Eu2/+IAxCEbjskS5OLD+4zZalvVbCZPnhpoKK9EW+bMujZEaFmy1/iCOklmmvbiEXKKqNB82bXN
	h+9fyRKSG6h5TqUVkST80iOSoY5t8JWMDzsh89LWPSIVo5d862vF9o7zMEQ==
X-Google-Smtp-Source: AGHT+IG3Lp94fasOSBuBk7kiWYXeM1N+R+sBlbsHjp65ALqA3ofYjSqPUCYSItMSjH7KE4/Hfa8Kmw==
X-Received: by 2002:a05:6512:124d:b0:553:24f4:872a with SMTP id 2adb3069b0e04-554fdf5ee43mr854668e87.40.1750859116175;
        Wed, 25 Jun 2025 06:45:16 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c455csm2206389e87.186.2025.06.25.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:45:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.10.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 13:45:12 +0000
Message-ID: <20250625134512.666883-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625134512.666883-1-ribalda@chromium.org>
References: <2025062016-whole-vaporizer-3c88@gregkh>
 <20250625134512.666883-1-ribalda@chromium.org>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 42 +++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index a4b082df3b06..4f67ba3a7c02 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1577,7 +1577,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1605,8 +1605,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1618,14 +1616,22 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0)
-			return ret;
-
-		if (!rollback && handle &&
+		if (!rollback && handle && !ret &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			uvc_ctrl_set_handle(handle, ctrl, handle);
+
+		if (ret < 0 && !rollback) {
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
+		}
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1635,23 +1641,31 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 {
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
 		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
 					     rollback);
-		if (ret < 0)
-			goto done;
-		else if (ret > 0 && !rollback)
+		if (ret < 0) {
+			/*
+			 * When we fail to commit an entity, we need to
+			 * restore the UVC_CTRL_DATA_BACKUP for all the
+			 * controls in the other entities, otherwise our cache
+			 * and the hardware will be out of sync.
+			 */
+			rollback = 1;
+
+			ret_out = ret;
+		} else if (ret > 0 && !rollback) {
 			uvc_ctrl_send_events(handle, entity, xctrls,
 					     xctrls_count);
+		}
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


