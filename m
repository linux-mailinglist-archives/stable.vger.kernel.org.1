Return-Path: <stable+bounces-155231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2796AE2889
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 12:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410527A8F56
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB7C1FDA94;
	Sat, 21 Jun 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm1aCaXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB001E5B73
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750500922; cv=none; b=MgRsU2Pf9pDcvopiSepxtSMiKEWXgDv9H6TUjCBgXKzwB72OwBcvYSRpa7mKISOE8TAkKZLHFKcif5Cq8Us8C/Li6Fadb1jqSlfqx0l38ufzhAozC9N36e6NzjBmMvjPOkjE+y5p7wOT98tkDCTzqEcUiphQboqJ3xVtNWuU+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750500922; c=relaxed/simple;
	bh=qQpjMUkQzg++64T28mYqm3BaQcXxg6lAubk8DEpEJpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKb9VMxtZ5d/6a0vBpNUW3EVeuFaE+Jy7xQc5xPnyuKq5+j2OF/9LLL5B8J4DF2Et0MekhPnGr2zly3aRjcm+ahZaeEAOp8Yi7Pd/4F/4rQnGKfv8IH+lcAxe//nwnGQ1cpDwWPeD9+4aaP3rQ+o0q/92r8XgvRwGXpmxM8/8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm1aCaXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83798C4CEF0;
	Sat, 21 Jun 2025 10:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750500922;
	bh=qQpjMUkQzg++64T28mYqm3BaQcXxg6lAubk8DEpEJpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mm1aCaXTfPoGeeykQPcRMY0fJNYfmvTuLfgJvXZx1K0sv1KBTo8UzcZVYF16o7gIg
	 BozV9iNTQsNwfg+8ndrc8TPOFi2PLbQ+XBqC0ilczfBquW/i+Pfz6iZpu4J2GCP9Nz
	 PAiFRF3+uybkKn6uPW8aZcTyYNr1d3nZ6MXYAPEvGeOgHGIMccZuTzYBQwESmSQRdG
	 hhnKHUc2b2DEqEI7iGY9764fpolCVAXZIViHZrCXdQ519Z2aJoalZQGMsscCLzcv3Z
	 RhkSNctazloDKALIZaG04R7UGJOjO1yL+SVAGG00JPmPjRpMv9hZN2hISk4n9hbqrL
	 c26ososk/VwvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jannh@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: unshare page tables during VMA split, not before
Date: Sat, 21 Jun 2025 06:15:20 -0400
Message-Id: <20250621052841-2e82f10b66fe127f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620213127.157399-1-jannh@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 081056dc00a27bccb55ccc3c6f230a3d5fd3f7e0

Status in newer kernel trees:
6.15.y | Present (different SHA1: 4391f7f0f242)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  081056dc00a27 ! 1:  e8ec25e3d047b mm/hugetlb: unshare page tables during VMA split, not before
    @@ Commit message
         Cc: <stable@vger.kernel.org>    [b30c14cd6102: hugetlb: unshare some PMDs when splitting VMAs]
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    [stable backport: code got moved from mmap.c to vma.c]
    +    Signed-off-by: Jann Horn <jannh@google.com>
     
      ## include/linux/hugetlb.h ##
    -@@ include/linux/hugetlb.h: bool is_hugetlb_entry_migration(pte_t pte);
    - bool is_hugetlb_entry_hwpoisoned(pte_t pte);
    +@@ include/linux/hugetlb.h: long hugetlb_change_protection(struct vm_area_struct *vma,
    + 
    + bool is_hugetlb_entry_migration(pte_t pte);
      void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
    - void fixup_hugetlb_reservations(struct vm_area_struct *vma);
     +void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
      
      #else /* !CONFIG_HUGETLB_PAGE */
      
    -@@ include/linux/hugetlb.h: static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
    - {
    - }
    +@@ include/linux/hugetlb.h: static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
    + 
    + static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
      
     +static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
     +
      #endif /* !CONFIG_HUGETLB_PAGE */
    - 
    - #ifndef pgd_write
    + /*
    +  * hugepages at page global directory. If arch support
     
      ## mm/hugetlb.c ##
     @@ mm/hugetlb.c: static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
    @@ mm/hugetlb.c: static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
     +		unsigned long start, unsigned long end, bool take_locks);
      static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
      
    - static void hugetlb_free_folio(struct folio *folio)
    + static inline bool subpool_is_free(struct hugepage_subpool *spool)
     @@ mm/hugetlb.c: static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
      {
      	if (addr & ~(huge_page_mask(hstate_vma(vma))))
    @@ mm/hugetlb.c: static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigne
      
      static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
     @@ mm/hugetlb.c: void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
    - 	spin_unlock_irq(&hugetlb_lock);
    + 	}
      }
      
     +/*
    @@ mm/hugetlb.c: static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
     +			/* take_locks = */ true);
      }
      
    - /*
    + #ifdef CONFIG_CMA
     
    - ## mm/vma.c ##
    -@@ mm/vma.c: __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
    + ## mm/mmap.c ##
    +@@ mm/mmap.c: int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
      	init_vma_prep(&vp, vma);
      	vp.insert = new;
      	vma_prepare(&vp);
    -+
     +	/*
     +	 * Get rid of huge pages and shared page tables straddling the split
     +	 * boundary.
     +	 */
    - 	vma_adjust_trans_huge(vma, vma->vm_start, addr, NULL);
    + 	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
     +	if (is_vm_hugetlb_page(vma))
     +		hugetlb_split(vma, addr);
      
      	if (new_below) {
      		vma->vm_start = addr;
    -
    - ## tools/testing/vma/vma_internal.h ##
    -@@ tools/testing/vma/vma_internal.h: static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
    - 	(void)next;
    - }
    - 
    -+static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
    -+
    - static inline void vma_iter_free(struct vma_iterator *vmi)
    - {
    - 	mas_destroy(&vmi->mas);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

