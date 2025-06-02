Return-Path: <stable+bounces-148441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F3ACA2CB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5AE7A640D
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E4272E55;
	Sun,  1 Jun 2025 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXXO5zzJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933302741A0;
	Sun,  1 Jun 2025 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820499; cv=none; b=VboTyEnp8hh2lcOrQrtPNeCjTe7+7gQodeLO8dV2CF1nYdzp/+GEkrJWg/DMQ1x8ZeB8+3xG3zyqbjaMSISms1uF5XaNICDJjHEc1e+YFxAjO9hQA3awQZo3QXLBuvxlCUjSdaVGCPONmXAYwbXtPDNI8/H66kdosNFXGadkbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820499; c=relaxed/simple;
	bh=BWNJhM0B0GwzMuWy0DnZNuBNkJMk5bCJMu8giMnnk8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVKEpl+iqqjC4WPGan85qjkTlsyXpWmXaxIPdpUmeKGC2lmPgYE/2Dak9vVH0xTKNOdW+KLGAHtQ02kCvHzD1oyekRUVqeC1Pr7IT9hmL2+tGo8HVwGPP078NZthtVdABnVxXESl/fyR/oDDe+xyM3/Zin2B29/FjAarhhCzBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXXO5zzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B4EC4CEEE;
	Sun,  1 Jun 2025 23:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820499;
	bh=BWNJhM0B0GwzMuWy0DnZNuBNkJMk5bCJMu8giMnnk8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXXO5zzJ0H0UZDe8chdiLCsP2Pq2H3qb0HJPiMo3tQPRM/4K6subAf5TBQSVoaZsx
	 RCtCvbXjAPYTb1MN8Q3uUUz3LJs0dUlRq43MrZ+7OhpMhrIkGKM8w9bWF0mQFkPVE3
	 052frskr4/KQdzAjIBdeLKbpgTHVAh6QpcyX8uwiRc962eBZWlRbHCL1mW9p/ybw46
	 Hca8twEuFrQbBVz8L4BN76pSvY98NJ7tLWIhFR9SP4+MHWmG/oswDNyKLqMgjohbmg
	 xSn6hhn/jYnlTfva06TY9+CW4FVIBPpaB0CM2pKK8cuuUhheXC850YIrKex61kqUqs
	 m2+LFxH5QdpeA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Andy Yan <andy.yan@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	hjc@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 075/110] drm/rockchip: vop2: Make overlay layer select register configuration take effect by vsync
Date: Sun,  1 Jun 2025 19:23:57 -0400
Message-Id: <20250601232435.3507697-75-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit c5996e4ab109c8bb5541453b20647eaaf9350f41 ]

Because the layer/window enable/disable is take effect by vsync, if the
overlay configuration of these layers does not follow vsync and
takes effect immediately instead, when multiple layers are dynamically
enable/disable, inconsistent display contents may be seen on the screen.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250318062024.4555-1-andyshrk@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the kernel repository context,
here is my assessment: **YES** This commit should be backported to
stable kernel trees for the following extensive reasons: ## Code
Analysis The commit addresses a critical timing synchronization issue in
the Rockchip VOP2 display controller. The changes are: 1. **Register Bit
Field Changes**: The commit modifies
`RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD` and introduces
`RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL` in the header file, indicating a
switch from immediate register updates to vsync-synchronized updates. 2.
**Timing Control Logic**: In `rk3568_vop2_setup_layer_mixer()`, the code
changes from: ```c ovl_ctrl |= RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD; //
Immediate mode ``` to: ```c ovl_ctrl &=
~RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD; // Remove immediate mode
ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
// Per-VP vsync sync ``` ## Why This Should Be Backported ### 1. **Fixes
User-Visible Display Corruption** The commit message explicitly states
it fixes "inconsistent display contents" when multiple layers are
dynamically enabled/disabled. This is a user-visible bug that affects
display quality and stability. ### 2. **Critical Display Functionality**
The overlay layer selection controls fundamental display pipeline
routing in VOP2. From examining similar commits, I found this subsystem
has had multiple recent layer-related fixes, indicating active issues in
this area that affect real users. ### 3. **Low Risk, High Impact
Change** - **Low Risk**: The change only modifies timing
synchronization, not display logic - **High Impact**: Affects any
Rockchip RK3568/RK3588 system using multiple display layers -
**Contained Scope**: Limited to VOP2 overlay timing control ### 4.
**Follows Stable Tree Criteria** - **Important bugfix**: Fixes visible
display artifacts - **Small and contained**: Only changes register
timing configuration - **No architectural changes**: Maintains existing
display logic - **Clear side effects**: Improves display consistency
during layer transitions ### 5. **Hardware Synchronization Issue** The
commit addresses a fundamental hardware synchronization problem where
layer enable/disable operations take effect at vsync, but overlay
configuration was taking effect immediately. This mismatch creates race
conditions causing display corruption during dynamic layer changes. ###
6. **Broad User Impact** Systems commonly affected include: - Video
players with overlay graphics - Compositing window managers - Embedded
displays with multiple UI layers - Any application dynamically managing
display layers The fix ensures that overlay layer selection changes are
properly synchronized with display refresh cycles, eliminating
intermediate corrupted states that users can see during layer
transitions. This is exactly the type of important, low-risk display fix
that stable trees should include.

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 680bedbb770e6..fc3ecb9fcd957 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -710,6 +710,7 @@ enum dst_factor_mode {
 
 #define VOP2_COLOR_KEY_MASK				BIT(31)
 
+#define RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL		GENMASK(31, 30)
 #define RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD		BIT(28)
 #define RK3568_OVL_CTRL__YUV_MODE(vp)			BIT(vp)
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 0a2840cbe8e22..32c4ed6857395 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2070,7 +2070,10 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 
 	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
-	ovl_ctrl |= RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
+	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_IMD;
+	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL;
+	ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
+
 	if (vcstate->yuv_overlay)
 		ovl_ctrl |= RK3568_OVL_CTRL__YUV_MODE(vp->id);
 	else
-- 
2.39.5


