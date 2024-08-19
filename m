Return-Path: <stable+bounces-69448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A259F95627C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C4A1C2138F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9A156220;
	Mon, 19 Aug 2024 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LEVoiQrv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34F155A4E;
	Mon, 19 Aug 2024 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040808; cv=none; b=XmUgMgBE4OQSeekkwrtKiih9M2Z1EnkVa4t1JfpN6f/NpWhBh+i2f5mZ8R0MSnmUElnsINMcRQ3c3xCNxcQ2kfUnuytIp3JNY85Tc32uock3KWauF/lKPOI7zUlZkN+j4xADR+55ta2ZD7rO0CLrD00+FmijQDKbroRoKJ8My+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040808; c=relaxed/simple;
	bh=wAJgVCsolyPJaWslPHCVj7mB018p97cOw0sXXvlxW7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k067OjG+7iHnzWO5E8NKu8Nlhd1CHEKyhhwXYvAO7oJNHxb+a3BwmnqNd32z7wPkSuznevT8+f1qcb6iTmeWLoCmqfFWtVekjzweKUoP+Juao2cT/U4kkW+KOCjq5K3SwUCrHQp3pRhc+FTAfrU5NLZxPymOBuMHuCWDYlNYt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LEVoiQrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657E3C32782;
	Mon, 19 Aug 2024 04:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040808;
	bh=wAJgVCsolyPJaWslPHCVj7mB018p97cOw0sXXvlxW7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEVoiQrvpCZUr2Tz/GJbmIEtAdam0Y/TUL6mm7P0zaPrdVq04WlnjF8bRq7HmcByK
	 DZIr5Jbvdvw6lFTX4Ta/oqAeSS4vmGHdAUWV6KvBGbNj2zL8UHiz5LBQWbOyLtoDbx
	 AskMGR9InlQ64MVE8zM9u095BCklodPBq/gySfvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.6
Date: Mon, 19 Aug 2024 06:13:15 +0200
Message-ID: <2024081914-carnivore-aluminum-a66a@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081914-curable-gladly-6d01@gregkh>
References: <2024081914-curable-gladly-6d01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index f9badb79ae8f..361a70264e1f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 10
-SUBLEVEL = 5
+SUBLEVEL = 6
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index fcb668984f03..b344b1f91715 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 076fbeadce01..4e0847601103 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -941,8 +941,19 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
-		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
+		/*
+		 * ATA PASS-THROUGH INFORMATION AVAILABLE
+		 *
+		 * Note: we are supposed to call ata_scsi_set_sense(), which
+		 * respects the D_SENSE bit, instead of unconditionally
+		 * generating the sense data in descriptor format. However,
+		 * because hdparm, hddtemp, and udisks incorrectly assume sense
+		 * data in descriptor format, without even looking at the
+		 * RESPONSE CODE field in the returned sense data (to see which
+		 * format the returned sense data is in), we are stuck with
+		 * being bug compatible with older kernels.
+		 */
+		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 964bb6d0a383..836bf9ba620d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2944,6 +2944,7 @@ static int dm_resume(void *handle)
 
 		commit_params.streams = dc_state->streams;
 		commit_params.stream_count = dc_state->stream_count;
+		dc_exit_ips_for_hw_access(dm->dc);
 		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
@@ -3016,7 +3017,8 @@ static int dm_resume(void *handle)
 			emulated_link_detect(aconnector->dc_link);
 		} else {
 			mutex_lock(&dm->dc_lock);
-			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+			dc_exit_ips_for_hw_access(dm->dc);
+			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
 			mutex_unlock(&dm->dc_lock);
 		}
 
@@ -3352,6 +3354,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
+	struct dc *dc = aconnector->dc_link->ctx->dc;
 	bool ret = false;
 
 	if (adev->dm.disable_hpd_irq)
