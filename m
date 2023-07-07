Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD60674B3B7
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjGGPIN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjGGPIL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F826A5
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr3n6BUNQnzJkk4DZqKIiuBWBx1T4L3uxf/aTUR1SNBhSEYMJdX8Hd5ZSthaH3vZFwblAVMAxbsTNgF9BNysV4jMiRTFVBnuw3llUg4O+LG8d7jPnfhrd89CWwjEKexDKXI+qaSYLDLcUr2wmE8L8WE9JELzMUPRjrH66dsBSiYGoXaApA6E+95+mczi8W2pBCcOSuKfy2HGUr+baombN5fUYwC2rnYjXzvknKDGfLpBqC5D0UieJXwtVtcGuswOw3aqTmUpUINII3a+H5GdEnquXdTIBPaaNxDvG3hb51fjLuZxnZAfhkTqJ/wEXyyqzGqDMG3fVD2OquHxZdYNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5VzNZ6pNRn1tgIU0ONncH++tblwZsGWXhJXIiHc9XU=;
 b=df86fmso8xfNEREeEiQamhEpOvbD3uhF0oG3RTKMPewRl8rof4kgOFR3ck/yFzJemrgpf7c2nEoTcSF1jP1ynuSzgRoBKkhT0s9mghmaY7DW0+jyzgAmpjreFbHkQFH+Nw6lW8vSvBKtR/BI8/THr42DiQWoRBGSbQbAzex7iVxjTg3nsgiZD6ddHgGyIa/tsqfKCuetcW6kugWrf3NtZ+G6fDCYtO6hYTcoJioehvHX1pUszeNxbDlZBWyZ1i5lLsdWbsWXF7QGTDAKOpz21MJsU245uDLkP16qmxHDXFlzAhR1+2l0RxKj+6W7Nuz3mo5zt7QZ3396G8QBD5HqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5VzNZ6pNRn1tgIU0ONncH++tblwZsGWXhJXIiHc9XU=;
 b=3xMc+Eto6EzaNQbrJIgr7pvpd0u4Ik8WOUuxPaOgHjSkkF2pV3mqr3kXIwxufe1u+ZuAkfvj1xjY+Y9BMIYjJqDCioE/FWi0y3s5i0eNcP9EZlDAnHm9HzeokTvMIXQMHY7wNnjuj0JV811iTG2UkKLaF42h5Df0qgSmym44Rzo=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:07:53 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::f8) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:51 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
        "Evan Quan" <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amd/pm: add abnormal fan detection for smu 13.0.0
Date:   Fri, 7 Jul 2023 11:07:31 -0400
Message-ID: <20230707150734.746135-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca4d47f-5884-4191-f267-08db7efbefe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxRssNGQ5aAPMXmfD9i9xQ6A+afCdX2m7yERYotRJV+9zeFoF+qDBVPDyXBjAS6a4oRqerlalF9+UrajKIl7+bPRerGkq7GFZxQiQ7pz4+95WEO0dzHR8bfvVJ5XBWhWqx68WECXD3EGpCfpOxMsY+TN6p6gLMPJcPVTOnjGHBz/Ha/3fbxJQknYv/pPQdxBw+G3u/yjT29ancAUQPEUnSm/2EVBoZZL59jjehZFzs354rk8Kdg0sI3grbAW1DQ8GT6D18cKyB9W600974GOQqWOV0JEzyPikTMj1yJAvvJ9NIxoxKmcRDSfCDIcoGNLf8Q85+HuL5QXYXilNpWn7bNcsInCdCsUbzw0ssQWaSjnmlpw8YxdezYG4VOeBntRBscyMyrmhnQHf9VVP1r8yLdrAYG3QyoCMefjUIc7iArIfLly7mg0hXfRYujw9gf+x8Nc8qzufYPQo6sCq1vjsLeTAtGTj6JRXQxW5RJ7dJeefUU14Z1qxfis7TJGzymK2GeekYfevaTLbJJKmIxktaVrz0lFnqNzGcPaVnl7aVse0uSYg7HcjfLO6iB+L2TMQr8F/122M3WixlAhe0ZE0Us/ffQVnxCEWMycy4DFx+hNb0u+9AM2vncGUnwLDhc8wsAzIQQUso0UO3wdB5FBWOuqmTo7ZLuYS1v1eWiRX8OZ107D9IRFCzTwTouoGOvxeo6ksIWYODO5YjN48D5BRsnMTkallpsYCIvNI10qU9ckHCPc/hH6mXgbpnDR5B8f4E1z+/fEySd6xzmJ8AfPSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(356005)(36756003)(86362001)(82310400005)(40460700003)(40480700001)(8936002)(41300700001)(8676002)(26005)(5660300002)(186003)(1076003)(2616005)(16526019)(2906002)(36860700001)(336012)(426003)(83380400001)(47076005)(316002)(6666004)(70206006)(7696005)(70586007)(478600001)(54906003)(6916009)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:52.8406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4d47f-5884-4191-f267-08db7efbefe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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

From: Kenneth Feng <kenneth.feng@amd.com>

add abnormal fan detection for smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2da0036ea99bccb27f7fe3cf2aa2900860e9be46)
Cc: stable@vger.kernel.org # 6.1.x
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 08577d1b84ec..c42c0c1446f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1300,6 +1300,7 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }
-- 
2.41.0

