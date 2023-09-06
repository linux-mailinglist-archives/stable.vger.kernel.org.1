Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17ED793D0A
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjIFMtv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjIFMtu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 08:49:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DACD1713
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 05:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUJe6Ak2zpu4jqwbMuAkB8aRG703uifNhEY/sOeMuKmhf9CueJeedLMMw8ExWNDvbTP+oUs4a3SlQGOxxB/YuZbxuyGXLGAf0O4U1067sfeFdz618rHzYAhYefFIQ2fq9Uo+/Vf3Sq6xlqu3JmML+BRSH9wVcIZFlunb9pIUceDf12/3oW+bsh/7gtwlnK0w/WU6jHEGerSzukgYB0HXF2Bo/ESjpmSr0umq8KApoId0Fd/e7V+E3QqPsjm+7/jwnOCYxjXoQsiM6d/Qfmss7WRCrC1Jgl2U3NRrk6IFHftKDtr31y3L2AESLMdXPnYEcgJM5ylWtmdxmU61AxpBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU3bF1Y4laZQuRlBsEUhAi1qn+Ik6PFQ9zsE2hwcebc=;
 b=DIJcRwhAQH34F6c6yCzDS4yo4huq/TXYfRhrYEasLe7898dGp1euMH5IDOVwbH3UF1tvxUfj2tvev3k4MnluuIK1pxpT3/0u7Nt9Y2BUgc3/3COaOwxvYLC4xx0SI13xcBZx9BXUVM4RSMoHlZhB04ByM2mz42O67DrSNzu1OnmE/8EL6i+8H//xH/c3jJ3EUPSTVvRtqtJopqo13cQ4Wb11jhOXAwEs9rFsu6VN10ZxnnK1VbLcYytSESdPAtt31Yxpw3dOw0XXFjXJb9SMW6Ekz9A9Aj+pg639l7RhAp+y4wJfJivkaSWnvU4Sbp0TCHhWmZbxiXbGPZskTMMbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU3bF1Y4laZQuRlBsEUhAi1qn+Ik6PFQ9zsE2hwcebc=;
 b=vkgwiq6mOEuycOer9iS4o2BFymUGU27iMQx5M9lYXtUbGYp+WkPmhlBZPy0VJLIlzhY/2ANvWTZdJhoAy8OJ6HURCbgyXlZGnii/CkcGnbsbzCGZ9e7NFqQc3R9f/CvdtQwhKnmGnd72EBgT3/lCFvlKK5z/VeArx2x8uLTT9J4=
Received: from DS7PR03CA0198.namprd03.prod.outlook.com (2603:10b6:5:3b6::23)
 by PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:43 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::17) by DS7PR03CA0198.outlook.office365.com
 (2603:10b6:5:3b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:43 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:39 -0500
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
Subject: [PATCH 10/28] drm/amd/display: Adjust the MST resume flow
Date:   Wed, 6 Sep 2023 20:28:15 +0800
Message-ID: <20230906124915.586250-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4ea840-ccd9-42aa-63af-08dbaed7be35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DzVTgAaUcUYIsS0c3Uj4QzVErPWk8FGZAf1FHtaEW7i+uiCNEl3XQWpxPwJtXrGQRX3STp+abEESkcFEBS45lVFYtx7BKQVrJ+1zd+eRINnZr7BqisbtTwu1DMCN47ylOeZv2lYiAFFKIZS6n1u1vrui1zVw6S0tQLyhG87AgSDDhsRJQiJ7cH9WqiDImF91KAQsN1LVt87eSdmCIoYyWY2VwcPZH6oVWGsu8euRlAkmM0YWkl3V2zlavuCB6huZ1P+MHGFGZ/4krS/CukYTNUThLYf36fcymHnYj/176R4iwYjPCFoTDgHXSIGat4dqAqrO5yxTYbSMa//LeOrkIcRy5bSbsEI212wpcKVf0+VWixSwj5P+SAinxqEaEzoRl3ET7QdtO+C+dgV6b6LdfMq6aQEn1FXY9uMam/WMMEMjJwGNWBvPkXGPF6yTRnVT7izvUbqwwZQcdQ0TTU9dSWxUzq1xjWD0wiv8jJcJA+5jjmn7dSCb+J2Rz5kZ12cdjb3MhrW1oyuF3x3ExeMBF97PrGAlr/58CY8qbTYHsnq7lAVDYioaUZoSmeFhB+pRWrr4v05eDipdi7vH6uvJLG7pRcxiSamDpoFXIDm7a1eo/fJDAy0QYQNB+ZSbTWMkpAxH7rTUey3P2Bo4XbfW1F3wUDmHlqUkkRyy9pIHdWPmhYv+BQ6MreezLY2dXskIuH+074jJumHyRiBAnH7nl8ESIVOhJUuwjSvqo5jizZHg3rUQMtspI3aoEmK2a7eCnoSKOdkeQmau2raIDok1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(6666004)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:43.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4ea840-ccd9-42aa-63af-08dbaed7be35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759
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
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 ++++++++++++++++---
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 93f8ec2acb4a..15bd87200f6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2350,14 +2350,62 @@ static int dm_late_init(void *handle)
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
@@ -2379,18 +2427,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
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
@@ -2784,7 +2829,8 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j;
+	int i, r, j, ret;
+	bool need_hotplug = false;
 
 	if (dm->dc->caps.ips_support) {
 		dc_dmub_srv_exit_low_power_state(dm->dc);
@@ -2886,7 +2932,7 @@ static int dm_resume(void *handle)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created
+		 * this is the case when traversing through already created end sink
 		 * MST connectors, should be skipped
 		 */
 		if (aconnector && aconnector->mst_root)
@@ -2946,6 +2992,27 @@ static int dm_resume(void *handle)
 
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
-- 
2.42.0

