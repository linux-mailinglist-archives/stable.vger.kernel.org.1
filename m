Return-Path: <stable+bounces-191533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6EC1654A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCAF1A271A2
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7834DCCC;
	Tue, 28 Oct 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ks/uO4jD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88C34D92D
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674116; cv=none; b=IR8vAnrlfUE4cSJNNGikEXMyF0hkFbfdTXLiECNWtjg6/2zqMJiUhDdKQ9tdQAH7IdzGKDG4TGiwVq64jkVwk57A8i47fQUPLdwQVW0LYTda5qP8HJcwS3b7gScvNw2W0iKboycrBLUo9rwwWvzlNziQciOWWhMGGOUwmVLyAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674116; c=relaxed/simple;
	bh=iStP52tSTRqDHZ2s/0JKhVbhHFkl0Dz3qnu03/driQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rzDQ3QEQ15mWNibz5gG9ZD6XOsQGqiAa3vcycO4XpCj0nAjpunKaClxIKIjFSBywPpw/49KlHZMucsWYNRmcIUc9woypC7XMSnv7S+7gesS8YP+0NcLPM9UWPOR2OydSpevf4kVX6f58zj2kCN5/V3U8OzC3lRBEZnjtgVwv9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ks/uO4jD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592f098f7adso7854741e87.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761674111; x=1762278911; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrs+/SZt/Dp84KkQFuAowfk7ciIjCYoKYgFhbI0eCxo=;
        b=Ks/uO4jDUE+R5flB+IeJSU1S2jahqmB7+vQGIFTMq/ZBTqJBFbINUBFWt+xFamwVsg
         +j00QQ/pF+/U5hbHEhk4Cie1KiAsNRv5c8s1V0Gdwms2cx1bE7+IPCwZEZwOw34I8KA8
         NNl7gosuHl/m1nQNkY8ddo3QjrPUJ92iavcRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674111; x=1762278911;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrs+/SZt/Dp84KkQFuAowfk7ciIjCYoKYgFhbI0eCxo=;
        b=hB1MiENMw4ro2bw/fKNdX0sVH8e7dg9SdojUl9OR+Ed26hHoDKbenRpfYgpliEcmxP
         GqL8Fx+TdA9ANgmFAbKxFxfbGU5MbN1c/bKWedRMza4Z94b4doZXL5+KmTYSvpLYwC6J
         vcwd6rGNVETeCyDW0s+tzmHLZ1mW09VyrpwEjFZunUR8YS1/ZgUQpgjJ8Y8LdRaiJkzz
         OPWte8GkJpIDE+zHxSvDMy+8KSnVFkQl/DaNBZtL4cm+SpBIjisF2yc+jlKS22F4kItl
         wNuDhASheDABkR8/vBPhnHt0q8Xj4OwpufNW3PPwHvWeMnV8NHWjIDjo1xkbOZd6f9JO
         xyrA==
X-Forwarded-Encrypted: i=1; AJvYcCXQNqhKqPf3X9jQWacbVzodVEYBTdkdpBx+tf1+zf5uB2rqTL5bqin8p/pdpIZEL1U3/sHE69M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQwbZkEkx33M2seohyDh1tWXCxnaAK3ZPQkkFGuMdqXzjwfh2
	8POKBVn3BKVgFHUnxN7vVdV1ES7XTQjLBU+1irLujAzw8pe+/v0D4eJbCwWNdSDZsA==
