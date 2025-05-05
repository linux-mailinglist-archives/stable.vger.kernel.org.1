Return-Path: <stable+bounces-140000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74089AAA39D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681D73A6842
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4262F54AC;
	Mon,  5 May 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjopS4J7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD12F54A8;
	Mon,  5 May 2025 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483870; cv=none; b=rYoLPIryCEAxxkLcDGzpVEQ25I9Vfun0gJiiA9Ag5uUDcSf4mpQI43lbsCArAu3JPN0Hvy9/h3/yiBnsz9avZrpdB33qtgx1RkZT/+ZU9UUdbccV92PTqwyoxeKu7F1GXrxDBBi0i5c91dYssb0zzo7WsBkbH9+wKyPixd7vCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483870; c=relaxed/simple;
	bh=lwr9bmhpfNroeZ6vXSSRBniyysNpdMbEwskf9zf0GNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exT6nxCRWXtVIY/G0XDak6mnHpZU0N7El5ffbIhCXF2GJZfVHRoyI5ZE1oeP0yJj2JiI75Nl7h9l09WzIuXsLWU1TYWbaTjdAvC+sGvnGAJYLBmjPCx77anwWCL9PQ1RKUbwKEdWCmqfffkV037yCQEv57nq0akEP4GMhxvJ0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjopS4J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2267C4CEE4;
	Mon,  5 May 2025 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483869;
	bh=lwr9bmhpfNroeZ6vXSSRBniyysNpdMbEwskf9zf0GNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjopS4J7d9b+JLQUrKmn6D1W0lIaaIEYC6rd16ll4UGMO1fQdxBOoVS0HanIJF6TG
	 fysVl7M0XBtYLDA7wJWCPAlYC2v+VcU42l6m/o6ZZ1bWdNrSAcJm2ixNtJggKFohY8
	 UtRyAnWmdyhWaYQ5D4PHgfMnF+axldimHb4tv+Aam+U4jb6xOC7T+jdnBE+uRWz0Cz
	 LT6frNeEki/YRcicZ1gjNfZYESro6aVoDe2xF5H7X6t4T/SxKpDLzuD/pZj/bFYYjl
	 /gsRvMxaVFGW/ylbhhnZMqeV7VgQFhb6Pb6w4oMZbCSJ15NvzVV2rf/DrUcsTs6pzj
	 K/iqmEmEIpWIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aric Cyr <Aric.Cyr@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	siqueira@igalia.com,
	alex.hung@amd.com,
	alvin.lee2@amd.com,
	aurabindo.pillai@amd.com,
	Ilya.Bakoulin@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	Josip.Pavic@amd.com,
	dillon.varone@amd.com,
	wenjing.liu@amd.com,
	linux@treblig.org,
	Leo.Zeng@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 253/642] drm/amd/display: Request HW cursor on DCN3.2 with SubVP
Date: Mon,  5 May 2025 18:07:49 -0400
Message-Id: <20250505221419.2672473-253-sashal@kernel.org>
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

From: Aric Cyr <Aric.Cyr@amd.com>

[ Upstream commit b74f46f3ce1e5f6336645f1e9ff47c56d5dfdef1 ]

[why]
When SubVP is active the HW cursor size is limited to 64x64, and
anything larger will force composition which is bad for gaming on
DCN3.2 if the game uses a larger cursor.

[how]
If HW cursor is requested, typically by a fullscreen game, do not
enable SubVP so that up to 256x256 cursor sizes are available for
DCN3.2.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c             | 3 ++-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a444fe1e0838a..5cd13aea1f694 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4907,7 +4907,8 @@ static bool full_update_required(struct dc *dc,
 			stream_update->lut3d_func ||
 			stream_update->pending_test_pattern ||
 			stream_update->crtc_timing_adjust ||
-			stream_update->scaler_sharpener_update))
+			stream_update->scaler_sharpener_update ||
+			stream_update->hw_cursor_req))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6f490d8d7038c..56dda686e2992 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -626,6 +626,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
+				!pipe->stream->hw_cursor_req &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
-- 
2.39.5


