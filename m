Return-Path: <stable+bounces-10262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8832827410
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551F7285E8A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701552F85;
	Mon,  8 Jan 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ph9vedYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C75102D;
	Mon,  8 Jan 2024 15:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E9AC433CB;
	Mon,  8 Jan 2024 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728498;
	bh=0oxO8yYaoMHy1AZ6b0iVp038FxtQbUpFPgp1+EiYDA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ph9vedYcKYfxacY7dbFKlkwdBHms13RtOSDqlBKHJ2J14TjhK6Nzc8alvro0zk65P
	 gjnEiatzNYk2HFxybE1oXaBVgG+eo3O7+7Y/qOMnmtfZqtQs9GJlKSXRwrPsr2w8TD
	 DoF/adIYGE7CTHFD2OlrsJ9tLPdMAc5zS66NWBAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Milen Mitkov <quic_mmitkov@quicinc.com>,
	Robert Foss <robert.foss@linaro.org>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/150] media: camss: sm8250: Virtual channels for CSID
Date: Mon,  8 Jan 2024 16:35:47 +0100
Message-ID: <20240108153515.627736909@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milen Mitkov <quic_mmitkov@quicinc.com>

[ Upstream commit 3c4ed72a16bc6733cda9c65048af74a2e8eaa0eb ]

CSID hardware on SM8250 can demux up to 4 simultaneous streams
based on virtual channel (vc) or datatype (dt).
The CSID subdevice entity now has 4 source ports that can be
enabled/disabled and thus can control which virtual channels
are enabled. Datatype demuxing not tested.

In order to keep a valid internal state of the subdevice,
implicit format propagation from the sink to the source pads
has been preserved. However, the format on each source pad
can be different and in that case it must be configured explicitly.

CSID's s_stream is called when any stream is started or stopped.
It will call configure_streams() that will rewrite IRQ settings to HW.
When multiple streams are running simultaneously there is an issue
when writing IRQ settings for one stream while another is still
running, thus avoid re-writing settings if they were not changed
in link setup, or by fully powering off the CSID hardware.

Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: e655d1ae9703 ("media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater than 3")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/qcom/camss/camss-csid-gen2.c     | 54 ++++++++++++-------
 .../media/platform/qcom/camss/camss-csid.c    | 44 ++++++++++-----
 .../media/platform/qcom/camss/camss-csid.h    | 11 +++-
 3 files changed, 74 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 904208f6f9546..2e015e69a6ad6 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -334,13 +334,14 @@ static const struct csid_format csid_formats[] = {
 	},
 };
 
-static void csid_configure_stream(struct csid_device *csid, u8 enable)
+static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 {
 	struct csid_testgen_config *tg = &csid->testgen;
 	u32 val;
 	u32 phy_sel = 0;
 	u8 lane_cnt = csid->phy.lane_cnt;
-	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_SRC];
+	/* Source pads matching RDI channels on hardware. Pad 1 -> RDI0, Pad 2 -> RDI1, etc. */
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
 	const struct csid_format *format = csid_get_fmt_entry(csid->formats, csid->nformats,
 							      input_format->code);
 
