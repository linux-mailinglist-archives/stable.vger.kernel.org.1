Return-Path: <stable+bounces-150621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38650ACBAFC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A2F1647F5
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540941CDFD4;
	Mon,  2 Jun 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXPIQt/D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582E229B16;
	Mon,  2 Jun 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888069; cv=none; b=uHFXfYRMtU2uqkmlfhu0cqJivBxDPVnXE7oo7f7Qt5zIarXIXIo979yitB2d10/jotf66hn1U84PUtTA4LrguzNecaugRTX4aNw/Ficr+zV9QZps0+z/Y/rx/9tuW3ivNluS18kBJWgP6LmUKXIUJj/RJGnS2qYqAZB57vjrRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888069; c=relaxed/simple;
	bh=WlrnfOLtX7txl2cuPp/DmsvZdpij2ZhEMFWtoJ1eEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRrRwBCiMhPfUpx5dRbJgA/lMnpQ1r39oGXsfNPsdPJniwhWpbJquVG1eG2FZDUFwFLEADsIsmKy0QUtUC1t8+pMnDm8D4ob0Wf7Zs/EB1SJ8ygcA5KlaaeDwEDoha+01pmJtGtgPo/CgJ4Yc4lUIDSYNYb9hqNpHh3gQHrIDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXPIQt/D; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2353a2bc210so29557565ad.2;
        Mon, 02 Jun 2025 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748888067; x=1749492867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDZ3mQFVfy4xCt7wewUY81eAfsa93TjxeELX/NJDSpw=;
        b=dXPIQt/Dq5ZlOh+cWMTnT3/OWZj3q6/1MMWjFFhyikTggaTgslUKGJVGL0yEIwWS5D
         hG1fQh0AD7M/qTYwoC9bbK2oBtPMVFmgPph3qo0SyuTzaUgCGkmZAI/ZnpVrhvoBsEL9
         Fz4RQ545aYKEqYuIk93DoiiWi3iAnmpVXYFfseOVwiVG8Vz3HvrzPlfZEYaMsqg8+f7p
         RffWcThXA42BZyc3AIgLB1NzOcq1FtXZLvMjdew418my/SBwKq2CfixJam9c+S1k65yc
         K1lnVwHNSPzT+94pDn5NMyM8PBkGbU+kWnRma1d4CY0hRlbLm9Qez+3iApty2Pmh0CJz
         N0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748888067; x=1749492867;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDZ3mQFVfy4xCt7wewUY81eAfsa93TjxeELX/NJDSpw=;
        b=JUoLVputRoV0pr8Uf1pyaOA9JrwbgtvrVx7kfNV7ay6yGyZ1gUL73a201zBSX8QiDI
         Lq0KrgNMJtwZsQNhVgyeudSfE9XTMpW/W+HZcy8sYnxWMxLnxf6F1WkIM1cl1X0+qsd1
         tupJcEzCUHC/F0OPQlucmZxxWQIKMEWgu+PWHa+pwrmwat1ZwycGP96Q2qiM7HxNZt1O
         vXijWv89zkvHZkFbZP6C3xRjg/7sl1u9ia0vUO5vn14pVAr71dTaeyWfL2oNaYhma2Gk
         x6e8rmK3545BsLt/WSlerHSOrYv7dWdS8b6PPpAlk+IPbtTFD1FxGnVBXHk/NGxHCElr
         ftYw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vUtlRZHh86gVZeXGMzYOQxsDwDnd+iYFGD2bQJlB2m4gLlYGNbga8W64oRWGWqsIRNXpACkH+Qd5CgQ=@vger.kernel.org, AJvYcCVIPTGygRWF76GSGvt4K0c7enNca4+mIFVIV4jLiMmJqivcASUAmZWAaPJlmQMVsllcoUVJq0Zp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyouk2qTaUwFPX/8xs+2+VabZtpsGXbzqedrXJUyi4duXcbqcp
	H3KB8PxgqjEUVNewTZ7XdY1Gfh1OR/BwaDvzzUCkR6g37raW+kJHrYLS
X-Gm-Gg: ASbGncsGWKgBfzHh5Cks2h3YrllS6+5jG9Zxx4KdyrhhwjENwCWXBbDZ6UYx0kSm0f0
	0BMdL4BSRSXhIgFY+2A0WWxWIoUKzskdX7vkJkwyTJuJZFhSNTLYJHgqtHP9YZyELVHRYlAr4Eu
	vKrahazfFX8EYuBjJ/EtI6x6Vtnau/Apc/fykZMM34rl7qJEs6bHPl/rmY8XsKJSLh6Y3oFOaUz
	poIh7k7YkHxlVQgn5QlSUotQUNAucYE7ZdGqY0PgCCsq7tXARodZXx2las8Ff6mVvisuDRlOxci
	AEofslUhRqTkFXsZ0FSmgm6rLmNJbuaFns3LAKPr08mhdDXfW08DpjUoDn/sIGu6jlMNSak9rSd
	lEUgQaFo=
X-Google-Smtp-Source: AGHT+IFNUzydhhbwzDlKGYhPSEDvNyUIjQMWLcCreC/Ptd/11scl6UUMIg4C1XJP1X2NKPSLK4iw2g==
X-Received: by 2002:a17:902:f610:b0:229:1619:ab58 with SMTP id d9443c01a7336-235396e2a84mr204137485ad.43.1748888066475;
        Mon, 02 Jun 2025 11:14:26 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2354fd632d7sm45031275ad.130.2025.06.02.11.14.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Jun 2025 11:14:25 -0700 (PDT)
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
Subject: [PATCH v3] mm: userfaultfd: fix race of userfaultfd_move and swap cache
Date: Tue,  3 Jun 2025 02:14:19 +0800
Message-ID: <20250602181419.20478-1-ryncsn@gmail.com>
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

V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gmail.com/
Changes:
- Move the folio and swap check inside move_swap_pte to avoid skipping
  the check and potential overhead [ Lokesh Gidra ]
- Add a READ_ONCE for the swap_map read to ensure it reads a up to dated
  value.

 mm/userfaultfd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..5dc05346e360 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
-			 struct folio *src_folio)
+			 struct folio *src_folio,
+			 struct swap_info_struct *si, swp_entry_t entry)
 {
+	/*
+	 * Check if the folio still belongs to the target swap entry after
+	 * acquiring the lock. Folio can be freed in the swap cache while
+	 * not locked.
+	 */
+	if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
+				  entry.val != src_folio->swap.val))
+		return -EAGAIN;
+
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1102,6 +1112,15 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	} else {
+		/*
+		 * Check if the swap entry is cached after acquiring the src_pte
+		 * lock. Or we might miss a new loaded swap cache folio.
+		 */
+		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			return -EAGAIN;
+		}
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
@@ -1412,7 +1431,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si, entry);
 	}
 
 out:
-- 
2.49.0


