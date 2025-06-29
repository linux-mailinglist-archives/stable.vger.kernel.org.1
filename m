Return-Path: <stable+bounces-158846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD35AECCC8
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 15:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9A57A7DBE
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDE21D58C;
	Sun, 29 Jun 2025 13:07:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3951E412A
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751202464; cv=none; b=Ir+DjdA6K2Z4ka2yjv6hpZs+Tx4DRDF7ziZ44LvPBSjj1CZFoTgbqm1rRwp9hc+EhtoI9mjcKkxFPG2rMjVK/xGZhFM1KqczhyHGF7bi3lNjT2g7/PNJmp+2toFHzJQJxRhLXq/3un0nnRZfNCcKpRfpzvyP43DbO5gDgkRUaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751202464; c=relaxed/simple;
	bh=dETYPqnfeExW+bmSLqP4SP1nKeGy7MP7b4bqwqTzBcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSp5WkdnRvEBEbOwnQAVPVOHB5J2Mx8dfZzEUrUQW7K2ldDeueXNjbhuvRvYuL8rtO7DJnFUzODt7mQRW/dcwYzv73ixzEhgIdUfYN8tCbwOGI0BMJ5bg3YXzgRN6hk7zWLL825ntQxfSTk15bSi5w+qN8m4KPJA6w3Pzzstwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 6E94172C8F5;
	Sun, 29 Jun 2025 16:00:46 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 63C8F36D0184;
	Sun, 29 Jun 2025 16:00:46 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id 47C73360D500; Sun, 29 Jun 2025 16:00:46 +0300 (MSK)
Date: Sun, 29 Jun 2025 16:00:46 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Jann Horn <jannh@google.com>, Sasha Levin <sashal@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Jane Chu <jane.chu@oracle.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	Muchun Song <muchun.song@linux.dev>, Ken Chen <kenneth.w.chen@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Liu Shixin <liushixin2@huawei.com>, linux-mm@kvack.org
Subject: Re: [PATCH 6.1.y 2/3] mm: hugetlb: independent PMD page table shared
 count
Message-ID: <srhpjxlqfna67blvma5frmy3aa@altlinux.org>
References: <2025062041-uplifted-cahoots-6c42@gregkh>
 <20250620213334.158850-1-jannh@google.com>
 <20250620213334.158850-2-jannh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620213334.158850-2-jannh@google.com>

Hi,

LTP tests failure with the following commit described below:

On Fri, Jun 20, 2025 at 11:33:32PM +0200, Jann Horn wrote:
> From: Liu Shixin <liushixin2@huawei.com>
> 
> [ Upstream commit 59d9094df3d79443937add8700b2ef1a866b1081 ]
> 
> The folio refcount may be increased unexpectly through try_get_folio() by
> caller such as split_huge_pages.  In huge_pmd_unshare(), we use refcount
> to check whether a pmd page table is shared.  The check is incorrect if
> the refcount is increased by the above caller, and this can cause the page
> table leaked:
> 
>  BUG: Bad page state in process sh  pfn:109324
>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
>  flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
>  page_type: f2(table)
>  raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
>  raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
>  page dumped because: nonzero mapcount
>  ...
>  CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
>  Tainted: [B]=BAD_PAGE
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  Call trace:
>   show_stack+0x20/0x38 (C)
>   dump_stack_lvl+0x80/0xf8
>   dump_stack+0x18/0x28
>   bad_page+0x8c/0x130
>   free_page_is_bad_report+0xa4/0xb0
>   free_unref_page+0x3cc/0x620
>   __folio_put+0xf4/0x158
>   split_huge_pages_all+0x1e0/0x3e8
>   split_huge_pages_write+0x25c/0x2d8
>   full_proxy_write+0x64/0xd8
>   vfs_write+0xcc/0x280
>   ksys_write+0x70/0x110
>   __arm64_sys_write+0x24/0x38
>   invoke_syscall+0x50/0x120
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x34/0x128
>   el0t_64_sync_handler+0xc8/0xd0
>   el0t_64_sync+0x190/0x198
> 
> The issue may be triggered by damon, offline_page, page_idle, etc, which
> will increase the refcount of page table.
> 
> 1. The page table itself will be discarded after reporting the
>    "nonzero mapcount".
> 
> 2. The HugeTLB page mapped by the page table miss freeing since we
>    treat the page table as shared and a shared page table will not be
>    unmapped.
> 
> Fix it by introducing independent PMD page table shared count.  As
> described by comment, pt_index/pt_mm/pt_frag_refcount are used for s390
> gmap, x86 pgds and powerpc, pt_share_count is used for x86/arm64/riscv
> pmds, so we can reuse the field as pt_share_count.

The commit causes LTP test memfd_create03 to fail on i586 architecture
on v6.1.142 stable release, the test was passing on v6.1.141. Found the
commit with git bisect.

