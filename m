Return-Path: <stable+bounces-159785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEDAF7A60
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A66179BD0
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161C2EA149;
	Thu,  3 Jul 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0MhDJSb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02F2ED16D;
	Thu,  3 Jul 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555341; cv=none; b=uXN+qZdsHV5H8GzwfEKSnstiAXxc6/FcoChRFPZOQC4acJOb/u1I72EPxpl2EfArqKPqrDVMfiwurWYgALpDf0d521ymNjngbfUhTcZ5FPfsUsThF9b/ALA7b3uxzbfDd+wSn2w0ejbAm4qIEAz+L73mj7r5ekdSwON2Hpd54Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555341; c=relaxed/simple;
	bh=hET5iyqQD+IMK3pqsXhpYtluNQS/ZVqZKLsi4X4EupY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEZ5sib+KIiRXdz7UQwfnGlDCUmhR2WBz5Rloqha3rfcjF4yoYUmFj4NIz/7R4k9+EEShWa+TwX9ozhyPvzxiGgxG+dpQsnXapGXxp0E1ZED+d5EJLj4xjlcbgFaQIQ0Xvh7ctWOZUrSdNZokcah0Zr6ysdR6N0jGR6a8KcYsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0MhDJSb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31E4C4CEE3;
	Thu,  3 Jul 2025 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555341;
	bh=hET5iyqQD+IMK3pqsXhpYtluNQS/ZVqZKLsi4X4EupY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0MhDJSb38ivEdHPY26HZejyo1QHWo4qYZTZ9ZDKph10PEuCAvqt2K4e5JuufLEegi
	 y9sLxjbd7NJXDwbx4ZL+BEzv2QDNzs/TBkf5Yv5h9OnKaR/2qQejgOIU5tUNX7cOoG
	 zmzAamRXKG83N3AwYiPujYCdtwdan2N8nVxgIi/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenjing Liu <wenjing.liu@amd.com>,
	Michael Strauss <michael.strauss@amd.com>,
	TungYu Lu <tungyu.lu@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 248/263] drm/amd/display: Add early 8b/10b channel equalization test pattern sequence
Date: Thu,  3 Jul 2025 16:42:48 +0200
Message-ID: <20250703144014.361568624@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 8989cb919b27cd0d2aadb7f1d144cedbb12e6fca ]

[WHY]
Early EQ pattern sequence is required for some LTTPR + old dongle
combinations.

[HOW]
If DP_EARLY_8B10B_TPS2 chip cap is set, this new sequence programs phy
to output TPS2 before initiating link training and writes TPS1 to
LTTPR training pattern register as instructed by vendor.

Add function to get embedded LTTPR target address offset.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: TungYu Lu <tungyu.lu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/protocols/link_dp_capability.c    |  8 +++
 .../dc/link/protocols/link_dp_capability.h    |  3 ++
 .../dc/link/protocols/link_dp_training.c      |  1 -
 .../link/protocols/link_dp_training_8b_10b.c  | 52 +++++++++++++++++--
 .../amd/display/include/link_service_types.h  |  2 +
 5 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 21ee0d96c9d48..9d49e77a24a1f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -158,6 +158,14 @@ uint8_t dp_parse_lttpr_repeater_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
+uint32_t dp_get_closest_lttpr_offset(uint8_t lttpr_count)
+{
+	/* Calculate offset for LTTPR closest to DPTX which is highest in the chain
+	 * Offset is 0 for single LTTPR cases as base LTTPR DPCD addresses target LTTPR 1
+	 */
+	return DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE * (lttpr_count - 1);
+}
+
 uint32_t link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw)
 {
 	switch (bw) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index 0ce0af3ddbebe..940b147cc5d42 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -48,6 +48,9 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link);
 /* Convert PHY repeater count read from DPCD uint8_t. */
 uint8_t dp_parse_lttpr_repeater_count(uint8_t lttpr_repeater_count);
 
