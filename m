Return-Path: <stable+bounces-192520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C5C36616
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 16:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE133B91A1
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895932C92C;
	Wed,  5 Nov 2025 15:19:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314121CC55
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355953; cv=none; b=d6hEFWnTYRtyXNrR9QQUO961mTIiZ9vRCzKf24so8UMjDq8hFOxTKsmjg0MWCqlRGAZV1TQOWV0rQCzOy+DeVJEndTAo9xztcKGwZc0l1oiRiD66oA/olvcLysJGs4ywSwUywS8W/JNk83dyhOGbI/FThVw7n2HyNNSLu/+u0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355953; c=relaxed/simple;
	bh=yPdcMxsJZjicYk3JWV46vgQDLgnx86bTAcnHqYLQtVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blWdDMifnYeawh4e5Lg8oCPWpuJyuG4FGmnRjt/REMSUg9kf5Jp+tdvZOdzf7UJwB2q/Ka2sA9LarnzO2bLJ3WdyUvua7ysRzBgiSXS0LJ4i/mr6eJz1A5fpsjwoZr2RCuuOZ3d4i3Zz5f/bPioz/jsZYQLheOEEgDafHUd2sWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vGfHy-0002IK-4f; Wed, 05 Nov 2025 16:19:10 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Wed, 05 Nov 2025 16:18:50 +0100
Subject: [PATCH 2/2] media: staging: imx: configure src_mux in csi_start
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-media-imx-fixes-v1-2-99e48b4f5cbc@pengutronix.de>
References: <20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de>
In-Reply-To: <20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Michael Tretter <michael.tretter@pengutronix.de>, 
 Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

After media_pipeline_start() was called, the media graph is assumed to
be validated. It won't be validated again if a second stream starts.

The imx-media-csi driver, however, changes hardware configuration in the
link_validate() callback. This can result in started streams with
misconfigured hardware.

In the concrete example, the ipu2_csi1_mux is driven by a parallel video
input. After the media pipeline has been started with this
configuration, a second stream is configured to use ipu1_csi0 with
MIPI-CSI input from imx6-mipi-csi2. This may require the reconfiguration
of ipu1_csi0 with ipu_set_csi_src_mux(). Since the media pipeline is
already running, link_validate won't be called, and the ipu1_csi0 won't
be reconfigured. The resulting video is broken, because the
ipu1_csi0_mux is misconfigured, but no error is reported.

Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
that input to ipu1_csi0 is configured correctly when starting the
stream. This is a local reconfiguration in ipu1_csi0 and is possible
while the media pipeline is running.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
Cc: stable@vger.kernel.org
---
 drivers/staging/media/imx/imx-media-csi.c | 44 +++++++++++++++++--------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 55a7d8f38465..1bc644f73a9d 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -744,6 +744,28 @@ static int csi_setup(struct csi_priv *priv,
 	return 0;
 }
 
+static void csi_set_src(struct csi_priv *priv,
+			struct v4l2_mbus_config *mbus_cfg)
+{
+	bool is_csi2;
+
+	is_csi2 = !is_parallel_bus(mbus_cfg);
+	if (is_csi2) {
+		/*
+		 * NOTE! It seems the virtual channels from the mipi csi-2
+		 * receiver are used only for routing by the video mux's,
+		 * or for hard-wired routing to the CSI's. Once the stream
+		 * enters the CSI's however, they are treated internally
+		 * in the IPU as virtual channel 0.
+		 */
+		ipu_csi_set_mipi_datatype(priv->csi, 0,
+					  &priv->format_mbus[CSI_SINK_PAD]);
+	}
+
+	/* select either parallel or MIPI-CSI2 as input to CSI */
+	ipu_set_csi_src_mux(priv->ipu, priv->csi_id, is_csi2);
+}
+
 static int csi_start(struct csi_priv *priv)
 {
 	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
@@ -760,6 +782,8 @@ static int csi_start(struct csi_priv *priv)
 	input_fi = &priv->frame_interval[CSI_SINK_PAD];
 	output_fi = &priv->frame_interval[priv->active_output_pad];
 
+	csi_set_src(priv, &mbus_cfg);
+
 	/* start upstream */
 	ret = v4l2_subdev_call(priv->src_sd, video, s_stream, 1);
 	ret = (ret && ret != -ENOIOCTLCMD) ? ret : 0;
@@ -1130,7 +1154,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
-	bool is_csi2;
 	int ret;
 
 	ret = v4l2_subdev_link_validate_default(sd, link,
@@ -1145,25 +1168,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
 		return ret;
 	}
 
-	mutex_lock(&priv->lock);
-
-	is_csi2 = !is_parallel_bus(&mbus_cfg);
-	if (is_csi2) {
-		/*
-		 * NOTE! It seems the virtual channels from the mipi csi-2
-		 * receiver are used only for routing by the video mux's,
-		 * or for hard-wired routing to the CSI's. Once the stream
-		 * enters the CSI's however, they are treated internally
-		 * in the IPU as virtual channel 0.
-		 */
-		ipu_csi_set_mipi_datatype(priv->csi, 0,
-					  &priv->format_mbus[CSI_SINK_PAD]);
-	}
-
-	/* select either parallel or MIPI-CSI2 as input to CSI */
-	ipu_set_csi_src_mux(priv->ipu, priv->csi_id, is_csi2);
-
-	mutex_unlock(&priv->lock);
 	return ret;
 }
 

-- 
2.47.3


