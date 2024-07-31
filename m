Return-Path: <stable+bounces-64826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F3943A50
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC701F2263F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A712413DBA4;
	Thu,  1 Aug 2024 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvwL7OfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC51311B4;
	Thu,  1 Aug 2024 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470921; cv=none; b=SwS6B6NtslHYiGeDuWy5F0QxIRRjVHrnhXkrruLQ37w52r0JIMM0KTyHQa4E+dhSDgh5nMmisaEm0C3XuPPOPBqcEEwf4lXYAIZ8zlaGKAi622+yQouYs/FpiK0h75hNLa5eEEwlqRjOX6BnTcfm0YO++1rLD3aMD75hrJLPJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470921; c=relaxed/simple;
	bh=ZOUiqqXObYwpddZ+RyouO3nNxC7OSPz4mP1hfi1BETc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YM2i1zmNRzXX4c7fLoE+xgqjzb5hIyD6w2GnWWBtjj7I/mDEjuDbgmZwpyT/iTt3GSi+QDWHZ2z9AfM5tQWBO1H/h4ph7b1MwWa5hau5QhICb3xmwvRq08mAjLqIHcA7j2a943Zr4edIhAOU9fICuy4yQ5A1ikCzAMF+8FmkFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvwL7OfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9ADC32786;
	Thu,  1 Aug 2024 00:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470920;
	bh=ZOUiqqXObYwpddZ+RyouO3nNxC7OSPz4mP1hfi1BETc=;
	h=From:To:Cc:Subject:Date:From;
	b=BvwL7OfVfUAQVIoUJQRBAYx7XYlmeSqHn3knZPh8YnaZjV8cN2dUfngppPei7rJBr
	 qkvYQ/NFtNoBYpkozuDAlxmVrBFQgAR5dkYkGe8qROUh0yELjKxUuLrc9g8TzGBVKI
	 3ggl4tqn54a3r0iEN87R7Hy6cNhhaQ+bNzvsNNUrDkwLMqE0SYGrmkv53S1klQgE+6
	 GCZDFMpeCaLGv6/R35xySz1gFk0qQmiGbNSDoETNtY1OMDbveaDrg4cmnkFEFJDgBY
	 Lcl9jhb9mlID0sNTQAnis9agonqiptQQFJ7DoyIqi6qn0YmAlbjnsybf2AyeecbkE6
	 fSD9KhOnewUFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Miess <daniel.miess@amd.com>,
	Roman Li <roman.li@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
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
	aric.cyr@amd.com,
	hamza.mahfooz@amd.com,
	nicholas.kazlauskas@amd.com,
	alvin.lee2@amd.com,
	Qingqing.Zhuo@amd.com,
	aurabindo.pillai@amd.com,
	chiahsuan.chung@amd.com,
	dillon.varone@amd.com,
	yi-lchen@amd.com,
	ahmed.ahmed@amd.com,
	syed.hassan@amd.com,
	harikrishna.revalla@amd.com,
	alex.hung@amd.com,
	sungjoon.kim@amd.com,
	michael.strauss@amd.com,
	allen.pan@amd.com,
	duncan.ma@amd.com,
	danny.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 001/121] drm/amd/display: Enable RCO for PHYSYMCLK in DCN35
Date: Wed, 31 Jul 2024 19:58:59 -0400
Message-ID: <20240801000834.3930818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit f2303026a5b6327247ba61152d00199b2d1be294 ]

[Why & How]
Enable root clock optimization for PHYSYMCLK and only
disable it when it's actively being used

