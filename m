Return-Path: <stable+bounces-151440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B9ACE0FC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BFB3A80B9
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A8291161;
	Wed,  4 Jun 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt4GwMlw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BDD4AEE0;
	Wed,  4 Jun 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049850; cv=none; b=Connj/k1iUQQ+h7MQyeY9O5wnGhnYtnQ/CRNESLMfAMTfAJIWaI95Z2RU/LKAL97wqym/iVmtCsifRfePydwR1oR1rauoXPFGf5eemHed3ImbV1kJgyts0JMTIrjEU7I+AdetE9XJMspzRAd3CIqAMb8epnBVa1i6ZvqqQP0bTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049850; c=relaxed/simple;
	bh=jj9p7Yfm1JiWH4mQLsD9XGLeEa/UqFTAkDlwPHBvhEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGFo0StZSl8lig6ANTFp2aBCHZqQ8OtKNZwkRj8I6dK7kj2+g+PaexMC5fThk+7y9bUUvj/IH3HqYAadn5Dj5naMKDMa58QmrAZ1OaGeSdA7U3ePF0rwCe7vhs3iFrMq/Sgb/gISvlFtmUd/NdY3xEVWyzfcBTUiw2af0gcp6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt4GwMlw; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso62688536d6.3;
        Wed, 04 Jun 2025 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749049847; x=1749654647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlNmd2XKllw/97ryueauENrkZuEH44uo2nMCnWBruCU=;
        b=jt4GwMlw3ssXeqc3x3DzDmyzSrByGDVFTifKDJ6NqOJ4+APx0Jo5YbWdqhqilD+1z8
         WXSfRJ8emqWBZ30qJVX6Y6NNWC96djsRYulrILM2SE8Do/VgzzE2gldOn533NDmlEZnD
         edeiWqwsGix+z2a0zDAAH2yh5T9vn7FWyxzQVXAVljIVNRxFcKhgor33/lV3gZ4qbATb
         uj/Vy1fIv3J4XXzLLP9U3AiHTsXgzF9MZq4XpNBUjX0IQOXOeay6xqGu46ivvNQdoEUi
         rmP4I70dgilyXg0kLRwc6sQL+mnpwPDCb/L8TVBfA51MCuaOdoieBePaJlCC79z4ED2E
         v4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749049847; x=1749654647;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlNmd2XKllw/97ryueauENrkZuEH44uo2nMCnWBruCU=;
        b=PCNq/4YkNmSHZ6oUTUvyZFca/UEDRD6REG+pBnuncPHBkY5YlSP++f/Gp4Q/BIhsYn
         J1Gm8mPIFqZ4t0AOWOR74XOoTHAMgsOMlaq2GMwVIIqkRjuKTp+ky2KsVLYChqkuU6Vq
         hKcGWkb8JQf/h1afIB37JxyLMglWsmbZZERRs63dhbpGacQRP+gobQjCEzmS+9xIOtqW
         Sn9qOjX8786auFP3DMQuQgm2SBr8sKV83vh1w0/xLZmURW6hpx9w4pdoiV2+l9Pkb0GU
         gEGAmYqQIrAM03iShycXeuEw6R4oD+l9l0Sesr8iy6Qq9NYKCYEqwF7GBHrPAxtgFih5
         9DKA==
X-Forwarded-Encrypted: i=1; AJvYcCXK5OKf7Z7RWFI8VZbPo7wuC0Y6RAysI3TmkzKeHKeecnLkMOlSEMV5OiwvnLKZCUVFYm/njlip@vger.kernel.org, AJvYcCXqObhc5rkI53hw/ymHAOTaKWt0whbfvR3u7OHcb7YJXe0Ww/dra9xbHq6MWaq5JfDVTZLFA/8jCI1vidE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkiQRibwiJVdBLkpN4sQc4teY6+p30Dr1qXK01s+gUPVbPBGR
	jWrYSnGWNaOqKNTEZr3MZ+pekr41rWQQLHJ3fY04nGdnIS1UK6IcL7QP
X-Gm-Gg: ASbGncv2xh2HIUrpVq9p6bpv1jRmpmV+raEV9e5SX7yA+pCzCJDv6x1fKnHZzNTFcFM
	BoBCNQUuS5DLOMRwdkyO5r6rNQMpMpaynWYcDktXVspRp13dlrUT1OEvgm0Fms5krPldOU0uGtE
	nLPeXR7IRghaX6jXtcHVXgKRKaj005eFJ0KAQkKpyLxb5M5I9tuqCat4XPZ0dtVfvT41m3EHhhl
	SARDXtSW8cja9JuURL1pnV03Smg96CE2R7iylot+SsFuQkFym79zMdNGNMj8yhabOFNk7s/+IEb
	NjRQcjySIoWBp0K/wxDIvl+GuiBMYMpzLZsFlrEtRrSaPT0xZ5omo2PKZL5i0ZFa5AMlIPD9
