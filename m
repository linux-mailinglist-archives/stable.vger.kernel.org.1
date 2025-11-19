Return-Path: <stable+bounces-195199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434DC71048
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 204AC2B6B9
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85C30C378;
	Wed, 19 Nov 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRBlvo3L"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC91F5847
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763583461; cv=none; b=mpQxocTdaud5Dpd3qkToSBXV+QMMCCY4DeWa8wbcquazr5kOoMkz1uZti5Z6m+wu6FtHNr1/HCzsJ9WjwXW0nl5UM8/pY70dSWC92gIvecqxbenbEqVHMBwLxi7NC9huZei3jNRdSLfCi6LACAd9rPPgAtuBB3IKCB82EMDYHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763583461; c=relaxed/simple;
	bh=f9RZO2R4aOCAiD1SjERQgTIa9CRXG/VIbKxc/B9MABU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NaUwPUvxZOPWYOE5fO/STIfOVKCH/md0VsupLDtX25XMiCz6+YH0roAy13a9Ffbes6sC1wFRc/9G+a4mllq78mVyyJjdECSr6aoQivbSR6qZixo81KfIUrf8TPktndMW0EQbOWZXAJgE7k8Ze1aAzCAF7Ea/2Ek1rfObHuM7i5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hRBlvo3L; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37ba5af5951so1051601fa.1
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763583458; x=1764188258; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SO059kbbw+dKgZc6zoKEA7kA0qHyx10fUv1rvbi+HXA=;
        b=hRBlvo3Ls0Kbd9fzDPkN/LJcvrJ0oR+ZmfuD6wfqOd/06g26EQK7GZSOck2iPGj+nw
         gRewVTJH0SAX56RjL7UNFYPIRTr/IaCAIQMH1e0Q1l6ojGJlrt9Sy6zBxaU9obwR1X/O
         530XlHmrGS+qcNLlEZdSzybw0H3PGBdkMGTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763583458; x=1764188258;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO059kbbw+dKgZc6zoKEA7kA0qHyx10fUv1rvbi+HXA=;
        b=KKXtpMlIygGkRluNW0xysiskpLzYrZ1uAm+cp5Ph1Hm8uzRLZsqs4rx6CEB4IqiRhz
         SbV193N7pEXVAfIF9RSF8QCu2oJdOWiyLf1w2IJUqrM29PGwhPKi7OM6hOtPOH5VHRDz
         jfB0UThuIlmye2QmgVXyavw+7wZkExHjqaFVvPmnIPeYCJzhMmx7R1yn3GYBF6+ZUEbi
         Natdq/8Na/xxVWvZ/TufR0z620bEj66Yjmn4W/b7Pj8DRaIeRazeQONKT8fSnIKwjWNN
         sBfh/ED34y2WjdH9v0S5XxgO3+Oxo20F3YhhM4ibwlq9ZlBflPBTxqZOpe0TLwRTi33k
         FFnw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ467LeYE8nLivRMQcRng+klWXIt2AgVuE4CyIzZfBfioNhYoT69HgvDa+jrgAX1A0Un3jdeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtjJBvRtyZk1LaRCTtL+6IcswiBGlB8xuow2+dwlcv1at6K59
	fnmKbb/CbH1qTlyy+aeRrEkH1eDhbt9aU9iEoTMA0tbu4+LX2ctcp/ThQhKgxnV/4g==
X-Gm-Gg: ASbGncuCCxVxULyhKlSkY/FZDEhA202Q9S0ttQSXzGp2mZnW5R8vPwpc6KUleiJU/qW
	yn76WvIo3ev0qYIfAf7gCKBXCthx9m3d5EDuOs2c6hciwOtDH3BBslg9BJuAH6Ldi6rA60aeo9P
	ELaHmzJH3qZNKU0OfA5xrUJtvJVNbyJ6erzz1coYsgxzpTrfIbwHypNX535my3h8NCgWTz7NV/q
	hpt+1SxmroIm/4dBN6TGDknC/IIvzGu1TSOM/DIS8zQnX/UihyR4rCgGwxeaXAGnR/MB7zmMfSX
	Nze1daoq5WDISBXwpQcXwLHN6XHdifyqAhFsapfDQSMWw5zl/uDyyMC4wjdYkk1l+u/RC/o/iKv
	2igCwFTrk2Dm5JfFmkvVeJ++ZMmxzQLTOU9mleETknONbHa8AqvzOp3P9zY9/DnlVKbRKsFrcs8
	SdqI/F4MwzAExTZT+O7ZzOHWFUnZGCuvMqK2AyMABczUF7NrZZj3QqtsiXUds0VicEuAbT6d1u
X-Google-Smtp-Source: AGHT+IH4kdKLDZMxdGVlT1psfgFV692MD2m38hRhKV/m2rf65Iu485e/0lHTl63za6bUYF8VfvyezA==
X-Received: by 2002:a2e:8019:0:b0:36b:bfd3:13e3 with SMTP id 38308e7fff4ca-37cc6796c2cmr1831761fa.29.1763583457886;
        Wed, 19 Nov 2025 12:17:37 -0800 (PST)
