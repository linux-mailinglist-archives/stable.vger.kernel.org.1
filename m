Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783B2760241
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGXW04 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjGXW0z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3E10E3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbE2xADKCgyMPgjwc3FZC8xDPdCsOs1B9MN2GPM7LN0Bvwah10xhbCud9LqaQiVBLguM7D6jXa1QV588MTwkbvAZ9cAjMrrTXzaDEOLVxMlWaBbFcxqeWKOVafCXzAH0pn3u6sObQ4AvAZdzzR+pFChh4fgEZs0Ctu2PIPsfbZw4tCY1U3s6Tbd0eC2YqeDm35vy6i2fhCfB+9r+LTX4Ok851jBT4Y84gwjYSeEUHfo8BKSpzQYV94QsEinegW0f3ZFUixZ75EV/RGVfNziM/ZLwk5Cbx+JTARaxA8IW+qquFCIhHl31/lqMJyVLESSqlg+BD9/DPIaoWriPlFr8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvkEsNW5UgL/0BP3hlaTxSSmUCpyYFq7JVVNjDu/pEI=;
 b=aS+SdTg4Z+l+f07DFrTGpYt7ShvjtXpZ2T68wD6ArbXjLaTU+WXBo1wjA7pVNkf3y7AC75gzTC2Nh1JDI68MQ7xMEigAe8qwDbxw7zx+4i9La1PqeCwHBOl8abML+7Mey6oUO7ZkeIYzoPdoj29zsN/91k68WobB3Kw+nt9KS7Bfv1FoIAlr5dm2Lf+dYJXtL3QNNFllA1lwQkXWEqUKvrinFHr/p751zrMmwhlHomkBc1Uc+G5Ztp9w3Dotp5pcd4hTNuVn4SzaSBPkbvv+AampHvzTbkPT0UJTg29ZttaCgjoIV1XnsAYf2MLf7j1O1Q1qolIAy8OXGlKtd8p+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvkEsNW5UgL/0BP3hlaTxSSmUCpyYFq7JVVNjDu/pEI=;
 b=0YLVQECJ78R/GsTqD6qrLfOaf+DWmH89ODdUwK4703eQVB6dkODqXgB3iOWJGSvOCkzDkxLsUQqlYpyJheGBB770JoDi9GhHykGloxVOA7qWtbetfnkBGtBVxcApf3skINwbgkQXNUV9Q2bJIN21ddsSexKSsmwZSjIygXsOYdg=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 22:26:47 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::55) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 4/7] drm/amd/display: force connector state when bpc changes during compliance
Date:   Mon, 24 Jul 2023 17:26:35 -0500
Message-ID: <20230724222638.1477-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 40918ce7-6b05-4699-a45f-08db8c951126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOphyPXxHkP4unvFrppp8esAhlL+n/Jv4RehiJMywQyw9jdkAsprREbsRAlWWJWr3LAJ7zhzGVZLBvoJVa34vyhBE0KL0LaSOiqa9gm52HjdCLeAKJoM9Huv2b3JhwE6CNWicDWUB/cO6PWXoi60+4fd+sRPa/KhcawsHftlsGaWKFIAkrBtjNxlJmcLOgsUyvoQLTDzHf+2+p5WFSHdy38rMPC6+zRJ34TUHFzOCd4hqECW0b6ZXVSHiQjENHkeMfa44GlLIqSnaszIKEK3ruF/HcTgyfJ/4HFF2Sb6zTahV4qADAKWqCbEeHkpQ4rLGbfFekve3uw7m1ngWDF5OiV3Hf3gcwGa8PLUt6RQtQd+ZUHUmbwHEff05J8GmDWoNUg+b1gpEd1i5gqskMN7nATjtdPlgy80FW0ADaqX5iW185pPaft7o3fg0hwxEZeddyWhThRtN/lcxJZn2iwMj9+NCbJeoK9dTgFKEArjDOHxbcyh8LDR9z+tCc+H/UlC/lC0WXzzgJTj3UuSytI2PsVeCh2MC84f/3VYSR9m7d3S+cCKzeOBjR4xBvn3e9/c+idbKwQhg8lM2tLTjg6k1VUtX1wgkYvNo5DsSsE/JbzeAK0Q92aou5L6bGGnmM61dWmhhhoUvoIulKXEhlMW4X7jXXQi7VDCeVfjPpMUGUNToYJu0JpRFM/M4gMlNEKsl60PUFP29zXKEECs1q9fWXbtlLmL/N2Jg96KjJeakHBo4c6Zqv47rYQOVtNcAQllx3Gd7T9+H1aG3nFbIngbXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(1076003)(186003)(26005)(40460700003)(336012)(16526019)(44832011)(5660300002)(36756003)(36860700001)(8676002)(8936002)(81166007)(30864003)(2906002)(356005)(426003)(2616005)(47076005)(82740400003)(86362001)(40480700001)(6916009)(4326008)(316002)(70206006)(70586007)(478600001)(6666004)(7696005)(83380400001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:46.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40918ce7-6b05-4699-a45f-08db8c951126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
During DP DSC compliance tests, bpc requested would
change between sub-tests, which requires stream
to be recommited.

[How]
Force connector to disconnect and reconnect whenever
there is a bpc change in automated test.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 028c4ccfb8127255d60f8d9edde96cacf2958082)
Adjustments for headers that were moved around in later commits.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  55 ++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 125 ++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 139 +++---------------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   6 +
 5 files changed, 209 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1aa84c020e7f..5f85a1afa590 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -40,6 +40,9 @@
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
 #include "dc/inc/dc_link_ddc.h"
