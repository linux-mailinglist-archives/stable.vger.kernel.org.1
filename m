Return-Path: <stable+bounces-92712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F609C55C4
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8066D28EE94
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2F219E37;
	Tue, 12 Nov 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0KkFDkoW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA6214416;
	Tue, 12 Nov 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408344; cv=none; b=CenBm9dK/5SmDnbeJ717mdbfkOA9fAgh9DQXCgtzf7gHyBqqntliZr17YIBLPwamLUym5Fp45Rnyp4xs0kXSd3TRyRtavS8viXyLZH0oTjWTnj29+mnwWKMBa7xp2SsA1mWKxxVt7xR7wc8JPMcFu2oH2bPEk4Id4isLzu2Y2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408344; c=relaxed/simple;
	bh=ePPGsEyQwcHci78f5J+5qwkLqIU/vja0ZbCKPFLgNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbUgMmddbPrEHGgtOKCTcCy521JNEWl+t1xycQ2tHBQv2WTl9QSx6Wq4WJfxJIlJE4FV38m7vbxuv1JQX3c905esrQm1UM3Nqz+CFHvN4hS+bxIT/oZk9TV8i5J6Qw9EE6SmcCnH5RW/Fk7j662+iLq1OqzjF1O0oqKWZTtfysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0KkFDkoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A36C4CECD;
	Tue, 12 Nov 2024 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408344;
	bh=ePPGsEyQwcHci78f5J+5qwkLqIU/vja0ZbCKPFLgNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0KkFDkoWUZRo118vejakTcwxyrK+My69keBMYKAXGK/fxGwuxNjKGc/b9D4RwbYK4
	 2Py9hiblcP4xB00+Qj4VZ6Cbqa5+IIO8EU/e27TzwkBx56O6LrNfV9KNDoKlGZRqDi
	 fKH1zb26cb8Vl7rmv/eR8j6/6SshgGdyXmlKI/mo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brendan King <brendan.king@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>
Subject: [PATCH 6.11 102/184] drm/imagination: Break an object reference loop
Date: Tue, 12 Nov 2024 11:21:00 +0100
Message-ID: <20241112101904.778102037@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brendan King <brendan.king@imgtec.com>

commit b04ce1e718bd55302b52d05d6873e233cb3ec7a1 upstream.

When remaining resources are being cleaned up on driver close,
outstanding VM mappings may result in resources being leaked, due
to an object reference loop, as shown below, with each object (or
set of objects) referencing the object below it:

    PVR GEM Object
    GPU scheduler "finished" fence
    GPU scheduler “scheduled” fence
    PVR driver “done” fence
    PVR Context
    PVR VM Context
    PVR VM Mappings
    PVR GEM Object

The reference that the PVR VM Context has on the VM mappings is a
soft one, in the sense that the freeing of outstanding VM mappings
is done as part of VM context destruction; no reference counts are
involved, as is the case for all the other references in the loop.

To break the reference loop during cleanup, free the outstanding
VM mappings before destroying the PVR Context associated with the
VM context.

