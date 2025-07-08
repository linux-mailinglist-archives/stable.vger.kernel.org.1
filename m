Return-Path: <stable+bounces-160490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E444AFCCD1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D92427E35
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9A1D5CD1;
	Tue,  8 Jul 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqEYtRia"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F92BE7B1
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983089; cv=none; b=NukkAGL3fPGfIj23cONVr3q+4RsZql5NmBIa+Ol+0npquuZTqXe6JJ233pu9fIr5C+U6vcnZNrCpZmsnnWxbLRxHnDrkzme6df8kt3A8ecrKqRDrlLRIi+IhIZz1bdEDcGqqQP34bekhGyhzSRNIQVnbCMb4t9rX1fqqKsZ19sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983089; c=relaxed/simple;
	bh=Gss1TmbWkIljllU+l1oVd53qZ0Uh5sImbeQ3A9jjNeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sITyleOFUpGtdKS9y20Zq8ZKc80s1Y0oyxd0Dfs1IIxJZAvxBph0LwUEwHaiOzZ/x+/SVKQYFNjVnn28NdJcp4IMW37AYaYYU2ilclnR1ibFfQUp/loiR7kS8i9rVpqyaHhp39V+ifAQou+I/zUnnPyxbMLbJOK1zuXsPKGleto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqEYtRia; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31ca4b6a8eso2744928a12.1
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751983087; x=1752587887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7q7ovtbvy1TcH8xZIMnEcJdKU8THqhL9yvx53zKs80=;
        b=oqEYtRiapQDL0Rl/P89eAfHN+gTvXhHY6SDwLM95un8Zf9sIUqgPR52kIVnMPuqrbF
         vbPRXewCn9hnTK9WtBIEnPrJkwBAH9I62PfPj87mHdwNfZeFVgaKqyNfSryHYfBPtEix
         OFt+/sV4mQpG+7n/2vFcj845rhuLppi7690RvYIhxzF2Ylzp/7RXMxlO1rQWlVpUX+Oc
         Qf9e6OscYZdUCkyoLczMdMG0pSlrx4mvQGZjCh8eBhh0903NjvBM9HsOMEOkNnoLd1gC
         H1aK9LOMesCtWkE55W9q1ihoWDjNb1AWk8eZJLIc4+GBDu4DZgqS4et3Y0qFJtjppq0Y
         hR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983087; x=1752587887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7q7ovtbvy1TcH8xZIMnEcJdKU8THqhL9yvx53zKs80=;
        b=OPzZhAwjQPlLTBKIyI3Cv+m7iE5r+rhGPB2gDXDruNjLtztdKrIMLlUerjcGLAhIil
         CQKVRZKtkYd4h7QTP2RtGIfflRaGRGXZwB3ndgimidKVuWFcD2WZX3NSFMupFnoXHbtP
         d9B67EbAb534MhRSVWRM1NiJY6wXE8yT5Ns+rdnVq8eL+fUikBLdcJm4DXLfT8XKWqUe
         RsBmWIjvCaoSV3yQG9UrvGJC2zb5BZa6zY0gM9rC+LtmxIopLpUp3CGxvuS/WxjNrF0L
         QaeCpzATkHETnKBhvG58ERM/79W9TxvI+lW5Bn1J1Uf1/lZMTrOdeaO6sJEeGzs7iC5C
         nGvQ==
X-Gm-Message-State: AOJu0YykXLHXR3/GJyYCgZpphkCpia1ne8RWuAroOHpUgjm1lpejtXof
	xrM41Caa1pspgqocwoZwlr3qC7hNhQ4rLW1TqoZ76EjXyKSalCT5269GdXjAeH9+TH0V5F14Pgh
	QMDsQrr7biNmHK0X9eUUrCMomdBsd6EsP36wMyY2L/FL5gTvXc5bS45RPZjEz7IyC3Wz3XEDz7n
	zRqXxepG8niAnoPK/TD/3ZTDJXeSd6ZWb26oNw9ufYeIip1wv4wLkWQqKsOjxvL0M=
