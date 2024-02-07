Return-Path: <stable+bounces-19035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0684C32F
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 04:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442341C25190
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C6FC1D;
	Wed,  7 Feb 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tzISHbzm"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B7FC01
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277153; cv=none; b=R3VrFP4v8drx4HPIlS2/s3AjpY5Ypz0irfz4suoG/numNaMDGnYVXmqPqjTIcTXyDVXElnBtrCPlsS/4o0FNI+555fAdYEfbI6NdoDWYTNjtwYYV4dNlHMH6eW4jClE+0L5EjStKArb0HEhhgQXTPVmnUHlrJrHbLPXsc1AIjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277153; c=relaxed/simple;
	bh=U46BdknpGfJcjwdP8dppmlrSBKTzNyeeWT870OF4bJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XiBVYKOEydIUl9P7YZwapuTDJMlrzANHxRihVgEjatP00DGL8XWpv7GLrG0WTqUdgLlMmGFFeu+YPtlFYFuQm1DROr5rX4IUZPaGW19vT3S3Z+6N4pW9gWO8InRP+20vegFfFErqRr3114f6cNSe6xT2qMGwwRIY9rbinFtElq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tzISHbzm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707277145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r51ZHhQk2ZaTew8zad3jGSIvU9CtfS131K9n+R66Vck=;
	b=tzISHbzm075OGdT/f9lsPmcEQiaosAn5+saw6etkpXkrnxxsBsgoP5jKFWsQRWogQZXMP7
	XCz5X6x2lcU73ooaCivufa3yT4TPJgC25UqqAtDFS50jXx7YHMTcyR6CEqSanl3BSIJEK8
	sq4uF7+m6RZYHD/nc8Hm3u6xvNITHNs=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/zswap: invalidate old entry when store fail or !zswap_enabled
Date: Wed,  7 Feb 2024 03:38:57 +0000
Message-Id: <20240207033857.3820921-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

We may encounter duplicate entry in the zswap_store():

1. swap slot that freed to per-cpu swap cache, doesn't invalidate
   the zswap entry, then got reused. This has been fixed.

2. !exclusive load mode, swapin folio will leave its zswap entry
   on the tree, then swapout again. This has been removed.

3. one folio can be dirtied again after zswap_store(), so need to
   zswap_store() again. This should be handled correctly.

So we must invalidate the old duplicate entry before insert the
new one, which actually doesn't have to be done at the beginning
of zswap_store(). And this is a normal situation, we shouldn't
WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
to detect swap entry UAF problem? But not very necessary here.)

The good point is that we don't need to lock tree twice in the
store success path.

Note we still need to invalidate the old duplicate entry in the
store failure path, otherwise the new data in swapfile could be
overwrite by the old data in zswap pool when lru writeback.

We have to do this even when !zswap_enabled since zswap can be
disabled anytime. If the folio store success before, then got
dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store(). So later lru writeback
may overwrite the new data in swapfile.

Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Cc: <stable@vger.kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v3:
 - Fix a few grammatical problems in comments, per Yosry.

v2:
 - Change the duplicate entry invalidation loop to if, since we hold
   the lock, we won't find it once we invalidate it, per Yosry.
 - Add Fixes tag.
---
 mm/zswap.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cd67f7f6b302..d9d8947d6761 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
 		return false;
 
 	if (!zswap_enabled)
-		return false;
+		goto check_old;
 
-	/*
-	 * If this is a duplicate, it must be removed before attempting to store
-	 * it, otherwise, if the store fails the old page won't be removed from
-	 * the tree, and it might be written back overriding the new data.
-	 */
-	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
-	if (entry)
-		zswap_invalidate_entry(tree, entry);
-	spin_unlock(&tree->lock);
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
@@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
 	/* map */
 	spin_lock(&tree->lock);
 	/*
-	 * A duplicate entry should have been removed at the beginning of this
-	 * function. Since the swap entry should be pinned, if a duplicate is
-	 * found again here it means that something went wrong in the swap
-	 * cache.
+	 * The folio may have been dirtied again, invalidate the
+	 * possibly stale entry before inserting the new entry.
 	 */
-	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
-		WARN_ON(1);
+	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
 		zswap_invalidate_entry(tree, dupentry);
+		VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
 	}
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
@@ -1638,6 +1626,17 @@ bool zswap_store(struct folio *folio)
 reject:
 	if (objcg)
 		obj_cgroup_put(objcg);
+check_old:
+	/*
+	 * If the zswap store fails or zswap is disabled, we must invalidate the
+	 * possibly stale entry which was previously stored at this offset.
+	 * Otherwise, writeback could overwrite the new data in the swapfile.
+	 */
+	spin_lock(&tree->lock);
+	entry = zswap_rb_search(&tree->rbroot, offset);
+	if (entry)
+		zswap_invalidate_entry(tree, entry);
+	spin_unlock(&tree->lock);
 	return false;
 
 shrink:
-- 
2.40.1