Signed-off-by: Brendan King <brendan.king@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Reviewed-by: Frank Binns <frank.binns@imgtec.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/8a25924f-1bb7-4d9a-a346-58e871dfb1d1@imgtec.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imagination/pvr_context.c |   19 +++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_context.h |   18 ++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_vm.c      |   22 ++++++++++++++++++----
 drivers/gpu/drm/imagination/pvr_vm.h      |    1 +
 4 files changed, 56 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -450,11 +450,30 @@ pvr_context_destroy(struct pvr_file *pvr
  */
 void pvr_destroy_contexts_for_file(struct pvr_file *pvr_file)
 {
+	struct pvr_device *pvr_dev = pvr_file->pvr_dev;
 	struct pvr_context *ctx;
 	unsigned long handle;
 
 	xa_for_each(&pvr_file->ctx_handles, handle, ctx)
 		pvr_context_destroy(pvr_file, handle);
+
+	spin_lock(&pvr_dev->ctx_list_lock);
+	ctx = list_first_entry(&pvr_file->contexts, struct pvr_context, file_link);
+
+	while (!list_entry_is_head(ctx, &pvr_file->contexts, file_link)) {
+		list_del_init(&ctx->file_link);
+
+		if (pvr_context_get_if_referenced(ctx)) {
+			spin_unlock(&pvr_dev->ctx_list_lock);
+
+			pvr_vm_unmap_all(ctx->vm_ctx);
+
+			pvr_context_put(ctx);
+			spin_lock(&pvr_dev->ctx_list_lock);
+		}
+		ctx = list_first_entry(&pvr_file->contexts, struct pvr_context, file_link);
+	}
+	spin_unlock(&pvr_dev->ctx_list_lock);
 }
 
 /**
--- a/drivers/gpu/drm/imagination/pvr_context.h
+++ b/drivers/gpu/drm/imagination/pvr_context.h
@@ -127,6 +127,24 @@ pvr_context_get(struct pvr_context *ctx)
 }
 
 /**
+ * pvr_context_get_if_referenced() - Take an additional reference on a still
+ * referenced context.
+ * @ctx: Context pointer.
+ *
+ * Call pvr_context_put() to release.
+ *
+ * Returns:
+ *  * True on success, or
+ *  * false if no context pointer passed, or the context wasn't still
+ *  * referenced.
+ */
+static __always_inline bool
+pvr_context_get_if_referenced(struct pvr_context *ctx)
+{
+	return ctx != NULL && kref_get_unless_zero(&ctx->ref_count) != 0;
+}
+
+/**
  * pvr_context_lookup() - Lookup context pointer from handle and file.
  * @pvr_file: Pointer to pvr_file structure.
  * @handle: Context handle.
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -14,6 +14,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_gpuvm.h>
 
+#include <linux/bug.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -597,12 +598,26 @@ err_free:
 }
 
 /**
- * pvr_vm_context_release() - Teardown a VM context.
- * @ref_count: Pointer to reference counter of the VM context.
+ * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
+ * @vm_ctx: Target VM context.
  *
  * This function ensures that no mappings are left dangling by unmapping them
  * all in order of ascending device-virtual address.
  */
+void
+pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
+{
+	WARN_ON(pvr_vm_unmap(vm_ctx, vm_ctx->gpuvm_mgr.mm_start,
+			     vm_ctx->gpuvm_mgr.mm_range));
+}
+
+/**
+ * pvr_vm_context_release() - Teardown a VM context.
+ * @ref_count: Pointer to reference counter of the VM context.
+ *
+ * This function also ensures that no mappings are left dangling by calling
+ * pvr_vm_unmap_all.
+ */
 static void
 pvr_vm_context_release(struct kref *ref_count)
 {
@@ -612,8 +627,7 @@ pvr_vm_context_release(struct kref *ref_
 	if (vm_ctx->fw_mem_ctx_obj)
 		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
 
-	WARN_ON(pvr_vm_unmap(vm_ctx, vm_ctx->gpuvm_mgr.mm_start,
-			     vm_ctx->gpuvm_mgr.mm_range));
+	pvr_vm_unmap_all(vm_ctx);
 
 	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
 	drm_gem_private_object_fini(&vm_ctx->dummy_gem);
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -39,6 +39,7 @@ int pvr_vm_map(struct pvr_vm_context *vm
 	       struct pvr_gem_object *pvr_obj, u64 pvr_obj_offset,
 	       u64 device_addr, u64 size);
 int pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size);
+void pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx);
 
 dma_addr_t pvr_vm_get_page_table_root_addr(struct pvr_vm_context *vm_ctx);
 struct dma_resv *pvr_vm_get_dma_resv(struct pvr_vm_context *vm_ctx);



