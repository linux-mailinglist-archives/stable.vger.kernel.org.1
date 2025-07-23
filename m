Return-Path: <stable+bounces-164501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182AFB0FA65
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 20:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7B547A71
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D01F418F;
	Wed, 23 Jul 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxkzhjXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FE82C60
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296066; cv=none; b=bDopJAyUqkSDQZt0MSqbw8Ix9Cf2O6mOP3rvRfHyJTbp0o1OcRxPLqHRUkEt12MGnrQF1Dszy7FdXUT/49XH3od2k6dr58itf1NxnRHZFslMNj0j0j5iNKSvXnAaurW1grgdDGGYrDfXss7i1MmeIuDMAdoahsEyvnuxhxdOsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296066; c=relaxed/simple;
	bh=oa5fH1/37v+xVjRy+xCCuQY/CnXAO0XY04/A/Yg6sWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bq/l0ffPJrjDnH2nYNfiBUT47Zq6UQ8zeUEt5oWynVIOqE2cZ3j9ARnTRDXPFoi7lZaAgNrHeGG1ZdKxtmsfcTJ00Xy+IbABIMjxySwi1qEDi4n6kg8701CxuyBzvKrnw85HiyG1zCOLIUSOU9MtSXNW9nRyQ9bBCu8EU1Vutqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxkzhjXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D256C4CEE7;
	Wed, 23 Jul 2025 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753296066;
	bh=oa5fH1/37v+xVjRy+xCCuQY/CnXAO0XY04/A/Yg6sWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxkzhjXHYhShCL0D88+piHeyBBxw88k8zvNBNe4bYLCDTdo3AwWHlo9LwKrySh6gK
	 SzfBg7FnplFkizHgIuPmENdbI398dHaNpchTUGoY+gKYFpnaxolf2ywtnUsTV+924n
	 ipEbT+LhyJpT7H0ImUYtXSDkkIblfB+bFbK75skbjOjpd/Kw5odfeL/WoHbvo+nNJt
	 gmuYvvuKopyMqwP+c1klx6yGLj9rc+GR3wiO0flFFVhoNOyKc1s5RyL9VyX7mv50ku
	 4O982BFHWeA7e0gqHCdeTTxumbtYVwrhy6UQv1yZ4lTUxYvCYsetvaS+54qG32XhCK
	 nZP0scj48UF8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdkfd: Don't call mmput from MMU notifier callback
Date: Wed, 23 Jul 2025 14:34:30 -0400
Message-Id: <20250723183430.1097183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071252-fountain-preacher-2c65@gregkh>
References: <2025071252-fountain-preacher-2c65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit cf234231fcbc7d391e2135b9518613218cc5347f ]

If the process is exiting, the mmput inside mmu notifier callback from
compactd or fork or numa balancing could release the last reference
of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
with below backtrace.

The deadlock will leak kfd process as mmu notifier release is not called
and cause VRAM leaking.

The fix is to take mm reference mmget_non_zero when adding prange to the
deferred list to pair with mmput in deferred list work.

If prange split and add into pchild list, the pchild work_item.mm is not
used, so remove the mm parameter from svm_range_unmap_split and
svm_range_add_child.

The backtrace of hung task:

 INFO: task python:348105 blocked for more than 64512 seconds.
 Call Trace:
  __schedule+0x1c3/0x550
  schedule+0x46/0xb0
  rwsem_down_write_slowpath+0x24b/0x4c0
  unlink_anon_vmas+0xb1/0x1c0
  free_pgtables+0xa9/0x130
  exit_mmap+0xbc/0x1a0
  mmput+0x5a/0x140
  svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
  mn_itree_invalidate+0x72/0xc0
  __mmu_notifier_invalidate_range_start+0x48/0x60
  try_to_unmap_one+0x10fa/0x1400
  rmap_walk_anon+0x196/0x460
  try_to_unmap+0xbb/0x210
  migrate_page_unmap+0x54d/0x7e0
  migrate_pages_batch+0x1c3/0xae0
  migrate_pages_sync+0x98/0x240
  migrate_pages+0x25c/0x520
  compact_zone+0x29d/0x590
  compact_zone_order+0xb6/0xf0
  try_to_compact_pages+0xbe/0x220
  __alloc_pages_direct_compact+0x96/0x1a0
  __alloc_pages_slowpath+0x410/0x930
  __alloc_pages_nodemask+0x3a9/0x3e0
  do_huge_pmd_anonymous_page+0xd7/0x3e0
  __handle_mm_fault+0x5e3/0x5f0
  handle_mm_fault+0xf7/0x2e0
  hmm_vma_fault.isra.0+0x4d/0xa0
  walk_pmd_range.isra.0+0xa8/0x310
  walk_pud_range+0x167/0x240
  walk_pgd_range+0x55/0x100
  __walk_page_range+0x87/0x90
  walk_page_range+0xf6/0x160
  hmm_range_fault+0x4f/0x90
  amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
  amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
  init_user_pages+0xb1/0x2a0 [amdgpu]
  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
  kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
  kfd_ioctl+0x29d/0x500 [amdgpu]

Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a29e067bd38946f752b0ef855f3dfff87e77bec7)
Cc: stable@vger.kernel.org
[ updated additional svm_range_add_child calls in svm_range_split_by_granularity to remove mm parameter ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 47 +++++++++++++---------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6b7c6f45a80a8..b77b472332316 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1130,13 +1130,12 @@ svm_range_split_head(struct svm_range *prange,
 }
 
 static void
-svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
-		    struct svm_range *pchild, enum svm_work_list_ops op)
+svm_range_add_child(struct svm_range *prange, struct svm_range *pchild, enum svm_work_list_ops op)
 {
 	pr_debug("add child 0x%p [0x%lx 0x%lx] to prange 0x%p child list %d\n",
 		 pchild, pchild->start, pchild->last, prange, op);
 
-	pchild->work_item.mm = mm;
+	pchild->work_item.mm = NULL;
 	pchild->work_item.op = op;
 	list_add_tail(&pchild->child_list, &prange->child_list);
 }
