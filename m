Return-Path: <stable+bounces-99076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39E9E6F3A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35435282DDA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DF207655;
	Fri,  6 Dec 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxLeSOgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6C206F3C
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491420; cv=none; b=NfDIjfZqWTRoFWehhiO1FqKvSdzytyPoKMosTlrqMjSQqFxYfa06r8PueVWb0fMpZmmcZSg1p/EXF6/ZJTXiSBjZP5MPYOnNxPttLzuNPZV9fPy1iFEXiLwIfLBeJcpWa72Hk9R+hnRUIWLZB74VMURcPVsLxqna1rKDfgRyf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491420; c=relaxed/simple;
	bh=X24Q6rSUn9jXGW1qW1a1gDbpzBUpltxz+2YNbe0XLD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jiViO6mCr0KFViKQ5Ipk28YMbZ0xpSc0bLk8ZxuCy+NsMP5ejZ/vlwWIXUT8Y8somx0PVE5jrHYfqyPbk7Ta49oDNzzOvn6qKC+8mjKI9Fuqjxe38sH7Lmirhelefaj7i9M4wHwfZEYlWkEKf16D9jGJSwTnhniLxxIb09XVkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxLeSOgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD7C4CED1;
	Fri,  6 Dec 2024 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733491420;
	bh=X24Q6rSUn9jXGW1qW1a1gDbpzBUpltxz+2YNbe0XLD4=;
	h=Subject:To:Cc:From:Date:From;
	b=zxLeSOgfGTeKHzxGltgDBx+PdeUkcdMg3k+CZLvX1w4C99EFwlr2qxpCBrOJpF1Bc
	 A5a30mmdWQ3oU6sRZbnQhue8KatX/nI+PYIgKuqhKivjHqO/5UirF15529w8JvyUfY
	 CkqrpHk6alUkUhjy9BtBGIdG+zjQ7Hfo11goF4bA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Enable Request rate limiter during C-State" failed to apply to 6.12-stable tree
To: dillon.varone@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:22:34 +0100
Message-ID: <2024120634-agnostic-slouchy-6a09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 89713ce5518eda6b370c7a17edbcab4f97a39f68
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120634-agnostic-slouchy-6a09@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89713ce5518eda6b370c7a17edbcab4f97a39f68 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Fri, 1 Nov 2024 10:51:02 -0400
Subject: [PATCH] drm/amd/display: Enable Request rate limiter during C-State
 on dcn401

[WHY]
When C-State entry is requested, the rate limiter will be disabled
which can result in high contention in the DCHUB return path.

[HOW]
Enable the rate limiter during C-state requests to prevent contention.

Cc: stable@vger.kernel.org # 6.11+
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 92e43a1e4dd4..601320b1be81 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -11,6 +11,7 @@
 
 #define DML2_MAX_FMT_420_BUFFER_WIDTH 4096
 #define DML_MAX_NUM_OF_SLICES_PER_DSC 4
