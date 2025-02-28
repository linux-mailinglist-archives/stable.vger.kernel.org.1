Return-Path: <stable+bounces-119904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E0A49305
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC7D7AA623
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586211E0B73;
	Fri, 28 Feb 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QdnXXRaH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617801D63EF
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730075; cv=none; b=Af8P+N5il3gI4si3HxzuXzk4tNPhGUQZnq0j8H5dQvVRRfjeSq+vBp3EjUQdtCkY3LWsWNuy7qNhQBN0VIpegESxTsDjqlh1Xu8fK5O4f40EG15joejchbYCBEGsu0xh/pLi2pcuZHl9b+LPHc2YsntFMm70JZsOiBeLCjapqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730075; c=relaxed/simple;
	bh=y6lMzBKAU10Yoq8h6KogKxN+QNcSMT+9xEe+AKKGlIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I76lbvT+rbkRayLnhdmzeluwzwNUoiqlWMxNxCWSVse+ZZt5s1xrRTXHW/NSfO3zuYNqv9QTcfsBiFXb69wVNH+e91lsq/YstHgL4iggBypETy/zXy67KGTtdkae+8p1z/DZthnOzGZ1WwzwxOt0ksi4hy29pCYgOFtUkS0DVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QdnXXRaH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0a1677aebso158234985a.0
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740730072; x=1741334872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uf6/MVNeP1pRPosx+fekaa45j3sL06Rcr2OdNGymx4=;
        b=QdnXXRaHW3LHSZvatPim0Ayb4jYagRyu6j8vT8pQqVM7BtqP82r9+cwASikUDr4oAS
         tiEGHHa3c5vz5jJZJW3Ye4kec3e1ecIyDhbCKixtKPdpaMAWbm6KPOMw/o1C3xYuIgYE
         eaQ0JjMLYcR0RJBuxPHQYaObAZy4pJO/tBvyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730072; x=1741334872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uf6/MVNeP1pRPosx+fekaa45j3sL06Rcr2OdNGymx4=;
        b=S8aX/ZujDTro2LTa0uVcYll+x+mTUHq/sxJi+G02I9zWvYZ0ti0YTQQirJ79C6Hkh7
         t3mG4fUmD2sBwS79NhCLF5R3fwZdlHnxZZ04Jb2lcD8vSFDGnetd4wbp9dGxdR6FyclR
         omYp63DAKaqj3RjVtck9gXIcATojVY36PZBsYdXar0m4FngNwkfdlwNpxfZ4y43ANmo/
         l0r2hNB6Br4q8UgWONb43taPKBDfxBdoogLV25VUjDMDdrtuYxPaWPyFtPkRtVdlMklZ
         1CRcE4qXkbil37zl59Hm5t7FOhdkkckDN+nC97HVNVfFKmJBtI799QfEVhK1DIf24Q0Q
         HZ7A==
X-Gm-Message-State: AOJu0YyOXtqpopx1aLkb0d2eK5sL/UN3UmTugzEyprjoqyPI5ZJi4N5t
	tk24E9CVm6KZKzzdNCeYRUaFIoHBjc3TLIHZFqb5OjRCa5Jk3nxr9VSpmoROjy6afurjhzCzLJL
	AfQ==
X-Gm-Gg: ASbGncvA7Jo29COhpV5JFI9bQOMWAEQq00S3PTf/dd8RTKLwL8sKEtQauL9TLHlXx7R
	hkWzAgaRdczPU3eqBwsZ14JsJLk+YONQ47m66onx8w9g2bhYc8ahVQeOUTF2f/CRa7OhjEyV7VJ
	zhVMd93ppCWsIyrb4KTPy8nDrFN0yCh3atBZXGLNueODPoJ+qLsNBNViC/I+CxhdQ0P/zRdb9k0
	izNZ9HkkFPrUZW4ARPCCSIigaKj/ZkmxFe91c0Z6CttL3BVS6hgIiAnwMZSl8/U1r+4Rp/cjszy
	6vMfpDHuzkEYVw3aASIAbMySezGlrfkS4LE2j4KeaHC5DGlLpX4BbU5uzxXK0gIWWbmIqK1CBaz
	cMW3q2UeQ
X-Google-Smtp-Source: AGHT+IEzlfYDHW+gKB1rN4YNYELwdO2KKXKWFvMqsA3etRzU7CxOBwbChRg9whoJe1A/myvCBjK8XQ==
X-Received: by 2002:a05:620a:170f:b0:7c2:4ccf:f9d6 with SMTP id af79cd13be357-7c39c4995d4mr372646885a.10.1740730071976;
        Fri, 28 Feb 2025 00:07:51 -0800 (PST)
Received: from denia.c.googlers.com.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36feea125sm217943285a.12.2025.02.28.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:07:50 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4.y] media: uvcvideo: Only save async fh if success
Date: Fri, 28 Feb 2025 08:07:46 +0000
Message-ID: <20250228080746.2658174-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <2025021009-blazing-throwback-e62a@gregkh>
References: <2025021009-blazing-throwback-e62a@gregkh>
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
index e3457449faae..9fc84f0ac047 100644
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


