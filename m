Return-Path: <stable+bounces-94912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283DB9D7520
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C62B2B6E8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAF1B218E;
	Sun, 24 Nov 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ektTkZ2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB91B0F34;
	Sun, 24 Nov 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455214; cv=none; b=CyXTMiClt4gng8K/9qL71X8JiLQPJF9xhBz9MgOAbk4ta1WP8crY3F2c/zN+8sdsURUS0bqR/LWWfbC9cFimyx9ZrEGnVAhcMnyvHe0rKg3HfvY8uY+2sotL87S0gJ+R3YzHVTkCPvCfPbvAjOHTLfUva2D16bjsD0w2qHEvyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455214; c=relaxed/simple;
	bh=gQhLTHHexreWu6vGLnNR+R7mKdozoHlwdHtZyWiXySU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3+z0UO1iOBkplFAM3pT+FNwg12F1/XYtw5cxGNlXnneGBBJu+giFu3Fwl2ae2osvAYJ3wWrueGDeQvdfeHk1DSZtCjMZeWmiCoXf+asVpMGZktH/jKRMrIbh9la5iVqdiNbUn9w5C8/BNxNSut5YSKH7KrzYh5mHqj6qWP9csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ektTkZ2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2F3C4CECC;
	Sun, 24 Nov 2024 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455214;
	bh=gQhLTHHexreWu6vGLnNR+R7mKdozoHlwdHtZyWiXySU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ektTkZ2b+ZtSD8tmlZTic5JN1DF8LKy++IUXRMHc2jaZ2dNGAE+kOdHCgijhfQdJv
	 HLH2U2WSsCHcJYC7iHYuX2xUsQ34QvQ5XZP27j420xFWMAah/LQmjAU/V4pApR8UMu
	 qlWg9smNGVomHiA5tkyMTz8SyA7o0w9DrUZF3M5pBc2X645rl1y654ZfhJjaoxh8F0
	 LjMyw73t4MoRLOf5WC0WllUCEHXZk0lb0O/t7t/Ir1HF2FiuD7pudMNlxVbcuvRgDr
	 EitHOR6VYsA/2ISBsRAlOIxKUtEcXTvL2O7DU+Ez9IVvK2blkfnr3JV2sMCPLy5ktN
	 iecwDP0Yr3UGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Strauss <michael.strauss@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	george.shen@amd.com,
	daniel.sa@amd.com,
	Ausef.Yousof@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 016/107] drm/amd/display: Block UHBR Based On USB-C PD Cable ID
Date: Sun, 24 Nov 2024 08:28:36 -0500
Message-ID: <20241124133301.3341829-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 4f01a68751194d05280d659a65758c09e4af04d6 ]

[WHY]
Currently the absence of UHBR cable ID caps from USB-C PD does not block UHBR
rates. In situations where DPCD reports valid UHBR capability but USB-C PD
does not, such as using a USB-C to DP1.4 dongle connected to a native DP2.1
cable, link loss and lightup failures can be seen as a result.

Additionally, in edge cases where a platform supports cable ID but DMUB
doesn't correctly return cable ID caps, driver currently also allows UHBR.

[HOW]
Block UHBR rates over DP alt mode if cable id indicates no UHBR support.
Additionally, block UHBR rates if a cable ID supported platform receives no
reply from a DMUB cable id query.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/protocols/link_dp_capability.c    | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d78c8ec4de79e..fe4aa2c158eae 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1409,7 +1409,8 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 
 	if (!link->ctx->dmub_srv ||
 			link->ep_type != DISPLAY_ENDPOINT_PHY ||
-			link->link_enc->features.flags.bits.DP_IS_USB_C == 0)
+			link->link_enc->features.flags.bits.DP_IS_USB_C == 0 ||
+			link->link_enc->features.flags.bits.IS_DP2_CAPABLE == 0)
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -1422,7 +1423,9 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 		cable_id->raw = cmd.cable_id.data.output_raw;
 		DC_LOG_DC("usbc_cable_id = %d.\n", cable_id->raw);
 	}
-	return cmd.cable_id.header.ret_status == 1;
+
+	ASSERT(cmd.cable_id.header.ret_status);
+	return true;
 }
 
 static void retrieve_cable_id(struct dc_link *link)
@@ -2103,6 +2106,8 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	/* get max link encoder capability */
 	if (link_enc)
 		link_enc->funcs->get_max_link_cap(link_enc, &max_link_cap);
+	else
+		return max_link_cap;
 
 	/* Lower link settings based on sink's link cap */
 	if (link->reported_link_cap.lane_count < max_link_cap.lane_count)
@@ -2136,10 +2141,15 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 */
 	cable_max_link_rate = get_cable_max_link_rate(link);
 
-	if (!link->dc->debug.ignore_cable_id &&
-			cable_max_link_rate != LINK_RATE_UNKNOWN) {
-		if (cable_max_link_rate < max_link_cap.link_rate)
-			max_link_cap.link_rate = cable_max_link_rate;
+	if (!link->dc->debug.ignore_cable_id) {
+		if (cable_max_link_rate != LINK_RATE_UNKNOWN)
+			// cable max link rate known
+			max_link_cap.link_rate = MIN(max_link_cap.link_rate, cable_max_link_rate);
+		else if (link_enc->funcs->is_in_alt_mode && link_enc->funcs->is_in_alt_mode(link_enc))
+			// cable max link rate ambiguous, DP alt mode, limit to HBR3
+			max_link_cap.link_rate = MIN(max_link_cap.link_rate, LINK_RATE_HIGH3);
+		//else {}
+			// cable max link rate ambiguous, DP, do nothing
 
 		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY &&
 				link->dpcd_caps.cable_id.bits.CABLE_TYPE >= 2)
-- 
2.43.0


