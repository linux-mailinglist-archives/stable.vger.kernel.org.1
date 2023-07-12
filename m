Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB32750F3D
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGLRGE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGLRGD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:06:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470F1BD5
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEnOHGpPkHHBNsM/GrS4SuVNjX7+gCVKPE1yykWUorzFRlr9TrlH2WjWoX9dyqrkZuR5cajH1h5sU5TDAb7w2xyfNjIsVWxHBZBBF2I67SxYVs7wGcywKwSaLg9oqtRmpErug1h9GF4KVjOpxc2WeK6dBls1KrRsM2Y6OYeN/1daC25LQK6djZP7wHSbgypQM3dOpcx/TN7eH7ta1iIditFR5eKrmX9n6CpGdvWoVP5CwXjWYD6kVYU1yDGYE8RN9wn6skkx8qlOG2wneNOPE6XAgA3wD41rRDJzEIoSkvMnH6PtN62bGes5zvM6yHrT9CpTwDC/La01KTdlwSTj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGIHqRWTLNAlHe6hTw4p4gzMnhuizes3iwiNusUz9/o=;
 b=P3xP8fNxrjaYvWUW/5RcjAI41amcIRcjPu9qTtgkOxXLoQxwrYx3xL/w+MRbD5wzy1xvUQk1qG0iClsldC2grtZN0Wxq1wKQpa/PwvLephyYj6dnA9gj6bsoNEN8dLto1bRAlyFxa1EGl5u98Y+GR1D5+MJsdl0RBxm34/lVK6Qw2ciwn5dPo5MQGE3SYSXPXFvpghUfJCyi24kl77QatnJ+RSb5Ri4V+etBesYvZaqrmWIlWwtqHHskwSxQf8yjiYQnWxVEed4mZJ6X5BrSzXZ1V/aQaHz5F974gE7l/aFGVsxVxwr+WDml7n4MZGuKmKWSFouIjWTRqr9y/Cr6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGIHqRWTLNAlHe6hTw4p4gzMnhuizes3iwiNusUz9/o=;
 b=TAPYFxT6DrQpYC3FlQciQ3CJhY9U8VZtH0+bVfLtQMYpZ1YAdNoNMZ1tmq/HH/Obgp+9WCRZokSlz4JNaOScpPIg8m1awYavQev+g483JzJ3ZkSOjfb6/TdjtxWFJ3mhGKmwNC4xFSNxv7LxRxtf0tbcysTthXjbVdJnFHDErZo=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Wed, 12 Jul
 2023 17:05:57 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::86) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:05:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:05:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:05:57 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:05:54 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <haoping.liu@amd.com>