+#include "dpcd_defs.h"
+#include "dc/inc/link_dpcd.h"
+#include "link_service_types.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -1273,6 +1276,21 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
+static void force_connector_state(
+	struct amdgpu_dm_connector *aconnector,
+	enum drm_connector_force force_state)
+{
+	struct drm_connector *connector = &aconnector->base;
+
+	mutex_lock(&connector->dev->mode_config.mutex);
+	aconnector->base.force = force_state;
+	mutex_unlock(&connector->dev->mode_config.mutex);
+
+	mutex_lock(&aconnector->hpd_lock);
+	drm_kms_helper_connector_hotplug_event(connector);
+	mutex_unlock(&aconnector->hpd_lock);
+}
+
 static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
@@ -1281,6 +1299,9 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	struct amdgpu_device *adev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	unsigned long flags;
+	union test_response test_response;
+
+	memset(&test_response, 0, sizeof(test_response));
 
 	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
 	aconnector = offload_work->offload_wq->aconnector;
@@ -1305,8 +1326,24 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 		goto skip;
 
 	mutex_lock(&adev->dm.dc_lock);
-	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST)
+	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
 		dc_link_dp_handle_automated_test(dc_link);
+
+		if (aconnector->timing_changed) {
+			/* force connector disconnect and reconnect */
+			force_connector_state(aconnector, DRM_FORCE_OFF);
+			msleep(100);
+			force_connector_state(aconnector, DRM_FORCE_UNSPECIFIED);
+		}
+
+		test_response.bits.ACK = 1;
+
+		core_link_write_dpcd(
+		dc_link,
+		DP_TEST_RESPONSE,
+		&test_response.raw,
+		sizeof(test_response));
+	}
 	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
@@ -3076,6 +3113,10 @@ void amdgpu_dm_update_connector_after_detect(
 						    aconnector->edid);
 		}
 
+		aconnector->timing_requested = kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
+		if (!aconnector->timing_requested)
+			dm_error("%s: failed to create aconnector->requested_timing\n", __func__);
+
 		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
 		update_connector_ext_caps(aconnector);
@@ -3087,6 +3128,8 @@ void amdgpu_dm_update_connector_after_detect(
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		kfree(aconnector->timing_requested);
+		aconnector->timing_requested = NULL;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again on hotplug */
 		if (connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
@@ -3131,6 +3174,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	if (aconnector->fake_enable)
 		aconnector->fake_enable = false;
 
+	aconnector->timing_changed = false;
+
 	if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type))
 		DRM_ERROR("KMS: Failed to detect connector\n");
 
@@ -5896,6 +5941,14 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			stream, &mode, &aconnector->base, con_state, old_stream,
 			requested_bpc);
 
+	if (aconnector->timing_changed) {
+		DC_LOG_DEBUG("%s: overriding timing for automated test, bpc %d, changing to %d\n",
+				__func__,
+				stream->timing.display_color_depth,
+				aconnector->timing_requested->display_color_depth);
+		stream->timing = *aconnector->timing_requested;
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* SST DSC determination policy */
 	update_dsc_caps(aconnector, sink, stream, &dsc_caps);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ac26e917240b..bae36001fc17 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -31,6 +31,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_plane.h>
+#include "link_service_types.h"
 
 /*
  * This file contains the definition for amdgpu_display_manager
@@ -650,6 +651,10 @@ struct amdgpu_dm_connector {
 
 	/* Record progress status of mst*/
 	uint8_t mst_status;
+
+	/* Automated testing */
+	bool timing_changed;
+	struct dc_crtc_timing *timing_requested;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index db7744beed5f..9dc41f569a76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -38,6 +38,9 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_mst_types.h"
+#include "dpcd_defs.h"
+#include "dc/inc/core_types.h"
+#include "dc_link_dp.h"
 
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
@@ -1056,6 +1059,128 @@ void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 					 sizeof(new_downspread));
 }
 
