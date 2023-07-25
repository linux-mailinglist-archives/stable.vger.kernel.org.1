Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D176132F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjGYLIm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjGYLIS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87A4493
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD0E6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD32CC433C8;
        Tue, 25 Jul 2023 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283211;
        bh=Lqkif4HGVceFEVQiTFVx1RaAynZNRuAs1DZ2Akb0I8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ul8LkKRWiObRwGpRzK/WsNWfGApPJ5hCGFnGTYB+Q843G71n8Riw3NS66DNtoBsRp
         E8AYv+mXAYjqZgHOhY7KASWCEsIURk5vNBVr2SiKAjSgkMoDRUR6735dbl4CgID3G6
         tyWwto91qcY5z4CRqb/p674R4FEShWkYIgJ6q8rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 178/183] drm/amd/display: fix some coding style issues
Date:   Tue, 25 Jul 2023 12:46:46 +0200
Message-ID: <20230725104514.137129903@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit ae67558be712237109100fd14f12378adcf24356 upstream.

Fix the following checkpatch checks in amdgpu_dm.c

CHECK: Prefer kernel type 'u8' over 'uint8_t'
CHECK: Prefer kernel type 'u32' over 'uint32_t'
CHECK: Prefer kernel type 'u64' over 'uint64_t'
CHECK: Prefer kernel type 's32' over 'int32_t'

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ PSR-SU support was introduced in kernel 6.2 with commits like
  30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
  but PSR-SU isn't enabled in 6.1.y, so this block needs to be skipped
  when backporting. ]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   90 +++++++++++-----------
 1 file changed, 45 insertions(+), 45 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -211,7 +211,7 @@ static void amdgpu_dm_destroy_drm_device
 
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *amdgpu_dm_connector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *amdgpu_encoder);
 static int amdgpu_dm_encoder_init(struct drm_device *dev,
 				  struct amdgpu_encoder *aencoder,
@@ -263,7 +263,7 @@ static u32 dm_vblank_get_counter(struct
 static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
-	uint32_t v_blank_start, v_blank_end, h_position, v_position;
+	u32 v_blank_start, v_blank_end, h_position, v_position;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
@@ -391,7 +391,7 @@ static void dm_pflip_high_irq(void *inte
 	struct amdgpu_device *adev = irq_params->adev;
 	unsigned long flags;
 	struct drm_pending_vblank_event *e;
-	uint32_t vpos, hpos, v_blank_start, v_blank_end;
+	u32 vpos, hpos, v_blank_start, v_blank_end;
 	bool vrr_active;
 
 	amdgpu_crtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
@@ -678,7 +678,7 @@ static void dmub_hpd_callback(struct amd
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct dc_link *link;
-	uint8_t link_index = 0;
+	u8 link_index = 0;
 	struct drm_device *dev;
 
 	if (adev == NULL)
@@ -779,7 +779,7 @@ static void dm_dmub_outbox1_low_irq(void
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dmcub_trace_buf_entry entry = { 0 };
-	uint32_t count = 0;
+	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
 	struct dc_link *plink = NULL;
 
@@ -1045,7 +1045,7 @@ static int dm_dmub_hw_init(struct amdgpu
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
-	uint32_t i, fw_inst_const_size, fw_bss_data_size;
+	u32 i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
 
 	if (!dmub_srv)
@@ -1206,10 +1206,10 @@ static void dm_dmub_hw_resume(struct amd
 
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
-	uint64_t pt_base;
-	uint32_t logical_addr_low;
-	uint32_t logical_addr_high;
-	uint32_t agp_base, agp_bot, agp_top;
+	u64 pt_base;
+	u32 logical_addr_low;
+	u32 logical_addr_high;
+	u32 agp_base, agp_bot, agp_top;
 	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
 
 	memset(pa_config, 0, sizeof(*pa_config));
@@ -2536,7 +2536,7 @@ struct amdgpu_dm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc)
 {
-	uint32_t i;
+	u32 i;
 	struct drm_connector_state *new_con_state;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc_from_state;
@@ -3172,8 +3172,8 @@ static void handle_hpd_irq(void *param)
 
 static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 {
-	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
-	uint8_t dret;
+	u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
+	u8 dret;
 	bool new_irq_handled = false;
 	int dpcd_addr;
 	int dpcd_bytes_to_read;
@@ -3201,7 +3201,7 @@ static void dm_handle_mst_sideband_msg(s
 
 	while (dret == dpcd_bytes_to_read &&
 		process_count < max_process_count) {
-		uint8_t retry;
+		u8 retry;
 		dret = 0;
 
 		process_count++;
@@ -3220,7 +3220,7 @@ static void dm_handle_mst_sideband_msg(s
 				dpcd_bytes_to_read - 1;
 
 			for (retry = 0; retry < 3; retry++) {
-				uint8_t wret;
+				u8 wret;
 
 				wret = drm_dp_dpcd_write(
 					&aconnector->dm_dp_aux.aux,
@@ -4236,12 +4236,12 @@ static void amdgpu_set_panel_orientation
 static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int32_t i;
+	s32 i;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct amdgpu_encoder *aencoder = NULL;
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
-	uint32_t link_cnt;
-	int32_t primary_planes;
+	u32 link_cnt;
+	s32 primary_planes;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
@@ -4768,7 +4768,7 @@ fill_plane_color_attributes(const struct
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const uint64_t tiling_flags,
+			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface,
@@ -4977,7 +4977,7 @@ static void fill_dc_dirty_rects(struct d
 	uint32_t num_clips;
 	bool bb_changed;
 	bool fb_changed;
-	uint32_t i = 0;
+	u32 i = 0;
 
 	flip_addrs->dirty_rect_count = 0;
 
@@ -5111,7 +5111,7 @@ static enum dc_color_depth
 convert_color_depth_from_display_info(const struct drm_connector *connector,
 				      bool is_y420, int requested_bpc)
 {
-	uint8_t bpc;
+	u8 bpc;
 
 	if (is_y420) {
 		bpc = 8;
@@ -5655,8 +5655,8 @@ static void apply_dsc_policy_for_edp(str
 				    uint32_t max_dsc_target_bpp_limit_override)
 {
 	const struct dc_link_settings *verified_link_cap = NULL;
-	uint32_t link_bw_in_kbps;
-	uint32_t edp_min_bpp_x16, edp_max_bpp_x16;
+	u32 link_bw_in_kbps;
+	u32 edp_min_bpp_x16, edp_max_bpp_x16;
 	struct dc *dc = sink->ctx->dc;
 	struct dc_dsc_bw_range bw_range = {0};
 	struct dc_dsc_config dsc_cfg = {0};
@@ -5713,11 +5713,11 @@ static void apply_dsc_policy_for_stream(
 					struct dsc_dec_dpcd_caps *dsc_caps)
 {
 	struct drm_connector *drm_connector = &aconnector->base;
-	uint32_t link_bandwidth_kbps;
+	u32 link_bandwidth_kbps;
 	struct dc *dc = sink->ctx->dc;
-	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
-	uint32_t dsc_max_supported_bw_in_kbps;
-	uint32_t max_dsc_target_bpp_limit_override =
+	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
+	u32 dsc_max_supported_bw_in_kbps;
+	u32 max_dsc_target_bpp_limit_override =
 		drm_connector->display_info.max_dsc_bpp;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
@@ -6871,7 +6871,7 @@ static uint add_fs_modes(struct amdgpu_d
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
 	uint i;
-	uint32_t new_modes_count = 0;
+	u32 new_modes_count = 0;
 
 	/* Standard FPS values
 	 *
@@ -6885,7 +6885,7 @@ static uint add_fs_modes(struct amdgpu_d
 	 * 60 	        - Commonly used
 	 * 48,72,96,120 - Multiples of 24
 	 */
-	static const uint32_t common_rates[] = {
+	static const u32 common_rates[] = {
 		23976, 24000, 25000, 29970, 30000,
 		48000, 50000, 60000, 72000, 96000, 120000
 	};
@@ -6901,8 +6901,8 @@ static uint add_fs_modes(struct amdgpu_d
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
-		uint64_t target_vtotal, target_vtotal_diff;
-		uint64_t num, den;
+		u64 target_vtotal, target_vtotal_diff;
+		u64 num, den;
 
 		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
 			continue;
@@ -7150,7 +7150,7 @@ create_i2c(struct ddc_service *ddc_servi
  */
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *aconnector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *aencoder)
 {
 	int res = 0;
@@ -7641,8 +7641,8 @@ static void amdgpu_dm_commit_planes(stru
 				    struct drm_crtc *pcrtc,
 				    bool wait_for_vblank)
 {
-	uint32_t i;
-	uint64_t timestamp_ns;
+	u32 i;
+	u64 timestamp_ns;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct amdgpu_crtc *acrtc_attach = to_amdgpu_crtc(pcrtc);
@@ -7653,7 +7653,7 @@ static void amdgpu_dm_commit_planes(stru
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
 	int planes_count = 0, vpos, hpos;
 	unsigned long flags;
-	uint32_t target_vblank, last_flip_vblank;
+	u32 target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
@@ -8102,7 +8102,7 @@ static void amdgpu_dm_atomic_commit_tail
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dm_atomic_state *dm_state;
 	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
-	uint32_t i, j;
+	u32 i, j;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	unsigned long flags;
@@ -8732,7 +8732,7 @@ is_timing_unchanged_for_freesync(struct
 }
 
 static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
-	uint64_t num, den, res;
+	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
 	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
@@ -9908,7 +9908,7 @@ fail:
 static bool is_dp_capable_without_timing_msa(struct dc *dc,
 					     struct amdgpu_dm_connector *amdgpu_dm_connector)
 {
-	uint8_t dpcd_data;
+	u8 dpcd_data;
 	bool capable = false;
 
 	if (amdgpu_dm_connector->dc_link &&
@@ -9927,7 +9927,7 @@ static bool is_dp_capable_without_timing
 static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
 		unsigned int total_length,
-		uint8_t *data,
+		u8 *data,
 		unsigned int length,
 		struct amdgpu_hdmi_vsdb_info *vsdb)
 {
@@ -9982,7 +9982,7 @@ static bool dm_edid_parser_send_cea(stru
 }
 
 static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -10023,7 +10023,7 @@ static bool parse_edid_cea_dmcu(struct a
 }
 
 static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -10039,7 +10039,7 @@ static bool parse_edid_cea_dmub(struct a
 }
 
 static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
@@ -10053,7 +10053,7 @@ static bool parse_edid_cea(struct amdgpu
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
-	uint8_t *edid_ext = NULL;
+	u8 *edid_ext = NULL;
 	int i;
 	bool valid_vsdb_found = false;
 
@@ -10229,7 +10229,7 @@ void amdgpu_dm_trigger_timing_sync(struc
 }
 
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
-		       uint32_t value, const char *func_name)
+		       u32 value, const char *func_name)
 {
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
@@ -10244,7 +10244,7 @@ void dm_write_reg_func(const struct dc_c
 uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 			  const char *func_name)
 {
-	uint32_t value;
+	u32 value;
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
 		DC_ERR("invalid register read; address = 0\n");


