Return-Path: <stable+bounces-108646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7182A11118
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E150B1889AE0
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16C1FC101;
	Tue, 14 Jan 2025 19:24:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510514A60C
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882684; cv=none; b=uOGj3GlaMUvUuR1SVZmyr32vKrkDyyiuiYbvKChCf0k5ULQeNtZSVmTNpkPztOZZfbU5MPq5Tz29wgLyRRoLzMOPkPyGbs/3Lum19ZvCeSFO1SxYAAGopXcg+uGwN1yMpex7r9UcoTLOzaFTiwnY1kYidtz1gSnQX3qhQ0PeLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882684; c=relaxed/simple;
	bh=o45MAMrCA7wvoqnK4eDlsnOU0b88J447QUTCrUvnjoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDtWIe1VPtjAZgzqCuBn/E3nAbrsuIZ1BkHMgqubHoM/4C5/WJg0YLOiyDvYzwwQ12dQmPuq+PQOjzWOMkX33nKAvlvSReLUpgc8bViB+yq1avmDBPtHGdgQMJv+J2OBaiRlP8bn25eVmQNYPJS1Sx46LCah/wcod0YxtzoADAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tXmWd-000000003pJ-14r5;
	Tue, 14 Jan 2025 19:24:31 +0000
Date: Tue, 14 Jan 2025 19:24:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, chunkuang.hu@kernel.org, ck.hu@mediatek.com
Subject: [PATCH 6.12.y] drm/mediatek: Only touch DISP_REG_OVL_PITCH_MSB if
 AFBC is supported
Message-ID: <Z4PLxgujddAwrJaR@makrotopia.org>
References: <2025011258-registrar-obsessed-eb25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011258-registrar-obsessed-eb25@gregkh>

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
(cherry picked from commit f8d9b91739e1fb436447c437a346a36deb676a36)
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 57 +++++++++++++------------
 1 file changed, 29 insertions(+), 28 deletions(-)

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
-- 
2.47.1


