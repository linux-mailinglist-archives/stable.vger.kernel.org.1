Return-Path: <stable+bounces-171721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA1B2B6E2
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A8526112
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB520B7FE;
	Tue, 19 Aug 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci3h2tsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785522BDC14
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569768; cv=none; b=cSg/Za+I7KPH8bHFRZMrx7Jxtx5w3ElW9ry4soQuW7oYzE2ZdmgxehjqDxXTqM4+CuCXacuEqiVHD3q7TYM/+uPtXyJ9fZ9gQcPtM6M/qgWIRuF6DFwjhEZCM36ToFcNf3DnRuRTq6Pvs250MknTWbdNrIY5zT3GH4PwOJN0CuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569768; c=relaxed/simple;
	bh=VjgLVFyIP6tqgq4ExFqwWmlYemBp45C6efFikfEPPQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMEcumy9JaUU59Vc24A9qrbZLeYGp8qm+kVg9Lr6U962oeLZSyEEEvwOcX5wK30gyki1ABgfeSN/97vojXITSTm+5f3kXaIqG9DjPSnCZnqQJiDaOc7+1LlXpeHRPOEBOSKsMIzWR7UZERBQcXgakQnTFF1UQjJB2e8a2bOXCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci3h2tsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D432CC116C6;
	Tue, 19 Aug 2025 02:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569768;
	bh=VjgLVFyIP6tqgq4ExFqwWmlYemBp45C6efFikfEPPQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci3h2tsjYRN7pfhnQyR21E6pEUx0VgSRjcnRAaaSJQfH9HyP2bVAFF019Kej0kj/7
	 jb5CGSRYaE9TCftuUXA+8Exyh0scB37ktv5p06c6ZLTPmx4EJtLhNzonWHZHspB83d
	 Bn/N0gW+56SZ/VDk7KNbh/o67Bem1QWhqxKZcd9UoC8/pHNWxlsLjC8MFEF+8VXnIP
	 36s0rVZVVziHBifia3fvNLpEhFiNDAmTbjYCwQk+T0grff6pEtbFv34fvHzT4DKG/7
	 ZKJVWtoNGdvKc7svleZsLuhBM2zqEcEKUVcfJG2HjYdsRf+BnInymblRKy0JewCx8q
	 i5IdD6Qt1VOPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/7] btrfs: send: keep the current inode's path cached
Date: Mon, 18 Aug 2025 22:15:58 -0400
Message-ID: <20250819021601.274993-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819021601.274993-1-sashal@kernel.org>
References: <2025081827-washed-yelp-3c3e@gregkh>
 <20250819021601.274993-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit fc746acb7aa9aeaa2cb5dcba449323319ba5c8eb ]

Whenever we need to send a command for the current inode, like sending
writes, xattr updates, truncates, utimes, etc, we compute the inode's
path each time, which implies doing some memory allocations and traversing
the inode hierarchy to extract the name of the inode and each ancestor
directory, and that implies doing lookups in the subvolume tree amongst
other operations.

Most of the time, by far, the current inode's path doesn't change while
we are processing it (like if we need to issue 100 write commands, the
path remains the same and it's pointless to compute it 100 times).

To avoid this keep the current inode's path cached in the send context
and invalidate it or update it whenever it's needed (after unlinks or
renames).

A performance test, and its results, is mentioned in the next patch in
the series (subject: "btrfs: send: avoid path allocation for the current
inode when issuing commands").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 005b0a0c24e1 ("btrfs: send: use fallocate for hole punching with send stream v2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3a960ac1f3c3..9e2ae2dc41d5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -178,6 +178,7 @@ struct send_ctx {
 	u64 cur_inode_rdev;
 	u64 cur_inode_last_extent;
 	u64 cur_inode_next_write_offset;
+	struct fs_path cur_inode_path;
 	bool cur_inode_new;
 	bool cur_inode_new_gen;
 	bool cur_inode_deleted;
@@ -436,6 +437,14 @@ static void fs_path_reset(struct fs_path *p)
 	}
 }
 
