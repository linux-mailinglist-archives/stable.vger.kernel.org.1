Return-Path: <stable+bounces-148329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E7AC9678
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBE4A41B3B
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD7A213E76;
	Fri, 30 May 2025 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNq6iIah"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8D1B808;
	Fri, 30 May 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748636240; cv=none; b=hjAcdKYJGcdT9UJlNFbUYbPl2JXLgjd/PfQ5MsuEmgpcvwKeMUH1nVe8eSkArZ+6ejgQjbVX7IfudcB8fXeYmJuzpKZzv/EKOWByQpAQByBGTpHO8vv9Fq4VDEJHfdYQdKpRdpC9Gh5z9+S4f4R7R9Cx8IZ5uFtQaSGsG+ek9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748636240; c=relaxed/simple;
	bh=hWZTrTly4ZCETVQSHVeAGo57bFjr4joW00S5AzuWOpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfVHGCbL/phvjtWAcLMqSGqIzK72e2R4jOUl6jOnbwinUewVGDPoiDpY28G+qh2w1RT1E68tOHVxCWwo7409Ddu/Ziw4C5yZW2xLhXWotX1+MOaZuIWepglfinwuG2phgGzlAkBhbhTuiGBjvkmLn9L3OM+2VkA/lFqk8Q1S3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNq6iIah; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2012633b3a.2;
        Fri, 30 May 2025 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748636238; x=1749241038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNz6qun3hh1euzqXte77G8oybXmyDfbl1U3WleK9TnI=;
        b=DNq6iIahn3A/ZHLHhnhL8/FF+L67eDozPlNfIrXCgFxndmAJFlT57UgdlRTGvizrFo
         l64JgMy7omXJFA1JP198LC1IsLepYtdtd5LiNqKFyAdBtG7BcrGgFPyB0o5Y01K/Id3y
         ipM3XSxX4NknQCcElE+DWrn0ICMOSAqcBMqGKqxVSkHTzxXGVf+eJjKQ9agstqvvWE4T
         PBF2X7ciVEUjLaq0PEViIwT2Pa3/RgDr86+mbpS4OkG2ZA8r9bH1dHiSoaViFMEqHrch
         lTerUGz9mzbNY4efQXFfBFf6z0RP6IuJGAsG+2cLu7W8JRQbBJQTRyuta0/jGCwNJgKs
         Fx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748636238; x=1749241038;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNz6qun3hh1euzqXte77G8oybXmyDfbl1U3WleK9TnI=;
        b=lwBG8mz+7qzeFKXgWlGG3E4ILS8YjfXoC437QptwnuS9wULB1JTuZ/ql0qw6Bexvlj
         jPlhjIkjzGhc1OgTXxIo7w7zA55SwVFhfFgXLYIropjxNn+Gji4RAuSOP2A1s1pxhXzr
         cCa4IJ/fjD9Vha7iJcsP+kVnIyPW5HmqIqe1F6bkO2A+Rd5MBJPmh3iTsDVQZgaKk/VL
         ZNlV8RwBwFhpgoEdVzlLrv+BNN5fHuW26Q9Whf/O9ZKw+u0aaXjKlsFsPZej+EkBIjIH
         j+SnAe9VmCtDQyvK2dZSOqN461Jc/zDMFQZrZg925VHSp9dgalmdgKmYvt4EbmxycCKF
         ROXw==
X-Forwarded-Encrypted: i=1; AJvYcCWMVOaiOdPwj+uN/XDul8ZRwSuMHtfsKxSLlcJyWehIjLO4MwchHzn297QCOnHB4I5EW7puT8MY@vger.kernel.org, AJvYcCX5RiJ5C0sDjDBlfwwQaWgoONr9ds9MPSxfGiDjmNDFrAISGjNBxGd0n70YdgQiptwqHVjk14ZjpQ5gHoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoxKd55fZ7161WWOcUbQhMuEvXRKS9u7IdVgITMNo66xP35Q6
	5I3wVTwd1yX4oSRBanuMo84e5TIZwXOt0jIz1o1plbatbtDA2z7154Xep/0O/o3Qbww=
X-Gm-Gg: ASbGncu984EFHB3BhBInUNes2UIUeLE9oapYb1EPcEXp7h1lLhQUgLkxY45KdrIOadP
	UCq/SGzKms+Xd4SkpJ4tQcKTBmcPKKPUrvp3SOVX3q/8A1d3V4FwMNZk0LnjD1aJjBbeVr8YyuR
	iltdIHUgOoqIKj7UAH4k7cz/DElPoIoYh+GAaTFDCltUyAMNQjQ3ORC/wC0WaCwGVP14A5ae5Ko
	taqEcCTK5qh2gODw7bKVkZqRV73nUrAr1+nyAf8GBPNcHqkhP5AVFAhqtYgf+15GNxoabK5nOsx
	NSBf9OiRiMwY9/fkOaOOL+UkBZ1RQrfa1S1pa59KpaaF/OM0HD+aFRDkhZeXpLVYrUF5N9DjH+d
	GNBZx6yXtpuoMwvnQcQ==
