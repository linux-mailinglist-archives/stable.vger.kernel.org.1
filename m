Return-Path: <stable+bounces-154967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19280AE1525
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A277419E5131
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C66226CFB;
	Fri, 20 Jun 2025 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wa5bqqZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504817583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405349; cv=none; b=OPL/T+QhLZjIv3WkxLpgcawStUffLUloq1GcI8VgZCk1eR8+pcjmoM4bDPcvjq2c2belOoczf9jvwsJdpkLX/6Gc4Z1PrRs5tkX+Awk3PCRRn5phmp1xMJ0U3QsVh3g7BtLpfI+jB0gFDlPXW4L1H1OPYAvhcgPs7d/cvgWQfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405349; c=relaxed/simple;
	bh=/bqsAtvLVzQh3cLI2rX3po/KV5EdKGZ1UzogxyceTlo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ECKPONd2oHqhxXdRNkRQytzbDKrwz3VwkymAdNto15WwmCXXv7n859pEcyc8d2RzctMF6nBHJyDTj2NAgtw9MQDsyqrAnSMp8C1T4bTnQpZBuaniCauZsk5FMGg8kGNCzTsJv+HfZUM3kZDnYyIUujA7fDTY4izb/9LorH6Ma+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wa5bqqZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E93C4CEE3;
	Fri, 20 Jun 2025 07:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405349;
	bh=/bqsAtvLVzQh3cLI2rX3po/KV5EdKGZ1UzogxyceTlo=;
	h=Subject:To:Cc:From:Date:From;
	b=wa5bqqZJnhqUns9zBcbuM0GspjhBXRk242bW+ezxd1RjtZV3vug0Cj/DBgve3fpPC
	 HN/eNO0FbYjNAzKrb2WVBBPcWO7OTc/OS5R71SKNC/WPC2NvGIlqBtLM0V0HKJyBzs
	 MLJcSBoZiNhQUDoHPytLrPDlEYlltGnRJiPax00A=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Rollback non processed entities on error" failed to apply to 6.1-stable tree
To: ribalda@chromium.org,hdegoede@redhat.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:42:15 +0200
Message-ID: <2025062015-vocalist-panning-1ddc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a70705d3c020d0d5c3ab6a5cc93e011ac35e7d48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062015-vocalist-panning-1ddc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


