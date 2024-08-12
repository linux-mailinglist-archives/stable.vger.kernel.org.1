Return-Path: <stable+bounces-66633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162494F07A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DBBB2700B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F544B5AE;
	Mon, 12 Aug 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UV/6lKWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF2183092
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474221; cv=none; b=ub3rV8Xle2+NsqpV4avjWfxhTUBrspPO4+SI0ud9JaH/uX75mUZiDuAKBneQDGmAvmrV6h0OuhnNhnsoLLAU992Do/0tAbsz2mEnoyPFp0h3EtcbxmnQ/OEwfNyFIoFgqqTVU4FSfj/EGU++1MQkgn/vxBd5rqt+CiNDgucRCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474221; c=relaxed/simple;
	bh=KJ3CZfAJjqx1uV3SS7v3CPcqaewq/Vp5+fhtVu2hopE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KT/H/74FuniFOS5LVUgEmJ7UqqqLbYvrWc0eefKed5+xuhteKQU3EZhQbNhKkKobldqkcSjtDfVWPv/YIMtPD1vfxQ3uZe1pYqxsw+CN7yNMeSmgGReuveM2+/GDzpU46p/ezqq7gT51Ac3Wr01febL+i4RWUVzNShfQX47YFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UV/6lKWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F10C4AF0D;
	Mon, 12 Aug 2024 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474221;
	bh=KJ3CZfAJjqx1uV3SS7v3CPcqaewq/Vp5+fhtVu2hopE=;
	h=Subject:To:Cc:From:Date:From;
	b=UV/6lKWQ0ROvo0ZVW/MMrzJZowCpVIb9AixXWoYyGNEyVzO2vgLHSeK9FyKuWX946
	 kJiFHEtMuRQloNHg5z3X1cDWAjtcY4CLoJ+8Nt7pMkHL5NgfmGDui/44ki4DSUb8yM
	 Ok6YWgGEzI/lCEt/RG+X5z3ZZk1YnS02OnK37PNs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Wait for double buffer update on ODM changes" failed to apply to 6.10-stable tree
To: alvin.lee2@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:45 +0200
Message-ID: <2024081245-safeguard-seducing-d4de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4228900a64592f9c5d4f3b3d48d158948b08ec98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081245-safeguard-seducing-d4de@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

4228900a6459 ("drm/amd/display: Wait for double buffer update on ODM changes")
e6a901a00822 ("drm/amd/display: use even ODM slice width for two pixels per container")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4228900a64592f9c5d4f3b3d48d158948b08ec98 Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Mon, 10 Jun 2024 12:34:25 -0400
Subject: [PATCH] drm/amd/display: Wait for double buffer update on ODM changes

[WHAT & HOW]
We must wait for ODM double buffer updates to complete
before exiting the pipe update sequence or we may reduce
DISPCLK and hit some transient underflow (pixel rate is
reduced before the pipes have ODM enabled).

Reviewed-by: Samson Tam <samson.tam@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4d359bb9b1ec..36797ed7ad8c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2227,6 +2227,29 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		/* When going from a smaller ODM slice count to larger, we must ensure double
+		 * buffer update completes before we return to ensure we don't reduce DISPCLK
+		 * before we've transitioned to 2:1 or 4:1
+		 */
+		if (resource_is_pipe_type(old_pipe, OTG_MASTER) && resource_is_pipe_type(pipe, OTG_MASTER) &&
+				resource_get_odm_slice_count(old_pipe) < resource_get_odm_slice_count(pipe) &&
+				dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM) {
+			int j = 0;
+			struct timing_generator *tg = pipe->stream_res.tg;
+
+
+			if (tg->funcs->get_double_buffer_pending) {
+				for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_US / polling_interval_us
+				&& tg->funcs->get_double_buffer_pending(tg); j++)
+					udelay(polling_interval_us);
+			}
+		}
+	}
+
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
 		dc->res_pool->hubbub->funcs->force_pstate_change_control(
 				dc->res_pool->hubbub, false, false);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index cd4826f329c1..0f453452234c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -340,6 +340,7 @@ struct timing_generator_funcs {
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
+	bool (*get_double_buffer_pending)(struct timing_generator *tg);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index e3e70c1db040..369a13244e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -562,7 +562,8 @@ struct dcn_optc_registers {
 	type OTG_CRC_DATA_FORMAT;\
 	type OTG_V_TOTAL_LAST_USED_BY_DRR;\
 	type OTG_DRR_TIMING_DBUF_UPDATE_PENDING;\
-	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;
+	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;\
+	type OPTC_DOUBLE_BUFFER_PENDING;\
 
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 6c837409df42..00094f0e8470 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -297,6 +297,18 @@ static void optc32_set_drr(
 	optc32_setup_manual_trigger(optc);
 }
 
+bool optc32_get_double_buffer_pending(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t update_pending = 0;
+
+	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
+			OPTC_DOUBLE_BUFFER_PENDING,
+			&update_pending);
+
+	return (update_pending == 1);
+}
+
 static struct timing_generator_funcs dcn32_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -361,6 +373,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.get_double_buffer_pending = optc32_get_double_buffer_pending,
 };
 
 void dcn32_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 0c2c14695561..665d7c52f67c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -116,6 +116,7 @@
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
@@ -184,5 +185,6 @@ void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combi
 void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc32_wait_odm_doublebuffer_pending_clear(struct timing_generator *tg);
+bool optc32_get_double_buffer_pending(struct timing_generator *optc);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index fd1c8b45c40e..9f5c2efa7560 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -459,6 +459,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.get_double_buffer_pending = optc32_get_double_buffer_pending,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 1671fdd5061c..3114ecef332a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -94,6 +94,7 @@
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_ON, mask_sh),\
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\


