Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A27744EC
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjHHSbc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjHHSbN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:31:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F793FB
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+ny/zbmcT0wbVt9AXm3BPYEsKZ4Qt99MRIP0M1CXhIRai6VFrHu1ah8QWbvSTp6iHaXGSFgBMrO/R1jHEE/Hoeun0yeMnOASAKZZ2wQBvT0ee4mZR/RdZmxlI1CAtjpxHYqeg+vAgIiSQsC6qdYV402COOiUbela/bWRujeo3BDcdmhBmaURuKCbBdaCchiJtsvF7DjBt/PcNFlYYBM91+IK6ll3D1P4IlMytT2hM/CNNn9KNsuNn4KHxdAzST0Te/T4UXA2rdDiYcx+Bgr6B40urQCAbHOk1PA8Dte62WgGmRL4J10hsNfJH92HYIkdzVgSOQOuZhRwcuZnZnPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADoa9rgkzEPHZnVcUhB04UVgKkA6OfotIMow9OLZswM=;
 b=cDtJ6u9si12w3+Odzsc3G+N4oXoclgQ3651dPYJXMIlG2qJ7r6Q5hAaP25yQXajxpRuibzQDmwWwVuYX2A/+aqC7HB13q2V/tcqr1S2bhoHQv3UECYMArep+5OmzUYYsBlaKOegoU1d3ulnabWb8UNTCRlHC4r0owS+eJ+jXcjQnVmjc3kbzMoSZzQKYagMIUpMS2YPC4aAH6xeH+6DZnxPeAI9wHoPjNvtHTa1v1gFxY/kJ8QKxTsY+dqMA5DPTHyaj2leGmflfKRexjAFz2OI0YXjQ2z0CBnLTMY+//pwlPXd51Wp75FBykHmCLdYIigGjYNKiw0/owYymppkscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADoa9rgkzEPHZnVcUhB04UVgKkA6OfotIMow9OLZswM=;
 b=uKZBz4Don9CedY7ZBBBmg4S8qkZGxLblQhWBGpAybBdsBP9Wgoa8tgQRAnJFlLkLiMXnrzplbPshE0Y1XOQU+ig5oUfQaN32ELEJ4S5+YmTfU4gFAitLG6XIpY3hIWeAAE8GvSOToPtGnrXqr1NRVVeDTbdbf+rV8rXHMQJp2SI=
Received: from CYXPR03CA0065.namprd03.prod.outlook.com (2603:10b6:930:d1::7)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 17:51:12 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::bd) by CYXPR03CA0065.outlook.office365.com
 (2603:10b6:930:d1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Tue, 8 Aug 2023 17:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 17:51:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 12:51:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 3/3] drm/amdgpu: Use apt name for FW reserved region
Date:   Tue, 8 Aug 2023 12:50:55 -0500
Message-ID: <20230808175055.3761-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808175055.3761-1-mario.limonciello@amd.com>
References: <20230808175055.3761-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: fad615d2-020f-45a8-edc8-08db98380e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urHBgpWxtQb2aFYtMOK6RVfmYkwR7oACth6CJdv3kKBx0AkHMiEac78KU7AXgdBWJIYBlvhoMdhu522eP7ddI0WAvLZEQw19pjn3VscqBKk9wTZ+sCyddDd/dhU5BLYtqmOiN85u8UnReH3I7/6r5vyzPcfW43x2i1R0k5ruFJ056KU7xRd/zBLgJuH5HL36JX4yXglmSbWi+n3SZ2FoD4lQ1MabtVRJ1cDfJRHInyLsm5iLbqhr5Nx3j3RrKm/VrcveZQ9EnyK5N5MRUETPJOKGCHa//rBBBszJRrXYCwQJudRjv+DUNkVKjCmu/WrCooidnaKg1dUlzF5QpncpCbOnAw7mlLcPOMRoIRSHOqJ6iZsIFAX4/1RxU29n1L11kENE8Yw39P7xMYOECw3zYjTeLrJQNjqH7N0kLk4qQnoiOMhSrzpHPY5pFCi/RjCwCgf2xPOoXwkLQl8mfggfHE2KrFMjonmYSR57xO/FSv1xNqZJbA/iSFuCuBk3CzjnOwaAjbQcui+t+21Zr1Y/BhR0MI3bzbKEwXnDv/jkidPw7kvHj/ZDZjC0lh0aIYRT2sn8iQ2fJaA4j9lechaJZmdq77/BeBHbRojngbjB2KggoXqh4ZL1ol8x/TcIUwBS+Lu94/SULjfo1fjxejBJ2iMHba10jV3yDJJNGvF/0CMfMUt5tUuMP62Luc0ReK9SpFS7CND4OCK8yO3NuLprEeq4VC9Ud1fhGXvA6oBYxv6m2tRtK1pFJbcZR/TllPRr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(1800799003)(186006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(81166007)(966005)(356005)(478600001)(82740400003)(36860700001)(86362001)(7696005)(26005)(6916009)(70206006)(1076003)(70586007)(4326008)(6666004)(16526019)(316002)(2616005)(336012)(40460700003)(426003)(41300700001)(2906002)(40480700001)(83380400001)(47076005)(36756003)(44832011)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:51:12.5051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad615d2-020f-45a8-edc8-08db98380e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lijo Lazar <lijo.lazar@amd.com>

