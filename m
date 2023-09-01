Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89EC790288
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbjIATi4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjIATiz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 15:38:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F9B10E0
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 12:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcKRz+7c1HignJat7y4Vw3BtG99NAZG6prgGI7P2xaC7BiLKPmHUtbECSDberBidvpkTHYaLW10qM4biU9tKAnhRnB2heC2PBcvk7tzZLYZka2zQEY0hFBxX2z44X8oaI1jt3bN2m4rgIdPVU+u4DNuw7s7w7iS1RYiifJ+PiFY6hujEHa4W/nB4EBlOl9UAj92VNg5HeIZncQ3ObLUPxfxCHIhOnt6w+GyKvIL+BM7SQkev5pi7od9lcpOSNtMHZMB6X1as5yTxcSXP1Yq5HV6RwvWU3JXTCSUnyQAlZCVLvllKYMqS++y4AJbhW0fJWXj3XEHkTuhW1geeWYHPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QROcWAOKqnUPJOyGror/wOggwiVSx4IFnkF/hVPo4x4=;
 b=TpsH4k57+wddzMTQV0YrcB5ZwaLRghcBSbuY0FgLGIS7uruRPSbZTMVCy8RgoGwTB+mUpJ+XYmhfvobyI5/iPt2NO80F5NsmXD8XXP+Svd/kYgn3bQp7D8XxB9l93W4ST9ksVSlz0EIKdkSHcHYZj0HtQ5G74Q74QWqJa0ISdOw1oH/NTlVNjLvAW49itoOxfdmvk4gnhpIfIFcTLbfczn5LBdgoM4+x8QXMgsCT8HvjINaOFo3kkbY+o3xluZ5BQnfwWUWkEOrox+Sc5Qy87j2KoPePhctISKrsydAZPvomZlxbtk37DHG4n/plbCCvLtQkBMdFcna/d0BP2dDmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QROcWAOKqnUPJOyGror/wOggwiVSx4IFnkF/hVPo4x4=;
 b=N2yayCRzrapo4tpSyAp17qFWldXIQzfoxzXLceRVrA80z8cudbOQhhBpLc6JOW5d0OAKiZeVmbLeP7yhCW96BVWFG0HpoHc81QcKEzrJWSS2Vqtg2g+5PlnNYrvWwBSt5kIoLMoymKBb3727H28U78yPKRUVXg1hO8lSyyvkYho=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 19:38:50 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::cc) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 19:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 19:38:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 14:38:47 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC:     Lang Yu <Lang.Yu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: correct vmhub index in GMC v10/11
Date:   Fri, 1 Sep 2023 15:38:35 -0400
Message-ID: <20230901193835.3846059-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 511389b9-93e2-4763-e538-08dbab2310bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ll076m4QKcCk4H/BDkmoiQngVQoKtpbsqTkn9z7z8v0QPTz2IPKryk5VZcoig3vkSzt023UpqbNfw6kxwoBihmEnWpv283KqWTuk1rbg1wu5sWZfkL06TgmbK7xDnWXaOyObUby+FPJySN47jolARqYrztrsqygSvhZtHHdfPvkyf/kZAoyF0DMnOTVmsMSVzLGzfqpPOrKyS86B/4KhDNU0CCr2y5BlLQIsW1/JGa8s9h2khpev3ZTPsJYuHe0efpNc9k9pp2nf2OraooXLaC0Foc8y0Br/BSyz6OHVIuaJjwaR/VBA6kpMK+NyfHVvO+wRWXWUvfu56Q+QdMTAs3PeILRREBkaRpwjZyyYID/fxDDFY5eSx4HzAfDo3Hvjs7l7ozo/GQ89b3nIrXFRRzzARzJshr0PZg9VH36Lo4CcNwJbL1LqTOIDIOUIxaGtrnYtk3GH0GGeLZaYv19tflXTEQEOjiAQL5YpMd0Mx4Vgi6+wo3ZWl07IXrk/Z9BiRSTueM0F4I4DlvAOuo2bq2/JQW7otcFTfFaBQPAOVpti0nxQdMtDmdIQdjRoeUPOOQ40vwJFbPLmj9izgVt4lBEXhQUevRY+xXJK5VSXoPB3rTNc+BZgTV/EQ7htoxhCNcHV83Zf+0nOKzmoqxNTQaSEudREReUxDRRL+FP34aOqeTSp0qzH+7GNi8gJziZK6AQrD3aDy5f3Q62IdlObYOW+8U8oIHZCyDL/eyV1wASbElXGm6Dh8M3sDqxvC3cm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(966005)(81166007)(356005)(478600001)(6666004)(2616005)(1076003)(82740400003)(110136005)(36860700001)(47076005)(54906003)(336012)(426003)(16526019)(83380400001)(26005)(70206006)(70586007)(7696005)(2906002)(5660300002)(8676002)(40460700003)(41300700001)(316002)(40480700001)(8936002)(86362001)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 19:38:49.4867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511389b9-93e2-4763-e538-08dbab2310bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lang Yu <Lang.Yu@amd.com>

Align with new vmhub definition.

v2: use client_id == VMC to decide vmhub(Hawking)

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2822
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6f38bdb86a056707b9ecb09e3b44adedc8e8d8a0)
Cc: stable@vger.kernel.org # 6.5.x
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0c8a47989576..c184f64342aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -109,9 +109,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
+	uint32_t vmhub_index = entry->client_id == SOC15_IH_CLIENTID_VMC ?
+			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
 	struct amdgpu_task_info task_info;
 	uint32_t status = 0;
 	u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c571f0d95994..dd9744b58394 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -97,7 +97,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
+	uint32_t vmhub_index = entry->client_id == SOC21_IH_CLIENTID_VMC ?
+			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	uint32_t status = 0;
 	u64 addr;
 
-- 
2.41.0

