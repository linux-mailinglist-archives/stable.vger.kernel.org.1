Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5407036B4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbjEORNA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbjEORMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F58A65
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E6EE62AE6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79968C433EF;
        Mon, 15 May 2023 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170654;
        bh=EjqZqNUYy6g783xyFHrp2UfyEyCikSrIDTsmgoAxXq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekE58Y3NwMBC7yQCkr7lEyA6LD3bT9U0R41yYXYNZH0S8OeLsoI2nqhSHGG/CJp/P
         DbLmbGKlpgLOYVlkoQ2jfQUeqgNZsFjnOCLVl4a4n/lvyHDM5SpvwfBIZZwsZw0c00
         FbcDp3CXzASifmWC+b1zzRC1owqyhEEX5/i3TdtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Broadworth <mark.broadworth@amd.com>,
        Robin Chen <robin.chen@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Ian Chen <ian.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/239] drm/amd/display: Refactor eDP PSR codes
Date:   Mon, 15 May 2023 18:27:42 +0200
Message-Id: <20230515161727.702931081@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ian Chen <ian.chen@amd.com>

[ Upstream commit bd829d5707730072fecc3267016a675a4789905b ]

We split out PSR config from "global" to "per-panel" config settings.

Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: d893f39320e1 ("drm/amd/display: Lowering min Z8 residency time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h               |  1 -
 drivers/gpu/drm/amd/display/dc/dc_link.h          | 14 +++++++++++---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |  5 ++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 15 +++++++++++++--
 .../drm/amd/display/dc/dcn302/dcn302_resource.c   | 14 +++++++++++++-
 .../drm/amd/display/dc/dcn303/dcn303_resource.c   | 13 ++++++++++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c |  4 ++++
 .../drm/amd/display/dc/dcn314/dcn314_resource.c   |  4 ++++
 .../drm/amd/display/dc/dcn315/dcn315_resource.c   |  4 ++++
 .../drm/amd/display/dc/dcn316/dcn316_resource.c   |  4 ++++
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 +-
 11 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0598465fd1a1b..8757d7ff8ff62 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -764,7 +764,6 @@ struct dc_debug_options {
 	bool disable_mem_low_power;
 	bool pstate_enabled;
 	bool disable_dmcu;
-	bool disable_psr;
 	bool force_abm_enable;
 	bool disable_stereo_support;
 	bool vsr_support;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index caf0c7af2d0b9..17f080f8af6cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -117,7 +117,7 @@ struct psr_settings {
  * Add a struct dc_panel_config under dc_link
  */
 struct dc_panel_config {
-	// extra panel power sequence parameters
+	/* extra panel power sequence parameters */
 	struct pps {
 		unsigned int extra_t3_ms;
 		unsigned int extra_t7_ms;
@@ -127,13 +127,21 @@ struct dc_panel_config {
 		unsigned int extra_t12_ms;
 		unsigned int extra_post_OUI_ms;
 	} pps;
-	// ABM
+	/* PSR */
+	struct psr {
+		bool disable_psr;
+		bool disallow_psrsu;
+		bool rc_disable;
+		bool rc_allow_static_screen;
+		bool rc_allow_fullscreen_VPB;
+	} psr;
+	/* ABM */
 	struct varib {
 		unsigned int varibright_feature_enable;
 		unsigned int def_varibright_level;
 		unsigned int abm_config_setting;
 	} varib;
-	// edp DSC
+	/* edp DSC */
 	struct dsc {
 		bool disable_dsc_edp;
 		unsigned int force_dsc_edp_policy;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 887081472c0d8..ce6c70e25703d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -671,12 +671,15 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_wm_range = true,
 		.disable_stutter = true,
 		.disable_48mhz_pwrdwn = true,
-		.disable_psr = true,
 		.enable_tri_buf = true,
 		.use_max_lb = true
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
 		.ilr = {
 			.optimize_edp_link_rate = true,
 		},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e958f838c8041..5a8d1a0513149 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -723,7 +723,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-	.disable_psr = false,
 	.use_max_lb = true,
 	.exit_idle_opt_for_cursor_updates = true
 };
@@ -742,11 +741,17 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.scl_reset_length10 = true,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
-	.disable_psr = true,
 	.enable_tri_buf = true,
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
+};
+
 static void dcn30_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -2214,6 +2219,11 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	}
 }
 
+static void dcn30_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static const struct resource_funcs dcn30_res_pool_funcs = {
 	.destroy = dcn30_destroy_resource_pool,
 	.link_enc_create = dcn30_link_encoder_create,
@@ -2233,6 +2243,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn30_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn30_get_panel_config_defaults,
 };
 
 #define CTX ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b925b6ddde5a3..d3945876aceda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -112,10 +112,16 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
-		.disable_psr = true,
 		.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
+};
+
 enum dcn302_clk_src_array_id {
 	DCN302_CLK_SRC_PLL0,
 	DCN302_CLK_SRC_PLL1,
@@ -1132,6 +1138,11 @@ void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	DC_FP_END();
 }
 
+static void dcn302_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct resource_funcs dcn302_res_pool_funcs = {
 		.destroy = dcn302_destroy_resource_pool,
 		.link_enc_create = dcn302_link_encoder_create,
@@ -1151,6 +1162,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 		.update_bw_bounding_box = dcn302_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+		.get_panel_config_defaults = dcn302_get_panel_config_defaults,
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 527d5c9028785..7e7f18bef0986 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -96,7 +96,13 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
-		.disable_psr = true,
+};
+
+static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
 };
 
 enum dcn303_clk_src_array_id {
@@ -1055,6 +1061,10 @@ static void dcn303_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
+static void dcn303_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
 
 void dcn303_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
@@ -1082,6 +1092,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 		.update_bw_bounding_box = dcn303_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+		.get_panel_config_defaults = dcn303_get_panel_config_defaults,
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index d825f11b4feaa..d3f76512841b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -911,6 +911,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index ffaa4e5b3fca0..94a90c8f3abbe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -940,6 +940,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 58746c437554f..31cbc5762eab3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -907,6 +907,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 6b40a11ac83a9..af3eddc0cf32e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -906,6 +906,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 45db40c41882c..602e885ed52c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -989,7 +989,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 
 		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !dc->debug.disable_psr)
+		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
-- 
2.39.2



