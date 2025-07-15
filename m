Return-Path: <stable+bounces-162459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF2DB05E0C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FB71C215F8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAE2E88A6;
	Tue, 15 Jul 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbjN6hmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8882D3732;
	Tue, 15 Jul 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586610; cv=none; b=VZYUtUCNuMmdGpNvgh+e/vessABWvLIsDehgfMvsTpXKx/dm+xWV9ncLmQBx/B8t00jOIHR3jxnmQCfvxAzfZjJooZXq62kybcNWRqQ0zjAsDCY/qU87neFqNRn/xDc3jWc3273H0Snai6c6AJ35oZEoJCny9cCDG/hLq0DuSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586610; c=relaxed/simple;
	bh=q9XqB8NX5V35turgtSVrQI/JWc9lW1K4uk3JdJ/prBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCjoQlhxJmEIEzF5xEDveGr7KFu+avHk7xL738K2p1qCuyOUt51WAOJM2yELS1EVI62/2BoWiAxGjzqqccKqYYN2Jn/SyXDx8nQOlus1LcPSREtysV+Vd8FcPTIV0YPlH5dIBAaUVnl6wTsCX6orjcriqVaPtnxScECBlAZBKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbjN6hmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C1DC4CEE3;
	Tue, 15 Jul 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586610;
	bh=q9XqB8NX5V35turgtSVrQI/JWc9lW1K4uk3JdJ/prBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbjN6hmKrlP4+0BOlFp9gmKtRLvsbNVGTqO1jAflfTvaQNJHigxKSP/d32HuEOnke
	 vowpiMC0QCG4teg7Z4Ey39N/M/j8bcNdFyIMOfW4+mdHizLdjiF/vULEz7dyOEp8SQ
	 wwlrIEI0Z7XJNys+40BdeZOA4f+l9JXhNwtfxWzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.4 103/148] media: uvcvideo: Send control events for partial succeeds
Date: Tue, 15 Jul 2025 15:13:45 +0200
Message-ID: <20250715130804.438435909@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

commit 5c791467aea6277430da5f089b9b6c2a9d8a4af7 upstream.

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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1429,7 +1429,9 @@ static bool uvc_ctrl_xctrls_has_control(
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1440,6 +1442,9 @@ static void uvc_ctrl_send_events(struct
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1638,10 +1643,11 @@ int __uvc_ctrl_commit(struct uvc_fh *han
 					     rollback);
 		if (ret < 0)
 			goto done;
+		else if (ret > 0 && !rollback)
+			uvc_ctrl_send_events(handle, entity, xctrls,
+					     xctrls_count);
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, xctrls, xctrls_count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);



