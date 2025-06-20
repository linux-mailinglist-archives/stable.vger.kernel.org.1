Return-Path: <stable+bounces-154962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877CAE151F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38BA5A1BE7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170621D3E7;
	Fri, 20 Jun 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJ0gaGTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AA17583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405303; cv=none; b=PJ9Z6luEmPmLLXSuJrdw8bKPFxio4eJC3ld/eSL4fHJF4FohFlc8HzGwSiJtRdek9ubHQIBCv8DHZaJpthxqcC0gg+anVUzyFXDV+cS31uQ/Zqs1jAZzfk16LDt44JAeVvJm1OX25JW/nO9lhusLUcthxnVcbrCkX51FmNqJiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405303; c=relaxed/simple;
	bh=VNjeBLosErEP4R864N7F4W6FcdPzp3207F/a9eERUFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hGjDdX6EXDQGXfhX4K5CvYlpsduXea6Gv/6nSb7pzTWfmwHlvENAlj+/CIwc/kDG0jxPKu7xIgxyDhz8PhG3aiaOnKa/SLjuQ1TFBqwJ229vmLtQCtiq89j+k2lwD5My6YNFgSZHvSC9fZ4aOivxrac+Minmzh7oDfOw4Ek5Z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJ0gaGTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C902C4CEE3;
	Fri, 20 Jun 2025 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405303;
	bh=VNjeBLosErEP4R864N7F4W6FcdPzp3207F/a9eERUFk=;
	h=Subject:To:Cc:From:Date:From;
	b=LJ0gaGTrhTj9DJGWCnrQEUd4dZFVC65TecddjawcRl2lfJ+HefvBAorG7Iuu09CH7
	 81T5sPpuRf8+XKgKIzgzW+JkoAUEEshZMumzTwfBYtocgBbXdXKQZhufYU0jU+Ixd/
	 q9GXY0hCRrnrTtYZ3BKypy4s7KrMxFfATkTQo6uM=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Return the number of processed controls" failed to apply to 5.4-stable tree
To: ribalda@chromium.org,hdegoede@redhat.com,hverkuil@xs4all.nl,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:41:32 +0200
Message-ID: <2025062032-omnivore-overcook-a17c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ba4fafb02ad6a4eb2e00f861893b5db42ba54369
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062032-omnivore-overcook-a17c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


