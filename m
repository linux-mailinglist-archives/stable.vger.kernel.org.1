Return-Path: <stable+bounces-4766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B82805EE0
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 20:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7D9281FC4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE46ABAA;
	Tue,  5 Dec 2023 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JW37iKaw"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B88C183
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 11:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPOCmy0qUCPoN3CITNh/EdIN0gZjCm2gySQvOiAOcWUsu/7Of4aX1IfMVQ766thaoJfR8Aj8llf7+ZZv9DID2vwxNgB+rCDeTBkYbTZvDd7H+tCIdyrzAyAyXzbL0OdZbuzHIk4nR75690ASyRbHjO48yZXX2jT6JjVU8i/KmZAlSc29jikfD0RUtmlG44PaJUSO9EOU7390cISJrdOHoyy5fOJ8ojfpm/XIjANDTKKk5bPitIigVSExwrTE/QlGAr8SO5KmgH2gveM1fpksjzOWfOYIsMesrMaIH52pBLPLvXnF8ZLX4KYKS8tc3L3GUBwflpjc6SXVMS3/8cXENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vslBfZGFOnv4rvYUBSixgUEtK/ll96ZiKqQrlyOxRuk=;
 b=LXmsBgcipXoK1T4vV6ZB42Tx4bz8pxWsQ/0CdJ0hvsbdruk+dmw2xVKknuHIWWXQgkUbiO/JhqgAVRwF01HN7z1R28i/6Klr3FxM2quN8y3Kvb9SgrI/N6O19eZzxiBUzGuuJJ9+5NnzADI1k28gX1oOGoVuwdrURcne33PTllq5/B9EhNGgYoeHhZ/d869J+mt8V0AYSeLNZknuP56jpUk1s+XuVqWJw+tg2ue+CNuN/bJQpryrrPz3GKyZF8axTM6KxkiAVD+iBuHjcRR0Sxye9GMke8XgG0pWXcFpC9SELH6cJmLEfwj78Idio8fAYzRX5jpe0DIqDXux7cVubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vslBfZGFOnv4rvYUBSixgUEtK/ll96ZiKqQrlyOxRuk=;
 b=JW37iKaw+Hn8MPPdhBuIAihVK8WoU8sHCjmimeBNdSrHo0pgj/o6MDQK9Zzr0RDc8gHqtInrgKSgYDs/9eft4BDdoFnf6YETWp8+8NJxsFjzg7sVNtE/4z7sMYXD5STUDGN/VpSlZCEYPsSg5TwzVeK7Q319OZc2HlpXrtKfu48=
