Return-Path: <stable+bounces-155188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28EAE2419
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4506F16627E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151F237A3B;
	Fri, 20 Jun 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWbrYYX/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2521FF28
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455341; cv=none; b=OtDpC/L7qLxUgh0eQ10AQl835jD01EreIJrofVNsxUov8GWg13dO6b0OErm906uZhBVCve2+i+wC/A3TCG7qnAo9s1P+YblbZqQlGCj7i+vhogUIi35S2KiiCwmP7Q4YD+hB0qOZ0O11p3cF++/s3UZikmxqSwCAj1mNw9v0GsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455341; c=relaxed/simple;
	bh=RaUuZnHvpUx8KGUfT+HsYL5+LcML43doSKv4VcwSGT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAFQC4S1+xBt2SozKA6ytaIo7EDe4Drty0E1cQI7OJAwAt8Gt7FhGsu/RPPg1PY+cDUFDysYhCZDhtye7Bsy898vt3Ob7clva/F9YeHR518vjBGiLBlm7HO74AfwHdjNyHUcgyBlplx7+DZ2+Ckj1/iwbn6/7oiwstKLZFDHey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWbrYYX/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7565e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455337; x=1751060137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlk3Mt5Coy64Z3vLsNnekv2nA6UFdklj5EboQW76K5c=;
        b=RWbrYYX/6CuI1XzK0EmIwoPhk2EIywA2L04H4PR0kdSVlgnkDCRuh7DPeXDWzfWCvb
         vCOD08HB+jAW/AeHmw8tNkjcRfufU3Udt2eNNtat4+XkZFkHP9zhshq8Gz4ecmn0F3I0
         Hiqnma/Qj6AWytQIzLjZPmnu2cpv1znmPENltS791H9z+63p14axVfybbLSFL4dcXQKq
         vw0Nn2FRrJboLQBkrSOH/ZmBcd3lp/zyGu3V2Wk2d1GR7JbR/UUJrvrGb0b/QtWK3RjF
         jEQFZHSHmJkeylZTSz0O6+oWEqTHQtAm0Kw1hzM73icpz57VvT2CDSg7QE0CfwYr5kYG
         xLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455337; x=1751060137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlk3Mt5Coy64Z3vLsNnekv2nA6UFdklj5EboQW76K5c=;
        b=jR5pB0pmxKjCC1DRgPHvCydz4xslj8aEWuwgicVoArJ608H9knI1U98Hl36UWWfz1a
         +cIeJNGLruJJFMDc57gGs+HbWwR3oXnQF372fPLJNbOAIyUs3+qISpx9SQGJh8Jwmou5
         aDvxSW+7914JUHOTPsn4+6OTxdc+ZO1LHu0Z/JRkvkc16RWgP9qjq/iR7DI4vnBGtx0g
         5E7QzZMwaoURLUe+ILUo9ji3ONMHk8CQAJFY86zD1GNXEeTjlnna/H/x0trmYBZlnz1v
         yZwIbnoMNpGI98+/M0yAHEH0obubqT5Ol+MT0KAseSWPJH8vrhcc2nX98+wlO5d++dYS
         9RQw==
X-Gm-Message-State: AOJu0Yy21a2wdZxMzUfIXQXX0iEAC7Ux17BllBYoXvWdKuGzUEWDjeTS
	APraZP7Z4xSNA6+/X5mj9Km5dzqmKVM7MW5FQTnBXfFQK84UHL2nIxQhdALYC1KqQMS+hAS1iq+
	WJR+9Pspq
X-Gm-Gg: ASbGncvyoyLUwFvrnVGgsBgseUt4ZdzpMw5OHRWxOQP85/M4yjd0a+/TGNYqQ+/kAiX
	FJyhSD5Dfjqe/j+nooRSYNCJBE86ZDsu9fR+i+11408RB11aZjEMGBNUie6hu7xz1VENTeOSIbY
	VUZhMxIIKqmmz3VvTlwYS71OHH77pqOvK8YNUgJvYsmUNDVvxrhywwi85SYmaIFMJSBVKLcPu60
	MeNnBcEZQ9UkjTiFtC5qp3oXKSKKm6Iy4H+xi4jVyGlYqpmGmp4hy6y9fuknPncJLbs3moIgOGW
	WpN7afScKcd+c0tKJuV+P6EXi+FaVC5c57hEj2K5iXbcvOAY15I2sYVr8MnBNg==
X-Google-Smtp-Source: AGHT+IG1/X0UBYr+ItOMohD0dkbkbxgI037T0tvQb3w4OnonkKt9D1jEKr8Gl1dlSoZta8PsfQy5DQ==
X-Received: by 2002:a05:600c:8112:b0:442:feea:622d with SMTP id 5b1f17b1804b1-4536b54b58fmr79165e9.1.1750455336822;
        Fri, 20 Jun 2025 14:35:36 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e983a4bsm70666025e9.13.2025.06.20.14.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:35:36 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 2/3] mm: hugetlb: independent PMD page table shared count
Date: Fri, 20 Jun 2025 23:35:31 +0200
Message-ID: <20250620213532.159985-2-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <20250620213532.159985-1-jannh@google.com>
References: <2025062042-thrill-gyration-f247@gregkh>
 <20250620213532.159985-1-jannh@google.com>
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
index 5692055f202c..720e16d1e9b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2352,6 +2352,9 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	atomic_set(&page->pt_share_count, 0);
+#endif
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..5e1278c46d0a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -166,6 +166,9 @@ struct page {
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
index 82dd31063270..e45773b08b5c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6046,7 +6046,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 			spte = huge_pte_offset(svma->vm_mm, saddr,
 					       vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				atomic_inc(&virt_to_page(spte)->pt_share_count);
 				break;
 			}
 		}
@@ -6061,7 +6061,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		atomic_dec(&virt_to_page(spte)->pt_share_count);
 	}
 	spin_unlock(ptl);
 out:
@@ -6072,11 +6072,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -6084,17 +6080,19 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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


