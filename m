Return-Path: <stable+bounces-160361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7716AFB19B
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6BE1AA2406
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9F289356;
	Mon,  7 Jul 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="c/Il0r8t"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB72877ED
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885307; cv=none; b=IACZxQ6Mp6mt7zxM24iyzDEN+6sy7I8Z8oBWn3aInDY1xGB9mRhfmy0AAAvStMqxOEzhAmY8gdrWn+lYajwRDqfgE7/1LCErYrfSMkyMYu4ba/VcCgYbLp+xdrtalKWx3F/2Z1FYjm1+5EIhFns7cihKmyaAP4k8A5Zt8J6w4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885307; c=relaxed/simple;
	bh=kR3xNNG2KN+LbMnlkeC5sGzvQ2no9nRvODckc2N7Ig0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e0WmQsz3Vo6vz6rhLtGVDTmSTnT9vze8LlZMecRanzGj/5gku9aZ0pnFn/GaXo263diP9P199HjABxxe22ZY2Hf1AUdCYT3gzA/ZvShgfdLroxn+L5cjceDGQaAejuWOpxd4wZEhB7/Z5bvNLhnXGSpofzZeopFOO/b+059PJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=c/Il0r8t; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9CFAE552F54A;
	Mon,  7 Jul 2025 10:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9CFAE552F54A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1751884796;
	bh=b3G+9wGgX6F0Vj1F8AdVmDCByLR5pDMbFneWnktvG0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c/Il0r8t/U2LMQiCmqK+qbP54q2JzdveaY8v81eyQe3aUd3KS17xHj8f3gZLl1/5J
	 JS0K2A1VkULS1V00QwwJrhVPK1P7EIXCh1MeaWY0Pzrn8lYpUkCdRcKs0flCG1fWz+
	 7wxPTPOcr0Q+/SUDHXQ4GI0sZdJeEStubfkbVpHA=
Date: Mon, 7 Jul 2025 13:39:56 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1.y 1/3] mm/hugetlb: unshare page tables during VMA
 split, not before
Message-ID: <evfvb2d7jgglzgp66hvwu7pwdzbdbbcitym5574vxkno3ff6vt@jg7nfsgded5w>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620213334.158850-1-jannh@google.com>

Hello Jann,

On Fri, 20 Jun 2025 23:33:31 +0200, Jann Horn wrote:
> Currently, __split_vma() triggers hugetlb page table unsharing through
> vm_ops->may_split().  This happens before the VMA lock and rmap locks are
> taken - which is too early, it allows racing VMA-locked page faults in our
> process and racing rmap walks from other processes to cause page tables to
> be shared again before we actually perform the split.
> 
> Fix it by explicitly calling into the hugetlb unshare logic from
> __split_vma() in the same place where THP splitting also happens.  At that
> point, both the VMA and the rmap(s) are write-locked.
> 
> An annoying detail is that we can now call into the helper
> hugetlb_unshare_pmds() from two different locking contexts:
> 
> 1. from hugetlb_split(), holding:
>     - mmap lock (exclusively)
>     - VMA lock
>     - file rmap lock (exclusively)
> 2. hugetlb_unshare_all_pmds(), which I think is designed to be able to
>    call us with only the mmap lock held (in shared mode), but currently
>    only runs while holding mmap lock (exclusively) and VMA lock
> 
> Backporting note:
> This commit fixes a racy protection that was introduced in commit
> b30c14cd6102 ("hugetlb: unshare some PMDs when splitting VMAs"); that
> commit claimed to fix an issue introduced in 5.13, but it should actually
> also go all the way back.
> 
> [jannh@google.com: v2]
>   Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-1-1329349bad1a@google.com
> Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-0-1329349bad1a@google.com
> Link: https://lkml.kernel.org/r/20250527-hugetlb-fixes-splitrace-v1-1-f4136f5ec58a@google.com
> Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
> Signed-off-by: Jann Horn <jannh@google.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>	[b30c14cd6102: hugetlb: unshare some PMDs when splitting VMAs]
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [stable backport: code got moved around, VMA splitting is in
> __vma_adjust]
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            | 60 ++++++++++++++++++++++++++++++-----------
>  mm/mmap.c               |  8 ++++++
>  3 files changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cc555072940f..26f2947c399d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -239,6 +239,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  
>  bool is_hugetlb_entry_migration(pte_t pte);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> +void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
>  
>  #else /* !CONFIG_HUGETLB_PAGE */
>  
> @@ -472,6 +473,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
>  
>  static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
>  
> +static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
> +
>  #endif /* !CONFIG_HUGETLB_PAGE */
>  /*
>   * hugepages at page global directory. If arch support
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 14b9494c58ed..fc5d3d665266 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -95,7 +95,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
>  static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
>  static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> -		unsigned long start, unsigned long end);
> +		unsigned long start, unsigned long end, bool take_locks);
>  static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
>  
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
> @@ -4900,26 +4900,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	if (addr & ~(huge_page_mask(hstate_vma(vma))))
>  		return -EINVAL;
> +	return 0;
> +}
>  
> +void hugetlb_split(struct vm_area_struct *vma, unsigned long addr)
> +{
>  	/*
>  	 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
>  	 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this
>  	 * split, unshare PMDs in the PUD_SIZE interval surrounding addr now.
> +	 * This function is called in the middle of a VMA split operation, with
> +	 * MM, VMA and rmap all write-locked to prevent concurrent page table
> +	 * walks (except hardware and gup_fast()).
>  	 */
> +	mmap_assert_write_locked(vma->vm_mm);
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);


