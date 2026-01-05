Return-Path: <stable+bounces-204667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8188CF3225
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A483C302A95E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB46314A65;
	Mon,  5 Jan 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOt2NnGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2152F261F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610856; cv=none; b=uVNHLW3NX309WevqncV89TTZRZHRE4rVfzmqYMZ4ObbrTgbTIXj3sK8jgh718EvbBgjEh0fTOahoavh2WObcfdilVwixfHdQ7IdOAWPpRvWsO1t/KH9zTvkc///9ovFKykOVXVyBq34RPwFHJw2EECKWNPJckNMXQudxiZk9bl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610856; c=relaxed/simple;
	bh=17mSmtEsr9IauI32zghzOUzJO5sFjIF+3yKYbqPF4pQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MYiLKGuNPzXnWF2xTYNNLOKu31N/oWZBmcgaU1R6ZM5sU1fvvIoXgYHVX9kDu8wGqy87eevZ5Rg6URTJkNK7x5M5jRBtqkRwW6eU3ZfA4OgnotlRFB8EyL2YRgvgtT3q+mV9+MqLHw1Vnlh6FiO1s+swnYiBljEwJKB8apix65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOt2NnGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAF2C116D0;
	Mon,  5 Jan 2026 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610855;
	bh=17mSmtEsr9IauI32zghzOUzJO5sFjIF+3yKYbqPF4pQ=;
	h=Subject:To:Cc:From:Date:From;
	b=qOt2NnGv0qfkjzmWS/Xh3J5Il1hzkMN1z+QwL7rt8kTmiTzjakAcoEqaZiL0R4p6u
	 q0NmasG4wGcTKskc8jwehGPDitzQIypsdtqinVUWPca5M1t7OqHmbHGDqsfy8H2PrS
	 ov/nNFvLFEQh8f/6sLzaxHV6tAdzetZGjcOvpNd0=
Subject: FAILED: patch "[PATCH] media: i2c: imx219: Fix 1920x1080 mode to use 1:1 pixel" failed to apply to 6.12-stable tree
To: dave.stevenson@raspberrypi.com,hverkuil+cisco@kernel.org,jacopo.mondi@ideasonboard.com,jai.luthra@ideasonboard.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:00:52 +0100
Message-ID: <2026010552-troubling-gala-6c69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9ef6e4db152c34580cc52792f32485c193945395
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010552-troubling-gala-6c69@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ef6e4db152c34580cc52792f32485c193945395 Mon Sep 17 00:00:00 2001
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 17 Oct 2025 13:43:49 +0530
Subject: [PATCH] media: i2c: imx219: Fix 1920x1080 mode to use 1:1 pixel
 aspect ratio

Commit 0af46fbc333d ("media: i2c: imx219: Calculate crop rectangle
dynamically") meant that the 1920x1080 mode switched from using no
binning to using vertical binning but no horizontal binning, which
resulted in stretched pixels.

Until proper controls are available to independently select horizontal
and vertical binning, restore the original 1:1 pixel aspect ratio by
forcing binning to be uniform in both directions.

Cc: stable@vger.kernel.org
Fixes: 0af46fbc333d ("media: i2c: imx219: Calculate crop rectangle dynamically")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
[Add comment & reword commit message]
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c680aa6c3a55..300935b1ef24 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -856,7 +856,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	const struct imx219_mode *mode;
 	struct v4l2_mbus_framefmt *format;
 	struct v4l2_rect *crop;
-	u8 bin_h, bin_v;
+	u8 bin_h, bin_v, binning;
 	u32 prev_line_len;
 
 	format = v4l2_subdev_state_get_format(state, 0);
@@ -877,9 +877,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	bin_h = min(IMX219_PIXEL_ARRAY_WIDTH / format->width, 2U);
 	bin_v = min(IMX219_PIXEL_ARRAY_HEIGHT / format->height, 2U);
 
+	/* Ensure bin_h and bin_v are same to avoid 1:2 or 2:1 stretching */
+	binning = min(bin_h, bin_v);
+
 	crop = v4l2_subdev_state_get_crop(state, 0);
-	crop->width = format->width * bin_h;
-	crop->height = format->height * bin_v;
+	crop->width = format->width * binning;
+	crop->height = format->height * binning;
 	crop->left = (IMX219_NATIVE_WIDTH - crop->width) / 2;
 	crop->top = (IMX219_NATIVE_HEIGHT - crop->height) / 2;
 