+#define ALLOW_SDPIF_RATE_LIMIT_PRE_CSTATE
 
 const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
 {
@@ -3886,6 +3887,10 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 #endif
 
 	*p->hw_debug5 = false;
+#ifdef ALLOW_SDPIF_RATE_LIMIT_PRE_CSTATE
+	if (p->NumberOfActiveSurfaces > 1)
+		*p->hw_debug5 = true;
+#else
 	for (unsigned int k = 0; k < p->NumberOfActiveSurfaces; ++k) {
 		if (!(p->mrq_present) && (!(*p->UnboundedRequestEnabled)) && (TotalActiveDPP == 1)
 			&& p->display_cfg->plane_descriptors[k].surface.dcc.enable
@@ -3901,6 +3906,7 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 		dml2_printf("DML::%s: k=%u hw_debug5 = %u\n", __func__, k, *p->hw_debug5);
 #endif
 	}
+#endif
 }
 
 static enum dml2_odm_mode DecideODMMode(unsigned int HActive,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 4bd1dda07719..9fbd45c7dfef 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -200,6 +200,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_MALL_B;
 	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL1;
 	uint32_t DCHUBBUB_TIMEOUT_DETECTION_CTRL2;
+	uint32_t DCHUBBUB_CTRL_STATUS;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -320,7 +321,12 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD;\
 		type DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD;\
 		type DCHUBBUB_TIMEOUT_DETECTION_EN;\
-		type DCHUBBUB_TIMEOUT_TIMER_RESET
+		type DCHUBBUB_TIMEOUT_TIMER_RESET;\
+		type ROB_UNDERFLOW_STATUS;\
+		type ROB_OVERFLOW_STATUS;\
+		type ROB_OVERFLOW_CLEAR;\
+		type DCHUBBUB_HW_DEBUG;\
+		type CSTATE_SWATH_CHK_GOOD_MODE
 
 #define HUBBUB_STUTTER_REG_FIELD_LIST(type) \
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
index 036bb3e6c957..46d8f5c70750 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
@@ -96,6 +96,7 @@ struct dcn20_hubbub {
 	unsigned int det1_size;
 	unsigned int det2_size;
 	unsigned int det3_size;
+	bool allow_sdpif_rate_limit_when_cstate_req;
 };
 
 void hubbub2_construct(struct dcn20_hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 5d658e9bef64..92fab471b183 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1192,15 +1192,35 @@ static void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
 	}
 }
 
-static void dcn401_program_timeout_thresholds(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs)
+static bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
+	bool wm_pending = false;
+	uint32_t temp;
+
 	/* request backpressure and outstanding return threshold (unused)*/
 	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
 
 	/* P-State stall threshold */
 	REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
+
+	if (safe_to_lower || arb_regs->allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+		hubbub2->allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req;
+
+		/* only update the required bits */
+		REG_GET(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, &temp);
+		if (hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+			temp |= (1 << 5);
+		} else {
+			temp &= ~(1 << 5);
+		}
+		REG_UPDATE(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, temp);
+	} else {
+		wm_pending = true;
+	}
+
+	return wm_pending;
 }
 
 static const struct hubbub_funcs hubbub4_01_funcs = {
@@ -1226,7 +1246,7 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.program_det_segments = dcn401_program_det_segments,
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
-	.program_timeout_thresholds = dcn401_program_timeout_thresholds,
+	.program_arbiter = dcn401_program_arbiter,
 };
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
index 5f1960722ebd..b1d9ea9d1c3d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
@@ -128,7 +128,12 @@
 	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_DETECTION_EN, mask_sh),\
-	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_TIMER_RESET, mask_sh)
+	HUBBUB_SF(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_TIMER_RESET, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_UNDERFLOW_STATUS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_OVERFLOW_STATUS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_OVERFLOW_CLEAR, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, CSTATE_SWATH_CHK_GOOD_MODE, mask_sh)
 
 bool hubbub401_program_urgent_watermarks(
 		struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e8cc1bfa73f3..5de11e2837c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1488,6 +1488,10 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
+	/* update timeout thresholds */
+	if (hubbub->funcs->program_arbiter) {
+		dc->wm_optimized_required |= hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, false);
+	}
 
 	/* decrease compbuf size */
 	if (hubbub->funcs->program_compbuf_segments) {
@@ -1529,6 +1533,10 @@ void dcn401_optimize_bandwidth(
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					true);
+	/* update timeout thresholds */
+	if (hubbub->funcs->program_arbiter) {
+		hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, true);
+	}
 
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
@@ -1554,11 +1562,6 @@ void dcn401_optimize_bandwidth(
 						pipe_ctx->dlg_regs.min_dst_y_next_start);
 		}
 	}
-
-	/* update timeout thresholds */
-	if (hubbub->funcs->program_timeout_thresholds) {
-		hubbub->funcs->program_timeout_thresholds(hubbub, &context->bw_ctx.bw.dcn.arb_regs);
-	}
 }
 
 void dcn401_fams2_global_control_lock(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 6c1d41c0f099..52b745667ef7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -228,7 +228,7 @@ struct hubbub_funcs {
 	void (*program_det_segments)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg);
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
-	void (*program_timeout_thresholds)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs);
+	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
 };
 
 struct hubbub {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 7c8d61db153d..19568c359669 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -612,7 +612,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SR(DCHUBBUB_SDPIF_CFG1),                                                 \
 	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),                                          \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),                                    \
-	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2)
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),									 \
+	SR(DCHUBBUB_CTRL_STATUS)
 
 /* DCCG */
 