+static void init_path(struct fs_path *p)
+{
+	p->reversed = 0;
+	p->buf = p->inline_buf;
+	p->buf_len = FS_PATH_INLINE_SIZE;
+	fs_path_reset(p);
+}
+
 static struct fs_path *fs_path_alloc(void)
 {
 	struct fs_path *p;
@@ -443,10 +452,7 @@ static struct fs_path *fs_path_alloc(void)
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return NULL;
-	p->reversed = 0;
-	p->buf = p->inline_buf;
-	p->buf_len = FS_PATH_INLINE_SIZE;
-	fs_path_reset(p);
+	init_path(p);
 	return p;
 }
 
@@ -624,6 +630,14 @@ static void fs_path_unreverse(struct fs_path *p)
 	p->reversed = 0;
 }
 
+static inline bool is_current_inode_path(const struct send_ctx *sctx,
+					 const struct fs_path *path)
+{
+	const struct fs_path *cur = &sctx->cur_inode_path;
+
+	return (strncmp(path->start, cur->start, fs_path_len(cur)) == 0);
+}
+
 static struct btrfs_path *alloc_path_for_send(void)
 {
 	struct btrfs_path *path;
@@ -2450,6 +2464,14 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 	u64 parent_inode = 0;
 	u64 parent_gen = 0;
 	int stop = 0;
+	const bool is_cur_inode = (ino == sctx->cur_ino && gen == sctx->cur_inode_gen);
+
+	if (is_cur_inode && fs_path_len(&sctx->cur_inode_path) > 0) {
+		if (dest != &sctx->cur_inode_path)
+			return fs_path_copy(dest, &sctx->cur_inode_path);
+
+		return 0;
+	}
 
 	name = fs_path_alloc();
 	if (!name) {
@@ -2501,8 +2523,12 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 
 out:
 	fs_path_free(name);
-	if (!ret)
+	if (!ret) {
 		fs_path_unreverse(dest);
+		if (is_cur_inode && dest != &sctx->cur_inode_path)
+			ret = fs_path_copy(&sctx->cur_inode_path, dest);
+	}
+
 	return ret;
 }
 
@@ -3112,6 +3138,11 @@ static int orphanize_inode(struct send_ctx *sctx, u64 ino, u64 gen,
 		goto out;
 
 	ret = send_rename(sctx, path, orphan);
+	if (ret < 0)
+		goto out;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		ret = fs_path_copy(&sctx->cur_inode_path, orphan);
 
 out:
 	fs_path_free(orphan);
@@ -4175,6 +4206,10 @@ static int rename_current_inode(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 
+	ret = fs_path_copy(&sctx->cur_inode_path, new_path);
+	if (ret < 0)
+		return ret;
+
 	return fs_path_copy(current_path, new_path);
 }
 
@@ -4368,6 +4403,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (ret > 0) {
 					orphanized_ancestor = true;
 					fs_path_reset(valid_path);
+					fs_path_reset(&sctx->cur_inode_path);
 					ret = get_cur_path(sctx, sctx->cur_ino,
 							   sctx->cur_inode_gen,
 							   valid_path);
@@ -4567,6 +4603,8 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_unlink(sctx, cur->full_path);
 				if (ret < 0)
 					goto out;
+				if (is_current_inode_path(sctx, cur->full_path))
+					fs_path_reset(&sctx->cur_inode_path);
 			}
 			ret = dup_ref(cur, &check_dirs);
 			if (ret < 0)
@@ -6902,6 +6940,7 @@ static int changed_inode(struct send_ctx *sctx,
 	sctx->cur_inode_last_extent = (u64)-1;
 	sctx->cur_inode_next_write_offset = 0;
 	sctx->ignore_cur_inode = false;
+	fs_path_reset(&sctx->cur_inode_path);
 
 	/*
 	 * Set send_progress to current inode. This will tell all get_cur_xxx
@@ -8174,6 +8213,7 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		goto out;
 	}
 
+	init_path(&sctx->cur_inode_path);
 	INIT_LIST_HEAD(&sctx->new_refs);
 	INIT_LIST_HEAD(&sctx->deleted_refs);
 
@@ -8459,6 +8499,9 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		btrfs_lru_cache_clear(&sctx->dir_created_cache);
 		btrfs_lru_cache_clear(&sctx->dir_utimes_cache);
 
+		if (sctx->cur_inode_path.buf != sctx->cur_inode_path.inline_buf)
+			kfree(sctx->cur_inode_path.buf);
+
 		kfree(sctx);
 	}
 
-- 
2.50.1


