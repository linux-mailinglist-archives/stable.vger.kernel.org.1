Return-Path: <stable+bounces-45418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63248C93B6
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286881F21330
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 07:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473E17C6B;
	Sun, 19 May 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="uyHLxjhM"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294061C2E;
	Sun, 19 May 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716104489; cv=none; b=jS5vDygh/mLd2FplBIuMGnsaYn4R6YkDsnxpWesULWs82JENGfzmSnF2jngJZmV3xfZcyMQ4O45ePHHHN1H2LaixuGvG308iOuNQ8aZ+bba8+s/kmck9uBXkOk8TmF219px3GOJ+axe6uGgQbleSKlhMuyeH3tX9YelwQZ3lud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716104489; c=relaxed/simple;
	bh=r7qebuKPlwDwTzkVFn4u2wgs6vKh7lR+jcu5oIF9jbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0nCN5O5UYfhlf7JkljGSR9JPxeE5o+gDxMmQ3+BwrUvUnn//iUbrYsmqmkQYw+bvmqxCBMCbFX0yKOZgwEi8Ky4oE6jY1UB8kE/lVD2Rh9ExP+hRBOYhVKVYfrb3ERLJCfjrZraUVRzQsqEBzjGRipynLqkOrOgMtVHZtf2NW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=uyHLxjhM; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716104484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iCzZwZj36Iz4vA1dDun7lszpPSZPxwDHKR4L5BLCjIg=;
	b=uyHLxjhMy3s5Tm8T1twQKRP6W5/3ZNw6oYwG7SQFEmrp6HRLn9yvjp+J4WS2RYr0/Xug/7
	IeOM96jyjfSeADjc5wXZsFDZ4PzL0NkAM2Hnekudu2iQACIYkoHkFHCOFZQeXs0KQi4HxY
	Qz7n9kvfBdnt6WINxFLWpbPNiVTQMrghArcTu81SSvTOh6mO29DLWYTeC6gHJwKnNw3QDj
	l0mR9Pwt6Iq2XP+guouOVkxYjVkvdwEhbxXV8CA2/ZQo//VrO1UA51+Be3fIRslylfuj3b
	CvzZt6Tv3PIRaXu12T4LcfDUSYbmP79QoZiW1g815fC0gY//CBQtKBSTSGN+YQ==
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
Subject: [PATCH 1/2] drm/rockchip: vop: clear DMA stop bit on flush on RK3066
Date: Sun, 19 May 2024 04:31:31 -0300
Message-ID: <20240519074019.10424-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On the RK3066, there is a bit that must be cleared on flush, otherwise
we do not get display output (at least for RGB).

Signed-off-by: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org
---
Hi! This was required to get display working on an old RK3066 tablet,
along with the next tiny patch in the series enabling the RGB output.

I have spent quite a lot of time banging my head against the wall debugging
that display (especially since at the same time a scaler chip is used for
LVDS encoding), but finally adding debug prints showed that RK3066_SYS_CTRL0
ended up being reset to all-zero after being written correctly upon init.
Looking at the register definitions in the vendor driver revealed that the
reason was pretty self-explanatory: "dma_stop".
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a13473b2d..d4daeba74 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1578,6 +1578,9 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	spin_lock(&vop->reg_lock);
 
+	/* If the chip has a DMA stop bit (RK3066), it must be cleared. */
+	VOP_REG_SET(vop, common, dma_stop, 0);
+
 	/* Enable AFBC if there is some AFBC window, disable otherwise. */
 	s = to_rockchip_crtc_state(crtc->state);
 	VOP_AFBC_SET(vop, enable, s->enable_afbc);
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
2.45.0


