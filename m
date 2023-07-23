Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2075E245
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGWOGG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWOGF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F83D12B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8AB360BB8
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E9C433C7;
        Sun, 23 Jul 2023 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690121163;
        bh=LYoejTGW++hMngU3JMMroNZ53ZuYQp/FiPYC9F9oU+U=;
        h=Subject:To:Cc:From:Date:From;
        b=AvparYkyRAVYXbk20ktfi94hazLU7cFRHshfeu/QkrU6mYuLxk9bfgXdy36dgNvkA
         9x5acU9EI0+yskZ0IeITUKaeM/uTdz3ymNdNg4AIvCAc0zdvA8OWWIxt7bQK8/Fys8
         YR3L20Lue7cLQKapoF2hgZKns008niX5YLyxh65Q=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add polling method to handle MST reply" failed to apply to 6.1-stable tree
To:     wayne.lin@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, haoping.liu@amd.com, jerry.zuo@amd.com,
        mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:05:53 +0200
Message-ID: <2023072352-yen-rancidity-83a1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4f6d9e38c4d244ad106eb9ebd8c0e1215e866f35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072352-yen-rancidity-83a1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4f6d9e38c4d2 ("drm/amd/display: Add polling method to handle MST reply packet")
87279fdf5ee0 ("drm/amd/display: Clean up errors & warnings in amdgpu_dm.c")
72f1de49ffb9 ("drm/dp_mst: Clear MSG_RDY flag before sending new message")
2792f98cdb1c ("drm/amd/display: Take FEC Overhead into Timeslot Calculation")
54c7b715b5ef ("drm/amd/display: Add DSC Support for Synaptics Cascaded MST Hub")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
0078c924e733 ("drm/amd/display: move eDP panel control logic to link_edp_panel_control")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
d144b40a4833 ("drm/amd/display: move dc_link_dpia logic to link_dp_dpia")
a28d0bac0956 ("drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd")
a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc")
4370f72e3845 ("drm/amd/display: refactor hpd logic from dc_link to link_hpd")
0e8cf83a2b47 ("drm/amd/display: allow hpo and dio encoder switching during dp retrain test")
7462475e3a06 ("drm/amd/display: move dccg programming from link hwss hpo dp to hwss")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f6d9e38c4d244ad106eb9ebd8c0e1215e866f35 Mon Sep 17 00:00:00 2001
From: Wayne Lin <wayne.lin@amd.com>
Date: Wed, 9 Mar 2022 17:05:05 +0800
Subject: [PATCH] drm/amd/display: Add polling method to handle MST reply
 packet

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

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 948d61845efd..0fa739fd6a9c 100644
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
 
@@ -7296,6 +7240,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
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
index 46d0a8f57e55..888e80f498e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -619,8 +619,118 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
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

