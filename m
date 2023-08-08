Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A722F7744ED
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjHHSbe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjHHSbO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:31:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104A93FE
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9SM1uS11VSPJaPgL95IJA5MhVTeQprBl6/Zcgpqkl7SWJW7apdC5gU0RCTojUeWy6nO9ikQ6Z//E5biQahqjOMEqE5Qk9lFmLxUyM/YNYw/RDQdgUtTwhKsJmkJyxB1cmvy+WK7hDvRpfuQCeOy/0qDY/uKMCJc7EBWR4F5iUrihqob2JaynYCGA1CQdBJZ0eBGKEpQnbcFiSdxq4Nbe8+ixI5MHOJLiPKDHk+endqEQdws9x7NLewaNhdGd/5E2c03il3VpAtJDYo66hU53OhJA6TiGLeGmKNHJLtcDKs+SF1X8uccKaX5Cb543Bytydom6J5+gfyBq42hTaFPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0boH7NZrbTQMyoVHfLK8xgI47/+yT87wVcls0sK3xM=;
 b=IXfMsY3VTFC3tBRT1qICwZRUhafBIe/q9HICQ1a7UTnilllsbV11RGfDawAd3LhTO4bkV2La513+iq3H1RTiupCgoUJb1muarpTS/dLp7emqrAvyFPMYQYsnTlOgWK9T6HeSHWRjAq8hC9ngJOq+P5txZ673uwdIHs6BJpWCxw8NM3pfp5ZL1Y08gEzrAVmNpeJ4rWer86svZ5K/y3BW8cg3ws10DK5v1nlVCkIE0brnToO3iFvuNI0mOY1RwrQUBHnxmF4K3zXlNOeHgBdOiTLJkVJ1AxiV3qi6L8gEoSSqktosKer3JhvrWTrJ+f1ZxhD/010rQBAw9+e9508sRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0boH7NZrbTQMyoVHfLK8xgI47/+yT87wVcls0sK3xM=;
 b=Le3ssw0hZo+5yMiLJacIRzCeuBwEUZ+HeYQky/WjkOWu6IXKdak8nlD360keWB0WzVhc4s2qO94EenQQ3LaOuvX2WxKGpI+NiapRdLrdht2+qElyV8A13Z7odAdztvYtY86HXF8DfKB2YT/dTjRobh/oYenM49/22f4Ux9vkL2M=
Received: from CYXPR03CA0057.namprd03.prod.outlook.com (2603:10b6:930:d1::23)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Tue, 8 Aug
 2023 17:51:09 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::9d) by CYXPR03CA0057.outlook.office365.com
 (2603:10b6:930:d1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 17:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 17:51:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 12:51:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 1/3] drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2
Date:   Tue, 8 Aug 2023 12:50:53 -0500
Message-ID: <20230808175055.3761-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808175055.3761-1-mario.limonciello@amd.com>
References: <20230808175055.3761-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 1827d828-7f12-4ad3-c53d-08db98380c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFW0NPS5PDDF3zFnllQpMLOYU+vDU1IxDtdkdmIkuJJBezyyH+kHVueRUDTFO4aF/1b78NIpkFAutx9kZ+c3wMHNRimSXOj66bkCRju3KuPa/v5kqHAtt9VqeLWTnPtIJ3wagiXq4R3H9+sut8aAlk7mxasl/kaXYQ6IAk17ryD7LwNxT6rGqz6FCbT5zeegxoQ1bYd4MxTUhy6LkzuP7xh9sRRZTMGGskBkR9s5c3LXk4GZDQi2+8XN8jUwR6DttyyKetWBERbqIj66slUVdWl/p2vN5NyO5HJYOWbkztZ4wyJ9Y/KH12LfaNMjlCG5WcLG0DR6ejvIvejdNXl6DW1vk1y7t4dW0W4q0Dhbl3Ws/WorJFNM7/dg7CoVTSgCFtVS8Ui/+hoVBmQYGRINTWlaGzC4knN/7Qk/ldrg45VqGtx8Osz8j5cUlpWSPNFf9vSu6tiiEuApelFSW4Ni50Yb4+GJ5QPA0fB53OeGhzKyFoIPoe6BRiVDRLswBvXGJbP0S4VP+oyr5mVCWkdAnKVlQTQ3NVQy+cj/88R5xFQI6U0HC9eqYZLg8hZYXmc+m8fyvovC0Hy+ABXnirPJBrqmgdbXUvxXKWVr9uh20LpryAVIvVR3Bdgx7bojyPyXX+hl1xQzBsdJ42rFV+oCSTr1MIHvuAFMZrrIqDQbqCc2JliCjgAs74JW5UkiPuu9z4gTnhGMQRodWndOohheA4HeRkRpY4KqJiCuuJBZVeRO8K0i5BbZskVO0e2tQENWc54CtAcviNOBzFYfhumCgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(186006)(1800799003)(82310400008)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(66574015)(426003)(36860700001)(2616005)(40460700003)(336012)(81166007)(40480700001)(4326008)(6916009)(30864003)(8676002)(2906002)(44832011)(316002)(5660300002)(8936002)(70586007)(70206006)(16526019)(41300700001)(82740400003)(86362001)(478600001)(6666004)(7696005)(356005)(26005)(1076003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:51:09.6926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1827d828-7f12-4ad3-c53d-08db98380c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tong Liu01 <Tong.Liu01@amd.com>

Move TMR region from top of FB to 2MB for FFBM, so we need to
reserve TMR region firstly to make sure TMR can be allocated at 2MB

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4864f2ee9ee2acf4a1009b58fbc62f17fa086d4e)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 104 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  51 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |  63 +++++++++--
 4 files changed, 191 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index b81b77a9efa6..9b97fa39d47a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -101,39 +101,97 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
