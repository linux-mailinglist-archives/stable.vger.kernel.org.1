Return-Path: <stable+bounces-155192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FDEAE241E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F131C21231
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07927239E93;
	Fri, 20 Jun 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kufl4mfK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74A238152
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455434; cv=none; b=lds5taGVwnoaQQ/xUbLW8kVO0UgFrKb3xuU8KrZU7D8EwR5p6FPk5myt+XkOXxX47bInxpjtUVaGu0QR1QTMxOTasmgtmEofQ8FWczy2FHcySXgMt0YhPqBZ0cspRLzjbgeEdsaUpad2voOQCZ6xKbA/5kS66OIwixrQEM1DoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455434; c=relaxed/simple;
	bh=XvivtOQCuuuu9bX8TrCV1hfEvNbQxaJmMbaUScVfOfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izt+nbXLeiK+gxqy6QH0TVcxuXSkaQ9BbL3jvlphzQaN8qmTLz2vRyqFOc4mu9g5DbgqtS5tOuyEkg88b+0SidKfwKI1c6xcGa4mojzyMzwDh2F51EB/LI+nkVxvoRyJ7h+GHOpovFqzVMDenCqTDl5yIg42CghKa2TJ12WYHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kufl4mfK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7675e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455431; x=1751060231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xxr3i4yiIkvmWmkoLO6+T8GH4JLAMjdbnJSMVstC98=;
        b=Kufl4mfKrTEy9PxEVgzIlVF3cuKce/WPlj2xTSv5G2aXaUX4wfzW1WmYdtnY0My7y8
         dYFSl41F3WcoOhkS72gobV9Bu5v/uyqV+LrjWsji/7hhJ1yKUiUa/QQoKjvUt76EYPdF
         mB9wW/bgtmTX1oTA2dPZyWDTtQMITd8TEJUGjN1VfVAZnBaL2CCkAKMYhZWqWjivYIqc
         TKdLyfMvuSdKx/RN5RR+mBosDCtmEje12WqZJu+qLj+6tndO1A6Q/p+8HTxSEi85tYCW
         2Rb3VPKp1R5bqNrqhwHdep76g9E73WV6ky/odLf1DZEjWhbpSD0vGimWZanVFcKaKZeu
         yM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455431; x=1751060231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xxr3i4yiIkvmWmkoLO6+T8GH4JLAMjdbnJSMVstC98=;
        b=Rnul+kcUPLbLmoiuU+0keO6F7Ax0/V9fCClHukZg2QzrKdwYVl9ZvawSmnpO4nHo1c
         nsdO3djv3RwlQ//ACqc5ZmxS5Xi+ceUKbknbCKWSrNuiRXVUvFpPq4wSCUG2izUcqvxx
         NFoyCeWGRd8/TvxuOOUz8mfeakLoL8/m2/hU2ZTj59rhCMTz/uUg+LppL6p+H44eYoBD
         UYZjtmtVNprdCrbWamNcrsUOgpkzw29/FD4sZE7DyFygFPRp491+r8Ob0WOTWcatVSUe
         FLl99AvY4EKyIaphE5c6LMjLj8YwjgugAJhZ4H0LeDrkrnFKjf93A3oglCh07lgdnaI+
         A+dg==
X-Gm-Message-State: AOJu0YwipC99A5NgwVftVsLIeWn6veY7B5r5/gc5cu+UAzLJJlEosJbh
	BJ6raZnkJcgmqc823kLQBicdeB4oJS4iJnhoNxB12vdnJ3+CdNbhBp5PyYsFbfFfzTgJW/fgcd/
	HrT35XdAd
X-Gm-Gg: ASbGnctU93488YTMSJ1smDppLntApVrz+S9x/ebEMlYUTOfebY6rynOG9knRjGWLLVd
	KcNAPRRhQXxgKSRzRy6QLg4gRrkwQ6bsKEy5vCoPvwhCCxamVvVUT/mALzWylj08n+JiPC85QkY
	Ek+wEfmPZgBPotXeA8dxdJVha7aIaO8YjnG62c0dMxJTCGYgjPuf1Mwxw+IDsEb5z3ogWKpJeZm
	uEQARl4QpMaLEkW0trMP9wFW76aSnWfVCBbQhgPF4w2ovPjcXRsBnJcPLsYjohHqHk7fzejDOg9
	mRXwCD6zq2IfuU0bydFzfH6IwByIwVV8agu8mzLdnzYWc53LmlTS71WlI2+l8g==
