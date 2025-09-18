Return-Path: <stable+bounces-168924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C708B23746
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992B05870D2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048592FDC53;
	Tue, 12 Aug 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3pwIkVE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546D29BDA9;
	Tue, 12 Aug 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025792; cv=none; b=JEnLVRw0xubTCvg4hW2eOSWzs1pOmqUS1bOvNwg7vpAxO7iKHYs+ByUF93fmMF0DztYckJADKs1ndlmoNU9OtpAMqBdH+axbMaZoyVgdFTx8jnATz8RmtroyjkRSY52TTWHBzibnKuYsZ5y3FkBBO7fBtO3Pzch7XxWtiUlPkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025792; c=relaxed/simple;
	bh=ABZlAUk9viHTY50PDzI3ojg2AbcWT2hHGXpTNJlh/OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9+3uDU/PV59Q/XuMdZRAg0G8RgzQNmj17mIk0f+w1Lwd57Kop6OI+lay4XoB7DgWHT3+kUf3U/ac712V2PmG7fq7WLuc8tLYdyAtJStvkig/52/4QNydYei6hw0rDotsaHZGvyMRvAU1WqJxhxEiAZrHcw0YhW4MsX8FXyyWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y3pwIkVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE5C4CEF0;
	Tue, 12 Aug 2025 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025792;
	bh=ABZlAUk9viHTY50PDzI3ojg2AbcWT2hHGXpTNJlh/OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3pwIkVEJZh4H+/eDCz+vSAsVXMaFTDOOXEmBPnikPd1HIK8moWh13ub6NPu3sKWX
	 CkGggqP69fWFuL3B0ZGTECTEjkCzO/VW64ROD1S1m4htqTGBe3JsBOi0mZJMJUQVw8
	 FBJTN68Q2gJPA4V0llso0Jcqbdc+M8eJs02MSnMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Yan <andy.yan@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 144/480] drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568
Date: Tue, 12 Aug 2025 19:45:52 +0200
Message-ID: <20250812174403.455652523@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit 3e89a8c6835476aa782da80585dee9ddae651eea ]

The all video ports of rk3568/rk3588 share the same OVL_LAYER_SEL
and OVL_PORT_SEL registers, and the configuration of these two registers
can be set to take effect when the vsync signal arrives at a certain Video
Port.

If two threads for two display output choose to update these two registers
simultaneously to meet their own plane adjustment requirements(change plane
zpos or switch plane from one crtc to another), then no matter which Video
Port'svsync signal we choose to follow for these two registers, the display
output of the other Video Port will be abnormal.
This is because the configuration of this Video Port does not take
effect at the right time (its configuration should take effect when its
VSYNC signal arrives).

In order to solve this problem, when performing plane migration or
change the zpos of planes, there are two things to be observed and
followed:

1. When a plane is migrated from one VP to another, the configuration of
   the layer can only take effect after the Port mux configuration is
   enabled.

2. When change the zpos of planes, we must ensure that the change for
   the previous VP takes effect before we proceed to change the next VP.
   Otherwise, the new configuration might overwrite the previous one for
   the previous VP, or it could lead to the configuration of the previous
   VP being take effect along with the VSYNC of the new VP.

This issue only occurs in scenarios where multi-display output is enabled.

Fixes: c5996e4ab109 ("drm/rockchip: vop2: Make overlay layer select register configuration take effect by vsync")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250421102156.424480-1-andyshrk@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 25 ++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 33 ++++++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 89 ++++++++++++++++++--
 3 files changed, 122 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 6b37ce3ee60b..186f6452a7d3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -146,25 +146,6 @@ static void vop2_unlock(struct vop2 *vop2)
 	mutex_unlock(&vop2->vop2_lock);
 }
 
