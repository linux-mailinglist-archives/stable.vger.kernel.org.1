Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06F76023D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGXW0v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGXW0u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2810D
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCwZzlbAnjWSDkkgXEbTidkAMK6D95ChRx7auUIOcMnnOObjrHMjd5j54ZDGAxmmKVWvIEE6vQzGNS+JE7Dkqx+LLLYmBgDOe+Oo45NHWjb35ijMMUuos2FRxONse3sZyhpY9eHrV+PO5Sce6JJ5tOV8lDbtwfGFEXPgh75sKuDargnay140IZRFd7aLWg1NtBErg76OPm3GoDJdgh+D/Liogsfvzky20bd+HhLuKINQw6L3bEfUByxgWe4F3YbRYs3+bsChEQ9//xVp2lIEk5THrgKKoe7M3kH3uQJOubLMT4dIMY2K7nujfQMAsjXb7xDMLRuqJdJDQ8GXM5uHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZrFYCUzoZ36N4HdrcMzWMW8pRYgOEj7a2JB+zsARw0=;
 b=AsOjxvHiDrUM65HDGW25at+vK8LWjozH6Tiz81Y32qbfVVTkwVLefEg7cdnDRBt08CxA/+ja4a7F2g6vwNgN9Gy/3Abtmf4vlr5xocSsGthRyyJyj8nppCbTmTn43zXOLM/dPg16FM6+g1xMqW1Wuj26eOetv8nyJLYXzZJ2RgT6JpHG949+R+lKec+/klmnRx6+jRcrwh1klEbwz1wrM1LjfAAHwsrWducDNxlhuzeYySteisYPkK4LN20CRex8C5DXTb/inuU3O8CSTdW23tXlkn2OgDhrnL6OjgwbovQ/GFIgrfrKpNadJgCsTuMTZg8MhvRgv3m+ZTVeNCQCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZrFYCUzoZ36N4HdrcMzWMW8pRYgOEj7a2JB+zsARw0=;
 b=v3aEPJGn85At9r0saTMj3jPWJ64rsU2j4PLDskd9yDAfVN/AM4oIk8Flr6oSd935Bi8ArIZQF2HyMBITRkGXngRO7Cj+l0YpX5qVyPXLU0wG44RyK+FtE/5gbdC1RX10CKkYr/wyYjWghyOhNyAcvvEcwgy7LKuh96WQo1tUnE4=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 22:26:46 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a1) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 2/7] drm/amd/display: fix some coding style issues
Date:   Mon, 24 Jul 2023 17:26:33 -0500
Message-ID: <20230724222638.1477-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724222638.1477-1-mario.limonciello@amd.com>
References: <20230724222638.1477-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 64101f41-f31d-4bfc-621e-08db8c95105e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6SFdkemgLZw+4pu3kekhdZxarDrnNaDqcqS+Lro0IsHTZO7gGrJgVZhGm+VeNETPBaNl6jedc+zYX+tz9dyxA1ZcrKs6I7WzejpCFfVvkNyYKE7aM+Q6tc4DdF9H3+f4oChIsy+zK/Mzs7fF3Eo36K7D4gQokgt0kUMTbnekeqvTAPvibvYrk2t79DqT7xg2s56N5eb8GOhXSTz3CwaHNWRiKfu1o46IIqb0uo1V32ZRNPgmKUByU72/OVUpH/0xr5+ZdEeLa2QVDYsLAMY3hBg+7ok54yjeK+UKNGC2V12QhM4t6lwVBwp31L7rTgAm2ULdxQ8ZsGvMbLCiYUc9dNG+/Id65kr7GS90ihg8w2YpXZUtk4cE9A9w7hNOPb4DApjlv6jBten5wO1RTaU/G74Bc26ZoKlHr2oLOOFFBJ2KFkgwsu5qlR5l+OYudrkdpZvcwuN7HwzQGCQ/s2q4RA41VtbDTOrNlXHc5b2lLx+ZWuiK67BUM6Z4NxKsVlb0Lj7DHt+8H4gEhAWwhwYd4L+oU7FWlmDLPDGIb7DpJ13OnKqFr8Tl3TFJZRxVZHaeO9SNBYV0KsTGeltSIfMlw2Mns2160efH+WHQcQzUA9DnuWYxM+H90NQjRWRshGTLEpbN1QStDQNl0JcwN1C3EzvjGvfl9zeazwUMypq1npSiTcNAKKIrTtANbQ/Ur+3TIe2C3V+pJ1u0ENeJLfLHGwpHsCrc2wbgdH0yEeOIFQ/f//cstiY/ZwF8zIurPfR3trb2zYpmQ5O4Lwv7/T3Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(478600001)(6666004)(83380400001)(36860700001)(426003)(47076005)(40460700003)(86362001)(40480700001)(36756003)(30864003)(44832011)(2906002)(16526019)(336012)(2616005)(26005)(1076003)(356005)(82740400003)(81166007)(70206006)(6916009)(186003)(70586007)(4326008)(41300700001)(8936002)(316002)(5660300002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:45.5225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64101f41-f31d-4bfc-621e-08db8c95105e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Fix the following checkpatch checks in amdgpu_dm.c

