Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1537A9E2B
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIUT60 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIUT6L (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 15:58:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144EE469B
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/MSoHB2LMX7Rl2egBAE6ytTT/f/p9YpVZaBVY/eXZUwSDjNqeruS7fqrC60puRLZzPEaZgjEad3GRudv/z04/03TrHbHE4DezTpPGK85gvn34rKn72btDMRRTZauN2B32Kph7SrHgss1btiLcPB8teDHt5nXPPHAmo4e5QBGDmlmSN2Gn1TYMLVP+PCtxuOVMkpTUpjE3zOlKjhbn9b02aTX85JiVJeCPRGgI7bMbcW4YaHO0lDVKFhYpaOby5OME6e0R2thuiGG7ql8JhSHjOa8XbkWYJZv/bNJ8CH9AE0dpU8zoGc7HI4c/XsgA9sIkIP1Wee4+5cdxXBkNXElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G/73rgKHMBmjOU2MBLjhbdWgsJ59O8nrTazL1wJQ6g=;
 b=DCfzXmkbP3hga44Uo5UgaI6JNTlFnWB5ba3nTzfhsxTZ6yLXiananvTxat+3hzSB9ogN5I9Ur1/ffWeZ2FN1S8JKSN7GXvoYQgpy/qsdsmbxJKityGLfDrwev8b/luMUdTtyGvuceiZ0yQsrwU0XWUHDbcbuS+jJ7DMvR+kcYhH4fjQQbUP4MTEUHVhvIkPLITf6znoi8qwANY4N+5oRT7FHyqvSTo419VkEE/2w//Pi3y+Yzur9XoQVrXpLrw72UgNrlsyVKuJsSFheboWplbUCmVpECMDhyOqL/WX/iU41nMKvADlcR3mcMFH1cMHS1DIJd0+eY+IKk0boDn51nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G/73rgKHMBmjOU2MBLjhbdWgsJ59O8nrTazL1wJQ6g=;
 b=2DOzPiztGpw2YYLqDQAgTsqQs+MBolwQ1EL67axAeziDqEgBhWbv5IDg9frlXzSRM5HEPjnLhVoBRiMV+g9nEg9ZYCbFdqX3Eb9/ezUjkneJWSOc9ruTQIUEBpHverhmGxcNzUjD4rIrhSK6fDFIf3pkQn8ndo2zCYpV6+hC0Fw=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 05:55:29 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::a4) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 05:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 05:55:29 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 00:55:21 -0500
From:   Lang Yu <Lang.Yu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: correct gpu clock counter query on cyan skilfish
Date:   Thu, 21 Sep 2023 13:54:20 +0800
Message-ID: <20230921055421.3927140-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: bff4ec38-05c3-44eb-70f1-08dbba675c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KW9Ulp5L+oo42ylvdBJLv+Ev+dkge7hrLKNc1DskHk0U6iNnlfAaYDI4K20pAqnuqEeeGwOnF5ifjcMQ8XvNgq8r5bMuEFgYSPwg8pleblBB2A7/YFzLMJZkKKOeSVz8SmM97sHA3rZRZB3MjVZNgRDHF4YGa8InqlarMALy5TonZy/7n/HGmWPqU5aVNGt+ALTJMd9I3DrY0elz4ltWaxSI52z49VPEapoGu4azlsFHtElKzOAw+Q4RYoje1dvOUYFo4ewAK/iDkEe9M4ubMN7t4pPCjbslV2kIPsvnn44qF7nVZNKw0jXDQ0MH7/hedPr9zlgWEDPCFOymRhV989M9mZTI4A+7eiSYLeMEt85GVFuz1pWONIDrmfSBKWcoIpSC846pJPSmebLUtwAT488YHlPhwnXwaf+NNngdqaf6Ib+Ppumks8dSlSNYZ6g0vVKdnRItL6CDMVdxMcT7vmX9QMmEQduo9ZeezCqvLh07Upu+kjKf46Ix+oVp2hdOSaJQR7Jl/8ZOnpaoYW99F8xcsHGMpWyReaSB60f9JAwQABSHLTx3bMsgtxVNuP185yPO7HmdlV1LxPTbMnUVm/4S9RDoTBrn/TaGCuClrob+TYKN8Ahv8+v07UC4SaNOjFaAfJxLE1QlwDvkv/0arxj27ZLb+Q9QDpPgpQVMLO1cYYgTU+tDnTHk0WjgaPx9tEWfX+Tja/w4j4I9OLr8cPstw257XATNrWpbkNQRbsT0fzsWNuwHIWXQVWf/WsAXbcWRk7RCgB/jgTnAQWa1eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(7696005)(86362001)(40460700003)(36756003)(40480700001)(356005)(81166007)(82740400003)(36860700001)(1076003)(47076005)(426003)(336012)(2906002)(478600001)(83380400001)(26005)(16526019)(4326008)(8676002)(5660300002)(6916009)(41300700001)(54906003)(8936002)(70586007)(316002)(70206006)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 05:55:29.3811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff4ec38-05c3-44eb-70f1-08dbba675c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Cayn skilfish uses SMUIO v11.0.8 offset.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1d671c330475..c16ca611886b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -102,6 +102,11 @@
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
 
+#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish                0x0105
+#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish_BASE_IDX       1
+#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish                0x0106
+#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish_BASE_IDX       1
+
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh                0x0025
 #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh_BASE_IDX       1
 #define mmGOLDEN_TSC_COUNT_LOWER_Vangogh                0x0026
@@ -7313,6 +7318,22 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	uint64_t clock, clock_lo, clock_hi, hi_check;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
+		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
+			clock_hi = hi_check;
+		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
+		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
-- 
2.25.1

