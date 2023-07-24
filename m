Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB05760240
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 00:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGXW04 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 18:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjGXW0z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 18:26:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06961BC
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 15:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxFIsrLkDJ8WfHFilNk3IX/m9a4tRJu73dawWcckHxm1UlLUnKgXqUTJkA1leW3kuOoHk4t7WxJcJLnpTV/kWd65coUCnkWsGG//iJQlxkywfAv+Q+XlmaPqFXduY4zgke+GEcqpdjhcBY4PytBo+Ujf4ytb8yXrASF4ldV5c71h555UxiAHTCM06IIzBWHE0z/IMvlvVf5PYrk6g3HMqJnxjR0AouJF9yzWmgSe7vU0DRWjSvg5L6DjzdU4aSP/zyCT4dXMeluIMZawCEMjhqMPpWtIR2h3gSPxoXNIfkjstQFV71gUhWBHz13XpXBa++87rRcl6BphQzDONbu09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw4isqlEwAkahjckJO4Z+rB4UwlWialCBUH3Lil7Uec=;
 b=odlJDd1mbpvRjh7RqrpTX48uoUXJiwMUJ9CZBWYgDYUweWd+4tgCjqaJkuYMUreZ6VI1BzdSym/e2TEiKHtFls8EZR0vPXafDsMq7GNB8fQdo1WAygXO6KDmvmAXQQ4h8wjqf9lxZdgfjupmQg+V1BERmEDnuqw6OcXVKlPWl4e1W2tBaoPsD6QHb2MH+P9c4gO6WSQNMk6VoTh2Lz0bMSFqwS5HCU9raNwQt90zRz4hgim7DyHvl6LiQYky+ddq9207Aa/TJEbhu72xhoxLXp5ls2hiUQv9J2cQV3XZorPJj9pNl13xOUeudhnNJhCgvzBiiyCmoRKp32Co+yfFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw4isqlEwAkahjckJO4Z+rB4UwlWialCBUH3Lil7Uec=;
 b=t2HzK4Bko28F53TF8c02zkkE/vwwWVlu5F2E6f/7GVE8n8q41rML2yWO1h9X/1YlYLHn1CVssg1Gvg1CRVgvwerK78wK8ShnDtoqQ3Ehlbchq2EebiOGMNKJqGl1dDbSCNEHy0QUiP4AXHuDxN+3HiNtKabuZUGpATS1UNkPI1g=
Received: from BN0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:408:ea::25)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 22:26:48 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::9b) by BN0PR04CA0080.outlook.office365.com
 (2603:10b6:408:ea::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 22:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 22:26:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 17:26:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 7/7] drm/amd/display: Add polling method to handle MST reply packet
Date:   Mon, 24 Jul 2023 17:26:38 -0500
Message-ID: <20230724222638.1477-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 011d20ad-3556-4388-33d6-08db8c9511fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cKvym9cWnSELcxH9+iNeEXgWqJI47PV4FK0fs4VmQWRONwRV1juwJ2VhdmokmUSSEGlC9MpE738YXfzZlAxJ+o4MMWyANmNBWSAAsDi0lPzx66sz4vpg1mQue4WeP/sGOmgbs5KI9Ekof4+a9yEhSngbPZiKSd8DqURI4EB4MoSdBea96bhri9VP5X34kHPDHPVfwC3FRyNHvwERlHckd1pwyj3HzIbLyxwCHmfZAQ9b65d73Eid4q1lnlDT+dMd/9pJLBqyI3LPL3ink8Aewg3dIJ9PNB7IX/j1fcxDzQgxTzJykR8fYLUjfHikMc6vkdnI24dv+RtOTXPPuy6vcLX9UolfQ7pCaP8e5Q/dWX8W2KTxd0TSEE+siGy0Ks9ipAWwVNNPO+ThXJjcsi61nvcmy0VNn6dEsD6qFsXv0sBOHQDv1XFJDIdWGqF4jPP2pM/mA2JrBFKdKNAyGEEvz58zuC9JdoM0LLzDJhpi9TdCjBuv+yqh6nbYlbeI1vYurEAYCuDGxTiP0TjF/QK8s1IPn7C+/Q/t+YQAtlpYMYw26W94w2MdV9LxH5AQsqJnr8aQ7c4zESTZRH+iR4bvp/1WNQf79q3UbfgrrudV6oD6GfBUcYCLzseIZjtkxn7xWaIeSb2TubYboAhFfYr8mIWO+GQkKqcUKcsdJSgY5IGeg+RO3f1kLweTbq1D+bxtTV2JKrzYonxLLEP7OPX1kXg9/vnZOlmkYtWGv5y8zJ3fMzRuT62gSVKOW1aKvNyAnBDSfGMPZU4ae6jwO6Kyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(44832011)(2906002)(40480700001)(81166007)(82740400003)(356005)(16526019)(83380400001)(426003)(47076005)(186003)(2616005)(336012)(36860700001)(1076003)(26005)(40460700003)(86362001)(5660300002)(8936002)(36756003)(30864003)(478600001)(6666004)(7696005)(70586007)(4326008)(8676002)(70206006)(6916009)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 22:26:48.2410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011d20ad-3556-4388-33d6-08db8c9511fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4f6d9e38c4d244ad106eb9ebd8c0e1215e866f35)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 117 +++++-------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 ++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 110 ++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  11 ++
 4 files changed, 159 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e64e1ed46faa..4875466340c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1325,6 +1325,15 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
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
@@ -3229,87 +3238,6 @@ static void handle_hpd_irq(void *param)
 
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
@@ -3371,7 +3299,23 @@ static void handle_hpd_rx_irq(void *param)
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
 
@@ -3482,11 +3426,11 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
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
 
@@ -7082,6 +7026,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->hpd.hpd = AMDGPU_HPD_NONE; /* not used */
 	aconnector->audio_inst = -1;
 	mutex_init(&aconnector->hpd_lock);
+	mutex_init(&aconnector->handle_mst_msg_ready);
 
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index bae36001fc17..2c9a33c80c81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -193,6 +193,11 @@ struct hpd_rx_irq_offload_work_queue {
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
@@ -614,6 +619,8 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *port;
 	struct amdgpu_dm_connector *mst_port;
 	struct drm_dp_aux *dsc_aux;
+	struct mutex handle_mst_msg_ready;
+
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
 	struct amdgpu_i2c_adapter *i2c;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 994a37003217..05708684c9f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -590,8 +590,118 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
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

