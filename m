Return-Path: <stable+bounces-204721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF7CF3517
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B4B30329EA
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB64330320;
	Mon,  5 Jan 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UtL7FLe/"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59813316903
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613259; cv=none; b=RHDXzRUG1kChHn5G03pdybncfjk6vdqEc3rYkiXVqPqG9+VJbfaK71CfTyZRsqPyJeszGRI1KpHQ4iEgoCckdLN88hI+1yK1uDSTUPF/aRPxy/naNORAO4FW0Uow5hfVZUpSK3hxKRUtR1yB3/fbGiS2SkUrMvJm7gK1X/h4GNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613259; c=relaxed/simple;
	bh=FeAKslzju0IBbSDUq6p1nx2sFx66+pIAhfys9TfsWuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvZjzik6+A+M8DrYYdS0SNtkhbF3mkKtLEgGbvGEAIr7nxiyJ3PzabeQ3qpCZbJnOl9tHvCuiJ+XpabVkjFGAfHWF7ZwV8+hiLgrvmx2tVxR7D6WzLIGArpw46NNfRnj7eMiI8VFDsAobFkrlmJkUJInO4rznCJTfOKKrU6M1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UtL7FLe/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c66:7a27:cc90:d029:7f3f:325e])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C845E8CB;
	Mon,  5 Jan 2026 12:40:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1767613233;
	bh=FeAKslzju0IBbSDUq6p1nx2sFx66+pIAhfys9TfsWuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtL7FLe/s7+HoCOSU/jetTdSclL7KUMMi7Mn3jXUWJ/3MTHjdXbjr/5WXrhHDLYp6
	 YQY7WbEWT3WAec6XAHqsAl20OjNWcfBrA3QDbH89sa81cYi4vNnFc6fOZbbU2QEXZC
	 7xB4z0UJCQM5Kkx/b0dH6EpFRBYuGQhFpB+IfdyY=
From: Jai Luthra <jai.luthra@ideasonboard.com>
To: stable@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH 6.12.y] media: i2c: imx219: Fix 1920x1080 mode to use 1:1 pixel aspect ratio
Date: Mon,  5 Jan 2026 17:10:32 +0530
Message-ID: <20260105114032.3222732-1-jai.luthra@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2026010552-troubling-gala-6c69@gregkh>
References: <2026010552-troubling-gala-6c69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

commit 9ef6e4db152c34580cc52792f32485c193945395 upstream.

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
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index eaa1496c71bb..e0714abe8540 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -843,7 +843,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	const struct imx219_mode *mode;
 	struct v4l2_mbus_framefmt *format;
 	struct v4l2_rect *crop;
-	unsigned int bin_h, bin_v;
+	unsigned int bin_h, bin_v, binning;
 
 	mode = v4l2_find_nearest_size(supported_modes,
 				      ARRAY_SIZE(supported_modes),
@@ -862,9 +862,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
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
 
-- 
2.52.0


