Return-Path: <stable+bounces-128014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62798A7ADF4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A7F7A1819
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336A1FC0FF;
	Thu,  3 Apr 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxkBki2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F21FBEBD;
	Thu,  3 Apr 2025 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707766; cv=none; b=bfy/F83tgDZPNJZ41gPD5xxTwoe0qNGK2eBggIxTU+isFzfZYHE6r6qPiVzt4PfTv2zTAjEJnsBvlZ3+sVeoEbh58rgB60WypT1hpJx+C2b8gj6O8GLGWO4QPl31AlLOqKUtwUW0mEUMCd+96iiXMMCw0DjwUepzGhihC4i1l/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707766; c=relaxed/simple;
	bh=68T1KwXtStZh529qYJQ/mffpGV6rZOYM3DCQOOlv7w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TVBxc6OQSlmYFWqzCJdd3nzRBNx9IhR9htpMjd0Ubs5UE8K26KH2yMj4ncgAdaNw6946TeoKJZeNqFfQUg4KrrJOQrI4lIk4Jmob82hCiFrWRDB7lsb9qIQaw7roo6PL1+03pteQomCKajwFAZeIN4f/VuGVC12JJhAhgxqCsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxkBki2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D23CC4CEE9;
	Thu,  3 Apr 2025 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707766;
	bh=68T1KwXtStZh529qYJQ/mffpGV6rZOYM3DCQOOlv7w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxkBki2X9bBEaWOZJSSOM3xuWOS2oJPkC+GqgdDyz6LmgkKpqdgEaqI+TRidm0SAS
	 +bRl9g6vLI8VAsq5D8mT4B+VxVyhigfRm3rmKOByNLjdTrkbQ6iWPqIgVDxUQcKZUI
	 yGrPII3vdzSMgAyzPwiLnCvq6U1pce9qM0ST7dpJBBRSlBgwrQXQRt13APuFyQ6tox
	 noSx6O475//OTeKEIBDKohOM+j5Zx4wrQ/d1UOoohJ7GGQS4Zylq4SCUQm+VbpY7V/
	 S4mQmnh7qvgGe3+ivjIuscv3KhpeMDvL6S4Ud2RiutBoTUVuU5u5QPB6LZ0PA/PQyq
	 BOpSPqHnbhwGg==
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
	wayne.lin@amd.com,
	george.shen@amd.com,
	siqueira@igalia.com,
	Cruise.Hung@amd.com,
	robin.chen@amd.com,
	Fudong.Wang@amd.com,
	ryanseto@amd.com,
	alex.hung@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 15/37] drm/amd/display: Update FIXED_VS Link Rate Toggle Workaround Usage
Date: Thu,  3 Apr 2025 15:14:51 -0400
Message-Id: <20250403191513.2680235-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 8dd6eb044829a..aecaf06ba9990 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1104,6 +1104,8 @@ struct dc_lttpr_caps {
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t lttpr_ieee_oui[3];
+	uint8_t lttpr_device_id[6];
 };
 
 struct dc_dongle_dfp_cap_ext {
@@ -1363,6 +1365,12 @@ struct dp_trace {
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
index 9dabaf682171d..d5d1f5ffd4fd8 100644
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


