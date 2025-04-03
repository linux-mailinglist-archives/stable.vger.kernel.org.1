Return-Path: <stable+bounces-128043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEACDA7AEA3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9A9189A39B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4C217647;
	Thu,  3 Apr 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eixBv6YG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863C215F76;
	Thu,  3 Apr 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707841; cv=none; b=I4k9LTM+JyWOysSyTTsK2ns3MkE8p+t3Wo3lUAQtNV3rX85q90ften/sV+kTFwB+DLj3eIwtZDh3d3B8hjMJsmPaQkcO61U1Hc3I7K7NA1vOPkiRuZfVT7rFeXG2r2I3rgE+k9wrwjC3rLkp0USAYW4pnVAAJ6UG2jJKEAmHrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707841; c=relaxed/simple;
	bh=t6oZMi/9McYhjjwa54LfqnU8rhG4e5YDSNMDfVmx1Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SueNoI8KVM0/YBHGKz53mjKJAfPRX4ssDK+H7h47S/SrSHacrUUybFC5G7tIpGgHug1LFoZp9kUWVVoa5WMAtanJrdfPBwRkbbFTAIe5KxSHg3P8OtnpoS+7a+oQoxSdbsh46i8xytfhjLqNfeD1vtU8iMLkuW3zUrGfX7gHqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eixBv6YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71214C4CEE3;
	Thu,  3 Apr 2025 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707841;
	bh=t6oZMi/9McYhjjwa54LfqnU8rhG4e5YDSNMDfVmx1Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eixBv6YGwNjRWwPmmhDvS3Z0f5tpqE3GRoB/OLiOCBo+ZJmgUSmvSU7kTSyTH3Kt+
	 zTHWABryrFt8LFejbpLT0ngJsT62O+bEl1n7cVOOpIi835sZrQYzx+f5I0zq019Y+a
	 ZZbWhYIpJNTiqHRLHFGeYwoWOCaH4kyMSGZsSIDMQb3jef/dombbpkmujwTK5ktGQd
	 89m/V56xt52YHIUb1BketlFpfJ9gsumxXYL4k3V2p+bzjOXIQKPgmXbMv9QptaSfL5
	 CRRmTHS38fsRPFTwZvUBSCaYEJpuayeTQl49jGhVRIANjKu8agAw1/Lx58IsiP4MWm
	 KLefIo9m2Vfsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	xiaogang.chen@amd.com,
	tvrtko.ursulin@igalia.com,
	mdaenzer@redhat.com,
	Yunxiang.Li@amd.com,
	xinhui.pan@amd.com,
	Longlong.Yao@amd.com,
	shane.xiao@amd.com,
	Hawking.Zhang@amd.com,
	jesse.zhang@amd.com,
	natalie.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 05/33] drm/amdgpu: Unlocked unmap only clear page table leaves
Date: Thu,  3 Apr 2025 15:16:28 -0400
Message-Id: <20250403191656.2680995-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 23b645231eeffdaf44021debac881d2f26824150 ]

SVM migration unmap pages from GPU and then update mapping to GPU to
recover page fault. Currently unmap clears the PDE entry for range
length >= huge page and free PTB bo, update mapping to alloc new PT bo.
There is race bug that the freed entry bo maybe still on the pt_free
list, reused when updating mapping and then freed, leave invalid PDE
entry and cause GPU page fault.

By setting the update to clear only one PDE entry or clear PTB, to
avoid unmap to free PTE bo. This fixes the race bug and improve the
unmap and map to GPU performance. Update mapping to huge page will
still free the PTB bo.

With this change, the vm->pt_freed list and work is not needed. Add
WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to free the
PTB.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 +++++++----------------
 3 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 73e02141a6e21..37d53578825b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2434,8 +2434,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
-	INIT_LIST_HEAD(&vm->pt_freed);
-	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
 	r = amdgpu_vm_init_entities(adev, vm);
@@ -2607,8 +2605,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
-	flush_work(&vm->pt_free_work);
-
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 52dd7cdfdc814..ee893527a4f1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -360,10 +360,6 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
-	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
-	struct list_head	pt_freed;
-	struct work_struct	pt_free_work;
-
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48fa..54ae0e9bc6d77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
-void amdgpu_vm_pt_free_work(struct work_struct *work)
-{
-	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm;
-	LIST_HEAD(pt_freed);
-
-	vm = container_of(work, struct amdgpu_vm, pt_free_work);
-
-	spin_lock(&vm->status_lock);
-	list_splice_init(&vm->pt_freed, &pt_freed);
-	spin_unlock(&vm->status_lock);
-
-	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
-	amdgpu_bo_reserve(vm->root.bo, true);
-
-	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
-
-	amdgpu_bo_unreserve(vm->root.bo);
-}
-
 /**
  * amdgpu_vm_pt_free_list - free PD/PT levels
  *
@@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm = params->vm;
 	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
 
-	if (unlocked) {
-		spin_lock(&vm->status_lock);
-		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
-		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
-		return;
-	}
+	/*
+	 * unlocked unmap clear page table leaves, warning to free the page entry.
+	 */
+	WARN_ON(unlocked);
 
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
@@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
 		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
-		entry_end = ((uint64_t)mask + 1) << shift;
+
+		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
+			/*
+			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
+			 * only clear one entry. Next entry search again for PDE or PTE leave.
+			 */
+			entry_end = 1ULL << shift;
+		else
+			entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
-- 
2.39.5