CC:     Wayne Lin <wayne.lin@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Jerry Zuo <jerry.zuo@amd.com>
Subject: [PATCH 04/33] drm/amd/display: Add polling method to handle MST reply packet
Date:   Thu, 13 Jul 2023 01:05:07 +0800
Message-ID: <20230712170536.3398144-5-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
References: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2480c9-9ea6-44c3-78be-08db82fa42b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2OYjHmhnKVQStslA5rb/7KNpSwUcSSh0AGL+8UgAyh1+Fgribu+CzyMLwRwZ39jJohjfGFT3OkkJ1/oZTndQA53LgB2eYCaxEZ/CsttuaDr55EL51RBdqSHVyeEm7u9ID2ZcQMpZbDlAKOc7V3k1l2chmx1MKETeYGGVRKhFuND5wpt/9CzFZLELDDd7kmzmpAT3XlQVa6K2Uca/+TPC7lg3jvdqt89ArBES9poD7JsPPGe9Yg60Mpv12+Tvc1idFbA/y9xLuFoXiKN3RZ24Hozt/KSxmkN5ntUjz7nYwDbrrctuDNLnP0/1NNEnmtJnyRM6gsG9fBoEWy67SulDQRWk7J6105LfItKV2C6o5VmBqH/7QKm+c+HhLXR/e5JnlwSoXLiCmzEkoQbkswXY1QiD78PcMnHGgnyd0A62a7Lg0xC9XayhOv3xwvQCAJ1YDqP9qVO4bKsrqArMR/VvhC70XcaDP5VqacMe6vpsngJZ2IPYLq9t1PyJhtfvGzdc/yw/aOeb3YdpNvpXBUjh3SQId6OdRkwWArvFrpODn16AXgmbmLZ0neTIvhZvW00kgJB+gYkeHVBZmaqOSCO665ptZCz07WMPpC+majsRBOeRKWxgpscUp3v7lbgAIZ8Kix76qqCURa4fOXMyE3Pq9DKyn4kCTYcwRr+tNExn84/NlG7K9u9E1ZSMUdJNjbYNL+4tp1mHwvGBlE3Lt/U5vNOf0pLm0eWjuWukJgsMPxuncewACyUz3LIX5mAR8oe2yAHJKYhDKPcb3gquQBdUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(336012)(186003)(1076003)(8676002)(6862004)(8936002)(26005)(5660300002)(7696005)(30864003)(40460700003)(41300700001)(37006003)(86362001)(6200100001)(2616005)(54906003)(40480700001)(316002)(81166007)(426003)(2906002)(83380400001)(4326008)(356005)(70206006)(47076005)(36860700001)(70586007)(36756003)(6666004)(82310400005)(478600001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:05:57.5146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2480c9-9ea6-44c3-78be-08db82fa42b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wayne Lin <wayne.lin@amd.com>

[Why]
Specific TBT4 dock doesn't send out short HPD to notify source
that IRQ event DOWN_REP_MSG_RDY is set. Which violates the spec
and cause source can't send out streams to mst sinks.

[How]
To cover this misbehavior, add an additional polling method to detect
DOWN_REP_MSG_RDY is set. HPD driven handling method is still kept.
Just hook up our handler to drm mgr->cbs->poll_hpd_irq().

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 117 +++++-------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 ++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 110 ++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  11 ++
 4 files changed, 159 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 28f8ac6007fb..42fa632523a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1347,6 +1347,15 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	if (amdgpu_in_reset(adev))
 		goto skip;
 
+	if (offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
+		offload_work->data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+		dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_OR_UP_MSG_RDY_EVENT);
+		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
+		offload_work->offload_wq->is_handling_mst_msg_rdy_event = false;
+		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+		goto skip;
+	}
+
 	mutex_lock(&adev->dm.dc_lock);
 	if (offload_work->data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
 		dc_link_dp_handle_automated_test(dc_link);
@@ -3232,87 +3241,6 @@ static void handle_hpd_irq(void *param)
 
 }
 