+/* Calculate embedded LTTPR address offset for vendor-specific behaviour */
+uint32_t dp_get_closest_lttpr_offset(uint8_t lttpr_count);
+
 bool dp_is_sink_present(struct dc_link *link);
 
 bool dp_is_lttpr_present(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index ef358afdfb65b..2dc1a660e5045 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -785,7 +785,6 @@ void override_training_settings(
 		lt_settings->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 
 	dp_get_lttpr_mode_override(link, &lt_settings->lttpr_mode);
-
 }
 
 enum dc_dp_training_pattern decide_cr_training_pattern(
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 5a5d48fadbf27..66d0fb1b9b9d2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -142,6 +142,14 @@ void decide_8b_10b_training_settings(
 	lt_settings->lttpr_mode = dp_decide_8b_10b_lttpr_mode(link);
 	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting, lt_settings->lttpr_mode);
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+
+	/* Some embedded LTTPRs rely on receiving TPS2 before LT to interop reliably with sensitive VGA dongles
+	 * This allows these LTTPRs to minimize freq/phase and skew variation during lock and deskew sequences
+	 */
+	if ((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) ==
+			AMD_EXT_DISPLAY_PATH_CAPS__DP_EARLY_8B10B_TPS2) {
+		lt_settings->lttpr_early_tps2 = true;
+	}
 }
 
 enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
@@ -173,6 +181,42 @@ enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
 	return LTTPR_MODE_NON_LTTPR;
 }
 
+static void set_link_settings_and_perform_early_tps2_retimer_pre_lt_sequence(struct dc_link *link,
+	const struct link_resource *link_res,
+	struct link_training_settings *lt_settings,
+	uint32_t lttpr_count)
+{
+	/* Vendor-specific LTTPR early TPS2 sequence:
+	* 1. Output TPS2
+	* 2. Wait 400us
+	* 3. Set link settings as usual
+	* 4. Write TPS1 to DP_TRAINING_PATTERN_SET_PHY_REPEATERx targeting LTTPR closest to host
+	* 5. Wait 1ms
+	* 6. Begin link training as usual
+	* */
+
+	uint32_t closest_lttpr_address_offset = dp_get_closest_lttpr_offset(lttpr_count);
+
+	union dpcd_training_pattern dpcd_pattern = {0};
+
+	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = 1;
+	dpcd_pattern.v1_4.SCRAMBLING_DISABLE = 1;
+
+	DC_LOG_HW_LINK_TRAINING("%s\n GPU sends TPS2. Wait 400us.\n", __func__);
+
+	dp_set_hw_training_pattern(link, link_res, DP_TRAINING_PATTERN_SEQUENCE_2, DPRX);
+
+	dp_set_hw_lane_settings(link, link_res, lt_settings, DPRX);
+
+	udelay(400);
+
+	dpcd_set_link_settings(link, lt_settings);
+
+	core_link_write_dpcd(link, DP_TRAINING_PATTERN_SET_PHY_REPEATER1 + closest_lttpr_address_offset, &dpcd_pattern.raw, 1);
+
+	udelay(1000);
+	}
+
 enum link_training_result perform_8b_10b_clock_recovery_sequence(
 	struct dc_link *link,
 	const struct link_resource *link_res,
@@ -383,7 +427,7 @@ enum link_training_result dp_perform_8b_10b_link_training(
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 
-	uint8_t repeater_cnt;
+	uint8_t repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	uint8_t repeater_id;
 	uint8_t lane = 0;
 
@@ -391,14 +435,16 @@ enum link_training_result dp_perform_8b_10b_link_training(
 		start_clock_recovery_pattern_early(link, link_res, lt_settings, DPRX);
 
 	/* 1. set link rate, lane count and spread. */
-	dpcd_set_link_settings(link, lt_settings);
+	if (lt_settings->lttpr_early_tps2)
+		set_link_settings_and_perform_early_tps2_retimer_pre_lt_sequence(link, link_res, lt_settings, repeater_cnt);
+	else
+		dpcd_set_link_settings(link, lt_settings);
 
 	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
 		 */
-		repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 
 		for (repeater_id = repeater_cnt; (repeater_id > 0 && status == LINK_TRAINING_SUCCESS);
 				repeater_id--) {
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 1867aac57cf2c..da74ed66c8f9d 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -89,6 +89,8 @@ struct link_training_settings {
 	bool enhanced_framing;
 	enum lttpr_mode lttpr_mode;
 
+	bool lttpr_early_tps2;
+
 	/* disallow different lanes to have different lane settings */
 	bool disallow_per_lane_settings;
 	/* dpcd lane settings will always use the same hw lane settings
-- 
2.39.5




