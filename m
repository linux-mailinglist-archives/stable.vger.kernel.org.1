Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED797D319B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjJWLLD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJWLLC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AC0F9
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:10:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E0C433C8;
        Mon, 23 Oct 2023 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059459;
        bh=7ydRu4IwGxYmBrRap5DsszHknT7eWKpZdlJ3yBGRoSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+BzKq1wzPxinLgwhbNtygOEw81B6yL69Jyak8U0wBV9D8WKniRScnJ7vcMGpNrvj
         GNkVdIbpKTWKFUXBFXhcfHmuk4m7JriCBOh1OMq2yBixCR6kB2SpzWwdUHBAd/WsQA
         s7vYTGJ8VOysTQr91mPhxd6QKwuuBT9p3jOVYI4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH 6.5 185/241] Revert "accel/ivpu: Use cached buffers for FW loading"
Date:   Mon, 23 Oct 2023 12:56:11 +0200
Message-ID: <20231023104838.392682259@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

commit 610b5d219d1ccac8064556310cc0e62e3c202389 upstream.

This reverts commit 645d694559cab36fe6a57c717efcfa27d9321396.

The commit cause issues with memory access from the device side.
Switch back to write-combined memory mappings until the issues
will be properly addressed.

Add extra wmb() needed when boot_params->save_restore_ret_address() is
modified.

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231017121353.532466-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_fw.c  |    9 ++++-----
 drivers/accel/ivpu/ivpu_gem.h |    5 -----
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -195,8 +195,7 @@ static int ivpu_fw_mem_init(struct ivpu_
 	if (ret)
 		return ret;
 
-	fw->mem = ivpu_bo_alloc_internal(vdev, fw->runtime_addr, fw->runtime_size,
-					 DRM_IVPU_BO_CACHED | DRM_IVPU_BO_NOSNOOP);
+	fw->mem = ivpu_bo_alloc_internal(vdev, fw->runtime_addr, fw->runtime_size, DRM_IVPU_BO_WC);
 	if (!fw->mem) {
 		ivpu_err(vdev, "Failed to allocate firmware runtime memory\n");
 		return -ENOMEM;
@@ -273,7 +272,7 @@ int ivpu_fw_load(struct ivpu_device *vde
 		memset(start, 0, size);
 	}
 
-	clflush_cache_range(fw->mem->kvaddr, fw->mem->base.size);
+	wmb(); /* Flush WC buffers after writing fw->mem */
 
 	return 0;
 }
@@ -375,7 +374,7 @@ void ivpu_fw_boot_params_setup(struct iv
 	if (!ivpu_fw_is_cold_boot(vdev)) {
 		boot_params->save_restore_ret_address = 0;
 		vdev->pm->is_warmboot = true;
-		clflush_cache_range(vdev->fw->mem->kvaddr, SZ_4K);
+		wmb(); /* Flush WC buffers after writing save_restore_ret_address */
 		return;
 	}
 
@@ -430,7 +429,7 @@ void ivpu_fw_boot_params_setup(struct iv
 	boot_params->punit_telemetry_sram_size = ivpu_hw_reg_telemetry_size_get(vdev);
 	boot_params->vpu_telemetry_enable = ivpu_hw_reg_telemetry_enable_get(vdev);
 
-	clflush_cache_range(vdev->fw->mem->kvaddr, SZ_4K);
+	wmb(); /* Flush WC buffers after writing bootparams */
 
 	ivpu_fw_boot_params_print(vdev, boot_params);
 }
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -8,8 +8,6 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_mm.h>
 
-#define DRM_IVPU_BO_NOSNOOP       0x10000000
-
 struct dma_buf;
 struct ivpu_bo_ops;
 struct ivpu_file_priv;
@@ -85,9 +83,6 @@ static inline u32 ivpu_bo_cache_mode(str
 
 static inline bool ivpu_bo_is_snooped(struct ivpu_bo *bo)
 {
-	if (bo->flags & DRM_IVPU_BO_NOSNOOP)
-		return false;
-
 	return ivpu_bo_cache_mode(bo) == DRM_IVPU_BO_CACHED;
 }
 