-/*
- * Note:
- * The write mask function is documented but missing on rk3566/8, writes
- * to these bits have no effect. For newer soc(rk3588 and following) the
- * write mask is needed for register writes.
- *
- * GLB_CFG_DONE_EN has no write mask bit.
- *
- */
-static void vop2_cfg_done(struct vop2_video_port *vp)
-{
-	struct vop2 *vop2 = vp->vop2;
-	u32 val = RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
-
-	val |= BIT(vp->id) | (BIT(vp->id) << 16);
-
-	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
-}
-
 static void vop2_win_disable(struct vop2_win *win)
 {
 	vop2_win_write(win, VOP2_WIN_ENABLE, 0);
@@ -854,6 +835,11 @@ static void vop2_enable(struct vop2 *vop2)
 	if (vop2->version == VOP_VERSION_RK3588)
 		rk3588_vop2_power_domain_enable_all(vop2);
 
+	if (vop2->version <= VOP_VERSION_RK3588) {
+		vop2->old_layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+		vop2->old_port_sel = vop2_readl(vop2, RK3568_OVL_PORT_SEL);
+	}
+
 	vop2_writel(vop2, RK3568_REG_CFG_DONE, RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN);
 
 	/*
@@ -2728,6 +2714,7 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return dev_err_probe(drm->dev, vop2->irq, "cannot find irq for vop2\n");
 
 	mutex_init(&vop2->vop2_lock);
+	mutex_init(&vop2->ovl_lock);
 
 	ret = devm_request_irq(dev, vop2->irq, vop2_isr, IRQF_SHARED, dev_name(dev), vop2);
 	if (ret)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index fc3ecb9fcd95..fa5c56f16047 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -334,6 +334,19 @@ struct vop2 {
 	/* optional internal rgb encoder */
 	struct rockchip_rgb *rgb;
 
+	/*
+	 * Used to record layer selection configuration on rk356x/rk3588
+	 * as register RK3568_OVL_LAYER_SEL and RK3568_OVL_PORT_SEL are
+	 * shared for all the Video Ports.
+	 */
+	u32 old_layer_sel;
+	u32 old_port_sel;
+	/*
+	 * Ensure that the updates to these two registers(RKK3568_OVL_LAYER_SEL/RK3568_OVL_PORT_SEL)
+	 * take effect in sequence.
+	 */
+	struct mutex ovl_lock;
+
 	/* must be put at the end of the struct */
 	struct vop2_win win[];
 };
@@ -727,6 +740,7 @@ enum dst_factor_mode {
 #define RK3588_OVL_PORT_SEL__CLUSTER2			GENMASK(21, 20)
 #define RK3568_OVL_PORT_SEL__CLUSTER1			GENMASK(19, 18)
 #define RK3568_OVL_PORT_SEL__CLUSTER0			GENMASK(17, 16)
+#define RK3588_OVL_PORT_SET__PORT3_MUX			GENMASK(15, 12)
 #define RK3568_OVL_PORT_SET__PORT2_MUX			GENMASK(11, 8)
 #define RK3568_OVL_PORT_SET__PORT1_MUX			GENMASK(7, 4)
 #define RK3568_OVL_PORT_SET__PORT0_MUX			GENMASK(3, 0)
@@ -831,4 +845,23 @@ static inline struct vop2_win *to_vop2_win(struct drm_plane *p)
 	return container_of(p, struct vop2_win, base);
 }
 
+/*
+ * Note:
+ * The write mask function is documented but missing on rk3566/8, writes
+ * to these bits have no effect. For newer soc(rk3588 and following) the
+ * write mask is needed for register writes.
+ *
+ * GLB_CFG_DONE_EN has no write mask bit.
+ *
+ */
+static inline void vop2_cfg_done(struct vop2_video_port *vp)
+{
+	struct vop2 *vop2 = vp->vop2;
+	u32 val = RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
+
+	val |= BIT(vp->id) | (BIT(vp->id) << 16);
+
+	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
+}
+
 #endif /* _ROCKCHIP_DRM_VOP2_H */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 32c4ed685739..45c5e3987813 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2052,12 +2052,55 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 	}
 }
 
