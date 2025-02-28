Return-Path: <stable+bounces-119908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE77A49343
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5A2170AF7
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96A6242917;
	Fri, 28 Feb 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lG+xRYeC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685D24291C
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730811; cv=none; b=j4lKRgrOlhuz4DfwptkUXyrKtvBB8d9EW7WCmM8cqB+uLifKky+HwCA5VNsBaKffLDS9m0Zsj3qrlC2vSD9e/og3suPyFKZ/WMuUSqyAKchQiXNcV2pX4QQRjaZfJh/oTnhSQI3FxwUSqfaGf+2nzLrz+93c4H09JDT1gnA4rsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730811; c=relaxed/simple;
	bh=yR+O228OvXoxq9DaXsTTyYud/WcvY/IxIDT93AmwCRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOyPnh3MsloOB00mZFQy7IbxTSGhtOLIr9psOi/++N0rJbAfXFzUqsEhUpm1eUyzQZhQJ/YxyWQzxoaLVfNy7EKMM3VJiNGm4zBYZaYcXeKT4pIPZuONtA2FMMTa3co8G99656MVwH7izhmYVFoZ3CDf1q8HdoPKxSiL6fMlg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lG+xRYeC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c2303a56d6so200742485a.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740730808; x=1741335608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUB5ASl5o66l68Lc8yM4LaRAQRDMAYp72BNGpsDzGw4=;
        b=lG+xRYeCBbwmSrWH0TMmbknzrRElxJNWO3cxUZD0C+vrw96p+6eoirdwgEY/iVenZb
         h86T7f4fL9C3SOOB6aa/DyOFBrlzA23MkVtLGRnLaxkwbclbYhV8yUtmXHdmgL3ijd7D
         DWNcoDtKCDPp1Jn3vt54LCHcWEobz+s4eTM6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730808; x=1741335608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUB5ASl5o66l68Lc8yM4LaRAQRDMAYp72BNGpsDzGw4=;
        b=GV+DA35gaP3fCm1SqU3NwjpdUK8EaKK4M4QJQ1Xp7xhgChtretPKa+uGWiYwmMI1p4
         41YqDnVLC2k5RdoZ8NvQml6RAyQekuj7ALK/6yDz2TbHMdM5wZpauSevd8lT7iq7bqi6
         kuAS4DbsutiyyBlAjSzZV0ZQvalHbTvD4bwROr8mxchQHc9XFejSppUCd6WSB8pjLQ8h
         q0jvU08ywRBealfoVtKaFsrcwGlCMcIJVt/GXA5sgsyrtNggiMSLsSvpVF1e0+eZmF53
         PGHW1W7OPu+qUfrPTDoLgX4sZeyUBM7A1noVlaLPNBjk0obUtD1OgnFLkxjuBdVzDMKk
         tIsw==
X-Gm-Message-State: AOJu0YwuPmrLAwnAZQOQlp3ZJJ+E6B+JJQLfzppN/haqMUHMft6mu5I+
	MzuD4pUrGyaq2r78mUC+xMqUKDK2Dy9+B3aKRDCN1VsQWJarusBEWolFV9CzsItoU1++V+qrwrk
	Knw==
X-Gm-Gg: ASbGnctNygrCbSBfOuSYCvFO4hx6kNFDXsj3sRLXlXW3TTIKDDR2+iGDhlnvvjgx8yF
	+GKwVOdpIjFpVMijf1vnew3Pc+XqYdwJjWEK7CB8rtmTBgxKTIF5WD/HSfR0DmiHACIke4l0oiG
	YT5ngETeF7uBFs7WlIN5/gGa2mYIm5kpgjWFc6PwtVMt8OM7+1oDJFpXuWGWd7OkTpflrxuxcdk
	8Myj3FVF+3p4Kil9bWPjtgwndF+XuPoaTt++uh6bfN7VeZC8bgceD03Z3a8Jaw/zp/1qecV3E11
	hQnTNlsEpOyuom+vp0+E/h9k0dk7EP5Hp3gGsI1IaLX6MFFrwTTx+S+YRYH7ICESMJzXzI4XbHq
	E8uwqdF7Q
X-Google-Smtp-Source: AGHT+IGZvDJU9+tAtlsycBXP02hesxekaaYwza1rv5rtMvlFDOpkp1RJUHYf7tILt5e5YH23vYX5tw==
X-Received: by 2002:a05:620a:410a:b0:7c0:ad3e:84a8 with SMTP id af79cd13be357-7c39c4c6ae5mr422994385a.25.1740730808138;
        Fri, 28 Feb 2025 00:20:08 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dacd0bsm217213185a.90.2025.02.28.00.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:20:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.1.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 08:20:04 +0000
Message-ID: <20250228082004.2691008-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021007-santa-thursday-909e@gregkh>
References: <2025021007-santa-thursday-909e@gregkh>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 1bad64f4499a..96b747bf0494 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1700,7 +1700,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback,
+				  struct uvc_control **err_ctrl)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1748,6 +1751,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				*err_ctrl = ctrl;
 			return ret;
 		}
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			ctrl->handle = handle;
 	}
 
 	return 0;
@@ -1784,8 +1791,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
-					     &err_ctrl);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback, &err_ctrl);
 		if (ret < 0)
 			goto done;
 	}
@@ -1925,9 +1932,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2256,7 +2260,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.48.1.711.g2feabab25a-goog


