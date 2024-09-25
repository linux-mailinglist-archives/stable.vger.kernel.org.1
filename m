Return-Path: <stable+bounces-77253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6719F985B0F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825221F20F40
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030F1917EE;
	Wed, 25 Sep 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrwLrgBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D51802AB;
	Wed, 25 Sep 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264818; cv=none; b=qliIhwp9JhS3+NhZybpCvrtPKkUzvW8stcWn410EyIv5RcLzBEfqwL8Zou+qvt8SngOs993I1tpBPbxSMusPag4894SC4exe1+shzGETalM85v1FRKmSS57ObxBbNz3mCc7jiLsk6xPzQ+B/Lwvuhohz7A9Kt78sx4MMf0mOilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264818; c=relaxed/simple;
	bh=oADzbTNubmfYGVYvml+OEhcVsx+Maav3B5kySYaz4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H16oA5eFDfJR16j5pLM8YxSHMJsyTyxt7AMd1lfCcQdqB2vzGj25d2QiHVF6F9LFcZE3yRJRtvZYLJjv0Z0zWiKWDBv86BM8gk51CtsDD5rvEJMFfAM+vU3WoEtHDE7oRwhMFiSAnf3WjTNkVXQ6PHGCm+kbb0U0rxO+r3MWwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrwLrgBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925D3C4CEC3;
	Wed, 25 Sep 2024 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264818;
	bh=oADzbTNubmfYGVYvml+OEhcVsx+Maav3B5kySYaz4mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrwLrgBHMW7B0CZ0fnhVBYHGUKZI3XMkpXMf+q6ZdX7V0/mYmB/hstia+2ohzNxVn
	 lWmMNPi/jBc3VhjZPr0I2X+Hc1eKhNJeCUP96RtBiV2w8XOFVyHIMKtMzDSE2mg9PO
	 yktInU69nxmARW1KPm08xOc6JlC8gFRDfPWA2O4MDrty0wxoOKijXKeagIRqysCWcG
	 nbSxx0Tt1DRk7ni7dw2lDLGuFeQQRiL7lj8Yszqm6/gUhYvnA/KhHGZc8OW9A4Ho9s
	 Mak3SIvXPT2dAoSN3RwtiyEKHns/yPJ0d1yXhGlNFATXhOFZrVYm+z1Im+oxGXOhsh
	 x54wo0gYA+PTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	zaeem.mohamed@amd.com,
	colin.i.king@gmail.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 155/244] drm/amd/display: fix a UBSAN warning in DML2.1
Date: Wed, 25 Sep 2024 07:26:16 -0400
Message-ID: <20240925113641.1297102-155-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit eaf3adb8faab611ba57594fa915893fc93a7788c ]

When programming phantom pipe, since cursor_width is explicity set to 0,
this causes calculation logic to trigger overflow for an unsigned int
triggering the kernel's UBSAN check as below:

[   40.962845] UBSAN: shift-out-of-bounds in /tmp/amd.EfpumTkO/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:3312:34
[   40.962849] shift exponent 4294967170 is too large for 32-bit type 'unsigned int'
[   40.962852] CPU: 1 PID: 1670 Comm: gnome-shell Tainted: G        W  OE      6.5.0-41-generic #41~22.04.2-Ubuntu
[   40.962854] Hardware name: Gigabyte Technology Co., Ltd. X670E AORUS PRO X/X670E AORUS PRO X, BIOS F21 01/10/2024
[   40.962856] Call Trace:
[   40.962857]  <TASK>
[   40.962860]  dump_stack_lvl+0x48/0x70
[   40.962870]  dump_stack+0x10/0x20
[   40.962872]  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
[   40.962878]  calculate_cursor_req_attributes.cold+0x1b/0x28 [amdgpu]
[   40.963099]  dml_core_mode_support+0x6b91/0x16bc0 [amdgpu]
[   40.963327]  ? srso_alias_return_thunk+0x5/0x7f
[   40.963331]  ? CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport+0x18b8/0x2790 [amdgpu]
[   40.963534]  ? srso_alias_return_thunk+0x5/0x7f
[   40.963536]  ? dml_core_mode_support+0xb3db/0x16bc0 [amdgpu]
[   40.963730]  dml2_core_calcs_mode_support_ex+0x2c/0x90 [amdgpu]
[   40.963906]  ? srso_alias_return_thunk+0x5/0x7f
[   40.963909]  ? dml2_core_calcs_mode_support_ex+0x2c/0x90 [amdgpu]
[   40.964078]  core_dcn4_mode_support+0x72/0xbf0 [amdgpu]
[   40.964247]  dml2_top_optimization_perform_optimization_phase+0x1d3/0x2a0 [amdgpu]
[   40.964420]  dml2_build_mode_programming+0x23d/0x750 [amdgpu]
[   40.964587]  dml21_validate+0x274/0x770 [amdgpu]
[   40.964761]  ? srso_alias_return_thunk+0x5/0x7f
[   40.964763]  ? resource_append_dpp_pipes_for_plane_composition+0x27c/0x3b0 [amdgpu]
[   40.964942]  dml2_validate+0x504/0x750 [amdgpu]
[   40.965117]  ? dml21_copy+0x95/0xb0 [amdgpu]
[   40.965291]  ? srso_alias_return_thunk+0x5/0x7f
[   40.965295]  dcn401_validate_bandwidth+0x4e/0x70 [amdgpu]
[   40.965491]  update_planes_and_stream_state+0x38d/0x5c0 [amdgpu]
[   40.965672]  update_planes_and_stream_v3+0x52/0x1e0 [amdgpu]
[   40.965845]  ? srso_alias_return_thunk+0x5/0x7f
[   40.965849]  dc_update_planes_and_stream+0x71/0xb0 [amdgpu]

