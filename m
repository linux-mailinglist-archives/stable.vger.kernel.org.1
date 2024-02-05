Return-Path: <stable+bounces-18836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BFD849BCC
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417821C22AF1
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55720B3E;
	Mon,  5 Feb 2024 13:30:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0322F13
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139820; cv=none; b=lsAUqkr9gpmBZvZHQG6u9hJVYOcnLDk7MnoDpAyM0K2zVuf8yf9InpfjXJ0Gd0b9hZSaj0SNk7RoG44NTI5dZM2URnJEFcFAit+/BEWYY9b9BSOTZJr7RclDHQW4AWEgkXpd8X6UCcFMWvXo7QFjbE4lYrXgBiuxZE0b/xCXTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139820; c=relaxed/simple;
	bh=a7XmbZjFkkUYD6WoMTbtehxwo17eUcEklrXfQ5Cg9ug=;
	h=From:Date:Subject:To:Cc:Message-Id; b=TtoBTaXwK5EMr0EypTEjNqjtIYeLArfFicjw2svEmbS7hfkEIfn0R/aFAZBUzQ0EYz45RFyf/dxa5BO7R1muEqJ2TmALzgXOYHT8+I6zFEaXvaNHY6LGcjkmQQbSt+rdtGRwtcwZNpgpU0FV7jb8Bcwfb6K2X+3ialQ53olbMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rWz36-0004ET-2Z;
	Mon, 05 Feb 2024 13:30:12 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 05 Feb 2024 13:29:35 +0000
Subject: [git:media_stage/master] media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rWz36-0004ET-2Z@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT
Author:  Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:    Mon Jan 15 04:16:29 2024 +0200

All the sink pads of the crossbar switch require an active link if
they're part of the pipeline. Mark them with the
MEDIA_PAD_FL_MUST_CONNECT flag to fail pipeline validation if they're
not connected. This allows removing a manual check when translating
streams.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

---

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 1bb1334ec6f2..93a55c97cd17 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -160,13 +160,6 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 	}
 
 	pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
-	if (!pad) {
-		dev_dbg(xbar->isi->dev,
-			"no pad connected to crossbar input %u\n",
-			sink_pad);
-		return ERR_PTR(-EPIPE);
-	}
-
 	sd = media_entity_to_v4l2_subdev(pad->entity);
 	if (!sd) {
 		dev_dbg(xbar->isi->dev,
@@ -475,7 +468,8 @@ int mxc_isi_crossbar_init(struct mxc_isi_dev *isi)
 	}
 
 	for (i = 0; i < xbar->num_sinks; ++i)
-		xbar->pads[i].flags = MEDIA_PAD_FL_SINK;
+		xbar->pads[i].flags = MEDIA_PAD_FL_SINK
+				    | MEDIA_PAD_FL_MUST_CONNECT;
 	for (i = 0; i < xbar->num_sources; ++i)
 		xbar->pads[i + xbar->num_sinks].flags = MEDIA_PAD_FL_SOURCE;
 

