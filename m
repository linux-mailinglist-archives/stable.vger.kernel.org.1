Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1471749C
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjEaEBo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbjEaEB1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:01:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3F125
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkToVxVLM0RjgeFj8/zNEjEy5e1TdJu8hlIac4jnC63PvmP1d6ZmkFviqEQ4kp/CDZXxqr1HIqU2CvFqV7+kmNwlCAoZfKu++AvHyyxGiTQwPHjqysYEi+jf6bqwQAMM8wZ7IRNOt3j5O9O4ZXn2UDyiLnsT/HV7lrl00XNShBEq8aTR4QD97G3O4nghTSlEvNl7zczrgrX3/5fnjXGT9P09x4SFrIRnFkgjj5/XB5Iq+P/Lcsj4d0Nymis9bHV7gk0qstP1EGGHPXP8S3iTzPA8K0MnHxT8wCRpbjjcYuiS7yuSic1LN2/zjgE+cCjkm6QykVuOU1eplZvGn4HN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3SabYrq7W/KSdqgh1h0lbbKit5Cu5AHpkaIXa1POAU=;
 b=eGumEin3YWzKDjQb37gdEpu7dg+UBEplZxGdjAsiluKHHTsakyk+Gvfdb5J7ywAmXmZ1Wuv7J+FTpKqs7aGoD32fY5Fvf6xyMF83BNrDrSBIK/WxP8CsvTUsIzG0uVefmXrg7OaSYupWUFGqU7kP0JujaBD3DmsYeTOqEh3GOPDR1U3RII6Gc1errIPvFkQEYM1l6fFIDryON5wxEbDyxQvdea3ANws8YpPiv5M7UDOsnTKApvxKGU+mRU8Fsw/9p30WkpU4S49PxWwnzg0D7uNTERCz8vBwD23ClybHWk0QC9gv0UgLuVwjfQ2ojEp3gkEfDM5u6g+AeONtRDq1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3SabYrq7W/KSdqgh1h0lbbKit5Cu5AHpkaIXa1POAU=;
 b=uGAF8JVwUnTeErr7wdN8+5RFEdoc66C+r4CwAmUKdODCfu5fHKnabbLkHZPGdN/lR+Vzh7lqVL0S/gos54qvaHSuNk20O5FmabpN8vwXpi7DCZyL72/2AlERa0zvndzItyLiPP+ZwXeXkFpzeyUb+4/bdZqTGgZhkEkKZzeIsf8=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 04:01:20 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::fc) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:01:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:01:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 23:00:44 -0500
From:   Wayne Lin <Wayne.Lin@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <lyude@redhat.com>, <ville.syrjala@linux.intel.com>,
        <jani.nikula@intel.com>, <imre.deak@intel.com>,
        <harry.wentland@amd.com>, <jerry.zuo@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/dp_mst: Clear MSG_RDY flag before sending new message
