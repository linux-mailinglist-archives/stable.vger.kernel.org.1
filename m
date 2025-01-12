Return-Path: <stable+bounces-108311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F6A0A7EB
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A71636C1
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5118A931;
	Sun, 12 Jan 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="roI4N2HI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E781891AB
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736673301; cv=none; b=JxSjxZWTCSAVUcAde0iQRe7EOHWGqe1FPyC/qYRUfL0qLPvkZgROe+1irczFCfAWVwUjSJdnjT6thgOPg7AShnii0BnfUMYe4LF6OCgn3v+VdSlEHHHM12FXyQGbYi7szintWfdxdr7FR71bGXDqCRwNLzlyfkgGx8sGaRR8cMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736673301; c=relaxed/simple;
	bh=/du7soGkC6hy/+9sgHyIX1R/qj4Em6UvrePtgT/ZWBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OW2z+3HPy3Qloxaf5jP0oqoct2RvhDu2GO7LzPSHdTG4uQNwJr3Y+0NIUKB50qh3AiG2S86Gzq6PligcLG3yfgRiKK/3lmWGXsQRZcJc2y1S6wzgIHXHlREr6Pi0DhByoM7ZbrVM/ZrWQjpsMf0dYf7Gt30Np/OuuyDSQbCgbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=roI4N2HI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF55DC4CEDF;
	Sun, 12 Jan 2025 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736673301;
	bh=/du7soGkC6hy/+9sgHyIX1R/qj4Em6UvrePtgT/ZWBg=;
	h=Subject:To:Cc:From:Date:From;
	b=roI4N2HIK6x+vlCBJ5qvM1kMhUHt8ec5ulZaIRrTlt3VfACIB7lv90eRAgxtKcyuB
	 QHHuT3PEkWjxUlmUpfCEunydJw9H9cpETNoacQbPZ4INfPtjVmOKtC5l4NN/F8SXto
	 QEgs/wWvPH++R03ajJJuIIWlbTvNfwOHn43XQwpA=
Subject: FAILED: patch "[PATCH] drm/mediatek: Only touch DISP_REG_OVL_PITCH_MSB if AFBC is" failed to apply to 6.12-stable tree
To: daniel@makrotopia.org,chunkuang.hu@kernel.org,ck.hu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Jan 2025 10:14:58 +0100
Message-ID: <2025011258-registrar-obsessed-eb25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f8d9b91739e1fb436447c437a346a36deb676a36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011258-registrar-obsessed-eb25@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8d9b91739e1fb436447c437a346a36deb676a36 Mon Sep 17 00:00:00 2001
From: Daniel Golle <daniel@makrotopia.org>
Date: Tue, 17 Dec 2024 01:18:01 +0000
Subject: [PATCH] drm/mediatek: Only touch DISP_REG_OVL_PITCH_MSB if AFBC is
 supported

Touching DISP_REG_OVL_PITCH_MSB leads to video overlay on MT2701, MT7623N
and probably other older SoCs being broken.

Move setting up AFBC layer configuration into a separate function only
being called on hardware which actually supports AFBC which restores the
behavior as it was before commit c410fa9b07c3 ("drm/mediatek: Add AFBC
support to Mediatek DRM driver") on non-AFBC hardware.

Fixes: c410fa9b07c3 ("drm/mediatek: Add AFBC support to Mediatek DRM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/c7fbd3c3e633c0b7dd6d1cd78ccbdded31e1ca0f.1734397800.git.daniel@makrotopia.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index e0c0bb01f65a..0e4da239cbeb 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -460,6 +460,29 @@ static unsigned int mtk_ovl_fmt_convert(struct mtk_disp_ovl *ovl,
 	}
 }
 
