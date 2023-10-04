Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8727B89F6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbjJDSax (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbjJDSaw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:30:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE0DC
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:30:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C9DC433C7;
        Wed,  4 Oct 2023 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444247;
        bh=PQchZq0q/mtoJc5PQRt89JwrSHavsobSspDWMp999YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDyh7Z+kPvdhNL9bX2MkyqG6zv5mY/1tSxrkA0AC3g/OwWbcWNEwmM52sqDjBeRk3
         ZzWBcFpDdcixvWpoqHqFN+Bly6aZXer5z9etFAhPTMNyYaGwaF9Vn2DTGpPSQ7ekbh
         FfLk9Qf2iiIcsWNBUUHEx0+6nYEWqjVWOR9h16B4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 154/321] accel/ivpu: Use cached buffers for FW loading
Date:   Wed,  4 Oct 2023 19:54:59 +0200
Message-ID: <20231004175236.380882855@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Wachowski <karol.wachowski@linux.intel.com>

[ Upstream commit 645d694559cab36fe6a57c717efcfa27d9321396 ]

Create buffers with cache coherency on the CPU side (write-back) while
disabling snooping on the VPU side. These buffers require an explicit
cache flush after each CPU-side modification.

Configuring pages as write-combined may introduce significant delays,
potentially taking hundreds of milliseconds for 64 MB buffers.

Added internal DRM_IVPU_BO_NOSNOOP mask which disables snooping on the
VPU side. Allocate FW runtime memory buffer (64 MB) as cached with
snooping-disabled.

This fixes random long FW loading times and boot params memory
corruption on warmboot (due to missed wmb).

Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230926120943.GD846747@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_fw.c  | 8 +++++---
 drivers/accel/ivpu/ivpu_gem.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index f58951a0d81b1..93c69aaa6218d 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -195,7 +195,8 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 	if (ret)
 		return ret;
 
-	fw->mem = ivpu_bo_alloc_internal(vdev, fw->runtime_addr, fw->runtime_size, DRM_IVPU_BO_WC);
+	fw->mem = ivpu_bo_alloc_internal(vdev, fw->runtime_addr, fw->runtime_size,
+					 DRM_IVPU_BO_CACHED | DRM_IVPU_BO_NOSNOOP);
 	if (!fw->mem) {
 		ivpu_err(vdev, "Failed to allocate firmware runtime memory\n");
 		return -ENOMEM;
@@ -272,7 +273,7 @@ int ivpu_fw_load(struct ivpu_device *vdev)
 		memset(start, 0, size);
 	}
 
-	wmb(); /* Flush WC buffers after writing fw->mem */
+	clflush_cache_range(fw->mem->kvaddr, fw->mem->base.size);
 
 	return 0;
 }
@@ -374,6 +375,7 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 	if (!ivpu_fw_is_cold_boot(vdev)) {
 		boot_params->save_restore_ret_address = 0;
 		vdev->pm->is_warmboot = true;
+		clflush_cache_range(vdev->fw->mem->kvaddr, SZ_4K);
 		return;
 	}
 
@@ -428,7 +430,7 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 	boot_params->punit_telemetry_sram_size = ivpu_hw_reg_telemetry_size_get(vdev);
 	boot_params->vpu_telemetry_enable = ivpu_hw_reg_telemetry_enable_get(vdev);
 
-	wmb(); /* Flush WC buffers after writing bootparams */
+	clflush_cache_range(vdev->fw->mem->kvaddr, SZ_4K);
 
 	ivpu_fw_boot_params_print(vdev, boot_params);
 }
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 6b0ceda5f2537..f4130586ff1b2 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -8,6 +8,8 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_mm.h>
 
+#define DRM_IVPU_BO_NOSNOOP       0x10000000
+
 struct dma_buf;
 struct ivpu_bo_ops;
 struct ivpu_file_priv;
@@ -83,6 +85,9 @@ static inline u32 ivpu_bo_cache_mode(struct ivpu_bo *bo)
 
 static inline bool ivpu_bo_is_snooped(struct ivpu_bo *bo)
 {
+	if (bo->flags & DRM_IVPU_BO_NOSNOOP)
+		return false;
+
 	return ivpu_bo_cache_mode(bo) == DRM_IVPU_BO_CACHED;
 }
 
-- 
2.40.1



