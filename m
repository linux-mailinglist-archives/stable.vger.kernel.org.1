Return-Path: <stable+bounces-141179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006A4AAB65C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FC43AA059
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23133344F2;
	Tue,  6 May 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgy7cuhw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CA2C1E2E;
	Mon,  5 May 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485407; cv=none; b=OYnORzyxfJuk5ImWB8PfB4rK8sIVBq3fqZCNjqyvHuSzNoFPaYHYFXLeoOVxlV5gjqtTurA++hQ0eCjohOlSFg7P8wBKc/wfOPQZo6ZPcLh4q30UV5JKRvJLiStrankQNQ/S5cIaddYpnp8I31DJbf1S2duF6oxdlssHE2QWLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485407; c=relaxed/simple;
	bh=TmMziUAO7Ca/u8ecyVo8LJZtOW71FIb95pElB9+CaSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0AG08eFg+AohTkEbpAd+TjneL68+ownuls9VUcapUV4b3sLVhdYKiqzxUOEQMOPEdlfzVulP8WqultQgG/GwXNVFX48th4SYFOFgVYD20Ytcl5FgdITT7dNT7jY2pKMqEqlKjuPRB52b936dd0ntfbVGYn8C4bhW45XBdtNmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgy7cuhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19B0C4CEED;
	Mon,  5 May 2025 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485407;
	bh=TmMziUAO7Ca/u8ecyVo8LJZtOW71FIb95pElB9+CaSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wgy7cuhwyWy5mEIJydT180q+bg1t7TcbNaILhZa8XHcj8rzFr6Wv6H/GcmP9ZQ1b9
	 8PUVlplCSzo4o+sfGfzln6senT5/UxiggoGrL+4xkcSv5XRCD2S6wKQ0JBnRI95LmV
	 ONMq/6DPnWgCAQNsoW0+9XVK03JABZgjSIPzVQOedoy/8JI/LlbDpvZ0lawUze02Rf
	 8RNsZ7OEy0j1aUh2d32dtDxjn0UeqALqtzrtndHK+hJxW+yu/W3T/7C4hEWbEeOFAG
	 dPiHfDJvOdwXJuupRBZ6CiUACd+K1KWH2K/F/GScn+IH3H1B0WBzMEttKHtbqjxbtJ
	 Hc6P2FD+Idnqw==
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
	Gabe.Teeger@amd.com,
	michael.strauss@amd.com,
	Hansen.Dsouza@amd.com,
	robin.chen@amd.com,
	Cruise.Hung@amd.com,
	ryanseto@amd.com,
	alex.hung@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 303/486] drm/amd/display: Read LTTPR ALPM caps during link cap retrieval
Date: Mon,  5 May 2025 18:36:19 -0400
Message-Id: <20250505223922.2682012-303-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 41bd95e9177a4..223c3d55544b2 100644
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
@@ -1103,6 +1111,7 @@ struct dc_lttpr_caps {
 	uint8_t max_ext_timeout;
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
+	union dp_alpm_lttpr_cap alpm;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
 };
 
@@ -1352,6 +1361,9 @@ struct dp_trace {
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
index d9a1e1a599674..842636c7922b4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1495,7 +1495,7 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8] = {0};
+	uint8_t lttpr_dpcd_data[10] = {0};
 	enum dc_status status;
 	bool is_lttpr_present;
 
@@ -1545,6 +1545,10 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 			lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
 							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+	link->dpcd_caps.lttpr_caps.alpm.raw =
+			lttpr_dpcd_data[DP_LTTPR_ALPM_CAPABILITIES -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
 	/* If this chip cap is set, at least one retimer must exist in the chain
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
 	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-- 
2.39.5


