Return-Path: <stable+bounces-192707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D495C3F81B
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 11:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 985124F411A
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFED32BF55;
	Fri,  7 Nov 2025 10:35:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEA19F11E
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511700; cv=none; b=Gouknvv2rlE5mYB0CEVZIoyGPDF5rh32yQCSPbPSaglY7canX4JN8rmMWxh3s/8150OQsYhGXlmm6CyIlcKcB0D4TiXuTYhrkyxfUfShBcnor4bcvJMPLaxvDjtHZ+kFUxjsLYvY6dwA+aKP+pYX9JIDOGo3ePATXD6tCNy1lho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511700; c=relaxed/simple;
	bh=nmf9UxL9nmkpWnu6BYC6uG9OTueBdAAyeh0D9PyTWyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrIUxlMc/0ZsJRf94zrk2ChETGfmXIi806+/sDUmxsf1s6OSRWFLS3aFnSWZgOYEzco/W0bXQe+TIDzEO2oawqHon4JqfAN09Ol4gn/MVog2Y026u0wbW+28w4nwMcmgZUFmAugsxZL5OVlivJAgJXg4rxrMu1xooacwYZIdcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vHJnp-0007dI-07; Fri, 07 Nov 2025 11:34:45 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Fri, 07 Nov 2025 11:34:33 +0100
Subject: [PATCH v2 1/2] media: staging: imx: request mbus_config in
 csi_start
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-media-imx-fixes-v2-1-07d949964194@pengutronix.de>
References: <20251107-media-imx-fixes-v2-0-07d949964194@pengutronix.de>
In-Reply-To: <20251107-media-imx-fixes-v2-0-07d949964194@pengutronix.de>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Michael Tretter <michael.tretter@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Request the upstream mbus_config in csi_start, which starts the stream,
instead of caching it in link_validate.

