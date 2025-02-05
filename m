Return-Path: <stable+bounces-113839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B7A2949E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8221885BA1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759EA15FA7B;
	Wed,  5 Feb 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUyS/riv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4A18FDDB;
	Wed,  5 Feb 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768339; cv=none; b=jRZpy0umkNaIfD77AInl88IX2gG1ppx0UK+t6UJ0d90YzUeGIlG/UStOcDGJIiTsTbVjiN0rxH/uRcz+LMOzR2G7EXdNL5fZgpKLgt4CUhjixdXVNAIBsO9UbVs32Yx1yheLSPpJ5k1PohN4axYHQgXlOt5duiQBqkC3Pg5Qa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768339; c=relaxed/simple;
	bh=7jCoKuJn9cwv6FlwktYgOBuVarzfFgBI3uSvTfrl7gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsUG9EVhdLzytFrXU0nvyw0ISWf9J8U8yKgM+EE+bDtKQ7RQ9MdiyHuedcY9+PUhC6UVQRfmCgV/kni9rkrVF2Z3Bv/04H2mNiuPYMVcMi7A5g+Hqbw2cjNMLPWcg4/d6Qg2bsFz79cJop4E3PLNlNc5yMb0nRmbygVG4r/VeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUyS/riv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6A7C4CED1;
	Wed,  5 Feb 2025 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768339;
	bh=7jCoKuJn9cwv6FlwktYgOBuVarzfFgBI3uSvTfrl7gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUyS/rivKubdyK8PcdV9q2CqCPGTE2F2i73Txv1Oimr2rRWBoKoa4XYEhy7bx5Reh
	 F6cDL8jm5v6HavtBOxKjNnB4C2tq2bIPQOeO2kwYVGOXv7tg99uQu+8SXqmoov5Ohj
	 yQuVRLepSnZIks/m2RvtUmTRHwWlUnPOR5gDCNEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sung Lee <sung.lee@amd.com>,
	Aric Cyr <Aric.Cyr@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.12 586/590] drm/amd/display: Add hubp cache reset when powergating
Date: Wed,  5 Feb 2025 14:45:41 +0100
Message-ID: <20250205134517.680900581@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aric Cyr <Aric.Cyr@amd.com>

commit 01130f5260e5868fb6b15ab8c00dbc894139f48e upstream.

[Why]
When HUBP is power gated, the SW state can get out of sync with the
hardware state causing cursor to not be programmed correctly.

[How]
Similar to DPP, add a HUBP reset function which is called wherever
HUBP is initialized or powergated.  This function will clear the cursor
position and attribute cache allowing for proper programming when the
HUBP is brought back up.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sung Lee <sung.lee@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c     |    3 +++
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c   |   10 +++++++++-
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h   |    2 ++
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c   |    1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c |    1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c   |    3 +++
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c   |    3 +++
 drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c   |    1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c   |    1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c   |    1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c |    3 ++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |    2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c  |    2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h             |    2 ++
 14 files changed, 33 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -194,6 +194,9 @@ void dpp_reset(struct dpp *dpp_base)
 	dpp->filter_h = NULL;
 	dpp->filter_v = NULL;
 
+	memset(&dpp_base->pos, 0, sizeof(dpp_base->pos));
+	memset(&dpp_base->att, 0, sizeof(dpp_base->att));
+
 	memset(&dpp->scl_data, 0, sizeof(dpp->scl_data));
 	memset(&dpp->pwl_data, 0, sizeof(dpp->pwl_data));
 }
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -532,6 +532,12 @@ void hubp1_dcc_control(struct hubp *hubp
 			SECONDARY_SURFACE_DCC_IND_64B_BLK, dcc_ind_64b_blk);
 }
 
+void hubp_reset(struct hubp *hubp)
+{
+	memset(&hubp->pos, 0, sizeof(hubp->pos));
+	memset(&hubp->att, 0, sizeof(hubp->att));
+}
+
 void hubp1_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
