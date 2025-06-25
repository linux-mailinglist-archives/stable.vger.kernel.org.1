Return-Path: <stable+bounces-158566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DCAE8524
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD33BC61F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B581DE4E1;
	Wed, 25 Jun 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAxOv9gd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D145945
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859319; cv=none; b=Rj2vQ1MmGcsTCafO1kareRv82GrNe8xEXwmTLbzPmxNSbj7adlGPBVnRp9n9BpdZxO+XKNlDF/QDerZ0QIcCho4mzPAU4MPnvOFj0vqUrlYYSxpj/erEucKshwDfXx3Hq0yHvrILmqlx7aHgkiOw0gViSwR8swW+wxUtULtwemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859319; c=relaxed/simple;
	bh=QagriU0N+dW12BVOYiFapzIoblJY/f+K4tBkgkVKBvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/R0Qy1Z9ZjXUFzYshGFL+paea7WF8wsiVqsRgYdvtxliQj0ahlXcuQ7uZ2yORQHFEf9rM/f7oVkTNsN+OeCdq8BJBAFizszQG9oEo4uoWqyP4ub8/KKBU/5FYRRrdX8ODsTQ+sA3bQLJqLg2Svu7lGGz0q6WUZQAkQWCAwWRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jAxOv9gd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b5165cf5so2129752e87.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750859315; x=1751464115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aLOL72SrvnMG/jLtp4nyVXhx97p/aV7ViAl3B0Ynbo=;
        b=jAxOv9gdTjZVhco0f9lp5lvtxarYPA2xdXULtLSrrtRvVVwWhhLlpcgoUc8Cgwhm9w
         sBIY/uN2Ygsusa5y3SWv4uH1PMTYz8DiUgTWajz92Hez1Id818WvkcfYL+TRFgJM0ABW
         XUuEonfNZH9IKm9FoLw3C2ZcEV6a1fJX/hAPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859315; x=1751464115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aLOL72SrvnMG/jLtp4nyVXhx97p/aV7ViAl3B0Ynbo=;
        b=eSXf67EdaepioN3jHeRGV9mZ3A1H89ODkMwmtwJkG5guiRaEh9niE1i9K4S5dLshuU
         TDTAQT5ANFd3Vv/yB4LALw9YVz9//+ofXsDUbtKfZVHjsZgHvuD57eV0qlhdhx3J2xQQ
         ul6DbXJHa3N0QGAUOEXJDc+zW7oUMT5bdUM6Y4KoaaLERYh9oV6NHG0GyQ771Ko0jIVN
         LjLDt76nurvqIOZKNuw0RaNPXwTjJx1L8VBBMhaZLrzTkODPVMTZslFSC7MbBE1uGS9c
         NvfwBkfn8PzqeqDfD3mSj5XucWmlXDszgcDIit3YlOkVKWmIbPwM9dbEb0rjFoiVRHSK
         Iykg==
X-Gm-Message-State: AOJu0Yx0+uMbMDV4UObb1g4CGdPv5sTZMl5Gj+PHYXPiZ3Ze7rnWpq6n
	n2MkSCEioKMXloueYDKW0xHHfhUL/Yf+6B+V8oOO6m6sepvxbjeqmj04PFKm6HYtWneR9wcdJta
	iDhs=
X-Gm-Gg: ASbGnct6iaAJJAYvAmlG2xlPR44LlL2ypNzW3r9/f1a3u2/lz7WpzvPBnYFvs9U+o13
	j4257OUhflj/XFEUDDDv6xnwGXPRL5BR+/EI6BM2h3cU3wmvp/ZnB2/qCrig9z0qMt6u0KwMr65
	FAeaj6S7AGHifK2vLCHzXzvC+Ngb+OlXCzc9CdKEcsG7Ko97NtT5TZJLoVUvQfSlS9Qu/Kp0d0C
	eNznyiBo0IWyiHlPVhN+mQQDos9QqUrzvK3E9jY7+Xr6wTIfTEACXcnRh5do57m8dA41T7Yl4I6
	u18ihc7Ocsr8XXcbtQkT1d34LzsmJT6abk9MVg3oIWSKlPvPyJxx3cuOCpNPbOAnRtQOU15FcYu
	szMgTy2y40hOUHDZQyXs7omyo49G+nd++VgqOI5uyJ4PoUQg=
X-Google-Smtp-Source: AGHT+IHEamR4sRm/hlgmgHluAH4gBIiLb32r8VnnS1JvLODecVrtzR4OPVh/A7pa6BZlpvwe9WLFiw==
X-Received: by 2002:a05:6512:12cd:b0:553:b005:d0e7 with SMTP id 2adb3069b0e04-554fdf8dfb3mr855028e87.53.1750859315213;
        Wed, 25 Jun 2025 06:48:35 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41cc3e0sm2210916e87.211.2025.06.25.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:48:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.4.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 13:48:31 +0000
Message-ID: <20250625134831.690170-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625134831.690170-1-ribalda@chromium.org>
References: <2025062016-colonist-judo-4d84@gregkh>
 <20250625134831.690170-1-ribalda@chromium.org>
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
index 2dac0eeed55b..c9e5a74e0f0d 100644
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


