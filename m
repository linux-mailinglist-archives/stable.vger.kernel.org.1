Return-Path: <stable+bounces-112631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6582AA28DAA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD4E164DC4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3E2E634;
	Wed,  5 Feb 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQbRlzgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D915198D;
	Wed,  5 Feb 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764220; cv=none; b=O9yY392Xtxy9atcOMlnitlZSOugBx/iKVSvoT5SAlOg/1qPRTXsCowOORvfRLwjIqoY3wFcuX62bRAN0g0Z83vxqTAYO+QCmSev6WDgrSGTx+R5yeAx/QZK+tcpeRwuFBwJyCuCac4XoXFkhcKDjLQl3s3TY6K6kuBI5MoOsJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764220; c=relaxed/simple;
	bh=NlER7QQQFkLtxSZ/DvnQYsG0lnZHPUbcRz8X9eI6fiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTrSl/AsPwLmOLNhFwDHs5RcEUbTgKFgziNfF7j7XbyiGkvyfNryo2ZRf6Grm7aga0N3Pt64c2Z/JcxtwMGsociA+jUtwTptN9OOeUnUbTe9cBOY4MgwnjqXakdwaSQL4NjHwv0QcTyY/7w34wiCBdi2wa4aoNS91MISFCsXuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQbRlzgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142FAC4CED1;
	Wed,  5 Feb 2025 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764220;
	bh=NlER7QQQFkLtxSZ/DvnQYsG0lnZHPUbcRz8X9eI6fiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQbRlzgA8KhAyEaCqQALPPzGOqRMzUGIcW7+kfnNCwHWT19nn/4DAXnJMyZ4tzo67
	 g84aa/OebB/roRwXs56t1YDiBOlXqE2Prrvsomz9TBSUgxeZz3xnpzZTvNlPwamHO5
	 ygV1s/PoQaG5u417pjhXixSH4cbpx5NhTIHN2kI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Yan <andy.yan@rock-chips.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 058/623] drm/rockchip: vop2: Set AXI id for rk3588
Date: Wed,  5 Feb 2025 14:36:40 +0100
Message-ID: <20250205134458.447349841@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit 7b256880fdb2d7f23393b87bb557090f049e686a ]

There are two AXI bus in vop2, windows attached on the same bus must
have a unique channel YUV and RGB channel ID.

The default IDs will conflict with each other on the rk3588, so they
need to be reassigned.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Derek Foreman <derek.foreman@collabora.com>
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20241214081719.3330518-4-andyshrk@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 14 +++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  9 +++++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 26 +++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 60b498ffd41aa..cd3fb906d0089 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1320,6 +1320,12 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		&fb->format->format,
 		afbc_en ? "AFBC" : "", &yrgb_mst);
 
+	if (vop2->data->soc_id > 3568) {
+		vop2_win_write(win, VOP2_WIN_AXI_BUS_ID, win->data->axi_bus_id);
+		vop2_win_write(win, VOP2_WIN_AXI_YRGB_R_ID, win->data->axi_yrgb_r_id);
+		vop2_win_write(win, VOP2_WIN_AXI_UV_R_ID, win->data->axi_uv_r_id);
+	}
+
 	if (vop2_cluster_window(win))
 		vop2_win_write(win, VOP2_WIN_AFBC_HALF_BLOCK_EN, half_block_en);
 
@@ -2908,6 +2914,10 @@ static struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_Y2R_EN] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 8, 8),
 	[VOP2_WIN_R2Y_EN] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 9, 9),
 	[VOP2_WIN_CSC_MODE] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL0, 10, 11),
+	[VOP2_WIN_AXI_YRGB_R_ID] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL2, 0, 3),
+	[VOP2_WIN_AXI_UV_R_ID] = REG_FIELD(RK3568_CLUSTER_WIN_CTRL2, 5, 8),
+	/* RK3588 only, reserved bit on rk3568*/
+	[VOP2_WIN_AXI_BUS_ID] = REG_FIELD(RK3568_CLUSTER_CTRL, 13, 13),
 
 	/* Scale */
 	[VOP2_WIN_SCALE_YRGB_X] = REG_FIELD(RK3568_CLUSTER_WIN_SCL_FACTOR_YRGB, 0, 15),
