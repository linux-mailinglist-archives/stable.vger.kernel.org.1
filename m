Return-Path: <stable+bounces-93910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947F9D1F5E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B161F20C17
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEA1509B4;
	Tue, 19 Nov 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw7XCSMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C314D444
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991001; cv=none; b=UcPRw4kqh5LOV5BMrOnKeCCd/tb8TRYpjZyl8lXtGE6j6ZMIpmLx0j9rbpfDGjLAj8Cs7He79CyeYgTfscM3vb6AAF3ST3iCfkdDy/9k922yuK7E/9aFixmnZe/LHUCCpKeBreyFH0SKnvtCP+CmCeXjS1QUwNsaw/B0SD/DYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991001; c=relaxed/simple;
	bh=+1X1tcboLqxA5F5qC4nEC8+T2MA4rdE3r5UQjrqlJgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrrdGzNwl0AAwFiVKCb2xGSLGHgYqgePzl4lXT/t7xH0OjM6rJcWxChdOOkBG3ARSFOFOAgI3lCRkoUKMG5ryHYxCkSzbZwicXQSb5sjlX8w+GbZuL16m29WB4JjEFnuKbbCIFNV93zO3tt7yIEaEK/fV2ar7PJ4gznxGMbMd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw7XCSMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15142C4CECF;
	Tue, 19 Nov 2024 04:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991001;
	bh=+1X1tcboLqxA5F5qC4nEC8+T2MA4rdE3r5UQjrqlJgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hw7XCSMKhAc2dOsEzqOcDhlco7Vr/bn8quB1CQ0V9NC49Ccxp2Tyd+IwyIJwsgu/y
	 Qf8QTUSkxRKZ0lkJiER+FH1lf9D1SHCIMSlyPYEYHbIl+DAgA8oWttqd74C3hyN7yv
	 xz9jV6pmu741vLH3MtzuPD4iqZfwr7pElgwijXp7jnlZMbFDX5tCByrqKbawjkVBs0
	 HTNDgK6ZPCmQa7/XDkj7STB/4q9HRNKtN06r6E4hxk9Lx1hTtOXyXorZIaAeyN3ctT
	 lwpEolRb8tcPVeL6kfSMxqtg+0rY+JNLFGAizUgNESZ2KE6CDXlVJOEwaKBeXudOAf
	 uh+XbUWtkb0Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2 2/4] mm: unconditionally close VMAs on error
Date: Mon, 18 Nov 2024 23:36:39 -0500
Message-ID: <ef2adefc6ecba82fc5b5615f459af5881ee3c013.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <ef2adefc6ecba82fc5b5615f459af5881ee3c013.1731946386.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 4080ef1579b2413435413988d14ac8c68e4d42c8

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Not found                                   |
| 6.6.y           |  Not found                                   |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 17:09:02.126570330 -0500
+++ /tmp/tmp.ObQGdOEZDP	2024-11-18 17:09:02.118081315 -0500
@@ -33,71 +33,81 @@
 Cc: Will Deacon <will@kernel.org>
 Cc: <stable@vger.kernel.org>
 Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 ---
- mm/internal.h | 18 ++++++++++++++++++
- mm/mmap.c     |  5 ++---
+ mm/internal.h |  7 +++++++
+ mm/mmap.c     | 12 ++++--------
  mm/nommu.c    |  3 +--
- mm/vma.c      | 14 +++++---------
- mm/vma.h      |  4 +---
- 5 files changed, 27 insertions(+), 17 deletions(-)
+ mm/util.c     | 15 +++++++++++++++
+ 4 files changed, 27 insertions(+), 10 deletions(-)
 
 diff --git a/mm/internal.h b/mm/internal.h
-index 4eab2961e69ce..64c2eb0b160e1 100644
+index 85ac9c6a1393..16a4a9aece30 100644
 --- a/mm/internal.h
 +++ b/mm/internal.h
-@@ -135,6 +135,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
- 	return err;
- }
+@@ -64,6 +64,13 @@ void page_writeback_init(void);
+  */
+ int mmap_file(struct file *file, struct vm_area_struct *vma);
  
 +/*
 + * If the VMA has a close hook then close it, and since closing it might leave
 + * it in an inconsistent state which makes the use of any hooks suspect, clear
 + * them down by installing dummy empty hooks.
 + */
-+static inline void vma_close(struct vm_area_struct *vma)
-+{
-+	if (vma->vm_ops && vma->vm_ops->close) {
-+		vma->vm_ops->close(vma);
-+
-+		/*
-+		 * The mapping is in an inconsistent state, and no further hooks
-+		 * may be invoked upon it.
-+		 */
-+		vma->vm_ops = &vma_dummy_vm_ops;
-+	}
-+}
++void vma_close(struct vm_area_struct *vma);
 +
