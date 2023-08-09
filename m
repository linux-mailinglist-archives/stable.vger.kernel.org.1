Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B000B775877
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHIKxF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjHIKvb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B495326B7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5250B63131
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E76C433CC;
        Wed,  9 Aug 2023 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578245;
        bh=iXSH5QLqqjxWitb/56c6CklVHqBQYwlYS6X7vnjmbfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxZzkpxSvJOxDLW7dRdq6a9ajP+yEbaq5Sj3zR0+LOYbd1HmATVvpjR1qWX50bRIm
         65wjp4bRuI4Sfe3BICNbr9BBWDtYHzSwOFmalLwPfUPGdZ7Ascy38Ns2EUJOGqKtJl
         6eNt0BNEZWU2d13McuANmSu0n7U9s0CQcVtP15UM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
        Le Ma <le.ma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4 156/165] drm/amdgpu: Use apt name for FW reserved region
Date:   Wed,  9 Aug 2023 12:41:27 +0200
Message-ID: <20230809103647.878452376@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lijo Lazar <lijo.lazar@amd.com>

commit db3b5cb64a9ca301d14ed027e470834316720e42 upstream.

Use the generic term fw_reserved_memory for FW reserve region. This
region may also hold discovery TMR in addition to other reserve
regions. This region size could be larger than discovery tmr size, hence
don't change the discovery tmr size based on this.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
This change fixes reading IP discovery from debugfs.
It needed to be hand modified because GC 9.4.3 support isn't
introduced in older kernels until 228ce176434b ("drm/amdgpu: Handle
VRAM dependencies on GFXIP9.4.3")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   35 +++++++++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |    3 +-
 2 files changed, 21 insertions(+), 17 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1623,14 +1623,15 @@ static int amdgpu_ttm_training_reserve_v
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
@@ -1648,9 +1649,10 @@ static void amdgpu_ttm_training_data_blo
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
@@ -1666,14 +1668,15 @@ static int amdgpu_ttm_reserve_tmr(struct
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
@@ -1687,14 +1690,13 @@ static int amdgpu_ttm_reserve_tmr(struct
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
 
@@ -1881,8 +1883,9 @@ void amdgpu_ttm_fini(struct amdgpu_devic
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