@@ -3386,6 +3389,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else {
 		mutex_lock(&adev->dm.dc_lock);
+		dc_exit_ips_for_hw_access(dc);
 		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 		mutex_unlock(&adev->dm.dc_lock);
 		if (ret) {
@@ -3445,6 +3449,7 @@ static void handle_hpd_rx_irq(void *param)
 	bool has_left_work = false;
 	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
+	struct dc *dc = aconnector->dc_link->ctx->dc;
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
@@ -3534,6 +3539,7 @@ static void handle_hpd_rx_irq(void *param)
 			bool ret = false;
 
 			mutex_lock(&adev->dm.dc_lock);
+			dc_exit_ips_for_hw_access(dc);
 			ret = dc_link_detect(dc_link, DETECT_REASON_HPDRX);
 			mutex_unlock(&adev->dm.dc_lock);
 
@@ -4640,6 +4646,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			bool ret = false;
 
 			mutex_lock(&dm->dc_lock);
+			dc_exit_ips_for_hw_access(dm->dc);
 			ret = dc_link_detect(link, DETECT_REASON_BOOT);
 			mutex_unlock(&dm->dc_lock);
 
@@ -8948,7 +8955,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 			memset(&position, 0, sizeof(position));
 			mutex_lock(&dm->dc_lock);
-			dc_stream_set_cursor_position(dm_old_crtc_state->stream, &position);
+			dc_exit_ips_for_hw_access(dm->dc);
+			dc_stream_program_cursor_position(dm_old_crtc_state->stream, &position);
 			mutex_unlock(&dm->dc_lock);
 		}
 
@@ -9017,6 +9025,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 	dm_enable_per_frame_crtc_master_sync(dc_state);
 	mutex_lock(&dm->dc_lock);
+	dc_exit_ips_for_hw_access(dm->dc);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
 	/* Allow idle optimization when vblank count is 0 for display off */
@@ -9382,6 +9391,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 
 		mutex_lock(&dm->dc_lock);
+		dc_exit_ips_for_hw_access(dm->dc);
 		dc_update_planes_and_stream(dm->dc,
 					    dummy_updates,
 					    status->plane_count,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index bb4e5ab7edc6..b50010ed7633 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1594,171 +1594,109 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 	return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
-static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
-{
-	uint32_t total_data_bw_efficiency_x10000 = 0;
-	uint32_t link_rate_per_lane_kbps = 0;
-	enum dc_link_rate link_rate;
-	union lane_count_set lane_count;
-	u8 dp_link_encoding;
-	u8 link_bw_set = 0;
-
-	*cur_link_bw = 0;
-
-	if (drm_dp_dpcd_read(aux, DP_MAIN_LINK_CHANNEL_CODING_SET, &dp_link_encoding, 1) != 1 ||
-		drm_dp_dpcd_read(aux, DP_LANE_COUNT_SET, &lane_count.raw, 1) != 1 ||
-		drm_dp_dpcd_read(aux, DP_LINK_BW_SET, &link_bw_set, 1) != 1)
-		return false;
-
-	switch (dp_link_encoding) {
-	case DP_8b_10b_ENCODING:
-		link_rate = link_bw_set;
-		link_rate_per_lane_kbps = link_rate * LINK_RATE_REF_FREQ_IN_KHZ * BITS_PER_DP_BYTE;
-		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_8b_10b_x10000;
-		total_data_bw_efficiency_x10000 /= 100;
-		total_data_bw_efficiency_x10000 *= DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100;
-		break;
-	case DP_128b_132b_ENCODING:
-		switch (link_bw_set) {
-		case DP_LINK_BW_10:
-			link_rate = LINK_RATE_UHBR10;
-			break;
-		case DP_LINK_BW_13_5:
-			link_rate = LINK_RATE_UHBR13_5;
-			break;
-		case DP_LINK_BW_20:
-			link_rate = LINK_RATE_UHBR20;
-			break;
-		default:
-			return false;
-		}
-
-		link_rate_per_lane_kbps = link_rate * 10000;
-		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_128b_132b_x10000;
-		break;
-	default:
-		return false;
-	}
-
-	*cur_link_bw = link_rate_per_lane_kbps * lane_count.bits.LANE_COUNT_SET / 10000 * total_data_bw_efficiency_x10000;
-	return true;
-}
-#endif
-
 enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream)
 {
-#if defined(CONFIG_DRM_AMD_DC_FP)
-	int branch_max_throughput_mps = 0;
+	int pbn, branch_max_throughput_mps = 0;
 	struct dc_link_settings cur_link_settings;
-	uint32_t end_to_end_bw_in_kbps = 0;
-	uint32_t root_link_bw_in_kbps = 0;
-	uint32_t virtual_channel_bw_in_kbps = 0;
+	unsigned int end_to_end_bw_in_kbps = 0;
+	unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
 	struct dc_dsc_bw_range bw_range = {0};
 	struct dc_dsc_config_options dsc_options = {0};
-	uint32_t stream_kbps;
 
-	/* DSC unnecessary case
-	 * Check if timing could be supported within end-to-end BW
+	/*
+	 * Consider the case with the depth of the mst topology tree is equal or less than 2
+	 * A. When dsc bitstream can be transmitted along the entire path
+	 *    1. dsc is possible between source and branch/leaf device (common dsc params is possible), AND
+	 *    2. dsc passthrough supported at MST branch, or
+	 *    3. dsc decoding supported at leaf MST device
+	 *    Use maximum dsc compression as bw constraint
+	 * B. When dsc bitstream cannot be transmitted along the entire path
+	 *    Use native bw as bw constraint
 	 */
-	stream_kbps =
-		dc_bandwidth_in_kbps_from_timing(&stream->timing,
-			dc_link_get_highest_encoding_format(stream->link));
-	cur_link_settings = stream->link->verified_link_cap;
-	root_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
-	virtual_channel_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
-
-	/* pick the end to end bw bottleneck */
-	end_to_end_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
-
-	if (stream_kbps <= end_to_end_bw_in_kbps) {
-		DRM_DEBUG_DRIVER("No DSC needed. End-to-end bw sufficient.");
-		return DC_OK;
-	}
-
-	/*DSC necessary case*/
-	if (!aconnector->dsc_aux)
-		return DC_FAIL_BANDWIDTH_VALIDATE;
-
-	if (is_dsc_common_config_possible(stream, &bw_range)) {
-
-		/*capable of dsc passthough. dsc bitstream along the entire path*/
-		if (aconnector->mst_output_port->passthrough_aux) {
-			if (bw_range.min_kbps > end_to_end_bw_in_kbps) {
-				DRM_DEBUG_DRIVER("DSC passthrough. Max dsc compression can't fit into end-to-end bw\n");
+	if (is_dsc_common_config_possible(stream, &bw_range) &&
+	   (aconnector->mst_output_port->passthrough_aux ||
+	    aconnector->dsc_aux == &aconnector->mst_output_port->aux)) {
+		cur_link_settings = stream->link->verified_link_cap;
+		upper_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
+		down_link_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
+
+		/* pick the end to end bw bottleneck */
+		end_to_end_bw_in_kbps = min(upper_link_bw_in_kbps, down_link_bw_in_kbps);
+
+		if (end_to_end_bw_in_kbps < bw_range.min_kbps) {
+			DRM_DEBUG_DRIVER("maximum dsc compression cannot fit into end-to-end bandwidth\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
-			}
-		} else {
-			/*dsc bitstream decoded at the dp last link*/
-			struct drm_dp_mst_port *immediate_upstream_port = NULL;
-			uint32_t end_link_bw = 0;
-
-			/*Get last DP link BW capability*/
-			if (dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw)) {
-				if (stream_kbps > end_link_bw) {
-					DRM_DEBUG_DRIVER("DSC decode at last link. Mode required bw can't fit into available bw\n");
-					return DC_FAIL_BANDWIDTH_VALIDATE;
-				}
-			}
-
-			/*Get virtual channel bandwidth between source and the link before the last link*/
-			if (aconnector->mst_output_port->parent->port_parent)
-				immediate_upstream_port = aconnector->mst_output_port->parent->port_parent;
+		}
 
-			if (immediate_upstream_port) {
-				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
-				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
-				if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
-					DRM_DEBUG_DRIVER("DSC decode at last link. Max dsc compression can't fit into MST available bw\n");
-					return DC_FAIL_BANDWIDTH_VALIDATE;
-				}
+		if (end_to_end_bw_in_kbps < bw_range.stream_kbps) {
+			dc_dsc_get_default_config_option(stream->link->dc, &dsc_options);
+			dsc_options.max_target_bpp_limit_override_x16 = aconnector->base.display_info.max_dsc_bpp * 16;
+			if (dc_dsc_compute_config(stream->sink->ctx->dc->res_pool->dscs[0],
+					&stream->sink->dsc_caps.dsc_dec_caps,
+					&dsc_options,
+					end_to_end_bw_in_kbps,
+					&stream->timing,
+					dc_link_get_highest_encoding_format(stream->link),
+					&stream->timing.dsc_cfg)) {
+				stream->timing.flags.DSC = 1;
+				DRM_DEBUG_DRIVER("end-to-end bandwidth require dsc and dsc config found\n");
+			} else {
+				DRM_DEBUG_DRIVER("end-to-end bandwidth require dsc but dsc config not found\n");
+				return DC_FAIL_BANDWIDTH_VALIDATE;
 			}
 		}
-
-		/*Confirm if we can obtain dsc config*/
-		dc_dsc_get_default_config_option(stream->link->dc, &dsc_options);
-		dsc_options.max_target_bpp_limit_override_x16 = aconnector->base.display_info.max_dsc_bpp * 16;
-		if (dc_dsc_compute_config(stream->sink->ctx->dc->res_pool->dscs[0],
-				&stream->sink->dsc_caps.dsc_dec_caps,
-				&dsc_options,
-				end_to_end_bw_in_kbps,
-				&stream->timing,
-				dc_link_get_highest_encoding_format(stream->link),
-				&stream->timing.dsc_cfg)) {
-			stream->timing.flags.DSC = 1;
-			DRM_DEBUG_DRIVER("Require dsc and dsc config found\n");
-		} else {
-			DRM_DEBUG_DRIVER("Require dsc but can't find appropriate dsc config\n");
+	} else {
+		/* Check if mode could be supported within max slot
+		 * number of current mst link and full_pbn of mst links.
+		 */
+		int pbn_div, slot_num, max_slot_num;
+		enum dc_link_encoding_format link_encoding;
+		uint32_t stream_kbps =
+			dc_bandwidth_in_kbps_from_timing(&stream->timing,
+				dc_link_get_highest_encoding_format(stream->link));
+
+		pbn = kbps_to_peak_pbn(stream_kbps);
+		pbn_div = dm_mst_get_pbn_divider(stream->link);
+		slot_num = DIV_ROUND_UP(pbn, pbn_div);
+
+		link_encoding = dc_link_get_highest_encoding_format(stream->link);
+		if (link_encoding == DC_LINK_ENCODING_DP_8b_10b)
+			max_slot_num = 63;
+		else if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
+			max_slot_num = 64;
+		else {
+			DRM_DEBUG_DRIVER("Invalid link encoding format\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
 
-		/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
-		switch (stream->timing.pixel_encoding) {
-		case PIXEL_ENCODING_RGB:
-		case PIXEL_ENCODING_YCBCR444:
-			branch_max_throughput_mps =
-				aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_0_mps;
-			break;
-		case PIXEL_ENCODING_YCBCR422:
-		case PIXEL_ENCODING_YCBCR420:
-			branch_max_throughput_mps =
-				aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_1_mps;
-			break;
-		default:
-			break;
+		if (slot_num > max_slot_num ||
+			pbn > aconnector->mst_output_port->full_pbn) {
+			DRM_DEBUG_DRIVER("Mode can not be supported within mst links!");
+			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
+	}
 
-		if (branch_max_throughput_mps != 0 &&
-			((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000)) {
-			DRM_DEBUG_DRIVER("DSC is required but max throughput mps fails");
-		return DC_FAIL_BANDWIDTH_VALIDATE;
-		}
-	} else {
-		DRM_DEBUG_DRIVER("DSC is required but can't find common dsc config.");
-		return DC_FAIL_BANDWIDTH_VALIDATE;
+	/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
+	switch (stream->timing.pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+	case PIXEL_ENCODING_YCBCR444:
+		branch_max_throughput_mps =
+			aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_0_mps;
+		break;
+	case PIXEL_ENCODING_YCBCR422:
+	case PIXEL_ENCODING_YCBCR420:
+		branch_max_throughput_mps =
+			aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_1_mps;
+		break;
+	default:
+		break;
 	}
-#endif
+
+	if (branch_max_throughput_mps != 0 &&
+		((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000))
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
 	return DC_OK;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e..311c62d2d1eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1254,7 +1254,7 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		/* turn off cursor */
 		if (crtc_state && crtc_state->stream) {
 			mutex_lock(&adev->dm.dc_lock);
-			dc_stream_set_cursor_position(crtc_state->stream,
+			dc_stream_program_cursor_position(crtc_state->stream,
 						      &position);
 			mutex_unlock(&adev->dm.dc_lock);
 		}
@@ -1284,11 +1284,11 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
-		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
+		if (!dc_stream_program_cursor_attributes(crtc_state->stream,
 							 &attributes))
 			DRM_ERROR("DC failed to set cursor attributes\n");
 
-		if (!dc_stream_set_cursor_position(crtc_state->stream,
+		if (!dc_stream_program_cursor_position(crtc_state->stream,
 						   &position))
 			DRM_ERROR("DC failed to set cursor position\n");
 		mutex_unlock(&adev->dm.dc_lock);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 5c7e4884cac2..53bc991b6e67 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -266,7 +266,6 @@ bool dc_stream_set_cursor_attributes(
 	const struct dc_cursor_attributes *attributes)
 {
 	struct dc  *dc;
-	bool reset_idle_optimizations = false;
 
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
@@ -297,20 +296,36 @@ bool dc_stream_set_cursor_attributes(
 
 	stream->cursor_attributes = *attributes;
 
-	dc_z10_restore(dc);
-	/* disable idle optimizations while updating cursor */
-	if (dc->idle_optimizations_allowed) {
-		dc_allow_idle_optimizations(dc, false);
-		reset_idle_optimizations = true;
-	}
+	return true;
+}
 
-	program_cursor_attributes(dc, stream, attributes);
+bool dc_stream_program_cursor_attributes(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_attributes *attributes)
+{
+	struct dc  *dc;
+	bool reset_idle_optimizations = false;
 
-	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
-		dc_allow_idle_optimizations(dc, true);
+	dc = stream ? stream->ctx->dc : NULL;
 
-	return true;
+	if (dc_stream_set_cursor_attributes(stream, attributes)) {
+		dc_z10_restore(dc);
+		/* disable idle optimizations while updating cursor */
+		if (dc->idle_optimizations_allowed) {
+			dc_allow_idle_optimizations(dc, false);
+			reset_idle_optimizations = true;
+		}
+
+		program_cursor_attributes(dc, stream, attributes);
+
+		/* re-enable idle optimizations if necessary */
+		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
+			dc_allow_idle_optimizations(dc, true);
+
+		return true;
+	}
+
+	return false;
 }
 
 static void program_cursor_position(
@@ -355,9 +370,6 @@ bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position)
 {
-	struct dc *dc;
-	bool reset_idle_optimizations = false;
-
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
 		return false;
@@ -368,24 +380,46 @@ bool dc_stream_set_cursor_position(
 		return false;
 	}
 
+	stream->cursor_position = *position;
+
+
+	return true;
+}
+
+bool dc_stream_program_cursor_position(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_position *position)
+{
+	struct dc *dc;
+	bool reset_idle_optimizations = false;
+	const struct dc_cursor_position *old_position;
+
+	if (!stream)
+		return false;
+
+	old_position = &stream->cursor_position;
 	dc = stream->ctx->dc;
-	dc_z10_restore(dc);
 
-	/* disable idle optimizations if enabling cursor */
-	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
-			&& position->enable) {
-		dc_allow_idle_optimizations(dc, false);
-		reset_idle_optimizations = true;
-	}
+	if (dc_stream_set_cursor_position(stream, position)) {
+		dc_z10_restore(dc);
 
-	stream->cursor_position = *position;
+		/* disable idle optimizations if enabling cursor */
+		if (dc->idle_optimizations_allowed &&
+		    (!old_position->enable || dc->debug.exit_idle_opt_for_cursor_updates) &&
+		    position->enable) {
+			dc_allow_idle_optimizations(dc, false);
+			reset_idle_optimizations = true;
+		}
 
-	program_cursor_position(dc, stream, position);
-	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
-		dc_allow_idle_optimizations(dc, true);
+		program_cursor_position(dc, stream, position);
+		/* re-enable idle optimizations if necessary */
+		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
+			dc_allow_idle_optimizations(dc, true);
 
-	return true;
+		return true;
+	}
+
+	return false;
 }
 
 bool dc_stream_add_writeback(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e5dbbc6089a5..1039dfb0b071 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -470,10 +470,18 @@ bool dc_stream_set_cursor_attributes(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_attributes *attributes);
 
+bool dc_stream_program_cursor_attributes(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_attributes *attributes);
+
 bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position);
 
+bool dc_stream_program_cursor_position(
+	struct dc_stream_state *stream,
+	const struct dc_cursor_position *position);
+
 
 bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 				struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 5b09d95cc5b8..4c4706153305 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1041,7 +1041,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 					/* Use copied cursor, and it's okay to not switch back */
 					cursor_attr.address.quad_part = cmd.mall.cursor_copy_dst.quad_part;
-					dc_stream_set_cursor_attributes(stream, &cursor_attr);
+					dc_stream_program_cursor_attributes(stream, &cursor_attr);
 				}
 
 				/* Enable MALL */
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 22d83ac18eb7..fbf58012becd 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -23,40 +23,11 @@ static int dvb_usb_force_pid_filter_usage;
 module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
 MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
 
-static int dvb_usb_check_bulk_endpoint(struct dvb_usb_device *d, u8 endpoint)
-{
-	if (endpoint) {
-		int ret;
-
-		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
-		if (ret)
-			return ret;
-		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static void dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)
-{
-	if (endpoint) {
-		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
-		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
-	}
-}
-
 static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 {
 	struct dvb_usb_adapter *adap;
 	int ret, n, o;
 
-	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint);
-	if (ret)
-		return ret;
-	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint_response);
-	if (ret)
-		return ret;
 	for (n = 0; n < d->props.num_adapters; n++) {
 		adap = &d->adapter[n];
 		adap->dev = d;
@@ -132,8 +103,10 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	 * when reloading the driver w/o replugging the device
 	 * sometimes a timeout occurs, this helps
 	 */
-	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
-	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
+	if (d->props.generic_bulk_ctrl_endpoint != 0) {
+		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
+		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
+	}
 
 	return 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7168ff4cc62b..a823330567ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2933,6 +2933,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 665fa9524986..ddfccc226751 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -477,6 +477,7 @@ config LENOVO_YMC
 	tristate "Lenovo Yoga Tablet Mode Control"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on IDEAPAD_LAPTOP
 	select INPUT_SPARSEKMAP
 	help
 	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
index a3dec14c3004..3c153fb1425e 100644
--- a/drivers/platform/x86/amd/pmf/spc.c
+++ b/drivers/platform/x86/amd/pmf/spc.c
@@ -150,36 +150,26 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 	return 0;
 }
 
-static int amd_pmf_get_sensor_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in)
+static void amd_pmf_get_sensor_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in)
 {
 	struct amd_sfh_info sfh_info;
-	int ret;
+
+	/* Get the latest information from SFH */
+	in->ev_info.user_present = false;
 
 	/* Get ALS data */
-	ret = amd_get_sfh_info(&sfh_info, MT_ALS);
-	if (!ret)
+	if (!amd_get_sfh_info(&sfh_info, MT_ALS))
 		in->ev_info.ambient_light = sfh_info.ambient_light;
 	else
-		return ret;
+		dev_dbg(dev->dev, "ALS is not enabled/detected\n");
 
 	/* get HPD data */
-	ret = amd_get_sfh_info(&sfh_info, MT_HPD);
-	if (ret)
-		return ret;
-
-	switch (sfh_info.user_present) {
-	case SFH_NOT_DETECTED:
-		in->ev_info.user_present = 0xff; /* assume no sensors connected */
-		break;
-	case SFH_USER_PRESENT:
-		in->ev_info.user_present = 1;
-		break;
-	case SFH_USER_AWAY:
-		in->ev_info.user_present = 0;
-		break;
+	if (!amd_get_sfh_info(&sfh_info, MT_HPD)) {
+		if (sfh_info.user_present == SFH_USER_PRESENT)
+			in->ev_info.user_present = true;
+	} else {
+		dev_dbg(dev->dev, "HPD is not enabled/detected\n");
 	}
-
-	return 0;
 }
 
 void amd_pmf_populate_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index fcf13d88fd6e..490815917ade 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -125,6 +125,7 @@ struct ideapad_rfk_priv {
 
 struct ideapad_private {
 	struct acpi_device *adev;
+	struct mutex vpc_mutex; /* protects the VPC calls */
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
 	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
@@ -145,6 +146,7 @@ struct ideapad_private {
 		bool touchpad_ctrl_via_ec : 1;
 		bool ctrl_ps2_aux_port    : 1;
 		bool usb_charging         : 1;
+		bool ymc_ec_trigger       : 1;
 	} features;
 	struct {
 		bool initialized;
@@ -193,6 +195,12 @@ MODULE_PARM_DESC(touchpad_ctrl_via_ec,
 	"Enable registering a 'touchpad' sysfs-attribute which can be used to manually "
 	"tell the EC to enable/disable the touchpad. This may not work on all models.");
 
+static bool ymc_ec_trigger __read_mostly;
+module_param(ymc_ec_trigger, bool, 0444);
+MODULE_PARM_DESC(ymc_ec_trigger,
+	"Enable EC triggering work-around to force emitting tablet mode events. "
+	"If you need this please report this to: platform-driver-x86@vger.kernel.org");
+
 /*
  * shared data
  */
@@ -297,6 +305,8 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 	struct ideapad_private *priv = s->private;
 	unsigned long value;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
 		seq_printf(s, "Backlight max:  %lu\n", value);
 	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
@@ -415,7 +425,8 @@ static ssize_t camera_power_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
 	if (err)
 		return err;
 
@@ -434,7 +445,8 @@ static ssize_t camera_power_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
 	if (err)
 		return err;
 
@@ -487,7 +499,8 @@ static ssize_t fan_mode_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
 	if (err)
 		return err;
 
@@ -509,7 +522,8 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (state > 4 || state == 3)
 		return -EINVAL;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
 	if (err)
 		return err;
 
@@ -594,7 +608,8 @@ static ssize_t touchpad_show(struct device *dev,
 	unsigned long result;
 	int err;
 
-	err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
 	if (err)
 		return err;
 
@@ -615,7 +630,8 @@ static ssize_t touchpad_store(struct device *dev,
 	if (err)
 		return err;
 
-	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
 	if (err)
 		return err;
 
@@ -1012,6 +1028,8 @@ static int ideapad_rfk_set(void *data, bool blocked)
 	struct ideapad_rfk_priv *priv = data;
 	int opcode = ideapad_rfk_data[priv->dev].opcode;
 
+	guard(mutex)(&priv->priv->vpc_mutex);
+
 	return write_ec_cmd(priv->priv->adev->handle, opcode, !blocked);
 }
 
@@ -1025,6 +1043,8 @@ static void ideapad_sync_rfk_state(struct ideapad_private *priv)
 	int i;
 
 	if (priv->features.hw_rfkill_switch) {
+		guard(mutex)(&priv->vpc_mutex);
+
 		if (read_ec_data(priv->adev->handle, VPCCMD_R_RF, &hw_blocked))
 			return;
 		hw_blocked = !hw_blocked;
@@ -1198,8 +1218,9 @@ static void ideapad_input_novokey(struct ideapad_private *priv)
 {
 	unsigned long long_pressed;
 
-	if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex)
+		if (read_ec_data(priv->adev->handle, VPCCMD_R_NOVO, &long_pressed))
+			return;
 
 	if (long_pressed)
 		ideapad_input_report(priv, 17);
@@ -1211,8 +1232,9 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 {
 	unsigned long bit, value;
 
-	if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex)
+		if (read_ec_data(priv->adev->handle, VPCCMD_R_SPECIAL_BUTTONS, &value))
+			return;
 
 	for_each_set_bit (bit, &value, 16) {
 		switch (bit) {
@@ -1245,6 +1267,8 @@ static int ideapad_backlight_get_brightness(struct backlight_device *blightdev)
 	unsigned long now;
 	int err;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	err = read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 	if (err)
 		return err;
@@ -1257,6 +1281,8 @@ static int ideapad_backlight_update_status(struct backlight_device *blightdev)
 	struct ideapad_private *priv = bl_get_data(blightdev);
 	int err;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_BL,
 			   blightdev->props.brightness);
 	if (err)
@@ -1334,6 +1360,8 @@ static void ideapad_backlight_notify_power(struct ideapad_private *priv)
 	if (!blightdev)
 		return;
 
+	guard(mutex)(&priv->vpc_mutex);
+
 	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
 		return;
 
@@ -1346,7 +1374,8 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
 
 	/* if we control brightness via acpi video driver */
 	if (!priv->blightdev)
-		read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
+		scoped_guard(mutex, &priv->vpc_mutex)
+			read_ec_data(priv->adev->handle, VPCCMD_R_BL, &now);
 	else
 		backlight_force_update(priv->blightdev, BACKLIGHT_UPDATE_HOTKEY);
 }
@@ -1571,7 +1600,8 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	int ret;
 
 	/* Without reading from EC touchpad LED doesn't switch state */
-	ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
+	scoped_guard(mutex, &priv->vpc_mutex)
+		ret = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value);
 	if (ret)
 		return;
 
@@ -1599,16 +1629,92 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
 	priv->r_touchpad_val = value;
 }
 
+static const struct dmi_system_id ymc_ec_trigger_quirk_dmi_table[] = {
+	{
+		/* Lenovo Yoga 7 14ARB7 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		},
+	},
+	{
+		/* Lenovo Yoga 7 14ACN6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
+		},
+	},
+	{ }
+};
+
+static void ideapad_laptop_trigger_ec(void)
+{
+	struct ideapad_private *priv;
+	int ret;
+
+	guard(mutex)(&ideapad_shared_mutex);
+
+	priv = ideapad_shared;
+	if (!priv)
+		return;
+
+	if (!priv->features.ymc_ec_trigger)
+		return;
+
+	scoped_guard(mutex, &priv->vpc_mutex)
+		ret = write_ec_cmd(priv->adev->handle, VPCCMD_W_YMC, 1);
+	if (ret)
+		dev_warn(&priv->platform_device->dev, "Could not write YMC: %d\n", ret);
+}
+
+static int ideapad_laptop_nb_notify(struct notifier_block *nb,
+				    unsigned long action, void *data)
+{
+	switch (action) {
+	case IDEAPAD_LAPTOP_YMC_EVENT:
+		ideapad_laptop_trigger_ec();
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block ideapad_laptop_notifier = {
+	.notifier_call = ideapad_laptop_nb_notify,
+};
+
+static BLOCKING_NOTIFIER_HEAD(ideapad_laptop_chain_head);
+
+int ideapad_laptop_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&ideapad_laptop_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(ideapad_laptop_register_notifier, IDEAPAD_LAPTOP);
+
+int ideapad_laptop_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&ideapad_laptop_chain_head, nb);
+}
+EXPORT_SYMBOL_NS_GPL(ideapad_laptop_unregister_notifier, IDEAPAD_LAPTOP);
+
+void ideapad_laptop_call_notifier(unsigned long action, void *data)
+{
+	blocking_notifier_call_chain(&ideapad_laptop_chain_head, action, data);
+}
+EXPORT_SYMBOL_NS_GPL(ideapad_laptop_call_notifier, IDEAPAD_LAPTOP);
+
 static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ideapad_private *priv = data;
 	unsigned long vpc1, vpc2, bit;
 
-	if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
-		return;
+	scoped_guard(mutex, &priv->vpc_mutex) {
+		if (read_ec_data(handle, VPCCMD_R_VPC1, &vpc1))
+			return;
 
-	if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
-		return;
+		if (read_ec_data(handle, VPCCMD_R_VPC2, &vpc2))
+			return;
+	}
 
 	vpc1 = (vpc2 << 8) | vpc1;
 
@@ -1735,6 +1841,8 @@ static void ideapad_check_features(struct ideapad_private *priv)
 	priv->features.ctrl_ps2_aux_port =
 		ctrl_ps2_aux_port || dmi_check_system(ctrl_ps2_aux_port_list);
 	priv->features.touchpad_ctrl_via_ec = touchpad_ctrl_via_ec;
+	priv->features.ymc_ec_trigger =
+		ymc_ec_trigger || dmi_check_system(ymc_ec_trigger_quirk_dmi_table);
 
 	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
 		priv->features.fan_mode = true;
@@ -1915,6 +2023,10 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	priv->adev = adev;
 	priv->platform_device = pdev;
 
+	err = devm_mutex_init(&pdev->dev, &priv->vpc_mutex);
+	if (err)
+		return err;
+
 	ideapad_check_features(priv);
 
 	err = ideapad_sysfs_init(priv);
@@ -1983,6 +2095,8 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	if (err)
 		goto shared_init_failed;
 
+	ideapad_laptop_register_notifier(&ideapad_laptop_notifier);
+
 	return 0;
 
 shared_init_failed:
@@ -2015,6 +2129,8 @@ static void ideapad_acpi_remove(struct platform_device *pdev)
 	struct ideapad_private *priv = dev_get_drvdata(&pdev->dev);
 	int i;
 
+	ideapad_laptop_unregister_notifier(&ideapad_laptop_notifier);
+
 	ideapad_shared_exit(priv);
 
 	acpi_remove_notify_handler(priv->adev->handle,
diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/ideapad-laptop.h
index 4498a96de597..948cc61800a9 100644
--- a/drivers/platform/x86/ideapad-laptop.h
+++ b/drivers/platform/x86/ideapad-laptop.h
@@ -12,6 +12,15 @@
 #include <linux/acpi.h>
 #include <linux/jiffies.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
+
+enum ideapad_laptop_notifier_actions {
+	IDEAPAD_LAPTOP_YMC_EVENT,
+};
+
+int ideapad_laptop_register_notifier(struct notifier_block *nb);
+int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
+void ideapad_laptop_call_notifier(unsigned long action, void *data);
 
 enum {
 	VPCCMD_R_VPC1 = 0x10,
diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e1fbc35504d4..e0bbd6a14a89 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -20,32 +20,10 @@
 #define LENOVO_YMC_QUERY_INSTANCE 0
 #define LENOVO_YMC_QUERY_METHOD 0x01
 
-static bool ec_trigger __read_mostly;
-module_param(ec_trigger, bool, 0444);
-MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force emitting tablet mode events");
-
 static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
 
-static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
-	{
-		/* Lenovo Yoga 7 14ARB7 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
-		},
-	},
-	{
-		/* Lenovo Yoga 7 14ACN6 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
-		},
-	},
-	{ }
-};
-
 static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 	{
 		.matches = {
@@ -62,21 +40,8 @@ static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 
 struct lenovo_ymc_private {
 	struct input_dev *input_dev;
-	struct acpi_device *ec_acpi_dev;
 };
 
-static void lenovo_ymc_trigger_ec(struct wmi_device *wdev, struct lenovo_ymc_private *priv)
-{
-	int err;
-
-	if (!priv->ec_acpi_dev)
-		return;
-
-	err = write_ec_cmd(priv->ec_acpi_dev->handle, VPCCMD_W_YMC, 1);
-	if (err)
-		dev_warn(&wdev->dev, "Could not write YMC: %d\n", err);
-}
-
 static const struct key_entry lenovo_ymc_keymap[] = {
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
@@ -125,11 +90,9 @@ static void lenovo_ymc_notify(struct wmi_device *wdev, union acpi_object *data)
 
 free_obj:
 	kfree(obj);
-	lenovo_ymc_trigger_ec(wdev, priv);
+	ideapad_laptop_call_notifier(IDEAPAD_LAPTOP_YMC_EVENT, &code);
 }
 
-static void acpi_dev_put_helper(void *p) { acpi_dev_put(p); }
-
 static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 {
 	struct lenovo_ymc_private *priv;
@@ -143,29 +106,10 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 			return -ENODEV;
 	}
 
-	ec_trigger |= dmi_check_system(ec_trigger_quirk_dmi_table);
-
 	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	if (ec_trigger) {
-		pr_debug("Lenovo YMC enable EC triggering.\n");
-		priv->ec_acpi_dev = acpi_dev_get_first_match_dev("VPC2004", NULL, -1);
-
-		if (!priv->ec_acpi_dev) {
-			dev_err(&wdev->dev, "Could not find EC ACPI device.\n");
-			return -ENODEV;
-		}
-		err = devm_add_action_or_reset(&wdev->dev,
-				acpi_dev_put_helper, priv->ec_acpi_dev);
-		if (err) {
-			dev_err(&wdev->dev,
-				"Could not clean up EC ACPI device: %d\n", err);
-			return err;
-		}
-	}
-
 	input_dev = devm_input_allocate_device(&wdev->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -192,7 +136,6 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	/* Report the state for the first time on probe */
-	lenovo_ymc_trigger_ec(wdev, priv);
 	lenovo_ymc_notify(wdev, NULL);
 	return 0;
 }
@@ -217,3 +160,4 @@ module_wmi_driver(lenovo_ymc_driver);
 MODULE_AUTHOR("Gergo Koteles <soyer@irl.hu>");
 MODULE_DESCRIPTION("Lenovo Yoga Mode Control driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IDEAPAD_LAPTOP);
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c26545d71d39..cd6d5bbb4b9d 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -72,8 +72,10 @@
 
 #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
 #define DATA_START_OFFSET_WORDS		(0)
+#define MAX_SHARED_LIBS_UPDATE		(0)
 #else
 #define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
+#define MAX_SHARED_LIBS_UPDATE		(MAX_SHARED_LIBS)
 #endif
 
 struct lib_info {
@@ -880,7 +882,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		return res;
 
 	/* Update data segment pointers for all libraries */
-	for (i = 0; i < MAX_SHARED_LIBS; i++) {
+	for (i = 0; i < MAX_SHARED_LIBS_UPDATE; i++) {
 		if (!libinfo.lib_list[i].loaded)
 			continue;
 		for (j = 0; j < MAX_SHARED_LIBS; j++) {
diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..0c17e59e3767 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1668,6 +1668,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	unsigned int mode;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
+	int err;
 
 	if (!mnt_may_suid(file->f_path.mnt))
 		return;
@@ -1684,12 +1685,17 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
-	/* reload atomically mode/uid/gid now that lock held */
+	/* Atomically reload and check mode/uid/gid now that lock held. */
 	mode = inode->i_mode;
 	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid = i_gid_into_vfsgid(idmap, inode);
+	err = inode_permission(idmap, inode, MAY_EXEC);
 	inode_unlock(inode);
 
+	/* Did the exec bit vanish out from under us? Give up. */
+	if (err)
+		return;
+
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!vfsuid_has_mapping(bprm->cred->user_ns, vfsuid) ||
 	    !vfsgid_has_mapping(bprm->cred->user_ns, vfsgid))
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 48048fa36427..fd1fc06359ee 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -19,33 +19,23 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
-bool sanity_check_extent_cache(struct inode *inode)
+bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct extent_tree *et = fi->extent_tree[EX_READ];
-	struct extent_info *ei;
-
-	if (!et)
-		return true;
+	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
+	struct extent_info ei;
 
-	ei = &et->largest;
-	if (!ei->len)
-		return true;
+	get_read_extent_info(&ei, i_ext);
 
-	/* Let's drop, if checkpoint got corrupted. */
-	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
-		ei->len = 0;
-		et->largest_updated = true;
+	if (!ei.len)
 		return true;
-	}
 
-	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
-	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
+	if (!f2fs_is_valid_blkaddr(sbi, ei.blk, DATA_GENERIC_ENHANCE) ||
+	    !f2fs_is_valid_blkaddr(sbi, ei.blk + ei.len - 1,
 					DATA_GENERIC_ENHANCE)) {
 		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
-			  ei->blk, ei->fofs, ei->len);
+			  ei.blk, ei.fofs, ei.len);
 		return false;
 	}
 	return true;
@@ -394,24 +384,22 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 
 	if (!__may_extent_tree(inode, EX_READ)) {
 		/* drop largest read extent */
-		if (i_ext && i_ext->len) {
+		if (i_ext->len) {
 			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 			i_ext->len = 0;
 			set_page_dirty(ipage);
 		}
-		goto out;
+		set_inode_flag(inode, FI_NO_EXTENT);
+		return;
 	}
 
 	et = __grab_extent_tree(inode, EX_READ);
 
-	if (!i_ext || !i_ext->len)
-		goto out;
-
 	get_read_extent_info(&ei, i_ext);
 
 	write_lock(&et->lock);
-	if (atomic_read(&et->node_cnt))
-		goto unlock_out;
+	if (atomic_read(&et->node_cnt) || !ei.len)
+		goto skip;
 
 	en = __attach_extent_node(sbi, et, &ei, NULL,
 				&et->root.rb_root.rb_node, true);
@@ -423,11 +411,13 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 		list_add_tail(&en->list, &eti->extent_list);
 		spin_unlock(&eti->extent_lock);
 	}
-unlock_out:
+skip:
+	/* Let's drop, if checkpoint got corrupted. */
+	if (f2fs_cp_error(sbi)) {
+		et->largest.len = 0;
+		et->largest_updated = true;
+	}
 	write_unlock(&et->lock);
-out:
-	if (!F2FS_I(inode)->extent_tree[EX_READ])
-		set_inode_flag(inode, FI_NO_EXTENT);
 }
 
 void f2fs_init_age_extent_tree(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 66680159a296..5556ab491368 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4195,7 +4195,7 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
-bool sanity_check_extent_cache(struct inode *inode);
+bool sanity_check_extent_cache(struct inode *inode, struct page *ipage);
 void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b2951cd930d8..448c75e80b89 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1566,6 +1566,16 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
+			if (f2fs_has_inline_data(inode)) {
+				iput(inode);
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
+				f2fs_err_ratelimited(sbi,
+					"inode %lx has both inline_data flag and "
+					"data block, nid=%u, ofs_in_node=%u",
+					inode->i_ino, dni.nid, ofs_in_node);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c6b55aedc276..ed629dabbfda 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -511,16 +511,16 @@ static int do_read_inode(struct inode *inode)
 
 	init_idisk_time(inode);
 
-	/* Need all the flag bits */
-	f2fs_init_read_extent_tree(inode, node_page);
-	f2fs_init_age_extent_tree(inode);
-
-	if (!sanity_check_extent_cache(inode)) {
+	if (!sanity_check_extent_cache(inode, node_page)) {
 		f2fs_put_page(node_page, 1);
 		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
 		return -EFSCORRUPTED;
 	}
 
+	/* Need all the flag bits */
+	f2fs_init_read_extent_tree(inode, node_page);
+	f2fs_init_age_extent_tree(inode);
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..5713994328cb 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1626,6 +1626,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 031d8f570f58..5d3127ca68a4 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -834,6 +834,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
+	if (p->header.freelist == 0)
+		return -EINVAL;
 
 	/*
 	 *	insert entry for new key
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 4822cfd6351c..ded451a84b77 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1896,6 +1896,47 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return REPARSE_LINK;
 }
 
+/*
+ * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
+ * but it accepts kernel address for fi_extents_start
+ */
+static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
+				     u64 logical, u64 phys, u64 len, u32 flags)
+{
+	struct fiemap_extent extent;
+	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+
+	/* only count the extents */
+	if (fieinfo->fi_extents_max == 0) {
+		fieinfo->fi_extents_mapped++;
+		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+	}
+
+	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
+		return 1;
+
+	if (flags & FIEMAP_EXTENT_DELALLOC)
+		flags |= FIEMAP_EXTENT_UNKNOWN;
+	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
+		flags |= FIEMAP_EXTENT_ENCODED;
+	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
+		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
+
+	memset(&extent, 0, sizeof(extent));
+	extent.fe_logical = logical;
+	extent.fe_physical = phys;
+	extent.fe_length = len;
+	extent.fe_flags = flags;
+
+	dest += fieinfo->fi_extents_mapped;
+	memcpy(dest, &extent, sizeof(extent));
+
+	fieinfo->fi_extents_mapped++;
+	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
+		return 1;
+	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
+}
+
 /*
  * ni_fiemap - Helper for file_fiemap().
  *
@@ -1906,6 +1947,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
+	struct fiemap_extent __user *fe_u = fieinfo->fi_extents_start;
+	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
 	struct runs_tree *run;
@@ -1953,6 +1996,18 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
+	/*
+	 * To avoid lock problems replace pointer to user memory by pointer to kernel memory.
+	 */
+	fe_k = kmalloc_array(fieinfo->fi_extents_max,
+			     sizeof(struct fiemap_extent),
+			     GFP_NOFS | __GFP_ZERO);
+	if (!fe_k) {
+		err = -ENOMEM;
+		goto out;
+	}
+	fieinfo->fi_extents_start = fe_k;
+
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (end > alloc_size)
@@ -2041,8 +2096,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
-						      flags);
+			err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, dlen,
+							flags);
+
 			if (err < 0)
 				break;
 			if (err == 1) {
@@ -2062,7 +2118,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		err = fiemap_fill_next_extent_k(fieinfo, vbo, lbo, bytes,
+						flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2075,7 +2132,19 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 
 	up_read(run_lock);
 
+	/*
+	 * Copy to user memory out of lock
+	 */
+	if (copy_to_user(fe_u, fe_k,
+			 fieinfo->fi_extents_max *
+				 sizeof(struct fiemap_extent))) {
+		err = -EFAULT;
+	}
+
 out:
+	/* Restore original pointer. */
+	fieinfo->fi_extents_start = fe_u;
+	kfree(fe_k);
 	return err;
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 110692c1dd95..ab0455c64e49 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2279,12 +2279,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
@@ -2385,12 +2385,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index a8494f796dca..0abbc413e0fe 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -433,7 +433,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 6d821a793045..56cd60d33a28 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -36,6 +36,7 @@ static const struct reg_sequence cs35l56_patch[] = {
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
 	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
 	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
+	{ CS35L56_IRQ1_MASK_18,			0x1f7df0ff },
 
 	/* These are not reset by a soft-reset, so patch to defaults. */
 	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index d1bdb0b93bda..8cc2d4937f34 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2021,6 +2021,13 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		bmaControls = ftr->bmaControls;
 	}
 
+	if (channels > 32) {
+		usb_audio_info(state->chip,
+			       "usbmixer: too many channels (%d) in unit %d\n",
+			       channels, unitid);
+		return -EINVAL;
+	}
+
 	/* parse the source unit */
 	err = parse_audio_unit(state, hdr->bSourceID);
 	if (err < 0)

