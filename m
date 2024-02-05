Return-Path: <stable+bounces-18833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40F849BC8
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0281C22AFD
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED81CD12;
	Mon,  5 Feb 2024 13:30:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFC2374C
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139819; cv=none; b=FycRkzGBntAyflK6giusw2udtSpabBG/yskDiIGFeAKmDH8zrtTJvtAWOJG/spuUHOeWwj7EcPOIZ8WvMsDKQ4mtZreSBvOre/qLvWIlevbLT6XJoJLeiudeZyr4oUJZu9HnNpJw7O7Xygt+oEm0XoU7lUHfBuHUXOmtH2GzEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139819; c=relaxed/simple;
	bh=dVdeDHLgVoy/9ys/1OANni5R9pq6n4MgwMhy0IT8cfc=;
	h=From:Date:Subject:To:Cc:Message-Id; b=B2PPf5bJHRBF50vUPLTzdgRo8sIipjEuZxLvJ6GEt20U9n0zSrV2/dWkY+DVh4MbK4n+W5Z6wpEEesAP7HLi5PdmqUmGU0qJxeJBOyKAge+d8St0M4TmkLBFxk1zOWUy7Q7p7TTJHBDQN7MhLeDqGIXxbrq54b/YmuxeQ8WYnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rWz37-0004Fv-1j;
	Mon, 05 Feb 2024 13:30:13 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 05 Feb 2024 13:29:34 +0000
Subject: [git:media_stage/master] media: nxp: imx8-isi: Check whether crossbar pad is non-NULL before access
To: linuxtv-commits@linuxtv.org
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Fabio Estevam <festevam@gmail.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rWz37-0004Fv-1j@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: nxp: imx8-isi: Check whether crossbar pad is non-NULL before access
Author:  Marek Vasut <marex@denx.de>
Date:    Fri Dec 1 16:06:04 2023 +0100

When translating source to sink streams in the crossbar subdev, the
driver tries to locate the remote subdev connected to the sink pad. The
remote pad may be NULL, if userspace tries to enable a stream that ends
at an unconnected crossbar sink. When that occurs, the driver
dereferences the NULL pad, leading to a crash.

Prevent the crash by checking if the pad is NULL before using it, and
return an error if it is.

Cc: stable@vger.kernel.org # 6.1
Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20231201150614.63300-1-marex@denx.de
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

---

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 575f17337388..1bb1334ec6f2 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -160,8 +160,14 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 	}
 
 	pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
-	sd = media_entity_to_v4l2_subdev(pad->entity);
+	if (!pad) {
+		dev_dbg(xbar->isi->dev,
+			"no pad connected to crossbar input %u\n",
+			sink_pad);
+		return ERR_PTR(-EPIPE);
+	}
 
+	sd = media_entity_to_v4l2_subdev(pad->entity);
 	if (!sd) {
 		dev_dbg(xbar->isi->dev,
 			"no entity connected to crossbar input %u\n",