X-Google-Smtp-Source: AGHT+IGiu0lFzZNa6hPiqhaDj24YWOh0gardigPDwei+AoUpJR/2KwA+p7biOIHmDCcuY50AXdtAyQ==
X-Received: by 2002:a05:6a00:744d:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-747bd96da15mr5403374b3a.7.1748636237682;
        Fri, 30 May 2025 13:17:17 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd4188sm3437056b3a.128.2025.05.30.13.17.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 13:17:17 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
Date: Sat, 31 May 2025 04:17:10 +0800
Message-ID: <20250530201710.81365-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
lookup, and try to move the found folio to the faulting vma when.
Currently, it relies on the PTE value check to ensure the moved folio
still belongs to the src swap entry, which turns out is not reliable.

While working and reviewing the swap table series with Barry, following
existing race is observed and reproduced [1]:

( move_pages_pte is moving src_pte to dst_pte, where src_pte is a
 swap entry PTE holding swap entry S1, and S1 isn't in the swap cache.)

CPU1                               CPU2
userfaultfd_move
  move_pages_pte()
    entry = pte_to_swp_entry(orig_src_pte);
    // Here it got entry = S1
    ... < Somehow interrupted> ...
                                   <swapin src_pte, alloc and use folio A>
                                   // folio A is just a new allocated folio
                                   // and get installed into src_pte
                                   <frees swap entry S1>
                                   // src_pte now points to folio A, S1
                                   // has swap count == 0, it can be freed
                                   // by folio_swap_swap or swap
                                   // allocator's reclaim.
                                   <try to swap out another folio B>
                                   // folio B is a folio in another VMA.
                                   <put folio B to swap cache using S1 >
                                   // S1 is freed, folio B could use it
                                   // for swap out with no problem.
                                   ...
    folio = filemap_get_folio(S1)
    // Got folio B here !!!
    ... < Somehow interrupted again> ...
                                   <swapin folio B and free S1>
                                   // Now S1 is free to be used again.
                                   <swapout src_pte & folio A using S1>
				   // Now src_pte is a swap entry pte
				   // holding S1 again.
    folio_trylock(folio)
    move_swap_pte
      double_pt_lock
      is_pte_pages_stable
      // Check passed because src_pte == S1
      folio_move_anon_rmap(...)
      // Moved invalid folio B here !!!

The race window is very short and requires multiple collisions of
multiple rare events, so it's very unlikely to happen, but with a
deliberately constructed reproducer and increased time window, it can be
reproduced [1].

It's also possible that folio (A) is swapped in, and swapped out again
after the filemap_get_folio lookup, in such case folio (A) may stay in
swap cache so it needs to be moved too. In this case we should also try
again so kernel won't miss a folio move.

Fix this by checking if the folio is the valid swap cache folio after
acquiring the folio lock, and checking the swap cache again after
acquiring the src_pte lock.

SWP_SYNCRHONIZE_IO path does make the problem more complex, but so far
we don't need to worry about that since folios only might get exposed to
swap cache in the swap out path, and it's covered in this patch too by
checking the swap cache again after acquiring src_pte lock.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/userfaultfd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..a1564d205dfb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
+#include <linux/delay.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
@@ -1086,6 +1087,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
 			 struct folio *src_folio)
 {
+	swp_entry_t entry;
+
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1102,6 +1105,19 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	} else {
+		/*
+		 * Check again after acquiring the src_pte lock. Or we might
+		 * miss a new loaded swap cache folio.
+		 */
+		entry = pte_to_swp_entry(orig_src_pte);
+		src_folio = filemap_get_folio(swap_address_space(entry),
+					      swap_cache_index(entry));
+		if (!IS_ERR_OR_NULL(src_folio)) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			folio_put(src_folio);
+			return -EAGAIN;
+		}
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
@@ -1409,6 +1425,16 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				folio_lock(src_folio);
 				goto retry;
 			}
+			/*
+			 * Check if the folio still belongs to the target swap entry after
+			 * acquiring the lock. Folio can be freed in the swap cache while
+			 * not locked.
+			 */
+			if (unlikely(!folio_test_swapcache(folio) ||
+				     entry.val != folio->swap.val)) {
+				err = -EAGAIN;
+				goto out;
+			}
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
-- 
2.49.0


