Return-Path: <stable+bounces-204883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8CCF516F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 325E23008725
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579E33A9FE;
	Mon,  5 Jan 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujUxATpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578A33A9DA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635591; cv=none; b=UjbnBQgUDK1kNSKwKkkR5AY4r7IqWjbPjDYgaWjO6RMt6q8plPcdx1APR2kBdHj2EcT2aMOtVClyge1H+BGz535Z/erf4D6fyg9jGQveRW9UVh1IcMy+PkXwjZaa3Ty7/ReBPvwMderZxH2v5DgILuLeCayvU9AjyQfs/OVAbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635591; c=relaxed/simple;
	bh=t9iWZeylDyvWEvt8jmTaDNjjpxrsP6K9KDPNNBIm0YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSUa7yI6WYZDc7J84ZKWUWeg4xJMgMgLDdfxn69f62yUFxzTVYMcMPKaRYZR0D13Ihap6ts7iPDjeWEG/RpFEHJsfV5+CnPwuki4U+0fVqWzfesrghSx2M6nMv1ZlQlEHhPq3g1avhsR9vTXG9OYExlKxFmEtN1yM01qYvZCxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujUxATpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564E0C116D0;
	Mon,  5 Jan 2026 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767635591;
	bh=t9iWZeylDyvWEvt8jmTaDNjjpxrsP6K9KDPNNBIm0YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujUxATpXTTuhsW14+eN5Ug5q12VLQtfiJzHAod0xnz7269kJqg3Pf6bTi0+prg6cG
	 k7MDkY9ja+xQN1HU67uY6VRO7a+EoGra6AshuiJ7J1G0NDpjigZWQwM+HvFQeTCrw/
	 3/LaROBuoYdTJFPxiSdXpzMEj23g5hDLCNuMi2u00320gXz1Nms+/AGclAgOO/rjEs
	 kObjoT8kVfOfNU4LH6dkmJyEwoXYqXJnrnMzqFuGEhTbsLMnqgES83K3cfD3KjEZkI
	 eGBTD8qbDNzsXn/NeL7vzGZaWcJb53fKCSu0LECaTLp4spkr7RcJOGEXh65hxfN+J+
	 N/K8lbFBwLiHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: verisilicon: Fix CPU stalls on G2 bus error
Date: Mon,  5 Jan 2026 12:53:07 -0500
Message-ID: <20260105175307.2700019-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010508-pending-boondocks-df47@gregkh>
References: <2026010508-pending-boondocks-df47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

[ Upstream commit 19c286b755072a22a063052f530a6b1fac8a1f63 ]

In some seek stress tests, we are getting IRQ from the G2 decoder where
the dec_bus_int and the dec_e bits are high, meaning the decoder is
still running despite the error.

Fix this by reworking the IRQ handler to only finish the job once we
have reached completion and move the software reset to when our software
watchdog triggers.

This way, we let the hardware continue on errors when it did not self
reset and in worse case scenario the hardware timeout will
automatically stop it. The actual error will be fixed in a follow up
patch.

Fixes: 3385c514ecc5a ("media: hantro: Convert imx8m_vpu_g2_irq to helper")
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/verisilicon/hantro_g2.c    | 88 +++++++++++++++----
 .../platform/verisilicon/hantro_g2_hevc_dec.c |  2 -
 .../platform/verisilicon/hantro_g2_regs.h     | 13 +++
 .../platform/verisilicon/hantro_g2_vp9_dec.c  |  2 -
 .../media/platform/verisilicon/hantro_hw.h    |  1 +
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
 6 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_g2.c b/drivers/media/platform/verisilicon/hantro_g2.c
index ee5f14c5f8f2..dcc7ea6d5c19 100644
--- a/drivers/media/platform/verisilicon/hantro_g2.c
+++ b/drivers/media/platform/verisilicon/hantro_g2.c
@@ -5,40 +5,90 @@
  * Copyright (C) 2021 Collabora Ltd, Andrzej Pietrasiewicz <andrzej.p@collabora.com>
  */
 
+#include <linux/delay.h>
 #include "hantro_hw.h"
 #include "hantro_g2_regs.h"
 
