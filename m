Return-Path: <stable+bounces-58595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98192B7C7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D83B1F2454F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA7156238;
	Tue,  9 Jul 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K13eHBVV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6627713;
	Tue,  9 Jul 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524415; cv=none; b=u3rH3/sCRC2rMxlFCH9fgksVlSz5T6QxWnqXOALW3L1jQyWXZH3S77Cafc81Ooeo+ITgp1/BQlWwnr3UlAT7RvKnTqEq10AR3nAR8IomJee/IsLabzSql0pWgYDtCxFHgdejDJNIAlTncI5hsHwpDjqS6XlqeR4xJWMotbFG5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524415; c=relaxed/simple;
	bh=p67IKqexZaRJEaIg+67KogtvmnDUvKG8+jJYK8nO/l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfQEZvBkCSd5MPj5iNSboJLoTcSxbZdxer+oA0AwNg9wNq95BIovt60JJgaQvU6koZDJxxoiptP/7vJw4f7la1rL++A3VK9y58ThW75AfmelbII3PhRGjKMW83EUigkGV6RBeyLtEw2+5965YJOTo0ONyOrxHehO3NyE5r1QJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K13eHBVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1127EC3277B;
	Tue,  9 Jul 2024 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524415;
	bh=p67IKqexZaRJEaIg+67KogtvmnDUvKG8+jJYK8nO/l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K13eHBVV/YRWxx9M90QxJR04ou3Q8j490EBKTCKoCochFoPIFU+IknewpdloBcktW
	 lNDM6x5jQSku3pA3XAmxvtCNaTfsCqQHE3loBYI/5kX6GDfmQEqUuvAj3bH/hAVEV3
	 /5ztahmvO/thoOYbl8jIeRAuyoqLhK3vd6htnT6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lang Yu <Lang.Yu@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 175/197] drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs
Date: Tue,  9 Jul 2024 13:10:29 +0200
Message-ID: <20240709110715.719972559@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lang Yu <Lang.Yu@amd.com>

[ Upstream commit eb853413d02c8d9b27942429b261a9eef228f005 ]

Small APUs(i.e., consumer, embedded products) usually have a small
carveout device memory which can't satisfy most compute workloads
memory allocation requirements.

We can't even run a Basic MNIST Example with a default 512MB carveout.
https://github.com/pytorch/examples/tree/main/mnist. Error Log:

"torch.cuda.OutOfMemoryError: HIP out of memory. Tried to allocate
84.00 MiB. GPU 0 has a total capacity of 512.00 MiB of which 0 bytes
is free. Of the allocated memory 103.83 MiB is allocated by PyTorch,
and 22.17 MiB is reserved by PyTorch but unallocated"

Though we can change BIOS settings to enlarge carveout size,
which is inflexible and may bring complaint. On the other hand,
the memory resource can't be effectively used between host and device.

The solution is MI300A approach, i.e., let VRAM allocations go to GTT.
Then device and host can flexibly and effectively share memory resource.

v2: Report local_mem_size_private as 0. (Felix)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  3 ++-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 35dd6effa9a34..7291c3fd8cf70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -455,6 +455,9 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 		else
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
+	} else if (adev->flags & AMD_IS_APU) {
+		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
+		mem_info->local_mem_size_private = 0;
 	} else {
 		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
 		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
@@ -809,6 +812,8 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		}
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
+	} else if (adev->flags & AMD_IS_APU) {
+		return (ttm_tt_pages_limit() << PAGE_SHIFT);
 	} else {
 		return adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0535b07987d9d..8975cf41a91ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
-		if (adev->gmc.is_app_apu) {
+		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
 		}
@@ -232,7 +232,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		  "adev reference can't be null when vram is used");
 	if (adev && xcp_id >= 0) {
 		adev->kfd.vram_used[xcp_id] += vram_needed;
-		adev->kfd.vram_used_aligned[xcp_id] += adev->gmc.is_app_apu ?
+		adev->kfd.vram_used_aligned[xcp_id] +=
+				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
 				vram_needed :
 				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -260,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 
 		if (adev) {
 			adev->kfd.vram_used[xcp_id] -= size;
-			if (adev->gmc.is_app_apu) {
+			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 				adev->kfd.vram_used_aligned[xcp_id] -= size;
 				kfd_mem_limit.system_mem_used -= size;
 				kfd_mem_limit.ttm_mem_used -= size;
@@ -889,7 +890,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev && !adev->gmc.is_app_apu) &&
+	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
@@ -1657,7 +1658,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
 
-	if (adev->gmc.is_app_apu) {
+	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1705,7 +1706,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->gmc.is_app_apu) {
+		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1952,7 +1953,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   (adev->gmc.is_app_apu &&
+		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2374,8 +2375,9 @@ static int import_obj_create(struct amdgpu_device *adev,
 	(*mem)->dmabuf = dma_buf;
 	(*mem)->bo = bo;
 	(*mem)->va = va;
-	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) && !adev->gmc.is_app_apu ?
-		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
+	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
+			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
+			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 5c8d81bfce7ab..ba651d12f1fa0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
-	if (adev->gmc.is_app_apu)
+	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
 		return 0;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 386875e6eb96b..069b81eeea03c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2619,7 +2619,8 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (node->adev->gmc.is_app_apu)
+	if (node->adev->gmc.is_app_apu ||
+	    node->adev->flags & AMD_IS_APU)
 		return 0;
 
 	if (prange->preferred_loc == gpuid ||
@@ -3337,7 +3338,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		goto out;
 	}
 
-	if (bo_node->adev->gmc.is_app_apu) {
+	if (bo_node->adev->gmc.is_app_apu ||
+	    bo_node->adev->flags & AMD_IS_APU) {
 		best_loc = 0;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 026863a0abcd3..9c37bd0567efa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -201,7 +201,8 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  * is initialized to not 0 when page migration register device memory.
  */
 #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					(adev)->gmc.is_app_apu)
+					(adev)->gmc.is_app_apu ||\
+					((adev)->flags & AMD_IS_APU))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
-- 
2.43.0