+bool dm_helpers_dp_handle_test_pattern_request(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		union link_test_pattern dpcd_test_pattern,
+		union test_misc dpcd_test_params)
+{
+	enum dp_test_pattern test_pattern;
+	enum dp_test_pattern_color_space test_pattern_color_space =
+			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
+	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
+	enum dc_pixel_encoding requestPixelEncoding = PIXEL_ENCODING_UNDEFINED;
+	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream == NULL)
+			continue;
+
+		if (pipes[i].stream->link == link && !pipes[i].top_pipe &&
+			!pipes[i].prev_odm_pipe) {
+			pipe_ctx = &pipes[i];
+			break;
+		}
+	}
+
+	if (pipe_ctx == NULL)
+		return false;
+
+	switch (dpcd_test_pattern.bits.PATTERN) {
+	case LINK_TEST_PATTERN_COLOR_RAMP:
+		test_pattern = DP_TEST_PATTERN_COLOR_RAMP;
+	break;
+	case LINK_TEST_PATTERN_VERTICAL_BARS:
+		test_pattern = DP_TEST_PATTERN_VERTICAL_BARS;
+	break; /* black and white */
+	case LINK_TEST_PATTERN_COLOR_SQUARES:
+		test_pattern = (dpcd_test_params.bits.DYN_RANGE ==
+				TEST_DYN_RANGE_VESA ?
+				DP_TEST_PATTERN_COLOR_SQUARES :
+				DP_TEST_PATTERN_COLOR_SQUARES_CEA);
+	break;
+	default:
+		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
+	break;
+	}
+
+	if (dpcd_test_params.bits.CLR_FORMAT == 0)
+		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
+	else
+		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
+				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
+
+	switch (dpcd_test_params.bits.BPC) {
+	case 0: // 6 bits
+		requestColorDepth = COLOR_DEPTH_666;
+		break;
+	case 1: // 8 bits
+		requestColorDepth = COLOR_DEPTH_888;
+		break;
+	case 2: // 10 bits
+		requestColorDepth = COLOR_DEPTH_101010;
+		break;
+	case 3: // 12 bits
+		requestColorDepth = COLOR_DEPTH_121212;
+		break;
+	default:
+		break;
+	}
+
+	switch (dpcd_test_params.bits.CLR_FORMAT) {
+	case 0:
+		requestPixelEncoding = PIXEL_ENCODING_RGB;
+		break;
+	case 1:
+		requestPixelEncoding = PIXEL_ENCODING_YCBCR422;
+		break;
+	case 2:
+		requestPixelEncoding = PIXEL_ENCODING_YCBCR444;
+		break;
+	default:
+		requestPixelEncoding = PIXEL_ENCODING_RGB;
+		break;
+	}
+
+	if ((requestColorDepth != COLOR_DEPTH_UNDEFINED
+		&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth)
+		|| (requestPixelEncoding != PIXEL_ENCODING_UNDEFINED
+		&& pipe_ctx->stream->timing.pixel_encoding != requestPixelEncoding)) {
+		DC_LOG_DEBUG("%s: original bpc %d pix encoding %d, changing to %d  %d\n",
+				__func__,
+				pipe_ctx->stream->timing.display_color_depth,
+				pipe_ctx->stream->timing.pixel_encoding,
+				requestColorDepth,
+				requestPixelEncoding);
+		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
+		pipe_ctx->stream->timing.pixel_encoding = requestPixelEncoding;
+
+		dp_update_dsc_config(pipe_ctx);
+
+		aconnector->timing_changed = true;
+		/* store current timing */
+		if (aconnector->timing_requested)
+			*aconnector->timing_requested = pipe_ctx->stream->timing;
+		else
+			DC_LOG_ERROR("%s: timing storage failed\n", __func__);
+
+	}
+
+	dc_link_dp_set_test_pattern(
+		(struct dc_link *) link,
+		test_pattern,
+		test_pattern_color_space,
+		NULL,
+		NULL,
+		0);
+
+	return false;
+}
+
 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 {
        // TODO
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 24f1aba4ae13..c86d10e45b55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4264,124 +4264,6 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 		test_pattern_size);
 }
 
