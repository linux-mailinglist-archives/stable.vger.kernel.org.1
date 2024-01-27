Return-Path: <stable+bounces-16181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC383F190
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CC9283022
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63218200BD;
	Sat, 27 Jan 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sQ+pRkta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239231F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397044; cv=none; b=uHTcHXBz2oUrIQyFhTADo8iKzQvNKVgkLgQ5EMrZVFg93xLI4B2zYaRbyvZ+PhviencKoQ/bVwpR3V8dTVgei1YeTbTl/0Civ41vsmuDClliPvoElQbNlYx64WIkGaNG13WG7pf+tGfSxdSep4QUUQy2ClCjJt0S4EXXkIbRH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397044; c=relaxed/simple;
	bh=pLDP1AeojWHMocqFegnC0AsSmFyJjBNeX+xRGgmwQ9Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cWqNThlM8jKZweQy89W/oCWSFB2RFGlr+2gw769RGUaQCs0hrnzwqYuRbiGO/XhTVycc/h6svSw2UzZzeuDkLCYZuiH8EeoFAjBjiSCFdq7EA6+Wp8kr1A2G4pEhDcT3nV+TywATTmNSvbbXkwlxUYGk1Br9v/Ijv1EHxJ3t9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sQ+pRkta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAFAC43399;
	Sat, 27 Jan 2024 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397044;
	bh=pLDP1AeojWHMocqFegnC0AsSmFyJjBNeX+xRGgmwQ9Q=;
	h=Subject:To:Cc:From:Date:From;
	b=sQ+pRktaJxQPy4YCZv+i0WirQNRjppaGTDUWH1p2m32hOA7t6jeAbXHqWMF1KYgho
	 wOQmRfil6Z7i8mJQkUdo6xFX4hpMcYr4RvWq7P1a2dmVHhblJ0uq9EaxNgArk6fphb
	 jH9eR47YW+ETR8YjXAgDt6evac0ChfAFOdsNynBs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix conversions between bytes and KB" failed to apply to 6.1-stable tree
To: syed.hassan@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:10:43 -0800
Message-ID: <2024012743-crown-occultist-f35d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 22136ff27c4e01fae81f6588033363a46c72ed8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012743-crown-occultist-f35d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

22136ff27c4e ("drm/amd/display: Fix conversions between bytes and KB")
b141fa036c90 ("drm/amd/display: Reduce stack size by splitting function")
7966f319c66d ("drm/amd/display: Introduce DML2")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
39d39a019657 ("drm/amd/display: switch to new ODM policy for windowed MPO ODM support")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")
ca030d83f53b ("drm/amd/display: always acquire MPO pipe for every blending tree")
71ba6b577a35 ("drm/amd/display: Add interface to enable DPIA trace")
75bd42fd2e8e ("drm/amd/display: Prevent invalid pipe connections")
da915efaa213 ("drm/amd/display: ABM pause toggle")
c35b6ea8f2ec ("drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt")
bbe4418f22b9 ("drm/amd/display: Include CSC updates in new fast update path")
33e82119cfb2 ("drm/amd/display: Only use ODM2:1 policy for high pixel rate displays")
0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
24e461e84f1c ("drm/amd/display: add ODM case when looking for first split pipe")
3a10a44a3e00 ("drm/amd/display: clean up some inconsistent indenting")
268182606f26 ("drm/amd/display: Update correct DCN314 register header")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 22136ff27c4e01fae81f6588033363a46c72ed8c Mon Sep 17 00:00:00 2001
From: Taimur Hassan <syed.hassan@amd.com>
Date: Fri, 10 Nov 2023 10:15:28 -0500
Subject: [PATCH] drm/amd/display: Fix conversions between bytes and KB

[Why]
There are a number of instances where we convert HostVMMinPageSize or
GPUVMMinPageSize from bytes to KB by dividing (rather than multiplying) and
vice versa.
Additionally, in some cases, a parameter is passed through DML in KB but
later checked as if it were in bytes.

Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 510be909cd75..59718ee33e51 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6329,7 +6329,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.NoOfDPPThisState,
 				mode_lib->ms.dpte_group_bytes,
 				s->HostVMInefficiencyFactor,
-				mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+				mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 				mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
 
 		s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
@@ -6542,7 +6542,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 						mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
 						mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels,
 						mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
-						mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+						mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 						mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k],
 						mode_lib->ms.MetaRowBytes[j][k],
 						mode_lib->ms.DPTEBytesPerRow[j][k],
@@ -7687,7 +7687,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 		CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 		CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 		CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
 		CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
 		CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
@@ -7957,7 +7957,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		UseMinimumDCFCLK_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 		UseMinimumDCFCLK_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 		UseMinimumDCFCLK_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
-		UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+		UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 		UseMinimumDCFCLK_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 		UseMinimumDCFCLK_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 		UseMinimumDCFCLK_params->ImmediateFlipRequirement = s->ImmediateFlipRequiredFinal;
@@ -8699,7 +8699,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 	CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 	CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 	CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 	CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
 	CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
 	CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = s->dummy_boolean_array[0];
@@ -8805,7 +8805,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			mode_lib->ms.cache_display_cfg.hw.DPPPerSurface,
 			locals->dpte_group_bytes,
 			s->HostVMInefficiencyFactor,
-			mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+			mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 			mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
 
 	locals->TCalc = 24.0 / locals->DCFCLKDeepSleep;
@@ -8995,7 +8995,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			CalculatePrefetchSchedule_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
 			CalculatePrefetchSchedule_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 			CalculatePrefetchSchedule_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
-			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
+			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
 			CalculatePrefetchSchedule_params->DynamicMetadataEnable = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataEnable[k];
 			CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 			CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataLinesBeforeActiveRequired[k];
@@ -9240,7 +9240,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 						mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
 						mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels,
 						mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
-						mode_lib->ms.soc.hostvm_min_page_size_kbytes,
+						mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
 						locals->PDEAndMetaPTEBytesFrame[k],
 						locals->MetaRowByte[k],
 						locals->PixelPTEBytesPerRow[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2b9638c6d9b0..48caa34a5ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -515,8 +515,8 @@ void dml2_translate_socbb_params(const struct dc *in, struct soc_bounding_box_st
 	out->do_urgent_latency_adjustment = in_soc_params->do_urgent_latency_adjustment;
 	out->dram_channel_width_bytes = (dml_uint_t)in_soc_params->dram_channel_width_bytes;
 	out->fabric_datapath_to_dcn_data_return_bytes = (dml_uint_t)in_soc_params->fabric_datapath_to_dcn_data_return_bytes;
-	out->gpuvm_min_page_size_kbytes = in_soc_params->gpuvm_min_page_size_bytes * 1024;
-	out->hostvm_min_page_size_kbytes = in_soc_params->hostvm_min_page_size_bytes * 1024;
+	out->gpuvm_min_page_size_kbytes = in_soc_params->gpuvm_min_page_size_bytes / 1024;
+	out->hostvm_min_page_size_kbytes = in_soc_params->hostvm_min_page_size_bytes / 1024;
 	out->mall_allocated_for_dcn_mbytes = (dml_uint_t)in_soc_params->mall_allocated_for_dcn_mbytes;
 	out->max_avg_dram_bw_use_normal_percent = in_soc_params->max_avg_dram_bw_use_normal_percent;
 	out->max_avg_fabric_bw_use_normal_percent = in_soc_params->max_avg_fabric_bw_use_normal_percent;


