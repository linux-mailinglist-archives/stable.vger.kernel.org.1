Return-Path: <stable+bounces-140559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B51AAAE16
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355C216B36F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7827F740;
	Mon,  5 May 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHY9nrsI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8136127F;
	Mon,  5 May 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485148; cv=none; b=QlvWrNH3hgtS3h3FjGY6Sx7X0v+Kc12J1Rcq6/oswiGTtMlk4dAtRZ0jJAVlALLdzKUuQ9hEeqefq4GGF+xuOJEMYQi3n0K9jIg92igyBJC0X3+jqx12oFKZzfewJOwKj9SPXbp1s91g658yWoItO6C9429KE1BaRII0xGSdJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485148; c=relaxed/simple;
	bh=IafRBD/jEyGO5Ye/U4fLc8c8KFzd/zjgQ46BK4wrpJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr/RRsz34Q5TiWJP+M2+/+es+mwSPsK9n/7wFhEydLERFrEaj4bl9W+5JKj42LZ8W2j9OUfZB2qAQZKeiO/qlTII03TW5VRvypiJoYIw4SONJZW3g+cq4HdNlyXdx9L25dyMX6WDRETiPrd5TiGUVZaKlmZr5cvRhmZzzGuhk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHY9nrsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8EEC4CEE4;
	Mon,  5 May 2025 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485145;
	bh=IafRBD/jEyGO5Ye/U4fLc8c8KFzd/zjgQ46BK4wrpJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHY9nrsIIWUlqnxH2yJf4Nz28YCcUdpGrjjHCAsnkc456dKP2DWKDRHkhnPxrkJIo
	 pPj39fjx2Xgp9zCsbGuSSVgGRGLsh6A5mMRJfF4BfF8CAyPQVr+42SAlKudRqZ90vc
	 wLZkFHxAeBQBRFkzdHuuibggou+eimuG4dfcxF2NR6mS9MFeQk56uFB8M3Y1gy+bAf
	 itn+qYJCVqYvJbQIZ+vYk6jZjdrgPFWTXXAfKN7sqAIP2So1Tmy7FZw6Qbie08hZBb
	 TjIALzkj60rpNup0uNbFmn5FCnb0r6QUMBsOdgDPVX1fEJwev8wqcfsKGYkpDKau8g
	 SKl21CzRhDQXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 183/486] drm/xe: Nuke VM's mapping upon close
Date: Mon,  5 May 2025 18:34:19 -0400
Message-Id: <20250505223922.2682012-183-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 074e40d9c2a84939fe28d7121d3469db50f34a3d ]

Clear root PT entry and invalidate entire VM's address space when
closing the VM. Will prevent the GPU from accessing any of the VM's
memory after closing.

v2:
 - s/vma/vm in kernel doc (CI)
 - Don't nuke migration VM as this occur at driver unload (CI)
v3:
 - Rebase and pull into SVM series (Thomas)
 - Wait for pending binds (Thomas)
v5:
 - Remove xe_gt_tlb_invalidation_fence_fini in error case (Matt Auld)
 - Drop local migration bool (Thomas)
v7:
 - Add drm_dev_enter/exit protecting invalidation (CI, Matt Auld)

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250306012657.3505757-12-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 22 ++++++++++++++
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h |  2 ++
 drivers/gpu/drm/xe/xe_pt.c                  | 14 +++++++++
 drivers/gpu/drm/xe/xe_pt.h                  |  3 ++
 drivers/gpu/drm/xe/xe_vm.c                  | 32 +++++++++++++++++++++
 5 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 98a450271f5ce..3155825fa46ad 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -406,6 +406,28 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
 	return send_tlb_invalidation(&gt->uc.guc, fence, action, len);
 }
 