-static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
-{
-	u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
-	u8 dret;
-	bool new_irq_handled = false;
-	int dpcd_addr;
-	int dpcd_bytes_to_read;
-
-	const int max_process_count = 30;
-	int process_count = 0;
-
-	const struct dc_link_status *link_status = dc_link_get_status(aconnector->dc_link);
-
-	if (link_status->dpcd_caps->dpcd_rev.raw < 0x12) {
-		dpcd_bytes_to_read = DP_LANE0_1_STATUS - DP_SINK_COUNT;
-		/* DPCD 0x200 - 0x201 for downstream IRQ */
-		dpcd_addr = DP_SINK_COUNT;
-	} else {
-		dpcd_bytes_to_read = DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI;
-		/* DPCD 0x2002 - 0x2005 for downstream IRQ */
-		dpcd_addr = DP_SINK_COUNT_ESI;
-	}
-
-	dret = drm_dp_dpcd_read(
-		&aconnector->dm_dp_aux.aux,
-		dpcd_addr,
-		esi,
-		dpcd_bytes_to_read);
-
-	while (dret == dpcd_bytes_to_read &&
-		process_count < max_process_count) {
-		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
-		u8 retry;
-
-		dret = 0;
-
-		process_count++;
-
-		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
-		/* handle HPD short pulse irq */
-		if (aconnector->mst_mgr.mst_state)
-			drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
-							esi,
-							ack,
-							&new_irq_handled);
-
-		if (new_irq_handled) {
-			/* ACK at DPCD to notify down stream */
-			for (retry = 0; retry < 3; retry++) {
-				ssize_t wret;
-
-				wret = drm_dp_dpcd_writeb(&aconnector->dm_dp_aux.aux,
-							  dpcd_addr + 1,
-							  ack[1]);
-				if (wret == 1)
-					break;
-			}
-
-			if (retry == 3) {
-				DRM_ERROR("Failed to ack MST event.\n");
-				return;
-			}
-
-			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
-			/* check if there is new irq to be handled */
-			dret = drm_dp_dpcd_read(
-				&aconnector->dm_dp_aux.aux,
-				dpcd_addr,
-				esi,
-				dpcd_bytes_to_read);
-
-			new_irq_handled = false;
-		} else {
-			break;
-		}
-	}
-
-	if (process_count == max_process_count)
-		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
-}
-
 static void schedule_hpd_rx_offload_work(struct hpd_rx_irq_offload_work_queue *offload_wq,
 							union hpd_irq_data hpd_irq_data)
 {
@@ -3374,7 +3302,23 @@ static void handle_hpd_rx_irq(void *param)
 	if (dc_link_dp_allow_hpd_rx_irq(dc_link)) {
 		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY ||
 			hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
-			dm_handle_mst_sideband_msg(aconnector);
+			bool skip = false;
+
+			/*
+			 * DOWN_REP_MSG_RDY is also handled by polling method
+			 * mgr->cbs->poll_hpd_irq()
+			 */
+			spin_lock(&offload_wq->offload_lock);
+			skip = offload_wq->is_handling_mst_msg_rdy_event;
+
+			if (!skip)
+				offload_wq->is_handling_mst_msg_rdy_event = true;
+
+			spin_unlock(&offload_wq->offload_lock);
+
+			if (!skip)
+				schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+
 			goto out;
 		}
 
@@ -3483,11 +3427,11 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 			amdgpu_dm_irq_register_interrupt(adev, &int_params,
 					handle_hpd_rx_irq,
 					(void *) aconnector);
-
-			if (adev->dm.hpd_rx_offload_wq)
-				adev->dm.hpd_rx_offload_wq[dc_link->link_index].aconnector =
-					aconnector;
 		}
+
+		if (adev->dm.hpd_rx_offload_wq)
+			adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
+				aconnector;
 	}
 }
 
@@ -7300,6 +7244,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->as_type = ADAPTIVE_SYNC_TYPE_NONE;
 	memset(&aconnector->vsdb_info, 0, sizeof(aconnector->vsdb_info));
 	mutex_init(&aconnector->hpd_lock);
+	mutex_init(&aconnector->handle_mst_msg_ready);
 
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4561f55afa99..9fb5bb3a75a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -194,6 +194,11 @@ struct hpd_rx_irq_offload_work_queue {
 	 * we're handling link loss
 	 */
 	bool is_handling_link_loss;
+	/**
+	 * @is_handling_mst_msg_rdy_event: Used to prevent inserting mst message
+	 * ready event when we're already handling mst message ready event
+	 */
+	bool is_handling_mst_msg_rdy_event;
 	/**
 	 * @aconnector: The aconnector that this work queue is attached to
 	 */
@@ -638,6 +643,8 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *mst_output_port;
 	struct amdgpu_dm_connector *mst_root;
 	struct drm_dp_aux *dsc_aux;
+	struct mutex handle_mst_msg_ready;
+
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
 	struct amdgpu_i2c_adapter *i2c;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 95eefa6b4f2f..1d343f16e5b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -620,8 +620,118 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	return connector;
 }
 