+static void mtk_ovl_afbc_layer_config(struct mtk_disp_ovl *ovl,
+				      unsigned int idx,
+				      struct mtk_plane_pending_state *pending,
+				      struct cmdq_pkt *cmdq_pkt)
+{
+	unsigned int pitch_msb = pending->pitch >> 16;
+	unsigned int hdr_pitch = pending->hdr_pitch;
+	unsigned int hdr_addr = pending->hdr_addr;
+
+	if (pending->modifier != DRM_FORMAT_MOD_LINEAR) {
+		mtk_ddp_write_relaxed(cmdq_pkt, hdr_addr, &ovl->cmdq_reg, ovl->regs,
+				      DISP_REG_OVL_HDR_ADDR(ovl, idx));
+		mtk_ddp_write_relaxed(cmdq_pkt,
+				      OVL_PITCH_MSB_2ND_SUBBUF | pitch_msb,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
+		mtk_ddp_write_relaxed(cmdq_pkt, hdr_pitch, &ovl->cmdq_reg, ovl->regs,
+				      DISP_REG_OVL_HDR_PITCH(ovl, idx));
+	} else {
+		mtk_ddp_write_relaxed(cmdq_pkt, pitch_msb,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
+	}
+}
+
 void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 			  struct mtk_plane_state *state,
 			  struct cmdq_pkt *cmdq_pkt)
@@ -467,25 +490,13 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 	struct mtk_plane_pending_state *pending = &state->pending;
 	unsigned int addr = pending->addr;
-	unsigned int hdr_addr = pending->hdr_addr;
-	unsigned int pitch = pending->pitch;
-	unsigned int hdr_pitch = pending->hdr_pitch;
+	unsigned int pitch_lsb = pending->pitch & GENMASK(15, 0);
 	unsigned int fmt = pending->format;
 	unsigned int offset = (pending->y << 16) | pending->x;
 	unsigned int src_size = (pending->height << 16) | pending->width;
 	unsigned int blend_mode = state->base.pixel_blend_mode;
 	unsigned int ignore_pixel_alpha = 0;
 	unsigned int con;
-	bool is_afbc = pending->modifier != DRM_FORMAT_MOD_LINEAR;
-	union overlay_pitch {
-		struct split_pitch {
-			u16 lsb;
-			u16 msb;
-		} split_pitch;
-		u32 pitch;
-	} overlay_pitch;
-
-	overlay_pitch.pitch = pitch;
 
 	if (!pending->enable) {
 		mtk_ovl_layer_off(dev, idx, cmdq_pkt);
@@ -524,11 +535,12 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	}
 
 	if (ovl->data->supports_afbc)
-		mtk_ovl_set_afbc(ovl, cmdq_pkt, idx, is_afbc);
+		mtk_ovl_set_afbc(ovl, cmdq_pkt, idx,
+				 pending->modifier != DRM_FORMAT_MOD_LINEAR);
 
 	mtk_ddp_write_relaxed(cmdq_pkt, con, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_CON(idx));
-	mtk_ddp_write_relaxed(cmdq_pkt, overlay_pitch.split_pitch.lsb | ignore_pixel_alpha,
+	mtk_ddp_write_relaxed(cmdq_pkt, pitch_lsb | ignore_pixel_alpha,
 			      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH(idx));
 	mtk_ddp_write_relaxed(cmdq_pkt, src_size, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_SRC_SIZE(idx));
@@ -537,19 +549,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	mtk_ddp_write_relaxed(cmdq_pkt, addr, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_ADDR(ovl, idx));
 
-	if (is_afbc) {
-		mtk_ddp_write_relaxed(cmdq_pkt, hdr_addr, &ovl->cmdq_reg, ovl->regs,
-				      DISP_REG_OVL_HDR_ADDR(ovl, idx));
-		mtk_ddp_write_relaxed(cmdq_pkt,
-				      OVL_PITCH_MSB_2ND_SUBBUF | overlay_pitch.split_pitch.msb,
-				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
-		mtk_ddp_write_relaxed(cmdq_pkt, hdr_pitch, &ovl->cmdq_reg, ovl->regs,
-				      DISP_REG_OVL_HDR_PITCH(ovl, idx));
-	} else {
-		mtk_ddp_write_relaxed(cmdq_pkt,
-				      overlay_pitch.split_pitch.msb,
-				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
-	}
+	if (ovl->data->supports_afbc)
+		mtk_ovl_afbc_layer_config(ovl, idx, pending, cmdq_pkt);
 
 	mtk_ovl_set_bit_depth(dev, idx, fmt, cmdq_pkt);
 	mtk_ovl_layer_on(dev, idx, cmdq_pkt);


