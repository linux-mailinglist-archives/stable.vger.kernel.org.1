Return-Path: <stable+bounces-66796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57194F27F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14331C213AC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128EE187323;
	Mon, 12 Aug 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qv8w/DdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B5186295;
	Mon, 12 Aug 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478812; cv=none; b=Oa7OjDRcIQVOOdy0XrwVGAm9UB/3iMClmZp/ERYQ1UiQ7FT0rhKbP3UxCaaR8g9Rp1nNpp+UH1Z8sf0+sQJH9qfJxEj11k3f6XOsOwvq3LheZhehn0lbHVi3abr/KHuf3xytj2SuhwrdZwZMmugEtCbGAWlkElUtQfvizA3trUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478812; c=relaxed/simple;
	bh=l4RjxHvlqw4wsNv04P+2k9phZOvQFfS6tcxbepelE3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiIEh/hYl/A+cC5HslUNFh/VEUvx+fTDAvPPyQaBRP64/uV2h71bzd3UtQ3vNCPoVoHNfvInp9dPFaOoJgmArXmXbpsOoXHgnqO1sE45ykgZGV8AZdv/KSOmPKjWSdwarhY7BHd+Cqlwim8e138hweckfGi0beAPVmmnSCFwWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qv8w/DdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480E2C32782;
	Mon, 12 Aug 2024 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478812;
	bh=l4RjxHvlqw4wsNv04P+2k9phZOvQFfS6tcxbepelE3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qv8w/DdJgOvYu+QtkeO4G1NzYvNrPXnx5SzNeUZ6BE8sOHtsK6Ute1Zlxw7+9Gr8K
	 1PfeUG8JPMFDECwbfljGRfDLdDgNlr6cbtRC9G9UIfgCw2ZaCKiFzMbLFkt/8hL+yZ
	 cg/BQcOLrerIUKPi2DFGWJcHiWT0otIWQLzZlfyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Pecio <michal.pecio@gmail.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 044/150] media: uvcvideo: Fix the bandwdith quirk on USB 3.x
Date: Mon, 12 Aug 2024 18:02:05 +0200
Message-ID: <20240812160126.865955328@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 9e3d55fbd160b3ca376599a68b4cddfdc67d4153 ]

The bandwidth fixup quirk doesn't know that SuperSpeed exists and has
the same 8 service intervals per millisecond as High Speed, hence its
calculations are wrong.

Assume that all speeds from HS up use 8 intervals per millisecond.

No further changes are needed, updated code has been confirmed to work
with all speeds from FS to SS.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240414190040.2255a0bc@foxbook
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7ca0760574598..aa0a879a9c64a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -212,13 +212,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 		 * Compute a bandwidth estimation by multiplying the frame
 		 * size by the number of video frames per second, divide the
 		 * result by the number of USB frames (or micro-frames for
-		 * high-speed devices) per second and add the UVC header size
-		 * (assumed to be 12 bytes long).
+		 * high- and super-speed devices) per second and add the UVC
+		 * header size (assumed to be 12 bytes long).
 		 */
 		bandwidth = frame->wWidth * frame->wHeight / 8 * format->bpp;
 		bandwidth *= 10000000 / interval + 1;
 		bandwidth /= 1000;
-		if (stream->dev->udev->speed == USB_SPEED_HIGH)
+		if (stream->dev->udev->speed >= USB_SPEED_HIGH)
 			bandwidth /= 8;
 		bandwidth += 12;
 
-- 
2.43.0




