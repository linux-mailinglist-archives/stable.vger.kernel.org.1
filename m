Return-Path: <stable+bounces-23978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10599869215
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D411C26133
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3911813B7AB;
	Tue, 27 Feb 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVh+d0qi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDB13B293;
	Tue, 27 Feb 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040689; cv=none; b=Vy/qGB7IbsMq/zv719UgDl0BX60fhCPYe3FWhwWu/hMsbp6KDyTkG6Txbh+r2V7O7snPi73xlPbMYmoNMqtyWJCV22LXcV8+5BFVGWRWIIwvYt4YacdQfP7WzcAFrShR6mYXvfa6CtgU57/ymV4hdgwXEmCa1/raMj+5cw+JhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040689; c=relaxed/simple;
	bh=710Tba2H1WssMnnR7JCuviGhIRpFlBtSnMJN+oP/N78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boSr+vfp0M9K1K/LbITXmQTRGKTD6cI2NQlKbDxIkkWQ5Pcd2hS39bk9uBQoLOVGDIAIBaH5MYj9tKs1/sLfGocNgK/K38zT4pMAOjfDdffRB8T5Tw8Qb7aeQUmU1Cgb72bmGd9Zhh2tyOpMKnLGfwflUQ98+4FGquvBiNriE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVh+d0qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B298C433C7;
	Tue, 27 Feb 2024 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040688;
	bh=710Tba2H1WssMnnR7JCuviGhIRpFlBtSnMJN+oP/N78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVh+d0qiWy7tcMABOA8UQi3pJqfLPecFq9qjWDUZn9kM8BRDA8UR0nR8g5oFfm0Hg
	 eZU1GaHFTIgHHq+c6LiEI/fTpQYaor2Vv80oOwldzlrvbGkoKoduItMBhR6MR8JhjX
	 R99LjuYgg1zomlDcRFrr8YCBYjBf5VQfz0r4BN9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 074/334] ext4: correct the hole length returned by ext4_map_blocks()
Date: Tue, 27 Feb 2024 14:18:52 +0100
Message-ID: <20240227131632.931174344@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 6430dea07e85958fa87d0276c0c4388dd51e630b ]

In ext4_map_blocks(), if we can't find a range of mapping in the
extents cache, we are calling ext4_ext_map_blocks() to search the real
path and ext4_ext_determine_hole() to determine the hole range. But if
the querying range was partially or completely overlaped by a delalloc
extent, we can't find it in the real extent path, so the returned hole
length could be incorrect.

Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
extent, but it searches start from the expanded hole_start, doesn't
start from the querying range, so the delalloc extent found could not be
the one that overlaped the querying range, plus, it also didn't adjust
the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
delalloc and insert adjusted hole extent in ext4_ext_determine_hole().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240127015825.1608160-4-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 111 +++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 01299b55a567a..fadfca75c3197 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2229,7 +2229,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 
 /*
- * ext4_ext_determine_hole - determine hole around given block
+ * ext4_ext_find_hole - find hole around given block according to the given path
  * @inode:	inode we lookup in
  * @path:	path in extent tree to @lblk
  * @lblk:	pointer to logical block around which we want to determine hole
@@ -2241,9 +2241,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
  * The function returns the length of a hole starting at @lblk. We update @lblk
  * to the beginning of the hole if we managed to find it.
  */
-static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
-					   struct ext4_ext_path *path,
-					   ext4_lblk_t *lblk)
+static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
+				      struct ext4_ext_path *path,
+				      ext4_lblk_t *lblk)
 {
 	int depth = ext_depth(inode);
 	struct ext4_extent *ex;
@@ -2270,30 +2270,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
 	return len;
 }
 
-/*
- * ext4_ext_put_gap_in_cache:
- * calculate boundaries of the gap that the requested block fits into
- * and cache this gap
- */
-static void
-ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
-			  ext4_lblk_t hole_len)
-{
-	struct extent_status es;
-
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
-				  hole_start + hole_len - 1, &es);
-	if (es.es_len) {
-		/* There's delayed extent containing lblock? */
-		if (es.es_lblk <= hole_start)
-			return;
-		hole_len = min(es.es_lblk - hole_start, hole_len);
-	}
-	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
-	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
-			      EXTENT_STATUS_HOLE);
-}
-
 /*
  * ext4_ext_rm_idx:
  * removes index from the index block.
@@ -4062,6 +4038,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Determine hole length around the given logical block, first try to
+ * locate and expand the hole from the given @path, and then adjust it
+ * if it's partially or completely converted to delayed extents, insert
+ * it into the extent cache tree if it's indeed a hole, finally return
+ * the length of the determined extent.
+ */
+static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t lblk)
+{
+	ext4_lblk_t hole_start, len;
+	struct extent_status es;
+
+	hole_start = lblk;
+	len = ext4_ext_find_hole(inode, path, &hole_start);
+again:
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
+				  hole_start + len - 1, &es);
+	if (!es.es_len)
+		goto insert_hole;
+
+	/*
+	 * There's a delalloc extent in the hole, handle it if the delalloc
+	 * extent is in front of, behind and straddle the queried range.
+	 */
+	if (lblk >= es.es_lblk + es.es_len) {
+		/*
+		 * The delalloc extent is in front of the queried range,
+		 * find again from the queried start block.
+		 */
+		len -= lblk - hole_start;
+		hole_start = lblk;
+		goto again;
+	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
+		/*
+		 * The delalloc extent containing lblk, it must have been
+		 * added after ext4_map_blocks() checked the extent status
+		 * tree, adjust the length to the delalloc extent's after
+		 * lblk.
+		 */
+		len = es.es_lblk + es.es_len - lblk;
+		return len;
+	} else {
+		/*
+		 * The delalloc extent is partially or completely behind
+		 * the queried range, update hole length until the
+		 * beginning of the delalloc extent.
+		 */
+		len = min(es.es_lblk - hole_start, len);
+	}
+
+insert_hole:
+	/* Put just found gap into cache to speed up subsequent requests */
+	ext_debug(inode, " -> %u:%u\n", hole_start, len);
+	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
+
+	/* Update hole_len to reflect hole size after lblk */
+	if (hole_start != lblk)
+		len -= lblk - hole_start;
+
+	return len;
+}
 
 /*
  * Block allocation/map/preallocation routine for extents based files
@@ -4179,22 +4218,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * we couldn't try to create block if create flag is zero
 	 */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
-		ext4_lblk_t hole_start, hole_len;
+		ext4_lblk_t len;
 
-		hole_start = map->m_lblk;
-		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
-		/*
-		 * put just found gap into cache to speed up
-		 * subsequent requests
-		 */
-		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
+		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
 
-		/* Update hole_len to reflect hole size after map->m_lblk */
-		if (hole_start != map->m_lblk)
-			hole_len -= map->m_lblk - hole_start;
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, hole_len);
-
+		map->m_len = min_t(unsigned int, map->m_len, len);
 		goto out;
 	}
 
-- 
2.43.0




