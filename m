Return-Path: <stable+bounces-162900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A027DB06092
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D9C1C474E5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083162ECD2A;
	Tue, 15 Jul 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zjgOpJEF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9E1531E8;
	Tue, 15 Jul 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587769; cv=none; b=kL0pD5PPiCwnUUqRX0MiZjnyMMbsSMPxDzo0zzgrdPMiPSX+3u17nV9DXcXc8zQhOOUThP6wiVurFW7EUympe603NSIvGuw+mpYs866b/odVgTI5GrjdKt3On92Yd0BxWIbc0jNMHcRbcYFu/wj725PImFp8XE6DWj6Za/phRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587769; c=relaxed/simple;
	bh=gQZj7yo1QvvzJGGgESfCoo12k2x1wr5+gZCBl+gXa3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYybxf474RYK/7X4nkVw1QFaM485xBVnwdsvhXPaK1Z9eK8mE2tUUG1iyh2hD4eIQ0oXk6JGV8RGN+rZ3KSZE8y3txH2G/EdGs0GU7On4RZdTevWigIw72v8bdpv+7FFUYDOXtKRICmMTKEExvhJKMx/YOpRVtIYUcKsBhuwOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zjgOpJEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB84C4CEE3;
	Tue, 15 Jul 2025 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587769;
	bh=gQZj7yo1QvvzJGGgESfCoo12k2x1wr5+gZCBl+gXa3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zjgOpJEFMEzpiDxmW0G6h8nk85cjs4dugyi89iCSxPBSkHFShoMRWVAUmR7kqRDB3
	 h/Yv5rD8iaEkSd8t5xOEGV+34XJosdaOCnEQC7aqF2/vfvNg+8b30g/bno0AE0V6ch
	 aJ3Zhw3/tWoySPVCNxM2odac2OwZvdf7He7+o3zE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.10 129/208] media: uvcvideo: Return the number of processed controls
Date: Tue, 15 Jul 2025 15:13:58 +0200
Message-ID: <20250715130816.108222038@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

commit ba4fafb02ad6a4eb2e00f861893b5db42ba54369 upstream.

If we let know our callers that we have not done anything, they will be
able to optimize their decisions.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1560,11 +1560,16 @@ int uvc_ctrl_begin(struct uvc_video_chai
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
@@ -1598,6 +1603,9 @@ static int uvc_ctrl_commit_entity(struct
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1613,7 +1621,7 @@ static int uvc_ctrl_commit_entity(struct
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
@@ -1634,6 +1642,7 @@ int __uvc_ctrl_commit(struct uvc_fh *han
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, xctrls, xctrls_count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;



