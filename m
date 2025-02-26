Return-Path: <stable+bounces-119573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D6A45151
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 01:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A463B1BF6
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 00:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E078F5C;
	Wed, 26 Feb 2025 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7MCXuiJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0B4689;
	Wed, 26 Feb 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528865; cv=none; b=kqIbsZcupATX1gHVc1q1qMbKtGOqoXkt/SL4ZWuvsYigUT+2sXwf+DywlkTqyuc5BZ+TaEGrHXSNF4Eo9XPUjAdwc3uNhNkz9ZBK3GoDl+yDVRu2rO/0jVtfqSe9oOw/0hBYFAjVODF8rdmUp+N7zgsmdYEtXdU0Y8grHo77CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528865; c=relaxed/simple;
	bh=hxvp5xOGEP1x8XTaXEIp0WnUEvgwT+/McffIWa07v1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbg8rhfrOeF0KU7huxKLT2moczs75HlhEG9eZGUGrqICa6rq7Ri5UKXfbO7EXeTNwfsI/OpyNgWf1izfGgrfqXW81Ox5oNJKpuukSzZbn6K6z4HgTYpNtJ92r/M4BCnvTZ3e8yCQ+fEtLCwI5aXvCmv4r3pqNu5d4zEo8vJDqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7MCXuiJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so12527249a91.0;
        Tue, 25 Feb 2025 16:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740528863; x=1741133663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DIRO3luX58Fb692QN92PavGqb9xzVHLwNZR8FZJ9W8=;
        b=X7MCXuiJIbaZEVyMs0p7GeGE4qNzQWaGEmzm19OcQEixUdfmkbLyB1bh4tjOTcW6D8
         K0h3sMHMNxoVy9sRh6MmyUWf/3t2Tr3bJStUleiGrwxc1UHs4JI15RUCYKwktOp9YSck
         CCbafn8yuJh7JO4DJIKF276Y/C1/i4+ax1JR04KKmwKY9PzCDFVi4mE9+f5HN6+qqxeE
         g921aEHOU9/u68IVyt1OOi6d+JA4EUYd19kmsdnIGKXBgnOkD1/l6xlG/Y4AfAKRrqQK
         fA8S96KMjqTiPUxkjCQvhYbXVSR+OXcc/L2JEI5ITqAH5vUv2f8IIDdrjkwYpxOgQOdh
         uBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528863; x=1741133663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DIRO3luX58Fb692QN92PavGqb9xzVHLwNZR8FZJ9W8=;
        b=Cxm7qCjncg20uyH88IiXBwJ3gopo0djdcnyszhpE5GURKHEEDl3DeCe7hhp50Xe4qD
         CuZoN0JZkV0TzUo+4GvhmMo/SR/W+9V+WczVvSxaXeB4s7ep9np1jl0mvoy33UIifUai
         YrgB+fJ7EojOnytefMSGvbuw9EVNaBb+qRmr8FZAP6msEsUUizyXiDQIRTS97VS71Zps
         rt0IMUn6r6XD8uMFF0auNfjzb9CLTkKDhwukRwz3z+962y0E/A7NkFjKirn+5hnQQPso
         zRB8n0A4zFlHPIY5m7R4sqDGUbPJG77/SQmZyLb3f1SZR6/842ealo7WnXo5IUijAlDL
         TS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx5DnfAOhb3QCFv4AT6B7AQl0eQrHjOMY62DRDUq0qoyM/WAS21K6OxlMTtgHFcnVoBpaglak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWxna8dJqHj5KQ7W63LcXK7GpZoOpYPtKiKr66OQXkkxst4h4
	TiNIpP9tJDHPK6fEkOPxtxzII1m6kYYxqYVVADEpSy8HmvBTR574
X-Gm-Gg: ASbGncv2lsS8JLC79TEoKv2NPPfaEVbFTX0dR6HQXATwTSa4lBRPR7KMp4JUwWKmUin
	F52o7ol+lQOBNW+tWPte+kTkQh34l4NSROECXN3vPOj8RJ/G7w9fg0TGOF7pvZsn728GS2k2+m1
	SeOeJyqWBzxIguiqpitVYjJVVxOEpEbRgxw76xxuSAQIOTtSY88qA1VHyutUOlqIV5M4b0suWWs
	OCsQywqKalBT1w3QWwb3sbXzx4aQb+02zc2itQKjpo0BJN+X21/6MQsM9ZlhPhjIyOxGEWucsFR
	4N2b9AJYHY7A94Ycj4pnRnnJsb4J9BfMtAWQNfXetg==
X-Google-Smtp-Source: AGHT+IH+tcF/meu04KjAIJyWYXTnvqP6CN/RslpggeabdBy9bUmHRhVjt7A5yw3T3Iv9NtcRfUig6A==
X-Received: by 2002:a17:90b:53c4:b0:2ee:70cb:a500 with SMTP id 98e67ed59e1d1-2fe7e2eb08emr2032332a91.1.1740528863104;
        Tue, 25 Feb 2025 16:14:23 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b2975sm20057815ad.259.2025.02.25.16.14.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 16:14:22 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
Date: Wed, 26 Feb 2025 13:14:00 +1300
Message-Id: <20250226001400.9129-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
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
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: ZhangPeng <zhangpeng362@huawei.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/userfaultfd.c | 76 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 867898c4e30b..2df5d100e76d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -18,6 +18,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
+#include "swap.h"
 
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
@@ -1072,16 +1073,14 @@ static int move_present_pte(struct mm_struct *mm,
 	return err;
 }
 
-static int move_swap_pte(struct mm_struct *mm,
+static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 unsigned long dst_addr, unsigned long src_addr,
 			 pte_t *dst_pte, pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
-			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
+			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
+			 struct folio *src_folio)
 {
-	if (!pte_swp_exclusive(orig_src_pte))
-		return -EBUSY;
-
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1090,10 +1089,20 @@ static int move_swap_pte(struct mm_struct *mm,
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
-	double_pt_unlock(dst_ptl, src_ptl);
 
+	double_pt_unlock(dst_ptl, src_ptl);
 	return 0;
 }
 
@@ -1137,6 +1146,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			  __u64 mode)
 {
 	swp_entry_t entry;
+	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -1318,6 +1328,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				       orig_dst_pte, orig_src_pte, dst_pmd,
 				       dst_pmdval, dst_ptl, src_ptl, src_folio);
 	} else {
+		struct folio *folio = NULL;
+
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
 			if (is_migration_entry(entry)) {
@@ -1331,9 +1343,53 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			goto out;
 		}
 
-		err = move_swap_pte(mm, dst_addr, src_addr, dst_pte, src_pte,
-				    orig_dst_pte, orig_src_pte, dst_pmd,
-				    dst_pmdval, dst_ptl, src_ptl);
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
+			if (folio && folio_test_large(folio)) {
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
+				/* now we can block and wait */
+				folio_lock(src_folio);
+				put_swap_device(si);
+				si = NULL;
+				goto retry;
+			}
+		}
+		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
+				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
+				dst_ptl, src_ptl, src_folio);
 	}
 
 out:
@@ -1350,6 +1406,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	if (src_pte)
 		pte_unmap(src_pte);
 	mmu_notifier_invalidate_range_end(&range);
+	if (si)
+		put_swap_device(si);
 
 	return err;
 }
-- 
2.39.3 (Apple Git-146)


