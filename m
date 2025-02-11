Return-Path: <stable+bounces-114775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06BA3006F
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561681887ACF
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B181DCB24;
	Tue, 11 Feb 2025 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Q+0Hcc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8371B6CE9;
	Tue, 11 Feb 2025 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237472; cv=none; b=FiHWq4OZjSZNWm7jrDBWF47C56yJGhNdbdqcgZS1ZDkMkiMKRyJS1S9aaxKFjslduzbZxCBoFlpmwGvZh7Pu72bm6Pyowpl5G/UBrm1eMdW6f/AxIAmHN20uH8SjEal22NeStu9IQusE2v/1fEZjsUCKOkRDGymeoBvOukfTR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237472; c=relaxed/simple;
	bh=CLsNW83ZRcxOLcSWwGPaKe0qusY5Ppqq1ipzZL8q830=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3RbE9bEL5P5gtxw/ecPVLBd4tUY1rJ9ivg3u6u8fTTEFzUXmK0R8Zm4Y6gnBJd3SBHrFLBAe+77z3HFbBl85S7F2tDB3vRuqtnBZ1yjjVKFc+GY3nCye6Kp221C8V012ThfKS9WSrhjObFnQL3DMKtB357E976kYiDKuy6xWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Q+0Hcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9188CC4CEDF;
	Tue, 11 Feb 2025 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237472;
	bh=CLsNW83ZRcxOLcSWwGPaKe0qusY5Ppqq1ipzZL8q830=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0Q+0Hcc89Sg0YXQTJHD8tzWbtVI/IkEljiH1wXbY1oW2cxBpHHXqWR+gj17BjlUo
	 SShf8dyDx6qD5sltTxA2TAXeAEibR2hVvFKXpOi/4sC/jTdcgoGpSJrCMrjcAN50mi
	 TrRkDrXZS3z7vKAcGkKvttuM464E6Kuh506dFJCNjoeFYnUWxene/SJL4qK3azzB9g
	 yCgnlfhXsKpYpPWBdMvKc0e3DBL8dyf0oAh23htMgz1mhtrVZabt2Wdqt6Rer44/L9
	 tzTn9eDbiC3XVjvBFw2UfuJSzUjif2Uu342ZPcmkt5eEOF8mMdvF5+60M70H2cQa/s
	 LEObieE4lZ4yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Austin Zheng <Austin.Zheng@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	dillon.varone@amd.com,
	Alvin.Lee2@amd.com,
	Samson.Tam@amd.com,
	aurabindo.pillai@amd.com,
	rostrows@amd.com,
	joshua.aberback@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 10/19] drm/amd/display: Fix out-of-bound accesses
Date: Mon, 10 Feb 2025 20:30:38 -0500
Message-Id: <20250211013047.4096767-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8adbb2a98b00926315fd513b5fe2596b5716b82d ]

[WHAT & HOW]
hpo_stream_to_link_encoder_mapping has size MAX_HPO_DP2_ENCODERS(=4),
but location can have size up to 6. As a result, it is necessary to
check location against MAX_HPO_DP2_ENCODERS.

Similiarly, disp_cfg_stream_location can be used as an array index which
should be 0..5, so the ASSERT's conditions should be less without equal.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3904
Reviewed-by: Austin Zheng <Austin.Zheng@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 8dee0d397e032..55014c1521167 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -994,7 +994,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		if (disp_cfg_stream_location < 0)
 			disp_cfg_stream_location = dml_dispcfg->num_streams++;
 
-		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index]);
@@ -1018,7 +1018,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_planes++;
 
-				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml21_surface_config_from_plane_state(in_dc, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location].surface, context->stream_status[stream_index].plane_states[plane_index]);
 				populate_dml21_plane_config_from_plane_state(dml_ctx, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location], context->stream_status[stream_index].plane_states[plane_index], context, stream_index);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index bde4250853b10..81ba8809a3b4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -746,7 +746,7 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_DISPLAY_PORT:
 		out->OutputEncoder[location] = dml_dp;
-		if (dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location] != -1)
+		if (location < MAX_HPO_DP2_ENCODERS && dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location] != -1)
 			out->OutputEncoder[dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location]] = dml_dp2p0;
 		break;
 	case SIGNAL_TYPE_EDP:
@@ -1303,7 +1303,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		if (disp_cfg_stream_location < 0)
 			disp_cfg_stream_location = dml_dispcfg->num_timings++;
 
-		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 		populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_stream_location, context->streams[i]);
 		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context, dml2);
@@ -1343,7 +1343,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
 
-				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml_surface_cfg_from_plane_state(dml2->v20.dml_core_ctx.project, &dml_dispcfg->surface, disp_cfg_plane_location, context->stream_status[i].plane_states[j]);
 				populate_dml_plane_cfg_from_plane_state(
-- 
2.39.5


