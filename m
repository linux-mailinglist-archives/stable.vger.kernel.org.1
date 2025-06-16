Return-Path: <stable+bounces-152678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C4ADA46A
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 00:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B6D169754
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC91EA7DF;
	Sun, 15 Jun 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ERsS373l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942F3595D;
	Sun, 15 Jun 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026439; cv=none; b=NLdgIGWOxg3Zc64AXYF2DPQAgDWIJyMtLg4DFSxpgOPHPs+39weXKUKdE9rlU+sm0qlpzmr48y+lNk+dgRaiaVc/4G6uQpLLNmu4f2H/Xg2OSwvIk29N6+A4b49XFjFjFSYqHb0bbmxw0kLhbD+x3jkiatLA7CvMhGynNkSLJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026439; c=relaxed/simple;
	bh=+Unj2rEpCB63spH6eQ7nF7emBKooEOQxRAucytAfzkM=;
	h=Date:To:From:Subject:Message-Id; b=gSZop7fmvq8tmTJEzNqWaj9BMorJcgtCRwXIb0owOoXVTpo5SVs8pPkEgnZkuOM8UTWy3NKCdVyxf3B2AklJB0urszz45oc0ohuISeZIe6hCFMtHWjcMLqFTktHrw+A7hC/fSXrMlM+hVViRhEUfesoxEcWon0giNDfSEe/uDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ERsS373l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D71DC4CEE3;
	Sun, 15 Jun 2025 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750026437;
	bh=+Unj2rEpCB63spH6eQ7nF7emBKooEOQxRAucytAfzkM=;
	h=Date:To:From:Subject:From;
	b=ERsS373lFnghcGmG2XRpBCjiIqd9uHPVmq5OcpPU0Cppq8bYUgh3Rdc/i0cky6hrA
	 ybN6BofgzOly27MSQ9icMJUd7/m27dzQyFt/ry/cdyrp5M1kLNs7zf/4vGe9I0gGty
	 RxpH+tpTvebQGEu8nqnTYqsQlzrfXN7799nepFG0=
Date: Sun, 15 Jun 2025 15:27:16 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,robertpang@google.com,kent.overstreet@linux.dev,jserv@ccns.ncku.edu.tw,colyli@kernel.org,visitorckw@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap.patch added to mm-hotfixes-unstable branch
Message-Id: <20250615222717.9D71DC4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: Revert "bcache: update min_heap_callbacks to use default builtin swap"
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Revert "bcache: update min_heap_callbacks to use default builtin swap"
Date: Sun, 15 Jun 2025 04:23:51 +0800

Patch series "bcache: Revert min_heap migration due to performance
regression".

This patch series reverts the migration of bcache from its original heap
implementation to the generic min_heap library.  While the original change
aimed to simplify the code and improve maintainability, it introduced a
severe performance regression in real-world scenarios.

As reported by Robert, systems using bcache now suffer from periodic
latency spikes, with P100 (max) latency increasing from 600 ms to 2.4
seconds every 5 minutes.  This degrades bcache's value as a low-latency
caching layer, and leads to frequent timeouts and application stalls in
production environments.

