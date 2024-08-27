Return-Path: <stable+bounces-71112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4B9611B0
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D4CB21879
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF91A072D;
	Tue, 27 Aug 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qzZ5viOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F119F485;
	Tue, 27 Aug 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772140; cv=none; b=JezjxuQ4VZh4p9ctMoxgx4I3Ul8K17LeIrPZclYm9DvP8E4nHd3xY5xXqfGwfs1sy6kwosfJGgPh4t+mGIbyELye0neaWspnjhMGp+QygxFjb2WiIgHg1qj3ac3pN9t9bKtz69YNUu7n5A+6uCaabmc8jA5J9Vy3nptoUqcvQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772140; c=relaxed/simple;
	bh=nfxHcTOBfWXNeW8CW0N4V1ci7JT0nz592OfEehsomIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/Ik/s3i0vGGzQhdknX9fJQqFDa6FOhACKmHE1qteHNiPU4FEM+R3LvtzTDo0tUJ/BcbkDYc/Z1QxvOZndT0wn6D0cxz5szy1WsDeSGwazyaqMsDiI9/nRDDKiZQy7KxhqRdepbi2nNbBzxooVfuQGZSQ6SmPKXXWrFfRxtNBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qzZ5viOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B40C4FE08;
	Tue, 27 Aug 2024 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772140;
	bh=nfxHcTOBfWXNeW8CW0N4V1ci7JT0nz592OfEehsomIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzZ5viOrfefIMQWfkDysdoe3cZ1TMkGtYJ6XDYB6K3tI6nh5YBhCOKzcobOT9dNLZ
	 JHM0q1rIP9CjEYJkXIf0/WcmcFOepCDIp0uWA5WY+++Z4hBZZmw0nSdMdGuZXvEWG2
	 9Nrn7ZUduEbH79dT9rG2FhQKQ6ilS2ZJKzTKBvA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/321] drm/amdkfd: Move dma unmapping after TLB flush
Date: Tue, 27 Aug 2024 16:37:13 +0200
Message-ID: <20240827143843.002951608@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 101b8104307eac734f2dfa4d3511430b0b631c73 ]

Otherwise GPU may access the stale mapping and generate IOMMU
IO_PAGE_FAULT.

Move this to inside p->mutex to prevent multiple threads mapping and
unmapping concurrently race condition.

After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
before free the mem attachment in case failed to unmap from GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 20 ++++++++------
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index dbc842590b253..585d608c10e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -286,6 +286,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7d5fbaaba72f7..3e7f4d8dc9d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -719,7 +719,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
 	enum dma_data_direction dir;
 
 	if (unlikely(!ttm->sg)) {
-		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
+		pr_debug("SG Table of BO is NULL");
 		return;
 	}
 
@@ -1226,8 +1226,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
 	amdgpu_sync_fence(sync, bo_va->last_pt_update);
-
-	kfd_mem_dmaunmap_attachment(mem, entry);
 }
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
@@ -1282,6 +1280,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 
 update_gpuvm_pte_failed:
 	unmap_bo_from_gpuvm(mem, entry, sync);
+	kfd_mem_dmaunmap_attachment(mem, entry);
 	return ret;
 }
 
@@ -1852,8 +1851,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue));
 
 	/* Remove from VM internal data structures */
-	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
+	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
+		kfd_mem_dmaunmap_attachment(mem, entry);
 		kfd_mem_detach(entry);
+	}
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -2024,6 +2025,23 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	return ret;
 }
 
+void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
+{
+	struct kfd_mem_attachment *entry;
+	struct amdgpu_vm *vm;
+
+	vm = drm_priv_to_vm(drm_priv);
+
+	mutex_lock(&mem->lock);
+
+	list_for_each_entry(entry, &mem->attachments, list) {
+		if (entry->bo_va->base.vm == vm)
+			kfd_mem_dmaunmap_attachment(mem, entry);
+	}
+
+	mutex_unlock(&mem->lock);
+}
+
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b0f475d51ae7e..2b21ce967e766 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1400,17 +1400,21 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			goto sync_memory_failed;
 		}
 	}
-	mutex_unlock(&p->mutex);
 
-	if (flush_tlb) {
-		/* Flush TLBs after waiting for the page table updates to complete */
-		for (i = 0; i < args->n_devices; i++) {
-			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
-			if (WARN_ON_ONCE(!peer_pdd))
-				continue;
+	/* Flush TLBs after waiting for the page table updates to complete */
+	for (i = 0; i < args->n_devices; i++) {
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		if (flush_tlb)
 			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
-		}
+
+		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
+		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
 	}
+
+	mutex_unlock(&p->mutex);
+
 	kfree(devices_arr);
 
 	return 0;
-- 
2.43.0




