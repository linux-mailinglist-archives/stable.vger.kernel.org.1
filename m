Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC06FCAAE
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjEIQC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjEIQCz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 12:02:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3264690
        for <stable@vger.kernel.org>; Tue,  9 May 2023 09:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW4ddid8YelL1FsFFWdQH15FqyaNLw23KBrW0E45UGd8PwAy4fcX6XZ/ObXYRqOch+r848GEP5df1RN0dRHWUJ2lFPbb/PLtKnw9PZj5n9TpZu8uqmxYr5QmbMtx31beBbkAF+RF3v62dHU3v9Czl3trXklwbqPGTf+PgGles5Pb2i/uBatE+TK/1YufoORXUQ6jd8QtEwI0pnHu4gwqRFDL6oteFDHrcGNAqsSwLyD0HrKm7l5+/ym6ftD57yr192U8hvT//iR6aXWFCvw1jJYavXz858HaWtxPdTw3LK8b6pH9DPv6z83unB/z+WCSwkSl7NiCLLmWLDaWj77iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAIh0d+wqfLQLVSiHWA+vyX8pFZyao7EIxwr4vRtvjE=;
 b=WYUwotAHUsO3MAkFWQdVwGIILtYbbeNJv1m4dwgiOz0Z2Ur9EECnoV1xSxPHhDaFuk08havhW1+OU+PRK/MixuhkDGkP0Lujkyad2kzwEvoNC8whLajmlUBeZqFVIlMZSM+6ttWg66mkD/3fLyeQQVSO8MEm5NtitAc0J1MSFJqp8xYCfIdZ+fCSkq051ALPHX9NuZvYZdQP1LWVxFLcsnJ6Ik3DqnvT5hAf0XJDNBjwKqrEYmrCzdO2upkXCK/4hZ18jqcvfk0RvHbJ8hhuT3RZSFsRRRLiuFt8JRw1JuQZKgpemkoE63lwY9SInNRYc7PkDVw8ZdA8hBdfqw3syA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAIh0d+wqfLQLVSiHWA+vyX8pFZyao7EIxwr4vRtvjE=;
 b=OqCgkNNwi1AYGttxEJUJmMDNSSBKdabw4OSoGDx9zIkRQwCu4nb5kXcfK5cH8gvVMZ+//UpCIpUFyww2MQQEcqZgRt//Z5q7+T0nDfh3Mi9W+LF+xIIHhPxcbXiQg5lMKloFTcNL4MWmoMCOcF6iKUI4tuft4xtlakQVDyit/Wo=
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 16:02:46 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::4b) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 16:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.34 via Frontend Transport; Tue, 9 May 2023 16:02:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 11:02:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <tsung-hua.lin@amd.com>, <richard.gong@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y / PATCH 6.2.y 1/1] drm/amd/display: Ext displays with dock can't recognized after resume
Date:   Tue, 9 May 2023 11:01:20 -0500
Message-ID: <20230509160120.1033-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509160120.1033-1-mario.limonciello@amd.com>
References: <20230509160120.1033-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5f710c-7ad9-4c32-7d1c-08db50a6d4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TTgD6RYeKAofNxWYeDE6QQAe9Cy/KX+kcGv3TfrlaiD+0goz8gXh7WGtfbujZtReg8iupW5EbrRn9Qjy5wW1cHa4a6FMeZoKuNWVC7OMbgjDeHDK6UJ20rSvbY6EboIodVRIYeCDQruyezmWKZikZYem6RzK6MsxqcQKbMaL6K5dq4CFUs7F7GWo+5h8U0Fl80f91mik7F0rOYqjMLmlpCr75qEpvzX4Rwt11YdHHcw1NyKLZjppxzJ201ppDCp6n52kLk1CzyikDXl0Ob95XHJ49R6S+3z3M12a7lh9URp392upc6tNpRkCXTxbFYtM/e8S+ttGgM1QJtQJTKQwKQSxc5z4AdQX8FAh2dAWHpW77zPiVb0XUb0ffp3qsxbs3nvApY8p7OJd/qwkE0tuTaT2Sd2KWIlQoEmjol5ZGuL73RucdfcKk4CDzJULzA19iOWOCWxCr8NrpEEAim07tpS496dWlxzoX/397wsciuqjxgCTGJMpby6qLugoTSIJoAtCWYTKtFZcNrtVT7Qv1gEFyoMJnHRWpXwtd4Ze5FzvoPixweUHTBzJv3OofLYFHlotHcZryjs1WC8NhVDWaQcYSoGbMb38Yf3jNsQfnP1HlNbOBZOSxpPRINA4Hdng51HLWnv17UoMuVK/FybszLjVfT1W2GGEll9oo81lQkXe1A6uK0DJffubpHIVmApY6ahf924bbG3UMITEZNZyPYrfWYQO89l7zCtxhSmN+FNissucRhiTtaSta8K5+6EseMWqbnbKxfkm9BuTiJ5ZbbXDNZ0r2dhf/wB/xlNtP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6916009)(4326008)(70206006)(356005)(82740400003)(70586007)(316002)(40480700001)(8676002)(336012)(8936002)(82310400005)(426003)(47076005)(54906003)(83380400001)(26005)(81166007)(1076003)(86362001)(5660300002)(41300700001)(36860700001)(186003)(44832011)(478600001)(16526019)(36756003)(2616005)(2906002)(40460700003)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 16:02:46.7094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f710c-7ad9-4c32-7d1c-08db50a6d4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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

From: Ryan Lin <tsung-hua.lin@amd.com>

[Why]
Needs to set the default value of the LTTPR timeout after resume.

[How]
Set the default (3.2ms) timeout at resuming if the sink supports
LTTPR

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 01a18aa309aec12461fb5e6aecb76f8b33810658)
Hand modified for missing changes in older kernels including rename
of dc_link_aux_try_to_configure_timeout()
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
(cherry picked from commit 5895ee73fc6b3d507b8ce42763df086acf43d26b)
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6c5ea99223ba..c5ee63862b01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -39,6 +39,7 @@
 #include "dc/dc_edid_parser.h"
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
+#include "dc/inc/dc_link_ddc.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -2253,6 +2254,14 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		if (suspend) {
 			drm_dp_mst_topology_mgr_suspend(mgr);
 		} else {
+			/* if extended timeout is supported in hardware,
+			 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+			 */
+			dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+			if (!dp_is_lttpr_present(aconnector->dc_link))
+				dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
 				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-- 
2.34.1

