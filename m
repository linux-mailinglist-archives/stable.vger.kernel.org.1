Return-Path: <stable+bounces-123111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB22A5A37C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB5C17057D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E31C3BE0;
	Mon, 10 Mar 2025 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifcvJvLz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39924374EA
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633074; cv=none; b=Bre9ASSYftDRe23ho2qB/t1tjk7bSJ0x+y6ccofAW7Aa/uFuSj5rJFeYVxkM9OrPVDPjTHY+kXLUwASQcWibafoTlrwACuETRGM7DBvLvhtZHj5olMqUqdyhti3+aD8nXuRvWLaAdSv9+2HIK5cGFpzmjFrt0DCIPnDAeuF7DHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633074; c=relaxed/simple;
	bh=f3tQ9JbTmWZFZRoxZdfDuyRh+oWCRYyAqnLGATmyQmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTAqnGiXuThldn01gbsO06V0eS57X9JmDWIY359J11pMN28wE9ERIBsc4PwZp1F3gY+s9J8LvJ+4LgxotQ85Wnw012ooI2LqOazQu75kaBJtyX5wSBdcgKxyDMQf3qJvwcPGi5GFlSmJDaWwrGhI8Qm9b50mYvN8mCczTLQLILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifcvJvLz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so508617a91.3
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741633071; x=1742237871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocjFRshQ3TGyfHWx5sMzys0l1kzGbS0G5Bs2fS083VQ=;
        b=ifcvJvLzT93wR2PUmjofNjBPOY/bIeNSZo6/5YvbYp4GUYjSYFzqc+8CCfiwmqPDnc
         RS6UtYKu+LFqJQTb/KtP8hc+EQ7sN7GftdJSBLCR7o4MTnLG119Exh/TdEcvAXTueVw0
         5FpB9vXiyjdpVZ7MqmbW7vXIHkBa4tkT2wS6MqHXNMkoJCbrd+NEeT9YLRqdjHDsM2C3
         7yQTBiUlKwhUyvf50Dq8/oVSVp7BjDnwi6udhRFbBcDH9SpyK0a9WVnUTU+MaXT9X+XR
         wc6IivzpIKoAbQy+Ay3uiaobQJ/YNWjD/OAqFVBhc5AZ6OoX49YOCx6VwpaJPsHcQ/FU
         5gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741633071; x=1742237871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocjFRshQ3TGyfHWx5sMzys0l1kzGbS0G5Bs2fS083VQ=;
        b=xNyqdy0Mp0kkDBvmTHw8qXiHX+sqZB+jDovOc3TFDSnXFSgvQegF0Pnkr2IH02hk5M
         Dn9lgUkyMk15sXa+rs1UVqz/8X4iv2EvhDidY+DGz30Te3f5qtia9WrEFnqqHvqb6yWW
         /NtDQkpXeFMEV0n6liB7midkohZfjDjw1yvcHrRb3ozrHvm3CSHNy6pQqIQzFbCnIbve
         wuas7AH1QPJwYzqorTfVEjl9tee4YfrO0kVKx1e+dPJIXjTZJvitSLNyHcl4BtsTeR37
         q68xA6s4nu2LzqfWj97QvWgoEcWqwTMwjywvPDHMqSfSeUL/BTQdmidts7Vv7lgDp0CY
         d5uw==
X-Gm-Message-State: AOJu0Yww6BhDTsejzX9k4zLQjY+ukFJLQG3NKpaqM1tb+rpJgdXeeYYE
	wBo3eNTx+N3fIoMdkArVxMtHqUmIX+Jfu/RPYdbf3Faa/Pypj2Jl/UWXnq4PqRJp8fRB69xfUtL
	qWjHKMgkefdlqrGG/cPrYUAKRkdrJ5/xBffAf/VZT4pFVVLjb/d6ZxSAZDdfYq2+1U1ToFYDY0F
	yCQrdjsPPFguDbl5B/YCDa3fdmhIcOiUpj
X-Google-Smtp-Source: AGHT+IGqQlW1pqLuyuh566Dc0mmpfUYDG6Hw9QlUKzSecYTe0Xefo01C2byiN8/c5LAdSobL8YvnS5ERMK0=
X-Received: from pjbkb6.prod.google.com ([2002:a17:90a:e7c6:b0:2ff:84e6:b2bd])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3906:b0:2ee:c6c8:d89f
 with SMTP id 98e67ed59e1d1-300ff0d6160mr1278659a91.14.1741633071524; Mon, 10
 Mar 2025 11:57:51 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:57:47 -0700
