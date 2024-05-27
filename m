Return-Path: <stable+bounces-47520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FE8D1070
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 01:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A6C1F21E66
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 23:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803213B293;
	Mon, 27 May 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="V+rroTeF"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89613AD04
	for <stable@vger.kernel.org>; Mon, 27 May 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716851565; cv=none; b=bsrbxFbxg8BpXVtLXxODKLxECGiKf1t2WVGIUI1qFzNfvVzdADnhqQBEPXi95vPmu/JPDkstbJ2PZqkGwiGGZiA59W8wwO21T4AzyHytkPFNVlFv+gjFOGbZWumWzBnVM80GiAWtfD54NNK2mZF5eCOegVGC5XU3FNobrRR6azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716851565; c=relaxed/simple;
	bh=0wmXGrXNl1JIddYv9SZqtoNICb7NDDFn9lXc8+3O4DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdKvjhBMhi/PLn55VA3H0pmgD1OFQjxsFlpJ/VEdpFSNoy1UUr187v0zCYMsmdej05IvL9QPFvSkjLQpg6lje6hOWdaPWzl+jhEOQaC2/W5y1ytiY5OMbiHGnrkV/nzmqWV4/02165ZcLpJjskE5oDPX4yAUiS8mGgfPjPf1LRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=V+rroTeF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716851561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NhJB2QVODdUA35I9pFEh6dmBBV56wUfJsZyxgaUD6Yc=;
	b=V+rroTeFfCggIU6g9FhwO+eUXGJJS0N0JEH51ksOYwRUE1xcX8iTW1M2Lz3MLIx3L8gEaE
	AMkJdPsStaC/7RR4woi4luZbmlVOy+Bd4AktN+ZMXGpthefQM4EVwhH+9IZCpRzwuU+lqQ
	wLNLgFWNkmVKrPD5uAScrjw0LRhXVUXb1PB2ovRXV7rOqnnUztJ+qUxrBfsrwFt7/g0L4b
	xLaL860E8FHpdok32JAMsdBjCjIvOUNAi0bqeHaCSFEBNpkapW4pBiZZorrZ+TbEjQx6AW
	BgB63Xzdtil7TkB9VqkaJG0js7plpSgPDkxcwaQXOsZnkv5QHfUWBKmX35mRdg==
X-Envelope-To: val@packett.cool
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: hjc@rock-chips.com
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
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: Val Packett <val@packett.cool>,
	stable@vger.kernel.org,
	Sandy Huang <hjc@rock-chips.com>,
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
Subject: [PATCH v3 1/2] drm/rockchip: vop: clear DMA stop bit upon vblank on RK3066
Date: Mon, 27 May 2024 20:11:49 -0300
Message-ID: <20240527231202.23365-1-val@packett.cool>
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

So unless we clear it "between" frames, the RGB output only shows noise
instead of the picture. vblank seems to be the most appropriate place to
do it, since it indicates exactly that: that the hardware is done
with the frame.

This seems to be a redundant synchronization mechanism that was removed
in later iterations of the VOP hardware block.

Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a13473b2d..2731fe2b2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1766,6 +1766,12 @@ static void vop_handle_vblank(struct vop *vop)
 	}
 	spin_unlock(&drm->event_lock);
 
+	if (VOP_HAS_REG(vop, common, dma_stop)) {
+		spin_lock(&vop->reg_lock);
+		VOP_REG_SET(vop, common, dma_stop, 0);
+		spin_unlock(&vop->reg_lock);
+	}
+
 	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
 		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
 }
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
2.45.1


