Return-Path: <stable+bounces-50819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17A906CF6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718A2B2514C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF61448E4;
	Thu, 13 Jun 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UL1GiTPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC113A406;
	Thu, 13 Jun 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279478; cv=none; b=Qpd8BWu84pOk1OOa4MUuRVwOzMhOxHgGCRH7VxpyWfnL0832s0xpfNIWRSaRxwj9kpw1/bIFM+L8Kf5/OGFPIwchXApfplt0l3zfsz+IKgdc3E+5O1xKpA0WXdIjSJv7zoJdW6JTaREo5SqqyvHS8RksM6Blj88Xw1K75+aOtBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279478; c=relaxed/simple;
	bh=xED1xYIGhhDWeYJqKX6epqQ3P6cR/gH3oDn1gpFblgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkniRFWNn+7WOMQzi7hyZz2wq+Wq74jb8u5bCwxciI72ewR6SaK66TSI/mBONBQ8KGvaYRoUr4fIQsAQRO2AvdGYrl1r/DVALJfn9QW8M3qubsQs0U1gozl7nwQoPfrNzRS2ExX+QbiM6a7c546+eBtS0JbNRIrlz9tOWQxGVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UL1GiTPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6808C2BBFC;
	Thu, 13 Jun 2024 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279478;
	bh=xED1xYIGhhDWeYJqKX6epqQ3P6cR/gH3oDn1gpFblgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UL1GiTPjorkYCWtFB0ClZq7qNg7r9cEBEUEt+R2n9yQHXh1lUNcMfOtPCRwT4xzCe
	 ujVwEIx2Z2pwj33An4yLouwEFMoEAbBz+3hFpjUYeUhSdIlTQWItMDTyYP1yt1y/ds
	 XF6gPiwdlR9lbs4BCabmr/VGRsIMvfMPs317/09M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Stefan Roesch <shr@devkernel.io>,
	xu xin <xu.xin16@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.9 088/157] mm/ksm: fix ksm_zero_pages accounting
Date: Thu, 13 Jun 2024 13:33:33 +0200
Message-ID: <20240613113230.830664536@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

From: Chengming Zhou <chengming.zhou@linux.dev>

commit c2dc78b86e0821ecf9a9d0c35dba2618279a5bb6 upstream.

We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
but ksm_zero_pages-- is done from page tables side, where there is no any
accessing protection of ksm_zero_pages.

So we can read very exceptional value of ksm_zero_pages in rare cases,
such as -1, which is very confusing to users.

Fix it by changing to use atomic_long_t, and the same case with the
mm->ksm_zero_pages.

Link: https://lkml.kernel.org/r/20240528-b4-ksm-counters-v3-2-34bb358fdc13@linux.dev
Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
Fixes: 6080d19f0704 ("ksm: add ksm zero pages for each process")
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c           |    2 +-
 include/linux/ksm.h      |   17 ++++++++++++++---
 include/linux/mm_types.h |    2 +-
 mm/ksm.c                 |   11 +++++------
 4 files changed, 21 insertions(+), 11 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_
 	mm = get_task_mm(task);
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
-		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
+		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		mmput(mm);
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -33,16 +33,27 @@ void __ksm_exit(struct mm_struct *mm);
  */
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
-extern unsigned long ksm_zero_pages;
+extern atomic_long_t ksm_zero_pages;
+
+static inline void ksm_map_zero_page(struct mm_struct *mm)
+{
+	atomic_long_inc(&ksm_zero_pages);
+	atomic_long_inc(&mm->ksm_zero_pages);
+}
 
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 	if (is_ksm_zero_pte(pte)) {
-		ksm_zero_pages--;
-		mm->ksm_zero_pages--;
+		atomic_long_dec(&ksm_zero_pages);
+		atomic_long_dec(&mm->ksm_zero_pages);
 	}
 }
 
+static inline long mm_ksm_zero_pages(struct mm_struct *mm)
+{
+	return atomic_long_read(&mm->ksm_zero_pages);
+}
+
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	int ret;
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -988,7 +988,7 @@ struct mm_struct {
 		 * Represent how many empty pages are merged with kernel zero
 		 * pages when enabling KSM use_zero_pages.
 		 */
-		unsigned long ksm_zero_pages;
+		atomic_long_t ksm_zero_pages;
 #endif /* CONFIG_KSM */
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
 		struct {
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -296,7 +296,7 @@ static bool ksm_use_zero_pages __read_mo
 static bool ksm_smart_scan = true;
 
 /* The number of zero pages which is placed by KSM */
-unsigned long ksm_zero_pages;
+atomic_long_t ksm_zero_pages = ATOMIC_LONG_INIT(0);
 
 /* The number of pages that have been skipped due to "smart scanning" */
 static unsigned long ksm_pages_skipped;
@@ -1428,8 +1428,7 @@ static int replace_page(struct vm_area_s
 		 * the dirty bit in zero page's PTE is set.
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
-		ksm_zero_pages++;
-		mm->ksm_zero_pages++;
+		ksm_map_zero_page(mm);
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
@@ -3368,7 +3367,7 @@ static void wait_while_offlining(void)
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *mm)
 {
-	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
+	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }
 #endif /* CONFIG_PROC_FS */
@@ -3657,7 +3656,7 @@ KSM_ATTR_RO(pages_skipped);
 static ssize_t ksm_zero_pages_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
+	return sysfs_emit(buf, "%ld\n", atomic_long_read(&ksm_zero_pages));
 }
 KSM_ATTR_RO(ksm_zero_pages);
 
@@ -3666,7 +3665,7 @@ static ssize_t general_profit_show(struc
 {
 	long general_profit;
 
-	general_profit = (ksm_pages_sharing + ksm_zero_pages) * PAGE_SIZE -
+	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
 				ksm_rmap_items * sizeof(struct ksm_rmap_item);
 
 	return sysfs_emit(buf, "%ld\n", general_profit);



