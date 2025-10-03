Return-Path: <stable+bounces-183265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C88BB7772
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C7B188430E
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7429E117;
	Fri,  3 Oct 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRF+XB35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCEE29D26D;
	Fri,  3 Oct 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507654; cv=none; b=MNOUlAA5dl4v6k7PKhUENL9pR6Awf5wBkzRLn8p5r9GujavV1LNVdDMW4j47fwfq8lekR9TWcxnvOCUOZxV93FQl1d6kBhY01qPB/FunhanO8Bg2D45j0xGIy6O6DmQ6zAAmGeFpf2QDqdRHdQp/8XvZvwpz+pA2Dal2iJei8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507654; c=relaxed/simple;
	bh=ofybCiMlqHT/a3KRxHPhhpCJhQGTv4bYACcpR+fSlo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe1QoXUrjtGpgjoUlWDbuugaa8VlQUZl97RwoQ7PH9NizoR726yUp86XMh+MzEg5wPuPJKbcPh9/vUABiTHFNPBr4lPy2OpFrJuxNTgLsCopNLH/9p10qKBzPchKAyDMhFEhErKDHSNtVg4MBJPjQNKflfOAwLI6pZsqBMmoZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRF+XB35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396C4C4CEF5;
	Fri,  3 Oct 2025 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759507654;
	bh=ofybCiMlqHT/a3KRxHPhhpCJhQGTv4bYACcpR+fSlo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRF+XB35B6IbiFDZvq45RkT6XB8O2gebmCuXws7561yZD5niYvR5o3p1Zio+26JY2
	 wtv0ssjcyOzGQzSMfxP5pkMhUZEESbWlE5yUqwOzN19qYYhm88gQrD2q2A6QezmeN/
	 jgc45AfWubA0TMKzgRDRgquxtxHIkjB4D/0EHE3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.16 13/14] media: stm32-csi: Fix dereference before NULL check
Date: Fri,  3 Oct 2025 18:05:47 +0200
Message-ID: <20251003160353.088920718@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
References: <20251003160352.713189598@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>

commit 80eaf32672871bd2623ce6ba13ffc1f018756580 upstream.

In 'stm32_csi_start', 'csidev->s_subdev' is dereferenced directly while
assigning a value to the 'src_pad'. However the same value is being
checked against NULL at a later point of time indicating that there
are chances that the value can be NULL.

Move the dereference after the NULL check.

Fixes: e7bad98c205d1 ("media: v4l: Convert the users of v4l2_get_link_freq to call it on a pad")
Cc: stable@vger.kernel.org
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/st/stm32/stm32-csi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/st/stm32/stm32-csi.c
+++ b/drivers/media/platform/st/stm32/stm32-csi.c
@@ -443,8 +443,7 @@ static void stm32_csi_phy_reg_write(stru
 static int stm32_csi_start(struct stm32_csi_dev *csidev,
 			   struct v4l2_subdev_state *state)
 {
-	struct media_pad *src_pad =
-		&csidev->s_subdev->entity.pads[csidev->s_subdev_pad_nb];
+	struct media_pad *src_pad;
 	const struct stm32_csi_mbps_phy_reg *phy_regs = NULL;
 	struct v4l2_mbus_framefmt *sink_fmt;
 	const struct stm32_csi_fmts *fmt;
@@ -466,6 +465,7 @@ static int stm32_csi_start(struct stm32_
 	if (!csidev->s_subdev)
 		return -EIO;
 
+	src_pad = &csidev->s_subdev->entity.pads[csidev->s_subdev_pad_nb];
 	link_freq = v4l2_get_link_freq(src_pad,
 				       fmt->bpp, 2 * csidev->num_lanes);
 	if (link_freq < 0)



