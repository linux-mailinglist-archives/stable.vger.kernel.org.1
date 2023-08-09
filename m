Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C503A776359
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjHIPI0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHIPI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 11:08:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA046210A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 08:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTq2Q2zFWv1sazIndOLWrmgTdSksN4bcgRu6VC8KpGVgPYVBEDh2RRdAHAFCYZnJnK6+Kw+mLihTSX3Rl/+wXTDIA231F/ymJ5jcW9dngAY8C6Q1bXSr3e3V6xv6GardgC0pQ31JaOp3s70ZgZ8KhrK3UOAEnqkMQAV0gEFGBxY2Mi2mGc12vr/PL15Ra5bx6IHM+NsWwPg1zr86Lgr/iWJ2PgWO89jEBvjScqdB0olYt9/rhC5BGx4JBmoSpJg6Q2Thide6dwgdDe+rxBRrfTxKmdV6YLu5s+IjgsfDtcv2Bamr5tSRqRn2g3z22NQlXTpAhCAPEDbLz2qVLAxR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbkc0jpjxDGKEMRf/8R/CY93YNu5i6WNjRCoqgXZdvE=;
 b=WpMXjnQ/WS34D+HciVv7rP/6I1APX3Zp6stYo6iPXzEZa55+E4cQoW/vDerAMknwlaksxpgD49Hs9lQzM/FcwVdp5BQWC/UK+2uE5SrDvyqpsyZd6hyzloRzsLIHJMt+cThIF37+4C6J1bW42U9zbqwuQ641LyRNDQ5hVqbHrs2UPysBPMg1+DX3fMe69Z6N3n201RIXdd2hEv1pmTVsTTRz3SmJk7+67V/XkTHMOx5OGSI/IGHr/I4rf3TwLmVJKZKRhH0MbjMyeqtL4KFgJDEwct5yHemRdkRKt/kcseL99cBS/iU4KqDfmWd9MOz5aGvUAYXUTGUXe0qYHasQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbkc0jpjxDGKEMRf/8R/CY93YNu5i6WNjRCoqgXZdvE=;
 b=FCNMBdRdUvbLfRTpU41Zs0RtzVQaHbRBUPlTgQY0LY1gt9zAKWedX7z1izvubJPyo2o3f/40JrACxraNhDEYihIBWyU4ei/sbzhr6FQ/GdNJwPFWhXxQO/Hlaqml9lsnN9C/iahfVi3d4OVMKWcT0kCfAPz6di0q+x4CZS0qNW8=
Received: from CYZPR19CA0012.namprd19.prod.outlook.com (2603:10b6:930:8e::21)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 15:08:21 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::bd) by CYZPR19CA0012.outlook.office365.com
 (2603:10b6:930:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:21 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:16 -0500
From:   Stylon Wang <stylon.wang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 08/15] drm/amd/display: Adjust the resume flow
Date:   Wed, 9 Aug 2023 23:04:58 +0800
Message-ID: <20230809150620.1071566-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: ee426464-f6c2-42da-5fb0-08db98ea784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfRVPXj+2UyZ5xxpM2t1sWJ8AQ7gfCbTyGGLSdMTGMA/h9q0lWzCoEs+3HFDpxYBmqz5BinhMufzIjmqirv5DVcl+NqMnzA1Ggtc8rwjJBJ8TJDEoEY7ix/OCfewZwb6c77F/oJMsjRVbZq8/mbbjYEoXHYn/d7sJtpraEu+pzRdZyf/tZtKCTk/KjN0AKOOG8P4W88+pAXkyyvegtCg+QSL1vB0ISUwXXdCvsGSnzVfPtNCvEU/o6z52zc1e3hVFIPhtoSgFKXPXJfo53bLo1a2/iSGOFyg24XCM/hR+uiC9QhiaXcrz0HfjeSKFHO2Xxz1sT4Re2xBLdskHRTN953MhAJGCd6penFkjO2IfIEZsgMCnT/vHc73p2wypG6j6xsFET4LUbD9NvfqIT2VpSt47HYKu/bP74D+W122epW7l9sL/2lDM2A5kRtn6pq0DPBmEq78u9b368YkiwWoEEgboo8HYcxg9r1BEkbX0g8wf2vju5fr1xwf8HMcyUuBuffOExGBBsEd2R0UV5YQUOyDpq0ItinhdGty4fuRaVYR2f/3XYs3pAnaKgOx7WFSBDz+fi00bUvn/8uUcc/5FobHpvg0pW98hFrwChh37R3qQsb/TXST8YHSNdi3CNdmHjC23wo/FBcc7mMgyv+yVwV8AlqOOoX3JEllCisa3ZFkwq2rEPpih5vav9XRuJsGUcEb1Y4+9/PQRymR4vUZtVZpA8cBeL9cH8kyP1hoMNTOyLAbqLfyfzbeTXT0eUnNBj7u6d4+vr7VwDKOvDQy9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(1800799006)(451199021)(82310400008)(186006)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(316002)(40460700003)(44832011)(5660300002)(8936002)(8676002)(36756003)(40480700001)(86362001)(82740400003)(356005)(54906003)(478600001)(81166007)(1076003)(7696005)(6666004)(26005)(16526019)(336012)(36860700001)(2616005)(47076005)(4326008)(6916009)(70206006)(83380400001)(70586007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:21.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee426464-f6c2-42da-5fb0-08db98ea784f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wayne Lin <wayne.lin@amd.com>

[Why]
In current dm_resume, dm->cached_state is restored after link get
detected and updated which will cause problems especially for MST
case.

In drm_dp_mst_topology_mgr_resume() today, it will resume the
mst branch to be ready handling mst mode and also consecutively do
the mst topology probing. Which will cause the dirver have chance
to fire hotplug event before restoring the old state. Then Userspace
will react to the hotplug event based on a wrong state.

[How]
Adjust the resume flow as:
1. restore old state first
2. link detect/topology probing and notify userspace
3. userspace commits new state

For drm_dp_mst_topology_mgr_resume(), it's better to adjust it to
pull out topology probing work into a 2nd part procedure of the mst
resume. Will have a follow up patch in drm.

Reviewed-by: Stylon Wang <stylon.wang@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 185 +++++++++++++-----
 1 file changed, 131 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a4d57289d07a..2a6ffe11be72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2334,14 +2334,62 @@ static int dm_late_init(void *handle)
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
@@ -2363,18 +2411,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
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
@@ -2751,14 +2796,80 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	kfree(bundle);
 }
 