The primary cause of this regression is the behavior of the generic
min_heap implementation's bottom-up sift_down, which performs up to 2 *
log2(n) comparisons when many elements are equal.  The original top-down
variant used by bcache only required O(1) comparisons in such cases.  The
issue was further exacerbated by commit 92a8b224b833 ("lib/min_heap:
introduce non-inline versions of min heap API functions"), which
introduced non-inlined versions of the min_heap API, adding function call
overhead to a performance-critical hot path.


This patch (of 3):

This reverts commit 3d8a9a1c35227c3f1b0bd132c9f0a80dbda07b65.

Although removing the custom swap function simplified the code, this
change is part of a broader migration to the generic min_heap API that
introduced significant performance regressions in bcache.

As reported by Robert, bcache now suffers from latency spikes, with P100
(max) latency increasing from 600 ms to 2.4 seconds every 5 minutes. 
These regressions degrade bcache's effectiveness as a low-latency cache
layer and lead to frequent timeouts and application stalls in production
environments.

This revert is part of a series of changes to restore previous performance
by undoing the min_heap transition.

Link: https://lkml.kernel.org/r/20250614202353.1632957-1-visitorckw@gmail.com
Link: https://lore.kernel.org/lkml/CAJhEC05+0S69z+3+FB2Cd0hD+pCRyWTKLEOsc8BOmH73p1m+KQ@mail.gmail.com
Link: https://lkml.kernel.org/r/20250614202353.1632957-2-visitorckw@gmail.com
Fixes: 866898efbb25 ("bcache: remove heap-related macros and switch to generic min_heap")
Fixes: 92a8b224b833 ("lib/min_heap: introduce non-inline versions of min heap API functions")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reported-by: Robert Pang <robertpang@google.com>
Closes: https://lore.kernel.org/linux-bcache/CAJhEC06F_AtrPgw2-7CvCqZgeStgCtitbD-ryuPpXQA-JG5XXw@mail.gmail.com
Acked-by: Coly Li <colyli@kernel.org>
Cc: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/md/bcache/alloc.c    |   11 +++++++++--
 drivers/md/bcache/bset.c     |   14 +++++++++++---
 drivers/md/bcache/extents.c  |   10 +++++++++-
 drivers/md/bcache/movinggc.c |   10 +++++++++-
 4 files changed, 38 insertions(+), 7 deletions(-)

--- a/drivers/md/bcache/alloc.c~revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap
+++ a/drivers/md/bcache/alloc.c
@@ -189,16 +189,23 @@ static inline bool new_bucket_min_cmp(co
 	return new_bucket_prio(ca, *lhs) < new_bucket_prio(ca, *rhs);
 }
 
+static inline void new_bucket_swap(void *l, void *r, void __always_unused *args)
+{
+	struct bucket **lhs = l, **rhs = r;
+
+	swap(*lhs, *rhs);
+}
+
 static void invalidate_buckets_lru(struct cache *ca)
 {
 	struct bucket *b;
 	const struct min_heap_callbacks bucket_max_cmp_callback = {
 		.less = new_bucket_max_cmp,
-		.swp = NULL,
+		.swp = new_bucket_swap,
 	};
 	const struct min_heap_callbacks bucket_min_cmp_callback = {
 		.less = new_bucket_min_cmp,
-		.swp = NULL,
+		.swp = new_bucket_swap,
 	};
 
 	ca->heap.nr = 0;
--- a/drivers/md/bcache/bset.c~revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap
+++ a/drivers/md/bcache/bset.c
@@ -1093,6 +1093,14 @@ static inline bool new_btree_iter_cmp(co
 	return bkey_cmp(_l->k, _r->k) <= 0;
 }
 
+static inline void new_btree_iter_swap(void *iter1, void *iter2, void __always_unused *args)
+{
+	struct btree_iter_set *_iter1 = iter1;
+	struct btree_iter_set *_iter2 = iter2;
+
+	swap(*_iter1, *_iter2);
+}
+
 static inline bool btree_iter_end(struct btree_iter *iter)
 {
 	return !iter->heap.nr;
@@ -1103,7 +1111,7 @@ void bch_btree_iter_push(struct btree_it
 {
 	const struct min_heap_callbacks callbacks = {
 		.less = new_btree_iter_cmp,
-		.swp = NULL,
+		.swp = new_btree_iter_swap,
 	};
 
 	if (k != end)
@@ -1149,7 +1157,7 @@ static inline struct bkey *__bch_btree_i
 	struct bkey *ret = NULL;
 	const struct min_heap_callbacks callbacks = {
 		.less = cmp,
-		.swp = NULL,
+		.swp = new_btree_iter_swap,
 	};
 
 	if (!btree_iter_end(iter)) {
@@ -1223,7 +1231,7 @@ static void btree_mergesort(struct btree
 		: bch_ptr_invalid;
 	const struct min_heap_callbacks callbacks = {
 		.less = b->ops->sort_cmp,
-		.swp = NULL,
+		.swp = new_btree_iter_swap,
 	};
 
 	/* Heapify the iterator, using our comparison function */
--- a/drivers/md/bcache/extents.c~revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap
+++ a/drivers/md/bcache/extents.c
@@ -266,12 +266,20 @@ static bool new_bch_extent_sort_cmp(cons
 	return !(c ? c > 0 : _l->k < _r->k);
 }
 
+static inline void new_btree_iter_swap(void *iter1, void *iter2, void __always_unused *args)
+{
+	struct btree_iter_set *_iter1 = iter1;
+	struct btree_iter_set *_iter2 = iter2;
+
+	swap(*_iter1, *_iter2);
+}
+
 static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 					  struct bkey *tmp)
 {
 	const struct min_heap_callbacks callbacks = {
 		.less = new_bch_extent_sort_cmp,
-		.swp = NULL,
+		.swp = new_btree_iter_swap,
 	};
 	while (iter->heap.nr > 1) {
 		struct btree_iter_set *top = iter->heap.data, *i = top + 1;
--- a/drivers/md/bcache/movinggc.c~revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap
+++ a/drivers/md/bcache/movinggc.c
@@ -190,6 +190,14 @@ static bool new_bucket_cmp(const void *l
 	return GC_SECTORS_USED(*_l) >= GC_SECTORS_USED(*_r);
 }
 
+static void new_bucket_swap(void *l, void *r, void __always_unused *args)
+{
+	struct bucket **_l = l;
+	struct bucket **_r = r;
+
+	swap(*_l, *_r);
+}
+
 static unsigned int bucket_heap_top(struct cache *ca)
 {
 	struct bucket *b;
@@ -204,7 +212,7 @@ void bch_moving_gc(struct cache_set *c)
 	unsigned long sectors_to_move, reserve_sectors;
 	const struct min_heap_callbacks callbacks = {
 		.less = new_bucket_cmp,
-		.swp = NULL,
+		.swp = new_bucket_swap,
 	};
 
 	if (!c->copy_gc_enabled)
_

Patches currently in -mm which might be from visitorckw@gmail.com are

revert-bcache-update-min_heap_callbacks-to-use-default-builtin-swap.patch
revert-bcache-remove-heap-related-macros-and-switch-to-generic-min_heap.patch
bcache-remove-unnecessary-select-min_heap.patch
lib-math-gcd-use-static-key-to-select-implementation-at-runtime.patch
riscv-optimize-gcd-code-size-when-config_riscv_isa_zbb-is-disabled.patch
riscv-optimize-gcd-performance-on-risc-v-without-zbb-extension.patch


