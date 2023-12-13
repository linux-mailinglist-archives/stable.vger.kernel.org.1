Return-Path: <stable+bounces-6326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB78180DA1D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACA31C2168B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99C524C0;
	Mon, 11 Dec 2023 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9g5tRRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8FE548;
	Mon, 11 Dec 2023 18:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EA7C433C8;
	Mon, 11 Dec 2023 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321127;
	bh=ftLwvQ+V4Kb0tg2ypGpoc3mCSiqkOZK7SZkE7ZtNYzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9g5tRRl8YzfmBbULFwL1gGzlnLAETW+mKMqyL34qdlO0qIJv3Lts23cTerSOKtKu
	 kyMAf59uhjqDQIN1JtTd32vXGN+eeo4aV8hSb2Nx6JyLytDXs9XFrMVA0QG3txkhEe
	 JfBYl5CMpxgm8e8HlFQApWi6ylS33/9haov4cDR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 119/141] drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c
Date: Mon, 11 Dec 2023 19:22:58 +0100
Message-ID: <20231211182031.730133634@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 93125cb704919f572c01e02ef64923caff1c3164 ]

Fixes the below checkpatch.pl warnings:

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
WARNING: suspect code indent for conditional statements (8, 12)
WARNING: braces {} are not necessary for single statement blocks

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: c6df7f313794 ("drm/amdgpu: correct the amdgpu runtime dereference usage count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 42 ++++++++++++---------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d2286a83e302f..2952f89734487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -80,7 +80,7 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 
 	struct drm_crtc *crtc = &amdgpu_crtc->base;
 	unsigned long flags;
-	unsigned i;
+	unsigned int i;
 	int vpos, hpos;
 
 	if (amdgpu_display_flip_handle_fence(work, &work->excl))
@@ -159,7 +159,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	u64 tiling_flags;
 	int i, r;
 
-	work = kzalloc(sizeof *work, GFP_KERNEL);
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
 	if (work == NULL)
 		return -ENOMEM;
 
@@ -290,13 +290,15 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	adev = drm_to_adev(dev);
 	/* if we have active crtcs and we don't have a power ref,
-	   take the current one */
+	 * take the current one
+	 */
 	if (active && !adev->have_disp_power_ref) {
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
 	/* if we have no active crtcs, then drop the power ref
-	   we got before */
+	 * we got before
+	 */
 	if (!active && adev->have_disp_power_ref) {
 		pm_runtime_put_autosuspend(dev->dev);
 		adev->have_disp_power_ref = false;
@@ -465,11 +467,10 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	if (amdgpu_connector->router.ddc_valid)
 		amdgpu_i2c_router_select_ddc_port(amdgpu_connector);
 
-	if (use_aux) {
+	if (use_aux)
 		ret = i2c_transfer(&amdgpu_connector->ddc_bus->aux.ddc, msgs, 2);
-	} else {
+	else
 		ret = i2c_transfer(&amdgpu_connector->ddc_bus->adapter, msgs, 2);
-	}
 
 	if (ret != 2)
 		/* Couldn't find an accessible DDC on this connector */
@@ -478,10 +479,12 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	 * EDID header starts with:
 	 * 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00.
 	 * Only the first 6 bytes must be valid as
-	 * drm_edid_block_valid() can fix the last 2 bytes */
+	 * drm_edid_block_valid() can fix the last 2 bytes
+	 */
 	if (drm_edid_header_is_valid(buf) < 6) {
 		/* Couldn't find an accessible EDID on this
-		 * connector */
+		 * connector
+		 */
 		return false;
 	}
 	return true;
@@ -1189,8 +1192,10 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-		drm_dbg_kms(dev, "No GEM object associated to handle 0x%08X, "
-			    "can't create framebuffer\n", mode_cmd->handles[0]);
+		drm_dbg_kms(dev,
+			    "No GEM object associated to handle 0x%08X, can't create framebuffer\n",
+			    mode_cmd->handles[0]);
+
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -1384,6 +1389,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	}
 	if (amdgpu_crtc->rmx_type != RMX_OFF) {
 		fixed20_12 a, b;
+
 		a.full = dfixed_const(src_v);
 		b.full = dfixed_const(dst_v);
 		amdgpu_crtc->vsc.full = dfixed_div(a, b);
@@ -1403,7 +1409,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
  *
  * \param dev Device to query.
  * \param pipe Crtc to query.
- * \param flags Flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
+ * \param flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
  *              For driver internal use only also supports these flags:
  *
  *              USE_REAL_VBLANKSTART to use the real start of vblank instead
@@ -1479,8 +1485,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
-	    /* Caller wants distance from real vbl_start in *hpos */
-	    *hpos = *vpos - vbl_start;
+		/* Caller wants distance from real vbl_start in *hpos */
+		*hpos = *vpos - vbl_start;
 	}
 
 	/* Fudge vblank to start a few scanlines earlier to handle the
@@ -1502,7 +1508,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* In vblank? */
 	if (in_vbl)
-	    ret |= DRM_SCANOUTPOS_IN_VBLANK;
+		ret |= DRM_SCANOUTPOS_IN_VBLANK;
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
@@ -1593,6 +1599,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				amdgpu_bo_unpin(aobj);
@@ -1600,9 +1607,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			}
 		}
 
-		if (fb == NULL || fb->obj[0] == NULL) {
+		if (!fb || !fb->obj[0])
 			continue;
-		}
+
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
 		/* don't unpin kernel fb objects */
 		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
@@ -1630,6 +1637,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
-- 
2.42.0




