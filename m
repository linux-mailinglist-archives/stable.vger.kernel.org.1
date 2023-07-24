Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7876023F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGXW0y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXW0x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D5B10CB
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8R1QJH4RqXlut4hwe3dnXPT87C1jyrjzNOEJWL5/h9j7TQcxs/y7+VjkG/c99bsD6s9v0xmZC9am9TYNdKDx/Oj3fKGXMiUbzlc2yGzdgjpZaz6rCYra5h2RK61jC1Wyz2/0jcS1pKYyPouHTXnGqxDJYXVxHsIKEt+FRVEY+WhedjdbbMmr+bZodEDebtaQtkVshEoeg++72HNOSdtKWJ4GBZSam6aq1cwZ0Hi9vXzzS2dgLegf9B6LPuc0JGriyf+VC2t7E02QVLyXD/Xe35zX8uKGqBEmqWtyMa81CF55zieIEPDd0h2TpIsBMyOwcUtveMTVt9t1l6Hor762g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeLgOpMe7AvrzRtwrjgBy1Z7RYlTLdiChTe6OHfk1dU=;
 b=BzsTp4tOEdUS1SfpUE8e02LlbB8lRge6DIsr8kMBuAQVGiCW5oPv3FbbHaEtPNXnkz3aK9f+K8qLVUAOpxMwXf4+Bw+qk4jl+9oYnS2Z3Vnq70ECai7i2aZPTzWxxCR5gIgJtcOqAsGaUbRTBiST91kb26Zc0dfhp/GU4nQ57DyhIPle4SIT+IVZUw7zjErWOUtTYNrOuV8XMWPGzyJm9muc+FE7WgY6B+I4F2fyo5wJN+YWqhATykY6GBFu083PWF4NpV7KaiOuo3DSLnX9ZHgyDrfS87816Zww28s8X84nEUV0exirVgFv2TeAvsgMtWFmuMHIulyMzqtYBujwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeLgOpMe7AvrzRtwrjgBy1Z7RYlTLdiChTe6OHfk1dU=;
 b=wxiQnOAB1biB43hFWs8MqGfQf58GA4t18ufF582Ue+AQf+r580S6lNUx3WlLiVXnFUJkBFVWVJ0uAQIeSGY9p77rog/TBMRdVHidDOD7S/d4X0EzHKc6Ow0mHUbXu0vgJTyXDWtEIlJ9dU0nulRnGoxwn/EJR3WY7u/Vz7UaOPA=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 22:26:47 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a1) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 5/7] drm/amd/display: Clean up errors & warnings in amdgpu_dm.c
Date:   Mon, 24 Jul 2023 17:26:36 -0500
Message-ID: <20230724222638.1477-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 0031ec12-4764-4313-3bc5-08db8c951181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vj/Aa2fGA+EhjSWSY7gZeTVkfe2/D9ABz9O+Ilhxwzc7m4qbepGqbetL3IvrnPJzFMAD1i9SMyP4RDQExwy11wKPYdlMCUgr198Qj9Q5ysv6v1fvXjenGWagsES4R7Ya6EVebBgU9N/ozSALHZtQ+0MwpqiM1brqLLfApD9gKAQyMGIe59sus2gGwnW4VQptQNtVwXihoWlWMQh8l2qc0/KSPzqrBEG4J5Sod/Z9OPP3PIgfupW7pV9fJwNiTy+B3U59ATlZUaDa3fCTT6e8JZyj0uS4jC9PaHttZnUrCSKMrR+oI6M0GME6tX/LlrOmts/HdMm123NqVy/IrAvCh+VIb4Z/gyL1d/peP1y7KX1eIDj/laUBQvnKb/TMVhIOw8W4sQPS4uyxyZKeDv4GEFIS9YxQWbG6Jp1sOmh3ejmVoM6JAaTuaTTG6cF9EL8I6opOXIjIfZJBKURTIivO8oXFnIuG/yWeSRdjUiTdCIWUsCaDbzWSj8xlS8rZCCtrgH0JVYoInrj97ql0TFhC6IGhC80t/ATS0oKy6PqN0AA1XBs9mou2t9GVAH4Lw9dBOnnPiXLg7muNUSoznm6Vd8Yv+nGZt4ALipADWTzcmvaYq5dB3zkkH7oEO1AZcbfqt9NyOjEi7OrxaQ3wCTnYI0iuDdFaO4l0JKG76IbmvC96jw+XSVENFgSlkXNzF7JzT91szGqIUfb8/mlA6GoR+LUMkGwW2x6pSKVoAv8LhDIUpiVCB+J5JP46zC0BqdFFwB5w9PtV0ghNpiB7h0jtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(1076003)(186003)(26005)(40460700003)(336012)(16526019)(44832011)(5660300002)(36756003)(36860700001)(8676002)(8936002)(81166007)(30864003)(2906002)(356005)(426003)(2616005)(47076005)(82740400003)(86362001)(40480700001)(6916009)(4326008)(316002)(70206006)(70586007)(478600001)(6666004)(7696005)(83380400001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:47.4286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0031ec12-4764-4313-3bc5-08db8c951181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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
(cherry picked from commit 87279fdf5ee0ad1360765ef70389d1c4d0f81bb6)
Modified for missing
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
which landed in 6.3
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 133 +++++++++---------
 1 file changed, 65 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5f85a1afa590..ccd39b4fed14 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -408,12 +408,12 @@ static void dm_pflip_high_irq(void *interrupt_params)
 
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
@@ -861,7 +861,7 @@ static int dm_set_powergating_state(void *handle,
 }
 
 /* Prototypes of private functions */
-static int dm_early_init(void* handle);
+static int dm_early_init(void *handle);
 
 /* Allocate memory for FBC compressed data  */
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
@@ -1260,7 +1260,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
 	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
 
-	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
+	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24;
 	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
 	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
 
@@ -1343,8 +1343,7 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 		DP_TEST_RESPONSE,
 		&test_response.raw,
 		sizeof(test_response));
