Return-Path: <stable+bounces-66595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2A94F04B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA8281242
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C818184538;
	Mon, 12 Aug 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B5SwXQK8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1E183CC2
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474096; cv=none; b=Bu0TvC5PlxDZy71A8E4aiW3Dz5tNgZTrZZc966FzAZJLtCaAR7fGKH4VRqticg5YRnCVBYB6CQIKdCeZPHpsH/1aPTs/6ysuap25Xtj2OVQe5liB8iMzl1nnpM0k916hG1FL/iPARN7qglmrn/7so0LHTBWCmSjm5lTrJ2B3jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474096; c=relaxed/simple;
	bh=8LSXfcFzlEHahYTW06WOoyuGA9yI1SF1MfMxcYpe21U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=smZ3jC8lItFnMWEZ885vIMhNQFuMvFtNFuWLqs4+5QzRzJE9zdCdV5LNM5TlhJCLeB0o1DfSw08kfFmcTMyC/NAb9hwHkRL23f9Ajp7TpBWnJa5ySl6UEY/mdMYKv4aCQKypdOia+jTz13k6A1S+ZiDuOmaSdPbwb8TpXaStr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B5SwXQK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC483C32782;
	Mon, 12 Aug 2024 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474096;
	bh=8LSXfcFzlEHahYTW06WOoyuGA9yI1SF1MfMxcYpe21U=;
	h=Subject:To:Cc:From:Date:From;
	b=B5SwXQK8YS0DEEiEey6vBQk0s+JNPzoDP55gANxEErHfFxuyIGsjiug5eUHRvDgGi
	 5KuQNqg+wkfWZyhKwdW8yOdKug6Uk5fPE08hYTo47aTh0qrQvJx+6dfZVno8IyFGpL
	 /TVh6BHGNkn1O2ZyxK14+dGmkOXweKB6+dkZYd7M=
Subject: FAILED: patch "[PATCH] drm/amd/display: Reset DSC memory status" failed to apply to 5.10-stable tree
To: duncan.ma@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:43 +0200
Message-ID: <2024081243-chive-reluctant-d200@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7210195f1bc51ba02cffa45b27ddb5c962faa606
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081243-chive-reluctant-d200@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

7210195f1bc5 ("drm/amd/display: Reset DSC memory status")
176278d8bff2 ("drm/amd/display: reset DSC clock in post unlock update")
0127f0445f7c ("drm/amd/display: Refactor input mode programming for DIG FIFO")
e6a901a00822 ("drm/amd/display: use even ODM slice width for two pixels per container")
532a0d2ad292 ("drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util next mode set"")
47745acc5e8d ("drm/amd/display: Add trigger FIFO resync path for DCN35")
4d4d3ff16db2 ("drm/amd/display: Keep VBios pixel rate div setting util next mode set")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
9712b64d6f3f ("drm/amd/display: Remove MPC rate control logic from DCN30 and above")
eed4edda910f ("drm/amd/display: Support long vblank feature")
2d7f3d1a5866 ("drm/amd/display: Implement wait_for_odm_update_pending_complete")
c7b33856139d ("drm/amd/display: Drop some unnecessary guards")
6a068e64fb25 ("drm/amd/display: Update phantom pipe enable / disable sequence")
db8391479f44 ("drm/amd/display: correct static screen event mask")
4ba9ca63e696 ("drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue")
9af68235ad3d ("drm/amd/display: Fix static screen event mask definition change")
f6154d8babbb ("drm/amd/display: Refactor INIT into component folder")
a71e1310a43f ("drm/amd/display: Add more mechanisms for tests")
85fce153995e ("drm/amd/display: change static screen wait frame_count for ips")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7210195f1bc51ba02cffa45b27ddb5c962faa606 Mon Sep 17 00:00:00 2001
From: Duncan Ma <duncan.ma@amd.com>
Date: Mon, 27 May 2024 16:59:59 -0400
Subject: [PATCH] drm/amd/display: Reset DSC memory status

[WHY]
When system exits idle state followed by enabling the display,
DSC memory may still be forced in a deep sleep or shutdown state.

Intermittent DSC corruption is seen when display is visible.

[HOW]
When DSC is enabled, reset dsc memory to force and disable status.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index d6b2334d5364..75128fd34306 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -32,16 +32,6 @@
 
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
 
-/* Object I/F functions */
-static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
-static bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
-static void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
-		struct dsc_optc_config *dsc_optc_cfg);
-static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
-static void dsc2_disable(struct display_stream_compressor *dsc);
-static void dsc2_disconnect(struct display_stream_compressor *dsc);
-static void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
-
 static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
@@ -156,7 +146,7 @@ void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
  */
-static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s)
+void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
@@ -173,7 +163,7 @@ static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_ds
 }
 
 