The failure:

  root@i586:~# /usr/lib/ltp/testcases/bin/memfd_create03
  tst_hugepage.c:78: TINFO: 2 hugepage(s) reserved
  tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
  memfd_create03.c:171: TINFO: --TESTING WRITE CALL IN HUGEPAGES--
  memfd_create03.c:176: TINFO: memfd_create() succeeded
  memfd_create03.c:70: TPASS: write(3, "LTP", 3) failed as expected

  memfd_create03.c:171: TINFO: --TESTING PAGE SIZE OF CREATED FILE--
  memfd_create03.c:176: TINFO: memfd_create() succeeded
  memfd_create03.c:43: TINFO: mmap((nil), 4194304, 2, 2, 3, 0) succeeded
  memfd_create03.c:92: TINFO: munmap(0xb7800000, 1024kB) failed as expected
  memfd_create03.c:92: TINFO: munmap(0xb7800000, 2048kB) failed as expected
  memfd_create03.c:92: TINFO: munmap(0xb7800000, 3072kB) failed as expected
  memfd_create03.c:111: TPASS: munmap() fails for page sizes less than 4096kB

  memfd_create03.c:171: TINFO: --TESTING HUGEPAGE ALLOCATION LIMIT--
  memfd_create03.c:176: TINFO: memfd_create() succeeded
  memfd_create03.c:39: TBROK: mmap((nil),0,2,2,3,0) failed: EINVAL (22)

  Summary:
  passed   2
  failed   0
  broken   1
  skipped  0
  warnings 0

dmesg while the test run:

  [   16.072078] memfd_create03 (203): drop_caches: 3
  [   16.075298] mm/pgtable-generic.c:51: bad pgd 7d4000e7

The same error occurs for v5.10.239. There is no test failure on v6.12.35 nor
v6.15.4 even though they contain the same commit.

Thanks,

> 
> Link: https://lkml.kernel.org/r/20241216071147.3984217-1-liushixin2@huawei.com
> Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Ken Chen <kenneth.w.chen@intel.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nanyong Sun <sunnanyong@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [backport note: struct ptdesc did not exist yet, stuff it equivalently
> into struct page instead]
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/mm.h       |  3 +++
>  include/linux/mm_types.h |  3 +++
>  mm/hugetlb.c             | 16 +++++++---------
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 03357c196e0b..b36dffbfbe69 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2537,6 +2537,9 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
>  	if (!pmd_ptlock_init(page))
>  		return false;
>  	__SetPageTable(page);
> +#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +	atomic_set(&page->pt_share_count, 0);
> +#endif
>  	inc_lruvec_page_state(page, NR_PAGETABLE);
>  	return true;
>  }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index a9c1d611029d..9b64610eddcc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -160,6 +160,9 @@ struct page {
>  			union {
>  				struct mm_struct *pt_mm; /* x86 pgds only */
>  				atomic_t pt_frag_refcount; /* powerpc */
> +#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +				atomic_t pt_share_count;
> +#endif
>  			};
>  #if ALLOC_SPLIT_PTLOCKS
>  			spinlock_t *ptl;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fc5d3d665266..a3907edf2909 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7114,7 +7114,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  			spte = huge_pte_offset(svma->vm_mm, saddr,
>  					       vma_mmu_pagesize(svma));
>  			if (spte) {
> -				get_page(virt_to_page(spte));
> +				atomic_inc(&virt_to_page(spte)->pt_share_count);
>  				break;
>  			}
>  		}
> @@ -7129,7 +7129,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  				(pmd_t *)((unsigned long)spte & PAGE_MASK));
>  		mm_inc_nr_pmds(mm);
>  	} else {
> -		put_page(virt_to_page(spte));
> +		atomic_dec(&virt_to_page(spte)->pt_share_count);
>  	}
>  	spin_unlock(ptl);
>  out:
> @@ -7141,10 +7141,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  /*
>   * unmap huge page backed by shared pte.
>   *
> - * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
> - * indicated by page_count > 1, unmap is achieved by clearing pud and
> - * decrementing the ref count. If count == 1, the pte page is not shared.
> - *
>   * Called with page table lock held.
>   *
>   * returns: 1 successfully unmapped a shared pte page
> @@ -7153,18 +7149,20 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {
> +	unsigned long sz = huge_page_size(hstate_vma(vma));
>  	pgd_t *pgd = pgd_offset(mm, addr);
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	pud_t *pud = pud_offset(p4d, addr);
>  
>  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>  	hugetlb_vma_assert_locked(vma);
> -	BUG_ON(page_count(virt_to_page(ptep)) == 0);
> -	if (page_count(virt_to_page(ptep)) == 1)
> +	if (sz != PMD_SIZE)
> +		return 0;
> +	if (!atomic_read(&virt_to_page(ptep)->pt_share_count))
>  		return 0;
>  
>  	pud_clear(pud);
> -	put_page(virt_to_page(ptep));
> +	atomic_dec(&virt_to_page(ptep)->pt_share_count);
>  	mm_dec_nr_pmds(mm);
>  	return 1;
>  }
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog
> 