+	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)
+{
+	uint32_t start_addr, fw_size, drv_size;
+
+	start_addr = le32_to_cpu(fw_usage->start_address_in_kb);
+	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
+	drv_size = le16_to_cpu(fw_usage->used_by_driver_in_kb);
+
+	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
+			  start_addr,
+			  fw_size,
+			  drv_size);
+
+	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
+		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
+		/* Firmware request VRAM reservation for SR-IOV */
+		adev->mman.fw_vram_usage_start_offset = (start_addr &
+			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+		adev->mman.fw_vram_usage_size = fw_size << 10;
+		/* Use the default scratch size */
+		*usage_bytes = 0;
+	} else {
+		*usage_bytes = drv_size << 10;
+	}
+	return 0;
+}
+
+static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
+		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)
+{
+	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
+
+	fw_start_addr = le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
+	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
+
+	drv_start_addr = le32_to_cpu(fw_usage->driver_region0_start_address_in_kb);
+	drv_size = le32_to_cpu(fw_usage->used_by_driver_region0_in_kb);
+
+	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
+			  fw_start_addr,
+			  fw_size,
+			  drv_start_addr,
+			  drv_size);
+
+	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+		/* Firmware request VRAM reservation for SR-IOV */
+		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
+			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+		adev->mman.fw_vram_usage_size = fw_size << 10;
+	}
+
+	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+		/* driver request VRAM reservation for SR-IOV */
+		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
+			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+		adev->mman.drv_vram_usage_size = drv_size << 10;
+	}
+
+	*usage_bytes = 0;
+	return 0;
+}
+
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 {
 	struct atom_context *ctx = adev->mode_info.atom_context;
 	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						vram_usagebyfirmware);
-	struct vram_usagebyfirmware_v2_1 *firmware_usage;
-	uint32_t start_addr, size;
+	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
+	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
 	uint16_t data_offset;
+	uint8_t frev, crev;
 	int usage_bytes = 0;
 
-	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
-		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
-			  le32_to_cpu(firmware_usage->start_address_in_kb),
-			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
-			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
-
-		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
-		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
-
-		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
-			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
-			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
-			/* Firmware request VRAM reservation for SR-IOV */
-			adev->mman.fw_vram_usage_start_offset = (start_addr &
-				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->mman.fw_vram_usage_size = size << 10;
-			/* Use the default scratch size */
-			usage_bytes = 0;
-		} else {
-			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
+	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
+		if (frev == 2 && crev == 1) {
+			fw_usage_v2_1 =
+				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+					fw_usage_v2_1,
+					&usage_bytes);
+		} else if (frev >= 2 && crev >= 2) {
+			fw_usage_v2_2 =
+				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
+			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
+					fw_usage_v2_2,
+					&usage_bytes);
 		}
 	}
+
 	ctx->scratch_size_bytes = 0;
 	if (usage_bytes == 0)
 		usage_bytes = 20 * 1024;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b64938ed8cb6..c66e7c79d653 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1537,6 +1537,23 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 		NULL, &adev->mman.fw_vram_usage_va);
 }
 
