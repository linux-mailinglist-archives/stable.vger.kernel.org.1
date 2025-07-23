Return-Path: <stable+bounces-164400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B92B0EC79
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B681C26994
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84426C39F;
	Wed, 23 Jul 2025 07:55:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF462777EA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257336; cv=none; b=WrZ83GbIx4cra0OsYUT98cEHnftcIDwKR91PvOVLi04TEdZbj+kP6asDGErF2XnQM30bRvOymQZOXUj8fRD+m/grz4fPMlRRDnuenEsZsxKbqpSUdxM8x1WWvvhFVg3eNwngpkRVZt18ukTKCKQoVtSmzjIKzKts9GABrHNtHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257336; c=relaxed/simple;
	bh=8siwWfMBbJbcDcQAqYlqAc8/bzNjGBa9L4vZ4sXgCoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLDhH8L0J2IZWOwt0HreRxsjj6WPpLQzl9BTzDCicy4iOHiPI0SpxKndwmVbnseXCCr6zIIeC6NBmIi9ty6k+h4rtWPB5XJkg5t6/ZnzjdpESHLGGPXA94Tf9VjSHbyf/a+Aaqf7TWFcIjgZtoAksxtdQuzZ/3aDrYAx594Gbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 15BA43F1BA;
	Wed, 23 Jul 2025 09:45:56 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org
Cc: jeffbai@aosc.io,
	Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org,
	Wenbin Fang <fangwenbin@vip.qq.com>,
	Haien Liang <27873200@qq.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Shirong Liu <lsr1024@qq.com>,
	Haofeng Wu <s2600cw2@126.com>,
	Shang Yatsen <429839446@qq.com>
Subject: [PATCH v3 2/5] drm/xe/guc: use GUC_SIZE (SZ_4K) for alignment
Date: Wed, 23 Jul 2025 16:45:14 +0900
Message-ID: <20250723074540.2660-3-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723074540.2660-1-Simon.Richter@hogyros.de>
References: <20250723074540.2660-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mingcong Bai <jeffbai@aosc.io>

Per the "Firmware" chapter in "drm/xe Intel GFX Driver", as well as
"Volume 8: Command Stream Programming" in "Intel® Arc™ A-Series Graphics
and Intel Data Center GPU Flex Series Open-Source Programmer's Reference
Manual For the discrete GPUs code named "Alchemist" and "Arctic Sound-M""
and "Intel® Iris® Xe MAX Graphics Open Source Programmer's Reference
Manual For the 2020 Discrete GPU formerly named "DG1"":

  "The RINGBUF register sets (defined in Memory Interface Registers) are
  used to specify the ring buffer memory areas. The ring buffer must start
  on a 4KB boundary and be allocated in linear memory. The length of any
  one ring buffer is limited to 2MB."

The Graphics micro (μ) Controller (GuC) really expects command buffers
aligned to 4KiB boundaries.

Current implementation uses `PAGE_SIZE' as an assumed alignment reference
but 4KiB kernel page sizes is by no means a guarantee. On 16KiB-paged
kernels, this causes driver failures after loading the GuC firmware:

[    7.398317] xe 0000:09:00.0: [drm] Found dg2/g10 (device ID 56a1) display version 13.00 stepping C0
[    7.410429] xe 0000:09:00.0: [drm] Using GuC firmware from i915/dg2_guc_70.bin version 70.36.0
[   10.719989] xe 0000:09:00.0: [drm] *ERROR* GT0: load failed: status = 0x800001EC, time = 3297ms, freq = 2400MHz (req 2400MHz), done = 0
[   10.732106] xe 0000:09:00.0: [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x76, UKernel = 0x01, MIA = 0x00, Auth = 0x02
[   10.744214] xe 0000:09:00.0: [drm] *ERROR* CRITICAL: Xe has declared device 0000:09:00.0 as wedged.
               Please file a _new_ bug report at https://gitlab.freedesktop.org/drm/xe/kernel/issues/new
[   10.828908] xe 0000:09:00.0: [drm] *ERROR* GT0: GuC mmio request 0x4100: no reply 0x4100

Correct this by defining `GUC_ALIGN' as `SZ_4K' in accordance with the
references above, and revising all instances of `PAGE_SIZE' as
`GUC_ALIGN'. Then, revise `PAGE_ALIGN()' calls as `ALIGN()' with
`GUC_ALIGN' as their second argument (overriding `PAGE_SIZE').

