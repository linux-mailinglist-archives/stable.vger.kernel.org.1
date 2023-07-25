Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19C761334
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjGYLIx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjGYLIj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914171FC4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 177A761648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C98C433C8;
        Tue, 25 Jul 2023 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283222;
        bh=haXr1Mj2DtYcfgySi85B1H6aVU+MDnD5K/bLHinuoE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPSMcM1ozOWj6RQNZTp4sQlKxP6vq3+bhi/jZVI6oitMZq9HyLWJinWxZY1I1gnWN
         vNyoQGFAfUYboChK/HtW41H9xkS9kvcJ0E+UWcUrtqC5f9RSOwd4Qh+Gv0zZz1fkUT
         T0N/dlt3azzLeTgm9MOdRYRc7XMoiy6FjocJ0Vfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 182/183] drm/amd/display: fix linux dp link lost handled only one time
Date:   Tue, 25 Jul 2023 12:46:50 +0200
Message-ID: <20230725104514.280632535@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Hersen Wu <hersenxs.wu@amd.com>

commit e322843e5e33e72ff218d661f3d15ff9c9f2f1b5 upstream.

[Why]
linux amdgpu defer handle link lost irq. dm add handle
request to irq work queue for the first irq of link lost.
if link training fails for link lost handle, link will not
be enabled anymore.

[How]
allow adding handle request of link lost to work queue
before running dp link training for link lost.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Modified due to not having
  c5a31f178e352 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
  until kernel 6.3-rc1.]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   24 +++++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c  |    2 -
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h   |    4 +++
 3 files changed, 26 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1346,10 +1346,28 @@ static void dm_handle_hpd_rx_offload_wor
 	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			hpd_rx_irq_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
-		dc_link_dp_handle_link_loss(dc_link);
+		/* offload_work->data is from handle_hpd_rx_irq->
+		 * schedule_hpd_rx_offload_work.this is defer handle
+		 * for hpd short pulse. upon here, link status may be
+		 * changed, need get latest link status from dpcd
+		 * registers. if link status is good, skip run link
+		 * training again.
+		 */
+		union hpd_irq_data irq_data;
+
+		memset(&irq_data, 0, sizeof(irq_data));
+
+		/* before dc_link_dp_handle_link_loss, allow new link lost handle
+		 * request be added to work queue if link lost at end of dc_link_
+		 * dp_handle_link_loss
+		 */
 		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
 		offload_work->offload_wq->is_handling_link_loss = false;
 		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+
+		if ((read_hpd_rx_irq_data(dc_link, &irq_data) == DC_OK) &&
+			hpd_rx_irq_check_link_loss_status(dc_link, &irq_data))
+			dc_link_dp_handle_link_loss(dc_link);
 	}
 	mutex_unlock(&adev->dm.dc_lock);
 
@@ -3324,7 +3342,7 @@ static void handle_hpd_rx_irq(void *para
 	union hpd_irq_data hpd_irq_data;
 	bool link_loss = false;
 	bool has_left_work = false;
-	int idx = aconnector->base.index;
+	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
@@ -3466,7 +3484,7 @@ static void register_hpd_handlers(struct
 					(void *) aconnector);
 
 			if (adev->dm.hpd_rx_offload_wq)
-				adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
+				adev->dm.hpd_rx_offload_wq[dc_link->link_index].aconnector =
 					aconnector;
 		}
 	}
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3115,7 +3115,7 @@ struct dc_link_settings dp_get_max_link_
 	return max_link_cap;
 }
 
-static enum dc_status read_hpd_rx_irq_data(
+enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
 {
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -82,6 +82,10 @@ bool perform_link_training_with_retries(
 	enum signal_type signal,
 	bool do_fallback);
 
+enum dc_status read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data);
+
 bool hpd_rx_irq_check_link_loss_status(
 	struct dc_link *link,
 	union hpd_irq_data *hpd_irq_dpcd_data);


