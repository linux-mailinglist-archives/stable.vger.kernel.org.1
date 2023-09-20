Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1446F7A7B8C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjITLxT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjITLxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6747AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDEDC433C7;
        Wed, 20 Sep 2023 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210792;
        bh=NBBlDsctGUllFDY3jUE93e9id1lfkt6Qfam5Hubi6A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH9Ht6pp56NvUU2Iy9USvqcyqt43xmOVUZPqYuE3tfHXaLftJNT09M69NOGnQ13vx
         l6ggBEpcm98B4vJG53+0fhZA+1bECSwmtYvKx/fyB5rPOnDvfZmO2Z8jbcsL5W+IdV
         RPR2ojXhA3HkuwljCGyN+387nHBvvsZXzfrgpjyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao-kai Wang <stylon.wang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Wayne Lin <wayne.lin@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.5 206/211] drm/amd/display: Adjust the MST resume flow
Date:   Wed, 20 Sep 2023 13:30:50 +0200
Message-ID: <20230920112852.252157798@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <wayne.lin@amd.com>

commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a upstream.

[Why]
In drm_dp_mst_topology_mgr_resume() today, it will resume the
mst branch to be ready handling mst mode and also consecutively do
the mst topology probing. Which will cause the dirver have chance
to fire hotplug event before restoring the old state. Then Userspace
will react to the hotplug event based on a wrong state.

[How]
Adjust the mst resume flow as:
1. set dpcd to resume mst branch status
2. restore source old state
3. Do mst resume topology probing

For drm_dp_mst_topology_mgr_resume(), it's better to adjust it to
pull out topology probing work into a 2nd part procedure of the mst
resume. Will have a follow up patch in drm.

Reviewed-by: Chao-kai Wang <stylon.wang@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   93 ++++++++++++++++++----
 1 file changed, 80 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2329,14 +2329,62 @@ static int dm_late_init(void *handle)
 	return detect_mst_link_for_all_connectors(adev_to_drm(adev));
 }
 
+static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
+{
+	int ret;
+	u8 guid[16];
+	u64 tmp64;
+
+	mutex_lock(&mgr->lock);
+	if (!mgr->mst_primary)
+		goto out_fail;
+
+	if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
+		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+
+	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
+				 DP_MST_EN |
+				 DP_UP_REQ_EN |
+				 DP_UPSTREAM_IS_SRC);
+	if (ret < 0) {
+		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+
+	/* Some hubs forget their guids after they resume */
+	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
+	if (ret != 16) {
+		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+
+	if (memchr_inv(guid, 0, 16) == NULL) {
+		tmp64 = get_jiffies_64();
+		memcpy(&guid[0], &tmp64, sizeof(u64));
+		memcpy(&guid[8], &tmp64, sizeof(u64));
+
+		ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
+
+		if (ret != 16) {
+			drm_dbg_kms(mgr->dev, "check mstb guid failed - undocked during suspend?\n");
+			goto out_fail;
+		}
+	}
+
+	memcpy(mgr->mst_primary->guid, guid, 16);
+
+out_fail:
+	mutex_unlock(&mgr->lock);
+}
+
 static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct drm_dp_mst_topology_mgr *mgr;
-	int ret;
-	bool need_hotplug = false;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -2358,18 +2406,15 @@ static void s3_handle_mst(struct drm_dev
 			if (!dp_is_lttpr_present(aconnector->dc_link))
 				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
-			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
-			if (ret < 0) {
-				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-					aconnector->dc_link);
-				need_hotplug = true;
-			}
+			/* TODO: move resume_mst_branch_status() into drm mst resume again
+			 * once topology probing work is pulled out from mst resume into mst
+			 * resume 2nd step. mst resume 2nd step should be called after old
+			 * state getting restored (i.e. drm_atomic_helper_resume()).
+			 */
+			resume_mst_branch_status(mgr);
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(dev);
 }
 
 static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
@@ -2763,7 +2808,8 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j;
+	int i, r, j, ret;
+	bool need_hotplug = false;
 
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
@@ -2861,7 +2907,7 @@ static int dm_resume(void *handle)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created
+		 * this is the case when traversing through already created end sink
 		 * MST connectors, should be skipped
 		 */
 		if (aconnector && aconnector->mst_root)
@@ -2921,6 +2967,27 @@ static int dm_resume(void *handle)
 
 	dm->cached_state = NULL;
 
+	/* Do mst topology probing after resuming cached state*/
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_root)
+			continue;
+
+		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
+
+		if (ret < 0) {
+			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+					aconnector->dc_link);
+			need_hotplug = true;
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+
+	if (need_hotplug)
+		drm_kms_helper_hotplug_event(ddev);
+
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);


