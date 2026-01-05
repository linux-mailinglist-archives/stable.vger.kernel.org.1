Return-Path: <stable+bounces-204635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65DDCF30B6
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9266F303DD3E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAA3195EC;
	Mon,  5 Jan 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0rjYFtg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69757316918
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609672; cv=none; b=US9Emq8s3q5Wk846iY9QojcSIaV2HNnG3lMAF6qkWIcrjxS44eczONBHMyB01HP7Lu5mNY5PYiKDTP96G3XG3eUANlc5QGWV09PPEZJCvW+t91dK7fA1vtrlX58zXhMZanbOTV0uytNZcqmqPB7vV6Sao+6A8fBV5+ictHglD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609672; c=relaxed/simple;
	bh=qey6RYwt0vwb2LDKRYt1jA+1JB42w1eR3SxEcFW7R8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RPPcv1umKHxxJC6Uwxe7FEjXyeNyhLRKX162bXysj3qJk5RFMvZ8lur1z+TnEJ2R92i00zJKFPHNM4gnIO2Xik4XQ/d2ZriAdqlMdcPz4obOVD5Keuv7B5hBbhWIol56ekYMETMrRQd8C86wJcWKgL+YJ/TUI59DEBrg6lLBltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0rjYFtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C17AC116D0;
	Mon,  5 Jan 2026 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767609670;
	bh=qey6RYwt0vwb2LDKRYt1jA+1JB42w1eR3SxEcFW7R8c=;
	h=Subject:To:Cc:From:Date:From;
	b=x0rjYFtg19m7xo2B8cI9FX+LglCc+Oekx2GPvOghcDXp+DJEEBqv1we1mhs8RBfUQ
	 yIapA6QoNijEXmGVY+LhJcT4RQ6GpssocLumss2TQSrUf/4UZgZsH047Uup+sZMXXk
	 DcpLf1gDTpOnJiqD94g4J1OvhVDVE2P5q0ZDiM6g=
Subject: FAILED: patch "[PATCH] media: verisilicon: Fix CPU stalls on G2 bus error" failed to apply to 6.6-stable tree
To: nicolas.dufresne@collabora.com,benjamin.gaignard@collabora.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:41:07 +0100
Message-ID: <2026010507-cringe-sterile-73c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 19c286b755072a22a063052f530a6b1fac8a1f63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010507-cringe-sterile-73c8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19c286b755072a22a063052f530a6b1fac8a1f63 Mon Sep 17 00:00:00 2001
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Date: Mon, 22 Sep 2025 14:43:38 -0400
Subject: [PATCH] media: verisilicon: Fix CPU stalls on G2 bus error

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

diff --git a/drivers/media/platform/verisilicon/hantro_g2.c b/drivers/media/platform/verisilicon/hantro_g2.c
index aae0b562fabb..318673b66da8 100644
--- a/drivers/media/platform/verisilicon/hantro_g2.c
+++ b/drivers/media/platform/verisilicon/hantro_g2.c
@@ -5,43 +5,93 @@
  * Copyright (C) 2021 Collabora Ltd, Andrzej Pietrasiewicz <andrzej.p@collabora.com>
  */
 
+#include <linux/delay.h>
 #include "hantro_hw.h"
 #include "hantro_g2_regs.h"
 
 #define G2_ALIGN	16
 
-void hantro_g2_check_idle(struct hantro_dev *vpu)
+static bool hantro_g2_active(struct hantro_ctx *ctx)
 {
-	int i;
+	struct hantro_dev *vpu = ctx->dev;
+	u32 status;
 
-	for (i = 0; i < 3; i++) {
-		u32 status;
+	status = vdpu_read(vpu, G2_REG_INTERRUPT);
 
-		/* Make sure the VPU is idle */
-		status = vdpu_read(vpu, G2_REG_INTERRUPT);
-		if (status & G2_REG_INTERRUPT_DEC_E) {
-			dev_warn(vpu->dev, "device still running, aborting");
-			status |= G2_REG_INTERRUPT_DEC_ABORT_E | G2_REG_INTERRUPT_DEC_IRQ_DIS;
-			vdpu_write(vpu, status, G2_REG_INTERRUPT);
-		}
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
 
-	hantro_irq_done(vpu, state);
+	hantro_reg_write(vpu, &g2_dec_irq, 0);
+	hantro_reg_write(vpu, &g2_dec_int_stat, 0);
+	hantro_reg_write(vpu, &g2_clk_gate_e, 1);
 
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
+
+	/**
+	 * If the decoding haven't stopped, let it continue. The hardware timeout
+	 * will trigger if it is trully stuck.
+	 */
+	if (status & G2_REG_INTERRUPT_DEC_E)
+		return IRQ_HANDLED;
+
+	hantro_irq_done(vpu, VB2_BUF_STATE_ERROR);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
index 0e212198dd65..f066636e56f9 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c
@@ -582,8 +582,6 @@ int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)
 	struct hantro_dev *vpu = ctx->dev;
 	int ret;
 
-	hantro_g2_check_idle(vpu);
-
 	/* Prepare HEVC decoder context. */
 	ret = hantro_hevc_dec_prepare_run(ctx);
 	if (ret)
diff --git a/drivers/media/platform/verisilicon/hantro_g2_regs.h b/drivers/media/platform/verisilicon/hantro_g2_regs.h
index b943b1816db7..c614951121c7 100644
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
index 82a478ac645e..56c79e339030 100644
--- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
@@ -893,8 +893,6 @@ int hantro_g2_vp9_dec_run(struct hantro_ctx *ctx)
 	struct vb2_v4l2_buffer *dst;
 	int ret;
 
-	hantro_g2_check_idle(ctx->dev);
-
 	ret = start_prepare_run(ctx, &decode_params);
 	if (ret) {
 		hantro_end_prepare_run(ctx);
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index c9b6556f8b2b..5f2011529f02 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -583,6 +583,7 @@ void hantro_g2_vp9_dec_done(struct hantro_ctx *ctx);
 int hantro_vp9_dec_init(struct hantro_ctx *ctx);
 void hantro_vp9_dec_exit(struct hantro_ctx *ctx);
 void hantro_g2_check_idle(struct hantro_dev *vpu);
+void hantro_g2_reset(struct hantro_ctx *ctx);
 irqreturn_t hantro_g2_irq(int irq, void *dev_id);
 
 #endif /* HANTRO_HW_H_ */
diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index f9f276385c11..5be0e2e76882 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -294,11 +294,13 @@ static const struct hantro_codec_ops imx8mq_vpu_g1_codec_ops[] = {
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


