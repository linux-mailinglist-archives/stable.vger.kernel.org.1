Return-Path: <stable+bounces-249607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GWqMm1wDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:15:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A6D580582
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D99F303396E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BF3ED3CD;
	Tue, 19 May 2026 14:14:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76F3ED3C8
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200082; cv=none; b=OHubo3AIUIJmzx1SpV/lZgQawETFJo1xTKLAeVPXETDwN6dLSO4DimB1Q9IGXr3ojtTdFG1GASjTOeNenB+2Qfbo5HPqZIKxr7cWZp2gBqXmN38jlPCRpYoLa1dlyoshkCTqwJzVKmxNEqeQpWrsDoq6K0jguZcKv1urGnHUZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200082; c=relaxed/simple;
	bh=HyEdZse8WgfGRDtxp2FnnQR/kSOabgWhq4eSbQSCVwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw1modlJNfJxWzmamoB/0AEQl4RKnVf76PrJQK4aZl/XnABMds064imTtWgjQ5J11PMIJGmGndzqVdJb/XtmLAuDrrqY+y20MNaZ9Xcsst2cCNRpqSo3qxmZb3FKPniDjRYdeSKdNNN6rccVxJ1gAJuVlBoRctaPetfcVHl4zQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1wPLDQ-0002qV-H0; Tue, 19 May 2026 16:14:36 +0200
From: Michael Tretter <m.tretter@pengutronix.de>
To: stable@vger.kernel.org
Cc: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 6.18.y] media: staging: imx: configure src_mux in csi_start
Date: Tue, 19 May 2026 16:14:36 +0200
Message-ID: <20260519141436.784770-1-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051552-pasta-scariness-9d08@gregkh>
References: <2026051552-pasta-scariness-9d08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.tretter@pengutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249607-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 72A6D580582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After media_pipeline_start() was called, the media graph is assumed to
be validated. It won't be validated again if a second stream starts.

The imx-media-csi driver, however, changes hardware configuration in the
link_validate() callback. This can result in started streams with
misconfigured hardware.

In the concrete example, the ipu2_csi1 is driven by a parallel video
input. After the media pipeline has been started with this
configuration, a second stream is configured to use ipu1_csi0 with
MIPI-CSI input from imx6-mipi-csi2. This may require the reconfiguration
of ipu1_csi0 with ipu_set_csi_src_mux(). Since the media pipeline is
already running, link_validate won't be called, and the ipu1_csi0 won't
be reconfigured. The resulting video is broken, because the ipu1_csi0 is
misconfigured, but no error is reported.

Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
that input to ipu1_csi0 is configured correctly when starting the
stream. This is a local reconfiguration in ipu1_csi0 and is possible
while the media pipeline is running.

Since csi_start() is called with priv->lock already locked,
csi_set_src() must not lock priv->lock again. Thus, the mutex_lock() is
dropped.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
(cherry picked from commit ebeec2b000a90cd8aae86d1931ff5ef23af8284e)
---
 drivers/staging/media/imx/imx-media-csi.c | 44 ++++++++++++-----------
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