Use the generic term fw_reserved_memory for FW reserve region. This
region may also hold discovery TMR in addition to other reserve
regions. This region size could be larger than discovery tmr size, hence
don't change the discovery tmr size based on this.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit db3b5cb64a9ca301d14ed027e470834316720e42)
This change fixes reading IP discovery from debugfs.

It needed to be hand modified because:
* GC 9.4.3 support isn't introduced in older kernels until
  228ce176434b ("drm/amdgpu: Handle VRAM dependencies on GFXIP9.4.3")
* It also changed because of 58ab2c08d708 (drm/amdgpu: use VRAM|GTT
  for a bunch of kernel allocations) not being present.
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 33 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++-
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 917147dee8a2..10469f20a10c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1625,14 +1625,15 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
+static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev,
+						uint32_t reserve_size)
 {
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 
 	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->c2p_train_data_offset =
-		ALIGN((adev->gmc.mc_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
+		ALIGN((adev->gmc.mc_vram_size - reserve_size - SZ_1M), SZ_1M);
 	ctx->p2c_train_data_offset =
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
@@ -1650,9 +1651,10 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
  */
 static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 {
-	int ret;
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 	bool mem_train_support = false;
+	uint32_t reserve_size = 0;
+	int ret;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (amdgpu_atomfirmware_mem_training_supported(adev))
@@ -1668,14 +1670,15 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
 	 * discovery data and G6 memory training data respectively
 	 */
-	adev->mman.discovery_tmr_size =
-		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-	if (!adev->mman.discovery_tmr_size)
-		adev->mman.discovery_tmr_size = DISCOVERY_TMR_OFFSET;
+	if (adev->bios)
+		reserve_size =
+			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
+	if (!reserve_size)
+		reserve_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
-		amdgpu_ttm_training_data_block_init(adev);
+		amdgpu_ttm_training_data_block_init(adev, reserve_size);
 		ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
@@ -1690,13 +1693,14 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	}
 
 	ret = amdgpu_bo_create_kernel_at(adev,
-				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
-				adev->mman.discovery_tmr_size,
-				&adev->mman.discovery_memory,
+				adev->gmc.real_vram_size - reserve_size,
+				reserve_size,
+				&adev->mman.fw_reserved_memory,
 				NULL);
 	if (ret) {
 		DRM_ERROR("alloc tmr failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
+				      NULL, NULL);
 		return ret;
 	}
 
@@ -1890,8 +1894,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	/* return the stolen vga memory back to VRAM */
 	amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
 	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
-	/* return the IP Discovery TMR memory back to VRAM */
-	amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+	/* return the FW reserved memory back to VRAM */
+	amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
+			      NULL);
 	if (adev->mman.stolen_reserved_size)
 		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
 				      NULL, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b391c8d076ff..0fefa5e3a524 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -78,7 +78,8 @@ struct amdgpu_mman {
 	/* discovery */
 	uint8_t				*discovery_bin;
 	uint32_t			discovery_tmr_size;
-	struct amdgpu_bo		*discovery_memory;
+	/* fw reserved memory */
+	struct amdgpu_bo		*fw_reserved_memory;
 
 	/* firmware VRAM reservation */
 	u64		fw_vram_usage_start_offset;
-- 
2.34.1

