Return-Path: <stable+bounces-158561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3709AE850D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422113AEC9D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B45262FEC;
	Wed, 25 Jun 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlsiP1ML"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E08142E83
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859119; cv=none; b=oqEu1/rN9f2ibMQelGH3Lj3DjNL/9iV8AhoXhdUBmJXBIAacgNdmml2YByGTrcLBeExSqA5A9FcyItxPHShcEaxznkK0kF59w1XJfiUzCWUzpqf+PjDin4ez2Oi9JoN/fRb9RvSfK5B8pn0y29B4sejBX5mZCgh2GPMfZiuiSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859119; c=relaxed/simple;
	bh=LxQ3DY6cCjdSXCFiMsDe7V5iSvwPgzHmm7DRH7HdbvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=us68ZO/vzjYjPuoCaHs5Z+tMEyv6sKEXz5fwnieYWwPq96lKGoMARHA/gY9dp8t8xX/TPBBWoAgLhL7I7iR+LUagTrLoVboNoBEDt2YKyVerk3o9HnvbYFJK6GsZ46h3z3BdDIqaxVsZAHiMcjpB1rAKFDOfBxeb1UYOxoQANqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WlsiP1ML; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54998f865b8so1344971e87.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750859115; x=1751463915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOeawaSRNmv6I9u2CU7Nraqn2SIiSO7nNVu/r6+HjQk=;
        b=WlsiP1MLuM3w9CbTga9fQhOk2FCsPZWG9L0VVgBcU1Zdb9Rj/GDKH/rcC9CvrmjMWP
         w3zNVkT/1zH6znyBtM8ppgrvSHfbRza4MXn3vgeDuNk3RchVy+12CCk9QD9iuwYR65PX
         SkC5X4HD9lHRGc6AUjrYNLUFN2ACTCnI775Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859115; x=1751463915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOeawaSRNmv6I9u2CU7Nraqn2SIiSO7nNVu/r6+HjQk=;
        b=hcWBq7xMnLoX8jCSdRGxGV7w2eISq6laipMRK5YPcygEbwKbBtW0w347HN5CQn1Dvv
         VY2QNcUWOHVClQxoIUbTFZHNV+k4U9DwNa9z6fgXjv/+VQcfyJhbSjuFcWYBm7+ZFTh8
         XdKrYqkMEUp423Wh5UasblBb5p1in3VLxMvOR2XHlbRUYE51nwexuICJv+sR5up6HWws
         IX69vtffC/ubaTlS3jsSxbgZQmOEQ2Jld+FQvmCROB8Vgpv2xvH6wtMxQqJEupP9Ggyn
         PPcU1ycmNdg/vWJxqpb6ZncFFB+miGdCrPZ+4v+xji5o4s9pKcvFA9pIuoASOtuosicj
         hurQ==
X-Gm-Message-State: AOJu0YxiHOn9HE9dF/UI7Hgj3qsXvcRQfvRHF82/hrB/lAKQk9qUOaJO
	CxYh5C/HFSxQTsX8efoGjoNGpewztfNjOlv+Z1G59LDF5+/PKvFFjRJ4RlkLInebuqDQ5msofvh
	DkIM=
X-Gm-Gg: ASbGncvUd+7nOaGhoJohcryO6nEIX9fIb+Fa4JHzk8wdXrLwdLe72MG+Tucu9TWdOTj
	ClI+JeuQBNrFBR4J4czYMH/PoIeriaxq7wvkiop8FYjy+WSzAl6TRoNyF8NrD9ofqdC9V+bzjKN
	y3Qch8W+TlUgy5pWz3cf2/RuosTAwsG46coNpZQvP19MOZoAP0fT2bBSR8ZolsiA0k/s5O8T3HA
	F5AsTqnkzNJmsUDRXgOnNm1NNl4+n82Rx+40MgHyYf0lMEfDeLPAheTZ9porKGQN7VMqGrkkATx
	TEXXg/ia4DdAoK/0cBv7nyWcqvJnwmcaqw1tA2ee+KRO8pe1nQDmLe8DQFHut4oC3clnmJ+bzqP
	YUkMkPfGq+l+/1QqmgejTtmAtIz8EK9Tx1r8nICBfSsT2JCHUvKYRQcsVgw==
X-Google-Smtp-Source: AGHT+IF4Z+Z/hbC0cXR3XAbCz7l5e/bmPdKKaJC4JtP6PjrljtiDTHOmEQ+J8GDVXSJ6sNkKkHgGpg==
X-Received: by 2002:a05:6512:3f27:b0:553:354f:1fe2 with SMTP id 2adb3069b0e04-554fdf7f329mr1101176e87.51.1750859115364;
        Wed, 25 Jun 2025 06:45:15 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41c455csm2206389e87.186.2025.06.25.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:45:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.10.y 1/3] media: uvcvideo: Return the number of processed controls
Date: Wed, 25 Jun 2025 13:45:10 +0000
Message-ID: <20250625134512.666883-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025062016-whole-vaporizer-3c88@gregkh>
References: <2025062016-whole-vaporizer-3c88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we let know our callers that we have not done anything, they will be
able to optimize their decisions.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit ba4fafb02ad6a4eb2e00f861893b5db42ba54369)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2b4ddfb8a291..f10760ad2da2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1560,11 +1560,16 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
 }
 
+/*
+ * Returns the number of uvc controls that have been correctly set, or a
+ * negative number if there has been an error.
+ */
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				  struct uvc_fh *handle,
 				  struct uvc_entity *entity,
 				  int rollback)
 {
+	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
 	int ret;
@@ -1598,6 +1603,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1613,7 +1621,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
@@ -1634,6 +1642,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, xctrls, xctrls_count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog


