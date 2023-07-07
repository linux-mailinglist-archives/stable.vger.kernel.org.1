Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4C74B3BA
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGGPIQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjGGPIO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D526B8
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwATqOyrfoQ9846fEHJ45EFhCWuEjx7GhwnlR+K78X79ou+9Upwb5zcoNkbVNU/0nqlJEqL0/ckuY2slC4EWfFRHrzCco6eQVXJIng6kmEBu0w0mzA5s7VZkWh27L7+40zFs1gdCPUpt/Ixn6rb1uxsQ87DCBJUX1y/IXvJsUqg5oqzy5Ap+qkIRkA6Iq8MkhV3cJtkDOibCRmtsWbX28Zgo1ZhPnojCLwu37hQ0kIBwGcpSyV8pg0ThbCBaH12Pp3UeSX5miP+jy//3/NokeuzXiU6zYeBFex5LgCRRrWqK5cdvp0bajaEB7TFIf0NHGsFoUqQW2XK5GW5gLFunkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dhkjjwW0Rn7CH1nWFn2jWFhSIJr7n0zqiVCx4potog=;
 b=QCIPx6KVCGG7L45Csj0Dw3hDQoyz3wZwAyRfRLJoO+f6yQ0f/9/meXbTvbDOkrhKqAWjpiyegc8DSnEwiXZlVR2OI8Uf/cP48Ca7XE9d3I5/3j5CMG35d8shpMtrCynbgGCQw+r9RbWzfSq4Yqjlk68JnciNO7WHFfeiX5BLL2UO3eTUDLGKT0nmiG0Hr4x4amOBIXCJYuOgCpEX0sCljaylTo+7Csc1j83SZf9AlRgqB8yF0THeO+SSIsUKsouieRIFLB7xrSZA6HzToNo9DXz+4h0G83snQ7GGFS8v9oaIYyLbEUevrkYJaerwN4dUwe541EKj5qSbpDtT38Yyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dhkjjwW0Rn7CH1nWFn2jWFhSIJr7n0zqiVCx4potog=;
 b=q0zsvhKD4JaxByz3PwBnhM42qKG8TJTVdvGyFP7HvQMaI3K/5j81CROBlWxG14PmhgEzoO4maQdbGRswe7KjttrmrT7I2vALPnIqkqdIbZ0IFAQDYpgePNDFmoucLEEJ4k8dvBjasR9Gz5AkSV7Sb/H/iq9XwqDgkDLGHDrkJJA=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 15:07:53 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::bb) by MW4P222CA0001.outlook.office365.com
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
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:52 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: check RAS irq existence for VCN/JPEG
Date:   Fri, 7 Jul 2023 11:07:32 -0400
Message-ID: <20230707150734.746135-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 50adea9d-5edc-40ab-73de-08db7efbf06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqebk9/rWFB6Zcq4BkXTOmNqgtPCyLiGnUhjq5vB56/dZTkBGzBq2lF5SItADqFbJ5WoCbeIZWF/JkH4QVoDsLoo1fmFFdoLYheh3PW6elFNcGWjEMcEmdZb8AuXjZszAvSkfulkeVWEHNKvJIgGEKE1LLwtH4kkQHHM+koPvAni2Wptg1VJXLDDkcqrErXwugJe+JozQanWfiVOG4k6oOLmpsvqjox01FQeirb1W0qXeBVyf4/EcAy6MmcCDKGCJyGbdWAwNoqBTmnGMTzbd1h+BXjjnWJrWbdMXH4X0bkUlrvZq9FD6UhDmrHYM+iBI/iW4hCpxNh2fdhNxHVFy2z3WsxvVtJZtxiCRqvbdOsMwKSYztPtlNOzezq6ZuXpKNySNinBfmPLji8GXz63egjGgyse84HQ7OD5aHZunIej/ZDLxxXXOqxeBgljXrGndXKZoeynzxwmeOGerUWEnUlEEHqrn8PMCE9ArwXnY+Y5R5JIw0giJe0zoz9UUrRrKTWdJ0X83tATWDaBfq2Vwul64bTtTg6GRsq1duBlcqilGi/Xf9yBszE5uLYS/K4DTiTatSDDRE2eIo6Gr74pcgjNt+Qrz3N3zRhnRdnDe/RtsFRN63PYfi7KXLLUONwPnLfT0qQ9q7CFKze2rAwwqHvah2gq04RLRI3vng/y7J6prRpeKZZAoUiyHnT59RRvF4S8NRBNPAIB0zoyD/eAFMWEl84altuIysNAUn2w3N8kw2YP49g1cJo4UOmdfFSEwHK0m5gRNGzVmPPnDvOmww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(70586007)(6916009)(82740400003)(2616005)(81166007)(4326008)(356005)(82310400005)(86362001)(16526019)(336012)(186003)(26005)(1076003)(36860700001)(83380400001)(47076005)(426003)(6666004)(36756003)(478600001)(7696005)(40480700001)(54906003)(41300700001)(5660300002)(8936002)(8676002)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:53.6687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50adea9d-5edc-40ab-73de-08db7efbf06e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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

From: Tao Zhou <tao.zhou1@amd.com>

No RAS irq is allowed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4ff96bcc0d40b66bf3ddd6010830e9a4f9b85d53)
Cc: stable@vger.kernel.org # 6.1.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 4fa019c8aefc..fb9251d9c899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -251,7 +251,8 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-			if (adev->jpeg.harvest_config & (1 << i))
+			if (adev->jpeg.harvest_config & (1 << i) ||
+			    !adev->jpeg.inst[i].ras_poison_irq.funcs)
 				continue;
 
 			r = amdgpu_irq_get(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2d94f1b63bd6..b46a5771c3ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1191,7 +1191,8 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
+			if (adev->vcn.harvest_config & (1 << i) ||
+			    !adev->vcn.inst[i].ras_poison_irq.funcs)
 				continue;
 
 			r = amdgpu_irq_get(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
-- 
2.41.0

