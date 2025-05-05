Return-Path: <stable+bounces-140134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD60AAA578
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD39B1885A1F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057EF28C5A5;
	Mon,  5 May 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnojNsON"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2327A441;
	Mon,  5 May 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484191; cv=none; b=MV+0d+Gn9/rXb4h2NRhnQUFbl3IP6KI2Lhd93hzoDp+GgoLYL1rQshGyoKXdD1HWRoHu1XUsmt4Ix/hNcczr/JcuVhs4Dnv2RHjy3ObO3t3+ZPj/GKxCrCAU1Y8qlOasHIJc3kjK4ecATvasKsFiozH15MaKv23jB9b7ygh2GAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484191; c=relaxed/simple;
	bh=fzDozuo7kbxJDxbgO7Loiq2m58dhuP02qkoTWNSOdk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0aFNNV/O1ekCzKBaG/EFyOY3+8X+1r5GHM5FU/Yre5/h4BLWALKhXEZaPO9l6YA82piaGVF+p517vy0stvSgl4Gdut0W1+EFvPAaoD5VaulDmDYCe8VQKQkfnFA3NLj3SnlLAOmzCoMrSAZ/X7usLx/Zf0/Vum9GXvP72OWgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnojNsON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94518C4CEED;
	Mon,  5 May 2025 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484191;
	bh=fzDozuo7kbxJDxbgO7Loiq2m58dhuP02qkoTWNSOdk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnojNsONxLOzPFij/xsBDGVJrJyMPb3gpJspU77bx+roTAThsB88cB/7SXsFH+hnd
	 5Hi0Al4oPSEtEpmbi2r8R1vlKQsdotxIxWNdiSjQKqGCypkFYoaB1ahHQpu5OEqkfa
	 c6oEDlGFhckihhSj08P6WAPTvx9s2y3uLI4vlbN8HPHq5UyQtz1WuQXGAUQQxEgyzI
	 WmJYTpUt/6EcJNmtEkPROJ7VITscxvXybHWf88LS8TYHJ41pEQ2YivGYWBoGPlunVY
	 qhoEFYs1i81Xmn8MnM/xj/jAE6diPsW517CHY7AtvMlrB6uWGYR5ZbMXoEXYfrGMmg
	 /XqYAoKV5Jkdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Shen <george.shen@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wayne.lin@amd.com,
	alex.hung@amd.com,
	robin.chen@amd.com,
	Fudong.Wang@amd.com,
	Cruise.Hung@amd.com,
	Hansen.Dsouza@amd.com,
	ryanseto@amd.com,
	michael.strauss@amd.com,
	Gabe.Teeger@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 387/642] drm/amd/display: Read LTTPR ALPM caps during link cap retrieval
Date: Mon,  5 May 2025 18:10:03 -0400
Message-Id: <20250505221419.2672473-387-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: George Shen <george.shen@amd.com>

[ Upstream commit de84d580126eb2214937df755cfec5ef0901479e ]

[Why]
The latest DP spec requires the DP TX to read DPCD F0000h through F0009h
when detecting LTTPR capabilities for the first time.

[How]
Update LTTPR cap retrieval to read up to F0009h (two more bytes than the
previous F0007h), and store the LTTPR ALPM capabilities.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h         | 12 ++++++++++++
 .../display/dc/link/protocols/link_dp_capability.c   |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index cc005da75ce4c..8bb628ab78554 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -959,6 +959,14 @@ union dp_128b_132b_supported_lttpr_link_rates {
 	uint8_t raw;
 };
 
+union dp_alpm_lttpr_cap {
+	struct {
+		uint8_t AUX_LESS_ALPM_SUPPORTED	:1;
+		uint8_t RESERVED				:7;
+	} bits;
+	uint8_t raw;
+};
+
 union dp_sink_video_fallback_formats {
 	struct {
 		uint8_t dp_1024x768_60Hz_24bpp_support	:1;
@@ -1118,6 +1126,7 @@ struct dc_lttpr_caps {
 	uint8_t max_ext_timeout;
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
+	union dp_alpm_lttpr_cap alpm;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
 	uint8_t lttpr_ieee_oui[3];
 	uint8_t lttpr_device_id[6];
@@ -1372,6 +1381,9 @@ struct dp_trace {
 #ifndef DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP
 #define DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP    0x221c
 #endif
+#ifndef DP_LTTPR_ALPM_CAPABILITIES
+#define DP_LTTPR_ALPM_CAPABILITIES              0xF0009
+#endif
 #ifndef DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE	0x50
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 28843e9882d39..64e4ae379e346 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1502,7 +1502,7 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8] = {0};
+	uint8_t lttpr_dpcd_data[10] = {0};
 	enum dc_status status;
 	bool is_lttpr_present;
 
@@ -1552,6 +1552,10 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 			lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
 							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+	link->dpcd_caps.lttpr_caps.alpm.raw =
+			lttpr_dpcd_data[DP_LTTPR_ALPM_CAPABILITIES -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
 	/* If this chip cap is set, at least one retimer must exist in the chain
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
 	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-- 
2.39.5


