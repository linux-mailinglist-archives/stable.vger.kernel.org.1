Return-Path: <stable+bounces-80914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BA1990CAD
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA45E282447
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E621F419;
	Fri,  4 Oct 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDcN2Gky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AE21F410;
	Fri,  4 Oct 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066235; cv=none; b=fEMXQoiDoQojF209EQHJSOYYZ/YphJvG6wo+3Otc3pQdM3O+VO3a2qM5sERvD/HkP/uu9BVLOg10+zAc4F/aoqPObXJrfxqHYME0ZhCpUV+M7XYQrKBOF0FEPqg+C6GmTK4polIvik1NbP3G0awkyZR7vht3ZH4+Jw0IVxYNY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066235; c=relaxed/simple;
	bh=9v4AkEzJHgd60Poe0PjrYbXzP1mJjJjuDEM+8aex0fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQgTUP5/OuSt015+yHf1eD3lWpFzVvm43P4c0Sahqr9FsfeKf6PbiHldSe5uKKFTXfTV2vfj/bjmLrdCaz43dz7h/KAaWsBypyWNFP5tD7Xl318xAqCOjrklbGJ5R5JFKSsZyVlC2YzcIrvQ/e5rw1/lso3p9JsVAYdV58Th42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDcN2Gky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D50C4CEC6;
	Fri,  4 Oct 2024 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066235;
	bh=9v4AkEzJHgd60Poe0PjrYbXzP1mJjJjuDEM+8aex0fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDcN2GkyaPKSLq1XPzOriMrLuVZtmJEolY+ZL0cY/rqvYqrDfEauk9f0CDCpkXSr1
	 E/vmxCKjeAnW22pGQTVcdCv4OlbEP79uDjx02fDl00IbJu9RNsoHDrLMW/HzVz7JEx
	 nGIIMKRSyrmJD/Ps2O9wdx4Rrj4yfjsR7b9ioYgKb4k9wW4/4PZFHMyYRKNCzWMao3
	 +KRONDgWpU4M6PoAFOzQUWCmKdHfQLTtjNlMuupv0mSCmL9zaQssl30ykHv1yE4oc3
	 yO8ZQwZQq6dPpeyx9oXTO7IDwj3fvHnOgV9uQfje0m53ZzjZ1P5L+ETn68YoRBiXgl
	 HYoRdIm40K9vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	arakesh@google.com,
	dan.scally@ideasonboard.com,
	m.grzeschik@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 58/70] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Fri,  4 Oct 2024 14:20:56 -0400
Message-ID: <20241004182200.3670903-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Abhishek Tamboli <abhishektamboli9@gmail.com>

[ Upstream commit a7bb96b18864225a694e3887ac2733159489e4b0 ]

Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
and uvc_v4l2_enum_format().

Fix the following smatch errors:

drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
error: 'fmtdesc' dereferencing possible ERR_PTR()

drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
error: 'fmtdesc' dereferencing possible ERR_PTR()

Also, fix similar issue in uvc_v4l2_try_format() for potential
dereferencing of ERR_PTR().

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
Link: https://lore.kernel.org/r/20240815102202.594812-1-abhishektamboli9@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_v4l2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc3..de1736f834e6b 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
 	list_for_each_entry(format, &uvc->header->formats, entry) {
 		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
 
+		if (IS_ERR(fmtdesc))
+			continue;
+
 		if (fmtdesc->fcc == pixelformat) {
 			uformat = format->fmt;
 			break;
@@ -240,6 +243,7 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	struct uvc_video *video = &uvc->video;
 	struct uvcg_format *uformat;
 	struct uvcg_frame *uframe;
+	const struct uvc_format_desc *fmtdesc;
 	u8 *fcc;
 
 	if (fmt->type != video->queue.queue.type)
@@ -277,7 +281,10 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
 		fmt->fmt.pix.height = uframe->frame.w_height;
 		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
 		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
-		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
+		fmtdesc = to_uvc_format(uformat);
+		if (IS_ERR(fmtdesc))
+			return PTR_ERR(fmtdesc);
+		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
 	}
 	fmt->fmt.pix.field = V4L2_FIELD_NONE;
 	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
@@ -389,6 +396,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 		return -EINVAL;
 
 	fmtdesc = to_uvc_format(uformat);
+	if (IS_ERR(fmtdesc))
+		return PTR_ERR(fmtdesc);
+
 	f->pixelformat = fmtdesc->fcc;
 
 	return 0;
-- 
2.43.0