Cc: stable@vger.kernel.org
Fixes: 84d15f426110 ("drm/xe/guc: Add capture size check in GuC log buffer")
Fixes: 9c8c7a7e6f1f ("drm/xe/guc: Prepare GuC register list and update ADS size for error capture")
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Wenbin Fang <fangwenbin@vip.qq.com>
Tested-by: Haien Liang <27873200@qq.com>
Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Shirong Liu <lsr1024@qq.com>
Tested-by: Haofeng Wu <s2600cw2@126.com>
Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
Link: https://t.me/c/1109254909/768552
Co-developed-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/gpu/drm/xe/xe_guc.c         |  4 ++--
 drivers/gpu/drm/xe/xe_guc.h         |  3 +++
 drivers/gpu/drm/xe/xe_guc_ads.c     | 32 ++++++++++++++---------------
 drivers/gpu/drm/xe/xe_guc_capture.c |  8 ++++----
 drivers/gpu/drm/xe/xe_guc_ct.c      |  2 +-
 drivers/gpu/drm/xe/xe_guc_log.c     |  5 +++--
 drivers/gpu/drm/xe/xe_guc_pc.c      |  4 ++--
 7 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index b1d1d6da3758..7ff8586f1942 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -91,7 +91,7 @@ static u32 guc_ctl_feature_flags(struct xe_guc *guc)
 
 static u32 guc_ctl_log_params_flags(struct xe_guc *guc)
 {
-	u32 offset = guc_bo_ggtt_addr(guc, guc->log.bo) >> PAGE_SHIFT;
+	u32 offset = guc_bo_ggtt_addr(guc, guc->log.bo) >> XE_PTE_SHIFT;
 	u32 flags;
 
 	#if (((CRASH_BUFFER_SIZE) % SZ_1M) == 0)
@@ -144,7 +144,7 @@ static u32 guc_ctl_log_params_flags(struct xe_guc *guc)
 
 static u32 guc_ctl_ads_flags(struct xe_guc *guc)
 {
-	u32 ads = guc_bo_ggtt_addr(guc, guc->ads.bo) >> PAGE_SHIFT;
+	u32 ads = guc_bo_ggtt_addr(guc, guc->ads.bo) >> XE_PTE_SHIFT;
 	u32 flags = ads << GUC_ADS_ADDR_SHIFT;
 
 	return flags;
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 22cf019a11bf..b3d049bdc047 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -23,6 +23,9 @@
 #define GUC_FIRMWARE_VER(guc) \
 	MAKE_GUC_VER_STRUCT((guc)->fw.versions.found[XE_UC_FW_VER_RELEASE])
 
+/* GuC really expects command buffers aligned to 4K boundaries. */
+#define GUC_ALIGN SZ_4K
+
 struct drm_printer;
 
 void xe_guc_comm_init_early(struct xe_guc *guc);
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 131cfc56be00..6b5862615fd7 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -144,17 +144,17 @@ static size_t guc_ads_regset_size(struct xe_guc_ads *ads)
 
 static size_t guc_ads_golden_lrc_size(struct xe_guc_ads *ads)
 {
-	return PAGE_ALIGN(ads->golden_lrc_size);
+	return ALIGN(ads->golden_lrc_size, GUC_ALIGN);
 }
 
 static u32 guc_ads_waklv_size(struct xe_guc_ads *ads)
 {
-	return PAGE_ALIGN(ads->ads_waklv_size);
+	return ALIGN(ads->ads_waklv_size, GUC_ALIGN);
 }
 
 static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
 {
-	return PAGE_ALIGN(ads->capture_size);
+	return ALIGN(ads->capture_size, GUC_ALIGN);
 }
 
 static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
@@ -169,7 +169,7 @@ static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
 
 static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
 {
-	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
+	return ALIGN(ads_to_guc(ads)->fw.private_data_size, GUC_ALIGN);
 }
 
 static size_t guc_ads_regset_offset(struct xe_guc_ads *ads)
@@ -184,7 +184,7 @@ static size_t guc_ads_golden_lrc_offset(struct xe_guc_ads *ads)
 	offset = guc_ads_regset_offset(ads) +
 		guc_ads_regset_size(ads);
 
-	return PAGE_ALIGN(offset);
+	return ALIGN(offset, GUC_ALIGN);
 }
 
 static size_t guc_ads_waklv_offset(struct xe_guc_ads *ads)
@@ -194,7 +194,7 @@ static size_t guc_ads_waklv_offset(struct xe_guc_ads *ads)
 	offset = guc_ads_golden_lrc_offset(ads) +
 		 guc_ads_golden_lrc_size(ads);
 
-	return PAGE_ALIGN(offset);
+	return ALIGN(offset, GUC_ALIGN);
 }
 
 static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