@@ -1182,14 +1181,14 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 		r = svm_range_split(prange, start, prange->last, &head);
 		if (r)
 			return r;
-		svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
+		svm_range_add_child(parent, head, SVM_OP_ADD_RANGE);
 	}
 
 	if (last < prange->last) {
 		r = svm_range_split(prange, prange->start, last, &tail);
 		if (r)
 			return r;
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
+		svm_range_add_child(parent, tail, SVM_OP_ADD_RANGE);
 	}
 
 	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
@@ -2393,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 		    prange->work_item.op != SVM_OP_UNMAP_RANGE)
 			prange->work_item.op = op;
 	} else {
-		prange->work_item.op = op;
-
-		/* Pairs with mmput in deferred_list_work */
-		mmget(mm);
-		prange->work_item.mm = mm;
-		list_add_tail(&prange->deferred_list,
-			      &prange->svms->deferred_range_list);
-		pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
-			 prange, prange->start, prange->last, op);
+		/* Pairs with mmput in deferred_list_work.
+		 * If process is exiting and mm is gone, don't update mmu notifier.
+		 */
+		if (mmget_not_zero(mm)) {
+			prange->work_item.mm = mm;
+			prange->work_item.op = op;
+			list_add_tail(&prange->deferred_list,
+				      &prange->svms->deferred_range_list);
+			pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
+				 prange, prange->start, prange->last, op);
+		}
 	}
 	spin_unlock(&svms->deferred_list_lock);
 }
@@ -2415,8 +2416,7 @@ void schedule_deferred_list_work(struct svm_range_list *svms)
 }
 
 static void
-svm_range_unmap_split(struct mm_struct *mm, struct svm_range *parent,
-		      struct svm_range *prange, unsigned long start,
+svm_range_unmap_split(struct svm_range *parent, struct svm_range *prange, unsigned long start,
 		      unsigned long last)
 {
 	struct svm_range *head;
@@ -2437,12 +2437,12 @@ svm_range_unmap_split(struct mm_struct *mm, struct svm_range *parent,
 		svm_range_split(tail, last + 1, tail->last, &head);
 
 	if (head != prange && tail != prange) {
-		svm_range_add_child(parent, mm, head, SVM_OP_UNMAP_RANGE);
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
+		svm_range_add_child(parent, head, SVM_OP_UNMAP_RANGE);
+		svm_range_add_child(parent, tail, SVM_OP_ADD_RANGE);
 	} else if (tail != prange) {
-		svm_range_add_child(parent, mm, tail, SVM_OP_UNMAP_RANGE);
+		svm_range_add_child(parent, tail, SVM_OP_UNMAP_RANGE);
 	} else if (head != prange) {
-		svm_range_add_child(parent, mm, head, SVM_OP_UNMAP_RANGE);
+		svm_range_add_child(parent, head, SVM_OP_UNMAP_RANGE);
 	} else if (parent != prange) {
 		prange->work_item.op = SVM_OP_UNMAP_RANGE;
 	}
@@ -2481,14 +2481,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		l = min(last, pchild->last);
 		if (l >= s)
 			svm_range_unmap_from_gpus(pchild, s, l, trigger);
-		svm_range_unmap_split(mm, prange, pchild, start, last);
+		svm_range_unmap_split(prange, pchild, start, last);
 		mutex_unlock(&pchild->lock);
 	}
 	s = max(start, prange->start);
 	l = min(last, prange->last);
 	if (l >= s)
 		svm_range_unmap_from_gpus(prange, s, l, trigger);
-	svm_range_unmap_split(mm, prange, prange, start, last);
+	svm_range_unmap_split(prange, prange, start, last);
 
 	if (unmap_parent)
 		svm_range_add_list_work(svms, prange, mm, SVM_OP_UNMAP_RANGE);
@@ -2531,8 +2531,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	if (range->event == MMU_NOTIFY_RELEASE)
 		return true;
-	if (!mmget_not_zero(mni->mm))
-		return true;
 
 	start = mni->interval_tree.start;
 	last = mni->interval_tree.last;
@@ -2559,7 +2557,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 	}
 
 	svm_range_unlock(prange);
-	mmput(mni->mm);
 
 	return true;
 }
-- 
2.39.5


