Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF87744EA
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjHHSb3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjHHSbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:31:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23470ACB78
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 10:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOEkTljDaavfrA95UBXROeLRqgfxsh5OqXr5+DGKcqnJC1r2S6/C9rw9GP85QZ+rxYC5IZADZd2JqMgjf2KIRtyFrVS1oxkyKJmsoIHhKcm9gNpsd01Q/w6EGRgnL6yh6fkzVIet0obAydKpYCiR6k+xeGtwf/NOccsKCs0fa69v/8l8jspdDOqyP03g1O5PrcbdO/bO+OHFbGV5RhDT3raGL9MDOmE6IQoLx1CvGby+MuJizIuieXC1+l4aATMvDzQ2RtfbeoO47h9CIbKRUOaTOOLDM50GPBw6sRe1T2bx/trBsBHGV/inZATeIXjKN1SdyAXDSQlXMtocgzl17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iLcxVVbxNPPhtAsjp3+HdDViwj1PnSPktZSFDF5h9g=;
 b=llqeqMfSynCjB2j/3PvYdgHtcU0ERZmTn7F9hduSUHXbu1jpbMnt133po0G4+DqoSTl4Hd7F5CT6JNxrusjWsa+7TOiT1z2qU7iyD+8885it3xLDJYzwshPMLduH+8Nxg1JvPiwO5V1kNbSKLeVWozi76yXniw5R6Pcw4x6FCpaZhBlMWY2E4hjVhE+CbdeK6vh6ZUQZDIfBPsoHbvqd+Z7q4dTBijWPSoeG29qxiGJDLCftjdMuUaA/PN/p01pOTQGJrjJOMcihY4WiIZaDlqzwFmz5JXfGibxzmz1Fs2M9tuEu9HCGbuMQ7owePX37+zlrajMbao4cUmIbrrkuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iLcxVVbxNPPhtAsjp3+HdDViwj1PnSPktZSFDF5h9g=;
 b=RvwE02qsTYHgWAI8fZplSoEwVCzcJx3/IHD6rPFFpBCN0YKcskkK4Uq4TqSRXDiBB6lvAjhh7OD0hD5td+1GKZ7r1L2PGeS7kiYMS2R8QPhZn2wyfoVShuyOXWKsrkMA3oEGc+6ZG7wCtUQmf8RqpcULY7/WhPNxw/rPuXZHyX4=
Received: from CYXPR03CA0050.namprd03.prod.outlook.com (2603:10b6:930:d1::15)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 17:51:12 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::75) by CYXPR03CA0050.outlook.office365.com
 (2603:10b6:930:d1::15) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 6.1.y 2/3] drm/amdgpu: Remove unnecessary domain argument
