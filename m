Return-Path: <stable+bounces-158945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E2AEDD54
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987103AFDB0
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC54284B46;
	Mon, 30 Jun 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bxca4P0v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14B27FB2E
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287449; cv=none; b=rFJzyvGeI62nFSeq3pPvUhGYTzki+Gy2rczwqQBdGJRTjhyGG67Ctdv5FWSRW9Q+EeKH8ftnH/hnWLFrySJ0WHZkk1VSoQoqgonBurOaASEcN3IM8D3iZsOE7Pa2Lmvx38D93yqZi6qBLhFgzl8Gn4ri6XGEIZ6SCTvoxy1Qz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287449; c=relaxed/simple;
	bh=q2YPIhjdzoWvenxjQhD97l4PJ+I0qdbnh1j6rpJKjOw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QWDvvZRQqUhAvVX2SrCt94ipc9yGrdHSg7nEoDFdCBLGk6O4Mn6clDFUu9uRvMisN9tu/6xMxmHY0mOj0akyuj+NV9/ZH/I7LYL3KOKQq+QX5LIovZmlIanvnPnlJBeViwg1c2nOe129vYTaBwasIwJL1oJMgC3/No09+CjkwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bxca4P0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464D4C4CEE3;
	Mon, 30 Jun 2025 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287448;
	bh=q2YPIhjdzoWvenxjQhD97l4PJ+I0qdbnh1j6rpJKjOw=;
	h=Subject:To:Cc:From:Date:From;
	b=bxca4P0vCd5P+hOtTFMZv5ARZwKk/nlUO+RYZpA2i0bEeEqDb/x6uOzHw73IAW9OM
	 Wk/TOixEIcVdkQr//wKicPd8Kkzo+4f3e3tSSeaslh1qQrKk6zEZg5Wr+F0/pyOekx
	 8Ns1kSCUh91qBnbbzXLknzaZfao695DG1lGfiCs0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Get LTTPR IEEE OUI/Device ID From Closest" failed to apply to 6.15-stable tree
To: michael.strauss@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:44:05 +0200
Message-ID: <2025063005-crop-granular-c1cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x d358a51444c88bcc995e471dc8cc840f19e4b374
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063005-crop-granular-c1cb@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d358a51444c88bcc995e471dc8cc840f19e4b374 Mon Sep 17 00:00:00 2001
From: Michael Strauss <michael.strauss@amd.com>
Date: Wed, 26 Feb 2025 10:03:48 -0500
Subject: [PATCH] drm/amd/display: Get LTTPR IEEE OUI/Device ID From Closest
 LTTPR To Host

[WHY]
These fields are read for the explicit purpose of detecting embedded LTTPRs
(i.e. between host ASIC and the user-facing port), and thus need to
calculate the correct DPCD address offset based on LTTPR count to target
the appropriate LTTPR's DPCD register space with these queries.

[HOW]
Cascaded LTTPRs in a link each snoop and increment LTTPR count when queried
via DPCD read, so an LTTPR embedded in a source device (e.g. USB4 port on a
laptop) will always be addressible using the max LTTPR count seen by the
host. Therefore we simply need to use a recently added helper function to
calculate the correct DPCD address to target potentially embedded LTTPRs
based on the received LTTPR count.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 791897f5c77a2a65d0e500be4743af2ddf6eb061)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 0bad8304ccf6..d346f8ae1634 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1172,8 +1172,8 @@ struct dc_lttpr_caps {
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	union dp_alpm_lttpr_cap alpm;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
-	uint8_t lttpr_ieee_oui[3];
-	uint8_t lttpr_device_id[6];
+	uint8_t lttpr_ieee_oui[3]; // Always read from closest LTTPR to host
+	uint8_t lttpr_device_id[6]; // Always read from closest LTTPR to host
 };
 
 struct dc_dongle_dfp_cap_ext {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index a5127c2d47ef..0f965380a9b4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -385,9 +385,15 @@ bool dp_is_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 bool dp_is_lttpr_present(struct dc_link *link)
 {
 	/* Some sink devices report invalid LTTPR revision, so don't validate against that cap */
-	return (dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
+	uint32_t lttpr_count = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	bool is_lttpr_present = (lttpr_count > 0 &&
 			link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 			link->dpcd_caps.lttpr_caps.max_lane_count <= 4);
+
+	if (lttpr_count > 0 && !is_lttpr_present)
+		DC_LOG_ERROR("LTTPR count is nonzero but invalid lane count reported. Assuming no LTTPR present.\n");
+
+	return is_lttpr_present;
 }
 
 /* in DP compliance test, DPR-120 may have
@@ -1551,6 +1557,8 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	uint8_t lttpr_dpcd_data[10] = {0};
 	enum dc_status status;
 	bool is_lttpr_present;
+	uint32_t lttpr_count;
+	uint32_t closest_lttpr_offset;
 
 	/* Logic to determine LTTPR support*/
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
@@ -1602,20 +1610,22 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 			lttpr_dpcd_data[DP_LTTPR_ALPM_CAPABILITIES -
 							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+	lttpr_count = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
 	/* If this chip cap is set, at least one retimer must exist in the chain
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
 	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			(dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
+			lttpr_count == 0) {
 		/* If you see this message consistently, either the host platform has FIXED_VS flag
 		 * incorrectly configured or the sink device is returning an invalid count.
 		 */
 		DC_LOG_ERROR("lttpr_caps phy_repeater_cnt is 0x%x, forcing it to 0x80.",
 			     link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 		link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
+		lttpr_count = 1;
 		DC_LOG_DC("lttpr_caps forced phy_repeater_cnt = %d\n", link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	}
 
-	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 	is_lttpr_present = dp_is_lttpr_present(link);
 
 	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
@@ -1623,11 +1633,25 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	if (is_lttpr_present) {
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
-		core_link_read_dpcd(link, DP_LTTPR_IEEE_OUI, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
-		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui), "LTTPR IEEE OUI: ");
+		// Identify closest LTTPR to determine if workarounds required for known embedded LTTPR
+		closest_lttpr_offset = dp_get_closest_lttpr_offset(lttpr_count);
 
-		core_link_read_dpcd(link, DP_LTTPR_DEVICE_ID, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id));
-		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id), "LTTPR Device ID: ");
+		core_link_read_dpcd(link, (DP_LTTPR_IEEE_OUI + closest_lttpr_offset),
+				link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
+		core_link_read_dpcd(link, (DP_LTTPR_DEVICE_ID + closest_lttpr_offset),
+				link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id));
+
+		if (lttpr_count > 1) {
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui),
+					"Closest LTTPR To Host's IEEE OUI: ");
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id),
+					"Closest LTTPR To Host's LTTPR Device ID: ");
+		} else {
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui),
+					"LTTPR IEEE OUI: ");
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id),
+					"LTTPR Device ID: ");
+		}
 	}
 
 	return status;


