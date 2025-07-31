Return-Path: <stable+bounces-165665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8CB171B4
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 15:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D90E1AA603A
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5A239E7C;
	Thu, 31 Jul 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6lk567Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59151224B10
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967004; cv=none; b=mE2tridbprAUfy9u+03Cj+ePuxCO2nqwIS4OgkhvLaEewHrRdpTnHDBQ5wyc/ETstGIRPrTlRpEJWdH5fQhbgXQyJ6udbZwG45ewZg51MFuBpYZ4hzfVzctj539hlhace/mhy3EmcV1QG9PRUh9NQVA1qR27cf0aiG1IU4cO3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967004; c=relaxed/simple;
	bh=O3OH3jdv+Kf0q92yYlclkd6SYvwHU1a3vE7fWdDGVAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jb76nWhebxa9c5hQ7rajeQQUa9kHo6phTqFDSOMPRAW7hcp7jCJ+MEzgrKHWXX3B5C9KpNy3O71My/Ka7S7bfC1pewcMBDDOBgEH1+M8JFlr008h88tcuEx7n9SNxVlGKnWguYR8y4alSTSbyU3S5z0vEigTxrbolp/fE8pj6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6lk567Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bd202ef81so516697b3a.3
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753967001; x=1754571801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KB1VTL8qmo716oZMudpEjuIExuRPHy1rI5wb3JLi640=;
        b=N6lk567Qo6UQ/EriCbHS6ZoaI6OXGAqWA0QsUe6mqtwew/z7mljLP3RPxkiQoHzNik
         lCADAS0CbP6f5cgBrWpU1WcaI8tuCGPgrYrCr5zsph/LxckTRBopZB/i7TFCGf6EsHJB
         zrZxk/SyzsHO027B1lgqknjKZiKH49vBtiUVLSFj2NSAcv6I2mvQWB3/CbeFyTk4PJSQ
         6kx0A8jbLx/3U3wYeLQSW50VAiWez//Kt9x1QGdHsBpwhwLFSIF+9MBuVe+d9lcX42hf
         NAg8Fb5hOPQDIv5u/ltHQVaIhg3iGQXFXIffIDQE5tQ+m0qKMKMV08h8CG/WoT6nr7ss
         Xe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753967001; x=1754571801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB1VTL8qmo716oZMudpEjuIExuRPHy1rI5wb3JLi640=;
        b=ENxskmICHWQHz4fslDYcFEcdAfSZlMlb7q9R4sjyqtquhdLm4Wm4u5bqmkR0EOJwBz
         8mzxYWxHVXDZpw+k6/jTzjaWAYfT7gnuaTfBch1/iJErBJ+V4Jgncqlx4rEUFXCVjANN
         s/Wp2o05COQtu7rW9h82HxTDIspJtKaQIM5BFvRai6THcJnnDmgjaa/GjeKIdUXPPDdL
         WeQPJwHs0hE8sv42hbzgsRqarhvzKk9VSE9Cm5Ga/lmCFMVTyfDs+HzXZ3ff7JE0bBgy
         K8H+B+ps4TNzeHcsMeVUKCUfDoySklJDCqaSZFm1x/Gkeavbtfo8isxXlDgcLFt4CMWL
         TBaw==
X-Gm-Message-State: AOJu0Yxv7F6MoGXZujqzwnjE8gN8UPS8qMhqd4tEHUf7OlQuMwIKgVrF
	DhKDmF8D7hLwSLLtYj4vJ4ic+z2ZCS4fxiwLUjuB1lB1cbBDUZd+QC5auA5Km/zo
X-Gm-Gg: ASbGncsijEr2pGWLJvEQYQr0/r7e9DulviTabv/w6oGfK2DdLRDV1MjwY27R67suqfL
	le27uV5gtoM7od8ZiO47dr9l1L2gRt6EDhF6Yz/UsSvU3KTTqmWRjjB6oe+A+ieha0ihLlvsnFW
	+JxAkiF+1/RNLHyP/0Qx0EY4IJdr9e45U/fB8+eCqZvrMmXJsxWupN55RZ5a/5fmLiPnvJBIbPM
	LsL9Et3i2WTpmUXhpiOHgdyDHsWKuzvjUrFqNBkxn6sfThSbupukBIpgEPFlgSVkfutHWaeNM1I
	GdLjcBjXvivtq5Ix0phHGKScwv7bY487HtfARAMdkGrSxdgd9LJOYvRkBFXIPuB2kQDtw8zJzpQ
	PMy/RQnDsc/jmakTGu+1RDMf9pQ58ILvRO56ILdJmNUvV/LFfR/eZfy43QKSk9nU=
X-Google-Smtp-Source: AGHT+IFISyusGUW0Aa/8OPlp0aTEb/o2l2Yc63XNR0sMIBj4b6jVVv4iVLyCXT4vuM1P9YE/beA6fw==
X-Received: by 2002:a05:6a00:b88:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-76ab0a37d6amr9272181b3a.1.1753967000991;
        Thu, 31 Jul 2025 06:03:20 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8911asm1619281b3a.36.2025.07.31.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:03:20 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Robert Pang <robertpang@google.com>,
	Coly Li <colyli@kernel.org>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y v2] Revert "bcache: remove heap-related macros and switch to generic min_heap"
Date: Thu, 31 Jul 2025 21:03:15 +0800
Message-Id: <20250731130315.33984-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 48fd7ebe00c1cdc782b42576548b25185902f64c ]

This reverts commit 866898efbb25bb44fd42848318e46db9e785973a.

The generic bottom-up min_heap implementation causes performance
regression in invalidate_buckets_lru(), a hot path in bcache.  Before the
cache is fully populated, new_bucket_prio() often returns zero, leading to
many equal comparisons.  In such cases, bottom-up sift_down performs up to
2 * log2(n) comparisons, while the original top-down approach completes
with just O() comparisons, resulting in a measurable performance gap.

