Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE413775E1A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjHILsy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjHIK5B (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F0268C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB0662BD5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FDBC433C7;
        Wed,  9 Aug 2023 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578619;
        bh=1C11SlrnTHj7pjtXBb3q6Z2PveBZ0QrCfdOPZdTNWwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLiqif+y7k22mJcnPiXzQpFLls3lejfreQDgHJ/uAEGsRxQDmHZEp+aYh12Ur8+mJ
         ZfJzaGqeRtu6HCcPjG1e4RaYaPz5e+L4BLbJTFa+rx4DicXdHMTRFLMN6WDp7JUP6P
         S3AaChtPY9ICx8yfdUxN3xIEmrEkQuuIhm4Hz52A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tong Liu01 <Tong.Liu01@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 124/127] drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2
Date:   Wed,  9 Aug 2023 12:41:51 +0200
Message-ID: <20230809103640.701148923@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tong Liu01 <Tong.Liu01@amd.com>

commit 4864f2ee9ee2acf4a1009b58fbc62f17fa086d4e upstream

Move TMR region from top of FB to 2MB for FFBM, so we need to
reserve TMR region firstly to make sure TMR can be allocated at 2MB

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c |  104 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |   51 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |    5 +
 drivers/gpu/drm/amd/include/atomfirmware.h       |   63 +++++++++++--
 4 files changed, 191 insertions(+), 32 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -101,39 +101,97 @@ void amdgpu_atomfirmware_scratch_regs_in
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
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1537,6 +1537,23 @@ static void amdgpu_ttm_fw_reserve_vram_f
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
@@ -1563,6 +1580,31 @@ static int amdgpu_ttm_fw_reserve_vram_in
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
@@ -1731,6 +1773,14 @@ int amdgpu_ttm_init(struct amdgpu_device
 	}
 
 	/*
+	 *The reserved vram for driver must be pinned to the specified
+	 *place on the VRAM, so reserve it early.
+	 */
+	r = amdgpu_ttm_drv_reserve_vram_init(adev);
+	if (r)
+		return r;
+
+	/*
 	 * only NAVI10 and onwards ASIC support for IP discovery.
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
@@ -1855,6 +1905,7 @@ void amdgpu_ttm_fini(struct amdgpu_devic
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
+	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
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