+static u32 rk3568_vop2_read_port_mux(struct vop2 *vop2)
+{
+	return vop2_readl(vop2, RK3568_OVL_PORT_SEL);
+}
+
+static void rk3568_vop2_wait_for_port_mux_done(struct vop2 *vop2)
+{
+	u32 port_mux_sel;
+	int ret;
+
+	/*
+	 * Spin until the previous port_mux figuration is done.
+	 */
+	ret = readx_poll_timeout_atomic(rk3568_vop2_read_port_mux, vop2, port_mux_sel,
+					port_mux_sel == vop2->old_port_sel, 0, 50 * 1000);
+	if (ret)
+		DRM_DEV_ERROR(vop2->dev, "wait port_mux done timeout: 0x%x--0x%x\n",
+			      port_mux_sel, vop2->old_port_sel);
+}
+
+static u32 rk3568_vop2_read_layer_cfg(struct vop2 *vop2)
+{
+	return vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+}
+
+static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2, u32 cfg)
+{
+	u32 atv_layer_cfg;
+	int ret;
+
+	/*
+	 * Spin until the previous layer configuration is done.
+	 */
+	ret = readx_poll_timeout_atomic(rk3568_vop2_read_layer_cfg, vop2, atv_layer_cfg,
+					atv_layer_cfg == cfg, 0, 50 * 1000);
+	if (ret)
+		DRM_DEV_ERROR(vop2->dev, "wait layer cfg done timeout: 0x%x--0x%x\n",
+			      atv_layer_cfg, cfg);
+}
+
 static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
+	u32 old_layer_sel = 0;
+	u32 atv_layer_sel = 0;
+	u32 old_port_sel = 0;
 	u8 layer_id;
 	u8 old_layer_id;
 	u8 layer_sel_id;
@@ -2069,19 +2112,18 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct vop2_video_port *vp2 = &vop2->vps[2];
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
+	mutex_lock(&vop2->ovl_lock);
 	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
 	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
 	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL;
-	ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
 
 	if (vcstate->yuv_overlay)
 		ovl_ctrl |= RK3568_OVL_CTRL__YUV_MODE(vp->id);
 	else
 		ovl_ctrl &= ~RK3568_OVL_CTRL__YUV_MODE(vp->id);
 
-	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
-
-	port_sel = vop2_readl(vop2, RK3568_OVL_PORT_SEL);
+	old_port_sel = vop2->old_port_sel;
+	port_sel = old_port_sel;
 	port_sel &= RK3568_OVL_PORT_SEL__SEL_PORT;
 
 	if (vp0->nlayers)
@@ -2102,7 +2144,13 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	else
 		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX, 8);
 
-	layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+	/* Fixed value for rk3588 */
+	if (vop2->version == VOP_VERSION_RK3588)
+		port_sel |= FIELD_PREP(RK3588_OVL_PORT_SET__PORT3_MUX, 7);
+
+	atv_layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
+	old_layer_sel = vop2->old_layer_sel;
+	layer_sel = old_layer_sel;
 
 	ofs = 0;
 	for (i = 0; i < vp->id; i++)
@@ -2186,8 +2234,37 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 			     old_win->data->layer_sel_id[vp->id]);
 	}
 
+	vop2->old_layer_sel = layer_sel;
+	vop2->old_port_sel = port_sel;
+	/*
+	 * As the RK3568_OVL_LAYER_SEL and RK3568_OVL_PORT_SEL are shared by all Video Ports,
+	 * and the configuration take effect by one Video Port's vsync.
+	 * When performing layer migration or change the zpos of layers, there are two things
+	 * to be observed and followed:
+	 * 1. When a layer is migrated from one VP to another, the configuration of the layer
+	 *    can only take effect after the Port mux configuration is enabled.
+	 *
+	 * 2. When we change the zpos of layers, we must ensure that the change for the previous
+	 *    VP takes effect before we proceed to change the next VP. Otherwise, the new
+	 *    configuration might overwrite the previous one for the previous VP, or it could
+	 *    lead to the configuration of the previous VP being take effect along with the VSYNC
+	 *    of the new VP.
+	 */
+	if (layer_sel != old_layer_sel || port_sel != old_port_sel)
+		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
+	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
+
+	if (port_sel != old_port_sel) {
+		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
+		vop2_cfg_done(vp);
+		rk3568_vop2_wait_for_port_mux_done(vop2);
+	}
+
+	if (layer_sel != old_layer_sel && atv_layer_sel != old_layer_sel)
+		rk3568_vop2_wait_for_layer_cfg_done(vop2, vop2->old_layer_sel);
+
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
-	vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
+	mutex_unlock(&vop2->ovl_lock);
 }
 
 static void rk3568_vop2_setup_dly_for_windows(struct vop2_video_port *vp)
-- 
2.39.5