Date:   Wed, 31 May 2023 12:00:27 +0800
Message-ID: <20230531040027.3457841-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ac8454-752b-4108-e285-08db618bb0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SATE/TkoTKOLJtBNZuIUhv97eh70jM9hmbVLqBGyNdmzOMRFPZfEaLVHD8nO35iRSZj3fzJFriqSVU9j+5kmuZ75utvdkIOHKN5SE0g2/dXMTuq0p8C0aH5uZ8yJORmA78hzoCNxTNc+ojo8vC+VXDlYX1uRB9i2a+7VNAdRrFHIHz/Wdme4kVS8vnlDuwTdGGu94cyKim7rExR1fMPBkRt4CuMJjJGfica4tV4Y3b9yazY2d3dHmI/6d7Y03FAb0MzAIUiZoR98ND6wcRDhPhRVdoiIqBvZJ9QZDwJej6Yq1EdogNuL1SXqd7ePe57q9+t1Js1cFhsud1HHzVZN2KHIrU7PV8UTv7n0KK3pQJC69uGMUsm9716hLM5/dGQ0IzEFT3si0vB6qh7GZiiFu9d8pg3LLnXI4tqrFNTxg6xaKY4Nea7OALaY2WL6jIULI/WVQ3l+/OIvc1m49v6OZL5iQMqf34irtVmzuvyPAgxrs0SPMKblFkMZHMu3Xb9PyNnjQlWQ3OeqceGiXI8KtQ5naV3O+fe6AtV/+994xD/SghuKMaiExPDP1SpIhgQ1Q+F3aPhX0CdLleQvE1yWBpOM4lo7tWRlPL5Snm/bhV/tRdS5odW9dOpnb+TAPz7l3tmR7fDivMNJedpfMuK3E+nY5j3b0Cr/Cd07TpzftW7af3bkKyRIoD1eYHZa4TLfHVQXQm/eM+yNEAiOLiufKzbJt5vyol7BwTE9CV7wbx1yS3Vkxihtc3DB1eAOYwkCaIkhQ3XLpvms+bIx3IWMfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(7696005)(41300700001)(86362001)(40480700001)(4326008)(40460700003)(6916009)(6666004)(316002)(70206006)(36756003)(70586007)(2616005)(5660300002)(36860700001)(15650500001)(186003)(81166007)(2906002)(1076003)(336012)(26005)(47076005)(426003)(83380400001)(54906003)(8936002)(356005)(478600001)(8676002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:01:19.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ac8454-752b-4108-e285-08db618bb0bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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

[Why]
The sequence for collecting down_reply from source perspective should
be:

Request_n->repeat (get partial reply of Request_n->clear message ready
flag to ack DPRX that the message is received) till all partial
replies for Request_n are received->new Request_n+1.

Now there is chance that drm_dp_mst_hpd_irq() will fire new down
request in the tx queue when the down reply is incomplete. Source is
restricted to generate interveleaved message transactions so we should
avoid it.

Also, while assembling partial reply packets, reading out DPCD DOWN_REP
Sideband MSG buffer + clearing DOWN_REP_MSG_RDY flag should be
wrapped up as a complete operation for reading out a reply packet.
Kicking off a new request before clearing DOWN_REP_MSG_RDY flag might
be risky. e.g. If the reply of the new request has overwritten the
DPRX DOWN_REP Sideband MSG buffer before source writing one to clear
DOWN_REP_MSG_RDY flag, source then unintentionally flushes the reply
for the new request. Should handle the up request in the same way.

[How]
Separete drm_dp_mst_hpd_irq() into 2 steps. After acking the MST IRQ
event, driver calls drm_dp_mst_hpd_irq_send_new_request() and might
trigger drm_dp_mst_kick_tx() only when there is no on going message
transaction.

Changes since v1:
* Reworked on review comments received
-> Adjust the fix to let driver explicitly kick off new down request
when mst irq event is handled and acked
-> Adjust the commit message

Changes since v2:
* Adjust the commit message
* Adjust the naming of the divided 2 functions and add a new input
  parameter "ack".
* Adjust code flow as per review comments.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Cc: stable@vger.kernel.org
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++-------
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 39 +++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_dp.c       |  7 ++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 12 ++++--
 include/drm/display/drm_dp_mst_helper.h       |  7 +++-
 5 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d5cec03eaa8d..597c3368bcfb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3236,6 +3236,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 {
 	u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
 	u8 dret;
+	u8 ack;
 	bool new_irq_handled = false;
 	int dpcd_addr;
 	int dpcd_bytes_to_read;
@@ -3265,34 +3266,36 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 		process_count < max_process_count) {
 		u8 retry;
 		dret = 0;
+		ack = 0;
 
 		process_count++;
 
 		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
 		/* handle HPD short pulse irq */
 		if (aconnector->mst_mgr.mst_state)
-			drm_dp_mst_hpd_irq(
-				&aconnector->mst_mgr,
-				esi,
-				&new_irq_handled);
+			drm_dp_mst_hpd_irq_handle_event(&aconnector->mst_mgr,
+							esi,
+							&ack,
+							&new_irq_handled);
 
 		if (new_irq_handled) {
 			/* ACK at DPCD to notify down stream */
-			const int ack_dpcd_bytes_to_write =
-				dpcd_bytes_to_read - 1;
-
 			for (retry = 0; retry < 3; retry++) {
-				u8 wret;
-
-				wret = drm_dp_dpcd_write(
-					&aconnector->dm_dp_aux.aux,
-					dpcd_addr + 1,
-					&esi[1],
-					ack_dpcd_bytes_to_write);
-				if (wret == ack_dpcd_bytes_to_write)
+				ssize_t wret;
+
+				wret = drm_dp_dpcd_writeb(&aconnector->dm_dp_aux.aux,
+							  dpcd_addr + 1,
+							  ack);
+				if (wret == 1)
 					break;
 			}
 
+			if (retry == 3) {
+				DRM_ERROR("Failed to ack MST event.\n");
+				return;
+			}
+
+			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
 			/* check if there is new irq to be handled */
 			dret = drm_dp_dpcd_read(
 				&aconnector->dm_dp_aux.aux,
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 38dab76ae69e..13165e764709 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4053,9 +4053,10 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 }
 
 /**
- * drm_dp_mst_hpd_irq() - MST hotplug IRQ notify
+ * drm_dp_mst_hpd_irq_handle_event() - MST hotplug IRQ handle MST event
  * @mgr: manager to notify irq for.
  * @esi: 4 bytes from SINK_COUNT_ESI
+ * @ack: flags of events to ack
  * @handled: whether the hpd interrupt was consumed or not
  *
  * This should be called from the driver when it detects a short IRQ,
@@ -4063,7 +4064,8 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
  * topology manager will process the sideband messages received as a result
  * of this.
  */
-int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled)
+int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr, const u8 *esi,
+				    u8 *ack, bool *handled)
 {
 	int ret = 0;
 	int sc;
@@ -4078,18 +4080,47 @@ int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handl
 	if (esi[1] & DP_DOWN_REP_MSG_RDY) {
 		ret = drm_dp_mst_handle_down_rep(mgr);
 		*handled = true;
+		*ack |= DP_DOWN_REP_MSG_RDY;
 	}
 
 	if (esi[1] & DP_UP_REQ_MSG_RDY) {
 		ret |= drm_dp_mst_handle_up_req(mgr);
 		*handled = true;
+		*ack |= DP_UP_REQ_MSG_RDY;
 	}
 
-	drm_dp_mst_kick_tx(mgr);
 	return ret;
 }
-EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
+EXPORT_SYMBOL(drm_dp_mst_hpd_irq_handle_event);
+
+/**
+ * drm_dp_mst_hpd_irq_send_new_request() - MST hotplug IRQ kick off new request
+ * @mgr: manager to notify irq for.
+ *
+ * This should be called from the driver when mst irq event is handled
+ * and acked. Note that new down request should only be sent when
+ * previous message transaction is completed. Source is not supposed to generate
+ * interleaved message transactions.
+ */
+void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct drm_dp_sideband_msg_tx *txmsg;
+	bool kick = true;
 
+	mutex_lock(&mgr->qlock);
+	txmsg = list_first_entry_or_null(&mgr->tx_msg_downq,
+					 struct drm_dp_sideband_msg_tx, next);
+	/* If last transaction is not completed yet*/
+	if (!txmsg ||
+	    txmsg->state == DRM_DP_SIDEBAND_TX_START_SEND ||
+	    txmsg->state == DRM_DP_SIDEBAND_TX_SENT)
+		kick = false;
+	mutex_unlock(&mgr->qlock);
+
+	if (kick)
+		drm_dp_mst_kick_tx(mgr);
+}
+EXPORT_SYMBOL(drm_dp_mst_hpd_irq_send_new_request);
 /**
  * drm_dp_mst_detect_port() - get connection status for an MST port
  * @connector: DRM connector for this port
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4bec8cd7979f..f24602887015 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4062,9 +4062,7 @@ intel_dp_mst_hpd_irq(struct intel_dp *intel_dp, u8 *esi, u8 *ack)
 {
 	bool handled = false;
 
-	drm_dp_mst_hpd_irq(&intel_dp->mst_mgr, esi, &handled);
-	if (handled)
-		ack[1] |= esi[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
+	drm_dp_mst_hpd_irq_handle_event(&intel_dp->mst_mgr, esi, &ack[1], &handled);
 
 	if (esi[1] & DP_CP_IRQ) {
 		intel_hdcp_handle_cp_irq(intel_dp->attached_connector);
@@ -4139,6 +4137,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 
 		if (!intel_dp_ack_sink_irq_esi(intel_dp, ack))
 			drm_dbg_kms(&i915->drm, "Failed to ack ESI\n");
+
+		if (ack[1] & (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY))
+			drm_dp_mst_hpd_irq_send_new_request(&intel_dp->mst_mgr);
 	}
 
 	return link_ok;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 9b6824f6b9e4..b2d9978e88a8 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1357,6 +1357,7 @@ nv50_mstm_service(struct nouveau_drm *drm,
 	bool handled = true, ret = true;
 	int rc;
 	u8 esi[8] = {};
+	u8 ack;
 
 	while (handled) {
 		rc = drm_dp_dpcd_read(aux, DP_SINK_COUNT_ESI, esi, 8);
@@ -1365,16 +1366,19 @@ nv50_mstm_service(struct nouveau_drm *drm,
 			break;
 		}
 
-		drm_dp_mst_hpd_irq(&mstm->mgr, esi, &handled);
+		ack = 0;
+		drm_dp_mst_hpd_irq_handle_event(&mstm->mgr, esi, &ack, &handled);
 		if (!handled)
 			break;
 
-		rc = drm_dp_dpcd_write(aux, DP_SINK_COUNT_ESI + 1, &esi[1],
-				       3);
-		if (rc != 3) {
+		rc = drm_dp_dpcd_writeb(aux, DP_SINK_COUNT_ESI + 1, ack);
+
+		if (rc != 1) {
 			ret = false;
 			break;
 		}
+
+		drm_dp_mst_hpd_irq_send_new_request(&mstm->mgr);
 	}
 
 	if (!ret)
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 32c764fb9cb5..40e855c8407c 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -815,8 +815,11 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);
 bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state);
 
-int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled);
-
+int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr,
+				    const u8 *esi,
+				    u8 *ack,
+				    bool *handled);
+void drm_dp_mst_hpd_irq_send_new_request(struct drm_dp_mst_topology_mgr *mgr);
 
 int
 drm_dp_mst_detect_port(struct drm_connector *connector,
-- 
2.37.3

