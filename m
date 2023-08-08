Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1925E7744EF
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbjHHSby (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjHHSbe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:31:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0EB5E90
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzlOZb+Yny9ItngpfMkHphZ3zp6ue4kXII5Dd6FFVJzHLbxocFlSPzyh64wQp8wYbNFeC7Fn5L4NJRLqVR/z+7TE2VKCArAlOqmu8Uadsbz/54jsXC2N4qWz+MavYa8M5iFZUw63mcZhtj3E6ToKpMJzhYw6gIHi0gI222qi8pbNgZ8poU0/jiOCLGUSkItcUh0Po1dVHMhCLstXdUVwsypn9oncibZePvhRtlMyLM5hjzLTkmr5scSNyEvgyDOBHoB4Fqo/kSyjn/n4JrYzAvx5mBm2Wdl3HMi57HhRkOMDJL0Jx0O/7MboWUrkTPsMVbMs/lLF1aS8xfmSyGsHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2f4bRXElMj3ZoARIPz68ja+N9vpFVRRzgkWVyYQ4Ng=;
 b=ESUKDjZMGVfyxT1riP4i8preuN1AgkA5AVvE7NuccbNJIs8SX/x/SRTi9cpL8eMKvVGM49/Gb1RuZCk6KXzqOLTnkq2IQ3zYkp+f+ZSyFv1usgdiSelfrbICj3VejYCPSpIaDuT6ssdVyM1gmX6UPiM9RDMdJO/Eiab4bdWkn99k10EFOcsz3B/75K8qYmulvAM5yJBvRgls9yb3FCtoy3/o5JUKmP/V5hIf46JBG29TTQjqJXZrlaOoVJr25mfRjQP16m5J6K0PcENmfPn4bMLQvviUARWkQJF+QbkkpHHYIalLkHyVYq2pI6DLboPecjOF6zZS8vxDPjkWDjgAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2f4bRXElMj3ZoARIPz68ja+N9vpFVRRzgkWVyYQ4Ng=;
 b=XVa8r674JNW6oHwwvY+RtkgM3cRhDmv7CCToUR1d0lnC7IknSLIbcZHJX7RbpDDv7TytwaRh1mjrQH+IB7RPfXQW/KJFth4sIgBRJjAtnssBnCYsn69gJYjnmtr+IWAXeX92JR8qQld3jq+pjoEp8Z6NOHmDgy7hThFB3qk7a4E=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 17:51:58 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::2c) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 17:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 17:51:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 12:51:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4.y] drm/amdgpu: Use apt name for FW reserved region
Date:   Tue, 8 Aug 2023 12:51:37 -0500
Message-ID: <20230808175137.3820-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e6d1d1-1c0a-45e8-f44b-08db98382928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLNR77Pd45tilxaA4pnq/mIKUCs83U8wYKct/Hxktn+nxNApn9SaR0Sz6OIfgMpzoJBeAtZwzpNvfoFH2CO7waKPHGG1yIPeEb/jIBeIkUFEtEiMO4bsm9OseqDjSr9lofSfO+SHYG+RHoJ5dU+jesvyCy4Uo5QSAxeHL8hO6oCG2tbuprogCPPjPHcbrXXQDDI3C1jtihMww4CoqiiBzqU1YR/ZIg4dgLNt4+bTl6gzadJy7j/jEGnTlUXocuhCk3XQMyh4jNhVPLikSQXlX9lRRU24/fJKlznOxjGGs4SOXLYs5Y3c/JicbGjohhgFhqMWnDkj5q4wu/CUqQqqPjqq714OZQ7NoIuH2xxPUNXW5d/KGAkWlsk05mOdhtrcLbnFxP4hiHSfedOQzS6S2YTkKtGdYeYU2UDDRoahTUU+gfciT+5msEstF9SmziQL3dIVYQ8B+o9H2YMJVf545kW4sXIrzm9n8+5M/ZLTJBdZAX8LkGlgPBEw09e4xoVV2Lag3im3ZTYGymL9yQ87Xp9LRxD6gZq+rIVfHbQcNmeIqgocwYFHmj1JNSOOz9K+8+Zm45W86pXsTGNiJ45FzgFfC8FRX/apEeyt8Tfq9gsd1ESgB/nBdJ+yCIXyGDP6RlxDvRGMpKzWl7zdKl1BKBm28cvw0iYuUy4mGAfOXAFPQlQ87hXwNLgjiuJEpo3e0d6+cN4mpV84PSq92BjPBNvI30K+RmEwILzt14uRmPlDjG4z2LG2q18/OoW2pyTP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(186006)(82310400008)(1800799003)(46966006)(36840700001)(40470700004)(40480700001)(336012)(16526019)(2616005)(40460700003)(36756003)(966005)(4326008)(316002)(86362001)(6916009)(478600001)(6666004)(70206006)(70586007)(356005)(82740400003)(81166007)(7696005)(1076003)(26005)(426003)(8676002)(41300700001)(8936002)(47076005)(36860700001)(2906002)(83380400001)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:51:57.8103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e6d1d1-1c0a-45e8-f44b-08db98382928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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
It needed to be hand modified because GC 9.4.3 support isn't
introduced in older kernels until 228ce176434b ("drm/amdgpu: Handle
VRAM dependencies on GFXIP9.4.3")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 35 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++-
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2cd081cbf706..59ffb9389c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1623,14 +1623,15 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
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
@@ -1648,9 +1649,10 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
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
@@ -1666,14 +1668,15 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
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
@@ -1687,14 +1690,13 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	ret = amdgpu_bo_create_kernel_at(adev,
-					 adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
-					 adev->mman.discovery_tmr_size,
-					 &adev->mman.discovery_memory,
-					 NULL);
+	ret = amdgpu_bo_create_kernel_at(
+		adev, adev->gmc.real_vram_size - reserve_size,
+		reserve_size, &adev->mman.fw_reserved_memory, NULL);
 	if (ret) {
 		DRM_ERROR("alloc tmr failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
+				      NULL, NULL);
 		return ret;
 	}
 
@@ -1881,8 +1883,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
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
index e2cd5894afc9..da6544fdc8dd 100644
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