Received: from ribalda.c.googlers.com (80.38.88.34.bc.googleusercontent.com. [34.88.38.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6baf973sm609191fa.24.2025.11.19.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 12:17:37 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 19 Nov 2025 20:17:36 +0000
Subject: [PATCH v2] media: uvcvideo: Fix support for
 V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-uvc-fix-which-v2-1-67d1520d0ee8@chromium.org>
X-B4-Tracking: v=1; b=H4sIAN8lHmkC/3WMQQ6DIBBFr2Jm3WkEI5Kueo/GBeAos1AaUNrGe
 PdS912+//PeDokiU4JbtUOkzInDUkBeKnDeLBMhD4VB1rIVtdS4ZYcjv/Hl2Xl0jTVitErT0EJ
 xnpHKefYefWHPaQ3xc+az+K3/SlmgQNORslqqTprm7nwMM2/zNcQJ+uM4vgTroC+tAAAA
X-Change-ID: 20251028-uvc-fix-which-c3ba1fb68ed5
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Yunke Cao <yunkec@google.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The VIDIOC_G_EXT_CTRLS with which V4L2_CTRL_WHICH_(MIN|MAX)_VAL can only
work for controls that have previously announced support for it.

This patch fixes the following v4l2-compliance error:

  info: checking extended control 'User Controls' (0x00980001)
  fail: v4l2-test-controls.cpp(980): ret != EINVAL (got 13)
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Fixes: 39d2c891c96e ("media: uvcvideo: support V4L2_CTRL_WHICH_MIN/MAX_VAL")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2, Thanks Laurent:
- Remove redundant ioctl check
- CodeStyle
- Link to v1: https://lore.kernel.org/r/20251028-uvc-fix-which-v1-1-a7e6b82672a3@chromium.org
---
 drivers/media/usb/uvc/uvc_ctrl.c | 14 ++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c | 10 ++++++----
 drivers/media/usb/uvc/uvcvideo.h |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2905505c240c060e5034ea12d33b59d5702f2e1f..2738ef74c7373b185b67611da57610fd0b442080 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1432,7 +1432,7 @@ static bool uvc_ctrl_is_readable(u32 which, struct uvc_control *ctrl,
  * auto_exposure=1, exposure_time_absolute=251.
  */
 int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
-			   const struct v4l2_ext_controls *ctrls,
+			   const struct v4l2_ext_controls *ctrls, u32 which,
 			   unsigned long ioctl)
 {
 	struct uvc_control_mapping *master_map = NULL;
@@ -1442,14 +1442,24 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 	s32 val;
 	int ret;
 	int i;
+	/*
+	 * There is no need to check the ioctl, all the ioctls except
+	 * VIDIOC_G_EXT_CTRLS use which=V4L2_CTRL_WHICH_CUR_VAL.
+	 */
+	bool is_which_min_max = which == V4L2_CTRL_WHICH_MIN_VAL ||
+				which == V4L2_CTRL_WHICH_MAX_VAL;
 
 	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
-		return -EACCES;
+		return is_which_min_max ? -EINVAL : -EACCES;
 
 	ctrl = uvc_find_control(chain, v4l2_id, &mapping);
 	if (!ctrl)
 		return -EINVAL;
 
+	if ((!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) ||
+	     !(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)) && is_which_min_max)
+		return -EINVAL;
+
 	if (ioctl == VIDIOC_G_EXT_CTRLS)
 		return uvc_ctrl_is_readable(ctrls->which, ctrl, mapping);
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 9e4a251eca88085a1b4e0e854370015855be92ee..30c160daed8cb057b31ec00d665107dfdf4be1dc 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -765,14 +765,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *priv,
 
 static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 				 struct v4l2_ext_controls *ctrls,
-				 unsigned long ioctl)
+				 u32 which, unsigned long ioctl)
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	unsigned int i;
 	int ret = 0;
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
-		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, ioctl);
+		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, which,
+					     ioctl);
 		if (ret)
 			break;
 	}
@@ -806,7 +807,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *priv,
 		which = V4L2_CTRL_WHICH_CUR_VAL;
 	}
 
-	ret = uvc_ctrl_check_access(chain, ctrls, VIDIOC_G_EXT_CTRLS);
+	ret = uvc_ctrl_check_access(chain, ctrls, which, VIDIOC_G_EXT_CTRLS);
 	if (ret < 0)
 		return ret;
 
@@ -840,7 +841,8 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	if (!ctrls->count)
 		return 0;
 
-	ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
+	ret = uvc_ctrl_check_access(chain, ctrls, V4L2_CTRL_WHICH_CUR_VAL,
+				    ioctl);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index ed7bad31f75ca474c1037d666d5310c78dd764df..d583425893a5f716185153a07aae9bfe20182964 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -786,7 +786,7 @@ int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
 		 struct v4l2_ext_control *xctrl);
 int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
 int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
-			   const struct v4l2_ext_controls *ctrls,
+			   const struct v4l2_ext_controls *ctrls, u32 which,
 			   unsigned long ioctl);
 
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,

---
base-commit: c218ce4f98eccf5a40de64c559c52d61e9cc78ee
change-id: 20251028-uvc-fix-which-c3ba1fb68ed5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


