Return-Path: <stable+bounces-140217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715AAAA636
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABFE18866A7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA81F3FDC;
	Mon,  5 May 2025 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwADsG90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD81321AE3;
	Mon,  5 May 2025 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484394; cv=none; b=HGMK37g2Ngi0w1+3xT3xazdSdD0aZUg6U6ctQfbhFLkdIwthhjzLl0LD3Stz4UICrCWd3WU/Y4awOluccKsPirhdUwijRATlscPt21ALV4Ki+2N5zXZpDc3tPYQAD0OWySBkg0lsv+tgi+W8V03bzPL9RbfZkN5vAiz/2l/yptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484394; c=relaxed/simple;
	bh=OQjj1QeJSiWUuGolg3JzwbiKZ5XQu+iPTgHHNverttU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJTGYqhnP2Oe34AAm5J70TwW2SK3wTMtvPVuU4M2xaO29oGkU6Tr1dI7S5cUjw2XbI4G57dQ4K6S0KPhUxBA0sQaTMlBxmVTPp5uzZwb3EnouO8aW6szq6P5JAJAYAP9hnOQd2SR/6lQ8OLW65WKcESIxHL3niPup+8l8tj2ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwADsG90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5D2C4CEE4;
	Mon,  5 May 2025 22:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484394;
	bh=OQjj1QeJSiWUuGolg3JzwbiKZ5XQu+iPTgHHNverttU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwADsG90/iI94zidOKLbE/Je57Nf53PLaT0JG+b7ThK90MgJPIYPxbDzCHFbVvQ2C
	 PCfcf5RVeMSQKY66I/clYNteKcraD1Z/DzmA57mS6zhnh916JTLESSUJa3Qdm4N09v
	 sWNkG4jjLfMHMyPwlByK4y5M0N08uDw9i35HkRItaL1QHhoUFfyZWWjo2uVsLv+ZG4
	 pu0amtIj7kkrb8fdoidtGfxcAM3+ALeU4rgiCRGCjHfKORb8pxJc84jbdjX30WQaFM
	 xCvoQv1rSYpa+B//YJqtvzv8UNE0Impoar3Re8JiT5K62jk99HEivS3l/jxVHuPCWO
	 bd9LQExw9Mp0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dillon Varone <dillon.varone@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	siqueira@igalia.com,
	wenjing.liu@amd.com,
	Alvin.Lee2@amd.com,
	joshua.aberback@amd.com,
	rostrows@amd.com,
	srinivasan.shanmugam@amd.com,
	Wayne.Lin@amd.com,
	yi-lchen@amd.com,
	nevenko.stupar@amd.com,
	sarvinde@amd.com,
	Austin.Zheng@amd.com,
	karthi.kandasamy@amd.com,
	peterson.guo@amd.com,
	relja.vojvodic@amd.com,
	jerry.zuo@amd.com,
	Ilya.Bakoulin@amd.com,
	aurabindo.pillai@amd.com,
	ryanseto@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 469/642] drm/amd/display: Ammend DCPG IP control sequences to align with HW guidance
Date: Mon,  5 May 2025 18:11:25 -0400
Message-Id: <20250505221419.2672473-469-sashal@kernel.org>
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

From: Dillon Varone <dillon.varone@amd.com>

[ Upstream commit cbd97d621ece1d92c3542e52f8af7c04cd2c6afb ]

[WHY&HOW]
IP_REQUEST_CNTL should only be toggled off when it was originally, never
unconditionally.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 14 +++++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 34 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  3 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index f7e31aec32058..1a07973ead4f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1264,14 +1264,18 @@ static void dcn20_power_on_plane_resources(
 	struct dce_hwseq *hws,
 	struct pipe_ctx *pipe_ctx)
 {
+	uint32_t org_ip_request_cntl = 0;
+
 	DC_LOGGER_INIT(hws->ctx->logger);
 
 	if (hws->funcs.dpp_root_clock_control)
 		hws->funcs.dpp_root_clock_control(hws, pipe_ctx->plane_res.dpp->inst, true);
 
 	if (REG(DC_IP_REQUEST_CNTL)) {
-		REG_SET(DC_IP_REQUEST_CNTL, 0,
-				IP_REQUEST_EN, 1);
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0,
+					IP_REQUEST_EN, 1);
 
 		if (hws->funcs.dpp_pg_control)
 			hws->funcs.dpp_pg_control(hws, pipe_ctx->plane_res.dpp->inst, true);
@@ -1279,8 +1283,10 @@ static void dcn20_power_on_plane_resources(
 		if (hws->funcs.hubp_pg_control)
 			hws->funcs.hubp_pg_control(hws, pipe_ctx->plane_res.hubp->inst, true);
 
-		REG_SET(DC_IP_REQUEST_CNTL, 0,
-				IP_REQUEST_EN, 0);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0,
+					IP_REQUEST_EN, 0);
+
 		DC_LOG_DEBUG(
 				"Un-gated front end for pipe %d\n", pipe_ctx->plane_res.hubp->inst);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f21e2f7449517..50e710b4ce651 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2655,3 +2655,37 @@ void dcn401_detect_pipe_changes(struct dc_state *old_state,
 		new_pipe->update_flags.bits.test_pattern_changed = 1;
 	}
 }
+
+void dcn401_plane_atomic_power_down(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	uint32_t org_ip_request_cntl = 0;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0,
+			IP_REQUEST_EN, 1);
+
+	if (hws->funcs.dpp_pg_control)
+		hws->funcs.dpp_pg_control(hws, dpp->inst, false);
+
+	if (hws->funcs.hubp_pg_control)
+		hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+
+	hubp->funcs->hubp_reset(hubp);
+	dpp->funcs->dpp_reset(dpp);
+
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0,
+			IP_REQUEST_EN, 0);
+
+	DC_LOG_DEBUG(
+			"Power gated front end %d\n", hubp->inst);
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 17cea748789e1..dbd69d215b8bc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -102,4 +102,7 @@ void dcn401_detect_pipe_changes(
 	struct dc_state *new_state,
 	struct pipe_ctx *old_pipe,
 	struct pipe_ctx *new_pipe);
+void dcn401_plane_atomic_power_down(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 44cb376f97c17..a4e3501fadbbe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -123,7 +123,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.disable_vga = dcn20_disable_vga,
 	.bios_golden_init = dcn10_bios_golden_init,
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
-	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
+	.plane_atomic_power_down = dcn401_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn32_enable_power_gating_plane,
 	.hubp_pg_control = dcn32_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
-- 
2.39.5


