Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A827ED296
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjKOUmn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjKOTZt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8819D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145DAC433C8;
        Wed, 15 Nov 2023 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076345;
        bh=PQnGBKE0Imeb7P4Eb9+CmBEG3s45ZLrA/91qEiZrgf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lfhc5FRQkDyomBAMfQ7u7LLLCAHEkojWU2kzvhBpWgraHMozqDi6/2Tq+aR/Tugj3
         Oq6JhYRJCoBfYqLnGKWtMpnaOZod6TRzVtMJ21NCRqPS9c7Nn0BwMOcOkucAKkuPsN
         OvPZ6AU0NoXB7OvxfPsvdY62BCL726+WL7LzIvb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        James Zhu <james.zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 233/550] drm/amdkfd: Handle errors from svm validate and map
Date:   Wed, 15 Nov 2023 14:13:37 -0500
Message-ID: <20231115191616.865315063@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit eb3c357bcb286e89386e89302061fe717fe4e562 ]

If new range is splited to multiple pranges with max_svm_range_pages
alignment and added to update_list, svm validate and map should keep
going after error to make sure prange->mapped_to_gpu flag is up to date
for the whole range.

svm validate and map update set prange->mapped_to_gpu after mapping to
GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
update mapping case) instead of setting error flag, we can remove
the redundant error flag to simpliy code.

Refactor to remove goto and update prange->mapped_to_gpu flag inside
svm_range_lock, to guarant we always evict queues or unmap from GPUs if
there are invalid ranges.

After svm validate and map return error -EAGIN, the caller retry will
update the mapping for the whole range again.

Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: James Zhu <james.zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 82 +++++++++++++---------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8cbfe18d16c6e..50f943e04f8a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -809,7 +809,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return !prange->is_error_flag;
+	return true;
 }
 
 /**
@@ -1627,71 +1627,66 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
-	for (addr = start; addr < end && !r; ) {
+	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
 		struct vm_area_struct *vma;
-		unsigned long next;
+		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
 		bool readonly;
 
 		vma = vma_lookup(mm, addr);
-		if (!vma) {
+		if (vma) {
+			readonly = !(vma->vm_flags & VM_WRITE);
+
+			next = min(vma->vm_end, end);
+			npages = (next - addr) >> PAGE_SHIFT;
+			WRITE_ONCE(p->svms.faulting_task, current);
+			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+						       readonly, owner, NULL,
+						       &hmm_range);
+			WRITE_ONCE(p->svms.faulting_task, NULL);
+			if (r) {
+				pr_debug("failed %d to get svm range pages\n", r);
+				if (r == -EBUSY)
+					r = -EAGAIN;
+			}
+		} else {
 			r = -EFAULT;
-			goto unreserve_out;
-		}
-		readonly = !(vma->vm_flags & VM_WRITE);
-
-		next = min(vma->vm_end, end);
-		npages = (next - addr) >> PAGE_SHIFT;
-		WRITE_ONCE(p->svms.faulting_task, current);
-		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-					       readonly, owner, NULL,
-					       &hmm_range);
-		WRITE_ONCE(p->svms.faulting_task, NULL);
-		if (r) {
-			pr_debug("failed %d to get svm range pages\n", r);
-			if (r == -EBUSY)
-				r = -EAGAIN;
-			goto unreserve_out;
 		}
 
-		offset = (addr - start) >> PAGE_SHIFT;
-		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
-				      hmm_range->hmm_pfns);
-		if (r) {
-			pr_debug("failed %d to dma map range\n", r);
-			goto unreserve_out;
+		if (!r) {
+			offset = (addr - start) >> PAGE_SHIFT;
+			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
+					      hmm_range->hmm_pfns);
+			if (r)
+				pr_debug("failed %d to dma map range\n", r);
 		}
 
 		svm_range_lock(prange);
-		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
-			goto unlock_out;
 		}
-		if (!list_empty(&prange->child_list)) {
+
+		if (!r && !list_empty(&prange->child_list)) {
 			pr_debug("range split by unmap in parallel, validate again\n");
 			r = -EAGAIN;
-			goto unlock_out;
 		}
 
-		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx->bitmap, wait, flush_tlb);
+		if (!r)
+			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+						  ctx->bitmap, wait, flush_tlb);
+
+		if (!r && next == end)
+			prange->mapped_to_gpu = true;
 
-unlock_out:
 		svm_range_unlock(prange);
 
 		addr = next;
 	}
 
-	if (addr == end)
-		prange->mapped_to_gpu = true;
-
-unreserve_out:
 	svm_range_unreserve_bos(ctx);
-
-	prange->is_error_flag = !!r;
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
 
@@ -2057,7 +2052,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node->last, last) + 1;
 
-		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
+		    prange->mapped_to_gpu) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3470,7 +3466,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range *next;
 	bool update_mapping = false;
 	bool flush_tlb;
-	int r = 0;
+	int r, ret = 0;
 
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
 		 p->pasid, &p->svms, start, start + size - 1, size);
@@ -3558,7 +3554,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 out_unlock_range:
 		mutex_unlock(&prange->migrate_mutex);
 		if (r)
-			break;
+			ret = r;
 	}
 
 	svm_range_debug_dump(svms);
@@ -3571,7 +3567,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
 		 &p->svms, start, start + size - 1, r);
 
-	return r;
+	return ret ? ret : r;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 21ca57992e054..d2aa8c324c610 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -133,7 +133,6 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				mapped_to_gpu;
-	bool				is_error_flag;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.42.0