Fix this by adding a guard for checking cursor width before triggering
the size calculation.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 93 ++++++++++---------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 6f4026e396e09..c40cd5d634568 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7231,10 +7231,9 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	/* Cursor Support Check */
 	mode_lib->ms.support.CursorSupport = true;
 	for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-		if (display_cfg->plane_descriptors[k].cursor.cursor_width > 0.0) {
-			if (display_cfg->plane_descriptors[k].cursor.cursor_bpp == 64 && mode_lib->ip.cursor_64bpp_support == false) {
+		if (display_cfg->plane_descriptors[k].cursor.num_cursors > 0) {
+			if (display_cfg->plane_descriptors[k].cursor.cursor_bpp == 64 && mode_lib->ip.cursor_64bpp_support == false)
 				mode_lib->ms.support.CursorSupport = false;
-			}
 		}
 	}
 
@@ -8091,27 +8090,31 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 		double line_time_us = (double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
 		bool cursor_not_enough_urgent_latency_hiding = 0;
-		calculate_cursor_req_attributes(
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			display_cfg->plane_descriptors[k].cursor.cursor_bpp,
 
-			// output
-			&s->cursor_lines_per_chunk[k],
-			&s->cursor_bytes_per_line[k],
-			&s->cursor_bytes_per_chunk[k],
-			&s->cursor_bytes[k]);
-
-		calculate_cursor_urgent_burst_factor(
-			mode_lib->ip.cursor_buffer_size,
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			s->cursor_bytes_per_chunk[k],
-			s->cursor_lines_per_chunk[k],
-			line_time_us,
-			mode_lib->ms.UrgLatency,
+		if (display_cfg->plane_descriptors[k].cursor.num_cursors > 0) {
+			calculate_cursor_req_attributes(
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				display_cfg->plane_descriptors[k].cursor.cursor_bpp,
+
+				// output
+				&s->cursor_lines_per_chunk[k],
+				&s->cursor_bytes_per_line[k],
+				&s->cursor_bytes_per_chunk[k],
+				&s->cursor_bytes[k]);
+
+			calculate_cursor_urgent_burst_factor(
+				mode_lib->ip.cursor_buffer_size,
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				s->cursor_bytes_per_chunk[k],
+				s->cursor_lines_per_chunk[k],
+				line_time_us,
+				mode_lib->ms.UrgLatency,
+
+				// output
+				&mode_lib->ms.UrgentBurstFactorCursor[k],
+				&cursor_not_enough_urgent_latency_hiding);
+		}
 
-			// output
-			&mode_lib->ms.UrgentBurstFactorCursor[k],
-			&cursor_not_enough_urgent_latency_hiding);
 		mode_lib->ms.UrgentBurstFactorCursorPre[k] = mode_lib->ms.UrgentBurstFactorCursor[k];
 
 #ifdef __DML_VBA_DEBUG__
@@ -10592,31 +10595,33 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 
 	for (k = 0; k < s->num_active_planes; ++k) {
 		bool cursor_not_enough_urgent_latency_hiding = 0;
-		double line_time_us;
+		double line_time_us = 0.0;
 
-		calculate_cursor_req_attributes(
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			display_cfg->plane_descriptors[k].cursor.cursor_bpp,
+		line_time_us = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total /
+			((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
+		if (display_cfg->plane_descriptors[k].cursor.num_cursors > 0) {
+			calculate_cursor_req_attributes(
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				display_cfg->plane_descriptors[k].cursor.cursor_bpp,
 
-			// output
-			&s->cursor_lines_per_chunk[k],
-			&s->cursor_bytes_per_line[k],
-			&s->cursor_bytes_per_chunk[k],
-			&s->cursor_bytes[k]);
-
-		line_time_us = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
-
-		calculate_cursor_urgent_burst_factor(
-			mode_lib->ip.cursor_buffer_size,
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			s->cursor_bytes_per_chunk[k],
-			s->cursor_lines_per_chunk[k],
-			line_time_us,
-			mode_lib->mp.UrgentLatency,
+				// output
+				&s->cursor_lines_per_chunk[k],
+				&s->cursor_bytes_per_line[k],
+				&s->cursor_bytes_per_chunk[k],
+				&s->cursor_bytes[k]);
+
+			calculate_cursor_urgent_burst_factor(
+				mode_lib->ip.cursor_buffer_size,
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				s->cursor_bytes_per_chunk[k],
+				s->cursor_lines_per_chunk[k],
+				line_time_us,
+				mode_lib->mp.UrgentLatency,
 
-			// output
-			&mode_lib->mp.UrgentBurstFactorCursor[k],
-			&cursor_not_enough_urgent_latency_hiding);
+				// output
+				&mode_lib->mp.UrgentBurstFactorCursor[k],
+				&cursor_not_enough_urgent_latency_hiding);
+		}
 		mode_lib->mp.UrgentBurstFactorCursorPre[k] = mode_lib->mp.UrgentBurstFactorCursor[k];
 
 		CalculateUrgentBurstFactor(
-- 
2.43.0


