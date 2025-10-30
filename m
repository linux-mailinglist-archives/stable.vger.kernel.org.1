Return-Path: <stable+bounces-191727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FFC20355
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2628C1898755
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806463016F6;
	Thu, 30 Oct 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="RgdZyRMi"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD02E8E0B
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830580; cv=none; b=jg5PBV/CN3k+fiHoMCJ64yemMII+4ygm3vMf9fPQ+VTA4RLgoaYRRF5nh++bPmld4hRFXEAjGxawhmlNNhPJtjsgkfPiEApgwP/2LfsIzAMGNp/SyvAYHFstYL5Uq9k4bm25/l2jHvxY1Mv95XyO4o1XvjwL4hcYAZHG30jKJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830580; c=relaxed/simple;
	bh=NfepKbu0TRurkRNR8YIs8likOg1pBFOHb1AOZRbL/a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikKXTXpLfBB/8O7s7ahMCY24jsLrevKkWWJgXb6tZQcFxkg8H+MBEqWPhLlQxV0Bz3aLjFQZNJ9ZVibX+LHM54jfQGDYo9HpwKJtXVfNYI5SYjIUhaBzS2UdV6ewIgXas/NWQDdmXnkO167id8yi7m0igoVQdNvGGbsRmS58uOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=RgdZyRMi; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1761829977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akyCJC3OnMtLon3drtBqXTEbgPI5RX/DE9GHCZwBfwU=;
	b=RgdZyRMiURlYPrBAeRWA2GQEj+77QeU9ennAyZyZDnHoHXeuEwQAwTwubrr3XeRn28Qp2i
	XjIJPw5uUl/ZVapTOGcD4LS3IClc98fmdDI/vudn80sJ07OXkSgDHRJV3QWGtfdUZWYwVM
	bgVrjhR6KQq3qGryNwZ9ZJ3viXv++Ik=
To: stable@vger.kernel.org
Cc: fdmanana@suse.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y 4/5] btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations
Date: Thu, 30 Oct 2025 16:12:53 +0300
Message-Id: <20251030131254.9225-5-kalachev@swemel.ru>
In-Reply-To: <20251030131254.9225-1-kalachev@swemel.ru>
References: <20251030131254.9225-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1cab1375ba6d5337a25acb346996106c12bb2dd0 ]

During fiemap we may have to visit multiple leaves of the subvolume's
inode tree, and each time we are freeing and allocating an extent buffer
to use as a clone of each visited leaf. Optimize this by reusing cloned
extent buffers, to avoid the freeing and re-allocation both of the extent
buffer structure itself and more importantly of the pages attached to the
extent buffer.

CC: stable@vger.kernel.org # 6.1
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 853f39b5e170..c07d12184ae2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3800,7 +3800,7 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 
 static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct extent_buffer *clone;
+	struct extent_buffer *clone = path->nodes[0];
 	struct btrfs_key key;
 	int slot;
 	int ret;
@@ -3809,29 +3809,45 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
 		return 0;
 
+	/*
+	 * Add a temporary extra ref to an already cloned extent buffer to
+	 * prevent btrfs_next_leaf() freeing it, we want to reuse it to avoid
+	 * the cost of allocating a new one.
+	 */
+	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
+	atomic_inc(&clone->refs);
+
 	ret = btrfs_next_leaf(inode->root, path);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	/*
 	 * Don't bother with cloning if there are no more file extent items for
 	 * our inode.
 	 */
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY)
-		return 1;
+	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY) {
+		ret = 1;
+		goto out;
+	}
 
 	/* See the comment at fiemap_search_slot() about why we clone. */
-	clone = btrfs_clone_extent_buffer(path->nodes[0]);
-	if (!clone)
-		return -ENOMEM;
+	copy_extent_buffer_full(clone, path->nodes[0]);
+	/*
+	 * Important to preserve the start field, for the optimizations when
+	 * checking if extents are shared (see extent_fiemap()).
+	 */
+	clone->start = path->nodes[0]->start;
 
 	slot = path->slots[0];
 	btrfs_release_path(path);
 	path->nodes[0] = clone;
 	path->slots[0] = slot;
+out:
+	if (ret)
+		free_extent_buffer(clone);
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.30.2


