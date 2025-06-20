Return-Path: <stable+bounces-154966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB2AE1526
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15D37AF148
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A321D3E7;
	Fri, 20 Jun 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cL2Z1lJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265E17583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405346; cv=none; b=vCEKhrPm8NbHwgFtHaaaVdyR5qj5Rjn1Md4HqngrzhFFOKOhyAQkuJ+zjxtjaNLpU1b9Hle6oHLxT3d9qa9SvazjtWIHh/Js2Y46uUQiHi2dEExQALzcSawXV1SuYoHTi4OIRUlv0lQF6MdcxI4NJ5ezHJSALy6pajlCmoj6heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405346; c=relaxed/simple;
	bh=2neaJxqmljkMhhrYQkDab2KrEzTveLlPlqfDMP5tcuM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L2d0YbVGiKFP12Ucr25pE7KgalE1MHDANeFd9Q2jlHWFdEpGqJYsOhtYG4kUqeuFHNYrzjwMvm8QWJNVj2FsV4qGU/aufnfgplpkqz+VLjx6RIyX4UTkrPGVwFRELNipNdvzFRifhGfMKUnlpaIg92XYV8AKQG/w2iOuzbR+/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cL2Z1lJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C71CC4CEE3;
	Fri, 20 Jun 2025 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405345;
	bh=2neaJxqmljkMhhrYQkDab2KrEzTveLlPlqfDMP5tcuM=;
	h=Subject:To:Cc:From:Date:From;
	b=cL2Z1lJ8p0Zz8//ifTS+ZQRLNXFYvS3bu8fUUckpDh1Snlqw9Q/rm4iQ2LO+sGFCK
	 nFJhKnWzlqk0jLFoQBqGUPSFBA0YdCv9Jww2qXn14eyd9XDOmhHgBVXWtI5DV8h5LZ
	 9FL7nYAmC1ANcRIq7YtNVoSsBLSq8NoUG2KIF+f0=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Rollback non processed entities on error" failed to apply to 6.12-stable tree
To: ribalda@chromium.org,hdegoede@redhat.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:42:14 +0200
Message-ID: <2025062014-afternoon-selector-f71a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a70705d3c020d0d5c3ab6a5cc93e011ac35e7d48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062014-afternoon-selector-f71a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a70705d3c020d0d5c3ab6a5cc93e011ac35e7d48 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:34:55 +0000
Subject: [PATCH] media: uvcvideo: Rollback non processed entities on error

If we fail to commit an entity, we need to restore the
UVC_CTRL_DATA_BACKUP for the other uncommitted entities. Otherwise the
control cache and the device would be out of sync.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Closes: https://lore.kernel.org/linux-media/fe845e04-9fde-46ee-9763-a6f00867929a@redhat.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-3-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 636ce1eb2a6b..44b6513c5264 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2119,7 +2119,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -2148,8 +2148,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -2165,13 +2163,20 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			ret = uvc_ctrl_set_handle(handle, ctrl, handle);
 
-		if (ret < 0) {
+		if (ret < 0 && !rollback) {
 			if (err_ctrl)
 				*err_ctrl = ctrl;
-			return ret;
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
 		}
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -2202,7 +2207,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -2213,17 +2219,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 				ctrls->error_idx =
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
-			goto done;
+			/*
+			 * When we fail to commit an entity, we need to
+			 * restore the UVC_CTRL_DATA_BACKUP for all the
+			 * controls in the other entities, otherwise our cache
+			 * and the hardware will be out of sync.
+			 */
+			rollback = 1;
+
+			ret_out = ret;
 		} else if (ret > 0 && !rollback) {
 			uvc_ctrl_send_events(handle, entity,
 					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	ret = 0;
-done:
 	mutex_unlock(&chain->ctrl_mutex);
-	return ret;
+	return ret_out;
 }
 
 static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,


