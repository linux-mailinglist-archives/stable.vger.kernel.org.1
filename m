Return-Path: <stable+bounces-158550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD321AE837B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A793B196D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA6E2627FC;
	Wed, 25 Jun 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRSoKA4X"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8C261594
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856148; cv=none; b=pqHGkodrIEeQT7i5b7xsekSs1PA9POUz8DTPYeqIoiywSEO+T3PV33deuMC1ThLT6R5tUykP1JjiRuqlzKBzenXfkH2DZPqYYSDdc2lucTCMGHr/NRGHeVgtLIjfvjniXyioF0xw9kzXqQPrdabNZ0ttbl+5ghfZGtQC3uuoNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856148; c=relaxed/simple;
	bh=Di9FCQ48/JycbWtDJIbsnfo2tFwXN07elAdKur4yKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UasKdrm53oRjwY/0htIG7Fbh1uzwfaJDt6fLKDZBdg+kkwV+dRikQg/+3c1LkTnwo38mOADORGcwnJf+Fae/66jaujssN+KVkZ9wJ//lGHoumTInMn5lz5Oe73jqeZgPzcggL9vZjCgwgK80jc4iw2wT03Dbyf5XPsQyEF+gL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dRSoKA4X; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b5931037eso12215691fa.2
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750856145; x=1751460945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PpwGrWnsidL5KJ+Xy5FN33GxmA78OXpaZ1YyXUQsFI=;
        b=dRSoKA4XESyVt88kOC94g2tBoYD9zaA4dWVk53tc5ZJywbicz+5FfHzTUyOlgjVNo/
         RwGTOeXlPEMWW9G4WpmQRMcimdHtN67TI8gnjkfdNr71xIVLqCsaRM3+M8lnMzOsQxCM
         muA5llP0wetYFDRgc1Dfl7N7DXoWVre0xc6Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856145; x=1751460945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PpwGrWnsidL5KJ+Xy5FN33GxmA78OXpaZ1YyXUQsFI=;
        b=QfO9oO5SzhlVLss1pstBbnHij+W71xe62Nm1Zw2LxzTMtkb/+BCNLh88jwnsjKtpSH
         xuwoilwCdru4A6yck4xvoMtJVr/Y1L4twB1MQrxd00IkLBRKKuJy08XtID/48nrgAD0j
         2ekixOghoLZKu8vP01gvjGDymNj0jLCVJo6zamoanCQgMDxK8BbzdUX5ZZ8kd0uiAsUm
         hBOLKHHWKR9cOcxBybzg6crq44ZqTwAqizwWOzMGSgbm+YPqcWwr2K/Mk8lsjBlCi8FK
         HWmXWW+BrlhM5HnYNDs0AZk937CKU9kx9NAvs0k9XnVN53l7OLzqQ0mSrIvD5QahTYFa
         hYZw==
X-Gm-Message-State: AOJu0YzwalbZ2PQn1ZChRyeWfQwmRmNOGak7JPfW+KcgdCbHqSO9LNo0
	35XEzvcl9p1w2wXrObsLgsFxxxDALvoG0TSzf9VlyIbv8dEOdCSa1MmAHbe2NDYsv5Zrnk/glzs
	jOik=
X-Gm-Gg: ASbGncvo40+pssPSyel6LjYmrZ7Di7VtEcW6S5MvfrjHsc0JDB4TYsBaskfAfEoAlIN
	wb9cZyDcG9fp9luNJx5SYaBSGCVr01WdQgPv4FIEBrx099F+LfuqcTZJ0AnH8I2ghiUGk3U47xo
	STueZT99yCS7LjnyCu47j2FQRfGe6mX6QFX437MUJp/CG60p1ohFk+Zw/PBm7bOLe0JEMsHwX6p
	bBsCDcwl/zLtPm9doojzkxxnYqiO37asuErG+pfaAqrcqvwPB107/qdyuEcHjYuCFUvZIIKqTJ4
	tL824Vgk4WhX8LXtR6e29d4K4ebFnn1H1gA5RjZCcF1ytnK1pzRk98/0AeGPWkdZ87B7qvAqmKv
	W4jQlBtMKD4ycnuIUM0feLnwXB1yzSU+RIgiFvTRRMlSQUXjgwn8UF5+NUQ==
X-Google-Smtp-Source: AGHT+IHV5yu1s2YPTmI5MY1FnxSrB1BZj+/GnVdrkXMa8jGV0/OPOLiPRBDubjQRFaOkVjeYIptfEg==
X-Received: by 2002:a05:651c:19a8:b0:32b:56b3:d35e with SMTP id 38308e7fff4ca-32cc64d45bemr9067201fa.20.1750856144582;
        Wed, 25 Jun 2025 05:55:44 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ca873a713sm12299411fa.5.2025.06.25.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:55:44 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15.y 1/3] media: uvcvideo: Return the number of processed controls
Date: Wed, 25 Jun 2025 12:55:40 +0000
Message-ID: <20250625125542.587528-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025062016-duress-pronto-30e6@gregkh>
References: <2025062016-duress-pronto-30e6@gregkh>
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
index b615d319196d..c845df51c3e5 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1679,12 +1679,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
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
@@ -1718,6 +1723,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1736,7 +1744,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -1783,6 +1791,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
-- 
2.50.0.727.gbf7dc18ff4-goog


