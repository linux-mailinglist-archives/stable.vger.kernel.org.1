Return-Path: <stable+bounces-154954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E37AE1517
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F693A9384
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997017583;
	Fri, 20 Jun 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAG1mKYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E5220F3B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405231; cv=none; b=i13HqMRivvSxBYgxPL1tCcuF6UX/zZ5LElgKN84Wd/35wdDSKAU8ypI12Bz+sLzJg9eQ/6ScLPw94rst0FvTRi3Dy3lcDfiIsaue4fBD1TkqIMLcvDRyAH2zh9DoBLx+81nlV5lfKFt4Rs2CYjhUXjZzREWWuqj2oAdcL9NKunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405231; c=relaxed/simple;
	bh=y3XVSLEgY2wXP8bKFiPCeCfCylaCJwM6RnQGODXvAnM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RCR25JCiWiOPUGP0Yn8+UqAS+fZ6UQQ1Vu3ur0hteX/ngKYPhufTwksZtIZJdrXJ7p3XnHP0zzm15fZxzbKDyXcNPVWYSC2/i3DAT4ZY6ODZV9G0GdbkFN3imjRKuZ07OoZpT2EwzGYT6HroYVy2mXx2IzGMmn/CPxxnOv3NnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAG1mKYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1367C4CEE3;
	Fri, 20 Jun 2025 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405231;
	bh=y3XVSLEgY2wXP8bKFiPCeCfCylaCJwM6RnQGODXvAnM=;
	h=Subject:To:Cc:From:Date:From;
	b=cAG1mKYSW0q3FHR4/KEOYkpOrc5j4J2pfvxR3+6PbckJ0l7K5yDcY0Wxsi9teqzhn
	 7B+QGlm7YrSdjvIs2wuRWAZW4rSLBsQ48wkaxg+CV8XLRetEiaWjJLIIbhvsh9iJ7M
	 Ks7OLa+j4AYgsvWHsQVQafMRzbzDqPofCBzgHNAU=
Subject: FAILED: patch "[PATCH] media: imx-jpeg: Drop the first error frames" failed to apply to 5.15-stable tree
To: ming.qian@oss.nxp.com,hverkuil@xs4all.nl,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:40:28 +0200
Message-ID: <2025062028-nylon-scoff-dcd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d52b9b7e2f10d22a49468128540533e8d76910cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062028-nylon-scoff-dcd4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d52b9b7e2f10d22a49468128540533e8d76910cd Mon Sep 17 00:00:00 2001
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Mon, 21 Apr 2025 15:06:12 +0800
Subject: [PATCH] media: imx-jpeg: Drop the first error frames

When an output buffer contains error frame header,
v4l2_jpeg_parse_header() will return error, then driver will mark this
buffer and a capture buffer done with error flag in device_run().

But if the error occurs in the first frames, before setup the capture
queue, there is no chance to schedule device_run(), and there may be no
capture to mark error.

So we need to drop this buffer with error flag, and make the decoding
can continue.

Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 1221b309a916..840dd62c2531 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1918,9 +1918,19 @@ static void mxc_jpeg_buf_queue(struct vb2_buffer *vb)
 	jpeg_src_buf = vb2_to_mxc_buf(vb);
 	jpeg_src_buf->jpeg_parse_error = false;
 	ret = mxc_jpeg_parse(ctx, vb);
-	if (ret)
+	if (ret) {
 		jpeg_src_buf->jpeg_parse_error = true;
 
+		/*
+		 * if the capture queue is not setup, the device_run() won't be scheduled,
+		 * need to drop the error buffer, so that the decoding can continue
+		 */
+		if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx))) {
+			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+			return;
+		}
+	}
+
 end:
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 }


