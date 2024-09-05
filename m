Return-Path: <stable+bounces-73480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E17496D50B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86A21F2723D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F150194AC7;
	Thu,  5 Sep 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17ZhzkB/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90883CC8;
	Thu,  5 Sep 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530370; cv=none; b=Uzr14771+0iS1LDSdvOxs6oNr2Y37Oa3DrPFbQLe+nmNANZ6ebpoqWd7Y2OKIghZmlhY8eOfRBUmxeZkFYwg1Qfagw16w2reE9sTlQn3OdF5d53LigkV4Ixbxq/EX/gJfWhjNXROtnIdj9/+ivusj/AzV/hc7YvoGgJOlRRpdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530370; c=relaxed/simple;
	bh=9mkBVQNwB1dlCJc3zzPHRf8qjOXkMrNcc0ofvS/MOnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxt3/FwClELh/HF8x/pXcObaaCwxkd7lX/OeZoK+2hEEe3JZbJ8FWu0ONZUlsD7UC51xyriCBDYsA+yX9gZGVezxI1KblxVT4WJuas9TP0FFSRblR7tv+7azV9LvSRCnESh6gNEa0+MznfJgylkSU4vMOPfcMdwRl+Pj0J3TTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17ZhzkB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4926DC4CEC4;
	Thu,  5 Sep 2024 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530370;
	bh=9mkBVQNwB1dlCJc3zzPHRf8qjOXkMrNcc0ofvS/MOnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=17ZhzkB/+5PcUKasZnpOsDI3hsVTJS5USt/kqaHV6qOSgmXj8dYcn4EHq9VfVFF4/
	 o8IRw2h414BXUtBbIvitH5WwTN0Kthn5L7S1+C7yGSXgKtSqJ5/CFZ9xSPsqegDl09
	 qd/g6tlNpCtp1IDv/+kd7OvnQpt9Vz0WB2qQ2eGI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 129/132] media: uvcvideo: Enforce alignment of frame and interval
Date: Thu,  5 Sep 2024 11:41:56 +0200
Message-ID: <20240905093727.228538625@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit c8931ef55bd325052ec496f242aea7f6de47dc9c ]

Struct uvc_frame and interval (u32*) are packaged together on
streaming->formats on a single contiguous allocation.

Right now they are allocated right after uvc_format, without taking into
consideration their required alignment.

This is working fine because both structures have a field with a
pointer, but it will stop working when the sizeof() of any of those
structs is not a multiple of the sizeof(void*).

Enforce that alignment during the allocation.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240404-uvc-align-v2-1-9e104b0ecfbd@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 68bf41147a61..04e7f58553db 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -687,16 +687,26 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 		goto error;
 	}
 
-	size = nformats * sizeof(*format) + nframes * sizeof(*frame)
+	/*
+	 * Allocate memory for the formats, the frames and the intervals,
+	 * plus any required padding to guarantee that everything has the
+	 * correct alignment.
+	 */
+	size = nformats * sizeof(*format);
+	size = ALIGN(size, __alignof__(*frame)) + nframes * sizeof(*frame);
+	size = ALIGN(size, __alignof__(*interval))
 	     + nintervals * sizeof(*interval);
+
 	format = kzalloc(size, GFP_KERNEL);
-	if (format == NULL) {
+	if (!format) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	frame = (struct uvc_frame *)&format[nformats];
-	interval = (u32 *)&frame[nframes];
+	frame = (void *)format + nformats * sizeof(*format);
+	frame = PTR_ALIGN(frame, __alignof__(*frame));
+	interval = (void *)frame + nframes * sizeof(*frame);
+	interval = PTR_ALIGN(interval, __alignof__(*interval));
 
 	streaming->formats = format;
 	streaming->nformats = 0;
-- 
2.43.0