The performance degradation is further worsened by the non-inlined
min_heap API functions introduced in commit 92a8b224b833 ("lib/min_heap:
introduce non-inline versions of min heap API functions"), adding function
call overhead to this critical path.

As reported by Robert, bcache now suffers from latency spikes, with P100
(max) latency increasing from 600 ms to 2.4 seconds every 5 minutes.
These regressions degrade bcache's effectiveness as a low-latency cache
layer and lead to frequent timeouts and application stalls in production
environments.

This revert aims to restore bcache's original low-latency behavior.

Link: https://lore.kernel.org/lkml/CAJhEC05+0S69z+3+FB2Cd0hD+pCRyWTKLEOsc8BOmH73p1m+KQ@mail.gmail.com
Link: https://lkml.kernel.org/r/20250614202353.1632957-3-visitorckw@gmail.com
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
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add missing [ Upstream commit <sha1> ] line.

 drivers/md/bcache/alloc.c     |  64 +++++-------------
 drivers/md/bcache/bcache.h    |   2 +-
 drivers/md/bcache/bset.c      | 124 ++++++++++++----------------------
 drivers/md/bcache/bset.h      |  40 ++++++-----
 drivers/md/bcache/btree.c     |  69 ++++++++-----------
 drivers/md/bcache/extents.c   |  53 ++++++---------
 drivers/md/bcache/movinggc.c  |  41 +++--------
 drivers/md/bcache/super.c     |   3 +-
 drivers/md/bcache/sysfs.c     |   4 +-
 drivers/md/bcache/util.h      |  67 +++++++++++++++++-
 drivers/md/bcache/writeback.c |  13 ++--
 11 files changed, 217 insertions(+), 263 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index da50f6661bae..48ce750bf70a 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -164,68 +164,40 @@ static void bch_invalidate_one_bucket(struct cache *ca, struct bucket *b)
  * prio is worth 1/8th of what INITIAL_PRIO is worth.
  */
 
-static inline unsigned int new_bucket_prio(struct cache *ca, struct bucket *b)
-{
-	unsigned int min_prio = (INITIAL_PRIO - ca->set->min_prio) / 8;
-
-	return (b->prio - ca->set->min_prio + min_prio) * GC_SECTORS_USED(b);
-}
-
-static inline bool new_bucket_max_cmp(const void *l, const void *r, void *args)
-{
-	struct bucket **lhs = (struct bucket **)l;
-	struct bucket **rhs = (struct bucket **)r;
-	struct cache *ca = args;
-
-	return new_bucket_prio(ca, *lhs) > new_bucket_prio(ca, *rhs);
-}
-
-static inline bool new_bucket_min_cmp(const void *l, const void *r, void *args)
-{
-	struct bucket **lhs = (struct bucket **)l;
-	struct bucket **rhs = (struct bucket **)r;
-	struct cache *ca = args;
-
-	return new_bucket_prio(ca, *lhs) < new_bucket_prio(ca, *rhs);
-}
-
-static inline void new_bucket_swap(void *l, void *r, void __always_unused *args)
-{
-	struct bucket **lhs = l, **rhs = r;
+#define bucket_prio(b)							\
+({									\
+	unsigned int min_prio = (INITIAL_PRIO - ca->set->min_prio) / 8;	\
+									\
+	(b->prio - ca->set->min_prio + min_prio) * GC_SECTORS_USED(b);	\
+})
 
-	swap(*lhs, *rhs);
-}
+#define bucket_max_cmp(l, r)	(bucket_prio(l) < bucket_prio(r))
+#define bucket_min_cmp(l, r)	(bucket_prio(l) > bucket_prio(r))
 
 static void invalidate_buckets_lru(struct cache *ca)
 {
 	struct bucket *b;
-	const struct min_heap_callbacks bucket_max_cmp_callback = {
-		.less = new_bucket_max_cmp,
-		.swp = new_bucket_swap,
-	};
-	const struct min_heap_callbacks bucket_min_cmp_callback = {
-		.less = new_bucket_min_cmp,
-		.swp = new_bucket_swap,
-	};
+	ssize_t i;
 
-	ca->heap.nr = 0;
+	ca->heap.used = 0;
 
 	for_each_bucket(b, ca) {
 		if (!bch_can_invalidate_bucket(ca, b))
 			continue;
 
-		if (!min_heap_full(&ca->heap))
-			min_heap_push(&ca->heap, &b, &bucket_max_cmp_callback, ca);
-		else if (!new_bucket_max_cmp(&b, min_heap_peek(&ca->heap), ca)) {
+		if (!heap_full(&ca->heap))
+			heap_add(&ca->heap, b, bucket_max_cmp);
+		else if (bucket_max_cmp(b, heap_peek(&ca->heap))) {
 			ca->heap.data[0] = b;
-			min_heap_sift_down(&ca->heap, 0, &bucket_max_cmp_callback, ca);
+			heap_sift(&ca->heap, 0, bucket_max_cmp);
 		}
 	}
 
-	min_heapify_all(&ca->heap, &bucket_min_cmp_callback, ca);
+	for (i = ca->heap.used / 2 - 1; i >= 0; --i)
+		heap_sift(&ca->heap, i, bucket_min_cmp);
 
 	while (!fifo_full(&ca->free_inc)) {
-		if (!ca->heap.nr) {
+		if (!heap_pop(&ca->heap, b, bucket_min_cmp)) {
 			/*
 			 * We don't want to be calling invalidate_buckets()
 			 * multiple times when it can't do anything
@@ -234,8 +206,6 @@ static void invalidate_buckets_lru(struct cache *ca)
 			wake_up_gc(ca->set);
 			return;
 		}
-		b = min_heap_peek(&ca->heap)[0];
-		min_heap_pop(&ca->heap, &bucket_min_cmp_callback, ca);
 
 		bch_invalidate_one_bucket(ca, b);
 	}
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 785b0d9008fa..1d33e40d26ea 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -458,7 +458,7 @@ struct cache {
 	/* Allocation stuff: */
 	struct bucket		*buckets;
 
-	DEFINE_MIN_HEAP(struct bucket *, cache_heap) heap;
+	DECLARE_HEAP(struct bucket *, heap);
 
 	/*
 	 * If nonzero, we know we aren't going to find any buckets to invalidate
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index bd97d8626887..463eb13bd0b2 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -54,11 +54,9 @@ void bch_dump_bucket(struct btree_keys *b)
 int __bch_count_data(struct btree_keys *b)
 {
 	unsigned int ret = 0;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	if (b->ops->is_extents)
 		for_each_key(b, k, &iter)
 			ret += KEY_SIZE(k);
@@ -69,11 +67,9 @@ void __bch_check_keys(struct btree_keys *b, const char *fmt, ...)
 {
 	va_list args;
 	struct bkey *k, *p = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	const char *err;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	for_each_key(b, k, &iter) {
 		if (b->ops->is_extents) {
 			err = "Keys out of order";
@@ -114,9 +110,9 @@ void __bch_check_keys(struct btree_keys *b, const char *fmt, ...)
 
 static void bch_btree_iter_next_check(struct btree_iter *iter)
 {
-	struct bkey *k = iter->heap.data->k, *next = bkey_next(k);
+	struct bkey *k = iter->data->k, *next = bkey_next(k);
 
-	if (next < iter->heap.data->end &&
+	if (next < iter->data->end &&
 	    bkey_cmp(k, iter->b->ops->is_extents ?
 		     &START_KEY(next) : next) > 0) {
 		bch_dump_bucket(iter->b);
@@ -883,14 +879,12 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 	unsigned int status = BTREE_INSERT_STATUS_NO_INSERT;
 	struct bset *i = bset_tree_last(b)->data;
 	struct bkey *m, *prev = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey preceding_key_on_stack = ZERO_KEY;
 	struct bkey *preceding_key_p = &preceding_key_on_stack;
 
 	BUG_ON(b->ops->is_extents && !KEY_SIZE(k));
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	/*
 	 * If k has preceding key, preceding_key_p will be set to address
 	 *  of k's preceding key; otherwise preceding_key_p will be set
@@ -901,9 +895,9 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 	else
 		preceding_key(k, &preceding_key_p);
 
-	m = bch_btree_iter_init(b, &iter, preceding_key_p);
+	m = bch_btree_iter_stack_init(b, &iter, preceding_key_p);
 
-	if (b->ops->insert_fixup(b, k, &iter, replace_key))
+	if (b->ops->insert_fixup(b, k, &iter.iter, replace_key))
 		return status;
 
 	status = BTREE_INSERT_STATUS_INSERT;
@@ -1083,102 +1077,79 @@ struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
 
 /* Btree iterator */
 
-typedef bool (new_btree_iter_cmp_fn)(const void *, const void *, void *);
-
-static inline bool new_btree_iter_cmp(const void *l, const void *r, void __always_unused *args)
-{
-	const struct btree_iter_set *_l = l;
-	const struct btree_iter_set *_r = r;
-
-	return bkey_cmp(_l->k, _r->k) <= 0;
-}
+typedef bool (btree_iter_cmp_fn)(struct btree_iter_set,
+				 struct btree_iter_set);
 
-static inline void new_btree_iter_swap(void *iter1, void *iter2, void __always_unused *args)
+static inline bool btree_iter_cmp(struct btree_iter_set l,
+				  struct btree_iter_set r)
 {
-	struct btree_iter_set *_iter1 = iter1;
-	struct btree_iter_set *_iter2 = iter2;
-
-	swap(*_iter1, *_iter2);
+	return bkey_cmp(l.k, r.k) > 0;
 }
 
 static inline bool btree_iter_end(struct btree_iter *iter)
 {
-	return !iter->heap.nr;
+	return !iter->used;
 }
 
 void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
 			 struct bkey *end)
 {
-	const struct min_heap_callbacks callbacks = {
-		.less = new_btree_iter_cmp,
-		.swp = new_btree_iter_swap,
-	};
-
 	if (k != end)
-		BUG_ON(!min_heap_push(&iter->heap,
-				 &((struct btree_iter_set) { k, end }),
-				 &callbacks,
-				 NULL));
+		BUG_ON(!heap_add(iter,
+				 ((struct btree_iter_set) { k, end }),
+				 btree_iter_cmp));
 }
 
-static struct bkey *__bch_btree_iter_init(struct btree_keys *b,
-					  struct btree_iter *iter,
-					  struct bkey *search,
-					  struct bset_tree *start)
+static struct bkey *__bch_btree_iter_stack_init(struct btree_keys *b,
+						struct btree_iter_stack *iter,
+						struct bkey *search,
+						struct bset_tree *start)
 {
 	struct bkey *ret = NULL;
 
-	iter->heap.size = ARRAY_SIZE(iter->heap.preallocated);
-	iter->heap.nr = 0;
+	iter->iter.size = ARRAY_SIZE(iter->stack_data);
+	iter->iter.used = 0;
 
 #ifdef CONFIG_BCACHE_DEBUG
-	iter->b = b;
+	iter->iter.b = b;
 #endif
 
 	for (; start <= bset_tree_last(b); start++) {
 		ret = bch_bset_search(b, start, search);
-		bch_btree_iter_push(iter, ret, bset_bkey_last(start->data));
+		bch_btree_iter_push(&iter->iter, ret, bset_bkey_last(start->data));
 	}
 
 	return ret;
 }
 
-struct bkey *bch_btree_iter_init(struct btree_keys *b,
-				 struct btree_iter *iter,
+struct bkey *bch_btree_iter_stack_init(struct btree_keys *b,
+				 struct btree_iter_stack *iter,
 				 struct bkey *search)
 {
-	return __bch_btree_iter_init(b, iter, search, b->set);
+	return __bch_btree_iter_stack_init(b, iter, search, b->set);
 }
 
 static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
-						 new_btree_iter_cmp_fn *cmp)
+						 btree_iter_cmp_fn *cmp)
 {
 	struct btree_iter_set b __maybe_unused;
 	struct bkey *ret = NULL;
-	const struct min_heap_callbacks callbacks = {
-		.less = cmp,
-		.swp = new_btree_iter_swap,
-	};
 
 	if (!btree_iter_end(iter)) {
 		bch_btree_iter_next_check(iter);
 
-		ret = iter->heap.data->k;
-		iter->heap.data->k = bkey_next(iter->heap.data->k);
+		ret = iter->data->k;
+		iter->data->k = bkey_next(iter->data->k);
 
-		if (iter->heap.data->k > iter->heap.data->end) {
+		if (iter->data->k > iter->data->end) {
 			WARN_ONCE(1, "bset was corrupt!\n");
-			iter->heap.data->k = iter->heap.data->end;
+			iter->data->k = iter->data->end;
 		}
 
-		if (iter->heap.data->k == iter->heap.data->end) {
-			if (iter->heap.nr) {
-				b = min_heap_peek(&iter->heap)[0];
-				min_heap_pop(&iter->heap, &callbacks, NULL);
-			}
-		}
+		if (iter->data->k == iter->data->end)
+			heap_pop(iter, b, cmp);
 		else
-			min_heap_sift_down(&iter->heap, 0, &callbacks, NULL);
+			heap_sift(iter, 0, cmp);
 	}
 
 	return ret;
@@ -1186,7 +1157,7 @@ static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
 
 struct bkey *bch_btree_iter_next(struct btree_iter *iter)
 {
-	return __bch_btree_iter_next(iter, new_btree_iter_cmp);
+	return __bch_btree_iter_next(iter, btree_iter_cmp);
 
 }
 
@@ -1224,18 +1195,16 @@ static void btree_mergesort(struct btree_keys *b, struct bset *out,
 			    struct btree_iter *iter,
 			    bool fixup, bool remove_stale)
 {
+	int i;
 	struct bkey *k, *last = NULL;
 	BKEY_PADDED(k) tmp;
 	bool (*bad)(struct btree_keys *, const struct bkey *) = remove_stale
 		? bch_ptr_bad
 		: bch_ptr_invalid;
-	const struct min_heap_callbacks callbacks = {
-		.less = b->ops->sort_cmp,
-		.swp = new_btree_iter_swap,
-	};
 
 	/* Heapify the iterator, using our comparison function */
-	min_heapify_all(&iter->heap, &callbacks, NULL);
+	for (i = iter->used / 2 - 1; i >= 0; --i)
+		heap_sift(iter, i, b->ops->sort_cmp);
 
 	while (!btree_iter_end(iter)) {
 		if (b->ops->sort_fixup && fixup)
@@ -1324,11 +1293,10 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 			    struct bset_sort_state *state)
 {
 	size_t order = b->page_order, keys = 0;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	int oldsize = bch_count_data(b);
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	__bch_btree_iter_init(b, &iter, NULL, &b->set[start]);
+	__bch_btree_iter_stack_init(b, &iter, NULL, &b->set[start]);
 
 	if (start) {
 		unsigned int i;
@@ -1339,7 +1307,7 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 		order = get_order(__set_bytes(b->set->data, keys));
 	}
 
-	__btree_sort(b, &iter, start, order, false, state);
+	__btree_sort(b, &iter.iter, start, order, false, state);
 
 	EBUG_ON(oldsize >= 0 && bch_count_data(b) != oldsize);
 }
@@ -1355,13 +1323,11 @@ void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
 			 struct bset_sort_state *state)
 {
 	uint64_t start_time = local_clock();
-	struct btree_iter iter;
-
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
+	struct btree_iter_stack iter;
 
-	bch_btree_iter_init(b, &iter, NULL);
+	bch_btree_iter_stack_init(b, &iter, NULL);
 
-	btree_mergesort(b, new->set->data, &iter, false, true);
+	btree_mergesort(b, new->set->data, &iter.iter, false, true);
 
 	bch_time_stats_update(&state->time, start_time);
 
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index f79441acd4c1..011f6062c4c0 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -187,9 +187,8 @@ struct bset_tree {
 };
 
 struct btree_keys_ops {
-	bool		(*sort_cmp)(const void *l,
-				    const void *r,
-					void *args);
+	bool		(*sort_cmp)(struct btree_iter_set l,
+				    struct btree_iter_set r);
 	struct bkey	*(*sort_fixup)(struct btree_iter *iter,
 				       struct bkey *tmp);
 	bool		(*insert_fixup)(struct btree_keys *b,
@@ -313,17 +312,23 @@ enum {
 	BTREE_INSERT_STATUS_FRONT_MERGE,
 };
 
-struct btree_iter_set {
-	struct bkey *k, *end;
-};
-
 /* Btree key iteration */
 
 struct btree_iter {
+	size_t size, used;
 #ifdef CONFIG_BCACHE_DEBUG
 	struct btree_keys *b;
 #endif
-	MIN_HEAP_PREALLOCATED(struct btree_iter_set, btree_iter_heap, MAX_BSETS) heap;
+	struct btree_iter_set {
+		struct bkey *k, *end;
+	} data[];
+};
+
+/* Fixed-size btree_iter that can be allocated on the stack */
+
+struct btree_iter_stack {
+	struct btree_iter iter;
+	struct btree_iter_set stack_data[MAX_BSETS];
 };
 
 typedef bool (*ptr_filter_fn)(struct btree_keys *b, const struct bkey *k);
@@ -335,9 +340,9 @@ struct bkey *bch_btree_iter_next_filter(struct btree_iter *iter,
 
 void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
 			 struct bkey *end);
-struct bkey *bch_btree_iter_init(struct btree_keys *b,
-				 struct btree_iter *iter,
-				 struct bkey *search);
+struct bkey *bch_btree_iter_stack_init(struct btree_keys *b,
+				       struct btree_iter_stack *iter,
+				       struct bkey *search);
 
 struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
 			       const struct bkey *search);
@@ -352,13 +357,14 @@ static inline struct bkey *bch_bset_search(struct btree_keys *b,
 	return search ? __bch_bset_search(b, t, search) : t->data->start;
 }
 
-#define for_each_key_filter(b, k, iter, filter)				\
-	for (bch_btree_iter_init((b), (iter), NULL);			\
-	     ((k) = bch_btree_iter_next_filter((iter), (b), filter));)
+#define for_each_key_filter(b, k, stack_iter, filter)                      \
+	for (bch_btree_iter_stack_init((b), (stack_iter), NULL);           \
+	     ((k) = bch_btree_iter_next_filter(&((stack_iter)->iter), (b), \
+					       filter));)
 
-#define for_each_key(b, k, iter)					\
-	for (bch_btree_iter_init((b), (iter), NULL);			\
-	     ((k) = bch_btree_iter_next(iter));)
+#define for_each_key(b, k, stack_iter)                           \
+	for (bch_btree_iter_stack_init((b), (stack_iter), NULL); \
+	     ((k) = bch_btree_iter_next(&((stack_iter)->iter)));)
 
 /* Sorting */
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ed40d8600656..4e6ccf2c8a0b 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -149,19 +149,19 @@ void bch_btree_node_read_done(struct btree *b)
 {
 	const char *err = "bad btree header";
 	struct bset *i = btree_bset_first(b);
-	struct btree_iter iter;
+	struct btree_iter *iter;
 
 	/*
 	 * c->fill_iter can allocate an iterator with more memory space
 	 * than static MAX_BSETS.
 	 * See the comment arount cache_set->fill_iter.
 	 */
-	iter.heap.data = mempool_alloc(&b->c->fill_iter, GFP_NOIO);
-	iter.heap.size = b->c->cache->sb.bucket_size / b->c->cache->sb.block_size;
-	iter.heap.nr = 0;
+	iter = mempool_alloc(&b->c->fill_iter, GFP_NOIO);
+	iter->size = b->c->cache->sb.bucket_size / b->c->cache->sb.block_size;
+	iter->used = 0;
 
 #ifdef CONFIG_BCACHE_DEBUG
-	iter.b = &b->keys;
+	iter->b = &b->keys;
 #endif
 
 	if (!i->seq)
@@ -199,7 +199,7 @@ void bch_btree_node_read_done(struct btree *b)
 		if (i != b->keys.set[0].data && !i->keys)
 			goto err;
 
-		bch_btree_iter_push(&iter, i->start, bset_bkey_last(i));
+		bch_btree_iter_push(iter, i->start, bset_bkey_last(i));
 
 		b->written += set_blocks(i, block_bytes(b->c->cache));
 	}
@@ -211,7 +211,7 @@ void bch_btree_node_read_done(struct btree *b)
 		if (i->seq == b->keys.set[0].data->seq)
 			goto err;
 
-	bch_btree_sort_and_fix_extents(&b->keys, &iter, &b->c->sort);
+	bch_btree_sort_and_fix_extents(&b->keys, iter, &b->c->sort);
 
 	i = b->keys.set[0].data;
 	err = "short btree key";
@@ -223,7 +223,7 @@ void bch_btree_node_read_done(struct btree *b)
 		bch_bset_init_next(&b->keys, write_block(b),
 				   bset_magic(&b->c->cache->sb));
 out:
-	mempool_free(iter.heap.data, &b->c->fill_iter);
+	mempool_free(iter, &b->c->fill_iter);
 	return;
 err:
 	set_btree_node_io_error(b);
@@ -1309,11 +1309,9 @@ static bool btree_gc_mark_node(struct btree *b, struct gc_stat *gc)
 	uint8_t stale = 0;
 	unsigned int keys = 0, good_keys = 0;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bset_tree *t;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	gc->nodes++;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_invalid) {
@@ -1572,11 +1570,9 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 static unsigned int btree_gc_count_keys(struct btree *b)
 {
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	unsigned int ret = 0;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_bad)
 		ret += bkey_u64s(k);
 
@@ -1615,18 +1611,18 @@ static int btree_gc_recurse(struct btree *b, struct btree_op *op,
 	int ret = 0;
 	bool should_rewrite;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct gc_merge_info r[GC_MERGE_NODES];
 	struct gc_merge_info *i, *last = r + ARRAY_SIZE(r) - 1;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	bch_btree_iter_init(&b->keys, &iter, &b->c->gc_done);
+	bch_btree_iter_stack_init(&b->keys, &iter, &b->c->gc_done);
 
 	for (i = r; i < r + ARRAY_SIZE(r); i++)
 		i->b = ERR_PTR(-EINTR);
 
 	while (1) {
-		k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad);
+		k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
+					       bch_ptr_bad);
 		if (k) {
 			r->b = bch_btree_node_get(b->c, op, k, b->level - 1,
 						  true, b);
@@ -1921,9 +1917,7 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 {
 	int ret = 0;
 	struct bkey *k, *p = NULL;
-	struct btree_iter iter;
-
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
+	struct btree_iter_stack iter;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_invalid)
 		bch_initial_mark_key(b->c, b->level, k);
@@ -1931,10 +1925,10 @@ static int bch_btree_check_recurse(struct btree *b, struct btree_op *op)
 	bch_initial_mark_key(b->c, b->level + 1, &b->key);
 
 	if (b->level) {
-		bch_btree_iter_init(&b->keys, &iter, NULL);
+		bch_btree_iter_stack_init(&b->keys, &iter, NULL);
 
 		do {
-			k = bch_btree_iter_next_filter(&iter, &b->keys,
+			k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
 						       bch_ptr_bad);
 			if (k) {
 				btree_node_prefetch(b, k);
@@ -1962,7 +1956,7 @@ static int bch_btree_check_thread(void *arg)
 	struct btree_check_info *info = arg;
 	struct btree_check_state *check_state = info->state;
 	struct cache_set *c = check_state->c;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k, *p;
 	int cur_idx, prev_idx, skip_nr;
 
@@ -1970,11 +1964,9 @@ static int bch_btree_check_thread(void *arg)
 	cur_idx = prev_idx = 0;
 	ret = 0;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	/* root node keys are checked before thread created */
-	bch_btree_iter_init(&c->root->keys, &iter, NULL);
-	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	bch_btree_iter_stack_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter.iter, &c->root->keys, bch_ptr_bad);
 	BUG_ON(!k);
 
 	p = k;
@@ -1992,7 +1984,7 @@ static int bch_btree_check_thread(void *arg)
 		skip_nr = cur_idx - prev_idx;
 
 		while (skip_nr) {
-			k = bch_btree_iter_next_filter(&iter,
+			k = bch_btree_iter_next_filter(&iter.iter,
 						       &c->root->keys,
 						       bch_ptr_bad);
 			if (k)
@@ -2065,11 +2057,9 @@ int bch_btree_check(struct cache_set *c)
 	int ret = 0;
 	int i;
 	struct bkey *k = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct btree_check_state check_state;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 	/* check and mark root node keys */
 	for_each_key_filter(&c->root->keys, k, &iter, bch_ptr_invalid)
 		bch_initial_mark_key(c, c->root->level, k);
@@ -2563,12 +2553,11 @@ static int bch_btree_map_nodes_recurse(struct btree *b, struct btree_op *op,
 
 	if (b->level) {
 		struct bkey *k;
-		struct btree_iter iter;
+		struct btree_iter_stack iter;
 
-		min_heap_init(&iter.heap, NULL, MAX_BSETS);
-		bch_btree_iter_init(&b->keys, &iter, from);
+		bch_btree_iter_stack_init(&b->keys, &iter, from);
 
-		while ((k = bch_btree_iter_next_filter(&iter, &b->keys,
+		while ((k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
 						       bch_ptr_bad))) {
 			ret = bcache_btree(map_nodes_recurse, k, b,
 				    op, from, fn, flags);
@@ -2597,12 +2586,12 @@ int bch_btree_map_keys_recurse(struct btree *b, struct btree_op *op,
 {
 	int ret = MAP_CONTINUE;
 	struct bkey *k;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	bch_btree_iter_init(&b->keys, &iter, from);
+	bch_btree_iter_stack_init(&b->keys, &iter, from);
 
-	while ((k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad))) {
+	while ((k = bch_btree_iter_next_filter(&iter.iter, &b->keys,
+					       bch_ptr_bad))) {
 		ret = !b->level
 			? fn(op, b, k)
 			: bcache_btree(map_keys_recurse, k,
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index a7221e5dbe81..d626ffcbecb9 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -33,16 +33,15 @@ static void sort_key_next(struct btree_iter *iter,
 	i->k = bkey_next(i->k);
 
 	if (i->k == i->end)
-		*i = iter->heap.data[--iter->heap.nr];
+		*i = iter->data[--iter->used];
 }
 
-static bool new_bch_key_sort_cmp(const void *l, const void *r, void *args)
+static bool bch_key_sort_cmp(struct btree_iter_set l,
+			     struct btree_iter_set r)
 {
-	struct btree_iter_set *_l = (struct btree_iter_set *)l;
-	struct btree_iter_set *_r = (struct btree_iter_set *)r;
-	int64_t c = bkey_cmp(_l->k, _r->k);
+	int64_t c = bkey_cmp(l.k, r.k);
 
-	return !(c ? c > 0 : _l->k < _r->k);
+	return c ? c > 0 : l.k < r.k;
 }
 
 static bool __ptr_invalid(struct cache_set *c, const struct bkey *k)
@@ -239,7 +238,7 @@ static bool bch_btree_ptr_insert_fixup(struct btree_keys *bk,
 }
 
 const struct btree_keys_ops bch_btree_keys_ops = {
-	.sort_cmp	= new_bch_key_sort_cmp,
+	.sort_cmp	= bch_key_sort_cmp,
 	.insert_fixup	= bch_btree_ptr_insert_fixup,
 	.key_invalid	= bch_btree_ptr_invalid,
 	.key_bad	= bch_btree_ptr_bad,
@@ -256,36 +255,22 @@ const struct btree_keys_ops bch_btree_keys_ops = {
  * Necessary for btree_sort_fixup() - if there are multiple keys that compare
  * equal in different sets, we have to process them newest to oldest.
  */
-
-static bool new_bch_extent_sort_cmp(const void *l, const void *r, void __always_unused *args)
-{
-	struct btree_iter_set *_l = (struct btree_iter_set *)l;
-	struct btree_iter_set *_r = (struct btree_iter_set *)r;
-	int64_t c = bkey_cmp(&START_KEY(_l->k), &START_KEY(_r->k));
-
-	return !(c ? c > 0 : _l->k < _r->k);
-}
-
-static inline void new_btree_iter_swap(void *iter1, void *iter2, void __always_unused *args)
+static bool bch_extent_sort_cmp(struct btree_iter_set l,
+				struct btree_iter_set r)
 {
-	struct btree_iter_set *_iter1 = iter1;
-	struct btree_iter_set *_iter2 = iter2;
+	int64_t c = bkey_cmp(&START_KEY(l.k), &START_KEY(r.k));
 
-	swap(*_iter1, *_iter2);
+	return c ? c > 0 : l.k < r.k;
 }
 
 static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 					  struct bkey *tmp)
 {
-	const struct min_heap_callbacks callbacks = {
-		.less = new_bch_extent_sort_cmp,
-		.swp = new_btree_iter_swap,
-	};
-	while (iter->heap.nr > 1) {
-		struct btree_iter_set *top = iter->heap.data, *i = top + 1;
-
-		if (iter->heap.nr > 2 &&
-		    !new_bch_extent_sort_cmp(&i[0], &i[1], NULL))
+	while (iter->used > 1) {
+		struct btree_iter_set *top = iter->data, *i = top + 1;
+
+		if (iter->used > 2 &&
+		    bch_extent_sort_cmp(i[0], i[1]))
 			i++;
 
 		if (bkey_cmp(top->k, &START_KEY(i->k)) <= 0)
@@ -293,7 +278,7 @@ static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 
 		if (!KEY_SIZE(i->k)) {
 			sort_key_next(iter, i);
-			min_heap_sift_down(&iter->heap, i - top, &callbacks, NULL);
+			heap_sift(iter, i - top, bch_extent_sort_cmp);
 			continue;
 		}
 
@@ -303,7 +288,7 @@ static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 			else
 				bch_cut_front(top->k, i->k);
 
-			min_heap_sift_down(&iter->heap, i - top, &callbacks, NULL);
+			heap_sift(iter, i - top, bch_extent_sort_cmp);
 		} else {
 			/* can't happen because of comparison func */
 			BUG_ON(!bkey_cmp(&START_KEY(top->k), &START_KEY(i->k)));
@@ -313,7 +298,7 @@ static struct bkey *bch_extent_sort_fixup(struct btree_iter *iter,
 
 				bch_cut_back(&START_KEY(i->k), tmp);
 				bch_cut_front(i->k, top->k);
-				min_heap_sift_down(&iter->heap, 0, &callbacks, NULL);
+				heap_sift(iter, 0, bch_extent_sort_cmp);
 
 				return tmp;
 			} else {
@@ -633,7 +618,7 @@ static bool bch_extent_merge(struct btree_keys *bk,
 }
 
 const struct btree_keys_ops bch_extent_keys_ops = {
-	.sort_cmp	= new_bch_extent_sort_cmp,
+	.sort_cmp	= bch_extent_sort_cmp,
 	.sort_fixup	= bch_extent_sort_fixup,
 	.insert_fixup	= bch_extent_insert_fixup,
 	.key_invalid	= bch_extent_invalid,
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 7f482729c56d..ebd500bdf0b2 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -182,27 +182,16 @@ err:		if (!IS_ERR_OR_NULL(w->private))
 	closure_sync(&cl);
 }
 
-static bool new_bucket_cmp(const void *l, const void *r, void __always_unused *args)
+static bool bucket_cmp(struct bucket *l, struct bucket *r)
 {
-	struct bucket **_l = (struct bucket **)l;
-	struct bucket **_r = (struct bucket **)r;
-
-	return GC_SECTORS_USED(*_l) >= GC_SECTORS_USED(*_r);
-}
-
-static void new_bucket_swap(void *l, void *r, void __always_unused *args)
-{
-	struct bucket **_l = l;
-	struct bucket **_r = r;
-
-	swap(*_l, *_r);
+	return GC_SECTORS_USED(l) < GC_SECTORS_USED(r);
 }
 
 static unsigned int bucket_heap_top(struct cache *ca)
 {
 	struct bucket *b;
 
-	return (b = min_heap_peek(&ca->heap)[0]) ? GC_SECTORS_USED(b) : 0;
+	return (b = heap_peek(&ca->heap)) ? GC_SECTORS_USED(b) : 0;
 }
 
 void bch_moving_gc(struct cache_set *c)
@@ -210,10 +199,6 @@ void bch_moving_gc(struct cache_set *c)
 	struct cache *ca = c->cache;
 	struct bucket *b;
 	unsigned long sectors_to_move, reserve_sectors;
-	const struct min_heap_callbacks callbacks = {
-		.less = new_bucket_cmp,
-		.swp = new_bucket_swap,
-	};
 
 	if (!c->copy_gc_enabled)
 		return;
@@ -224,7 +209,7 @@ void bch_moving_gc(struct cache_set *c)
 	reserve_sectors = ca->sb.bucket_size *
 			     fifo_used(&ca->free[RESERVE_MOVINGGC]);
 
-	ca->heap.nr = 0;
+	ca->heap.used = 0;
 
 	for_each_bucket(b, ca) {
 		if (GC_MARK(b) == GC_MARK_METADATA ||
@@ -233,31 +218,25 @@ void bch_moving_gc(struct cache_set *c)
 		    atomic_read(&b->pin))
 			continue;
 
-		if (!min_heap_full(&ca->heap)) {
+		if (!heap_full(&ca->heap)) {
 			sectors_to_move += GC_SECTORS_USED(b);
-			min_heap_push(&ca->heap, &b, &callbacks, NULL);
-		} else if (!new_bucket_cmp(&b, min_heap_peek(&ca->heap), ca)) {
+			heap_add(&ca->heap, b, bucket_cmp);
+		} else if (bucket_cmp(b, heap_peek(&ca->heap))) {
 			sectors_to_move -= bucket_heap_top(ca);
 			sectors_to_move += GC_SECTORS_USED(b);
 
 			ca->heap.data[0] = b;
-			min_heap_sift_down(&ca->heap, 0, &callbacks, NULL);
+			heap_sift(&ca->heap, 0, bucket_cmp);
 		}
 	}
 
 	while (sectors_to_move > reserve_sectors) {
-		if (ca->heap.nr) {
-			b = min_heap_peek(&ca->heap)[0];
-			min_heap_pop(&ca->heap, &callbacks, NULL);
-		}
+		heap_pop(&ca->heap, b, bucket_cmp);
 		sectors_to_move -= GC_SECTORS_USED(b);
 	}
 
-	while (ca->heap.nr) {
-		b = min_heap_peek(&ca->heap)[0];
-		min_heap_pop(&ca->heap, &callbacks, NULL);
+	while (heap_pop(&ca->heap, b, bucket_cmp))
 		SET_GC_MOVE(b, 1);
-	}
 
 	mutex_unlock(&c->bucket_lock);
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f5171167819b..1084b3f0dfe7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1912,7 +1912,8 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	INIT_LIST_HEAD(&c->btree_cache_freed);
 	INIT_LIST_HEAD(&c->data_buckets);
 
-	iter_size = ((meta_bucket_pages(sb) * PAGE_SECTORS) / sb->block_size) *
+	iter_size = sizeof(struct btree_iter) +
+		    ((meta_bucket_pages(sb) * PAGE_SECTORS) / sb->block_size) *
 			    sizeof(struct btree_iter_set);
 
 	c->devices = kcalloc(c->nr_uuids, sizeof(void *), GFP_KERNEL);
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index e8f696cb58c0..826b14cae4e5 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -660,9 +660,7 @@ static unsigned int bch_root_usage(struct cache_set *c)
 	unsigned int bytes = 0;
 	struct bkey *k;
 	struct btree *b;
-	struct btree_iter iter;
-
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
+	struct btree_iter_stack iter;
 
 	goto lock_root;
 
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 539454d8e2d0..f61ab1bada6c 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/sched/clock.h>
 #include <linux/llist.h>
-#include <linux/min_heap.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -31,10 +30,16 @@ struct closure;
 
 #endif
 
+#define DECLARE_HEAP(type, name)					\
+	struct {							\
+		size_t size, used;					\
+		type *data;						\
+	} name
+
 #define init_heap(heap, _size, gfp)					\
 ({									\
 	size_t _bytes;							\
-	(heap)->nr = 0;						\
+	(heap)->used = 0;						\
 	(heap)->size = (_size);						\
 	_bytes = (heap)->size * sizeof(*(heap)->data);			\
 	(heap)->data = kvmalloc(_bytes, (gfp) & GFP_KERNEL);		\
@@ -47,6 +52,64 @@ do {									\
 	(heap)->data = NULL;						\
 } while (0)
 
+#define heap_swap(h, i, j)	swap((h)->data[i], (h)->data[j])
+
+#define heap_sift(h, i, cmp)						\
+do {									\
+	size_t _r, _j = i;						\
+									\
+	for (; _j * 2 + 1 < (h)->used; _j = _r) {			\
+		_r = _j * 2 + 1;					\
+		if (_r + 1 < (h)->used &&				\
+		    cmp((h)->data[_r], (h)->data[_r + 1]))		\
+			_r++;						\
+									\
+		if (cmp((h)->data[_r], (h)->data[_j]))			\
+			break;						\
+		heap_swap(h, _r, _j);					\
+	}								\
+} while (0)
+
+#define heap_sift_down(h, i, cmp)					\
+do {									\
+	while (i) {							\
+		size_t p = (i - 1) / 2;					\
+		if (cmp((h)->data[i], (h)->data[p]))			\
+			break;						\
+		heap_swap(h, i, p);					\
+		i = p;							\
+	}								\
+} while (0)
+
+#define heap_add(h, d, cmp)						\
+({									\
+	bool _r = !heap_full(h);					\
+	if (_r) {							\
+		size_t _i = (h)->used++;				\
+		(h)->data[_i] = d;					\
+									\
+		heap_sift_down(h, _i, cmp);				\
+		heap_sift(h, _i, cmp);					\
+	}								\
+	_r;								\
+})
+
+#define heap_pop(h, d, cmp)						\
+({									\
+	bool _r = (h)->used;						\
+	if (_r) {							\
+		(d) = (h)->data[0];					\
+		(h)->used--;						\
+		heap_swap(h, 0, (h)->used);				\
+		heap_sift(h, 0, cmp);					\
+	}								\
+	_r;								\
+})
+
+#define heap_peek(h)	((h)->used ? (h)->data[0] : NULL)
+
+#define heap_full(h)	((h)->used == (h)->size)
+
 #define DECLARE_FIFO(type, name)					\
 	struct {							\
 		size_t front, back, size, mask;				\
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index c1d28e365910..792e070ccf38 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -908,16 +908,15 @@ static int bch_dirty_init_thread(void *arg)
 	struct dirty_init_thrd_info *info = arg;
 	struct bch_dirty_init_state *state = info->state;
 	struct cache_set *c = state->c;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct bkey *k, *p;
 	int cur_idx, prev_idx, skip_nr;
 
 	k = p = NULL;
 	prev_idx = 0;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-	bch_btree_iter_init(&c->root->keys, &iter, NULL);
-	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
+	bch_btree_iter_stack_init(&c->root->keys, &iter, NULL);
+	k = bch_btree_iter_next_filter(&iter.iter, &c->root->keys, bch_ptr_bad);
 	BUG_ON(!k);
 
 	p = k;
@@ -931,7 +930,7 @@ static int bch_dirty_init_thread(void *arg)
 		skip_nr = cur_idx - prev_idx;
 
 		while (skip_nr) {
-			k = bch_btree_iter_next_filter(&iter,
+			k = bch_btree_iter_next_filter(&iter.iter,
 						       &c->root->keys,
 						       bch_ptr_bad);
 			if (k)
@@ -980,13 +979,11 @@ void bch_sectors_dirty_init(struct bcache_device *d)
 	int i;
 	struct btree *b = NULL;
 	struct bkey *k = NULL;
-	struct btree_iter iter;
+	struct btree_iter_stack iter;
 	struct sectors_dirty_init op;
 	struct cache_set *c = d->c;
 	struct bch_dirty_init_state state;
 
-	min_heap_init(&iter.heap, NULL, MAX_BSETS);
-
 retry_lock:
 	b = c->root;
 	rw_lock(0, b, b->level);
-- 
2.34.1