-static bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
+bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
 {
 	struct dsc_optc_config dsc_optc_cfg;
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
@@ -196,7 +186,7 @@ void dsc_config_log(struct display_stream_compressor *dsc, const struct dsc_conf
 	DC_LOG_DSC("\tcolor_depth %d", config->color_depth);
 }
 
-static void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg)
 {
 	bool is_config_ok;
@@ -233,7 +223,7 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc
 }
 
 
-static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
+void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 	int dsc_clock_en;
@@ -258,7 +248,7 @@ static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
 }
 
 
-static void dsc2_disable(struct display_stream_compressor *dsc)
+void dsc2_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 	int dsc_clock_en;
@@ -277,14 +267,14 @@ static void dsc2_disable(struct display_stream_compressor *dsc)
 		DSC_CLOCK_EN, 0);
 }
 
-static void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
+void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
 	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING, 0, 2, 50000);
 }
 
-static void dsc2_disconnect(struct display_stream_compressor *dsc)
+void dsc2_disconnect(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index a136b26c914c..a23308a785bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -597,5 +597,14 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc,
 		const struct dsc_config *dsc_cfg,
 		uint8_t *dsc_packed_pps);
 
+void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
+bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
+void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+		struct dsc_optc_config *dsc_optc_cfg);
+void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
+void dsc2_disable(struct display_stream_compressor *dsc);
+void dsc2_disconnect(struct display_stream_compressor *dsc);
+void dsc2_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
+
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index 71d2dff9986d..6f4f5a3c4861 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -27,6 +27,20 @@
 #include "dcn35_dsc.h"
 #include "reg_helper.h"
 
+static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe);
+
+static const struct dsc_funcs dcn35_dsc_funcs = {
+	.dsc_get_enc_caps = dsc2_get_enc_caps,
+	.dsc_read_state = dsc2_read_state,
+	.dsc_validate_stream = dsc2_validate_stream,
+	.dsc_set_config = dsc2_set_config,
+	.dsc_get_packed_pps = dsc2_get_packed_pps,
+	.dsc_enable = dsc35_enable,
+	.dsc_disable = dsc2_disable,
+	.dsc_disconnect = dsc2_disconnect,
+	.dsc_wait_disconnect_pending_clear = dsc2_wait_disconnect_pending_clear,
+};
+
 /* Macro definitios for REG_SET macros*/
 #define CTX \
 	dsc20->base.ctx
@@ -49,9 +63,47 @@ void dsc35_construct(struct dcn20_dsc *dsc,
 		const struct dcn35_dsc_shift *dsc_shift,
 		const struct dcn35_dsc_mask *dsc_mask)
 {
-	dsc2_construct(dsc, ctx, inst, dsc_regs,
-		(const struct dcn20_dsc_shift *)(dsc_shift),
-		(const struct dcn20_dsc_mask *)(dsc_mask));
+	dsc->base.ctx = ctx;
+	dsc->base.inst = inst;
+	dsc->base.funcs = &dcn35_dsc_funcs;
+
+	dsc->dsc_regs = dsc_regs;
+	dsc->dsc_shift = (const struct dcn20_dsc_shift *)(dsc_shift);
+	dsc->dsc_mask = (const struct dcn20_dsc_mask *)(dsc_mask);
+
+	dsc->max_image_width = 5184;
+}
+
+static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe)
+{
+	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+	int dsc_clock_en;
+	int dsc_fw_config;
+	int enabled_opp_pipe;
+
+	DC_LOG_DSC("enable DSC %d at opp pipe %d", dsc->inst, opp_pipe);
+
+	// TODO: After an idle exit, the HW default values for power control
+	// are changed intermittently due to unknown reasons. There are cases
+	// when dscc memory are still in shutdown state during enablement.
+	// Reset power control to hw default values.
+	REG_UPDATE_2(DSCC_MEM_POWER_CONTROL,
+		DSCC_MEM_PWR_FORCE, 0,
+		DSCC_MEM_PWR_DIS, 0);
+
+	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &dsc_clock_en);
+	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &dsc_fw_config, DSCRM_DSC_OPP_PIPE_SOURCE, &enabled_opp_pipe);
+	if ((dsc_clock_en || dsc_fw_config) && enabled_opp_pipe != opp_pipe) {
+		DC_LOG_DSC("ERROR: DSC %d at opp pipe %d already enabled!", dsc->inst, enabled_opp_pipe);
+		ASSERT(0);
+	}
+
+	REG_UPDATE(DSC_TOP_CONTROL,
+		DSC_CLOCK_EN, 1);
+
+	REG_UPDATE_2(DSCRM_DSC_FORWARD_CONFIG,
+		DSCRM_DSC_FORWARD_EN, 1,
+		DSCRM_DSC_OPP_PIPE_SOURCE, opp_pipe);
 }
 
 void dsc35_set_fgcg(struct dcn20_dsc *dsc20, bool enable)


