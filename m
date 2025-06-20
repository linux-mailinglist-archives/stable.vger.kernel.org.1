Return-Path: <stable+bounces-154961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E9AE151E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEB19E4F79
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78721D3E7;
	Fri, 20 Jun 2025 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RuOwsYbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4917583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405295; cv=none; b=eL8CLbQvsc0A5bN9SHdJVl2ESGY/WdnYQaFXBiTS1sqr6j1ehEE+c2nquuzbCzzEhub0kCG+Fahg+5TYdIUFxN5Xpdt4g5o4H5CHMu0e2Wavih0MWidz2d+pjLQXzOXE7dSJPK9v5AIw0o+ELyzVtnFhIQy3OpnpMVrCuvCq0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405295; c=relaxed/simple;
	bh=dn4UuHR1O11zCRVHUTKEmYiBAaLeCRFwFIaZ2EX4EW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uVxDVoGHolNzmGz50WciexdhlCgaxuHbNW/wyYFYJE2rec8WvNY96QbeeoaDLOXMZHy2FLZ8oUOay48QqlmNblitvDALLOMyLoJjpK/Wx7dcZPKOVyHa7+YkNfY1Tv+FpF0CxbGrO5szsZLNo8ZNQvpwwCp+TZncX0uOFWXkNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RuOwsYbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23537C4CEE3;
	Fri, 20 Jun 2025 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405294;
	bh=dn4UuHR1O11zCRVHUTKEmYiBAaLeCRFwFIaZ2EX4EW4=;
	h=Subject:To:Cc:From:Date:From;
	b=RuOwsYbE7MTAYPcQ5MEnRE8f0qrxnmG4cW4lrRQkc7lhcYGsAVHIMoq+Fyi2xPhOF
	 jviqhnEQjbJ/DDpCztrzf+rejFxWAQWORWAQJipWmm8vKTuFTnKWEXf5UgkOm/sK67
	 U2xaMGHjY5vgqinEcdRkPRySHYzHb+LyZswMHYb4=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Return the number of processed controls" failed to apply to 5.10-stable tree
To: ribalda@chromium.org,hdegoede@redhat.com,hverkuil@xs4all.nl,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:41:31 +0200
Message-ID: <2025062031-resubmit-subsector-759f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ba4fafb02ad6a4eb2e00f861893b5db42ba54369
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062031-resubmit-subsector-759f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba4fafb02ad6a4eb2e00f861893b5db42ba54369 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:34:53 +0000
Subject: [PATCH] media: uvcvideo: Return the number of processed controls

If we let know our callers that we have not done anything, they will be
able to optimize their decisions.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e2052130f4c9..0c4d84eab42a 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2101,12 +2101,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
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
@@ -2141,6 +2146,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -2159,7 +2167,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		}
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -2206,6 +2214,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;


