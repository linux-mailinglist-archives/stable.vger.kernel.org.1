Return-Path: <stable+bounces-187984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5183BEFDE6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB9D94E5AE6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0462C0F63;
	Mon, 20 Oct 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QP6dWQtU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793822E3B11
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948151; cv=none; b=ggaFFHMM3fp/s6Q1ukhEqeZD1ibHueaD+BGcHn/0sOP9phwwOHms7NlcLBAEVG+kEtbyP/auEKZqS7HFszjNUAsYeDvsap4alLEyghMInbTSrBL/W46GvPl7D1zXIlWBS2us1rfNfO2EXElLG/hwyyPkdBnE2GqREYxt6iNUjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948151; c=relaxed/simple;
	bh=G15GVDPiNNy609jX/klj/fpAYq+mdIRPSv5l0weIW+o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fVdPKtRPHhL7s9bTuObyzgmpJNg2xiGI4Wm6lIrnD/RlyGazBrhHJaOxZUMQ6a4xBCLax/cCi+PEVoSHXZwbVWnPt95P233XlMXPBlmYxfeEAp6b+MynvCCeuOM7rR/zGcTqbXq4vzia5XdZRGY8joBCI4LSQknDO/pQZRHdvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QP6dWQtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE083C4CEF9;
	Mon, 20 Oct 2025 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760948151;
	bh=G15GVDPiNNy609jX/klj/fpAYq+mdIRPSv5l0weIW+o=;
	h=Subject:To:Cc:From:Date:From;
	b=QP6dWQtU6VjCrCoINWg3J93HMcu1JpvwKZRDUMSTq8WdoBTzTR+1CuDsLDGgjfjwe
	 d0LhHmviF18+p465mvEYB3LEx1j3F1yS7X/NzYNzPuvV6vrBzOPccLbofkHRsXNXmK
	 DiCJnjaiiHRet9D8VSnU6XidCmjfrrJaVIOyGUa0=
Subject: FAILED: patch "[PATCH] drm/xe: Don't allow evicting of BOs in same VM in array of VM" failed to apply to 6.17-stable tree
To: matthew.brost@intel.com,lucas.demarchi@intel.com,paulo.r.zanoni@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:15:48 +0200
Message-ID: <2025102048-unrushed-state-ce5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 7ac74613e5f2ef3450f44fd2127198662c2563a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102048-unrushed-state-ce5e@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ac74613e5f2ef3450f44fd2127198662c2563a9 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 9 Oct 2025 04:06:18 -0700
Subject: [PATCH] drm/xe: Don't allow evicting of BOs in same VM in array of VM
 binds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 027e6ce648c5..f602b874e054 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2832,7 +2832,7 @@ static void vm_bind_ioctl_ops_unwind(struct xe_vm *vm,
 }
 
 static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
-				 bool validate)
+				 bool res_evict, bool validate)
 {
 	struct xe_bo *bo = xe_vma_bo(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
@@ -2843,7 +2843,8 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 			err = drm_exec_lock_obj(exec, &bo->ttm.base);
 		if (!err && validate)
 			err = xe_bo_validate(bo, vm,
-					     !xe_vm_in_preempt_fence_mode(vm), exec);
+					     !xe_vm_in_preempt_fence_mode(vm) &&
+					     res_evict, exec);
 	}
 
 	return err;
@@ -2913,14 +2914,23 @@ static int prefetch_ranges(struct xe_vm *vm, struct xe_vma_op *op)
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
@@ -2931,11 +2941,13 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
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
@@ -2944,7 +2956,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.unmap.va),
-					    false);
+					    res_evict, false);
 		break;
 	case DRM_GPUVA_OP_PREFETCH:
 	{
@@ -2959,7 +2971,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
 
 		err = vma_lock_and_validate(exec,
 					    gpuva_to_vma(op->base.prefetch.va),
-					    false);
+					    res_evict, false);
 		if (!err && !xe_vma_has_no_bo(vma))
 			err = xe_bo_migrate(xe_vma_bo(vma),
 					    region_to_mem_type[region],
@@ -3005,7 +3017,7 @@ static int vm_bind_ioctl_ops_lock_and_prep(struct drm_exec *exec,
 		return err;
 
 	list_for_each_entry(op, &vops->list, link) {
-		err = op_lock_and_prep(exec, vm, op);
+		err = op_lock_and_prep(exec, vm, vops, op);
 		if (err)
 			return err;
 	}
@@ -3638,6 +3650,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	xe_vma_ops_init(&vops, vm, q, syncs, num_syncs);
+	if (args->num_binds > 1)
+		vops.flags |= XE_VMA_OPS_ARRAY_OF_BINDS;
 	for (i = 0; i < args->num_binds; ++i) {
 		u64 range = bind_ops[i].range;
 		u64 addr = bind_ops[i].addr;
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index da39940501d8..413353e1c225 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -476,6 +476,7 @@ struct xe_vma_ops {
 	/** @flag: signify the properties within xe_vma_ops*/
 #define XE_VMA_OPS_FLAG_HAS_SVM_PREFETCH BIT(0)
 #define XE_VMA_OPS_FLAG_MADVISE          BIT(1)
+#define XE_VMA_OPS_ARRAY_OF_BINDS	 BIT(2)
 	u32 flags;
 #ifdef TEST_VM_OPS_ERROR
 	/** @inject_error: inject error to test error handling */