@@ -204,7 +204,7 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
 	offset = guc_ads_waklv_offset(ads) +
 		 guc_ads_waklv_size(ads);
 
-	return PAGE_ALIGN(offset);
+	return ALIGN(offset, GUC_ALIGN);
 }
 
 static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
@@ -214,7 +214,7 @@ static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
 	offset = guc_ads_capture_offset(ads) +
 		 guc_ads_capture_size(ads);
 
-	return PAGE_ALIGN(offset);
+	return ALIGN(offset, GUC_ALIGN);
 }
 
 static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
@@ -224,7 +224,7 @@ static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
 	offset = guc_ads_um_queues_offset(ads) +
 		guc_ads_um_queues_size(ads);
 
-	return PAGE_ALIGN(offset);
+	return ALIGN(offset, GUC_ALIGN);
 }
 
 static size_t guc_ads_size(struct xe_guc_ads *ads)
@@ -277,7 +277,7 @@ static size_t calculate_golden_lrc_size(struct xe_guc_ads *ads)
 			continue;
 
 		real_size = xe_gt_lrc_size(gt, class);
-		alloc_size = PAGE_ALIGN(real_size);
+		alloc_size = ALIGN(real_size, GUC_ALIGN);
 		total_size += alloc_size;
 	}
 
@@ -647,12 +647,12 @@ static int guc_capture_prep_lists(struct xe_guc_ads *ads)
 					 offsetof(struct __guc_ads_blob, system_info));
 
 	/* first, set aside the first page for a capture_list with zero descriptors */
-	total_size = PAGE_SIZE;
+	total_size = GUC_ALIGN;
 	if (!xe_guc_capture_getnullheader(guc, &ptr, &size))
 		xe_map_memcpy_to(ads_to_xe(ads), ads_to_map(ads), capture_offset, ptr, size);
 
 	null_ggtt = ads_ggtt + capture_offset;
-	capture_offset += PAGE_SIZE;
+	capture_offset += GUC_ALIGN;
 
 	/*
 	 * Populate capture list : at this point adps is already allocated and
@@ -716,10 +716,10 @@ static int guc_capture_prep_lists(struct xe_guc_ads *ads)
 		}
 	}
 
-	if (ads->capture_size != PAGE_ALIGN(total_size))
+	if (ads->capture_size != ALIGN(total_size, GUC_ALIGN))
 		xe_gt_dbg(gt, "Updated ADS capture size %d (was %d)\n",
-			  PAGE_ALIGN(total_size), ads->capture_size);
-	return PAGE_ALIGN(total_size);
+			  ALIGN(total_size, GUC_ALIGN), ads->capture_size);
+	return ALIGN(total_size, GUC_ALIGN);
 }
 
 static void guc_mmio_regset_write_one(struct xe_guc_ads *ads,
@@ -967,7 +967,7 @@ static void guc_golden_lrc_populate(struct xe_guc_ads *ads)
 		xe_gt_assert(gt, gt->default_lrc[class]);
 
 		real_size = xe_gt_lrc_size(gt, class);
-		alloc_size = PAGE_ALIGN(real_size);
+		alloc_size = ALIGN(real_size, GUC_ALIGN);
 		total_size += alloc_size;
 
 		xe_map_memcpy_to(xe, ads_to_map(ads), offset,
diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 859a3ba91be5..34e9ea9b2935 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -591,8 +591,8 @@ guc_capture_getlistsize(struct xe_guc *guc, u32 owner, u32 type,
 		return -ENODATA;
 
 	if (size)
-		*size = PAGE_ALIGN((sizeof(struct guc_debug_capture_list)) +
-				   (num_regs * sizeof(struct guc_mmio_reg)));
+		*size = ALIGN((sizeof(struct guc_debug_capture_list)) +
+			      (num_regs * sizeof(struct guc_mmio_reg)), GUC_ALIGN);
 
 	return 0;
 }
@@ -739,7 +739,7 @@ size_t xe_guc_capture_ads_input_worst_size(struct xe_guc *guc)
 	 * sequence, that is, during the pre-hwconfig phase before we have
 	 * the exact engine fusing info.
 	 */