v2:  Fix array-index-out-of-bounds in dcn35_calc_blocks_to_gate

Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 45 -------------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 32 +++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  4 ++
 7 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3c33c3bcbe2cb..fe0025f2167fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -701,6 +701,7 @@ enum pg_hw_pipe_resources {
 	PG_OPTC,
 	PG_DPSTREAM,
 	PG_HDMISTREAM,
+	PG_PHYSYMCLK,
 	PG_HW_PIPE_RESOURCES_NUM_ELEMENT
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 58dd3c5bbff09..024dcf3057a05 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -451,32 +451,22 @@ static void dccg35_set_physymclk_root_clock_gating(
 	case 0:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYASYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYA_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 1:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYBSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYB_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 2:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYCSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYC_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 3:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYDSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYD_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 4:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYESYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYE_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -499,16 +489,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_EN, 1,
 					PHYASYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYA_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_EN, 0,
 					PHYASYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYA_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 1:
@@ -516,16 +500,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_EN, 1,
 					PHYBSYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYB_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_EN, 0,
 					PHYBSYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYB_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 2:
@@ -533,16 +511,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_EN, 1,
 					PHYCSYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYC_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_EN, 0,
 					PHYCSYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYC_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 3:
@@ -550,16 +522,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_EN, 1,
 					PHYDSYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYD_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_EN, 0,
 					PHYDSYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYD_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 4:
@@ -567,16 +533,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_EN, 1,
 					PHYESYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYE_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_EN, 0,
 					PHYESYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYE_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	default:
@@ -714,11 +674,6 @@ void dccg35_init(struct dccg *dccg)
 			dccg35_set_dpstreamclk_root_clock_gating(dccg, otg_inst, false);
 		}
 
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-		for (otg_inst = 0; otg_inst < 5; otg_inst++)
-			dccg35_set_physymclk_root_clock_gating(dccg, otg_inst,
-					false);
-
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
 		for (otg_inst = 0; otg_inst < 4; otg_inst++)
 			dccg35_set_dppclk_root_clock_gating(dccg, otg_inst, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index dcced89c07b38..5f60da72c6f58 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -506,6 +506,17 @@ void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hp
 	}
 }
 
+void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->set_physymclk_root_clock_gating) {
+		hws->ctx->dc->res_pool->dccg->funcs->set_physymclk_root_clock_gating(
+			hws->ctx->dc->res_pool->dccg, phy_inst, clock_on);
+	}
+}
+
 void dcn35_dsc_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst,
@@ -1041,6 +1052,13 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->stream_res.hpo_dp_stream_enc)
 			update_state->pg_pipe_res_update[PG_DPSTREAM][pipe_ctx->stream_res.hpo_dp_stream_enc->inst] = false;
 	}
+
+	for (i = 0; i < dc->link_count; i++) {
+		update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
+		if (dc->links[i]->type != dc_connection_none)
+			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = false;
+	}
+
 	/*domain24 controls all the otg, mpc, opp, as long as one otg is still up, avoid enabling OTG PG*/
 	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 		struct timing_generator *tg = dc->res_pool->timing_generators[i];
@@ -1138,6 +1156,10 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		}
 	}
 
+	for (i = 0; i < dc->link_count; i++)
+		if (dc->links[i]->type != dc_connection_none)
+			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
+
 	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
 		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
 				dc->res_pool->hpo_dp_stream_enc[i]) {
@@ -1288,6 +1310,11 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
 
+		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++)
+			if (update_state->pg_pipe_res_update[PG_PHYSYMCLK][i])
+				if (dc->hwseq->funcs.physymclk_root_clock_control)
+					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
+
 	}
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
@@ -1313,6 +1340,11 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
 
+		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++)
+			if (update_state->pg_pipe_res_update[PG_PHYSYMCLK][i])
+				if (dc->hwseq->funcs.physymclk_root_clock_control)
+					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
+
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index f0ea7d1511ae6..e27b3609020ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -39,6 +39,8 @@ void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hpo_inst, bool clock_on);
 
+void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on);
+
 void dcn35_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 void dcn35_set_dmu_fgcg(struct dce_hwseq *hws, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 199781233fd5f..987e09d9246e4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -148,6 +148,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index a53092cd619b1..2e0d23ae8fee5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -147,6 +147,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 341219cf41442..9553a7d34c3e9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -124,6 +124,10 @@ struct hwseq_private_funcs {
 			struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool clock_on);
+	void (*physymclk_root_clock_control)(
+			struct dce_hwseq *hws,
+			unsigned int phy_inst,
+			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool power_on);
-- 
2.43.0


