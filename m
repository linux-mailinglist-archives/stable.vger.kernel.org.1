Return-Path: <stable+bounces-11890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D228316CF
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DDE287B38
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B223741;
	Thu, 18 Jan 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUWeAj9c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5D22F10;
	Thu, 18 Jan 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575021; cv=none; b=ZIdBum+9gJqakym67BIIFmXmlO4jNxHXij5rc4e7QZ/zf/yGuSkZl1ewf3Gy42hC0SgbAVAx6FJoVkd3LnZEVr8u8I3EWHvgq/PIRURjUA3hLECdZTQUXu0/BjLHrhHa6pxQA1S5D6IrdbU+3Bp8dx4H0/RnfWxRj1KSbaY6+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575021; c=relaxed/simple;
	bh=v7E/O/ug5FOinRGa6mLYpkX+vn5zCK8EcCMGN7Lr+0A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=mNc7Tnm5IDuf9n9lIyxakjwBmr2YnC4jGb5sLOpgHju74TMrDTJGZnnzxIW3mkzMmDcZV3ggyzXHB95E00XSTGqMrkF8S/Vq63UKfLYvrqyWkB48uTI8FmS9peRF2yVHjfAbtlmdO3LbaWmuu6uAEcavnIq0a4j7bTPoosD2l54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUWeAj9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE7EC433C7;
	Thu, 18 Jan 2024 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575020;
	bh=v7E/O/ug5FOinRGa6mLYpkX+vn5zCK8EcCMGN7Lr+0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUWeAj9coNGcd3j5i4GTTs8a+8Ijh9+LiRFzC7xFE3XCXGBc12+9YtCrGwJMLLJvE
	 CPXx5gaAWjOFoLamyZshodaayNfjm4LJ911M7XKwfRq3xASuA1n/uPm9lI8YAd1RK6
	 9G/1hY7skshK3rEJT+nDJL1RPPWvIGszwZ1xCIrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Phil Hsieh <phil.hsieh@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Lewis Huang <lewis.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.7 12/28] drm/amd/display: Pass pwrseq inst for backlight and ABM
Date: Thu, 18 Jan 2024 11:49:02 +0100
Message-ID: <20240118104301.660585979@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
References: <20240118104301.249503558@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lewis Huang <lewis.huang@amd.com>

commit b17ef04bf3a4346d66404454d6a646343ddc9749 upstream.

[Why]
OTG inst and pwrseq inst mapping is not align therefore we cannot use
otg_inst as pwrseq inst to get DCIO register.

[How]
1. Pass the correct pwrseq instance to dmub when set abm pipe.
2. LVTMA control index change from panel_inst to pwrseq_inst.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Phil Hsieh <phil.hsieh@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        |    4 
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c      |   12 +-
 drivers/gpu/drm/amd/display/dc/bios/command_table2.h      |    2 
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h            |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c             |    8 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c         |    7 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h         |    2 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c   |    5 -
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |   16 +--
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   36 ++++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h               |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h        |    2 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c        |   59 +++++++++-----
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h           |   14 ++-
 14 files changed, 119 insertions(+), 53 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1698,7 +1698,7 @@ static enum bp_result bios_parser_enable
 static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
