Return-Path: <stable+bounces-158541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E869AE82DB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD53A188B247
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954825E465;
	Wed, 25 Jun 2025 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iXiH1hl+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C325E44D
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855159; cv=none; b=mo38oT5thU/I2Bjfd+WwLaSmrdlYYvw0ycjROfv1TxL+YTFrjFDrIM19T/FeyDNFpmBNxvAT26rEQqtj9ZoJ/CYEUuOXaOcv1ztwaeVLYvaV2XaSoCB+eRXRzInKkCt3mxdW8ApATNs8p3KSBiLUmyRIbW/GEIfhgVHqVWIPGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855159; c=relaxed/simple;
	bh=tVFPZc2OU7hgBFUVfw3F2vrfYNe9vCthtQ5p6d2+Fak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+QXLxaNmvF/+GDwRYogkcohMxYXE5D9b3t5zGwvt4utYyKzb/u9AfbuW2xKXw9zhJO+4S/fNwsZ3nwjMOpK1uPGUVq5TMF5OQDVHaZTSg1OrZ7vn7KwMMRJBIdMQcSSGyVkg6DELzumkcQ4h9p0ojjIAmYicIh+VlG94PByPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iXiH1hl+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5532a30ac45so828993e87.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750855155; x=1751459955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOF2wqBGz1qAJNQxD+jzj8izaBngApaGcrvQc50NoDs=;
        b=iXiH1hl+ZtHbYSg5yLRaW0V8MfspbxbYozSo0Bm/b77U0j75bf4pXGJCdyDV3qCNaR
         dSJt6dSXLjPhYqxTZ71ycyVbPTNWVpfJL66/ud7cu+5Yi2TRSvraWbFpp9QeFrPEKIzB
         3FpFRniMgeV9K9yoggn1gsykIbdazvEb4YOH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855155; x=1751459955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOF2wqBGz1qAJNQxD+jzj8izaBngApaGcrvQc50NoDs=;
        b=SNPh3DyhiC8sieFwkOucWEP90pcAT6W/AdbzIvxUbVkdC0/EJaqHC/FaQBEwHoSLLJ
         SXXzqFMSGpRaa98rCC1sm5PUt8gwYM63CpK1baQiOEBSTKAGGDCFNszCBthulmYxH9Tx
         1pL71/hcgZe1OA1pxbMUTunRA5NvFM2/0Ew2JCoDeNCzo3MiyhqEMnlN81k11oIFzQbl
         Na8adPM3FY6HPmstaIhjC/VjuJIool8d14MZlvDeIkcmVmPqj2+gqTY6TJzoAzwP0Jy4
         FhrYVOwYupXItlkqK9eKjqbtk1L/Z8x40iPUd9O0HuTI5Y8DWLGp/BmMt30XvzbCW2Z7
         0XVw==
X-Gm-Message-State: AOJu0YyqQzmKTZ6Rn98KZ7D598+DcekB6+mQxYPtIks3w5DJnFM22cNd
	/tXO5oj+ym8mVnfvNapLYG8t5ZIq8mzlKy+KgAeGIDWnfBw/+7TtdOOQ6Vn955rCb4gNhr21jbR
	m2ss=
X-Gm-Gg: ASbGncs8iVJ+prztuI4fOqwj54amUNFed0s4K2sV0scnfYtBi1rKbtey3ACgADR/hBE
	lTwTS5PYUBwkPNu9F19Hf8fGst2QLq8RCR/CBF9GE1EPjTg9re2sP8018Yu0zwyT2ira9Wkhl8c
	ed4ii20feAQOBf5fdndeVU4VvM0uiER6/Zk4KdpIgd2l9Ueg/JRqkczHlORRYNjAs0eDfr+VW9T
	deAKA5GVH4MRImXU9K/yvpRLxtxWbERBzAbjH8308MK1pNmSgzDuiq5gOg5q4Lt8ffnKzOWyPlE
	DvgISez8b+BFCVElWGXxE79+lTJx2TOdKvLbRLaCF10Lty7+qrmYC9QVbvCU4dFx/LHUCBt8agP
	DdCEjFGbvdHscXKoEet0KQUqCvdQQGKwt4M9d+LXJBL0USQM=
X-Google-Smtp-Source: AGHT+IHTjL4MY4uEz4QEEaA1AAinF88l/TbarVED7oRynsErgqBFe+YvB9W8bi4VqU+phToAMOFesA==
X-Received: by 2002:a05:6512:239e:b0:553:cc61:170d with SMTP id 2adb3069b0e04-554fdce57d6mr935759e87.21.1750855155331;
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
Subject: [PATCH 6.12.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 12:39:06 +0000
Message-ID: <20250625123907.523404-2-ribalda@chromium.org>
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

Today, when we are applying a change to entities A, B. If A succeeds and B
fails the events for A are not sent.

This change changes the code so the events for A are send right after
they happen.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit 5c791467aea6277430da5f089b9b6c2a9d8a4af7)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3030e5a893e2..c70d9c24c6fb 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1689,7 +1689,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1700,6 +1702,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1938,11 +1943,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
-- 
2.50.0.727.gbf7dc18ff4-goog