The above i_mmap lock assertion is firing on stable kernels from 5.10 to 6.1
included.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11489 at include/linux/fs.h:503 i_mmap_assert_write_locked include/linux/fs.h:503 [inline]
WARNING: CPU: 0 PID: 11489 at include/linux/fs.h:503 hugetlb_split+0x267/0x300 mm/hugetlb.c:4917
Modules linked in:
CPU: 0 PID: 11489 Comm: syz-executor.4 Not tainted 6.1.142-syzkaller-00296-gfd0df5221577 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:i_mmap_assert_write_locked include/linux/fs.h:503 [inline]
RIP: 0010:hugetlb_split+0x267/0x300 mm/hugetlb.c:4917
Call Trace:
 <TASK>
 __vma_adjust+0xd73/0x1c10 mm/mmap.c:736
 vma_adjust include/linux/mm.h:2745 [inline]
 __split_vma+0x459/0x540 mm/mmap.c:2385
 do_mas_align_munmap+0x5f2/0xf10 mm/mmap.c:2497
 do_mas_munmap+0x26c/0x2c0 mm/mmap.c:2646
 __mmap_region mm/mmap.c:2694 [inline]
 mmap_region+0x19f/0x1770 mm/mmap.c:2912
 do_mmap+0x84b/0xf20 mm/mmap.c:1432
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
 ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1478
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x46a269
 </TASK>

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.


The main reason is that those branches lack the following

  commit ccf1d78d8b86e28502fa1b575a459a402177def4
  Author: Suren Baghdasaryan <surenb@google.com>
  Date:   Mon Feb 27 09:36:13 2023 -0800
  
      mm/mmap: move vma_prepare before vma_adjust_trans_huge
      
      vma_prepare() acquires all locks required before VMA modifications.  Move
      vma_prepare() before vma_adjust_trans_huge() so that VMA is locked before
      any modification.
      
      Link: https://lkml.kernel.org/r/20230227173632.3292573-15-surenb@google.com
      Signed-off-by: Suren Baghdasaryan <surenb@google.com>
      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

thus the needed lock is acquired just after vma_adjust_trans_huge() and
the newly added hugetlb_split().

Please have a look at a straightforward write-up which comes to my mind.
It does something like the ccf1d78d8b86 ("mm/mmap: move vma_prepare before
vma_adjust_trans_huge"), but in context of an old stable branch.

If looks okay, I'll be glad to prepare it as a formal patch and send it
out for the 5.10-5.15, too.

against 6.1.y
-------------
diff --git a/mm/mmap.c b/mm/mmap.c
index 0f303dc8425a..941880ed62d7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -543,8 +543,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
        if (mas_preallocate(mas, vma, GFP_KERNEL))
                goto nomem;
 
-       vma_adjust_trans_huge(vma, start, end, 0);
-
        if (file) {
                mapping = file->f_mapping;
                root = &mapping->i_mmap;
@@ -562,6 +560,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
                vma_interval_tree_remove(vma, root);
        }
 
+       vma_adjust_trans_huge(vma, start, end, 0);
+
        vma->vm_start = start;
        vma->vm_end = end;
        vma->vm_pgoff = pgoff;
@@ -727,15 +727,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
                return -ENOMEM;
        }
 