This allows to get rid of the mbus_cfg field in the struct csi_priv and
avoids state in the driver.

Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 40 ++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index fd7e37d803e7..55a7d8f38465 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -97,9 +97,6 @@ struct csi_priv {
 	/* the mipi virtual channel number at link validate */
 	int vc_num;
 
-	/* media bus config of the upstream subdevice CSI is receiving from */
-	struct v4l2_mbus_config mbus_cfg;
-
 	spinlock_t irqlock; /* protect eof_irq handler */
 	struct timer_list eof_timeout_timer;
 	int eof_irq;
@@ -403,7 +400,8 @@ static void csi_idmac_unsetup_vb2_buf(struct csi_priv *priv,
 }
 
 /* init the SMFC IDMAC channel */
-static int csi_idmac_setup_channel(struct csi_priv *priv)
+static int csi_idmac_setup_channel(struct csi_priv *priv,
+				   struct v4l2_mbus_config *mbus_cfg)
 {
 	struct imx_media_video_dev *vdev = priv->vdev;
 	const struct imx_media_pixfmt *incc;
@@ -432,7 +430,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	image.phys0 = phys[0];
 	image.phys1 = phys[1];
 
-	passthrough = requires_passthrough(&priv->mbus_cfg, infmt, incc);
+	passthrough = requires_passthrough(mbus_cfg, infmt, incc);
 	passthrough_cycles = 1;
 
 	/*
@@ -572,11 +570,12 @@ static void csi_idmac_unsetup(struct csi_priv *priv,
 	csi_idmac_unsetup_vb2_buf(priv, state);
 }
 
-static int csi_idmac_setup(struct csi_priv *priv)
+static int csi_idmac_setup(struct csi_priv *priv,
+			   struct v4l2_mbus_config *mbus_cfg)
 {
 	int ret;
 
-	ret = csi_idmac_setup_channel(priv);
+	ret = csi_idmac_setup_channel(priv, mbus_cfg);
 	if (ret)
 		return ret;
 
@@ -595,7 +594,8 @@ static int csi_idmac_setup(struct csi_priv *priv)
 	return 0;
 }
 
-static int csi_idmac_start(struct csi_priv *priv)
+static int csi_idmac_start(struct csi_priv *priv,
+			   struct v4l2_mbus_config *mbus_cfg)
 {
 	struct imx_media_video_dev *vdev = priv->vdev;
 	int ret;
@@ -619,7 +619,7 @@ static int csi_idmac_start(struct csi_priv *priv)
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
-	ret = csi_idmac_setup(priv);
+	ret = csi_idmac_setup(priv, mbus_cfg);
 	if (ret) {
 		v4l2_err(&priv->sd, "csi_idmac_setup failed: %d\n", ret);
 		goto out_free_dma_buf;
@@ -701,7 +701,8 @@ static void csi_idmac_stop(struct csi_priv *priv)
 }
 
 /* Update the CSI whole sensor and active windows */
-static int csi_setup(struct csi_priv *priv)
+static int csi_setup(struct csi_priv *priv,
+		     struct v4l2_mbus_config *mbus_cfg)
 {
 	struct v4l2_mbus_framefmt *infmt, *outfmt;
 	const struct imx_media_pixfmt *incc;
@@ -719,7 +720,7 @@ static int csi_setup(struct csi_priv *priv)
 	 * if cycles is set, we need to handle this over multiple cycles as
 	 * generic/bayer data
 	 */
-	if (is_parallel_bus(&priv->mbus_cfg) && incc->cycles) {
+	if (is_parallel_bus(mbus_cfg) && incc->cycles) {
 		if_fmt.width *= incc->cycles;
 		crop.width *= incc->cycles;
 	}
@@ -730,7 +731,7 @@ static int csi_setup(struct csi_priv *priv)
 			     priv->crop.width == 2 * priv->compose.width,
 			     priv->crop.height == 2 * priv->compose.height);
 
-	ipu_csi_init_interface(priv->csi, &priv->mbus_cfg, &if_fmt, outfmt);
+	ipu_csi_init_interface(priv->csi, mbus_cfg, &if_fmt, outfmt);
 
 	ipu_csi_set_dest(priv->csi, priv->dest);
 
@@ -745,9 +746,17 @@ static int csi_setup(struct csi_priv *priv)
 
 static int csi_start(struct csi_priv *priv)
 {
+	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
 	struct v4l2_fract *input_fi, *output_fi;
 	int ret;
 
+	ret = csi_get_upstream_mbus_config(priv, &mbus_cfg);
+	if (ret) {
+		v4l2_err(&priv->sd,
+			 "failed to get upstream media bus configuration\n");
+		return ret;
+	}
+
 	input_fi = &priv->frame_interval[CSI_SINK_PAD];
 	output_fi = &priv->frame_interval[priv->active_output_pad];
 
@@ -758,7 +767,7 @@ static int csi_start(struct csi_priv *priv)
 		return ret;
 
 	/* Skip first few frames from a BT.656 source */
-	if (priv->mbus_cfg.type == V4L2_MBUS_BT656) {
+	if (mbus_cfg.type == V4L2_MBUS_BT656) {
 		u32 delay_usec, bad_frames = 20;
 
 		delay_usec = DIV_ROUND_UP_ULL((u64)USEC_PER_SEC *
@@ -769,12 +778,12 @@ static int csi_start(struct csi_priv *priv)
 	}
 
 	if (priv->dest == IPU_CSI_DEST_IDMAC) {
-		ret = csi_idmac_start(priv);
+		ret = csi_idmac_start(priv, &mbus_cfg);
 		if (ret)
 			goto stop_upstream;
 	}
 
-	ret = csi_setup(priv);
+	ret = csi_setup(priv, &mbus_cfg);
 	if (ret)
 		goto idmac_stop;
 
@@ -1138,7 +1147,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
 
 	mutex_lock(&priv->lock);
 
-	priv->mbus_cfg = mbus_cfg;
 	is_csi2 = !is_parallel_bus(&mbus_cfg);
 	if (is_csi2) {
 		/*

-- 
2.47.3


