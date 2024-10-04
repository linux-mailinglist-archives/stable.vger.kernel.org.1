Return-Path: <stable+bounces-80844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D24990BC2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696D6282214
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBEA1E96E5;
	Fri,  4 Oct 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlOvd+se"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5F1E3DC0;
	Fri,  4 Oct 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066033; cv=none; b=Ha86vLuAqeQoIyn0KTXSU8a59Hpec43FITm84L960tmgZqYVbE+KwUpOVhyz3OeeIRcZPBQs03HnmVROm7RmGRlPNl1vwi8JHTsp70ih4W+pDYb6iVhVJv1Y/e+gFrLWjGM8vNyy67UiriMnjG5AY3Jm3fXtYFGX6n6NI+VAsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066033; c=relaxed/simple;
	bh=9v4AkEzJHgd60Poe0PjrYbXzP1mJjJjuDEM+8aex0fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEPE7HWEJ90UsEMWnKllnekpfxLV+Gq6q8AatzKulIZtn2uu8JY5NQ1+Skqcw0b5UvUlsQ/i2zPeB7LprORj++/6zMaklTYsfCAyCb2wsyNT6i9Xq6AbytjJR5KZl24uV/sfNJWV3kcE0RJwpteAjjTdi7V4iCSxDB8SmCddMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlOvd+se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503DC4CECC;
	Fri,  4 Oct 2024 18:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066033;
	bh=9v4AkEzJHgd60Poe0PjrYbXzP1mJjJjuDEM+8aex0fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlOvd+seE/zxopZeBho4z4F0+6R87Spi13bq0yv6iGmq+KmAQGvCimowOUVxt1Vib
	 hOSpAtBwrwrV2veYQyvbHb2XHzT4Sliqn5Wes/0V6fpIy/KlfU4jEoNMwb4W9X0jx+
	 5AWI/5JOnGubWX5s5qHtlfd+FL+ISR4r1oSRM8wYNP97EL5E5G9NkpRdIj+yO5a36h
	 FhnUCvkYa7dQZligMcl6slJv14ppD11XrvBXJlXEjgLqHI0irz1RN3IO3liOhqfv7x
	 Go9IJjV2+vBKvvtzzOtb5GTzjDFVe1aQfUeXJQinQ2qxvaq4Z/2IE0cDNNOnEX94Hm
	 8C6qxGnC9gzwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	arakesh@google.com,
	m.grzeschik@pengutronix.de,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 64/76] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Fri,  4 Oct 2024 14:17:21 -0400
Message-ID: <20241004181828.3669209-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


