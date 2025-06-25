Return-Path: <stable+bounces-158539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF2AE82C7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00215A1121
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638451E4AE;
	Wed, 25 Jun 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6qn5N8Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020C25BF0A
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854745; cv=none; b=P1x9GysLHYZRkf6dYcsdloMB6PoztGo5cBCuUwap06FR9xdOztAEitUqX1Y/hNgF5aEdOYUupXAOfBXVM/oViQV5vgTmMo6bU2McmpVRUI9rV1j3nrYp2DoFZtIfwIbgyugJD3fwYBb8ZXdKN5cQUUp+pAFzYf/7gUv3kr4G/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854745; c=relaxed/simple;
	bh=o9BFH/S5fvBitXNO+w0m09n0jqmtKIb1ucHv2GHJpEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIBZ3LS3E9Z3U8R4bOhFT93VhxRr+lx/E0eDBBXRCCJuXTkMltyLIoUzjbw1DMl+t8jhL9dXaDtoHVzCEhhNvzWn+VM5J2QkTZmwMAnVWD2tYXrrbnE6Cd0FcIbbkx32i1yLmE7pxN3DjAQGrJhNHzO8iLtqK2n3aVQDsVL5e7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M6qn5N8Z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54e98f73850so5623924e87.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750854741; x=1751459541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYgOx8eb8sQtjK7wLC7txnn8RPqBEitHbwfvuH3F8Kg=;
        b=M6qn5N8ZDmfseFHvMPdb4meG8ZJ8h7y/u0azyZLRnuCWOZZPXcFMgBusqpSjAw0MB1
         w4L1ZYXSKwYOiXG1UTYaRhYxFXnCzL32B8/5gshsy/eaQYhAfJeyA6rR2Oyau+nJUJhG
         RR0yoNBGUrz619UvCdQY6FLPQuzeq2cywQKDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854741; x=1751459541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYgOx8eb8sQtjK7wLC7txnn8RPqBEitHbwfvuH3F8Kg=;
        b=E/COzOmokJyp1B4R9tIG4lY9Vtnv2JWtZlUqFjzOaaxvaEz+UlIJmJM+epDWI7Avpg
         Gh+oUIpnOCV2MVVmxm06G6gr9R0Kb1fySsATE/mcVmP1ZmN1p9jNlkJhRbZWusj31/XB
         VWhgzcxGWIMcwyTg8todPRpt+bGVsF4kdSZMfV1PyLD11n4UHYJelB+LI9NyBO6X2Uor
         bdU14tp1gmxcPDapNl1+9Ubsqllnt6yyh1tjNdCzBZpLACReZnnLUH8ffX3inZ7f/UUv
         P6Xu/hC2ywJIL1DL2zdvtJ3JcoQBb8AAWkFsKKsBvC5ubo0zOA0Ob2P/CSpOcEhGkjXr
         MmVA==
X-Gm-Message-State: AOJu0YxXxvFGLWZtZyTZGcFD9mLJ19DggR1rMx51CpCbJYNAE0WItra1
	f/UF6gF5GBnanDE/YObLTrVF+ugEu1QG15s1X9uG6nOdZngv3QS2myK6Y2i2hAVppWH3EpFujH/
	1Lc8=
X-Gm-Gg: ASbGncs+JnwMZbMZgRiaQUkqDK8cbYNC5plqVjHRBg2ulChFZdLkWQknuj6enZKrVX0
	jG6AB3bx2vniU5z//JHm66tJgDKWHCpynKQ2sy1LV3c+HBPiL+oJo3VFgDvas2XbtxU5B2DXRHP
	jpJ+w0Op0VQlbm3jY/TJiEJZXjoLf9qfm765lUGBpQXQLnCVTaLRzc7HLEgTC/J6Vb+FcSH/zq3
	kc0n2CQ3TUsN0YG51ebCsqWlf2fc1VefJHajBdtyOu60POhhJJufYw+3bjCEyK85EyjA5LF99I+
	ntvmfYTOdl9fT7un5f+18Znge8VqeN7JopTwVne4KS6N2HxsEFMMnbaoenhKj9znJdjgMM5Czbn
	FjxCpghTo84v+AWXaujMGsXbgYO1SU9TnxnL2LexRnXRcKFw=
X-Google-Smtp-Source: AGHT+IEE8CyA3UVAW/2Ps5G2XehTrbMlYBYzDxHXEx1VVrNPtZxtxVJCwCTej/lwyK2QEji7dMYFbA==
X-Received: by 2002:a05:6512:3ca5:b0:553:2868:6358 with SMTP id 2adb3069b0e04-554fdd1d3a4mr957172e87.35.1750854740798;
        Wed, 25 Jun 2025 05:32:20 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ea7f7cf0sm1830850e87.237.2025.06.25.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:32:20 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.15.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 12:32:16 +0000
Message-ID: <20250625123216.514435-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625123216.514435-1-ribalda@chromium.org>
References: <2025062014-prideful-exemplary-1838@gregkh>
 <20250625123216.514435-1-ribalda@chromium.org>
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
index bc7e2005fc6c..e344f9d36e89 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2108,7 +2108,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -2137,8 +2137,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -2150,17 +2148,24 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
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
 
@@ -2191,7 +2196,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -2202,17 +2208,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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
 
 static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
-- 
2.50.0.727.gbf7dc18ff4-goog


