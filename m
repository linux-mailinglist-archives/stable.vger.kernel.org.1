Return-Path: <stable+bounces-71403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0F9625A8
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 13:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6178281310
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252716D330;
	Wed, 28 Aug 2024 11:13:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8016C873
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843608; cv=none; b=aefgNEW2A369wF65Unz5JtTvERqb57KqINWTWBzyfdn/lHgMX9TEAS1JUXLgQ5VZZx1LAojxHLgtWTLDWugNV9o/lrfSC0dR5xd/m3AfrNTNZZKpa0eBIZvYwi5DgzQ/99u7aR7xaMdYPujjxaaOxKnuAZ5ikAXwCDWW8Y8mR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843608; c=relaxed/simple;
	bh=Ib+LiF6Qp0AfDM/lw1bUutNwDWrXrkN3ukVRR6t5bQw=;
	h=From:Date:Subject:To:Cc:Message-Id; b=OwaOtaLHrBwOdyEKRndHsol0sJBgcOksyqs/hm/kiq6H3g9Fyyt6hQVjarqYylv3t6TbNJJClLjV87AERuTIU9cBHRuvkjaTzdVJCtYSHKn3qYBWae5zPuLrjGqBfwTWY3mHPEi2YIYL9Xq18SSgRbYWNg3w3jTkD7FieGHJ4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sjGcA-0006Dh-1b;
	Wed, 28 Aug 2024 11:13:26 +0000
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 26 Aug 2024 13:36:14 +0000
Subject: [git:media_stage/master] media: sun4i_csi: Implement link validate for sun4i_csi subdev
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Chen-Yu Tsai <wens@csie.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sjGcA-0006Dh-1b@linuxtv.org>
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

