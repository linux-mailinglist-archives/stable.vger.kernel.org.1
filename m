Return-Path: <stable+bounces-104298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D39F2694
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 23:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D06C164D6F
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 22:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECE1BC9E6;
	Sun, 15 Dec 2024 22:27:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C3A41;
	Sun, 15 Dec 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734301656; cv=none; b=Ta0bJoDamiXSXjbfCaBhEpDVX0ZzoOHwp4hu6FG1MoAJtTZEnwo1oEPuSUq95gLq9fZg+juMpLHWfxg5n+TmF5MletKq4QCpiWIB52bMuKARxt/KCRyTuFGkQ+VOf2oO+S39cgthNTIra4tMUffd2KY6ikxv0m1Xo/T90lHxt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734301656; c=relaxed/simple;
	bh=y9ECdaR/x9UTauFlwVvPjZJ2Cu2SqXvHOrC9C3SfedA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oRznExC++UqOxuxBqTpqt8Vnybob44OCfws11ASoO3hG3vGV9BCbVcldpefYru53sJG4ae1a+svg4bt04cfZSDcvUYir2E1F4TvxDqDjVCdVPz7x5tWzQrFK+4jqvkOQ4BWnbjK7yrwtok5LCMY9jcIhSSOl0qM6igm2pt4hiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tMwo8-000000002oV-1Trq;
	Sun, 15 Dec 2024 22:09:48 +0000
Date: Sun, 15 Dec 2024 22:09:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Justin Green <greenjustin@chromium.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: only touch DISP_REG_OVL_PITCH_MSB if AFBC is
 supported
Message-ID: <8c001c8e70d93d64d3ee6bf7dc5078d2783d4e32.1734300345.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Touching DISP_REG_OVL_PITCH_MSB leads to video overlay on MT2701, MT7623N
and probably other older SoCs being broken.

Only touching it on hardware which actually supports AFBC like it was
before commit c410fa9b07c3 ("drm/mediatek: Add AFBC support to Mediatek
DRM driver") fixes it.

Fixes: c410fa9b07c3 ("drm/mediatek: Add AFBC support to Mediatek DRM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index f731d4fbe8b6..321b40a387cd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -545,7 +545,7 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
 		mtk_ddp_write_relaxed(cmdq_pkt, hdr_pitch, &ovl->cmdq_reg, ovl->regs,
 				      DISP_REG_OVL_HDR_PITCH(ovl, idx));
-	} else {
+	} else if (ovl->data->supports_afbc) {
 		mtk_ddp_write_relaxed(cmdq_pkt,
 				      overlay_pitch.split_pitch.msb,
 				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
-- 
2.47.1