Received: from CY5PR17CA0054.namprd17.prod.outlook.com (2603:10b6:930:12::18)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 5 Dec
 2023 19:54:49 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::76) by CY5PR17CA0054.outlook.office365.com
 (2603:10b6:930:12::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 19:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 19:54:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 13:54:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Linux Regressions
	<regressions@lists.linux.dev>, <stable@vger.kernel.org>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Wayne Lin <wayne.lin@amd.com>, Oliver Schmidt
	<oliver@luced.de>, Mario Limonciello
	<mario.limonciellomario.limonciello@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
Date: Tue, 5 Dec 2023 13:54:36 -0600
Message-ID: <20231205195436.16081-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f53599-56a6-44e6-2938-08dbf5cc0a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	smmcZXmFx6DPVF76GoQl12pozDbVR/fhwhuwXw4NJNBbOaU78pIbsISi4SzNARXcXlP4yaPHh7SgbVBb8wP11aDqObopOLm516IH/tkNXelZ6i5tRWpC17T2cn52TDEz7ClOpsvDd4G0U/dflGL8GyEHKr5+mc6MQlnvEl5+nVka0wg99mUUKB1ZHlPgNI6Z52M/aLLu3bI50mZGcB945tjfAxtx8oCFhLurqLucu+2n1Azmwbb3qd5ycCzuxv4lwmP1QnXfj27w+PGNBnEvqrMp8+Yis9P7nplJsaig8yypWpmtwQAvZ/bdzWDjs6vw/Ouo683jEk3Ui3aUCbbPSXs5IWrkavwmmQEG6Bo03FPUzDn2W+9skWd44blBC4/9moJS8LRQT0zjPjAklViAsQ/HAQPZsBcNjpmljwqKEhWoJ8xMjITJOtvdivhOYyGvER3ef8z8zsaPIjRdfJkbKTyDT4ieYkOeC+nFg76LkIsJY1QXa1Fud1Gb+j8xxKNK3PGidgNCh33OsHujjtTJ6HbMkgM7Vbdi7J6QgtpD2OoxIm68O1dfApIIMwW2r5Fko6ef1ddDCgrLwRKHn+AzXYT0vytYzdMHseuMRw8xCePrNvrO4YyuVB5hShpse7tg07Dtlbff3fzTM2s5/EnxsURsfrzTrQC6yK+QfxzTxqBSBIr6vxfZ0LUmaIVambsh5OgfZskTiHEFDQGno5Hy583aep86eLLQ3UJ3joeaa8Af2tK+IqRt1k8rpfHsfbsiTEzmE+xxsl7oGJNWu3bhWZulGFzHLENV6NyZM6X0E4SnEAkmW/08Y/uAlKuQncdiYR3x+1EC8xe/eTH8b3eoIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(2616005)(41300700001)(40480700001)(36756003)(36860700001)(86362001)(356005)(1076003)(26005)(47076005)(336012)(83380400001)(82740400003)(426003)(16526019)(5660300002)(70206006)(44832011)(2906002)(70586007)(81166007)(7696005)(478600001)(8676002)(8936002)(4326008)(6666004)(966005)(316002)(6916009)(40460700003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 19:54:49.3714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f53599-56a6-44e6-2938-08dbf5cc0a1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.

Reports are that this causes problems with external monitors after wake up
from suspend, which is something it was directly supposed to help.

Cc: Linux Regressions <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Wayne Lin <wayne.lin@amd.com>
Reported-by: Oliver Schmidt <oliver@luced.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
Link: https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-after-suspend/151840
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
Signed-off-by: Mario Limonciello <mario.limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++----------------
 1 file changed, 13 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c146dc9cba92..1ba58e4ecab3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
 	return detect_mst_link_for_all_connectors(adev_to_drm(adev));
 }
 
-static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
-{
-	int ret;
-	u8 guid[16];
-	u64 tmp64;
-
-	mutex_lock(&mgr->lock);
-	if (!mgr->mst_primary)
-		goto out_fail;
-
-	if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
-		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
-		goto out_fail;
-	}
-
-	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-				 DP_MST_EN |
-				 DP_UP_REQ_EN |
-				 DP_UPSTREAM_IS_SRC);
-	if (ret < 0) {
-		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
-		goto out_fail;
-	}
-
-	/* Some hubs forget their guids after they resume */
-	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
-	if (ret != 16) {
-		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
-		goto out_fail;
-	}
-
-	if (memchr_inv(guid, 0, 16) == NULL) {
-		tmp64 = get_jiffies_64();
-		memcpy(&guid[0], &tmp64, sizeof(u64));
-		memcpy(&guid[8], &tmp64, sizeof(u64));
-
-		ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
-
-		if (ret != 16) {
-			drm_dbg_kms(mgr->dev, "check mstb guid failed - undocked during suspend?\n");
-			goto out_fail;
-		}
-	}
-
-	memcpy(mgr->mst_primary->guid, guid, 16);
-
-out_fail:
-	mutex_unlock(&mgr->lock);
-}
-
 static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct drm_dp_mst_topology_mgr *mgr;
+	int ret;
+	bool need_hotplug = false;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -2444,15 +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 			if (!dp_is_lttpr_present(aconnector->dc_link))
 				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
-			/* TODO: move resume_mst_branch_status() into drm mst resume again
-			 * once topology probing work is pulled out from mst resume into mst
-			 * resume 2nd step. mst resume 2nd step should be called after old
-			 * state getting restored (i.e. drm_atomic_helper_resume()).
-			 */
-			resume_mst_branch_status(mgr);
+			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
+			if (ret < 0) {
+				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
+					aconnector->dc_link);
+				need_hotplug = true;
+			}
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	if (need_hotplug)
+		drm_kms_helper_hotplug_event(dev);
 }
 
 static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
@@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
-	int i, r, j, ret;
-	bool need_hotplug = false;
+	int i, r, j;
 
 	if (dm->dc->caps.ips_support) {
 		dc_dmub_srv_exit_low_power_state(dm->dc);
@@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created end sink
+		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
 		if (aconnector && aconnector->mst_root)
@@ -3017,27 +2971,6 @@ static int dm_resume(void *handle)
 
 	dm->cached_state = NULL;
 
-	/* Do mst topology probing after resuming cached state*/
-	drm_connector_list_iter_begin(ddev, &iter);
-	drm_for_each_connector_iter(connector, &iter) {
-		aconnector = to_amdgpu_dm_connector(connector);
-		if (aconnector->dc_link->type != dc_connection_mst_branch ||
-		    aconnector->mst_root)
-			continue;
-
-		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
-
-		if (ret < 0) {
-			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-					aconnector->dc_link);
-			need_hotplug = true;
-		}
-	}
-	drm_connector_list_iter_end(&iter);
-
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(ddev);
-
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
-- 
2.34.1