In-Reply-To: <2025030928-bonanza-unscrew-4f1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025030928-bonanza-unscrew-4f1c@gregkh>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310185747.1238197-1-surenb@google.com>
Subject: [PATCH 6.12.y] mm: fix kernel BUG when userfaultfd_move encounters swapcache
From: Suren Baghdasaryan <surenb@google.com>
To: stable@vger.kernel.org
Cc: Barry Song <v-songbaohua@oppo.com>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Axel Rasmussen <axelrasmussen@google.com>, 
	Brian Geffon <bgeffon@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>, 
	Tangquan Zheng <zhengtangquan@oppo.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

From: Barry Song <v-songbaohua@oppo.com>

userfaultfd_move() checks whether the PTE entry is present or a
swap entry.

- If the PTE entry is present, move_present_pte() handles folio
  migration by setting:

  src_folio->index = linear_page_index(dst_vma, dst_addr);

- If the PTE entry is a swap entry, move_swap_pte() simply copies
  the PTE to the new dst_addr.

This approach is incorrect because, even if the PTE is a swap entry,
it can still reference a folio that remains in the swap cache.

This creates a race window between steps 2 and 4.
 1. add_to_swap: The folio is added to the swapcache.
 2. try_to_unmap: PTEs are converted to swap entries.
 3. pageout: The folio is written back.
 4. Swapcache is cleared.
If userfaultfd_move() occurs in the window between steps 2 and 4,
after the swap PTE has been moved to the destination, accessing the
destination triggers do_swap_page(), which may locate the folio in
the swapcache. However, since the folio's index has not been updated
to match the destination VMA, do_swap_page() will detect a mismatch.

This can result in two critical issues depending on the system
configuration.

If KSM is disabled, both small and large folios can trigger a BUG
during the add_rmap operation due to:

 page_pgoff(folio, page) != linear_page_index(vma, address)

[   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
[   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
[   13.337716] memcg:ffff00000405f000
[   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
[   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
[   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
[   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
[   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
[   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
[   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
[   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
[   13.340190] ------------[ cut here ]------------
[   13.340316] kernel BUG at mm/rmap.c:1380!
[   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[   13.340969] Modules linked in:
[   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
[   13.341470] Hardware name: linux,dummy-virt (DT)
[   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
[   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
[   13.342018] sp : ffff80008752bb20
[   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
[   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
[   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
[   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
[   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
[   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
[   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
[   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
[   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
[   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
[   13.343876] Call trace:
[   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
[   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
[   13.344333]  do_swap_page+0x1060/0x1400
[   13.344417]  __handle_mm_fault+0x61c/0xbc8
[   13.344504]  handle_mm_fault+0xd8/0x2e8
[   13.344586]  do_page_fault+0x20c/0x770
[   13.344673]  do_translation_fault+0xb4/0xf0
[   13.344759]  do_mem_abort+0x48/0xa0
[   13.344842]  el0_da+0x58/0x130
[   13.344914]  el0t_64_sync_handler+0xc4/0x138
[   13.345002]  el0t_64_sync+0x1ac/0x1b0
[   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
[   13.345504] ---[ end trace 0000000000000000 ]---
[   13.345715] note: a.out[107] exited with irqs disabled
[   13.345954] note: a.out[107] exited with preempt_count 2

If KSM is enabled, Peter Xu also discovered that do_swap_page() may
trigger an unexpected CoW operation for small folios because
ksm_might_need_to_copy() allocates a new folio when the folio index
does not match linear_page_index(vma, addr).

This patch also checks the swapcache when handling swap entries. If a
match is found in the swapcache, it processes it similarly to a present
PTE.
However, there are some differences. For example, the folio is no longer
exclusive because folio_try_share_anon_rmap_pte() is performed during
unmapping.
Furthermore, in the case of swapcache, the folio has already been
unmapped, eliminating the risk of concurrent rmap walks and removing the
need to acquire src_folio's anon_vma or lock.

Note that for large folios, in the swapcache handling path, we directly
return -EBUSY since split_folio() will return -EBUSY regardless if
the folio is under writeback or unmapped. This is not an urgent issue,
so a follow-up patch may address it separately.

[v-songbaohua@oppo.com: minor cleanup according to Peter Xu]
  Link: https://lkml.kernel.org/r/20250226024411.47092-1-21cnbao@gmail.com
Link: https://lkml.kernel.org/r/20250226001400.9129-1-21cnbao@gmail.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Nicolas Geoffray <ngeoffray@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: ZhangPeng <zhangpeng362@huawei.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit c50f8e6053b0503375c2975bf47f182445aebb4c)
[surenb: resolved merged conflict caused by the difference in
move_swap_pte() arguments]
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/userfaultfd.c | 75 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 9 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ce13c4062647..4f24acd63a95 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -18,6 +18,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
+#include "swap.h"
 
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
@@ -1067,15 +1068,13 @@ static int move_present_pte(struct mm_struct *mm,
 	return err;
 }
 
-static int move_swap_pte(struct mm_struct *mm,
+static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 unsigned long dst_addr, unsigned long src_addr,
 			 pte_t *dst_pte, pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
-			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
+			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
+			 struct folio *src_folio)
 {
-	if (!pte_swp_exclusive(orig_src_pte))
-		return -EBUSY;
-
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
@@ -1084,6 +1083,16 @@ static int move_swap_pte(struct mm_struct *mm,
 		return -EAGAIN;
 	}
 
+	/*
+	 * The src_folio resides in the swapcache, requiring an update to its
+	 * index and mapping to align with the dst_vma, where a swap-in may
+	 * occur and hit the swapcache after moving the PTE.
+	 */
+	if (src_folio) {
+		folio_move_anon_rmap(src_folio, dst_vma);
+		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	}
+
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
@@ -1130,6 +1139,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			  __u64 mode)
 {
 	swp_entry_t entry;
+	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1297,6 +1307,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				       orig_dst_pte, orig_src_pte,
 				       dst_ptl, src_ptl, src_folio);
 	} else {
+		struct folio *folio = NULL;
+
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
 			if (is_migration_entry(entry)) {
@@ -1310,10 +1322,53 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			goto out;
 		}
 
-		err = move_swap_pte(mm, dst_addr, src_addr,
-				    dst_pte, src_pte,
-				    orig_dst_pte, orig_src_pte,
-				    dst_ptl, src_ptl);
+		if (!pte_swp_exclusive(orig_src_pte)) {
+			err = -EBUSY;
+			goto out;
+		}
+
+		si = get_swap_device(entry);
+		if (unlikely(!si)) {
+			err = -EAGAIN;
+			goto out;
+		}
+		/*
+		 * Verify the existence of the swapcache. If present, the folio's
+		 * index and mapping must be updated even when the PTE is a swap
+		 * entry. The anon_vma lock is not taken during this process since
+		 * the folio has already been unmapped, and the swap entry is
+		 * exclusive, preventing rmap walks.
+		 *
+		 * For large folios, return -EBUSY immediately, as split_folio()
+		 * also returns -EBUSY when attempting to split unmapped large
+		 * folios in the swapcache. This issue needs to be resolved
+		 * separately to allow proper handling.
+		 */
+		if (!src_folio)
+			folio = filemap_get_folio(swap_address_space(entry),
+					swap_cache_index(entry));
+		if (!IS_ERR_OR_NULL(folio)) {
+			if (folio_test_large(folio)) {
+				err = -EBUSY;
+				folio_put(folio);
+				goto out;
+			}
+			src_folio = folio;
+			src_folio_pte = orig_src_pte;
+			if (!folio_trylock(src_folio)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte = dst_pte = NULL;
+				put_swap_device(si);
+				si = NULL;
+				/* now we can block and wait */
+				folio_lock(src_folio);
+				goto retry;
+			}
+		}
+		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
+				orig_dst_pte, orig_src_pte,
+				dst_ptl, src_ptl, src_folio);
 	}
 
 out:
@@ -1330,6 +1385,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	if (src_pte)
 		pte_unmap(src_pte);
 	mmu_notifier_invalidate_range_end(&range);
+	if (si)
+		put_swap_device(si);
 
 	return err;
 }
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