-	}
-	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
+	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
 		dc_link_dp_handle_link_loss(dc_link);
@@ -1519,7 +1518,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 	spin_lock_init(&adev->dm.vblank_lock);
 
-	if(amdgpu_dm_irq_init(adev)) {
+	if (amdgpu_dm_irq_init(adev)) {
 		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
 		goto error;
 	}
@@ -1654,9 +1653,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
 
-	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		adev->dm.dc->debug.disable_dsc = true;
-	}
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
 		adev->dm.dc->debug.disable_clock_gate = true;
@@ -1877,8 +1875,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 	mutex_destroy(&adev->dm.dpia_aux_lock);
-
-	return;
 }
 
 static int load_dmcu_fw(struct amdgpu_device *adev)
@@ -1887,7 +1883,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	int r;
 	const struct dmcu_firmware_header_v1_0 *hdr;
 
-	switch(adev->asic_type) {
+	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
@@ -2679,7 +2675,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} * bundle;
+	} *bundle;
 	int k, m;
 
 	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
@@ -2709,8 +2705,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 
 cleanup:
 	kfree(bundle);
-
-	return;
 }
 
 static int dm_resume(void *handle)
@@ -2924,8 +2918,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.set_powergating_state = dm_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version dm_ip_block =
-{
+const struct amdgpu_ip_block_version dm_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_DCE,
 	.major = 1,
 	.minor = 0,
@@ -2982,9 +2975,12 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
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
@@ -3248,6 +3244,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 		process_count < max_process_count) {
 		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
 		u8 retry;
+
 		dret = 0;
 
 		process_count++;
@@ -3449,7 +3446,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 		aconnector = to_amdgpu_dm_connector(connector);
 		dc_link = aconnector->dc_link;
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 			int_params.irq_source = dc_link->irq_source_hpd;
 
@@ -3458,7 +3455,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					(void *) aconnector);
 		}
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
 
 			/* Also register for DP short pulse (hpd_rx). */
 			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -3484,7 +3481,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -3498,11 +3495,12 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
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
@@ -3510,7 +3508,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i+1 , 0);
+			dc_interrupt_to_irq_source(dc, i + 1, 0);
 
 		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
 
@@ -3566,7 +3564,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
-	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
 	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
@@ -3583,7 +3581,8 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
 	 *    coming from DC hardware.
 	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling. */
+	 *    for acknowledging and handling.
+	 */
 
 	/* Use VBLANK interrupt */
 	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