+/**
+ * xe_gt_tlb_invalidation_vm - Issue a TLB invalidation on this GT for a VM
+ * @gt: graphics tile
+ * @vm: VM to invalidate
+ *
+ * Invalidate entire VM's address space
+ */
+void xe_gt_tlb_invalidation_vm(struct xe_gt *gt, struct xe_vm *vm)
+{
+	struct xe_gt_tlb_invalidation_fence fence;
+	u64 range = 1ull << vm->xe->info.va_bits;
+	int ret;
+
+	xe_gt_tlb_invalidation_fence_init(gt, &fence, true);
+
+	ret = xe_gt_tlb_invalidation_range(gt, &fence, 0, range, vm->usm.asid);
+	if (ret < 0)
+		return;
+
+	xe_gt_tlb_invalidation_fence_wait(&fence);
+}
+
 /**
  * xe_gt_tlb_invalidation_vma - Issue a TLB invalidation on this GT for a VMA
  * @gt: graphics tile
diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h
index 672acfcdf0d70..abe9b03d543e6 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h
@@ -12,6 +12,7 @@
 
 struct xe_gt;
 struct xe_guc;
+struct xe_vm;
 struct xe_vma;
 
 int xe_gt_tlb_invalidation_init_early(struct xe_gt *gt);
@@ -21,6 +22,7 @@ int xe_gt_tlb_invalidation_ggtt(struct xe_gt *gt);
 int xe_gt_tlb_invalidation_vma(struct xe_gt *gt,
 			       struct xe_gt_tlb_invalidation_fence *fence,
 			       struct xe_vma *vma);
+void xe_gt_tlb_invalidation_vm(struct xe_gt *gt, struct xe_vm *vm);
 int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
 				 struct xe_gt_tlb_invalidation_fence *fence,
 				 u64 start, u64 end, u32 asid);
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 230cf47fb9c5e..fb94ff55c7361 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -217,6 +217,20 @@ void xe_pt_destroy(struct xe_pt *pt, u32 flags, struct llist_head *deferred)
 	xe_pt_free(pt);
 }
 
+/**
+ * xe_pt_clear() - Clear a page-table.
+ * @xe: xe device.
+ * @pt: The page-table.
+ *
+ * Clears page-table by setting to zero.
+ */
+void xe_pt_clear(struct xe_device *xe, struct xe_pt *pt)
+{
+	struct iosys_map *map = &pt->bo->vmap;
+
+	xe_map_memset(xe, map, 0, 0, SZ_4K);
+}
+
 /**
  * DOC: Pagetable building
  *
diff --git a/drivers/gpu/drm/xe/xe_pt.h b/drivers/gpu/drm/xe/xe_pt.h
index 9ab386431cadd..8e43912ae8e94 100644
--- a/drivers/gpu/drm/xe/xe_pt.h
+++ b/drivers/gpu/drm/xe/xe_pt.h
@@ -13,6 +13,7 @@ struct dma_fence;
 struct xe_bo;
 struct xe_device;
 struct xe_exec_queue;
+struct xe_svm_range;
 struct xe_sync_entry;
 struct xe_tile;
 struct xe_vm;
@@ -35,6 +36,8 @@ void xe_pt_populate_empty(struct xe_tile *tile, struct xe_vm *vm,
 
 void xe_pt_destroy(struct xe_pt *pt, u32 flags, struct llist_head *deferred);
 
+void xe_pt_clear(struct xe_device *xe, struct xe_pt *pt);
+
 int xe_pt_update_ops_prepare(struct xe_tile *tile, struct xe_vma_ops *vops);
 struct dma_fence *xe_pt_update_ops_run(struct xe_tile *tile,
 				       struct xe_vma_ops *vops);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 872de052d670f..de257a032225f 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -8,6 +8,7 @@
 #include <linux/dma-fence-array.h>
 #include <linux/nospec.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_exec.h>
 #include <drm/drm_print.h>
 #include <drm/ttm/ttm_execbuf_util.h>
@@ -1581,9 +1582,40 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
 
 static void xe_vm_close(struct xe_vm *vm)
 {
+	struct xe_device *xe = vm->xe;
+	bool bound;
+	int idx;
+
+	bound = drm_dev_enter(&xe->drm, &idx);
+
 	down_write(&vm->lock);
+
 	vm->size = 0;
+
+	if (!((vm->flags & XE_VM_FLAG_MIGRATION))) {
+		struct xe_tile *tile;
+		struct xe_gt *gt;
+		u8 id;
+
+		/* Wait for pending binds */
+		dma_resv_wait_timeout(xe_vm_resv(vm),
+				      DMA_RESV_USAGE_BOOKKEEP,
+				      false, MAX_SCHEDULE_TIMEOUT);
+
+		if (bound) {
+			for_each_tile(tile, xe, id)
+				if (vm->pt_root[id])
+					xe_pt_clear(xe, vm->pt_root[id]);
+
+			for_each_gt(gt, xe, id)
+				xe_gt_tlb_invalidation_vm(gt, vm);
+		}
+	}
+
 	up_write(&vm->lock);
+
+	if (bound)
+		drm_dev_exit(idx);
 }
 
 void xe_vm_close_and_put(struct xe_vm *vm)
-- 
2.39.5