- #ifdef CONFIG_MMU
- 
- /* Flags for folio_pte_batch(). */
+ static inline void *folio_raw_mapping(struct folio *folio)
+ {
+ 	unsigned long mapping = (unsigned long)folio->mapping;
 diff --git a/mm/mmap.c b/mm/mmap.c
-index 6e3b25f7728f9..ac0604f146f6e 100644
+index bf2f1ca87bef..4bfec4df51c2 100644
 --- a/mm/mmap.c
 +++ b/mm/mmap.c
-@@ -1573,8 +1573,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
+@@ -136,8 +136,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
+ static void remove_vma(struct vm_area_struct *vma)
+ {
+ 	might_sleep();
+-	if (vma->vm_ops && vma->vm_ops->close)
+-		vma->vm_ops->close(vma);
++	vma_close(vma);
+ 	if (vma->vm_file)
+ 		fput(vma->vm_file);
+ 	mpol_put(vma_policy(vma));
+@@ -2388,8 +2387,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+ 	new->vm_start = new->vm_end;
+ 	new->vm_pgoff = 0;
+ 	/* Clean everything up if vma_adjust failed. */
+-	if (new->vm_ops && new->vm_ops->close)
+-		new->vm_ops->close(new);
++	vma_close(new);
+ 	if (new->vm_file)
+ 		fput(new->vm_file);
+ 	unlink_anon_vmas(new);
+@@ -2885,8 +2883,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
  	return addr;
  
  close_and_free_vma:
--	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
+-	if (vma->vm_ops && vma->vm_ops->close)
 -		vma->vm_ops->close(vma);
 +	vma_close(vma);
- 
- 	if (file || vma->vm_file) {
  unmap_and_free_vma:
-@@ -1934,7 +1933,7 @@ void exit_mmap(struct mm_struct *mm)
- 	do {
- 		if (vma->vm_flags & VM_ACCOUNT)
- 			nr_accounted += vma_pages(vma);
--		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
-+		remove_vma(vma, /* unreachable = */ true);
- 		count++;
- 		cond_resched();
- 		vma = vma_next(&vmi);
+ 	fput(vma->vm_file);
+ 	vma->vm_file = NULL;
+@@ -3376,8 +3373,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
+ 	return new_vma;
+ 
+ out_vma_link:
+-	if (new_vma->vm_ops && new_vma->vm_ops->close)
+-		new_vma->vm_ops->close(new_vma);
++	vma_close(new_vma);
+ 
+ 	if (new_vma->vm_file)
+ 		fput(new_vma->vm_file);
 diff --git a/mm/nommu.c b/mm/nommu.c
-index f9ccc02458ec6..635d028d647b3 100644
+index f09e798a4416..e0428fa57526 100644
 --- a/mm/nommu.c
 +++ b/mm/nommu.c
-@@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
+@@ -650,8 +650,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
   */
  static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
  {
@@ -107,80 +117,32 @@
  	if (vma->vm_file)
  		fput(vma->vm_file);
  	put_nommu_region(vma->vm_region);
-diff --git a/mm/vma.c b/mm/vma.c
-index b21ffec33f8e0..7621384d64cf5 100644
---- a/mm/vma.c
-+++ b/mm/vma.c
-@@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
- /*
-  * Close a vm structure and free it.
-  */
--void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
-+void remove_vma(struct vm_area_struct *vma, bool unreachable)
- {
- 	might_sleep();
--	if (!closed && vma->vm_ops && vma->vm_ops->close)
--		vma->vm_ops->close(vma);
-+	vma_close(vma);
- 	if (vma->vm_file)
- 		fput(vma->vm_file);
- 	mpol_put(vma_policy(vma));
-@@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
- 	vms_clear_ptes(vms, mas_detach, true);
- 	mas_set(mas_detach, 0);
- 	mas_for_each(mas_detach, vma, ULONG_MAX)
--		if (vma->vm_ops && vma->vm_ops->close)
--			vma->vm_ops->close(vma);
--	vms->closed_vm_ops = true;
-+		vma_close(vma);
- }
- 
- /*
-@@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
- 	/* Remove and clean up vmas */
- 	mas_set(mas_detach, 0);
- 	mas_for_each(mas_detach, vma, ULONG_MAX)
--		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
-+		remove_vma(vma, /* unreachable = */ false);
- 
- 	vm_unacct_memory(vms->nr_accounted);
- 	validate_mm(mm);
-@@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
- 	return new_vma;
- 
- out_vma_link:
--	if (new_vma->vm_ops && new_vma->vm_ops->close)
--		new_vma->vm_ops->close(new_vma);
-+	vma_close(new_vma);
- 
- 	if (new_vma->vm_file)
- 		fput(new_vma->vm_file);
-diff --git a/mm/vma.h b/mm/vma.h
-index 55457cb682008..75558b5e9c8cd 100644
---- a/mm/vma.h
-+++ b/mm/vma.h
-@@ -42,7 +42,6 @@ struct vma_munmap_struct {
- 	int vma_count;                  /* Number of vmas that will be removed */
- 	bool unlock;                    /* Unlock after the munmap */
- 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
--	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
- 	/* 1 byte hole */
- 	unsigned long nr_pages;         /* Number of pages being removed */
- 	unsigned long locked_vm;        /* Number of locked pages */
-@@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
- 	vms->unmap_start = FIRST_USER_ADDRESS;
- 	vms->unmap_end = USER_PGTABLES_CEILING;
- 	vms->clear_ptes = false;
--	vms->closed_vm_ops = false;
+diff --git a/mm/util.c b/mm/util.c
+index 15f1970da665..d3a2877c176f 100644
+--- a/mm/util.c
++++ b/mm/util.c
+@@ -1121,6 +1121,21 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
+ 	return err;
  }
- #endif
- 
-@@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
- 		  unsigned long start, size_t len, struct list_head *uf,
- 		  bool unlock);
  
--void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
-+void remove_vma(struct vm_area_struct *vma, bool unreachable);
- 
- void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
- 		struct vm_area_struct *prev, struct vm_area_struct *next);
++void vma_close(struct vm_area_struct *vma)
++{
++	static const struct vm_operations_struct dummy_vm_ops = {};
++
++	if (vma->vm_ops && vma->vm_ops->close) {
++		vma->vm_ops->close(vma);
++
++		/*
++		 * The mapping is in an inconsistent state, and no further hooks
++		 * may be invoked upon it.
++		 */
++		vma->vm_ops = &dummy_vm_ops;
++	}
++}
++
+ #ifdef CONFIG_PRINTK
+ /**
+  * mem_dump_obj - Print available provenance information
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