+/*
+ * Driver Reservation functions
+ */
+/**
+ * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * free drv reserved vram if it has been reserved.
+ */
+static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
+						  NULL,
+						  NULL);
+}
+
 /**
  * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
  *
@@ -1563,6 +1580,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 					  &adev->mman.fw_vram_usage_va);
 }
 
+/**
+ * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * create bo vram reservation from drv.
+ */
+static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
+{
+	uint64_t vram_size = adev->gmc.visible_vram_size;
+
+	adev->mman.drv_vram_usage_reserved_bo = NULL;
+
+	if (adev->mman.drv_vram_usage_size == 0 ||
+	    adev->mman.drv_vram_usage_size > vram_size)
+		return 0;
+
+	return amdgpu_bo_create_kernel_at(adev,
+					  adev->mman.drv_vram_usage_start_offset,
+					  adev->mman.drv_vram_usage_size,
+					  AMDGPU_GEM_DOMAIN_VRAM,
+					  &adev->mman.drv_vram_usage_reserved_bo,
+					  NULL);
+}
+
 /*
  * Memoy training reservation functions
  */
@@ -1730,6 +1772,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/*
+	 *The reserved vram for driver must be pinned to the specified
+	 *place on the VRAM, so reserve it early.
+	 */
+	r = amdgpu_ttm_drv_reserve_vram_init(adev);
+	if (r)
+		return r;
+
 	/*
 	 * only NAVI10 and onwards ASIC support for IP discovery.
 	 * If IP discovery enabled, a block of memory should be
@@ -1855,6 +1905,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
+	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a37207011a69..b391c8d076ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -86,6 +86,11 @@ struct amdgpu_mman {
 	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
 	void		*fw_vram_usage_va;
 
+	/* driver VRAM reservation */
+	u64		drv_vram_usage_start_offset;
+	u64		drv_vram_usage_size;
+	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
+
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index ff855cb21d3f..bbe1337a8cee 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -705,20 +705,65 @@ struct atom_gpio_pin_lut_v2_1
 };
 
 
-/* 
-  ***************************************************************************
-    Data Table vram_usagebyfirmware  structure
-  ***************************************************************************
-*/
+/*
+ * VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write
+ * access that region. driver can allocate their own reservation region as long as it does not
+ * overlap firwmare's reservation region.
+ * if (pre-NV1X) atom data table firmwareInfoTable version < 3.3:
+ * in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
+ *   if VBIOS/UEFI GOP is posted:
+ *     VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
+ *     update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;
+ *     ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
+ *     driver can allocate driver reservation region under firmware reservation,
+ *     used_by_driver_in_kb = driver reservation size
+ *     driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+ *     Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by
+ *     host driver. Host driver would overwrite the table with the following
+ *     used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
+ *     set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
+ *   else there is no VBIOS reservation region:
+ *     driver must allocate driver reservation region at top of FB.
+ *     driver set used_by_driver_in_kb = driver reservation size
+ *     driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
+ *     same as Comment1
+ * else (NV1X and after):
+ *   if VBIOS/UEFI GOP is posted:
+ *     VBIOS/UEFIGOP update:
+ *       used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
+ *       start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;
+ *       (total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
+ *   if vram_usagebyfirmwareTable version <= 2.1:
+ *     driver can allocate driver reservation region under firmware reservation,
+ *     driver set used_by_driver_in_kb = driver reservation size
+ *     driver reservation start address = start_address_in_kb - used_by_driver_in_kb
+ *     same as Comment1
+ *   else driver can:
+ *     allocate it reservation any place as long as it does overlap pre-OS FW reservation area
+ *     set used_by_driver_region0_in_kb = driver reservation size
+ *     set driver_region0_start_address_in_kb =  driver reservation region start address
+ *     Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to
+ *     zero as the reservation for VF as it doesn’t exist.  And Host driver should also
+ *     update atom_firmware_Info table to remove the same VBIOS reservation as well.
+ */
 
 struct vram_usagebyfirmware_v2_1
 {
-  struct  atom_common_table_header  table_header;
-  uint32_t  start_address_in_kb;
-  uint16_t  used_by_firmware_in_kb;
-  uint16_t  used_by_driver_in_kb; 
+	struct  atom_common_table_header  table_header;
+	uint32_t  start_address_in_kb;
+	uint16_t  used_by_firmware_in_kb;
+	uint16_t  used_by_driver_in_kb;
 };
 
+struct vram_usagebyfirmware_v2_2 {
+	struct  atom_common_table_header  table_header;
+	uint32_t  fw_region_start_address_in_kb;
+	uint16_t  used_by_firmware_in_kb;
+	uint16_t  reserved;
+	uint32_t  driver_region0_start_address_in_kb;
+	uint32_t  used_by_driver_region0_in_kb;
+	uint32_t  reserved32[7];
+};
 
 /* 
   ***************************************************************************
-- 
2.34.1

