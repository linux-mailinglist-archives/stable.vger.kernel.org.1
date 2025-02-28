Return-Path: <stable+bounces-119905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F4A4930B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57665188C601
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6C1E00BF;
	Fri, 28 Feb 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A1AmGNAe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344C1DFE0C
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730327; cv=none; b=nBJH/Q4mNbvsKmvtCeTLDEympdZyVuB/+QgkvAJk/IxqExFq4WxakoZdYP/souHP6KWHiO0Q8Uu9YzuOpV9ONjn/aJWXhznG/iqIuL4YHafvRM8FZhuj7xkEVX7r1eelL7/CpeE8MLNZ3Q5v9eJT4Xo8FwOqBpr4h84X7+MiSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730327; c=relaxed/simple;
	bh=2jiqnJHEdnQIND1z6hVxtfVK4WUmMM1j7u6BYJrGFEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUV8Innd775C3rBbfyM83UhZxZqKuBlv7zgSHjI9skwvUUOwIgoiDlR9olqD3CNKh2WS5cWef4OaDHH07wY18QCwm03o0LvUP37vx7xMZ8dZlr8nxwufK/5iaMb2phMcew7/ZePw+XXrTLQepuDj++RUjcuW9Em1T3krToswRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A1AmGNAe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08fc20194so308988185a.2
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740730324; x=1741335124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6cTR/CvotYRsNcgEBUQ0VMIvrqaVKh1AXtRogzVb8A=;
        b=A1AmGNAeSGgOhO/sCflbqJe/Oh730r2QL0QJx8hby67RwjAbJqPV2q5xPLQOWXf2ko
         tvsxpz3DvPYwXtuBJ/ZpaOhHADLZ5AghvG8PC4Z7ty82h+00l1fe5qKYHg04vcOWJNz1
         2HzsEVqj7yzYKRSi3UNoNETu5Hq0yTvaFIHFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730324; x=1741335124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6cTR/CvotYRsNcgEBUQ0VMIvrqaVKh1AXtRogzVb8A=;
        b=vtr+gcchdd5lQMe4Ts5I8QJ9v725d+BwO0FNUPQzW0eYaIEqQsXnE+ffrfTlG6rA2V
         QB435Zx2AxwEsURJ/JVV2LEjncNBMCuE7oEItxbYubVAuo/ILv40tGJWbvH7fn3CjuwN
         WEoBAzd1UsqKrJdWdkRmRtU1F3Wb9TEa5RJwKxbb6sh7QW4d52ER98IHeTu5r5b8pmkn
         RmkvpCCRrDcepkcsz3QGw5FlbCMeHJYrRmKWvuE/cllSWqmVa4bVyBFKfBZvsmuFgmLj
         rIONoxpf/H1BsxPicLD5SAa7GnjIsAbVecU/EsQMfuinzY6cFpBAgLv5GaW61hMbxCIf
         E1AQ==
X-Gm-Message-State: AOJu0Yx3WO8HNfxQzV+OQzbE1Mjk3u67lnK4enGVsiE6YSEygnbtw6f+
	2QgMe3DipMwbViNdeoiv4YRDY8YIJqOjhghEjtEGY/ujwqIs9Y9C57ZxinCe92wlVxhQZ15gT+x
	tWw==
X-Gm-Gg: ASbGncsncN4P/POIY0kNgpNzcWJseXUnFyNsuGbgpNHtsYuYOiOCdiKMjLdGdVPnjW5
	lAwQtoXSEK2yWnIhT63v78YSi131KY1ir2AkMybvmMLtIvs7UOpShH5GbGWlMkbLx28ryehpRip
	Yra7+6nDKwlfQw+Hg7JagMx9DCpOHnOr6+W8S15EXpKdRRogFvAoqk6ridJqA2UivUTxA4HWavk
	dJ2tPGkKztz+kWPctiXoNoyWNfGJ2tyYRiNGmy7IVaTSl8fKCXMdWS2dksI1n2BAkKKGdcvsw7j
	ZQl+Wgxz1nGnIgwpGjdv3iFafyWcoIxHiysPhvcL/O9AG3bR9JEYGzcWXA3HfEk+jsqZ34P+fSK
	fLXLiRZha
X-Google-Smtp-Source: AGHT+IGUoBKpfcPxaGALdsMZ9zq4VN7uM0cg+nHNkj2ZLaLQx+2+LypFo2k6opLNIwUwAwJu575nWw==
X-Received: by 2002:a05:620a:3cc:b0:7c3:9d2d:fe9d with SMTP id af79cd13be357-7c39d2dff58mr300333085a.36.1740730324539;
        Fri, 28 Feb 2025 00:12:04 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c367956523sm221387885a.0.2025.02.28.00.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:12:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 08:12:00 +0000
Message-ID: <20250228081200.2672808-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021008-virus-pampered-abf4@gregkh>
References: <2025021008-virus-pampered-abf4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we keep a reference to the active fh for any call to uvc_ctrl_set,
regardless if it is an actual set or if it is a just a try or if the
device refused the operation.

We should only keep the file handle if the device actually accepted
applying the operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-1-26c867231118@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit d9fecd096f67a4469536e040a8a10bbfb665918b)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index dc8d790eb911..fbd9e0073cf7 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1528,7 +1528,9 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1572,6 +1574,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (ret < 0)
 			return ret;
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			ctrl->handle = handle;
 	}
 
 	return 0;
@@ -1587,7 +1593,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback);
 		if (ret < 0)
 			goto done;
 	}
@@ -1711,9 +1718,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2042,7 +2046,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.48.1.711.g2feabab25a-goog


