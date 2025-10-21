Return-Path: <stable+bounces-188353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BABF6FD8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA23464035
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC833B948;
	Tue, 21 Oct 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf+eT4Ho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460533B943
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055896; cv=none; b=DySoOXuE3kVO2hQHBzV8OczoVkDkUnPxS4j6cztY9KjhuyNyXu9nrqEVfBs1U3rJ73es6suUojajeTzHPm4xJdvRNzCdAQpRcsIqNIfQAUI5Pehf2gbB9TFGVAcC5cC6SNIalc8BYu3pDMVAq2SKENbyemqH+7NUk3VXqZJ8CsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055896; c=relaxed/simple;
	bh=qhpDDWHXCKWpQOwUtFHMqDQXM10R3JS0MkdzjGtwt4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0kuO6pENstvc8zF6hnJ8dI9gonH4ibe/Pl81NW5EB43/6lTDvSz1r8uW09WIwvKJAF4W68OIuqXUct8oe9GZdCnEtTPpmsWirrmU/zoNYB3Wx276oWxUUPXG69WDDKTf+pjjK2faW3Bgcvrabzl3W54DJWMEYpch6fksVN1HTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf+eT4Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAFEC4CEF1;
	Tue, 21 Oct 2025 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761055895;
	bh=qhpDDWHXCKWpQOwUtFHMqDQXM10R3JS0MkdzjGtwt4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mf+eT4HoyXfH6dWbwE9dc0nUe1lQa5jIJtlVjxmpIza2gqi0j242bZbXsRsJSAkGs
	 qn26gKefLFFsPI9AHx8+UfZfE8SWDml6aKydDBLDSQcIbqpx1V475tHudjSlfFcIYn
	 ASewwny7XCvYqmc94eIEaOCwx35x0nU2CMvUEI0DK11Jeg3WW1mLYu9jsgL9+13f6w
	 /EkgPstuzt0HmiMYfD3zpNniDPl8QsmRQpBkIF9ykB69M9XzqIyhYA51BpZ/8JPT/a
	 elJHnfOkmvtnswALacjrVD2PFg5aei/nDO6aAQ+MuMOugRqjE/cRJWUMt80K2fJrjL
	 0xV8yJRv9RsRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Paulo Zanoni <paulo.r.zanoni@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y] drm/xe: Don't allow evicting of BOs in same VM in array of VM binds
Date: Tue, 21 Oct 2025 10:11:33 -0400
Message-ID: <20251021141133.2151101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102048-unrushed-state-ce5e@gregkh>
References: <2025102048-unrushed-state-ce5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 7ac74613e5f2ef3450f44fd2127198662c2563a9 ]

An array of VM binds can potentially evict other buffer objects (BOs)
within the same VM under certain conditions, which may lead to NULL
pointer dereferences later in the bind pipeline. To prevent this, clear
the allow_res_evict flag in the xe_bo_validate call.

v2:
 - Invert polarity of no_res_evict (Thomas)
 - Add comment in code explaining issue (Thomas)

Cc: stable@vger.kernel.org
Reported-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6268
Fixes: 774b5fa509a9 ("drm/xe: Avoid evicting object of the same vm in none fault mode")
Fixes: 77f2ef3f16f5 ("drm/xe: Lock all gpuva ops during VM bind IOCTL")
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Tested-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://lore.kernel.org/r/20251009110618.3481870-1-matthew.brost@intel.com
(cherry picked from commit 8b9ba8d6d95fe75fed6b0480bb03da4b321bea08)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
[ removed exec parameter from xe_bo_validate() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vm.c       | 32 +++++++++++++++++++++++---------
 drivers/gpu/drm/xe/xe_vm_types.h |  2 ++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5146999d27fa2..bf44cd5bf49c0 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2894,7 +2894,7 @@ static void vm_bind_ioctl_ops_unwind(struct xe_vm *vm,
 }
 
 static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
-				 bool validate)
+				 bool res_evict, bool validate)
 {
 	struct xe_bo *bo = xe_vma_bo(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
@@ -2905,7 +2905,8 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 			err = drm_exec_lock_obj(exec, &bo->ttm.base);
 		if (!err && validate)
 			err = xe_bo_validate(bo, vm,
-					     !xe_vm_in_preempt_fence_mode(vm));
+					     !xe_vm_in_preempt_fence_mode(vm) &&
+					     res_evict);
 	}
 
 	return err;