-       /*
-        * Get rid of huge pages and shared page tables straddling the split
-        * boundary.
-        */
-       vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-       if (is_vm_hugetlb_page(orig_vma)) {
-               hugetlb_split(orig_vma, start);
-               hugetlb_split(orig_vma, end);
-       }
        if (file) {
                mapping = file->f_mapping;
                root = &mapping->i_mmap;
@@ -775,6 +766,16 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
                        vma_interval_tree_remove(next, root);
        }
 
+       /*
+        * Get rid of huge pages and shared page tables straddling the split
+        * boundary.
+        */
+       vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
+       if (is_vm_hugetlb_page(orig_vma)) {
+               hugetlb_split(orig_vma, start);
+               hugetlb_split(orig_vma, end);
+       }
+
        if (start != vma->vm_start) {
                if ((vma->vm_start < start) &&
                    (!insert || (insert->vm_end != start))) {


--
Fedor

> +
>  	if (addr & ~PUD_MASK) {
> -		/*
> -		 * hugetlb_vm_op_split is called right before we attempt to
> -		 * split the VMA. We will need to unshare PMDs in the old and
> -		 * new VMAs, so let's unshare before we split.
> -		 */
>  		unsigned long floor = addr & PUD_MASK;
>  		unsigned long ceil = floor + PUD_SIZE;
>  
> -		if (floor >= vma->vm_start && ceil <= vma->vm_end)
> -			hugetlb_unshare_pmds(vma, floor, ceil);
> +		if (floor >= vma->vm_start && ceil <= vma->vm_end) {
> +			/*
> +			 * Locking:
> +			 * Use take_locks=false here.
> +			 * The file rmap lock is already held.
> +			 * The hugetlb VMA lock can't be taken when we already
> +			 * hold the file rmap lock, and we don't need it because
> +			 * its purpose is to synchronize against concurrent page
> +			 * table walks, which are not possible thanks to the
> +			 * locks held by our caller.
> +			 */
> +			hugetlb_unshare_pmds(vma, floor, ceil, /* take_locks = */ false);
> +		}
>  	}
> -
> -	return 0;
>  }
>  
>  static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
> @@ -7495,9 +7509,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
>  	}
>  }
>  
> +/*
> + * If @take_locks is false, the caller must ensure that no concurrent page table
> + * access can happen (except for gup_fast() and hardware page walks).
> + * If @take_locks is true, we take the hugetlb VMA lock (to lock out things like
> + * concurrent page fault handling) and the file rmap lock.
> + */
>  static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  				   unsigned long start,
> -				   unsigned long end)
> +				   unsigned long end,
> +				   bool take_locks)
>  {
>  	struct hstate *h = hstate_vma(vma);
>  	unsigned long sz = huge_page_size(h);
> @@ -7521,8 +7542,12 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
>  				start, end);
>  	mmu_notifier_invalidate_range_start(&range);
> -	hugetlb_vma_lock_write(vma);
> -	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	if (take_locks) {
> +		hugetlb_vma_lock_write(vma);
> +		i_mmap_lock_write(vma->vm_file->f_mapping);
> +	} else {
> +		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +	}
>  	for (address = start; address < end; address += PUD_SIZE) {
>  		ptep = huge_pte_offset(mm, address, sz);
>  		if (!ptep)
> @@ -7532,8 +7557,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		spin_unlock(ptl);
>  	}
>  	flush_hugetlb_tlb_range(vma, start, end);
> -	i_mmap_unlock_write(vma->vm_file->f_mapping);
> -	hugetlb_vma_unlock_write(vma);
> +	if (take_locks) {
> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
> +		hugetlb_vma_unlock_write(vma);
> +	}
>  	/*
>  	 * No need to call mmu_notifier_invalidate_range(), see
>  	 * Documentation/mm/mmu_notifier.rst.
> @@ -7548,7 +7575,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  {
>  	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
> -			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
> +			ALIGN_DOWN(vma->vm_end, PUD_SIZE),
> +			/* take_locks = */ true);
>  }
>  
>  #ifdef CONFIG_CMA
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ebc3583fa612..0f303dc8425a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -727,7 +727,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  		return -ENOMEM;
>  	}
>  
> +	/*
> +	 * Get rid of huge pages and shared page tables straddling the split
> +	 * boundary.
> +	 */
>  	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> +	if (is_vm_hugetlb_page(orig_vma)) {
> +		hugetlb_split(orig_vma, start);
> +		hugetlb_split(orig_vma, end);
> +	}
>  	if (file) {
>  		mapping = file->f_mapping;
>  		root = &mapping->i_mmap;
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog

