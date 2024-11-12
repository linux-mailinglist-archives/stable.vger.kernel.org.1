Return-Path: <stable+bounces-92284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559489C5507
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE8B33B50
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5621441F;
	Tue, 12 Nov 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqslLzg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EA214415;
	Tue, 12 Nov 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407154; cv=none; b=lunDjkHWgLUsrqhns9L5STi3wbJwLuHQqQZIrIHGNH4TgcXoqPgvqug7lS3rJnvgXZSnc2943PAiFEkSeJdtT2cYPbPmBWAvcLB7nFP3/7S2GP4yG/KTS4vcIggfwhUHirdhRTz1v7DLVB46l7UxvdMrkIl9SxzJSUJPLtUYhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407154; c=relaxed/simple;
	bh=13V1uvSG3yyHlip6Or4DeDxAz8UAr9jjNEVJBdLx5Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pejB6bQmvBmEx1YZzljavA+9kiOY/c3ROCPAt7KKgJjv8170T2q9QCy2wbkI3vUCJ8JMbzOq8MM2eofcT78VS9Gj3vEMnRNH5kYNzJcK8ADKLVpm+tDowUyYn4v46O/0J4gc964HaWzjmjU5DD4wLAVwekDHt86FAlsziy5Vj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqslLzg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110CBC4CED4;
	Tue, 12 Nov 2024 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407154;
	bh=13V1uvSG3yyHlip6Or4DeDxAz8UAr9jjNEVJBdLx5Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqslLzg2pzdUhDmnHOdHwBX0IECyo3Ht+Fcv35f9JSDkdttNslLjHNArpqNP8U145
	 6v5BPXuW/wZaXqorUbdH2d26HAg4dWCLjtaM7LGouk116PAw2j1MFuPPckblGeht3B
	 /Wq9feTdE+NPxaVtqeznpum8DtIQnrT2Qtf19FzI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benoit Sevens <bsevens@google.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 59/76] media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format
Date: Tue, 12 Nov 2024 11:21:24 +0100
Message-ID: <20241112101842.028586366@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benoit Sevens <bsevens@google.com>

commit ecf2b43018da9579842c774b7f35dbe11b5c38dd upstream.

This can lead to out of bounds writes since frames of this type were not
taken into account when calculating the size of the frames buffer in
uvc_parse_streaming.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Signed-off-by: Benoit Sevens <bsevens@google.com>
Cc: stable@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -645,7 +645,7 @@ static int uvc_parse_format(struct uvc_d
 	/* Parse the frame descriptors. Only uncompressed, MJPEG and frame
 	 * based formats have frame descriptors.
 	 */
-	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
+	while (ftype && buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
 	       buffer[2] == ftype) {
 		frame = &format->frame[format->nframes];
 		if (ftype != UVC_VS_FRAME_FRAME_BASED)



