Return-Path: <stable+bounces-180753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A8B8DA92
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF2A3BCED6
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574081A9F97;
	Sun, 21 Sep 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pmyb/vsx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541534BA52
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457066; cv=none; b=fpy/y6+Dgi2yNCDDAmfBubO2Opn/DhXtk8+jcX/5HpCszGm84v9M0wVVL2MVJ2YqtGjtr1fGNbcVehU0WFuT3sqbNf9+1QI+k1xMveB2e6pw5Hhr+OnNdyELranbPFDUMUMYxVgqgEhBFzIkuy3hqfDVNzWrXEaDcAGvmsQe73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457066; c=relaxed/simple;
	bh=WSyGVZaClERWCe55wISy62gJN83NbBVzAZO6eKG2f5Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BDmKG/fySWzpJCYeHl9vnALhM0HgVpI3aVdEfCYIOEhH8D4bRga6o1lchHZKhhjrl38xEvvdC9TS3ic/7Dp2U6j5bU/i9yaXa4v/ZBTniMhkyh3PLzQzfRpS6Xv9NuSNnzxZqZYCFEWHRRb7vRVGHKxXIYMyh16ZNN0Ygjr3jto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pmyb/vsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275CFC4CEE7;
	Sun, 21 Sep 2025 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457065;
	bh=WSyGVZaClERWCe55wISy62gJN83NbBVzAZO6eKG2f5Q=;
	h=Subject:To:Cc:From:Date:From;
	b=Pmyb/vsxzu01zl03KvvspMlJO7WjyOdhvYNrJFHv0NqZeq3iYg5W2Xsn6gcQhS6B3
	 6u+PG5Q/zXBKN1/3qBrEjcudTKvOpsVWAbBcPiTYu5D/A+y+iSN9W8Bx2UxZmpLmhK
	 9TAQBKiNYuioF0U5S/IWZXA+YJuANMigxBIy1rJE=
Subject: FAILED: patch "[PATCH] mm: folio_may_be_lru_cached() unless folio_test_large()" failed to apply to 6.12-stable tree
To: hughd@google.com,akpm@linux-foundation.org,aneesh.kumar@kernel.org,axelrasmussen@google.com,chrisl@kernel.org,david@redhat.com,hannes@cmpxchg.org,hch@infradead.org,jgg@ziepe.ca,jhubbard@nvidia.com,keirf@google.com,koct9i@gmail.com,lizhe.67@bytedance.com,peterx@redhat.com,riel@surriel.com,shivankg@amd.com,stable@vger.kernel.org,vbabka@suse.cz,weixugc@google.com,will@kernel.org,willy@infradead.org,yangge1116@126.com,yuanchu@google.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:17:42 +0200
Message-ID: <2025092142-easiness-blatancy-23af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092142-easiness-blatancy-23af@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3 Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Mon, 8 Sep 2025 15:23:15 -0700
Subject: [PATCH] mm: folio_may_be_lru_cached() unless folio_test_large()

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

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe6ed2cc3fd..7012a0f758d8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -385,6 +385,16 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
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
index b47066a54f52..0bc4d140fc07 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2307,13 +2307,13 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drained == 0 &&
+		if (drained == 0 && folio_may_be_lru_cached(folio) &&
 				folio_ref_count(folio) !=
 				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain();
 			drained = 1;
 		}
-		if (drained == 1 &&
+		if (drained == 1 && folio_may_be_lru_cached(folio) &&
 				folio_ref_count(folio) !=
 				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
diff --git a/mm/mlock.c b/mm/mlock.c
index a1d93ad33c6d..bb0776f5ef7c 100644
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
index 6ae2d5680574..b74ebe865dd9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -192,7 +192,7 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
-			folio_test_large(folio) || lru_cache_disabled())
+			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)