@@ -2978,14 +2979,23 @@ static int prefetch_ranges(struct xe_vm *vm, struct xe_vma_op *op)
 }
 
 static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
-			    struct xe_vma_op *op)
+			    struct xe_vma_ops *vops, struct xe_vma_op *op)
 {
 	int err = 0;
+	bool res_evict;
+
+	/*
+	 * We only allow evicting a BO within the VM if it is not part of an
+	 * array of binds, as an array of binds can evict another BO within the
+	 * bind.
+	 */
+	res_evict = !(vops->flags & XE_VMA_OPS_ARRAY_OF_BINDS);
 
 	switch (op->base.op) {
 	case DRM_GPUVA_OP_MAP:
 		if (!op->map.invalidate_on_bind)
 			err = vma_lock_and_validate(exec, op->map.vma,
+						    res_evict,
 						    !xe_vm_in_fault_mode(vm) ||
 						    op->map.immediate);
 		break;
@@ -2996,11 +3006,13 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.remap.unmap->va),
-					    false);
+					    res_evict, false);
 		if (!err && op->remap.prev)
-			err = vma_lock_and_validate(exec, op->remap.prev, true);
+			err = vma_lock_and_validate(exec, op->remap.prev,
+						    res_evict, true);
 		if (!err && op->remap.next)
-			err = vma_lock_and_validate(exec, op->remap.next, true);
+			err = vma_lock_and_validate(exec, op->remap.next,
+						    res_evict, true);
 		break;
 	case DRM_GPUVA_OP_UNMAP:
 		err = check_ufence(gpuva_to_vma(op->base.unmap.va));
@@ -3009,7 +3021,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.unmap.va),
-					    false);
+					    res_evict, false);
 		break;
 	case DRM_GPUVA_OP_PREFETCH:
 	{
@@ -3025,7 +3037,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.prefetch.va),
-					    false);
+					    res_evict, false);
 		if (!err && !xe_vma_has_no_bo(vma))
 			err = xe_bo_migrate(xe_vma_bo(vma),
 					    region_to_mem_type[region]);
@@ -3069,7 +3081,7 @@ static int vm_bind_ioctl_ops_lock_and_prep(struct drm_exec *exec,
 		return err;
 
 	list_for_each_entry(op, &vops->list, link) {
-		err = op_lock_and_prep(exec, vm, op);
+		err = op_lock_and_prep(exec, vm, vops, op);
 		if (err)
 			return err;
 	}
@@ -3698,6 +3710,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	xe_vma_ops_init(&vops, vm, q, syncs, num_syncs);
+	if (args->num_binds > 1)
+		vops.flags |= XE_VMA_OPS_ARRAY_OF_BINDS;
 	for (i = 0; i < args->num_binds; ++i) {
 		u64 range = bind_ops[i].range;
 		u64 addr = bind_ops[i].addr;
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 6058cf739388b..f6616d595999f 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -467,6 +467,8 @@ struct xe_vma_ops {
 	struct xe_vm_pgtable_update_ops pt_update_ops[XE_MAX_TILES_PER_DEVICE];
 	/** @flag: signify the properties within xe_vma_ops*/
 #define XE_VMA_OPS_FLAG_HAS_SVM_PREFETCH BIT(0)
+#define XE_VMA_OPS_FLAG_MADVISE          BIT(1)
+#define XE_VMA_OPS_ARRAY_OF_BINDS	 BIT(2)
 	u32 flags;
 #ifdef TEST_VM_OPS_ERROR
 	/** @inject_error: inject error to test error handling */
-- 
2.51.0