Date:   Tue, 8 Aug 2023 12:50:54 -0500
Message-ID: <20230808175055.3761-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 52440232-1465-4b23-8e12-08db98380de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0s9ey3Bb0XX1jzS8+jxXaGyD3qox9RaNiOL4FD3KuQpnmLkPS3ydj8rmPVI5zZIuLaY3d7DrZ4Ztj6VT9zA2JaBPzONVjSf2xxK3CR/tghVBKsKLJBINRP2m0pFIyDOot94gh5mRkeasDyjv8RFkfkQaqke6ponv+ScmGlwTehhCPBeiVrQmLQTwE3AocUq1OGmetDHtE9jfV1X7cSreKk7GpC7DSisObrhx2UIIj1rG0S3YL1xQHak3pd2uuhCuAzSc7Hek4QtExSmMnnZFla/9DBA/5xbX09snHqUL15s63CWLa5lHMyahxum28yNXvb8yNjyRc5bOEiR5BILV4/7hSUCOQfUPDQB6xSJ/SVw0cYaRjk/nscKGkC+9Ziz+4K96dTxhGAaMWF0ha5exMzVwrEUQMlkKuj23+wTFK6HJjM5daEpcS5PNJC61u2mj7INox18M6sH6cbQxgwJ7HctwTMF5b/bZo5a6qrlysjNLDihAUQorVTlRvic7rqGGhELJA9x3esZQpL/aLj5hMTXqOuG+a+BYya9ea4R4Q1I/a3YrfW3NUFMBOkUt3H4EdHFHJ/wZ/0Ws4g8nwnN3Ju6xpHsDrFYZ7JPosSDnR3DyMfkI2ATrNr0JcJGqeqN9f66CE6PkCpMMZbWEIFU9yffUdY5T93sWGGSeq79hcksmzqnRp196gxv1kiffepQ4uda/lGNTDfwmFKDREF2ES5mGDXvlacR0Y9mCMw4eVJgrIhQdTxtX+h+XC8CO3FKiWH0dHHE8tPi/b33x7GzGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(1800799003)(82310400008)(186006)(451199021)(46966006)(40470700004)(36840700001)(2906002)(40480700001)(336012)(82740400003)(356005)(316002)(81166007)(36860700001)(2616005)(47076005)(40460700003)(426003)(1076003)(5660300002)(8676002)(83380400001)(70586007)(8936002)(41300700001)(44832011)(70206006)(16526019)(6916009)(36756003)(6666004)(86362001)(7696005)(478600001)(26005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:51:12.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52440232-1465-4b23-8e12-08db98380de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luben Tuikov <luben.tuikov@amd.com>

Remove the "domain" argument to amdgpu_bo_create_kernel_at() since this
function takes an "offset" argument which is the offset off of VRAM, and as
such allocation always takes place in VRAM. Thus, the "domain" argument is
unnecessary.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3273f11675ef11959d25a56df3279f712bcd41b7)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  1 -
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ad8cb9e6d1ab..0ee7c935fba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -347,17 +347,16 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
  * @adev: amdgpu device object
  * @offset: offset of the BO
  * @size: size of the BO
- * @domain: where to place it
  * @bo_ptr:  used to initialize BOs in structures
  * @cpu_addr: optional CPU address mapping
  *
- * Creates a kernel BO at a specific offset in the address space of the domain.
+ * Creates a kernel BO at a specific offset in VRAM.
  *
  * Returns:
  * 0 on success, negative error code otherwise.
  */
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size, uint32_t domain,
+			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -367,8 +366,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	offset &= PAGE_MASK;
 	size = ALIGN(size, PAGE_SIZE);
 
-	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE, domain, bo_ptr,
-				      NULL, cpu_addr);
+	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
+				      cpu_addr);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 147b79c10cbb..93207badf83f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 			    u32 domain, struct amdgpu_bo **bo_ptr,
 			    u64 *gpu_addr, void **cpu_addr);
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size, uint32_t domain,
+			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c66e7c79d653..917147dee8a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1575,7 +1575,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.fw_vram_usage_start_offset,
 					  adev->mman.fw_vram_usage_size,
-					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.fw_vram_usage_reserved_bo,
 					  &adev->mman.fw_vram_usage_va);
 }
@@ -1600,7 +1599,6 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.drv_vram_usage_start_offset,
 					  adev->mman.drv_vram_usage_size,
-					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.drv_vram_usage_reserved_bo,
 					  NULL);
 }
@@ -1681,7 +1679,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
-					 AMDGPU_GEM_DOMAIN_VRAM,
 					 &ctx->c2p_bo,
 					 NULL);
 		if (ret) {
@@ -1695,7 +1692,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	ret = amdgpu_bo_create_kernel_at(adev,
 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
 				adev->mman.discovery_tmr_size,
-				AMDGPU_GEM_DOMAIN_VRAM,
 				&adev->mman.discovery_memory,
 				NULL);
 	if (ret) {
@@ -1796,21 +1792,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
 	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_vga_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
 				       adev->mman.stolen_extended_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_extended_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
 				       adev->mman.stolen_reserved_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_reserved_memory,
 				       NULL);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c73abe54d974..81549f1edfe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -391,7 +391,6 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
 					       AMDGPU_GPU_PAGE_SIZE,
-					       AMDGPU_GEM_DOMAIN_VRAM,
 					       &bo, NULL))
 			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
 
-- 
2.34.1

