Return-Path: <stable+bounces-114663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B324A2F101
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9864A3A7EF1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB582309BA;
	Mon, 10 Feb 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CuJ25ZYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E36252908
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200330; cv=none; b=W9JzyiJPsIu3KBeM556gaqvkoybZi3FU00Ig3p08RDRakhx7HuMrLhMCG+CVJ5RYdzRHkeqBPbF14sDa4boA6uet79Yxyl/GRI5MkTrKeRQGWwwwJ9Qu7cTIe7SKJvPaFB4l7N9gtnPwC1h8R/mU4SHQll8VZpMrXyYDR1W3j64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200330; c=relaxed/simple;
	bh=jpwG68JyZLLk2SK82wLDF74rGRU21EDzBEuCGi5tY/c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kcvb1ogtreZGCYCRu4VrQCEmIl2ievKqvmeBPzXNSXohFUVUkuCR9NdZ7YAjFjDRKrO3P9OqAyXbF4ILLxVePQTwqc++37fCnQshrUEzfEtD1HmCynC+gGafrFt6asFn9CeJWfcX2Rb5BS7Xv3hzZv/sOuNIjkz4Ukd1jdOTG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CuJ25ZYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52540C4CED1;
	Mon, 10 Feb 2025 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739200329;
	bh=jpwG68JyZLLk2SK82wLDF74rGRU21EDzBEuCGi5tY/c=;
	h=Subject:To:Cc:From:Date:From;
	b=CuJ25ZYDV0RkXh0AGqEzCP/JG+QjT0e3spcF4OLQZEZXJ1doxWAVtQ8roYqfNXojo
	 bpNJwDE6mRqrfx9rd2pma13mVpcwKuJVz+eet+A+eiC0884I9J2Q/361auzyIp973b
	 MI66Wyx1ZyQLLAKQ2Tt9EseWRkh9e5IRlkW7NGpA=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Only save async fh if success" failed to apply to 6.6-stable tree
To: ribalda@chromium.org,hdegoede@redhat.com,laurent.pinchart@ideasonboard.com,mchehab+huawei@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:12:06 +0100
Message-ID: <2025021006-sharpie-patchwork-f168@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d9fecd096f67a4469536e040a8a10bbfb665918b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021006-sharpie-patchwork-f168@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d9fecd096f67a4469536e040a8a10bbfb665918b Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 3 Dec 2024 21:20:08 +0000
Subject: [PATCH] media: uvcvideo: Only save async fh if success

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

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index bab9fdac98e6..e0806641a8d0 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1811,7 +1811,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
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
@@ -1859,6 +1862,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				*err_ctrl = ctrl;
 			return ret;
 		}
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			ctrl->handle = handle;
 	}
 
 	return 0;
@@ -1895,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
-					     &err_ctrl);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback, &err_ctrl);
 		if (ret < 0) {
 			if (ctrls)
 				ctrls->error_idx =
@@ -2046,9 +2053,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2377,7 +2381,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
 		if (ret < 0)
 			return ret;
 	}


