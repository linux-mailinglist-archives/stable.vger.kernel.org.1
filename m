Return-Path: <stable+bounces-139945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA0AAA2AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC67A1A853E8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE928136C;
	Mon,  5 May 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu+wlemy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21528137C;
	Mon,  5 May 2025 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483748; cv=none; b=pje9apptjic/rwIBQE6A8ouHRCjdcMAIvikl4KFcqhjeIcoyFttDGqmUNjNZQA3+QYeFHaf2iPtTeS1j9Y7SkPDRBnbudp+O+gzomc5oe++xzt/Bhz+OPTFkp+e5BEE9eiNHFNYMRrHTzDAUT23972RfsqJ+Wjpgt6PkHVoqgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483748; c=relaxed/simple;
	bh=1JONFQvlJ4ztdQKRMCgvxbAm0vyafQXEy0jtAPYXM0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1Xca9BfM3aOXlfkQDJ1k3SANBLSqMKAJgCsZaVQkW2cbLFFObw134xr/6FiueVBkRSvAh07xOiFEScPIKYW1kx84f8RoN82+NzL81CiZbyW48w8XY4NI3M+2BL9R4wuZs21UAkaxe3VxtMB6VoUUktcGzRJIPkkBxqdauV29tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu+wlemy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77D1C4CEE4;
	Mon,  5 May 2025 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483747;
	bh=1JONFQvlJ4ztdQKRMCgvxbAm0vyafQXEy0jtAPYXM0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nu+wlemyQUehfNW8rGM5zNmvfGNPaWQiJtf8vqW5VQluBIMjAC3aqt015dlzUi90L
	 uIxZb0BC1D+lYa0+1Bf0Y0vIVOBTMcQG6D1IGxUdCBfN51CsDh0Ugzrxa0RhN3H9WJ
	 h3+6i2/A265710AWVJro+Fr/7fheJ3Zm2505CUTYQzNG10Jt/aZvOPF97D1fc2LRGg
	 8FskH9ny7HWPKrXp/v2u2Vp4JaFHEwz8mJK4w+9x69To9fXRIpEFJwZMf4AqfsrLXw
	 JVqaag0bTvWxgkPtD8hWFPuxeD1xxAGVa1rfdKxDpP7zQJs+WGFbkwdpFxhfHWbH/l
	 8bPMvu3p2gv4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Huang <Leon.Huang1@amd.com>,
	Robin Chen <robin.chen@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wenjing.liu@amd.com,
	zaeem.mohamed@amd.com,
	anthony.koo@amd.com,
	Kaitlyn.Tse@amd.com,
	joshua.aberback@amd.com,
	alex.hung@amd.com,
	Sungjoon.Kim@amd.com,
	muyuan.yang@amd.com,
	michael.strauss@amd.com,
	xi.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 198/642] drm/amd/display: Fix incorrect DPCD configs while Replay/PSR switch
Date: Mon,  5 May 2025 18:06:54 -0400
Message-Id: <20250505221419.2672473-198-sashal@kernel.org>
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

From: Leon Huang <Leon.Huang1@amd.com>

[ Upstream commit 0d9cabc8f591ea1cd97c071b853b75b155c13259 ]

[Why]
When switching between PSR/Replay,
the DPCD config of previous mode is not cleared,
resulting in unexpected behavior in TCON.

[How]
Initialize the DPCD in setup function

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../link/protocols/link_edp_panel_control.c   | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e0e3bb8653595..1e4adbc764ea6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -675,6 +675,18 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!link)
 		return false;
 
+	//Clear PSR cfg
+	memset(&psr_configuration, 0, sizeof(psr_configuration));
+	dm_helpers_dp_write_dpcd(
+		link->ctx,
+		link,
+		DP_PSR_EN_CFG,
+		&psr_configuration.raw,
+		sizeof(psr_configuration.raw));
+
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED)
+		return false;
+
 	dc = link->ctx->dc;
 	dmcu = dc->res_pool->dmcu;
 	psr = dc->res_pool->psr;
@@ -685,9 +697,6 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-
-	memset(&psr_configuration, 0, sizeof(psr_configuration));
-
 	psr_configuration.bits.ENABLE                    = 1;
 	psr_configuration.bits.CRC_VERIFICATION          = 1;
 	psr_configuration.bits.FRAME_CAPTURE_INDICATION  =
@@ -950,6 +959,16 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	if (!link)
 		return false;
 
+	//Clear Replay config
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_SINK_PR_ENABLE_AND_CONFIGURATION,
+		(uint8_t *)&(replay_config.raw), sizeof(uint8_t));
+
+	if (!(link->replay_settings.config.replay_supported))
+		return false;
+
+	link->replay_settings.config.replay_error_status.raw = 0;
+
 	dc = link->ctx->dc;
 
 	replay = dc->res_pool->replay;
-- 
2.39.5


