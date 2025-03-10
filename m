Return-Path: <stable+bounces-122784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65705A5A12D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A384A173A79
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA75231A2A;
	Mon, 10 Mar 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aa5e3URM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3F22ACDC;
	Mon, 10 Mar 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629490; cv=none; b=j6JC1tPR1SqOK/J4X2brb48jtUbWjdMDTUSuHkRk4hj4Mv+O7jco0m82ZiUNeYuqkau2HmYjXb/4f9ZHw9hcdMqUzo/YB2LJzvj+3kttQ14D91QTrYFGmLXS3WsvLq2JEhxb7WsZ5emjVO1wsVIambp8qBnw0cq4XlYGEIhbZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629490; c=relaxed/simple;
	bh=8OcxT9Fsd9Iqs9ZtWJBgtNo1i808diXOEMQveXIpEH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og1iPax+hBQqNoSQqNahL1epCqpBj05Ubj3zqDThMtEZWZr+R7VOQ1Q6qAnlnfYrNnE8HULWKCMj06HqEfSjppYwGiHYfhM/EyONVISCnot5Ac7xljYApE+Oz+BJgIgiMh5r4m3mbGOmFmTjBrKXKiY0lf+CQfPhkelvoju/9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aa5e3URM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F06C4CEE5;
	Mon, 10 Mar 2025 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629490;
	bh=8OcxT9Fsd9Iqs9ZtWJBgtNo1i808diXOEMQveXIpEH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aa5e3URMqIFfnJmOGxCgo0YM7yrimP1RS2rV5LWPb20Ga7qIEMbZqG40xvJ3Sezxx
	 /PPrrwjaBEXBoTvrGixNIq4BHxd2aDuEdZ34ZkIW1XrRDN0dYvU97YwKLNELJ0kGUg
	 DCeWHDrxr6l9sGR+A/ixFcHbGN1qPOHl8UWFwuo8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15 311/620] media: uvcvideo: Fix event flags in uvc_ctrl_send_events
Date: Mon, 10 Mar 2025 18:02:37 +0100
Message-ID: <20250310170557.894173289@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

commit c31cffd5ae2c3d7ef21d9008977a9d117ce7a64e upstream.

If there is an event that needs the V4L2_EVENT_CTRL_CH_FLAGS flag, all
the following events will have that flag, regardless if they need it or
not.

This is because we keep using the same variable all the time and we do
not reset its original value.

Cc: stable@vger.kernel.org
Fixes: 805e9b4a06bf ("[media] uvcvideo: Send control change events for slave ctrls when the master changes")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241114-uvc-roi-v15-1-64cfeb56b6f8@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1511,13 +1511,13 @@ static void uvc_ctrl_send_events(struct
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
-	u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 	unsigned int i;
 	unsigned int j;
 
 	for (i = 0; i < xctrls_count; ++i) {
-		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
+		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;