-static void dp_test_send_link_test_pattern(struct dc_link *link)
-{
-	union link_test_pattern dpcd_test_pattern;
-	union test_misc dpcd_test_params;
-	enum dp_test_pattern test_pattern;
-	enum dp_test_pattern_color_space test_pattern_color_space =
-			DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED;
-	enum dc_color_depth requestColorDepth = COLOR_DEPTH_UNDEFINED;
-	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
-	struct pipe_ctx *pipe_ctx = NULL;
-	int i;
-
-	memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
-	memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream == NULL)
-			continue;
-
-		if (pipes[i].stream->link == link && !pipes[i].top_pipe && !pipes[i].prev_odm_pipe) {
-			pipe_ctx = &pipes[i];
-			break;
-		}
-	}
-
-	if (pipe_ctx == NULL)
-		return;
-
-	/* get link test pattern and pattern parameters */
-	core_link_read_dpcd(
-			link,
-			DP_TEST_PATTERN,
-			&dpcd_test_pattern.raw,
-			sizeof(dpcd_test_pattern));
-	core_link_read_dpcd(
-			link,
-			DP_TEST_MISC0,
-			&dpcd_test_params.raw,
-			sizeof(dpcd_test_params));
-
-	switch (dpcd_test_pattern.bits.PATTERN) {
-	case LINK_TEST_PATTERN_COLOR_RAMP:
-		test_pattern = DP_TEST_PATTERN_COLOR_RAMP;
-	break;
-	case LINK_TEST_PATTERN_VERTICAL_BARS:
-		test_pattern = DP_TEST_PATTERN_VERTICAL_BARS;
-	break; /* black and white */
-	case LINK_TEST_PATTERN_COLOR_SQUARES:
-		test_pattern = (dpcd_test_params.bits.DYN_RANGE ==
-				TEST_DYN_RANGE_VESA ?
-				DP_TEST_PATTERN_COLOR_SQUARES :
-				DP_TEST_PATTERN_COLOR_SQUARES_CEA);
-	break;
-	default:
-		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
-	break;
-	}
-
-	if (dpcd_test_params.bits.CLR_FORMAT == 0)
-		test_pattern_color_space = DP_TEST_PATTERN_COLOR_SPACE_RGB;
-	else
-		test_pattern_color_space = dpcd_test_params.bits.YCBCR_COEFS ?
-				DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 :
-				DP_TEST_PATTERN_COLOR_SPACE_YCBCR601;
-
-	switch (dpcd_test_params.bits.BPC) {
-	case 0: // 6 bits
-		requestColorDepth = COLOR_DEPTH_666;
-		break;
-	case 1: // 8 bits
-		requestColorDepth = COLOR_DEPTH_888;
-		break;
-	case 2: // 10 bits
-		requestColorDepth = COLOR_DEPTH_101010;
-		break;
-	case 3: // 12 bits
-		requestColorDepth = COLOR_DEPTH_121212;
-		break;
-	default:
-		break;
-	}
-
-	switch (dpcd_test_params.bits.CLR_FORMAT) {
-	case 0:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
-		break;
-	case 1:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR422;
-		break;
-	case 2:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
-		break;
-	default:
-		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
-		break;
-	}
-
-
-	if (requestColorDepth != COLOR_DEPTH_UNDEFINED
-			&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth) {
-		DC_LOG_DEBUG("%s: original bpc %d, changing to %d\n",
-				__func__,
-				pipe_ctx->stream->timing.display_color_depth,
-				requestColorDepth);
-		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
-	}
-
-	dp_update_dsc_config(pipe_ctx);
-
-	dc_link_dp_set_test_pattern(
-			link,
-			test_pattern,
-			test_pattern_color_space,
-			NULL,
-			NULL,
-			0);
-}
-
 static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video)
 {
 	union audio_test_mode            dpcd_test_mode = {0};
@@ -4494,8 +4376,25 @@ void dc_link_dp_handle_automated_test(struct dc_link *link)
 		test_response.bits.ACK = 0;
 	}
 	if (test_request.bits.LINK_TEST_PATTRN) {
-		dp_test_send_link_test_pattern(link);
-		test_response.bits.ACK = 1;
+		union test_misc dpcd_test_params;
+		union link_test_pattern dpcd_test_pattern;
+
+		memset(&dpcd_test_pattern, 0, sizeof(dpcd_test_pattern));
+		memset(&dpcd_test_params, 0, sizeof(dpcd_test_params));
+
+		/* get link test pattern and pattern parameters */
+		core_link_read_dpcd(
+				link,
+				DP_TEST_PATTERN,
+				&dpcd_test_pattern.raw,
+				sizeof(dpcd_test_pattern));
+		core_link_read_dpcd(
+				link,
+				DP_TEST_MISC0,
+				&dpcd_test_params.raw,
+				sizeof(dpcd_test_params));
+		test_response.bits.ACK = dm_helpers_dp_handle_test_pattern_request(link->ctx, link,
+				dpcd_test_pattern, dpcd_test_params) ? 1 : 0;
 	}
 
 	if (test_request.bits.AUDIO_TEST_PATTERN) {
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index e3e5c39895a3..d0ad682fdde8 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -156,6 +156,12 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+bool dm_helpers_dp_handle_test_pattern_request(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		union link_test_pattern dpcd_test_pattern,
+		union test_misc dpcd_test_params);
+
 void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
-- 
2.34.1

