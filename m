Return-Path: <stable+bounces-73652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24E96E196
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC01C23CEF
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174A17B4E5;
	Thu,  5 Sep 2024 18:09:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F917BEA4
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559756; cv=none; b=SxX5DBfmIS8lJjUnWBbI1FyJCBcza6Q2vthLS27jZ5qozR8L0q1yMYKpL/CIjhwNRqzmyIxBT+vwOSEqApoiWoEE9OO22iMlwu7zXVHzw/QCEEMBvSDzwuDks9sfn86PF9Dd4WkowXgbQnc5UoIlVWK7Kk1avFwdiLUZr2+BaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559756; c=relaxed/simple;
	bh=Ib+LiF6Qp0AfDM/lw1bUutNwDWrXrkN3ukVRR6t5bQw=;
	h=From:Date:Subject:To:Cc:Message-Id; b=rthVpWkI3kK5TGRtRATzKfrCBmDLdNyaLUreJT5pGu8LDzkbarUkbAWfDV+14uwffWrkvIaIs6PKGSi7AJhxn+phldsnm4USDtE+mHwr/FWTYqDTN0x3EfamBiFQ8BO1nK3/YE7x3B/dF6+I5/8rZ4RP4kXJMX53u0uEyfcAPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1smGus-0001bg-2q;
	Thu, 05 Sep 2024 18:09:11 +0000
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 26 Aug 2024 13:36:14 +0000
Subject: [git:media_tree/master] media: sun4i_csi: Implement link validate for sun4i_csi subdev
To: linuxtv-commits@linuxtv.org
Cc: Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1smGus-0001bg-2q@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: sun4i_csi: Implement link validate for sun4i_csi subdev
Author:  Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:    Wed Jun 19 02:46:16 2024 +0300

The sun4i_csi driver doesn't implement link validation for the subdev it
registers, leaving the link between the subdev and its source
unvalidated. Fix it, using the v4l2_subdev_link_validate() helper.

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

---

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index 097a3a08ef7d..dbb26c7b2f8d 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -39,6 +39,10 @@ static const struct media_entity_operations sun4i_csi_video_entity_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+static const struct media_entity_operations sun4i_csi_subdev_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static int sun4i_csi_notify_bound(struct v4l2_async_notifier *notifier,
 				  struct v4l2_subdev *subdev,
 				  struct v4l2_async_connection *asd)
@@ -214,6 +218,7 @@ static int sun4i_csi_probe(struct platform_device *pdev)
 	subdev->internal_ops = &sun4i_csi_subdev_internal_ops;
 	subdev->flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 	subdev->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	subdev->entity.ops = &sun4i_csi_subdev_entity_ops;
 	subdev->owner = THIS_MODULE;
 	snprintf(subdev->name, sizeof(subdev->name), "sun4i-csi-0");
 	v4l2_set_subdevdata(subdev, csi);