@@ -3000,6 +3010,10 @@ static struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_YMIRROR] = REG_FIELD(RK3568_SMART_CTRL1, 31, 31),
 	[VOP2_WIN_COLOR_KEY] = REG_FIELD(RK3568_SMART_COLOR_KEY_CTRL, 0, 29),
 	[VOP2_WIN_COLOR_KEY_EN] = REG_FIELD(RK3568_SMART_COLOR_KEY_CTRL, 31, 31),
+	[VOP2_WIN_AXI_YRGB_R_ID] = REG_FIELD(RK3568_SMART_CTRL1, 4, 8),
+	[VOP2_WIN_AXI_UV_R_ID] = REG_FIELD(RK3568_SMART_CTRL1, 12, 16),
+	/* RK3588 only, reserved register on rk3568 */
+	[VOP2_WIN_AXI_BUS_ID] = REG_FIELD(RK3588_SMART_AXI_CTRL, 1, 1),
 
 	/* Scale */
 	[VOP2_WIN_SCALE_YRGB_X] = REG_FIELD(RK3568_SMART_REGION0_SCL_FACTOR_YRGB, 0, 15),
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 615a16196aff6..1c4204324f9f5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -78,6 +78,9 @@ enum vop2_win_regs {
 	VOP2_WIN_COLOR_KEY,
 	VOP2_WIN_COLOR_KEY_EN,
 	VOP2_WIN_DITHER_UP,
+	VOP2_WIN_AXI_BUS_ID,
+	VOP2_WIN_AXI_YRGB_R_ID,
+	VOP2_WIN_AXI_UV_R_ID,
 
 	/* scale regs */
 	VOP2_WIN_SCALE_YRGB_X,
@@ -140,6 +143,10 @@ struct vop2_win_data {
 	unsigned int layer_sel_id;
 	uint64_t feature;
 
+	uint8_t axi_bus_id;
+	uint8_t axi_yrgb_r_id;
+	uint8_t axi_uv_r_id;
+
 	unsigned int max_upscale_factor;
 	unsigned int max_downscale_factor;
 	const u8 dly[VOP2_DLY_MODE_MAX];
@@ -308,6 +315,7 @@ enum dst_factor_mode {
 
 #define RK3568_CLUSTER_WIN_CTRL0		0x00
 #define RK3568_CLUSTER_WIN_CTRL1		0x04
+#define RK3568_CLUSTER_WIN_CTRL2		0x08
 #define RK3568_CLUSTER_WIN_YRGB_MST		0x10
 #define RK3568_CLUSTER_WIN_CBR_MST		0x14
 #define RK3568_CLUSTER_WIN_VIR			0x18
@@ -330,6 +338,7 @@ enum dst_factor_mode {
 /* (E)smart register definition, offset relative to window base */
 #define RK3568_SMART_CTRL0			0x00
 #define RK3568_SMART_CTRL1			0x04
+#define RK3588_SMART_AXI_CTRL			0x08
 #define RK3568_SMART_REGION0_CTRL		0x10
 #define RK3568_SMART_REGION0_YRGB_MST		0x14
 #define RK3568_SMART_REGION0_CBR_MST		0x18
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index f9d87a0abc8b0..6a6c15f2c9cc7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -313,7 +313,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
  * AXI1 is a read only bus.
  *
  * Every window on a AXI bus must assigned two unique
- * read id(yrgb_id/uv_id, valid id are 0x1~0xe).
+ * read id(yrgb_r_id/uv_r_id, valid id are 0x1~0xe).
  *
  * AXI0:
  * Cluster0/1, Esmart0/1, WriteBack
@@ -333,6 +333,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 0,
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 2,
+		.axi_uv_r_id = 3,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -349,6 +352,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 6,
+		.axi_uv_r_id = 7,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -364,6 +370,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 2,
+		.axi_uv_r_id = 3,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -379,6 +388,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 6,
+		.axi_uv_r_id = 7,
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
@@ -393,6 +405,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 2,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 0x0a,
+		.axi_uv_r_id = 0x0b,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
@@ -406,6 +421,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 3,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 0,
+		.axi_yrgb_r_id = 0x0c,
+		.axi_uv_r_id = 0x01,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
@@ -419,6 +437,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 6,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 0x0a,
+		.axi_uv_r_id = 0x0b,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
@@ -432,6 +453,9 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.layer_sel_id = 7,
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
+		.axi_bus_id = 1,
+		.axi_yrgb_r_id = 0x0c,
+		.axi_uv_r_id = 0x0d,
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
-- 
2.39.5




