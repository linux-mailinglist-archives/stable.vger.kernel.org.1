Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88939750F54
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGLRMZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGLRMY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:12:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D81980
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvU/zzN0EHgRMu7g9aWCYibvmnicas+K4jdscrR6fWIiKPhFAacOiy9V0faFPbldW7UfbqbMts/boFPqm7y7GkSVNNtqLy4PeIcp/1nZfgB+8lakw88ehF44mv5u10YhdDY6RI/ICvKltEB6Ryd/XF+Qyn5LzcAtlIKOE780+fwM3399I3jcP7+2liTmdjANpuSHmO/zHGTSBidTpd+rpMMV7e7TY+Lva6LlqcR6jd3VrOclkiJe36CKklM7WYDGwXi4ri9mmEPoARTWJpI8lwkkQqyt5QZBaV88cMjE0i0R+e6l2pbrB6KMBLJH1KWLUIp76jxo/dV/XiqpqsDQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGIHqRWTLNAlHe6hTw4p4gzMnhuizes3iwiNusUz9/o=;
 b=BnLcjF4AEjzTp4zpXOsmsVvq21pHxGFmC48YJaga/pZnZFxikSx2xnCRoCVnZNWEItvWyriMInwzt8L007hnkIeDp0JjBYrSXv9MYHJZk/ZgH5zH7d0RkzcnVikyrQzwtSjACpNe+zWFDpfOrXA1FKRMUkjZFytWoNgPFmz5UDVoPt3y6VcQea8Q2GEMSZOCarqoyUxfUVJuqdwBsmepSTfa9NGmDKMbFtz5qbyWWLuqmf93Nn4ckr9jOU0Jk7nnDbrei4HCG3irflWB7oIOe/CNKtonChsd4Nq0b8Ze26z/wa4cCQwdI8Ym0GY8D1NBq99b1jAc5oso6/sA2sMP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGIHqRWTLNAlHe6hTw4p4gzMnhuizes3iwiNusUz9/o=;
 b=xPwYHdrvgSTK7Nx3mfBLAfm6/vyVbP9GC3zGjoAd11MabD3RBmgDeXsfn/HS6n8lpdphgq2P1gJY3OjdgnmVvQXRDLuGNXOMJFSkvu5cyQHoKlEnK1BDCiEJu90Yd8G2WjzlFHPxyJWq8WuiIWkpEMIRqNqnxta9cF+es1DnhmQ=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:12:18 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::e4) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jul
 2023 10:12:14 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:10 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Jerry Zuo <jerry.zuo@amd.com>,
        Alan Liu <haoping.liu@amd.com>
Subject: [PATCH 04/33] drm/amd/display: Add polling method to handle MST reply packet
Date:   Thu, 13 Jul 2023 01:11:08 +0800
Message-ID: <20230712171137.3398344-5-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: c34c910c-41e0-4c15-38c4-08db82fb25b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNVUVjB+GWgushBOLiZw6uFgeCfySvtFaSpNhTWwFjvJurPXuCBoCtsijmOiU+Pp1pdYR810cvmZhbTq6B4KzmJuss2VCTFWq1v/smCp87MgK7ye3n+mwhCwgwjldoDJvnO3ojwvEdXmIIpYBF6nPirt3lshdZ30Focey3MiNZx7H015onTFiJsidP+NhpR9sve0f8AsifWv4AxQvSamRgJvBzxiyE4q8ZNKBGZSs11f4yvllZ4GbVnK4BPOK83QCjLJHHpvh94BU6Na4qRinhnOH2vpFloT0o1DBgHyNPr+mclgTmirrisVFxmkg+AsJghfA8P1pHwRjgN4USkzkP9WzOd2j0DLC6yU2/lyp0IkvxebLAE2sYHdKLHAwCoJGCTjavkwcpXfognobQA0g4xT2TBvdnLKnFXCSfl+AvXy3L4G2MBwsKpBcsAj4EKA8YGDzZtdlBn4E/tMTj8NWifl53jWs/6XjPdq92aRMyjC5zD4n5PBx+WcQTYYKJUcCLZsgp5zAnY64QzZfCQ0TZLPAwMt62/Lb1ApupQCMXL4c8P4duHGA0vFsg1MK8ghGI78KfHex/uNjTraPOpWmVTwCIFVoXd52nCbtytRYniWIRvMAzysNn2P6Y2GOBFflmLiH7IwMZAAZdlejP1l29JVHoFmb7BStLPswRCYlMa3TTP5Zkm8kehnngQJ8wXe9YDAkiq2/dofChwrMt6c2ULE8dfDZigLmsVPQMABW/N7mQPjEOMJiQh0sZa7T4ply3gEH+3MBJTbe2MKFPBJnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(426003)(336012)(30864003)(36756003)(2616005)(2906002)(36860700001)(41300700001)(83380400001)(47076005)(186003)(40480700001)(26005)(1076003)(5660300002)(40460700003)(8936002)(8676002)(82740400003)(356005)(81166007)(54906003)(70586007)(70206006)(4326008)(7696005)(6916009)(86362001)(82310400005)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:18.3296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34c910c-41e0-4c15-38c4-08db82fb25b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

