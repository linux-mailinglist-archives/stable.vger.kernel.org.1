Return-Path: <stable+bounces-183687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC471BC8FD0
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB4C24F1489
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9782DCC04;
	Thu,  9 Oct 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rTolYT8P"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7312D879B
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012568; cv=none; b=G+EqHgFBi71ehnFlMggXQjd5pbWjF+PUqsd4twmS4RtVBrBpbKjtrF8mca1WAvSW8hkMsR9zzM5GBiIg0g61MM+dSnh2EWC54ccIeJ/+ZniDZ2g3MLnf2HK4hfrjvXGRxhcfXINTgPW9l0WZk9jfVkBronSuHO6Zwp5Qy/KRxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012568; c=relaxed/simple;
	bh=WED1CaVoy7jTVdlX/Aw/IQWqtv/1nGQg+rNRCl+wjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/S2kPCSKdlG/5rMDV21vxEnJudvTNpsfz7Tm33yvLW6SvrAq5n6mLdDIijWrjo5w4LuKv7TQNhQCyt1Qq1N5+csr6ujYHMO3kzRMFYerAPFo2WIeZHNCrhXmVIsY5emobNtSntcxYbGC5C6S+zLbRCVp5sE3D2z+4aSGtrpKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rTolYT8P; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760012563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+LD5r01PNN7zm04H6bSvacVHamUM/2IZoCmv2ssIeCg=;
	b=rTolYT8PhikH16sOIRDoUQet6iGvoyf7ONa/qlIsqyhBepgupyHs0OdGPTCEDLAqueqrJz
	6+3xmVrUMMBHkVB7ZIHngJD7EoM4lGdiF3zRhX0S6KDP/7l/Cv6v4Pt+r8fqkvIrDOoPft
	iWj+O/j9E1UXsQuYv7v6OYDkc2qBs2k=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: harry.wentland@amd.com,
	christian.koenig@amd.com,
	sunpeng.li@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	regressions@lists.linux.dev,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] Revert "drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume"
Date: Thu,  9 Oct 2025 14:19:00 +0200
Message-ID: <20251009121900.12777-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This fix regressed the original issue that commit d83c747a1225
("drm/amd/display: Fix brightness level not retained over reboot") solved,
so revert it until a different approach to solve the regression that
it caused with AMD_PRIVATE_COLOR is found.

Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
v1 -> v2:
- Fix missing stable tag
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e1622bf7a42..21281e684b84 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2081,8 +2081,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	adev->dm.restore_backlight = true;
-
 	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
@@ -3438,7 +3436,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
-		adev->dm.restore_backlight = true;
 
 		amdgpu_dm_irq_resume_early(adev);
 
@@ -9965,6 +9962,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
+	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -10084,6 +10082,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
+			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -10140,16 +10139,13 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	 * to fix a flicker issue.
 	 * It will cause the dm->actual_brightness is not the current panel brightness
 	 * level. (the dm->brightness is the correct panel level)
-	 * So we set the backlight level with dm->brightness value after initial
-	 * set mode. Use restore_backlight flag to avoid setting backlight level
-	 * for every subsequent mode set.
+	 * So we set the backlight level with dm->brightness value after set mode
 	 */
-	if (dm->restore_backlight) {
+	if (set_backlight_level) {
 		for (i = 0; i < dm->num_of_edps; i++) {
 			if (dm->backlight_dev[i])
 				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 		}
-		dm->restore_backlight = false;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 009f206226f0..db75e991ac7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -630,13 +630,6 @@ struct amdgpu_display_manager {
 	 */
 	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
 
-	/**
-	 * @restore_backlight:
-	 *
-	 * Flag to indicate whether to restore backlight after modeset.
-	 */
-	bool restore_backlight;
-
 	/**
 	 * @aux_hpd_discon_quirk:
 	 *
-- 
2.51.0