@@ -4032,7 +4031,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 }
 
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned *min, unsigned *max)
+				unsigned int *min, unsigned int *max)
 {
 	if (!caps)
 		return 0;
@@ -4052,7 +4051,7 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 					uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4065,7 +4064,7 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 				      uint32_t brightness)
 {
-	unsigned min, max;
+	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
@@ -4546,7 +4545,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
 	drm_atomic_private_obj_fini(&dm->atomic_obj);
-	return;
 }
 
 /******************************************************************************
@@ -5272,6 +5270,7 @@ static bool adjust_colour_depth_from_display_info(
 {
 	enum dc_color_depth depth = timing_out->display_color_depth;
 	int normalized_clk;
+
 	do {
 		normalized_clk = timing_out->pix_clk_100hz / 10;
 		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
@@ -5487,6 +5486,7 @@ create_fake_sink(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
+
 	sink_init_data.link = aconnector->dc_link;
 	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
 
@@ -5610,7 +5610,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		return &aconnector->freesync_vid_base;
 
 	/* Find the preferred mode */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		if (m->type & DRM_MODE_TYPE_PREFERRED) {
 			m_pref = m;
 			break;
@@ -5634,7 +5634,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 	 * For some monitors, preferred mode is not the mode with highest
 	 * supported refresh rate.
 	 */
-	list_for_each_entry (m, list_head, head) {
+	list_for_each_entry(m, list_head, head) {
 		current_refresh  = drm_mode_vrefresh(m);
 
 		if (m->hdisplay == m_pref->hdisplay &&
@@ -5905,7 +5905,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 * This may not be an error, the use case is when we have no
 		 * usermode calls to reset and set mode upon hotplug. In this
 		 * case, we call set mode ourselves to restore the previous mode
-		 * and the modelist may not be filled in in time.
+		 * and the modelist may not be filled in time.
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
@@ -5929,9 +5929,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
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
@@ -6593,6 +6593,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 
 	if (!state->duplicated) {
 		int max_bpc = conn_state->max_requested_bpc;
+
 		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
 			  aconnector->force_yuv420_output;
 		color_depth = convert_color_depth_from_display_info(connector,
@@ -6913,7 +6914,7 @@ static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 {
 	struct drm_display_mode *m;
 
-	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
+	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
 		if (drm_mode_equal(m, mode))
 			return true;
 	}
@@ -7216,7 +7217,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	link->priv = aconnector;
 
-	DRM_DEBUG_DRIVER("%s()\n", __func__);
 
 	i2c = create_i2c(link->ddc, link->link_index, &res);
 	if (!i2c) {
@@ -7853,8 +7853,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			 * DRI3/Present extension with defined target_msc.
 			 */
 			last_flip_vblank = amdgpu_get_vblank_counter_kms(pcrtc);
-		}
-		else {
+		} else {
 			/* For variable refresh rate mode only:
 			 * Get vblank of last completed flip to avoid > 1 vrr
 			 * flips per video frame by use of throttling, but allow
@@ -8181,8 +8180,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dc_resource_state_copy_construct_current(dm->dc, dc_state);
 	}
 
-	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
-				       new_crtc_state, i) {
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -8205,9 +8204,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		drm_dbg_state(state->dev,
-			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-			"connectors_changed:%d\n",
+			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 			acrtc->crtc_id,
 			new_crtc_state->enable,
 			new_crtc_state->active,
@@ -8692,8 +8689,8 @@ static int do_aquire_global_lock(struct drm_device *dev,
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done "
-				  "timed out\n", crtc->base.id, crtc->name);
+			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
+				  crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
 	}
@@ -8778,7 +8775,8 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 	return false;
 }
 
-static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
+static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
+{
 	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
@@ -8901,9 +8899,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		goto skip_modeset;
 
 	drm_dbg_state(state->dev,
-		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
-		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
-		"connectors_changed:%d\n",
+		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
 		acrtc->crtc_id,
 		new_crtc_state->enable,
 		new_crtc_state->active,
@@ -8932,8 +8928,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
 			DRM_DEBUG_DRIVER(
-				"Mode change not required for front porch change, "
-				"setting mode_changed to %d",
+				"Mode change not required for front porch change, setting mode_changed to %d",
 				new_crtc_state->mode_changed);
 
 			set_freesync_fixed_config(dm_new_crtc_state);
@@ -8945,9 +8940,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			struct drm_display_mode *high_mode;
 
 			high_mode = get_highest_refresh_rate_mode(aconnector, false);
-			if (!drm_mode_equal(&new_crtc_state->mode, high_mode)) {
+			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
 				set_freesync_fixed_config(dm_new_crtc_state);
-			}
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -9115,6 +9109,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
 		struct amdgpu_framebuffer *old_afb, *new_afb;
+
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
 
@@ -9213,11 +9208,12 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
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
@@ -9430,12 +9426,12 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
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
@@ -9481,6 +9477,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 	struct drm_connector_state *conn_state, *old_conn_state;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	int i;
+
 	for_each_oldnew_connector_in_state(state, connector, old_conn_state, conn_state, i) {
 		if (!conn_state->crtc)
 			conn_state = old_conn_state;
@@ -9923,7 +9920,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 
 	/* Store the overall update type for use later in atomic check. */
-	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct dm_crtc_state *dm_new_crtc_state =
 			to_dm_crtc_state(new_crtc_state);
 
@@ -9945,7 +9942,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
 		DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
 	else
-		DRM_DEBUG_DRIVER("Atomic check failed with err: %d \n", ret);
+		DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
 
 	trace_amdgpu_dm_atomic_check_finish(state, ret);
 
-- 
2.34.1

