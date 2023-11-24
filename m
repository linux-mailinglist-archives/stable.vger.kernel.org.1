Return-Path: <stable+bounces-218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D39347F759A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396D8B21393
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02F2C1BB;
	Fri, 24 Nov 2023 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vGiLzbBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203028E26
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6B6C433C7;
	Fri, 24 Nov 2023 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833887;
	bh=rut6gJbhYUhEXgGZ5OzF4X2a6GExZ6ZBIb99hBQIfYk=;
	h=Subject:To:Cc:From:Date:From;
	b=vGiLzbBMPExwrwZh9bqDTHPc0bgEnovYhQ0wTCb2SMRIotOGNH2jpKNMeNASTLvYY
	 rAA2F8oaDYQRFbVuguJfiq+jdBsFNvFuMqFrF2jEk/0XDaa7QJU1ppL16+6bif2rDS
	 mwJLRkSWD6yoz6R5aTSFSZrkWS4A5DkTkkfYJe6Q=
Subject: FAILED: patch "[PATCH] drm/amd/display: Adjust the MST resume flow" failed to apply to 5.15-stable tree
To: wayne.lin@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,stylon.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:51:19 +0000
Message-ID: <2023112418-elevation-snooper-e9a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 73c57a0aa7f672110d3f28c0ac03ec778a21d9d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112418-elevation-snooper-e9a2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

73c57a0aa7f6 ("drm/amd/display: Adjust the MST resume flow")
1e5d4d8eb8c0 ("drm/amd/display: Ext displays with dock can't recognized after resume")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
d144b40a4833 ("drm/amd/display: move dc_link_dpia logic to link_dp_dpia")
a28d0bac0956 ("drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd")
a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc")
4370f72e3845 ("drm/amd/display: refactor hpd logic from dc_link to link_hpd")
0e8cf83a2b47 ("drm/amd/display: allow hpo and dio encoder switching during dp retrain test")
7462475e3a06 ("drm/amd/display: move dccg programming from link hwss hpo dp to hwss")
e85d59885409 ("drm/amd/display: use encoder type independent hwss instead of accessing enc directly")
ebf13b72020a ("drm/amd/display: Revert Scaler HCBlank issue workaround")
639f6ad6df7f ("drm/amd/display: Revert Reduce delay when sink device not able to ACK 00340h write")
e3aa827e2ab3 ("drm/amd/display: Avoid setting pixel rate divider to N/A")
180f33d27a55 ("drm/amd/display: Adjust DP 8b10b LT exit behavior")
b7ada7ee61d3 ("drm/amd/display: Populate DP2.0 output type for DML pipe")
ea192af507d9 ("drm/amd/display: Only update link settings after successful MST link train")
be9f6b222c52 ("drm/amd/display: Fix fallback issues for DP LL 1.4a tests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73c57a0aa7f672110d3f28c0ac03ec778a21d9d4 Mon Sep 17 00:00:00 2001
From: Wayne Lin <wayne.lin@amd.com>
Date: Tue, 22 Aug 2023 16:03:17 +0800
Subject: [PATCH] drm/amd/display: Adjust the MST resume flow

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

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0e1ce71350d7..8e98dda1e084 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2355,14 +2355,62 @@ static int dm_late_init(void *handle)
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
@@ -2384,18 +2432,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
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
@@ -2789,7 +2834,8 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j;
+	int i, r, j, ret;
+	bool need_hotplug = false;
 
 	if (dm->dc->caps.ips_support) {
 		dc_dmub_srv_exit_low_power_state(dm->dc);
@@ -2891,7 +2937,7 @@ static int dm_resume(void *handle)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created
+		 * this is the case when traversing through already created end sink
 		 * MST connectors, should be skipped
 		 */
 		if (aconnector && aconnector->mst_root)
@@ -2951,6 +2997,27 @@ static int dm_resume(void *handle)
 
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


