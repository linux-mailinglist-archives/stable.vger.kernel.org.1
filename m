Return-Path: <stable+bounces-19069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38084C9FF
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 12:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95DB28736D
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3A1B80A;
	Wed,  7 Feb 2024 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7urxb1z"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D925613
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306868; cv=none; b=S+uaFWR6le8nzGiBSR76eAWdCmc3RA1BZA4VD/pyNo1jTymzzhBB4A7uLr5QoIeUW/lxpOw8NBWo4B2JC7LF4/MC1a7j4fvbmd0kPgnYFqn8mcVF+l+2zSgLN/UM1FA5y8pFBl7+OcK6HJ1t5qcSILvk8LgmtpdZjLuJzYS9Ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306868; c=relaxed/simple;
	bh=JoXxuLCsrhOpbZQMs+OzlyzJluALM1uI9Rd6eTJkgzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rtET9fbwxUtcFV4wxRI1+DBbfSO1hcRk2WBI5NNrEXRFM7vuORUqiJ7Q8ltEVe1s33O6TpH9pyUkKeYnAIWE7TrV84uvnR1p7ipXRJq1O/38ettYzPor2h4J/OBc5xWNwCgOgBMehE+oCTjWXRVBhI3MxQjrY7Bwk6xhxf6QWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7urxb1z; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707306864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ck3hKl39ypdTqSG4pfP4RVVn2fuXE/aqcuy4S0hHA80=;
	b=G7urxb1z2CoYjeym/6zM/gbzSaxYgXK5VSTQONwGFNmhxuLtuFZCpnGIfyLLjDcRpNm+Qu
	of6IbTfTcagmeY/OPVN6FZRaBR2SGUd8nfLeIUcbcPVZUQwg4W4EpbPJKHzPiNRh2P1Cym
	r3yO3vleg65c9uXw28g77L1hoFSfh5Q=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>,
	stable@vger.kernel.org,
	Chris Li <chrisl@kernel.org>
Subject: [PATCH v4] mm/zswap: invalidate old entry when store fail or !zswap_enabled
Date: Wed,  7 Feb 2024 11:54:06 +0000
Message-Id: <20240207115406.3865746-1-chengming.zhou@linux.dev>
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
Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v4:
 - VM_WARN_ON generate no code when !CONFIG_DEBUG_VM, change
   to use WARN_ON.

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
index cd67f7f6b302..62fe307521c9 100644
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
+		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
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


