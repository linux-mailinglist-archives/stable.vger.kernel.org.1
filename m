Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82E7E5E17
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjKHTDr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjKHTDd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:03:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE2244A8
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAzR99OwpVH1HwSRbGuf3IfqaPIKs3f3S75M10cnu1M/Hs2SAS3euWSkCdTzMWYJfYctc2lS/9WhPJdbM7pLB+15IqjhCJLp4xLc4poMACAFnInMjnFl14a7AIJMauolsRNU1/LIUzJxWHp9pcBvE/Emd0+l2qB+fSFHjmwANVHHbb/g7PLPc00qZwKe8V42X9vDVC8oduPa068IBKet5d6nEG8OsYwLmUoc7ayiZO9RMMRmwpX7bkKpl5T6SX83eye080Dzh/AD+1JERWGJ3duntqZNBKHN4kkc3c7jYTvr8+mpo3oWUTtJePZ4naZ6o1wdpS81zxUaF9cpzeS1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy59PEmWCG1q4QU4Oy8n9wSL2gzyn8BWwcxu5KkFOeI=;
 b=kCA5EVSU/lkY7qfwf07jcDtMcYyADwR/AeTPCV/4F4VAUbuI7Nf7/pe/LNrciBf/OUyvhSCazaewj2GptO95jbzTQp55pTIfQUVQ+VsYTW32bL7U2AVpAxiY0PDNV+9ZW+wdjvvp45gbcByO8zNuR//zz9sff34EZqQngHRJZZN0JGar4v6RJOtib9p0IueR/L60W65Bfh4I6l81EcooNqjPFHVxcwMPxZILPFdgieTeV4MdHS5NQLaduiJfRodT1VQrYEXei7P9H1fiWv8klG5qO/jhzW7mPmXlEE/z3AF2koo0ZOaA4aEYQR9R7NjnqbuZbxAPY6lm930GxAZFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy59PEmWCG1q4QU4Oy8n9wSL2gzyn8BWwcxu5KkFOeI=;
 b=VlF/jxKF5ntSaKWMTMDbP3xopdWxy2KnP6yZzgZSFOm3v6h4B/FneMcwBS9ZHQLxBg5pWhWE8VvG0LL7UDLXs+LGLQlXqg0qJq8Gi5xg8I8lSKC/arOdJHobEvxUkPhm0Q9zgFHeLwKKD2FPDFkKFcYuV7GNPUJLO2Y2gIp9slw=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:01:36 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::89) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:01:35 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:01:28 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 01/20] drm/amd/display: Fix a debugfs null pointer error
Date:   Wed, 8 Nov 2023 11:44:16 -0700
Message-ID: <20231108185501.45359-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ea874a-2a06-4f8f-a096-08dbe08d210b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EREqDUF7JHK5iHpc+REenkBpOA1n83rzYwLZhynU/ysv7ajlsvZHPOSBJsZ9scF5xU5BI1BKe1PWXZ9RKpJIAShFLr+4n/aneDD8XZz7QnTobOfEzzWXYr27TmCKBlFaBpK/HxfqxQStmfCkgW5UrMfl0kFm15yyD+KcC2WZXLHhftJoSPyLWBWglfUH/KDwqQgtykaOUdoUFWb9s+v9ZK4sSa2/0EZp78NTCB2kjefZZQ4iOSLNbHvutCtXHyILuLkK2HVvHkys1VBbLUgD8A5CH+grxwTfO7zFAUWezneV0uMBzHdHRBjGj97fp3H5veFFcXQh3rBbRUgltkIXrmuYu8jfoEyhdZZZd2ZRL4TRGElX+MQdh7JNFB578dB6oN3SqsIkvsDZaIvjsefUVkUcn7qqt3239swHZcqtoPDNyiszi6jqr4H3rtT4kbjuOaNsI2WVyo5D7wngyQAp5IJEMZ3pUOXuIFeitLI42WCBei9KCs5Bap2TH3T/nO/O3HeVNkhoHqVRbKa0FW7WINg37X6rff1dqJO9oNHb16+pjoEcWq+rZQBLIfucwga1++yaC+AZmQiq8qymW4irS283wMtLXRqtTlP6FeOTznvCvlIbkDjA+N8iEz0de6v5aPDV5irEvDbY0/GNtRinQWjtx/q7WUntq4oUWQArRK6Q0p+8bYQ9glUc0RnHahSvMGGwzE37lWgzG69nMPFTzbSOyo76r+ltyRhHz67K2kI5NmRfbENX7pIZN9f4+5tr1a0MBB/vY4c+XnKbAHzMqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(46966006)(36840700001)(40470700004)(1076003)(70586007)(70206006)(2616005)(26005)(83380400001)(336012)(426003)(16526019)(478600001)(7696005)(40480700001)(8936002)(4326008)(8676002)(316002)(54906003)(6916009)(47076005)(6666004)(44832011)(5660300002)(36860700001)(41300700001)(40460700003)(86362001)(82740400003)(81166007)(356005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:01:35.2009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ea874a-2a06-4f8f-a096-08dbe08d210b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHY & HOW]
Check whether get_subvp_en() callback exists before calling it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 13a177d34376..45c972f2630d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3647,12 +3647,16 @@ static int capabilities_show(struct seq_file *m, void *unused)
 	bool mall_supported = dc->caps.mall_size_total;
 	bool subvp_supported = dc->caps.subvp_fw_processing_delay_us;
 	unsigned int mall_in_use = false;
-	unsigned int subvp_in_use = dc->cap_funcs.get_subvp_en(dc, dc->current_state);
+	unsigned int subvp_in_use = false;
+
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
 	if (hubbub->funcs->get_mall_en)
 		hubbub->funcs->get_mall_en(hubbub, &mall_in_use);
 
+	if (dc->cap_funcs.get_subvp_en)
+		subvp_in_use = dc->cap_funcs.get_subvp_en(dc, dc->current_state);
+
 	seq_printf(m, "mall supported: %s, enabled: %s\n",
 			   mall_supported ? "yes" : "no", mall_in_use ? "yes" : "no");
 	seq_printf(m, "sub-viewport supported: %s, enabled: %s\n",
-- 
2.42.0

