Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDC761260
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjGYLBs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjGYLBW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B801C4EE1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 757B7616A8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821AEC433AD;
        Tue, 25 Jul 2023 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282728;
        bh=5pAVA3IFtFGW+suJXrKJf5/WRdNtt+jg765k1Rqvqck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PCg8x7B96Wfg7dEBoryrUUh9w5hnoFaCIkfwfCblx9EnkgusBmZ2sC79SiOUN175
         Esm7gA8vGpd6pDCb/1UcQnlqrBL8MpGi24+Q7+qmS/4ZYg08Yy0dhrruOnjAO5Qq27
         36rOp5rVZxuecKSyxANhrJDCNVTXHhKc54SvHW4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 6.4 226/227] drm/amd/display: Clean up errors & warnings in amdgpu_dm.c
Date:   Tue, 25 Jul 2023 12:46:33 +0200
Message-ID: <20230725104524.056376492@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit 87279fdf5ee0ad1360765ef70389d1c4d0f81bb6 upstream.

Fix the following errors & warnings reported by checkpatch:

ERROR: space required before the open brace '{'
ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxW)
ERROR: else should follow close brace '}'
ERROR: open brace '{' following function definitions go on the next line
ERROR: code indent should use tabs where possible

WARNING: braces {} are not necessary for single statement blocks
WARNING: void function return statements are not generally useful
WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  133 ++++++++++------------
 1 file changed, 65 insertions(+), 68 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -416,12 +416,12 @@ static void dm_pflip_high_irq(void *inte
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
-		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
-						 amdgpu_crtc->pflip_status,
-						 AMDGPU_FLIP_SUBMITTED,
-						 amdgpu_crtc->crtc_id,
-						 amdgpu_crtc);
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p]\n",
+			     amdgpu_crtc->pflip_status,
+			     AMDGPU_FLIP_SUBMITTED,
+			     amdgpu_crtc->crtc_id,
+			     amdgpu_crtc);
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 		return;
 	}
@@ -875,7 +875,7 @@ static int dm_set_powergating_state(void
 }
 
 /* Prototypes of private functions */
-static int dm_early_init(void* handle);
+static int dm_early_init(void *handle);
 
 /* Allocate memory for FBC compressed data  */
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
@@ -1274,7 +1274,7 @@ static void mmhub_read_system_context(st
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
 	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
 
-	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
+	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24;
 	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
 	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
 
@@ -1357,8 +1357,7 @@ static void dm_handle_hpd_rx_offload_wor
 		DP_TEST_RESPONSE,
 		&test_response.raw,
 		sizeof(test_response));
-	}
-	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
+	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
 		/* offload_work->data is from handle_hpd_rx_irq->
@@ -1546,7 +1545,7 @@ static int amdgpu_dm_init(struct amdgpu_
 	mutex_init(&adev->dm.dc_lock);
 	mutex_init(&adev->dm.audio_lock);
 
-	if(amdgpu_dm_irq_init(adev)) {
+	if (amdgpu_dm_irq_init(adev)) {
 		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
 		goto error;
 	}
@@ -1691,9 +1690,8 @@ static int amdgpu_dm_init(struct amdgpu_
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
 
-	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		adev->dm.dc->debug.disable_dsc = true;
-	}
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
 		adev->dm.dc->debug.disable_clock_gate = true;
@@ -1937,8 +1935,6 @@ static void amdgpu_dm_fini(struct amdgpu
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 	mutex_destroy(&adev->dm.dpia_aux_lock);
-
-	return;
 }
 
 static int load_dmcu_fw(struct amdgpu_device *adev)
@@ -1947,7 +1943,7 @@ static int load_dmcu_fw(struct amdgpu_de
 	int r;
 	const struct dmcu_firmware_header_v1_0 *hdr;
 
-	switch(adev->asic_type) {
+	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
@@ -2704,7 +2700,7 @@ static void dm_gpureset_commit_state(str
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} * bundle;
+	} *bundle;
 	int k, m;
 
 	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
@@ -2734,8 +2730,6 @@ static void dm_gpureset_commit_state(str
 
 cleanup:
 	kfree(bundle);
-
-	return;
 }
 
 static int dm_resume(void *handle)
@@ -2949,8 +2943,7 @@ static const struct amd_ip_funcs amdgpu_
 	.set_powergating_state = dm_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version dm_ip_block =
-{
+const struct amdgpu_ip_block_version dm_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 1,
 	.minor = 0,
@@ -2995,9 +2988,12 @@ static void update_connector_ext_caps(st
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
 
-	if (caps->ext_caps->bits.oled == 1 /*||
-	    caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
-	    caps->ext_caps->bits.hdr_aux_backlight_control == 1*/)
+	if (caps->ext_caps->bits.oled == 1
+	    /*
+	     * ||
+	     * caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
+	     * caps->ext_caps->bits.hdr_aux_backlight_control == 1
+	     */)
 		caps->aux_support = true;
 
 	if (amdgpu_backlight == 0)
