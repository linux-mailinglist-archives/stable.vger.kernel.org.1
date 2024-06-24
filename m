Return-Path: <stable+bounces-55103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39491582B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 22:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99C31C21CE2
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE761A0AFD;
	Mon, 24 Jun 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="aKTzGVGQ"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715B1A08CA
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261703; cv=none; b=gD5kiBnPUSDfQzKs7Yr/4mvyMAnwChNCllAiowxhqmGitdCPX+3mMIGirvsU6eCEA1J8nKtVl6hbroRPw0LgOh7V0oKdpUI1hZIKHKNRCgjHlX3UEUGD1eZPlyLsIs1JovYTmhs3YG3Itp8AfR5fcWQ3lHsHzN1XLeM6yOuUCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261703; c=relaxed/simple;
	bh=SpEcgF+fnF0/U+HAnrXTQeOcOE/TyuaAS0xcGefqEYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDTy2tUlR3dkKYUjFTgHbEUAzFjt6IMfsT1pqDJdGVtm1Diebd3p2g5SndSFPwfXZLwK7T60ei+QRfctLstUl1tY5iRrQFW7Kij2CfEiRQ64o/Hb35vQ/TBsJfikgpBijbAIXe96JEP136krGBOBdMBD3IsHMHO7nT0Waa+yRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=aKTzGVGQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1719261699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybNct5VISNj9THQmTwh5irL9J90lY2CWVHgOZSZgZdY=;
	b=aKTzGVGQFfcBAmyxxxVdXouKRzMC/qDAjVqrVesHY7zCjjaktkFomQJ8+zq+fr684XhO9M
	Ol1ocuf1jOorb7Et5gD0mSIUQZ5JsQ/EF48Kr0viSD3pHeaWcUsXUuMKNLBu5TuCLCBHIw
	/l2XYoFh3A8jFP2FGYZz430++y2U/uQsVikeycgv4ArJDgXcbVDi3FWsf4HYQhkCHDoX2c
	EvwIwfhm6Ror4WreNMn0GWGtmm5Ymrz5lihpTrfIMOP+UY5ZqaZt62zzEf9Um0+OzdfOsO
	rtrCYR9l6YQQQnLEnBaMFrIOsOJmDV+rbmoeOc4RKa1hQoJ8oYKxPxi//qav4Q==
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	stable@vger.kernel.org,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] drm/rockchip: vop: clear DMA stop bit on RK3066
Date: Mon, 24 Jun 2024 17:40:48 -0300
Message-ID: <20240624204054.5524-2-val@packett.cool>
In-Reply-To: <20240624204054.5524-1-val@packett.cool>
References: <20240624204054.5524-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The RK3066 VOP sets a dma_stop bit when it's done scanning out a frame
and needs the driver to acknowledge that by clearing the bit.

Unless we clear it "between" frames, the RGB output only shows noise
instead of the picture. atomic_flush is the place for it that least
affects other code (doing it on vblank would require converting all
other usages of the reg_lock to spin_(un)lock_irq, which would affect
performance for everyone).

This seems to be a redundant synchronization mechanism that was removed
in later iterations of the VOP hardware block.

Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a13473b2d..e88fbd568 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1583,6 +1583,10 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	VOP_AFBC_SET(vop, enable, s->enable_afbc);
 	vop_cfg_done(vop);
 
+	/* Ack the DMA transfer of the previous frame (RK3066). */
+	if (VOP_HAS_REG(vop, common, dma_stop))
+		VOP_REG_SET(vop, common, dma_stop, 0);
+
 	spin_unlock(&vop->reg_lock);
 
 	/*
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index b33e5bdc2..0cf512cc1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -122,6 +122,7 @@ struct vop_common {
 	struct vop_reg lut_buffer_index;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
+	struct vop_reg dma_stop;
 	struct vop_reg out_mode;
 	struct vop_reg standby;
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b9ee02061..9bcb40a64 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -466,6 +466,7 @@ static const struct vop_output rk3066_output = {
 };
 
 static const struct vop_common rk3066_common = {
+	.dma_stop = VOP_REG(RK3066_SYS_CTRL0, 0x1, 0),
 	.standby = VOP_REG(RK3066_SYS_CTRL0, 0x1, 1),
 	.out_mode = VOP_REG(RK3066_DSP_CTRL0, 0xf, 0),
 	.cfg_done = VOP_REG(RK3066_REG_CFG_DONE, 0x1, 0),
-- 
2.45.2


