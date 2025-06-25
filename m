Return-Path: <stable+bounces-158537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DAAE82C5
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624245A01B3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A725F79C;
	Wed, 25 Jun 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1Ay3Q+T"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96E27468
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854744; cv=none; b=DVDQXQagcXg8m+f70ZJc89LOFfKmUD7BOt9COlKd/C4/q1dcwZC/v5hvG6XPJP43q1EoElObV7qlDIs7VzPVPOSY2PuMTBsSRhJR+8zi/alRs6NrOy0i8Vn25ZGp5nx2NKwmiSthjVXiZEgCPn2MdbUkQNRjaRkbElMkwqYi534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854744; c=relaxed/simple;
	bh=JqPO/9U3+Ff+KlGnSYR3sbBCY/6eg60IOqwNcb10dEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb5xn3ypj7AybT19acz02B+aio8k+JzL/al+9osUTb63bqHW0rGslfqeo6KbAOPCKWgjz98pwQWicnVFJla6sOpRfk2JZ1fnuqBiiqBjm0Ulh+8vMlyDGs6lmBndvtf1NocIvP7uODZDwptD8ZEWDGdBOD+nKXMqurMSzaBOlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T1Ay3Q+T; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so49372871fa.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750854740; x=1751459540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/UcRL2CiRusSjTBBonxW3R6u5mp7QJvmDzQeV8NE+I=;
        b=T1Ay3Q+T5DmkjePaWHsMFlT+20yhqSQdTMwQRqEqDLksgdG/jhG02hdynAPuICDlIz
         2+9OLDAS2quJbhOPhofs7Z7Mc4d7o8WdD9QLYqSs/S9etYI/xMzzlf1GWvZQtXCd0uMR
         /KRDNyrVYVevde/e1PAq2jiBSzdA5nOPWwJx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854740; x=1751459540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/UcRL2CiRusSjTBBonxW3R6u5mp7QJvmDzQeV8NE+I=;
        b=s09rQHdd3dEp8DU0O6XmBz7odb3Ltdxcmo14EwsUXwZeLLWjELM+Ai1hxTV/Y1vyCb
         QnSAbDz8xvtjxy2C13ff80/H1+DbS1ftqtBEPzUrfT3I+MS1b3yNEt5RyKLGeVMVCmuw
         jMdXvEop/6PB9bSAMbavlXH63gG1hhNGBWGb+7m02pWJJYwoGloe34IxnqDq7bpJPrcr
         dScTXN1MqoMTyuZhNjhTGfirPXF/9KQb1ZYxDtZ4SkrWTEfC19K0T/hWG1lJtDnqVlG/
         AaQXXU3QdmQQFT+t/KCwz8q6uGVbUBln/LNYQ6ujFpjuS7fVlUm+PgH7WrgWz8/Uhvqd
         fMTw==
X-Gm-Message-State: AOJu0YwWbJnQA0987398ClIqlvceB3pDoSNVnhpNmkqHLPI4odhHYLnH
	RE7NPFoDtRuVGoEjSEEZY7cCXvtyZM4e39Zjk4FZqL29a0bvXNGrui14cZlA72dWGhSFIw/saYg
	QyLQ=
X-Gm-Gg: ASbGncv/Uo6gyY9PLoib89F4nSFvmpZWxG9T9DEq/E9tjEHeiqhM9wMlgGLGHzbzCWo
	IrSvX/4Nup4Sy4rHxD8W0XZm/T8km28bzJ6rRhL61X4Vzt90d+rjH2Fyi4rzOC6sruZPzBJtY3e
	QHEXJTLMNqIES1mU3ReWE8tQN87v3xUbDHtXkSZySSLNOaW1JD0fweGlR/jhCZOQC1sCD2aXKYX
	vYgqn9Cv+E+Eo4xPqPUODFAN2qHN+9E8dnxFw6X8mWJtexLLWxoiFKkDppRAmw0gmPq2T5ekdfL
	lva1z/FWL2QemuVdyNNCVnUNDBx1tDCj6mai2CtKj1dgAf1kMuCokyekvH5Ug7gfHqshLUorpmE
	45XUHkk5VHJEEPNwyqzkb8IVbUtnVyfmSTgSqNOMDHY+QeDEuRQ6pDeAQDA==
X-Google-Smtp-Source: AGHT+IHZZyKQaxryj0iY7w/MNBxO2g1Drmn99ADVMq0+p+V9o4uVRAd/Q78mrO7oLic+tmY+Rlu1AQ==
X-Received: by 2002:a05:6512:3f06:b0:553:3544:2b31 with SMTP id 2adb3069b0e04-554fdd215b1mr821771e87.40.1750854739959;
        Wed, 25 Jun 2025 05:32:19 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ea7f7cf0sm1830850e87.237.2025.06.25.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:32:19 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.15.y 1/3] media: uvcvideo: Return the number of processed controls
Date: Wed, 25 Jun 2025 12:32:14 +0000
Message-ID: <20250625123216.514435-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025062014-prideful-exemplary-1838@gregkh>
References: <2025062014-prideful-exemplary-1838@gregkh>
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
---
 drivers/media/usb/uvc/uvc_ctrl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index cbf19aa1d823..0a01c8b3625b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2090,12 +2090,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
 }
 
+/*
+ * Returns the number of uvc controls that have been correctly set, or a
+ * negative number if there has been an error.
+ */
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				  struct uvc_fh *handle,
 				  struct uvc_entity *entity,
 				  int rollback,
 				  struct uvc_control **err_ctrl)
 {
+	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
 	int ret;
@@ -2130,6 +2135,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -2148,7 +2156,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -2195,6 +2203,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog


