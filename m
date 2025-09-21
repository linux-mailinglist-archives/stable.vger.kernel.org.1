Return-Path: <stable+bounces-180818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C13B8DD6B
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A13BF8CE
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F61DE887;
	Sun, 21 Sep 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldRBm0oV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D870814
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469302; cv=none; b=ah6UCHADn0fl2gWkXmU5edBbQrUFUu4d5UPqO9q7XEZK1FvWHi4BKn/z6vsQqIdE3KS8qEF1haVbF43dX9tGy5k8nwiKSUTmuFc2pSvr0xM3fahg9jfLNSalhUjJl7MyPQKBMSGlq7+eSK97xEythjBdkKpPjNUuBWbBPgmuB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469302; c=relaxed/simple;
	bh=pT+FAkru2/OhLq6NXR0/TTENRzQdXlqyvzyu21NKW4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOJN4Zd/xlaEVN1s+156nGVRxyapzUGpe1S1+LKxmTY3fKQISSo5mt7xwRc9tskesmgqGlfvFPcMbmls8p2A1QkH0TqmnggA7YNxlDOfijai+xFXj5Ew7w57Ilv89Rc+mZgaePnwY7IXcrmHNWwexdnjMU107nSt0QHn/Kof69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldRBm0oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863D8C4CEE7;
	Sun, 21 Sep 2025 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758469302;
	bh=pT+FAkru2/OhLq6NXR0/TTENRzQdXlqyvzyu21NKW4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldRBm0oVwb+De/yi9KTBdUAv44O48Fe3cTvRmvURo/XTSgPQ4aISVL0mxTqP5opK1
	 eJowxCLmbJndTMf9gZ84BcU8pxuc855TQvPcXq0vUInMhlY5JWrM7xL3Z7VNp5QNyl
	 /dOXX3gqLcJy+KfWXtAfaDj1y8jyKRb+40lQI2sQDeFnnjG96H21iFHh6ZaSaBXiPw
	 4C4nTwAIrZTuYCWF3VNr/ZGKO2Mo8yFNIL/fHfVCR05uuLDDOudFnKp5xM8LznqoCu
	 ymP8dyEHxzwLjo4QCXOmjqTnxN2WL5NZA17Tnn094w8zLRs7R9DM113m1bG42B1sDN
	 F38vtVAgCmzsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Chris Li <chrisl@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Keir Fraser <keirf@google.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Shivank Garg <shivankg@amd.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wei Xu <weixugc@google.com>,
	Will Deacon <will@kernel.org>,
	yangge <yangge1116@126.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm: folio_may_be_lru_cached() unless folio_test_large()
Date: Sun, 21 Sep 2025 11:41:34 -0400
Message-ID: <20250921154134.2945191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092142-easiness-blatancy-23af@gregkh>
References: <2025092142-easiness-blatancy-23af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugh Dickins <hughd@google.com>

[ Upstream commit 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3 ]

mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as a
large folio is added: so collect_longterm_unpinnable_folios() just wastes
effort when calling lru_add_drain[_all]() on a large folio.

But although there is good reason not to batch up PMD-sized folios, we
might well benefit from batching a small number of low-order mTHPs (though
unclear how that "small number" limitation will be implemented).

So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
insulate those particular checks from future change.  Name preferred to
"folio_is_batchable" because large folios can well be put on a batch: it's
just the per-CPU LRU caches, drained much later, which need care.

Marked for stable, to counter the increase in lru_add_drain_all()s from
"mm/gup: check ref_count instead of lru before migration".

Link: https://lkml.kernel.org/r/57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com
Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Signed-off-by: Hugh Dickins <hughd@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Keir Fraser <keirf@google.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Li Zhe <lizhe.67@bytedance.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shivank Garg <shivankg@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Xu <weixugc@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: yangge <yangge1116@126.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted to drain_allow instead of drained ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/swap.h | 10 ++++++++++
 mm/gup.c             |  3 ++-
 mm/mlock.c           |  6 +++---
 mm/swap.c            |  4 ++--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f3e0ac20c2e8c..63f85b3fee238 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -382,6 +382,16 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
 
+static inline bool folio_may_be_lru_cached(struct folio *folio)
+{
+	/*
+	 * Holding PMD-sized folios in per-CPU LRU cache unbalances accounting.
+	 * Holding small numbers of low-order mTHP folios in per-CPU LRU cache
+	 * will be sensible, but nobody has implemented and tested that yet.
+	 */
+	return !folio_test_large(folio);
+}
+
 extern atomic_t lru_disable_count;
 
 static inline bool lru_cache_disabled(void)
diff --git a/mm/gup.c b/mm/gup.c
index e323843cc5dd8..a919ee0f5b778 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2354,7 +2354,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (!folio_test_lru(folio) && folio_may_be_lru_cached(folio) &&
+		    drain_allow) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index cde076fa7d5e5..8c8d522efdd59 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -255,7 +255,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -278,7 +278,7 @@ void mlock_new_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
@@ -299,7 +299,7 @@ void munlock_folio(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 59f30a981c6f9..e8536e3b48149 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -222,8 +222,8 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
-	    lru_cache_disabled())
+	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
-- 
2.51.0