@@ -351,8 +352,7 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		phy_sel = csid->phy.csiphy_id;
 
 	if (enable) {
-		u8 vc = 0; /* Virtual Channel 0 */
-		u8 dt_id = vc * 4;
+		u8 dt_id = vc;
 
 		if (tg->enabled) {
 			/* configure one DT, infinite frames */
@@ -392,42 +392,42 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		val |= format->data_type << RDI_CFG0_DATA_TYPE;
 		val |= vc << RDI_CFG0_VIRTUAL_CHANNEL;
 		val |= dt_id << RDI_CFG0_DT_ID;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG0(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
 
 		/* CSID_TIMESTAMP_STB_POST_IRQ */
 		val = 2 << RDI_CFG1_TIMESTAMP_STB_SEL;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG1(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CFG1(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_FRM_DROP_PATTERN(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_IRQ_SUBSAMPLE_PATTERN(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_PIX_DROP_PATTERN(vc));
 
 		val = 1;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PERIOD(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PERIOD(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PATTERN(0));
+		writel_relaxed(val, csid->base + CSID_RDI_RPP_LINE_DROP_PATTERN(vc));
 
 		val = 0;
-		writel_relaxed(val, csid->base + CSID_RDI_CTRL(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
 
-		val = readl_relaxed(csid->base + CSID_RDI_CFG0(0));
+		val = readl_relaxed(csid->base + CSID_RDI_CFG0(vc));
 		val |=  1 << RDI_CFG0_ENABLE;
-		writel_relaxed(val, csid->base + CSID_RDI_CFG0(0));
+		writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
 	}
 
 	if (tg->enabled) {
@@ -453,7 +453,16 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 		val = HALT_CMD_RESUME_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
 	else
 		val = HALT_CMD_HALT_AT_FRAME_BOUNDARY << RDI_CTRL_HALT_CMD;
-	writel_relaxed(val, csid->base + CSID_RDI_CTRL(0));
+	writel_relaxed(val, csid->base + CSID_RDI_CTRL(vc));
+}
+
+static void csid_configure_stream(struct csid_device *csid, u8 enable)
+{
+	u8 i;
+	/* Loop through all enabled VCs and configure stream for each */
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i))
+			__csid_configure_stream(csid, enable, i);
 }
 
 static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
@@ -499,6 +508,7 @@ static irqreturn_t csid_isr(int irq, void *dev)
 	struct csid_device *csid = dev;
 	u32 val;
 	u8 reset_done;
+	int i;
 
 	val = readl_relaxed(csid->base + CSID_TOP_IRQ_STATUS);
 	writel_relaxed(val, csid->base + CSID_TOP_IRQ_CLEAR);
@@ -507,8 +517,12 @@ static irqreturn_t csid_isr(int irq, void *dev)
 	val = readl_relaxed(csid->base + CSID_CSI2_RX_IRQ_STATUS);
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_IRQ_CLEAR);
 
-	val = readl_relaxed(csid->base + CSID_CSI2_RDIN_IRQ_STATUS(0));
-	writel_relaxed(val, csid->base + CSID_CSI2_RDIN_IRQ_CLEAR(0));
+	/* Read and clear IRQ status for each enabled RDI channel */
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
+		if (csid->phy.en_vc & BIT(i)) {
+			val = readl_relaxed(csid->base + CSID_CSI2_RDIN_IRQ_STATUS(i));
+			writel_relaxed(val, csid->base + CSID_CSI2_RDIN_IRQ_CLEAR(i));
+		}
 
 	val = 1 << IRQ_CMD_CLEAR;
 	writel_relaxed(val, csid->base + CSID_IRQ_CMD);
diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 88f188e0f7501..6360314f04a63 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -196,6 +196,8 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 			return ret;
 		}
 
+		csid->phy.need_vc_update = true;
+
 		enable_irq(csid->irq);
 
 		ret = csid->ops->reset(csid);
@@ -249,7 +251,10 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 			return -ENOLINK;
 	}
 
-	csid->ops->configure_stream(csid, enable);
+	if (csid->phy.need_vc_update) {
+		csid->ops->configure_stream(csid, enable);
+		csid->phy.need_vc_update = false;
+	}
 
 	return 0;
 }
@@ -460,6 +465,7 @@ static int csid_set_format(struct v4l2_subdev *sd,
 {
 	struct csid_device *csid = v4l2_get_subdevdata(sd);
 	struct v4l2_mbus_framefmt *format;
+	int i;
 
 	format = __csid_get_format(csid, sd_state, fmt->pad, fmt->which);
 	if (format == NULL)
@@ -468,14 +474,14 @@ static int csid_set_format(struct v4l2_subdev *sd,
 	csid_try_format(csid, sd_state, fmt->pad, &fmt->format, fmt->which);
 	*format = fmt->format;
 
-	/* Propagate the format from sink to source */
+	/* Propagate the format from sink to source pads */
 	if (fmt->pad == MSM_CSID_PAD_SINK) {
-		format = __csid_get_format(csid, sd_state, MSM_CSID_PAD_SRC,
-					   fmt->which);
+		for (i = MSM_CSID_PAD_FIRST_SRC; i < MSM_CSID_PADS_NUM; ++i) {
+			format = __csid_get_format(csid, sd_state, i, fmt->which);
 
-		*format = fmt->format;
-		csid_try_format(csid, sd_state, MSM_CSID_PAD_SRC, format,
-				fmt->which);
+			*format = fmt->format;
+			csid_try_format(csid, sd_state, i, format, fmt->which);
+		}
 	}
 
 	return 0;
@@ -738,7 +744,6 @@ static int csid_link_setup(struct media_entity *entity,
 		struct csid_device *csid;
 		struct csiphy_device *csiphy;
 		struct csiphy_lanes_cfg *lane_cfg;
-		struct v4l2_subdev_format format = { 0 };
 
 		sd = media_entity_to_v4l2_subdev(entity);
 		csid = v4l2_get_subdevdata(sd);
@@ -761,11 +766,22 @@ static int csid_link_setup(struct media_entity *entity,
 		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
 		csid->phy.lane_cnt = lane_cfg->num_data;
 		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
+	}
+	/* Decide which virtual channels to enable based on which source pads are enabled */
+	if (local->flags & MEDIA_PAD_FL_SOURCE) {
+		struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
+		struct csid_device *csid = v4l2_get_subdevdata(sd);
+		struct device *dev = csid->camss->dev;
+
+		if (flags & MEDIA_LNK_FL_ENABLED)
+			csid->phy.en_vc |= BIT(local->index - 1);
+		else
+			csid->phy.en_vc &= ~BIT(local->index - 1);
 
-		/* Reset format on source pad to sink pad format */
-		format.pad = MSM_CSID_PAD_SRC;
-		format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
-		csid_set_format(&csid->subdev, NULL, &format);
+		csid->phy.need_vc_update = true;
+
+		dev_dbg(dev, "%s: Enabled CSID virtual channels mask 0x%x\n",
+			__func__, csid->phy.en_vc);
 	}
 
 	return 0;
@@ -816,6 +832,7 @@ int msm_csid_register_entity(struct csid_device *csid,
 	struct v4l2_subdev *sd = &csid->subdev;
 	struct media_pad *pads = csid->pads;
 	struct device *dev = csid->camss->dev;
+	int i;
 	int ret;
 
 	v4l2_subdev_init(sd, &csid_v4l2_ops);
@@ -852,7 +869,8 @@ int msm_csid_register_entity(struct csid_device *csid,
 	}
 
 	pads[MSM_CSID_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-	pads[MSM_CSID_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	for (i = MSM_CSID_PAD_FIRST_SRC; i < MSM_CSID_PADS_NUM; ++i)
+		pads[i].flags = MEDIA_PAD_FL_SOURCE;
 
 	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 	sd->entity.ops = &csid_media_ops;
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index f06040e44c515..d4b48432a0973 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -19,8 +19,13 @@
 #include <media/v4l2-subdev.h>
 
 #define MSM_CSID_PAD_SINK 0
-#define MSM_CSID_PAD_SRC 1
-#define MSM_CSID_PADS_NUM 2
+#define MSM_CSID_PAD_FIRST_SRC 1
+#define MSM_CSID_PADS_NUM 5
+
+#define MSM_CSID_PAD_SRC (MSM_CSID_PAD_FIRST_SRC)
+
+/* CSID hardware can demultiplex up to 4 outputs */
+#define MSM_CSID_MAX_SRC_STREAMS	4
 
 #define DATA_TYPE_EMBEDDED_DATA_8BIT	0x12
 #define DATA_TYPE_YUV420_8BIT		0x18
@@ -81,6 +86,8 @@ struct csid_phy_config {
 	u8 csiphy_id;
 	u8 lane_cnt;
 	u32 lane_assign;
+	u32 en_vc;
+	u8 need_vc_update;
 };
 
 struct csid_device;
-- 
2.43.0