X-Gm-Gg: ASbGnctzXaRitbQw2I5zhFuSTVNEthzzKgtRr/hK31PlrNLzFYMrVkX0TjfpJZ4ZHZk
	ZfEONVkoCfN0ya3fOgGqmGDDMUw8uVx2URb9per6GJzvuAO+Qjx9h6arTNqvAIp6RDq3zO1Ap/u
	6+tv37QeWDGhVsV8bV3mWTEOeqcXaN+8Gbi97yjpls9vhFWTNNmY9eaEnTLdjHge9YEQmliiD7N
	l5CwZbIlhnMy8LCnDBxK+JVbxPirniqEvVvnR63VRrTx5gi61nEVCjvMIygXDoqrZ7sIVG5kNke
	keHQCiOpjAaoEYDarZd190j7Uo7xjcOucR5/4XHJ2L2uMgDgHrM22Ifei/MM6b7ZkvCisjMhdPt
	I37sfLgkaurmRp99A9FomW9lpuDIZ1E6V/bf73yzAkVazjhF1TWyP61RZxxrnQhpWUFObJX/J9D
	QjQ+P7VK1Qv5cBD3R/k3kkH9XFseu+RPBYnJQlWQ3jfdCSXXrkz79C0RLv+aTDHNGljg==
X-Google-Smtp-Source: AGHT+IFqGiYrkyFkibQDWmSYZpAF6eBWO6jYvlesQVDAePpNLhM3UWiTVV5GZ9/v+cj6r6VcAsgK+w==
X-Received: by 2002:a05:6512:4012:b0:592:f935:cd8d with SMTP id 2adb3069b0e04-59412868c4bmr83783e87.15.1761674111422;
        Tue, 28 Oct 2025 10:55:11 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f7444bsm3239773e87.85.2025.10.28.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:55:11 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 28 Oct 2025 17:55:10 +0000
Subject: [PATCH] media: uvcvideo: Fix support for
 V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-uvc-fix-which-v1-1-a7e6b82672a3@chromium.org>
X-B4-Tracking: v=1; b=H4sIAH0DAWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3dKyZN20zArd8ozM5AzdZOOkRMO0JDOL1BRTJaCegqJUoCTYvOj
 Y2loAMUR4ul8AAAA=
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
 drivers/media/usb/uvc/uvc_ctrl.c | 11 +++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  9 ++++++---
 drivers/media/usb/uvc/uvcvideo.h |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2905505c240c060e5034ea12d33b59d5702f2e1f..2f7d5cdd18e072a47fb5906da0f847dd449911b4 100644
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
@@ -1442,14 +1442,21 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 	s32 val;
 	int ret;
 	int i;
+	bool is_which_min_max = (ioctl == VIDIOC_G_EXT_CTRLS &&
+				 (which == V4L2_CTRL_WHICH_MIN_VAL ||
+				  which == V4L2_CTRL_WHICH_MAX_VAL));
 
 	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
-		return -EACCES;
+		return is_which_min_max ? -EINVAL : -EACCES;
 
 	ctrl = uvc_find_control(chain, v4l2_id, &mapping);
 	if (!ctrl)
 		return -EINVAL;
 
+	if ((!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) ||
+	     !(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)) && is_which_min_max)
+		return -EINVAL;
+
 	if (ioctl == VIDIOC_G_EXT_CTRLS)
 		return uvc_ctrl_is_readable(ctrls->which, ctrl, mapping);
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 9e4a251eca88085a1b4e0e854370015855be92ee..d5274dc94da3c60f1f4566b307dd445f30c4f45f 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -765,6 +765,7 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *priv,
 
 static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 				 struct v4l2_ext_controls *ctrls,
+				 u32 which,
 				 unsigned long ioctl)
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
@@ -772,7 +773,8 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 	int ret = 0;
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
-		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, ioctl);
+		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, which,
+					     ioctl);
 		if (ret)
 			break;
 	}
@@ -806,7 +808,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *priv,
 		which = V4L2_CTRL_WHICH_CUR_VAL;
 	}
 
-	ret = uvc_ctrl_check_access(chain, ctrls, VIDIOC_G_EXT_CTRLS);
+	ret = uvc_ctrl_check_access(chain, ctrls, which, VIDIOC_G_EXT_CTRLS);
 	if (ret < 0)
 		return ret;
 
@@ -840,7 +842,8 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
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