X-Google-Smtp-Source: AGHT+IEZ5Uf1bsWKgXtxFZVbT2QGv/K3mgX1pC8TlTojXb3txD4/AOyO0HFiYgMl9AXKL85bpH4v1w==
X-Received: by 2002:a05:6214:2a4e:b0:6e8:f166:b19c with SMTP id 6a1803df08f44-6faf7a6d772mr42701686d6.41.1749049846868;
        Wed, 04 Jun 2025 08:10:46 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6facab00339sm97468236d6.125.2025.06.04.08.10.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Jun 2025 08:10:46 -0700 (PDT)
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
Subject: [PATCH v4] mm: userfaultfd: fix race of userfaultfd_move and swap cache
Date: Wed,  4 Jun 2025 23:10:38 +0800
Message-ID: <20250604151038.21968-1-ryncsn@gmail.com>
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

On seeing a swap entry PTE, userfaultfd_move does a lockless swap
cache lookup, and tries to move the found folio to the faulting vma.
Currently, it relies on checking the PTE value to ensure that the moved
folio still belongs to the src swap entry and that no new folio has
been added to the swap cache, which turns out to be unreliable.

While working and reviewing the swap table series with Barry, following
existing races are observed and reproduced [1]:

In the example below, move_pages_pte is moving src_pte to dst_pte,
where src_pte is a swap entry PTE holding swap entry S1, and S1
is not in the swap cache:

CPU1                               CPU2
userfaultfd_move
  move_pages_pte()
    entry = pte_to_swp_entry(orig_src_pte);
    // Here it got entry = S1
    ... < interrupted> ...
                                   <swapin src_pte, alloc and use folio A>
                                   // folio A is a new allocated folio
                                   // and get installed into src_pte
                                   <frees swap entry S1>
                                   // src_pte now points to folio A, S1
                                   // has swap count == 0, it can be freed
                                   // by folio_swap_swap or swap
                                   // allocator's reclaim.
                                   <try to swap out another folio B>
                                   // folio B is a folio in another VMA.
                                   <put folio B to swap cache using S1 >
                                   // S1 is freed, folio B can use it
                                   // for swap out with no problem.
                                   ...
    folio = filemap_get_folio(S1)
    // Got folio B here !!!
    ... < interrupted again> ...
                                   <swapin folio B and free S1>
                                   // Now S1 is free to be used again.
                                   <swapout src_pte & folio A using S1>
                                   // Now src_pte is a swap entry PTE
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
deliberately constructed reproducer and increased time window, it
can be reproduced easily.

This can be fixed by checking if the folio returned by filemap is the
valid swap cache folio after acquiring the folio lock.

Another similar race is possible: filemap_get_folio may return NULL, but
folio (A) could be swapped in and then swapped out again using the same
swap entry after the lookup. In such a case, folio (A) may remain in the
swap cache, so it must be moved too:

CPU1                               CPU2
userfaultfd_move
  move_pages_pte()
    entry = pte_to_swp_entry(orig_src_pte);
    // Here it got entry = S1, and S1 is not in swap cache
    folio = filemap_get_folio(S1)
    // Got NULL
    ... < interrupted again> ...
                                   <swapin folio A and free S1>
                                   <swapout folio A re-using S1>
    move_swap_pte
      double_pt_lock
      is_pte_pages_stable
      // Check passed because src_pte == S1
      folio_move_anon_rmap(...)
      // folio A is ignored !!!

Fix this by checking the swap cache again after acquiring the src_pte
lock. And to avoid the filemap overhead, we check swap_map directly [2].

The SWP_SYNCHRONOUS_IO path does make the problem more complex, but so
far we don't need to worry about that, since folios can only be exposed
to the swap cache in the swap out path, and this is covered in this
patch by checking the swap cache again after acquiring the src_pte lock.

Testing with a simple C program that allocates and moves several GB of
memory did not show any observable performance change.

Cc: <stable@vger.kernel.org>
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com/ [2]
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>

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

V3: https://lore.kernel.org/all/20250602181419.20478-1-ryncsn@gmail.com/
Changes:
- Add more comments and more context in commit message.

 mm/userfaultfd.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..8253978ee0fb 100644
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
@@ -1102,6 +1112,25 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	} else {
+		/*
+		 * Check if the swap entry is cached after acquiring the src_pte
+		 * lock. Otherwise, we might miss a newly loaded swap cache folio.
+		 *
+		 * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
+		 * We are trying to catch newly added swap cache, the only possible case is
+		 * when a folio is swapped in and out again staying in swap cache, using the
+		 * same entry before the PTE check above. The PTL is acquired and released
+		 * twice, each time after updating the swap_map's flag. So holding
+		 * the PTL here ensures we see the updated value. False positive is possible,
+		 * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag without touching the
+		 * cache, or during the tiny synchronization window between swap cache and
+		 * swap_map, but it will be gone very quickly, worst result is retry jitters.
+		 */
+		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			return -EAGAIN;
+		}
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
@@ -1412,7 +1441,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si, entry);
 	}
 
 out:
-- 
2.49.0


