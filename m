Return-Path: <stable+bounces-112461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DCA28CCD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7DC168E6B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD7FC0B;
	Wed,  5 Feb 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVoePS1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CB1494DF;
	Wed,  5 Feb 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763647; cv=none; b=PUVXphp4zon7/S1EjVb4FkkNfwSNNYdxrXpuyuBvF9sL8uYMtwYUhZFwBrMg4+mS/IAQXSLdAR3podyk/iaUF3ohRiF1a1J3V0xMMqKUwQ6WlzPOaUjRVzb7obIzPn4JCZxCTKvZIyhLfUv33CUu76Ts39oE3BuhUL6c20N4SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763647; c=relaxed/simple;
	bh=mgh3xNPZC64oMlIOl7QyUa1wUdlg2YZpKKNOI83O6OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDndCJE188Ajhg+b1xS0PoDcvsCudRvdExuLV1QU6BLEVpl04pfOaFWXVUp8pvgsPR5ZmZRWylxCAo+CTk3055YPlDCnFCzif3Gz9gWeWDPuzeYaoj/EwuW9IWx145ADApcqVlQ/M7JHnafyXSMv3VPHjE/M2m08/ZLHqyGKWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVoePS1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E3C4CED1;
	Wed,  5 Feb 2025 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763646;
	bh=mgh3xNPZC64oMlIOl7QyUa1wUdlg2YZpKKNOI83O6OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVoePS1BKUe8tz2gsnyWMQXcptiCuH5Kby7hVgZsbbUyvCAEWTs5k3oSQkumtYzqK
	 kvqvLUz3SyFQo+tn1NxKwbOOn7d//2X4EG3xAbyQW2NRTBaPwQElgOsDjpHrnbPH6q
	 8xfIa3tJ/69IRy+RV1EDv7efIzRIAqntK2irFZw4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Derek Foreman <derek.foreman@collabora.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/590] drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
Date: Wed,  5 Feb 2025 14:36:39 +0100
Message-ID: <20250205134456.942432705@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit 17b4b10a0df1a1421d5fbdc03bad0bd3799bc966 ]

The phy_id of cluster windws are not increase one for each window.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Tested-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20241209122943.2781431-6-andyshrk@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 30d03ff6c01f0..594923303a850 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2159,7 +2159,6 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2 *vop2, u8 port_id)
 
 static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_win)
 {
-	u32 offset = (main_win->data->phys_id * 0x10);
 	struct vop2_alpha_config alpha_config;
 	struct vop2_alpha alpha;
 	struct drm_plane_state *bottom_win_pstate;
@@ -2167,6 +2166,7 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	u16 src_glb_alpha_val, dst_glb_alpha_val;
 	bool premulti_en = false;
 	bool swap = false;
+	u32 offset = 0;
 
 	/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/top win */
 	bottom_win_pstate = main_win->base.state;
@@ -2185,6 +2185,22 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	vop2_parse_alpha(&alpha_config, &alpha);
 
 	alpha.src_color_ctrl.bits.src_dst_swap = swap;
+
+	switch (main_win->data->phys_id) {
+	case ROCKCHIP_VOP2_CLUSTER0:
+		offset = 0x0;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER1:
+		offset = 0x10;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER2:
+		offset = 0x20;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER3:
+		offset = 0x30;
+		break;
+	}
+
 	vop2_writel(vop2, RK3568_CLUSTER0_MIX_SRC_COLOR_CTRL + offset,
 		    alpha.src_color_ctrl.val);
 	vop2_writel(vop2, RK3568_CLUSTER0_MIX_DST_COLOR_CTRL + offset,
-- 
2.39.5




