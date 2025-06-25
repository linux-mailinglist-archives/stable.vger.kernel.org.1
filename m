Return-Path: <stable+bounces-158543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9816AE82DC
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C62A1C22A3B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F025E44D;
	Wed, 25 Jun 2025 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXxAzKjJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80B20ED
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855159; cv=none; b=I6aiRL3ZPU7vQhgTFkZpc+HQOpYb5dUZhmslM6U0prf3RT6JrKJIz6WsFnm2ABVT05/+BH0nXpb1h5PxnfQqR6b6UKQF2mvEccyEajiIjGWvQCAMmUv4TNMzYyanhXDoXGf5R+z4dWEkkqK+pl7lf+guaZQhilshySGGS8YwswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855159; c=relaxed/simple;
	bh=JyvLjqY3vV3MdGgUev4L0bymlkSzJjxyFDyYY3NGjJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnM6HmiuEDQ5vrOLreI+3SoPtLcIlWVrqYft55M3HIA5dbjchRjvLs3JeuQ0PtYnpPUUhEQUEgUS1hxAg3IlsWEfBb02GmMNUL80u3mmj3Ki48KktR3o0ofejVgusgUanve8d8cKFxdoyx2mElMiE52/Il4AUwlO+EXb77S8h/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SXxAzKjJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-555024588b0so3455e87.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855156; x=1751459956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZYvI081BEbpHKTCpApT8naNWqKfVQdCgS4sC+dfK3Y=;
        b=SXxAzKjJeD9eivO/Totz8ir/97KQij+2KDMw6/h8gnr2jLek9avAu2QqsrqLzg8Lku
         Md7L8lpMvbtT6l+NGlJnFpZSvCbKRYn9DqZ7MOS/frNVpK3kHNZceicLmVEll0hoF8Mn
         +aSbUuOzS89FWlmsuTE5xcwtZ3ycGumvi3YR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855156; x=1751459956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZYvI081BEbpHKTCpApT8naNWqKfVQdCgS4sC+dfK3Y=;
        b=iF/8hZBrR1ygZtP/8rtPfI9jTZix+C3CnfqtVgLovw1m8z/WsMDdDt6PVIlIDezQrb
         BW+e9OWPaqBmUF+YNwwXbeTYsQDHeHumpBZbDVxqLF/yHWnVc6a6Ic62hnrXqdg/Qp2Y
         Kd39QA0oEFYWj7mKkK/Mq4/QUvJATY6wn1veDiKs9hrbvb0NPCzumZ36zB6K7hZ/wjQD
         tT7/4E+5xNWLmCZFbC9yMHUqsH9G4kT/ZNI+luD+eMV6t59kGcC34EgZYi1RV+7Fmzbn
         yZGLOwS4Ro2QBUITfCC5JPUsr8K8BYf8SQ+VC6x0+grldsj/uzibYWZcZQYfni1Kswi5
         sOmA==
X-Gm-Message-State: AOJu0YwLW07SkBvdKDm6mkOCOZEaNVprLJF23v5kttZ3OWtf9BgDO7q0
	FErFCShY0CbvziLcP0uROwwT9poatXC1ddFq+/D/6grIbM1sizZuioKQScBg+7yKLpBNec+i8JE
	mxR0=
X-Gm-Gg: ASbGncs5kdMVJ95rKEvyhBohNFX0TIxKYEUIwUxVM9VHQBgevUYfszef7Gd7OgXQAWi
	kKImz9Ora7yU2jJ7NbybuM8B800iHlttS7uFDej87WDyKzYkjcpHN7ahtF5aJNNRv+O7PKaOYEX
	EVP4G6Vb8yz/3OAirohrZvwfdwMD/l3qOiSYHxm7SjYareI2//QEAuylzOfy5zHONU8i5D/xLqF
	6HIBNGgaVpQhArx2sAuKb5vIEuGja5tLkj/saxUbzZDlhj9xotKOl14dJMRlOXaZC977dFtYo44
	hnDLsGst6yMLW3g0Gp6u8tGtIH/35OlNnLZSf504D4FQDgabb2XKWytOTTRI10rM7LmLY3JVLxS
	5Q788fEjhIWkwgcw/ks1peceoYZxhB1vLmWPM/ZOKGrvRY3s=
X-Google-Smtp-Source: AGHT+IGOFwIQZKZjzeVddYJhGAQHWuCj1z00wu9Tr0p6HT60+OMmCa2hmsXmDp0XKr9S2yTwOFAhrQ==
X-Received: by 2002:a05:6512:3e16:b0:553:2c01:ff44 with SMTP id 2adb3069b0e04-554fdcf43e5mr884379e87.2.1750855155756;
        Wed, 25 Jun 2025 05:39:15 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e40dcde5sm2187710e87.0.2025.06.25.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:39:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.12.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 12:39:07 +0000
Message-ID: <20250625123907.523404-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625123907.523404-1-ribalda@chromium.org>
References: <2025062014-afternoon-selector-f71a@gregkh>
 <20250625123907.523404-1-ribalda@chromium.org>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 34 +++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index c70d9c24c6fb..957d620ad671 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1848,7 +1848,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1877,8 +1877,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1890,17 +1888,24 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0) {
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
 
-		if (!rollback && handle &&
+		if (!rollback && handle && !ret &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1931,7 +1936,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1942,17 +1948,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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