@@ -1337,8 +1343,9 @@ static void hubp1_wait_pipe_read_start(s
 
 void hubp1_init(struct hubp *hubp)
 {
-	//do nothing
+	hubp_reset(hubp);
 }
+
 static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_program_surface_flip_and_addr =
 			hubp1_program_surface_flip_and_addr,
@@ -1351,6 +1358,7 @@ static const struct hubp_funcs dcn10_hub
 	.hubp_set_vm_context0_settings = hubp1_set_vm_context0_settings,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_hubp_blank_en = hubp1_set_hubp_blank_en,
 	.set_cursor_attributes	= hubp1_cursor_set_attributes,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -746,6 +746,8 @@ void hubp1_dcc_control(struct hubp *hubp
 		bool enable,
 		enum hubp_ind_block_size independent_64b_blks);
 
+void hubp_reset(struct hubp *hubp);
+
 bool hubp1_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -1660,6 +1660,7 @@ static struct hubp_funcs dcn20_hubp_func
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp2_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
@@ -121,6 +121,7 @@ static struct hubp_funcs dcn201_hubp_fun
 	.set_cursor_position	= hubp1_cursor_set_position,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.hubp_clk_cntl = hubp1_clk_cntl,
 	.hubp_vtg_sel = hubp1_vtg_sel,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -811,6 +811,8 @@ static void hubp21_init(struct hubp *hub
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
+
+	hubp_reset(hubp);
 }
 static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
@@ -823,6 +825,7 @@ static struct hubp_funcs dcn21_hubp_func
 	.hubp_set_vm_system_aperture_settings = hubp21_set_vm_system_aperture_settings,
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = hubp21_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp1_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -483,6 +483,8 @@ void hubp3_init(struct hubp *hubp)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
+
+	hubp_reset(hubp);
 }
 
 static struct hubp_funcs dcn30_hubp_funcs = {
@@ -497,6 +499,7 @@ static struct hubp_funcs dcn30_hubp_func
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -79,6 +79,7 @@ static struct hubp_funcs dcn31_hubp_func
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -181,6 +181,7 @@ static struct hubp_funcs dcn32_hubp_func
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -199,6 +199,7 @@ static struct hubp_funcs dcn35_hubp_func
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.dcc_control = hubp3_dcc_control,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp2_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -141,7 +141,7 @@ void hubp401_update_mall_sel(struct hubp
 
 void hubp401_init(struct hubp *hubp)
 {
-	//For now nothing to do, HUBPREQ_DEBUG_DB register is removed on DCN4x.
+	hubp_reset(hubp);
 }
 
 void hubp401_vready_at_or_After_vsync(struct hubp *hubp,
@@ -974,6 +974,7 @@ static struct hubp_funcs dcn401_hubp_fun
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
 	.set_blank_regs = hubp2_set_blank_regs,
+	.hubp_reset = hubp_reset,
 	.mem_program_viewport = hubp401_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
 	.set_cursor_position	= hubp401_cursor_set_position,
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1286,6 +1286,7 @@ void dcn10_plane_atomic_power_down(struc
 		if (hws->funcs.hubp_pg_control)
 			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
@@ -1447,6 +1448,7 @@ void dcn10_init_pipes(struct dc *dc, str
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -787,6 +787,7 @@ void dcn35_init_pipes(struct dc *dc, str
 		/* Disable on the current state so the new one isn't cleared. */
 		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		hubp->funcs->hubp_reset(hubp);
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
@@ -940,6 +941,7 @@ void dcn35_plane_atomic_disable(struct d
 /*to do, need to support both case*/
 	hubp->power_gated = true;
 
+	hubp->funcs->hubp_reset(hubp);
 	dpp->funcs->dpp_reset(dpp);
 
 	pipe_ctx->stream = NULL;
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -152,6 +152,8 @@ struct hubp_funcs {
 	void (*dcc_control)(struct hubp *hubp, bool enable,
 			enum hubp_ind_block_size blk_size);
 
+	void (*hubp_reset)(struct hubp *hubp);
+
 	void (*mem_program_viewport)(
 			struct hubp *hubp,
 			const struct rect *viewport,