CHECK: Prefer kernel type 'u8' over 'uint8_t'
CHECK: Prefer kernel type 'u32' over 'uint32_t'
CHECK: Prefer kernel type 'u64' over 'uint64_t'
CHECK: Prefer kernel type 's32' over 'int32_t'

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ae67558be712237109100fd14f12378adcf24356)

PSR-SU support was introduced in kernel 6.2 with commits like
30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
but PSR-SU isn't enabled in 6.1.y, so this block needs to be skipped
when backporting.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e7c7ac47f86a..8274981f8766 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -211,7 +211,7 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *amdgpu_dm_connector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *amdgpu_encoder);
 static int amdgpu_dm_encoder_init(struct drm_device *dev,
 				  struct amdgpu_encoder *aencoder,
@@ -263,7 +263,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
-	uint32_t v_blank_start, v_blank_end, h_position, v_position;
+	u32 v_blank_start, v_blank_end, h_position, v_position;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
@@ -391,7 +391,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	unsigned long flags;
 	struct drm_pending_vblank_event *e;
-	uint32_t vpos, hpos, v_blank_start, v_blank_end;
+	u32 vpos, hpos, v_blank_start, v_blank_end;
 	bool vrr_active;
 
 	amdgpu_crtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
@@ -678,7 +678,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct dc_link *link;
-	uint8_t link_index = 0;
+	u8 link_index = 0;
 	struct drm_device *dev;
 
 	if (adev == NULL)
@@ -779,7 +779,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dmcub_trace_buf_entry entry = { 0 };
-	uint32_t count = 0;
+	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
 	struct dc_link *plink = NULL;
 
@@ -1045,7 +1045,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
-	uint32_t i, fw_inst_const_size, fw_bss_data_size;
+	u32 i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
 
 	if (!dmub_srv)
@@ -1206,10 +1206,10 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 
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
@@ -3201,7 +3201,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 
 	while (dret == dpcd_bytes_to_read &&
 		process_count < max_process_count) {
-		uint8_t retry;
+		u8 retry;
 		dret = 0;
 
 		process_count++;
@@ -3220,7 +3220,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 				dpcd_bytes_to_read - 1;
 
 			for (retry = 0; retry < 3; retry++) {
-				uint8_t wret;
+				u8 wret;
 
 				wret = drm_dp_dpcd_write(
 					&aconnector->dm_dp_aux.aux,
@@ -4236,12 +4236,12 @@ static void amdgpu_set_panel_orientation(struct drm_connector *connector);
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
@@ -4768,7 +4768,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const uint64_t tiling_flags,
+			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface,
@@ -4977,7 +4977,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
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
@@ -5655,8 +5655,8 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
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
@@ -5713,11 +5713,11 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
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
@@ -6871,7 +6871,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
 	uint i;
-	uint32_t new_modes_count = 0;
+	u32 new_modes_count = 0;
 
 	/* Standard FPS values
 	 *
@@ -6885,7 +6885,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	 * 60 	        - Commonly used
 	 * 48,72,96,120 - Multiples of 24
 	 */
-	static const uint32_t common_rates[] = {
+	static const u32 common_rates[] = {
 		23976, 24000, 25000, 29970, 30000,
 		48000, 50000, 60000, 72000, 96000, 120000
 	};
@@ -6901,8 +6901,8 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
-		uint64_t target_vtotal, target_vtotal_diff;
-		uint64_t num, den;
+		u64 target_vtotal, target_vtotal_diff;
+		u64 num, den;
 
 		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
 			continue;
@@ -7150,7 +7150,7 @@ create_i2c(struct ddc_service *ddc_service,
  */
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *aconnector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *aencoder)
 {
 	int res = 0;
@@ -7641,8 +7641,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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
@@ -7653,7 +7653,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
 	int planes_count = 0, vpos, hpos;
 	unsigned long flags;
-	uint32_t target_vblank, last_flip_vblank;
+	u32 target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
@@ -8094,7 +8094,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dm_atomic_state *dm_state;
 	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
-	uint32_t i, j;
+	u32 i, j;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	unsigned long flags;
@@ -8724,7 +8724,7 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 }
 
 static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
-	uint64_t num, den, res;
+	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
 	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
@@ -9900,7 +9900,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 static bool is_dp_capable_without_timing_msa(struct dc *dc,
 					     struct amdgpu_dm_connector *amdgpu_dm_connector)
 {
-	uint8_t dpcd_data;
+	u8 dpcd_data;
 	bool capable = false;
 
 	if (amdgpu_dm_connector->dc_link &&
@@ -9919,7 +9919,7 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
 static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
 		unsigned int total_length,
-		uint8_t *data,
+		u8 *data,
 		unsigned int length,
 		struct amdgpu_hdmi_vsdb_info *vsdb)
 {
@@ -9974,7 +9974,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -10015,7 +10015,7 @@ static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -10031,7 +10031,7 @@ static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
@@ -10045,7 +10045,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
-	uint8_t *edid_ext = NULL;
+	u8 *edid_ext = NULL;
 	int i;
 	bool valid_vsdb_found = false;
 
@@ -10221,7 +10221,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 }
 
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
-		       uint32_t value, const char *func_name)
+		       u32 value, const char *func_name)
 {
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
@@ -10236,7 +10236,7 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 			  const char *func_name)
 {
-	uint32_t value;
+	u32 value;
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
 		DC_ERR("invalid register read; address = 0\n");
-- 
2.34.1