@@ -3264,6 +3260,7 @@ static void dm_handle_mst_sideband_msg(s
 		process_count < max_process_count) {
 		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
 		u8 retry;
+
 		dret = 0;
 
 		process_count++;
@@ -3463,7 +3460,7 @@ static void register_hpd_handlers(struct
 		aconnector = to_amdgpu_dm_connector(connector);
 		dc_link = aconnector->dc_link;
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 			int_params.irq_source = dc_link->irq_source_hpd;
 
@@ -3472,7 +3469,7 @@ static void register_hpd_handlers(struct
 					(void *) aconnector);
 		}
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
 
 			/* Also register for DP short pulse (hpd_rx). */
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -3498,7 +3495,7 @@ static int dce60_register_irq_handlers(s
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -3512,11 +3509,12 @@ static int dce60_register_irq_handlers(s
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		r = amdgpu_irq_add_id(adev, client_id, i+1 , &adev->crtc_irq);
+		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
 		if (r) {
 			DRM_ERROR("Failed to add crtc irq id!\n");
 			return r;
@@ -3524,7 +3522,7 @@ static int dce60_register_irq_handlers(s
 
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i+1 , 0);
+			dc_interrupt_to_irq_source(dc, i + 1, 0);
 
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
@@ -3580,7 +3578,7 @@ static int dce110_register_irq_handlers(
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
@@ -3597,7 +3595,8 @@ static int dce110_register_irq_handlers(
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
@@ -4044,7 +4043,7 @@ static void amdgpu_dm_update_backlight_c
 }
 
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned *min, unsigned *max)
+				unsigned int *min, unsigned int *max)
 {
 	if (!caps)
 		return 0;
@@ -4064,7 +4063,7 @@ static int get_brightness_range(const st
 static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 					uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4077,7 +4076,7 @@ static u32 convert_brightness_from_user(
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 				      uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4557,7 +4556,6 @@ fail:
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
 	drm_atomic_private_obj_fini(&dm->atomic_obj);
-	return;
 }
 
 /******************************************************************************
@@ -5375,6 +5373,7 @@ static bool adjust_colour_depth_from_dis
 {
 	enum dc_color_depth depth = timing_out->display_color_depth;
 	int normalized_clk;
+
 	do {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
@@ -5590,6 +5589,7 @@ create_fake_sink(struct amdgpu_dm_connec
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
+
 	sink_init_data.link = aconnector->dc_link;
 	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
 
@@ -5713,7 +5713,7 @@ get_highest_refresh_rate_mode(struct amd
 		return &aconnector->freesync_vid_base;
 
 	/* Find the preferred mode */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		if (m->type & DRM_MODE_TYPE_PREFERRED) {
 			m_pref = m;
 			break;
@@ -5737,7 +5737,7 @@ get_highest_refresh_rate_mode(struct amd
 	 * For some monitors, preferred mode is not the mode with highest
 	 * supported refresh rate.
 	 */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		current_refresh  = drm_mode_vrefresh(m);
 
 		if (m->hdisplay == m_pref->hdisplay &&
@@ -6010,7 +6010,7 @@ create_stream_for_sink(struct amdgpu_dm_
 		 * This may not be an error, the use case is when we have no
 		 * usermode calls to reset and set mode upon hotplug. In this
 		 * case, we call set mode ourselves to restore the previous mode
-		 * and the modelist may not be filled in in time.
+		 * and the modelist may not be filled in time.
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
@@ -6034,9 +6034,9 @@ create_stream_for_sink(struct amdgpu_dm_
 		drm_mode_set_crtcinfo(&mode, 0);
 
 	/*
-	* If scaling is enabled and refresh rate didn't change
-	* we copy the vic and polarities of the old timings
-	*/
+	 * If scaling is enabled and refresh rate didn't change
+	 * we copy the vic and polarities of the old timings
+	 */
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
 			stream, &mode, &aconnector->base, con_state, NULL,
@@ -6756,6 +6756,7 @@ static int dm_encoder_helper_atomic_chec
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
+
 		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
 			  aconnector->force_yuv420_output;
 		color_depth = convert_color_depth_from_display_info(connector,
@@ -7074,7 +7075,7 @@ static bool is_duplicate_mode(struct amd
 {
 	struct drm_display_mode *m;
 
-	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
 		if (drm_mode_equal(m, mode))
 			return true;
 	}
@@ -7384,7 +7385,6 @@ static int amdgpu_dm_connector_init(stru
 
 	link->priv = aconnector;
 
-	DRM_DEBUG_DRIVER("%s()\n", __func__);
 
 	i2c = create_i2c(link->ddc, link->link_index, &res);
 	if (!i2c) {
@@ -8106,8 +8106,7 @@ static void amdgpu_dm_commit_planes(stru
 			 * DRI3/Present extension with defined target_msc.
 			 */
 			last_flip_vblank = amdgpu_get_vblank_counter_kms(pcrtc);
-		}
-		else {
+		} else {
 			/* For variable refresh rate mode only:
 			 * Get vblank of last completed flip to avoid > 1 vrr
 			 * flips per video frame by use of throttling, but allow
@@ -8440,8 +8439,8 @@ static void amdgpu_dm_atomic_commit_tail
 		dc_resource_state_copy_construct_current(dm->dc, dc_state);
 	}
 
-	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
-				       new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -8464,9 +8463,7 @@ static void amdgpu_dm_atomic_commit_tail
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		drm_dbg_state(state->dev,
-			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-			"connectors_changed:%d\n",
+			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 			acrtc->crtc_id,
 			new_crtc_state->enable,
 			new_crtc_state->active,
@@ -9035,8 +9032,8 @@ static int do_aquire_global_lock(struct
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done "
-				  "timed out\n", crtc->base.id, crtc->name);
+			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
+				  crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
 	}
@@ -9121,7 +9118,8 @@ is_timing_unchanged_for_freesync(struct
 	return false;
 }
 
-static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
+static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
+{
 	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
@@ -9244,9 +9242,7 @@ static int dm_update_crtc_state(struct a
 		goto skip_modeset;
 
 	drm_dbg_state(state->dev,
-		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-		"connectors_changed:%d\n",
+		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 		acrtc->crtc_id,
 		new_crtc_state->enable,
 		new_crtc_state->active,
@@ -9275,8 +9271,7 @@ static int dm_update_crtc_state(struct a
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
 			DRM_DEBUG_DRIVER(
-				"Mode change not required for front porch change, "
-				"setting mode_changed to %d",
+				"Mode change not required for front porch change, setting mode_changed to %d",
 				new_crtc_state->mode_changed);
 
 			set_freesync_fixed_config(dm_new_crtc_state);
@@ -9288,9 +9283,8 @@ static int dm_update_crtc_state(struct a
 			struct drm_display_mode *high_mode;
 
 			high_mode = get_highest_refresh_rate_mode(aconnector, false);
-			if (!drm_mode_equal(&new_crtc_state->mode, high_mode)) {
+			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
 				set_freesync_fixed_config(dm_new_crtc_state);
-			}
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -9458,6 +9452,7 @@ static bool should_reset_plane(struct dr
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
 		struct amdgpu_framebuffer *old_afb, *new_afb;
+
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
 
@@ -9556,11 +9551,12 @@ static int dm_check_cursor_fb(struct amd
 	}
 
 	/* Core DRM takes care of checking FB modifiers, so we only need to
-	 * check tiling flags when the FB doesn't have a modifier. */
+	 * check tiling flags when the FB doesn't have a modifier.
+	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
 		if (adev->family < AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
-			         AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
+				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
 				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
 		} else {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
@@ -9782,12 +9778,12 @@ static int dm_check_crtc_cursor(struct d
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
 	 * positioning from the underlying pipe. Check the cursor plane's
-	 * blending properties match the underlying planes'. */
+	 * blending properties match the underlying planes'.
+	 */
 
 	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
-	if (!new_cursor_state || !new_cursor_state->fb) {
+	if (!new_cursor_state || !new_cursor_state->fb)
 		return 0;
-	}
 
 	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
 	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
@@ -9832,6 +9828,7 @@ static int add_affected_mst_dsc_crtcs(st
 	struct drm_connector_state *conn_state, *old_conn_state;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	int i;
+
 	for_each_oldnew_connector_in_state(state, connector, old_conn_state, conn_state, i) {
 		if (!conn_state->crtc)
 			conn_state = old_conn_state;
@@ -10266,7 +10263,7 @@ static int amdgpu_dm_atomic_check(struct
 	}
 
 	/* Store the overall update type for use later in atomic check. */
-	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct dm_crtc_state *dm_new_crtc_state =
 			to_dm_crtc_state(new_crtc_state);
 
@@ -10288,7 +10285,7 @@ fail:
 	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
 		DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
 	else
-		DRM_DEBUG_DRIVER("Atomic check failed with err: %d \n", ret);
+		DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
 
 	trace_amdgpu_dm_atomic_check_finish(state, ret);
 


