Return-Path: <stable+bounces-154963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B6AE1520
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C694A4955
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806CA21D3E7;
	Fri, 20 Jun 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjbL1yLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9917583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405313; cv=none; b=AvmOt2tUwFS7sVN61kzSU0M4+O6+np1S5pBjsWkHXw8BIdT2u+Dklwid46uKiuCbKatsW1HPWfkO968hRuFmdQLBayqChzYEdkumkTV+Ca21741ck7fS62s59VOX9+dKapSRBfBvnvFTV1bxEhgQry3e8LlwU06kGwPhGhdQPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405313; c=relaxed/simple;
	bh=0QqVdJjDLmp4+Snqxca3NfYWVnKoV2FHwNv9qUmo3kQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JHrTIP5tBVyBgA+fZHdCwqeMM8ETk7eQkiYW9LmAZzJYMR5KxSbBNv33TEy2PB9sr0EfrLUF+2ctmLRbjMsZ2/KKASYY1QOBgV2VGaGkyrdnHG8kh9JecMvlY0aeisnRd8+WIushQp3YMqduelcoEzm3Pcq93bLp5vvp4nytsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FjbL1yLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B557CC4CEE3;
	Fri, 20 Jun 2025 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405313;
	bh=0QqVdJjDLmp4+Snqxca3NfYWVnKoV2FHwNv9qUmo3kQ=;
	h=Subject:To:Cc:From:Date:From;
	b=FjbL1yLtr5KzJcaQ4ewX7ZjXmMXxwcILfJwpMKr7F9Jz50ZATO5ak2q9e30S3GyXw
	 P0rZirtzzQRFWhphcF7ysBpqqXSf4puFwWr0FMhi/YEmKIcICeDStNQYuD6tIkRXa6
	 rSNMX54LtirIOzpV5t8vydIChthO6DTKV6pzznro=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Send control events for partial succeeds" failed to apply to 5.10-stable tree
To: ribalda@chromium.org,hdegoede@redhat.com,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:41:50 +0200
Message-ID: <2025062050-overpower-democrat-9d5e@gregkh>
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
git cherry-pick -x 5c791467aea6277430da5f089b9b6c2a9d8a4af7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062050-overpower-democrat-9d5e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c791467aea6277430da5f089b9b6c2a9d8a4af7 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:34:54 +0000
Subject: [PATCH] media: uvcvideo: Send control events for partial succeeds

Today, when we are applying a change to entities A, B. If A succeeds and B
fails the events for A are not sent.

This change changes the code so the events for A are send right after
they happen.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0c4d84eab42a..636ce1eb2a6b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1954,7 +1954,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1966,6 +1968,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		s32 value;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -2209,11 +2214,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);