+static void link_detect_and_update_connectors(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct amdgpu_display_manager *dm = &adev->dm;
+	enum dc_connection_type new_connection_type = dc_connection_none;
+	int ret;
+
+	/* link detection and update. Skip those MST end sink connectors but do
+	 * detection for mst root connectors
+	 */
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		aconnector = to_amdgpu_dm_connector(connector);
+
+		if (!aconnector->dc_link)
+			continue;
+
+		/*
+		 * this is the case when traversing through created end sink
+		 * MST connectors, should be skipped
+		 */
+		if (aconnector && aconnector->mst_root)
+			continue;
+
+		mutex_lock(&aconnector->hpd_lock);
+		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
+			DRM_ERROR("KMS: Failed to detect connector\n");
+
+		if (aconnector->base.force && new_connection_type == dc_connection_none) {
+			emulated_link_detect(aconnector->dc_link);
+		} else {
+			mutex_lock(&dm->dc_lock);
+			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+			mutex_unlock(&dm->dc_lock);
+		}
+
+		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
+			aconnector->fake_enable = false;
+
+		if (aconnector->dc_sink)
+			dc_sink_release(aconnector->dc_sink);
+		aconnector->dc_sink = NULL;
+		amdgpu_dm_update_connector_after_detect(aconnector);
+		mutex_unlock(&aconnector->hpd_lock);
+	}
+	drm_connector_list_iter_end(&iter);
+
+	/* MST topology probing*/
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_root)
+			continue;
+
+		mgr = &aconnector->mst_mgr;
+
+		ret = drm_dp_mst_topology_mgr_resume(mgr, true);
+		if (ret < 0)
+			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+					aconnector->dc_link);
+	}
+	drm_connector_list_iter_end(&iter);
+}
+
 static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct amdgpu_display_manager *dm = &adev->dm;
-	struct amdgpu_dm_connector *aconnector;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
 	struct dm_crtc_state *dm_new_crtc_state;
@@ -2766,7 +2877,6 @@ static int dm_resume(void *handle)
 	struct drm_plane_state *new_plane_state;
 	struct dm_plane_state *dm_new_plane_state;
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
-	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
 	int i, r, j;
 
@@ -2857,44 +2967,6 @@ static int dm_resume(void *handle)
 	/* On resume we need to rewrite the MSTM control bits to enable MST*/
 	s3_handle_mst(ddev, false);
 
-	/* Do detection*/
-	drm_connector_list_iter_begin(ddev, &iter);
-	drm_for_each_connector_iter(connector, &iter) {
-		aconnector = to_amdgpu_dm_connector(connector);
-
-		if (!aconnector->dc_link)
-			continue;
-
-		/*
-		 * this is the case when traversing through already created
-		 * MST connectors, should be skipped
-		 */
-		if (aconnector && aconnector->mst_root)
-			continue;
-
-		mutex_lock(&aconnector->hpd_lock);
-		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
-
-		if (aconnector->base.force && new_connection_type == dc_connection_none) {
-			emulated_link_detect(aconnector->dc_link);
-		} else {
-			mutex_lock(&dm->dc_lock);
-			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
-			mutex_unlock(&dm->dc_lock);
-		}
-
-		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
-			aconnector->fake_enable = false;
-
-		if (aconnector->dc_sink)
-			dc_sink_release(aconnector->dc_sink);
-		aconnector->dc_sink = NULL;
-		amdgpu_dm_update_connector_after_detect(aconnector);
-		mutex_unlock(&aconnector->hpd_lock);
-	}
-	drm_connector_list_iter_end(&iter);
-
 	/* Force mode set in atomic commit */
 	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i)
 		new_crtc_state->active_changed = true;
@@ -2926,10 +2998,15 @@ static int dm_resume(void *handle)
 
 	dm->cached_state = NULL;
 
+	/* Do link detection and update to upper layer */
+	link_detect_and_update_connectors(adev);
+
+	/* Fire hotplug event anyway */
+	drm_kms_helper_hotplug_event(ddev);
+
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
-
 	return 0;
 }
 
-- 
2.41.0