@@ -1706,7 +1706,7 @@ static enum bp_result bios_parser_enable
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_panel_control_wait);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, pwrseq_instance, bypass_panel_control_wait);
 }
 
 static bool bios_parser_is_accelerated_mode(
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -976,7 +976,7 @@ static unsigned int get_smu_clock_info_v
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
@@ -989,7 +989,7 @@ static void init_enable_lvtma_control(st
 static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 
@@ -1002,8 +1002,8 @@ static void enable_lvtma_control_dmcub(
 			DMUB_CMD__VBIOS_LVTMA_CONTROL;
 	cmd.lvtma_control.data.uc_pwr_action =
 			uc_pwr_on;
-	cmd.lvtma_control.data.panel_inst =
-			panel_instance;
+	cmd.lvtma_control.data.pwrseq_inst =
+			pwrseq_instance;
 	cmd.lvtma_control.data.bypass_panel_control_wait =
 			bypass_panel_control_wait;
 	dm_execute_dmub_cmd(dmcub->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
@@ -1012,7 +1012,7 @@ static void enable_lvtma_control_dmcub(
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
@@ -1021,7 +1021,7 @@ static enum bp_result enable_lvtma_contr
 	    bp->base.ctx->dc->debug.dmub_command_table) {
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
 				uc_pwr_on,
-				panel_instance,
+				pwrseq_instance,
 				bypass_panel_control_wait);
 		return BP_RESULT_OK;
 	}
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -96,7 +96,7 @@ struct cmd_tbl {
 			struct bios_parser *bp, uint8_t id);
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
 			uint8_t uc_pwr_on,
-			uint8_t panel_instance,
+			uint8_t pwrseq_instance,
 			uint8_t bypass_panel_control_wait);
 };
 
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -140,7 +140,7 @@ struct dc_vbios_funcs {
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on,
-		uint8_t panel_instance,
+		uint8_t pwrseq_instance,
 		uint8_t bypass_panel_control_wait);
 
 	enum bp_result (*get_soc_bb_info)(
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -145,7 +145,11 @@ static bool dmub_abm_save_restore_ex(
 	return ret;
 }
 
-static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe_ex(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	bool ret = false;
 	unsigned int feature_support;
@@ -153,7 +157,7 @@ static bool dmub_abm_set_pipe_ex(struct
 	feature_support = abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
-		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst);
+		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
 
 	return ret;
 }
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -254,7 +254,11 @@ bool dmub_abm_save_restore(
 	return true;
 }
 
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+bool dmub_abm_set_pipe(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -264,6 +268,7 @@ bool dmub_abm_set_pipe(struct abm *abm,
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -44,7 +44,7 @@ bool dmub_abm_save_restore(
 		struct dc_context *dc,
 		unsigned int panel_inst,
 		struct abm_save_restore *pData);
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 bool dmub_abm_set_backlight_level(struct abm *abm,
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -50,7 +50,7 @@ static bool dcn31_query_backlight_info(s
 	cmd->panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd->panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO;
 	cmd->panel_cntl.header.payload_bytes = sizeof(cmd->panel_cntl.data);
-	cmd->panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd->panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 
 	return dm_execute_dmub_cmd(dc_dmub_srv->ctx, cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 }
@@ -78,7 +78,7 @@ static uint32_t dcn31_panel_cntl_hw_init
 	cmd.panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd.panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_HW_INIT;
 	cmd.panel_cntl.header.payload_bytes = sizeof(cmd.panel_cntl.data);
-	cmd.panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd.panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 	cmd.panel_cntl.data.bl_pwm_cntl = panel_cntl->stored_backlight_registers.BL_PWM_CNTL;
 	cmd.panel_cntl.data.bl_pwm_period_cntl = panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL;
 	cmd.panel_cntl.data.bl_pwm_ref_div1 =
@@ -157,4 +157,5 @@ void dcn31_panel_cntl_construct(
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
+	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
 }
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -790,7 +790,7 @@ void dce110_edp_power_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result bp_result;
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
@@ -873,7 +873,7 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
-		panel_instance = link->panel_cntl->inst;
+		pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
@@ -881,11 +881,11 @@ void dce110_edp_power_control(
 			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON) {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_ON,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			} else {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_OFF,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			}
 		}
 
@@ -956,7 +956,7 @@ void dce110_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
 	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
 
@@ -1009,7 +1009,7 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	panel_instance = link->panel_cntl->inst;
+	pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -1034,11 +1034,11 @@ void dce110_edp_backlight_control(
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLON,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -137,7 +137,8 @@ void dcn21_PLAT_58856_wa(struct dc_state
 	pipe_ctx->stream->dpms_off = true;
 }
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
+		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -147,6 +148,7 @@ static bool dmub_abm_set_pipe(struct abm
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
@@ -179,7 +181,6 @@ void dcn21_set_abm_immediate_disable(str
 	struct abm *abm = pipe_ctx->stream_res.abm;
 	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
-
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 
 	if (dmcu) {
@@ -190,9 +191,13 @@ void dcn21_set_abm_immediate_disable(str
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
 			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-			panel_cntl->inst);
+					panel_cntl->inst, panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE, panel_cntl->inst);
+				dmub_abm_set_pipe(abm,
+						otg_inst,
+						SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
@@ -212,9 +217,16 @@ void dcn21_set_pipe(struct pipe_ctx *pip
 
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				dmub_abm_set_pipe(abm, otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 	}
 }
@@ -237,9 +249,17 @@ bool dcn21_set_backlight_level(struct pi
 
 		if (abm && panel_cntl) {
 			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				abm->funcs->set_pipe_ex(abm,
+						otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 			} else {
-				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+					dmub_abm_set_pipe(abm,
+							otg_inst,
+							SET_ABM_PIPE_NORMAL,
+							panel_cntl->inst,
+							panel_cntl->pwrseq_inst);
 			}
 		}
 	}
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -64,7 +64,8 @@ struct abm_funcs {
 	bool (*set_pipe_ex)(struct abm *abm,
 			unsigned int otg_inst,
 			unsigned int option,
-			unsigned int panel_inst);
+			unsigned int panel_inst,
+			unsigned int pwrseq_inst);
 };
 
 #endif
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -56,12 +56,14 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 };
 
 struct panel_cntl {
 	const struct panel_cntl_funcs *funcs;
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 	/* registers setting needs to be saved and restored at InitBacklight */
 	struct panel_cntl_backlight_registers stored_backlight_registers;
 };
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -368,6 +368,30 @@ static enum transmitter translate_encode
 	}
 }
 
+static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
+{
+	uint8_t pwrseq_inst = 0xF;
+	struct dc_context *dc_ctx = link->dc->ctx;
+
+	DC_LOGGER_INIT(dc_ctx->logger);
+
+	switch (link->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	return pwrseq_inst;
+}
+
+
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -595,24 +619,6 @@ static bool construct_phy(struct dc_link
 	link->ddc_hw_inst =
 		dal_ddc_get_line(get_ddc_pin(link->ddc));
 
-
-	if (link->dc->res_pool->funcs->panel_cntl_create &&
-		(link->link_id.id == CONNECTOR_ID_EDP ||
-			link->link_id.id == CONNECTOR_ID_LVDS)) {
-		panel_cntl_init_data.ctx = dc_ctx;
-		panel_cntl_init_data.inst =
-			panel_cntl_init_data.ctx->dc_edp_id_count;
-		link->panel_cntl =
-			link->dc->res_pool->funcs->panel_cntl_create(
-								&panel_cntl_init_data);
-		panel_cntl_init_data.ctx->dc_edp_id_count++;
-
-		if (link->panel_cntl == NULL) {
-			DC_ERROR("Failed to create link panel_cntl!\n");
-			goto panel_cntl_create_fail;
-		}
-	}
-
 	enc_init_data.ctx = dc_ctx;
 	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
 			      &enc_init_data.encoder);
@@ -643,6 +649,23 @@ static bool construct_phy(struct dc_link
 	link->dc->res_pool->dig_link_enc_count++;
 
 	link->link_enc_hw_inst = link->link_enc->transmitter;
+
+	if (link->dc->res_pool->funcs->panel_cntl_create &&
+		(link->link_id.id == CONNECTOR_ID_EDP ||
+			link->link_id.id == CONNECTOR_ID_LVDS)) {
+		panel_cntl_init_data.ctx = dc_ctx;
+		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
+		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		link->panel_cntl =
+			link->dc->res_pool->funcs->panel_cntl_create(
+								&panel_cntl_init_data);
+		panel_cntl_init_data.ctx->dc_edp_id_count++;
+
+		if (link->panel_cntl == NULL) {
+			DC_ERROR("Failed to create link panel_cntl!\n");
+			goto panel_cntl_create_fail;
+		}
+	}
 	for (i = 0; i < 4; i++) {
 		if (bp_funcs->get_device_tag(dc_ctx->dc_bios,
 					     link->link_id, i,
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3357,6 +3357,16 @@ struct dmub_cmd_abm_set_pipe_data {
 	 * TODO: Remove.
 	 */
 	uint8_t ramping_boundary;
+
+	/**
+	 * PwrSeq HW Instance.
+	 */
+	uint8_t pwrseq_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
 };
 
 /**
@@ -3737,7 +3747,7 @@ enum dmub_cmd_panel_cntl_type {
  * struct dmub_cmd_panel_cntl_data - Panel control data.
  */
 struct dmub_cmd_panel_cntl_data {
-	uint32_t inst; /**< panel instance */
+	uint32_t pwrseq_inst; /**< pwrseq instance */
 	uint32_t current_backlight; /* in/out */
 	uint32_t bl_pwm_cntl; /* in/out */
 	uint32_t bl_pwm_period_cntl; /* in/out */
@@ -3796,7 +3806,7 @@ struct dmub_cmd_lvtma_control_data {
 	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
 	uint8_t bypass_panel_control_wait;
 	uint8_t reserved_0[2]; /**< For future use */
-	uint8_t panel_inst; /**< LVTMA control instance */
+	uint8_t pwrseq_inst; /**< LVTMA control instance */
 	uint8_t reserved_1[3]; /**< For future use */
 };
 