-	total_size = PAGE_SIZE;	/* Pad a page in front for empty lists */
+	total_size = GUC_ALIGN;	/* Pad a page in front for empty lists */
 	for (i = 0; i < GUC_CAPTURE_LIST_INDEX_MAX; i++) {
 		for (j = 0; j < GUC_CAPTURE_LIST_CLASS_MAX; j++) {
 			if (xe_guc_capture_getlistsize(guc, i,
@@ -759,7 +759,7 @@ size_t xe_guc_capture_ads_input_worst_size(struct xe_guc *guc)
 		total_size += global_size;
 	}
 
-	return PAGE_ALIGN(total_size);
+	return ALIGN(total_size, GUC_ALIGN);
 }
 
 static int guc_capture_output_size_est(struct xe_guc *guc)
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index b6acccfcd351..557c14b386fd 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -223,7 +223,7 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
 	struct xe_gt *gt = ct_to_gt(ct);
 	int err;
 
-	xe_gt_assert(gt, !(guc_ct_size() % PAGE_SIZE));
+	xe_gt_assert(gt, !(guc_ct_size() % GUC_ALIGN));
 
 	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", WQ_MEM_RECLAIM);
 	if (!ct->g2h_wq)
diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index c01ccb35dc75..becf74a28d90 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -15,6 +15,7 @@
 #include "xe_force_wake.h"
 #include "xe_gt.h"
 #include "xe_gt_printk.h"
+#include "xe_guc.h"
 #include "xe_map.h"
 #include "xe_mmio.h"
 #include "xe_module.h"
@@ -58,7 +59,7 @@ static size_t guc_log_size(void)
 	 *  |         Capture logs          |
 	 *  +===============================+ + CAPTURE_SIZE
 	 */
-	return PAGE_SIZE + CRASH_BUFFER_SIZE + DEBUG_BUFFER_SIZE +
+	return GUC_ALIGN + CRASH_BUFFER_SIZE + DEBUG_BUFFER_SIZE +
 		CAPTURE_BUFFER_SIZE;
 }
 
@@ -328,7 +329,7 @@ u32 xe_guc_get_log_buffer_size(struct xe_guc_log *log, enum guc_log_buffer_type
 u32 xe_guc_get_log_buffer_offset(struct xe_guc_log *log, enum guc_log_buffer_type type)
 {
 	enum guc_log_buffer_type i;
-	u32 offset = PAGE_SIZE;/* for the log_buffer_states */
+	u32 offset = GUC_ALIGN;	/* for the log_buffer_states */
 
 	for (i = GUC_LOG_BUFFER_CRASH_DUMP; i < GUC_LOG_BUFFER_TYPE_MAX; ++i) {
 		if (i == type)
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 68b192fe3b32..5a69b5682fc8 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -1190,7 +1190,7 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
 {
 	struct xe_device *xe = pc_to_xe(pc);
 	struct xe_gt *gt = pc_to_gt(pc);
-	u32 size = PAGE_ALIGN(sizeof(struct slpc_shared_data));
+	u32 size = ALIGN(sizeof(struct slpc_shared_data), GUC_ALIGN);
 	unsigned int fw_ref;
 	ktime_t earlier;
 	int ret;
@@ -1318,7 +1318,7 @@ int xe_guc_pc_init(struct xe_guc_pc *pc)
 	struct xe_tile *tile = gt_to_tile(gt);
 	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_bo *bo;
-	u32 size = PAGE_ALIGN(sizeof(struct slpc_shared_data));
+	u32 size = ALIGN(sizeof(struct slpc_shared_data), GUC_ALIGN);
 	int err;
 
 	if (xe->info.skip_guc_pc)
-- 
2.47.2