-void hantro_g2_check_idle(struct hantro_dev *vpu)
+static bool hantro_g2_active(struct hantro_ctx *ctx)
 {
-	int i;
-
-	for (i = 0; i < 3; i++) {
-		u32 status;
-
-		/* Make sure the VPU is idle */
-		status = vdpu_read(vpu, G2_REG_INTERRUPT);
-		if (status & G2_REG_INTERRUPT_DEC_E) {
-			dev_warn(vpu->dev, "device still running, aborting");
-			status |= G2_REG_INTERRUPT_DEC_ABORT_E | G2_REG_INTERRUPT_DEC_IRQ_DIS;
-			vdpu_write(vpu, status, G2_REG_INTERRUPT);
-		}
+	struct hantro_dev *vpu = ctx->dev;
+	u32 status;
+
+	status = vdpu_read(vpu, G2_REG_INTERRUPT);
+
+	return (status & G2_REG_INTERRUPT_DEC_E);
+}
+
+/**
+ * hantro_g2_reset:
+ * @ctx: the hantro context
+ *
+ * Emulates a reset using Hantro abort function. Failing this procedure would
+ * results in programming a running IP which leads to CPU hang.
+ *
+ * Using a hard reset procedure instead is prefferred.
+ */
+void hantro_g2_reset(struct hantro_ctx *ctx)
+{
+	struct hantro_dev *vpu = ctx->dev;
+	u32 status;
+
+	status = vdpu_read(vpu, G2_REG_INTERRUPT);
+	if (status & G2_REG_INTERRUPT_DEC_E) {
+		dev_warn_ratelimited(vpu->dev, "device still running, aborting");
+		status |= G2_REG_INTERRUPT_DEC_ABORT_E | G2_REG_INTERRUPT_DEC_IRQ_DIS;
+		vdpu_write(vpu, status, G2_REG_INTERRUPT);
+
+		do {
+			mdelay(1);
+		} while (hantro_g2_active(ctx));
 	}
 }
 
 irqreturn_t hantro_g2_irq(int irq, void *dev_id)
 {
 	struct hantro_dev *vpu = dev_id;
-	enum vb2_buffer_state state;
 	u32 status;
 
 	status = vdpu_read(vpu, G2_REG_INTERRUPT);
-	state = (status & G2_REG_INTERRUPT_DEC_RDY_INT) ?
-		 VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
-	vdpu_write(vpu, 0, G2_REG_INTERRUPT);
-	vdpu_write(vpu, G2_REG_CONFIG_DEC_CLK_GATE_E, G2_REG_CONFIG);
+	if (!(status & G2_REG_INTERRUPT_DEC_IRQ))
+		return IRQ_NONE;
+
+	hantro_reg_write(vpu, &g2_dec_irq, 0);
+	hantro_reg_write(vpu, &g2_dec_int_stat, 0);
+	hantro_reg_write(vpu, &g2_clk_gate_e, 1);
+
+	if (status & G2_REG_INTERRUPT_DEC_RDY_INT) {
+		hantro_irq_done(vpu, VB2_BUF_STATE_DONE);
+		return IRQ_HANDLED;
+	}
+
+	if (status & G2_REG_INTERRUPT_DEC_ABORT_INT) {
+		/* disabled on abort, though lets be safe and handle it */
+		dev_warn_ratelimited(vpu->dev, "decode operation aborted.");
+		return IRQ_HANDLED;
+	}
+
+	if (status & G2_REG_INTERRUPT_DEC_LAST_SLICE_INT)
+		dev_warn_ratelimited(vpu->dev, "not all macroblocks were decoded.");
+
+	if (status & G2_REG_INTERRUPT_DEC_BUS_INT)
+		dev_warn_ratelimited(vpu->dev, "bus error detected.");
+
+	if (status & G2_REG_INTERRUPT_DEC_ERROR_INT)
+		dev_warn_ratelimited(vpu->dev, "decode error detected.");
+
+	if (status & G2_REG_INTERRUPT_DEC_TIMEOUT)
+		dev_warn_ratelimited(vpu->dev, "frame decode timed out.");
 
-	hantro_irq_done(vpu, state);
+	/**
+	 * If the decoding haven't stopped, let it continue. The hardware timeout
+	 * will trigger if it is trully stuck.
+	 */
+	if (status & G2_REG_INTERRUPT_DEC_E)
+		return IRQ_HANDLED;
 
+	hantro_irq_done(vpu, VB2_BUF_STATE_ERROR);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
index d1971af5f7fa..3c2160768d34 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
@@ -581,8 +581,6 @@ int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)
 	struct hantro_dev *vpu = ctx->dev;
 	int ret;
 
-	hantro_g2_check_idle(vpu);
-
 	/* Prepare HEVC decoder context. */
 	ret = hantro_hevc_dec_prepare_run(ctx);
 	if (ret)
diff --git a/drivers/media/platform/verisilicon/hantro_g2_regs.h b/drivers/media/platform/verisilicon/hantro_g2_regs.h
index 82606783591a..e238b1a308bb 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_regs.h
+++ b/drivers/media/platform/verisilicon/hantro_g2_regs.h
@@ -22,7 +22,14 @@
 #define G2_REG_VERSION			G2_SWREG(0)
 
 #define G2_REG_INTERRUPT		G2_SWREG(1)
+#define G2_REG_INTERRUPT_DEC_LAST_SLICE_INT	BIT(19)
+#define G2_REG_INTERRUPT_DEC_TIMEOUT	BIT(18)
+#define G2_REG_INTERRUPT_DEC_ERROR_INT	BIT(16)
+#define G2_REG_INTERRUPT_DEC_BUF_INT	BIT(14)
+#define G2_REG_INTERRUPT_DEC_BUS_INT	BIT(13)
 #define G2_REG_INTERRUPT_DEC_RDY_INT	BIT(12)
+#define G2_REG_INTERRUPT_DEC_ABORT_INT	BIT(11)
+#define G2_REG_INTERRUPT_DEC_IRQ	BIT(8)
 #define G2_REG_INTERRUPT_DEC_ABORT_E	BIT(5)
 #define G2_REG_INTERRUPT_DEC_IRQ_DIS	BIT(4)
 #define G2_REG_INTERRUPT_DEC_E		BIT(0)
@@ -35,6 +42,9 @@
 #define BUS_WIDTH_128			2
 #define BUS_WIDTH_256			3
 
+#define g2_dec_int_stat		G2_DEC_REG(1, 11, 0xf)
+#define g2_dec_irq		G2_DEC_REG(1, 8, 0x1)
+
 #define g2_strm_swap		G2_DEC_REG(2, 28, 0xf)
 #define g2_strm_swap_old	G2_DEC_REG(2, 27, 0x1f)
 #define g2_pic_swap		G2_DEC_REG(2, 22, 0x1f)
@@ -225,6 +235,9 @@
 #define vp9_filt_level_seg5	G2_DEC_REG(19,  8, 0x3f)
 #define vp9_quant_seg5		G2_DEC_REG(19,  0, 0xff)
 
+#define g2_timemout_override_e	G2_DEC_REG(45, 31, 0x1)
+#define g2_timemout_cycles	G2_DEC_REG(45, 0, 0x7fffffff)
+
 #define hevc_cur_poc_00		G2_DEC_REG(46, 24, 0xff)
 #define hevc_cur_poc_01		G2_DEC_REG(46, 16, 0xff)
 #define hevc_cur_poc_02		G2_DEC_REG(46, 8,  0xff)
diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
index 6fc4b555517f..1750f0e898bd 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
@@ -909,8 +909,6 @@ int hantro_g2_vp9_dec_run(struct hantro_ctx *ctx)
 	struct vb2_v4l2_buffer *dst;
 	int ret;
 
-	hantro_g2_check_idle(ctx->dev);
-
 	ret = start_prepare_run(ctx, &decode_params);
 	if (ret) {
 		hantro_end_prepare_run(ctx);
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index e83f0c523a30..c64d968d0474 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -436,6 +436,7 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx);
 int hantro_vp9_dec_init(struct hantro_ctx *ctx);
 void hantro_vp9_dec_exit(struct hantro_ctx *ctx);
 void hantro_g2_check_idle(struct hantro_dev *vpu);
+void hantro_g2_reset(struct hantro_ctx *ctx);
 irqreturn_t hantro_g2_irq(int irq, void *dev_id);
 
 #endif /* HANTRO_HW_H_ */
diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index b390228fd3b4..d89c2c3501aa 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -310,11 +310,13 @@ static const struct hantro_codec_ops imx8mq_vpu_g1_codec_ops[] = {
 static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
 	[HANTRO_MODE_HEVC_DEC] = {
 		.run = hantro_g2_hevc_dec_run,
+		.reset = hantro_g2_reset,
 		.init = hantro_hevc_dec_init,
 		.exit = hantro_hevc_dec_exit,
 	},
 	[HANTRO_MODE_VP9_DEC] = {
 		.run = hantro_g2_vp9_dec_run,
+		.reset = hantro_g2_reset,
 		.done = hantro_g2_vp9_dec_done,
 		.init = hantro_vp9_dec_init,
 		.exit = hantro_vp9_dec_exit,
-- 
2.51.0


