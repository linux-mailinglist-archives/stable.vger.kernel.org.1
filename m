Return-Path: <stable+bounces-127974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B51A7ADC7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D299177D2A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712E25DD1A;
	Thu,  3 Apr 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxGCVa+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123F25DB11;
	Thu,  3 Apr 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707657; cv=none; b=dNQeQyQwXXe++0R9dJDnoQdnj+fX5ko1tFnQQPBxwZpE+ZSFfcH4JXEqY8UWziQEG2smUaxoHEuBGXOO4+9QFXpX6+GhO3ysl6wDXyDFA7DdnrGQ60qHPVSlghSh0D0vbEbl37hxTfs+/kwxMXnShM8w6RHczsEv46MLPBYrgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707657; c=relaxed/simple;
	bh=rfSVIvWIvrcWspSxI4xZIo2hUwyZBvaY8onLw1tWd50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWlttdZxHheaF4+I7kyvvdj+byg37HXzT9m1mPNg0hV5F+t8yxtKO9JikgoP0oLfEBVvYOd0la7usybpXygyWZjqVBPGX1pxADtDmESASyR96UmdYX8lCccl2bx6pi2BVEpapAb+3kAW5TCG28ysScGl1J7DVX3t9pq3vS5C8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxGCVa+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA02C4CEE3;
	Thu,  3 Apr 2025 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707657;
	bh=rfSVIvWIvrcWspSxI4xZIo2hUwyZBvaY8onLw1tWd50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxGCVa+vsdVBRwN/TaVHG/cknMtDDicmkYwCinm0Xu18IsmrHstnZm8GD2uqhXLH6
	 lztbwhxlA3VXYylbstoWxV73gQGRKZH1mJocmk4KfwAkT+SPoaDLZM+tlLDcQcEeSn
	 2lJpalyP35Q2GSQaM/pgWl9DtdRwjYcEgRwF46IrsV64ik9ITE5kdrj4djcNfpcq4e
	 5bT9h+IuyGSuWsPyVnbjmq8mDRYjbkT/j+M3e8gtvjrkXGP5VnKhlEGJ8pMezp1uza
	 lyIgQcYotLt7rXORrQMJhwYUxbvGZ69iVk46/nehLrNC+4BUEJyThAupUVIF7lv1ad
	 cLeURn1sAW1CQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Strauss <michael.strauss@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	roman.li@amd.com,
	george.shen@amd.com,
	wayne.lin@amd.com,
	siqueira@igalia.com,
	Fudong.Wang@amd.com,
	Gabe.Teeger@amd.com,
	Cruise.Hung@amd.com,
	ryanseto@amd.com,
	alex.hung@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 19/44] drm/amd/display: Update FIXED_VS Link Rate Toggle Workaround Usage
Date: Thu,  3 Apr 2025 15:12:48 -0400
Message-Id: <20250403191313.2679091-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 7c6518c1c73199a230b5fc55ddfed3e5b9dc3290 ]

[WHY]
Previously the 128b/132b LTTPR support DPCD field was used to decide if
FIXED_VS training sequence required a rate toggle before initiating LT.

When running DP2.1 4.9.x.x compliance tests, emulated LTTPRs can report
no-128b/132b support which is then forwarded by the FIXED_VS retimer.
As a result this test exposes the rate toggle again, erroneously causing
failures as certain compliance sinks don't expect this behaviour.

[HOW]
Add new DPCD register defines/reads to read LTTPR IEEE OUI and device ID.

Decide whether to perform the rate toggle based on the LTTPR's IEEE OUI
which guarantees that we only perform the toggle on affected retimers.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h         |  8 ++++++++
 .../display/dc/link/protocols/link_dp_capability.c   | 12 ++++++++++--
 .../protocols/link_dp_training_fixed_vs_pe_retimer.c |  3 ++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 94ce8fe744810..cc005da75ce4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1119,6 +1119,8 @@ struct dc_lttpr_caps {
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t lttpr_ieee_oui[3];
+	uint8_t lttpr_device_id[6];
 };
 
 struct dc_dongle_dfp_cap_ext {
@@ -1379,6 +1381,12 @@ struct dp_trace {
 #ifndef DP_BRANCH_VENDOR_SPECIFIC_START
 #define DP_BRANCH_VENDOR_SPECIFIC_START     0x50C
 #endif
+#ifndef DP_LTTPR_IEEE_OUI
+#define DP_LTTPR_IEEE_OUI 0xF003D
+#endif
+#ifndef DP_LTTPR_DEVICE_ID
+#define DP_LTTPR_DEVICE_ID 0xF0040
+#endif
 /** USB4 DPCD BW Allocation Registers Chapter 10.7 **/
 #ifndef DP_TUNNELING_CAPABILITIES
 #define DP_TUNNELING_CAPABILITIES			0xE000D /* 1.4a */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 44c3023a77318..44f33e3bc1c59 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1568,10 +1568,18 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 	is_lttpr_present = dp_is_lttpr_present(link);
 
-	if (is_lttpr_present)
+	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
+
+	if (is_lttpr_present) {
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
-	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
+		core_link_read_dpcd(link, DP_LTTPR_IEEE_OUI, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
+		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui), "LTTPR IEEE OUI: ");
+
+		core_link_read_dpcd(link, DP_LTTPR_DEVICE_ID, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id));
+		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id), "LTTPR Device ID: ");
+	}
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index ccf8096dde290..ce174ce5579c0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -270,7 +270,8 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 	rate = get_dpcd_link_rate(&lt_settings->link_settings);
 
-	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED) {
+	// Only perform toggle if FIXED_VS LTTPR reports no IEEE OUI
+	if (memcmp("\x0,\x0,\x0", &link->dpcd_caps.lttpr_caps.lttpr_ieee_oui[0], 3) == 0) {
 		/* Vendor specific: Toggle link rate */
 		toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-- 
2.39.5