X-Google-Smtp-Source: AGHT+IGXNYIz3nq0XPBD27C3x0UkSFKqh8+eCP215gMFo9wBZfd1QA02noZd+gWHMwfW11RghG2K0A==
X-Received: by 2002:a05:600c:8112:b0:442:feea:622d with SMTP id 5b1f17b1804b1-4536b54b58fmr82435e9.1.1750455431159;
        Fri, 20 Jun 2025 14:37:11 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4536470371csm35656325e9.30.2025.06.20.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:37:10 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 3/4] mm: hugetlb: independent PMD page table shared count
Date: Fri, 20 Jun 2025 23:37:05 +0200
Message-ID: <20250620213706.161203-3-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <20250620213706.161203-1-jannh@google.com>
References: <2025062043-plunging-sculpture-7ca1@gregkh>
 <20250620213706.161203-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Shixin <liushixin2@huawei.com>

[ Upstream commit 59d9094df3d79443937add8700b2ef1a866b1081 ]

The folio refcount may be increased unexpectly through try_get_folio() by
caller such as split_huge_pages.  In huge_pmd_unshare(), we use refcount
to check whether a pmd page table is shared.  The check is incorrect if
the refcount is increased by the above caller, and this can cause the page
table leaked:

 BUG: Bad page state in process sh  pfn:109324
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
 flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
 page_type: f2(table)
 raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
 raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
 page dumped because: nonzero mapcount
 ...
 CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
 Tainted: [B]=BAD_PAGE
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x80/0xf8
  dump_stack+0x18/0x28
  bad_page+0x8c/0x130
  free_page_is_bad_report+0xa4/0xb0
  free_unref_page+0x3cc/0x620
  __folio_put+0xf4/0x158
  split_huge_pages_all+0x1e0/0x3e8
  split_huge_pages_write+0x25c/0x2d8
  full_proxy_write+0x64/0xd8
  vfs_write+0xcc/0x280
  ksys_write+0x70/0x110
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x34/0x128
  el0t_64_sync_handler+0xc8/0xd0
  el0t_64_sync+0x190/0x198

The issue may be triggered by damon, offline_page, page_idle, etc, which
will increase the refcount of page table.

1. The page table itself will be discarded after reporting the
   "nonzero mapcount".

2. The HugeTLB page mapped by the page table miss freeing since we
   treat the page table as shared and a shared page table will not be
   unmapped.

Fix it by introducing independent PMD page table shared count.  As
described by comment, pt_index/pt_mm/pt_frag_refcount are used for s390
gmap, x86 pgds and powerpc, pt_share_count is used for x86/arm64/riscv
pmds, so we can reuse the field as pt_share_count.

Link: https://lkml.kernel.org/r/20241216071147.3984217-1-liushixin2@huawei.com
Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Ken Chen <kenneth.w.chen@intel.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[backport note: struct ptdesc did not exist yet, stuff it equivalently
into struct page instead]
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/mm.h       |  3 +++
 include/linux/mm_types.h |  3 +++
 mm/hugetlb.c             | 18 ++++++++----------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 94e630862d58..e159a11424f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2318,6 +2318,9 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	atomic_set(&page->pt_share_count, 0);
+#endif
 	inc_zone_page_state(page, NR_PAGETABLE);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4eb38918da8f..b6cf570dc98c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -151,6 +151,9 @@ struct page {
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+				atomic_t pt_share_count;
+#endif
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0711f91f5c5e..2221c6acebbb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5442,7 +5442,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 			spte = huge_pte_offset(svma->vm_mm, saddr,
 					       vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				atomic_inc(&virt_to_page(spte)->pt_share_count);
 				break;
 			}
 		}
@@ -5457,7 +5457,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		atomic_dec(&virt_to_page(spte)->pt_share_count);
 	}
 	spin_unlock(ptl);
 out:
@@ -5468,11 +5468,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 /*
  * unmap huge page backed by shared pte.
  *
- * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
- * indicated by page_count > 1, unmap is achieved by clearing pud and
- * decrementing the ref count. If count == 1, the pte page is not shared.
- *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
@@ -5480,17 +5476,19 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 					unsigned long *addr, pte_t *ptep)
 {
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 	pgd_t *pgd = pgd_offset(mm, *addr);
 	p4d_t *p4d = p4d_offset(pgd, *addr);
 	pud_t *pud = pud_offset(p4d, *addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-	BUG_ON(page_count(virt_to_page(ptep)) == 0);
-	if (page_count(virt_to_page(ptep)) == 1)
+	if (sz != PMD_SIZE)
+		return 0;
+	if (!atomic_read(&virt_to_page(ptep)->pt_share_count))
 		return 0;
 
 	pud_clear(pud);
-	put_page(virt_to_page(ptep));
+	atomic_dec(&virt_to_page(ptep)->pt_share_count);
 	mm_dec_nr_pmds(mm);
 	/*
 	 * This update of passed address optimizes loops sequentially
-- 
2.50.0.rc2.701.gf1e915cc24-goog


