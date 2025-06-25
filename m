Return-Path: <stable+bounces-158546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47269AE8311
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8824E1C22DBD
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD502609CC;
	Wed, 25 Jun 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VHBFQYGs"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EA2609F7
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855546; cv=none; b=XLG0ivlFsIBVxbhwoyiGikSTiBYpQnyvhc1EkEq9scF4Ln/EhxebuL/D7lTnFWtdsmF7400KXopxUBR88mpAMngUkDLdsnWLN4gUzSm2uhwfpdKh2TM2YjDgCXsJWVG62W1Hyy/PwUChC2QzO09pbH8KC0FyusStkBqXQVqnEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855546; c=relaxed/simple;
	bh=03dFSHi9SjJX1IPWgBLP0HPUDphfxRH4OW4dejXSI6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0nmvFYZKWf+rzSFn5H2Hj3FyES5srliDqfrczxzuiSCbzxtWYRSPG/Vvi4aumFjfeT1K2wGanxUrzOXPqaxa9NEKP4WRJ9I4Hot8FWLiDR1o2+71UWok+OXH1wqxkZr6jVU4YTZH6ybaX/kzU0kI/pCghQLJ2rFjBHPauWjKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VHBFQYGs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so980420e87.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855542; x=1751460342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdckUi7h5bL42PfsjTfGgTNjfPS0GkN9wyP2pMJ6GxY=;
        b=VHBFQYGsSy6E4z2lEoBvXnbPDdI2UPDF/b97iDGDg09i2440PUF/DGXQWVXQlqC1aw
         sgsT7bhyQ1dJGb0LTNdwe+keD4b+MYde9/OIdbQ4wn2OPqj7C/8kw0aExbTYBDV6Lvdu
         dFa1ZYGdfD68dYmvvs3TgtKkEQ9Grnb7xtFkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855542; x=1751460342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdckUi7h5bL42PfsjTfGgTNjfPS0GkN9wyP2pMJ6GxY=;
        b=f5zEJPQp6kqa3ogBguYqazY5cNLK9ddH8X4584gYVD3ORwFAnGgnv9/2ZysCRzQT1D
         Odx7nWUCILDo7TffubFrlC6ydvxEHVbJNSeB1GaaBK/2C+dU4wXa7O3TdS3RczgDfWxb
         snCkuq/GmskDyyIuAf8U8sGGlywDM7CtHwqlPGr3g6zngzp4yTeX/yvivcW213dx9R6Y
         8uzy4EY0iH+0uxxfm9/j2WWYEio0YPWhS6jTMWooW1jOjl7nfPo3XY6RAEAMWnCHKsFi
         19Gu1waOt3eekfd20MVXKNIXCJ6rjOyUZjDo2Ws7HVpJGJC9e/H8cU3RMofFtPVDn0ZO
         f5EA==
X-Gm-Message-State: AOJu0YyulpWQcIFG/7lWG1ZpdPyCwoc4CftgfV7Mke2c90Joan5TikVR
	DLImUXUMZ0EC7Ht763Q+g+isorNkNXvbe9HSPYqsxmi8+5W2AjGCMIZQD3HCr2WX5DsE4wys5V4
	dzDc=
X-Gm-Gg: ASbGnctnqfTsUnWeQWS9Jbyo1aB1ke6H1Jg/hkcaTss0cyh6je5fTCglMuB2pMZ6E6D
	NWWEACxIyod3PYO+aSMn0LjQwv56tyV6Z4RjAIu/UMyVyE7lDAA++vrbl+1AiDFADPJZu/fON/i
	oxaB+Rp3MRJOdgNUjcw4mFUNqLjpcgxb5Ee3weWLu/Xx0G9J7sO+7lsGN3e5VvUvEq7WFsSAhaW
	1tazL4v0TKNhrC2zNqMcmUtw+EPr80qWMlXlku3nbYONV7eyvVInzppBdwioNVVhYvqXMcXCb4M
	gGKupP9R50YgoKBeFcPnFkUP0DgR1g0nASqGty/uC+U0Je+nGiFXuR6D6rh0gM+zKZmBV1cf0Y9
	spZ6apZMGBpyCvBN1jhu+62hOfAF9MJXE7V5mCY+9skBQID0=
X-Google-Smtp-Source: AGHT+IHQ36jm96ST7aJE3B/x+7rdg9rqB9SKoBml73dWrevuuXtQOB3n9M0D3Q0qr3h8VzcGEmA1xQ==
X-Received: by 2002:a05:6512:10d0:b0:553:d1b0:1f3a with SMTP id 2adb3069b0e04-554f5cddf6amr2573093e87.28.1750855541668;
        Wed, 25 Jun 2025 05:45:41 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c4448sm2196328e87.187.2025.06.25.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:45:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6.y 3/3] media: uvcvideo: Rollback non processed entities on error
Date: Wed, 25 Jun 2025 12:45:35 +0000
Message-ID: <20250625124535.538621-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625124535.538621-1-ribalda@chromium.org>
References: <2025062015-vessel-facility-967c@gregkh>
 <20250625124535.538621-1-ribalda@chromium.org>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 39 +++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 59e21746f550..bd90d8bacd5e 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1801,7 +1801,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1830,8 +1830,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1843,17 +1841,25 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0) {
+		if (!rollback && handle &&
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
 
-		if (!rollback && handle &&
-		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1884,7 +1890,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1895,17 +1902,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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