X-Google-Smtp-Source: AGHT+IFq4nnbX5u+VsZ2G/v4toKgxO491pd5nt1Uu9TY15O29EAaWwZzYWX2p6A98lo2xunoBYlaUkIhDvHm9M+Wfw==
X-Received: from plnd13.prod.google.com ([2002:a17:903:198d:b0:234:c5eb:fe1d])
 (user=lokeshgidra job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b0b:b0:234:8c64:7878 with SMTP id d9443c01a7336-23dd0a819c3mr41000755ad.11.1751983086608;
 Tue, 08 Jul 2025 06:58:06 -0700 (PDT)
Date: Tue,  8 Jul 2025 06:58:02 -0700
In-Reply-To: <2025063052-strive-fabulous-239b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025063052-strive-fabulous-239b@gregkh>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708135802.2870878-1-lokeshgidra@google.com>
Subject: [PATCH 6.12.y] mm: userfaultfd: fix race of userfaultfd_move and swap cache
From: Lokesh Gidra <lokeshgidra@google.com>
To: stable@vger.kernel.org
Cc: Kairui Song <kasong@tencent.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

From: Kairui Song <kasong@tencent.com>

This commit fixes two kinds of races, they may have different results:

Barry reported a BUG_ON in commit c50f8e6053b0, we may see the same
BUG_ON if the filemap lookup returned NULL and folio is added to swap
cache after that.

If another kind of race is triggered (folio changed after lookup) we
may see RSS counter is corrupted:

[  406.893936] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
type:MM_ANONPAGES val:-1
[  406.894071] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
type:MM_SHMEMPAGES val:1

Because the folio is being accounted to the wrong VMA.

I'm not sure if there will be any data corruption though, seems no.
The issues above are critical already.

On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
lookup, and tries to move the found folio to the faulting vma.  Currently,
it relies on checking the PTE value to ensure that the moved folio still
belongs to the src swap entry and that no new folio has been added to the
swap cache, which turns out to be unreliable.

While working and reviewing the swap table series with Barry, following
existing races are observed and reproduced [1]:

In the example below, move_pages_pte is moving src_pte to dst_pte, where
src_pte is a swap entry PTE holding swap entry S1, and S1 is not in the
swap cache:

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

The race window is very short and requires multiple collisions of multiple
rare events, so it's very unlikely to happen, but with a deliberately
constructed reproducer and increased time window, it can be reproduced
easily.

This can be fixed by checking if the folio returned by filemap is the
valid swap cache folio after acquiring the folio lock.

Another similar race is possible: filemap_get_folio may return NULL, but
folio (A) could be swapped in and then swapped out again using the same
swap entry after the lookup.  In such a case, folio (A) may remain in the
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
lock.  And to avoid the filemap overhead, we check swap_map directly [2].

The SWP_SYNCHRONOUS_IO path does make the problem more complex, but so far
we don't need to worry about that, since folios can only be exposed to the
swap cache in the swap out path, and this is covered in this patch by
checking the swap cache again after acquiring the src_pte lock.

Testing with a simple C program that allocates and moves several GB of
memory did not show any observable performance change.

Link: https://lkml.kernel.org/r/20250604151038.21968-1-ryncsn@gmail.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Kairui Song <kasong@tencent.com>
Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com/ [2]
Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Chris Li <chrisl@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0ea148a799198518d8ebab63ddd0bb6114a103bc)
[lokeshgidra: resolved merged conflict caused by the difference in
move_swap_pte() arguments]
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/userfaultfd.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e06e3d270961..2646b75163d5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1078,8 +1078,18 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 pte_t *dst_pte, pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
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
 
 	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
@@ -1096,6 +1106,25 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
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
@@ -1391,7 +1420,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte,
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si, entry);
 	}
 
 out:
-- 
2.50.0.727.gbf7dc18ff4-goog


