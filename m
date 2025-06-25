Return-Path: <stable+bounces-158565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC429AE8525
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161DE7A7A86
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2880262FF1;
	Wed, 25 Jun 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KkdbXMyt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32083074B2
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859318; cv=none; b=e1Q+JB3hJa59a4gl2H/5PGwlXJ4DnsCtom+RvHnUfGUKgxQn5OJj+cGvJHrmt8BobSRXNu+UaHpVhEHKoUfRl7o1sIStBH5yx03IhAZqOAbG6FLk36nkmaE3y/vdfC6RilQmU1RoEXyHn2Gi+JIe8b61/exYEjrxx15EbNpUsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859318; c=relaxed/simple;
	bh=AHiy5jUXKTQw6DmpyUBQIoRyga7tQweJX14BR4cpJW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsO3ebjTR1DvNHahFJEf5G/1t238b15S2DluMw+ZRt3ftF4LKJsMRcAyFj55gnKgEj3O8mmgCRNwZJH5Pr7+DFrkFxca5OX9uNlwsR2K8jbpRXu6VAjI4jS7jew4uObWLSAtU/YCo/q+IV72Xs2NqtZvGP0lYWqDQM92WiegV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KkdbXMyt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b6a349ccso6527555e87.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750859314; x=1751464114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1QJa7BqSnNAcS8vAhvXM1t7HFg9U0kg2uuHGj2LR8s=;
        b=KkdbXMytutjiK7uutQTI4X8eS+sa9n0n2v03Ykum2VZJD6dARQqrs54+/DqZSSWaBd
         Pfb2FnLtl1ch4nC/fsdPbdDRi4jGFXkVrYA+uM8uwOWvt2i2u9JmPtHuMPiSvKKFDRT0
         dRpGQYfjxiqSMDlWhAhuFnLLaBkCudRaHqDto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859314; x=1751464114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1QJa7BqSnNAcS8vAhvXM1t7HFg9U0kg2uuHGj2LR8s=;
        b=GcHqnkbQl5CHlu8rOZ0cySDoZdOMW7VPPkhRvNb+OlnzshnW7VLEKS9QmyeFKTiEnG
         76udNewcQgZvjBDLKPPzbe6OTXAZfCIOtLQ9crMOrTTDtZDPRkrx6UkmdBg8VJM8OwPH
         I4x1LNlJEHD6qcvtdzRnPK7t5dRBCMn6VRIXvvH2/dRfNJo4OijrupAeq1bfy/tNhy0I
         A/gOKZUQstbSC60aON6+eogTUD1QewkR+IwDK9IJHC9CS9Mx/ceIRU5WnpkykRB6GQBI
         bi2z9CYV7boRZVHorJ+zmY99DfnPnVhMrxvQYDcPUp7k9XG54VXOJ2Kc/a6vWIsqaL4Q
         s0ag==
X-Gm-Message-State: AOJu0Ywv6TmaC5+njEd+ExBFuigNQOdnxJjYqIF1/62kvMkhipkEQVfG
	VPUeObWoG+Rdr6gtH/FnxDvGlcUc/AIXTGCGi7CPsC1OVdPlzIae00DSoGIvVTxaEgvcDLvHLud
	GXmc=
X-Gm-Gg: ASbGnctPZFvFswNMRm40PzbTQ6ebN5M3PV6HiySaNiKZVTOMdZ/S7NU7F0HIOrhLlCp
	07Q6S3fM6E6ov1eoRNmIxwkphj7d0aq/DOL2bCOgv55gjtt01qsonZFEeBQ9K/gdgjP8sc2jPOs
	mf3oicOn/cpMifTeh/VP8ecPE9AD5/cLo7lLScNY0rvttHUA4pt6iOILiTRgS365ThUvDadfaM0
	cWfwJyfY4OPIrLL0yb6zWA1LMlrXIvwkvsk+Pgkb2V+CxuEZf8FZZdan2/5qxCLTtfsLFu3fdqc
	0pIbnGjRi2f5EncNSYYisHoDb6meBMCZraYxzn5brSr7ByOI6lsvvxiaB3EcrjZRkXVEGtPTB/Q
	Q+2SL1/imZky+isZyZmpC5/1TMQ5hHWenWCZYoWSjtDJD/YE=
X-Google-Smtp-Source: AGHT+IEBS0Nt57Bq4FwMN1doTyuWn++QkVLGoUEXSvDVgzDONlW3jERFrTfKbuVgxsN9ydOsv3mkzA==
X-Received: by 2002:a05:6512:3d0f:b0:553:297b:3d4e with SMTP id 2adb3069b0e04-554fdf67cdamr894896e87.52.1750859314428;
        Wed, 25 Jun 2025 06:48:34 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41cc3e0sm2210916e87.211.2025.06.25.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:48:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.4.y 1/3] media: uvcvideo: Return the number of processed controls
Date: Wed, 25 Jun 2025 13:48:29 +0000
Message-ID: <20250625134831.690170-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025062016-colonist-judo-4d84@gregkh>
References: <2025062016-colonist-judo-4d84@gregkh>
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
index 923494567d89..0db6bbadc593 100644
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


