Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92B7794E5
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjHKQk6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjHKQk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:40:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEF418F
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEnC2LxpD95uDvOtDFKdmFdu2276PFUOyOruQp4d0JJNgNk81CZZmqnwSjNgM2S5iuDiD0edem614/Gq85StqtHvxIz1MOmU4JobSPhYFN557JKjDcuurj4rPYzp6e+61ybG/0SD+2zZMIQuD6geOqrDeyw1Zvc8qDlgGN9N2d3kyozfiSNR4cRa8fGMG1uVCAVaI/s0zDeEnMTa0SN5cmo0cjsE+idHyevxU1NW8YsgOkY/pIABrZd69M+xwP1b/S8sFu96lb9bHwnb5XGqYTV5vGU3ubs+SFjMjXXLtC4ls6y+RPs+aeOf0fll8aukhWydgWXE7YI+H54wMMR1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2mMeLVttP/7NQfqFH3lXTgn1cxR7QXQ53NUMTiRcUU=;
 b=JA/Ug8pxjc6Na7Ns8nEzpxOEnUXexhcTicxKNg8yC1HscanLJa7a0EHrG9Gm7VzfMXPSq1mA0bgYOZqqvdCvCZXm6ET0M/wbgiGfFOyaKXECxnR5r46puravJD01DdwbQeh/ApIUk7Q1sy8J6k0jRZQCGCNoj2/QAbXJ0FdijghDBIk+4D5LYnBIZp5CFz67/JfjJA27DzWplk6dO1g71yrg5B1//Qlwp2NMQfWCdOvf0H0zYJi6qWX3kk2XGkBqFy5SfX+ZUxO8PZKOp2i+5pxhI0d7uBRQ4t6oBVIdor9WjZvgIgOmWTTK9udI5jl4/5aCOUdW+zK8ZVbtJF2XiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2mMeLVttP/7NQfqFH3lXTgn1cxR7QXQ53NUMTiRcUU=;
 b=mwDzgyl9qYkEms2NA8mEj3Ec74VJU9Un372U/uK0MVziO4yjqOBBSd2cuvoiGfx68+ip1ELRE1xYjEus9uQbzgJT1S8y2/lkGJpio1PUizvS2BtNDrMfGJyCAy+SALgbMWuDGB6u7aZmJyUJgpGaSQ6vTyjFu3cSV7R/YRXsjGg=
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:40:54 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::4) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 16:40:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 11:40:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 1/4] drm/amd/pm: fulfill swsmu peak profiling mode shader/memory clock settings
Date:   Fri, 11 Aug 2023 11:40:28 -0500
Message-ID: <20230811164031.24687-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811164031.24687-1-mario.limonciello@amd.com>
References: <20230811164031.24687-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3e3015-daa2-435b-3286-08db9a89bb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2r2QP5sTZbN32xHMzlB+GPknpNuJ1uXl6j4kRDoizvmUriTeAm625baGumV8ok0A95hDYLhBG7zZOLh4ssu3dt9ABwbzVlWIug/7myfQdEhMh3D14XGgHViP0axoWgDrbn2GOI20Dc4cLN2HqPLBNJaQ8utsDkkCXXtQC6nMpNV2rBgAg8tHxEpJLn8ArwHgYj6L0DC8vIO6EuEsLKQS09NACuw59k6S/lVGjZITyhiT214xDaDetZxBWtwG3XJGkHoUXrgUjawmfXE43nwFAJYAXuGNjvEv30oBeyNwQVvB3pS8oi9Oyr3xHZmecdWu3IQcxLD6ghddDEGYEm6LKiH2jKkJJ1dGn7up+tgZP0Up+/u3dnz4NaGzQenhYGBcQzFYDGd2N9MSMoH51TJ4LQFVLf292dhsx2ryErTD2TLtvDZ87yoSePwmUkDdHGwi/pxCsvdQ6yOw+25ryw1Md1f68sbnKeYHnl8+Yy7oy6bJ62hdvM+Q6KHtyLD2HXB8oPqZ1t7kwjV2xs+WfJu+N9k+oytiNnvx+jU03Y9h4dNMOZ5QoMJTSuF7SVdx09hEPiyXUW2+JaTRpKlhwjbFLdvI8ixrToig8SBsSfCwxkh/xMNUSo5o5BDg6l9FZsLdMdhZgSjV9mPK25ZoU5WY0Y/lFuqeT+JRglGqjXPK/L2urMrk1EXO0sQY5shjoLs9YZTPdiGCUCbduyLJgnN56QGurUIKQB8pZpUn9xbco/myEPorOb8U0v0ko/Ce2DvUWJxyVGdlMGZ4dbxQF+3rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1800799006)(451199021)(82310400008)(186006)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(83380400001)(336012)(16526019)(2906002)(1076003)(36756003)(26005)(7696005)(6666004)(478600001)(86362001)(40480700001)(426003)(2616005)(4326008)(70206006)(8936002)(70586007)(81166007)(8676002)(6916009)(316002)(356005)(5660300002)(82740400003)(41300700001)(44832011)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:40:54.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3e3015-daa2-435b-3286-08db9a89bb33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

Enable peak profiling mode shader/memory clocks reporting for swsmu
framework.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 975b4b1d90ccf83da252907108f4090fb61b816e)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index d18162e9ed1d..f3d64c78feaa 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -139,6 +139,8 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_MIN_FAN_RPM,
 	AMDGPU_PP_SENSOR_MAX_FAN_RPM,
 	AMDGPU_PP_SENSOR_VCN_POWER_STATE,
+	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
+	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
 };
 
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 91dfc229e34d..6d90ab55cea3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2520,6 +2520,14 @@ static int smu_read_sensor(void *handle,
 		*((uint32_t *)data) = pstate_table->uclk_pstate.standard * 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK:
+		*((uint32_t *)data) = pstate_table->gfxclk_pstate.peak * 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK:
+		*((uint32_t *)data) = pstate_table->uclk_pstate.peak * 100;
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
 		ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
 		*size = 8;
-- 
2.34.1

