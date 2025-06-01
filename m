Return-Path: <stable+bounces-148363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D93ACA05E
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 22:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E6A3B44C1
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123FA86352;
	Sun,  1 Jun 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IExSQy9R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457962DCC0D;
	Sun,  1 Jun 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748808090; cv=none; b=K3fjB60Mw4tSPOFhfjtbb98iSENq7TKgvlHkA7j1KjyJuI2NhBINd1PGgiS2KxVXcSNRuPCeGJseDPUadhznMyXyT+20eASGV3kK/TcWe6OryOdiogEn6BEWI0SSzqPL0TWWRM6pMYRftX6G88hiHG7fhzW7kq5mDVMqTYllMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748808090; c=relaxed/simple;
	bh=aGGRaZnwPd8HwcgEfLfpENVgB57XKiU5poyxraHVk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaJO4CuNRpgjmnoZPC8ZQaXL8TYr21i90ma+Omo8mDiD8zSRshHr2pLIDjzEZfhWuMXz2LNhB4XubsAdjEnhpmobFUOhk3+TnoTuoPbOor5rc2GE/sgz+Cy7uuAEaFZsAznlfT80Ml1NG7RJ5aKW8YDqD5fFr6bOyJpP6GWEzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IExSQy9R; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311ef4fb549so3114606a91.2;
        Sun, 01 Jun 2025 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748808088; x=1749412888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5wfQviA8yPzjds+RQSjBciKS/dDPs2tg7uDFAy3E5U=;
        b=IExSQy9RaGWdEjEuusf8TUYGPIhQmvQ8MiXUoxxGNFUXajVzIXff+qDbZinShvCYny
         PcmfH+6jbKQged80f/6GIS1OsYTRiGISzWghTR9F+pWSbrwE2DmSbKdbv0/RFRQv8iPz
         Tbn/epQI1SAhD3OdCSUX7stwiNeHBCVXUkraqqJGAKNhH6mMIMC2Lw2/3k3IT2UcG1og
         XGDX7qHJoDZkz3y1FmQV6lCaZIYjsx15UGtM7oEK5EdE/feDYHw6E3FT7sPAnBcUNT2k
         v1hkzkYixXDX9k3A5/E7Ls3qaFkjrolT8d5ZffWNN21j8FOWsWx/HidpeKr8/FZZe+qT
         /xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748808088; x=1749412888;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5wfQviA8yPzjds+RQSjBciKS/dDPs2tg7uDFAy3E5U=;
        b=FI/qd9+57TelUU2n+fu+zynWLpGjT/t83674Ke5T4+Zt+20ElH0v/w2z0s2MJHGrK0
         leLbJr6foBhtxFnD2BdAhrFZ8IuusAKGDcWvzzMdiWtLVPYxxDTSUYmTHXYqUg2jIQ9G
         5Kfu1LF+HI5OpzwaW0/huOSkKRPkUBRFkWUTCVrGbABOgmLKVwR8nKJ+ybgXw/NY2aXA
         iIQSSQqRTOg9/2g9l7IA1U8meN+exGcxS8m3FNxmx2oKaSxCGsfNybpc0o6FcbZesydW
         4flqYQ35V3uBowrguAG0fXxylFFwC7s+FsZN6xWJF5P15V9+bT5i+2hm87Ch9oClGp7C
         4mMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz8lV69kW+lkZtaIaPRcTBQorGGjlo8/NjnntMiosvrGkSzz/rYzEMwYXUwtmq94V9TvFfwDy9f0aTxFc=@vger.kernel.org, AJvYcCWnIGuDYN0xA6mFXpl6+8yLkhlh4815/L7JcnNlAZ4HyxD/LNbgNefEr0NoJzEzSjZ8Hw+CBvwk@vger.kernel.org
X-Gm-Message-State: AOJu0YynAg+Z0BPZG6xx9w7IN6kLZ4wSThiufpGBNXplkzyVz1chHc+v
	jPqzRdwQ9emgpXVnCdf94r8kI0ZgevhkDVbE4DXbMvRduvwSHx8Vo/ah
X-Gm-Gg: ASbGncsaN4xnoUltQVaBybrZfo36N72uzmSdE71r7z16QxiCrwB5J/YH5a7aqttrujr
	W1wg1fb9tTFH8o44fbp059QGMCsMDqbjVtIjEaCFvGjjMtoCtuHqAFgh4huWkFnFWHLlAn+QcBr
	HXOv970zu8a4kUjdtGUtZoppjWDjxiA2t8KRDeuBeHUqarQYVHzYO9baqGeYriWvZbT66vYp0g9
	QQRVdGboNZBCecZ6NG82ookjcMaqAG79QWFNle1EMyr6JeRXKByUxy1hNEdkqqP8dPGqpQUVmFC
	Np0EAZdbL/B6ISGgoXrmytmBtKNEhFjpSnwfqQnQWQFD5ikwTo3/Ng7+Bpalpj1Xqb25RAhgzwH
	bnjRxQrQ=
X-Google-Smtp-Source: AGHT+IG4Lc9FhigZUgWldD7scIQD8VLnkGzOxYeQGikRL6B9oYrq4ZvfIN3ryGecjR7FAVoLjo/5vA==
X-Received: by 2002:a17:90a:e7cd:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-312417369b3mr15855412a91.21.1748808088316;
        Sun, 01 Jun 2025 13:01:28 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e30b832sm4356137a91.33.2025.06.01.13.01.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Jun 2025 13:01:27 -0700 (PDT)
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
Subject: [PATCH v2] mm: userfaultfd: fix race of userfaultfd_move and swap cache
Date: Mon,  2 Jun 2025 04:01:08 +0800
Message-ID: <20250601200108.23186-1-ryncsn@gmail.com>
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

Testing with a simple C program to allocate and move several GB of memory
did not show any observable performance change.

Cc: <stable@vger.kernel.org>
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>

---

V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmail.com/
Changes:
- Check swap_map instead of doing a filemap lookup after acquiring the
  PTE lock to minimize critical section overhead [ Barry Song, Lokesh Gidra ]

 mm/userfaultfd.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..a74ede04996c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1084,8 +1084,11 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
-			 struct folio *src_folio)
+			 struct folio *src_folio,
+			 struct swap_info_struct *si)
 {
+	swp_entry_t entry;
+
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1102,6 +1105,16 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	} else {
+		/*
+		 * Check if the swap entry is cached after acquiring the src_pte
+		 * lock. Or we might miss a new loaded swap cache folio.
+		 */
+		entry = pte_to_swp_entry(orig_src_pte);
+		if (si->swap_map[swp_offset(entry)] & SWAP_HAS_CACHE) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			return -EAGAIN;
+		}
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
@@ -1409,10 +1422,20 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
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
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si);
 	}
 
 out:
-- 
2.49.0