+void dm_handle_mst_sideband_msg_ready_event(
+	struct drm_dp_mst_topology_mgr *mgr,
+	enum mst_msg_ready_type msg_rdy_type)
+{
+	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
+	uint8_t dret;
+	bool new_irq_handled = false;
+	int dpcd_addr;
+	uint8_t dpcd_bytes_to_read;
+	const uint8_t max_process_count = 30;
+	uint8_t process_count = 0;
+	u8 retry;
+	struct amdgpu_dm_connector *aconnector =
+			container_of(mgr, struct amdgpu_dm_connector, mst_mgr);
+
+
+	const struct dc_link_status *link_status = dc_link_get_status(aconnector->dc_link);
+
+	if (link_status->dpcd_caps->dpcd_rev.raw < 0x12) {
+		dpcd_bytes_to_read = DP_LANE0_1_STATUS - DP_SINK_COUNT;
+		/* DPCD 0x200 - 0x201 for downstream IRQ */
+		dpcd_addr = DP_SINK_COUNT;
+	} else {
+		dpcd_bytes_to_read = DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI;
+		/* DPCD 0x2002 - 0x2005 for downstream IRQ */
+		dpcd_addr = DP_SINK_COUNT_ESI;
+	}
+
+	mutex_lock(&aconnector->handle_mst_msg_ready);
+
+	while (process_count < max_process_count) {
+		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
+
+		process_count++;
+
+		dret = drm_dp_dpcd_read(
+			&aconnector->dm_dp_aux.aux,
+			dpcd_addr,
+			esi,
+			dpcd_bytes_to_read);
+
+		if (dret != dpcd_bytes_to_read) {
+			DRM_DEBUG_KMS("DPCD read and acked number is not as expected!");
+			break;
+		}
+
+		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
+
+		switch (msg_rdy_type) {
+		case DOWN_REP_MSG_RDY_EVENT:
+			/* Only handle DOWN_REP_MSG_RDY case*/
+			esi[1] &= DP_DOWN_REP_MSG_RDY;
+			break;
+		case UP_REQ_MSG_RDY_EVENT:
+			/* Only handle UP_REQ_MSG_RDY case*/
+			esi[1] &= DP_UP_REQ_MSG_RDY;
+			break;
+		default:
+			/* Handle both cases*/
+			esi[1] &= (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
+			break;
+		}
+
+		if (!esi[1])
+			break;
+
+		/* handle MST irq */
+		if (aconnector->mst_mgr.mst_state)
+			drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
+						 esi,
+						 ack,
+						 &new_irq_handled);
+
+		if (new_irq_handled) {
+			/* ACK at DPCD to notify down stream */
+			for (retry = 0; retry < 3; retry++) {
+				ssize_t wret;
+
+				wret = drm_dp_dpcd_writeb(&aconnector->dm_dp_aux.aux,
+							  dpcd_addr + 1,
+							  ack[1]);
+				if (wret == 1)
+					break;
+			}
+
+			if (retry == 3) {
+				DRM_ERROR("Failed to ack MST event.\n");
+				return;
+			}
+
+			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
+
+			new_irq_handled = false;
+		} else {
+			break;
+		}
+	}
+
+	mutex_unlock(&aconnector->handle_mst_msg_ready);
+
+	if (process_count == max_process_count)
+		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
+}
+
+static void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
+{
+	dm_handle_mst_sideband_msg_ready_event(mgr, DOWN_REP_MSG_RDY_EVENT);
+}
+
 static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 	.add_connector = dm_dp_add_mst_connector,
+	.poll_hpd_irq = dm_handle_mst_down_rep_msg_ready,
 };
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 1e4ede1e57ab..37c820ab0fdb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -49,6 +49,13 @@
 #define PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B	1031
 #define PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B	1000
 
+enum mst_msg_ready_type {
+	NONE_MSG_RDY_EVENT = 0,
+	DOWN_REP_MSG_RDY_EVENT = 1,
+	UP_REQ_MSG_RDY_EVENT = 2,
+	DOWN_OR_UP_MSG_RDY_EVENT = 3
+};
+
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 
@@ -61,6 +68,10 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 void
 dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev);
 
+void dm_handle_mst_sideband_msg_ready_event(
+	struct drm_dp_mst_topology_mgr *mgr,
+	enum mst_msg_ready_type msg_rdy_type);
+
 struct dsc_mst_fairness_vars {
 	int pbn;
 	bool dsc_enabled;
-- 
2.34.1

