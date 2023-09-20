Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549677A8878
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 17:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjITPeH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjITPeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 11:34:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28FC6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 08:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm+/QgIzgmD0t/vjC5rG+zuQMrDiYiov5MvEG7vE/8p3IOND8gPv16u1Vluujae9shXAszn0ZD3ZaroheCpRKgD/896VSrC4S2iwiwPiwV94h3Fiw9i2mC5sR8JmlSRJLaTzEqkaPOQPZ0QsPLPvbL3r0beP4XHV9lWPC7d+HYnMewnl7vCgUIRxm3O8QrQaIWIOgMNKNF3U+E7n0hvM8UrZpYtYuw4EfnuhR0RB6mZbjmIOoL8xrH5a+/hb/R9LQRVTlisxp2/P6ELRSH4UvllIsntghoM7vNJHE0FIVPXWucPb2cQ3JPNd40rSbRHRiYo+Jn40ZkZ/fkXUcwr7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbf2ZrU/unEGi7j47G8EzBPAs5VTIx4SnTNFJ72xmcs=;
 b=YZE5TQmDkeb1RC7X+9aaLCTuF/x+Di5Qv3sQeKhn6KgfQOzBqzhO9QuBqpdFkADLlhwV1oz03qvl5LqHIcxlWiqsNu4luWZOk4+/UAF8FBd8InFYaAORO5UUFWDQSAX1H8G3QuQuV57+GVA4Rj5cBpC3oPhXo7nVtIhwfCpV5nacdc055mkhce0Gut5Y11oYkH1Y3ET+mBWBhj4EB0bFnh0EItMzgGJi8i1dLv3DtKceVTqmYBDaV3K2+c6zBOBDuOKxKV8qSyM6A/mBNGipE0cuA6y0xHp/k3CGo76ikqNPhIs6Oe17DGg3kqjhQ3Gw5YSmZe+mXOS2prBgIZfSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbf2ZrU/unEGi7j47G8EzBPAs5VTIx4SnTNFJ72xmcs=;
 b=oo+TnfIJ1qGxCY2BBJMfNlUvplmRHfWJYsIubE0/Hvx/rzml9fFhQFSK3TQ3KzakqExV6bDAlyUz/Gqlhl1SAQdBu5nM95r9QMGBZmeZ5JSd0gjZ7zqjlBtqhth9ztaSwVZUA6UnvSC1O3TbSSFKAod7cEvqTA0yOppec0zOtUs=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 15:33:54 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::a) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 15:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 15:33:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 10:33:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Wayne Lin <wayne.lin@amd.com>, Chao-kai Wang <stylon.wang@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1] drm/amd/display: Adjust the MST resume flow
Date:   Wed, 20 Sep 2023 10:33:31 -0500
Message-ID: <20230920153331.73662-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 67eaa002-04a5-41ae-7590-08dbb9eeffa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MpoVQCsc6+C9AEQNa2tzO22prSZdBNhn6G/AFdetRSbFoIuz5RWy+y9rDYqNu0icdCanGBzfQ4Rb1JOXKrho3camUlxHGNRWeYgRCZ51rtdFnOAOGgg5Mc0pVCZ2WCSTBC+XEfCAxH5LZa8RVJgfCOKhg3iWGzj1hs4DFp622cIv2kclMlxd62tIBKTRIjv+rolvfoKro+S6DP77Cq2wuR/sA8oy8sn2P6tA6g1ZRJQ4zqUf6cpZ/TVtD0jPfmJIQsP42NnMF3grQhUtsar+sF/oDJXT6PYxXNIcW34L+vQHJ0GCDffPgaPni36bAT0569UBAFbg8Tyu6WOOZRKJ+fb0lfIe+0FlnI0vDK5/rNE185UP2S9hQp8vGIOGKhNkNPkkJxbXkHpAun5AP+eqlV2lpcAiLULTloTtQNcFBXWi4E7bRrRBroDjlTXOCWh3xokN2QHcyLvnZhZwrKC7kQjU6C3u+wbXMN4E+gDrRm8hmvWeKCfr0/QGuL9TYPl2D+GU9G9xBMdA4dIIC7gcEd15uwkxCuTE/pzEKKgcqsMh0eTMy9OIuIp7Z1tmaIn9o92MM/OdXfPSgsxR8VJT5m6R8FaRXn00aCuqZTKk5pvFduz2suhKhF96Wji8VC9Modc43at+DBsONzGevsOeeEC7nIHIyOvkcJqxv5uAPQv77MshSbvoY0WnuzbGKkoe67v0yoKT83b0Jiz8582RRBCiY4MMIxBl0uFM75wIdTINnWpUYHLrD/wpLvc+LMs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(44832011)(5660300002)(7696005)(8676002)(8936002)(41300700001)(54906003)(6666004)(70206006)(6916009)(478600001)(966005)(70586007)(316002)(2906002)(26005)(426003)(1076003)(16526019)(83380400001)(2616005)(336012)(47076005)(36860700001)(36756003)(40480700001)(81166007)(82740400003)(356005)(40460700003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:33:54.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eaa002-04a5-41ae-7590-08dbb9eeffa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wayne Lin <wayne.lin@amd.com>

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
(cherry picked from commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a)
Adjust for missing variable rename in
f0127cb11299 ("drm/amdgpu/display/mst: adjust the naming of mst_port and port of aconnector")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This is a follow up for https://lore.kernel.org/stable/2023092029-banter-truth-cf72@gregkh/
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 ++++++++++++++++---
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c8e562dcd99d..b98ee4b41863 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2339,14 +2339,62 @@ static int dm_late_init(void *handle)
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
@@ -2368,18 +2416,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 			if (!dp_is_lttpr_present(aconnector->dc_link))
 				dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
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
@@ -2768,7 +2813,8 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j;
+	int i, r, j, ret;
+	bool need_hotplug = false;
 
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
@@ -2866,7 +2912,7 @@ static int dm_resume(void *handle)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created
+		 * this is the case when traversing through already created end sink
 		 * MST connectors, should be skipped
 		 */
 		if (aconnector && aconnector->mst_port)
@@ -2926,6 +2972,27 @@ static int dm_resume(void *handle)
 
 	dm->cached_state = NULL;
 
+	/* Do mst topology probing after resuming cached state*/
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_port)
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
-- 
2.34.1

