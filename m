Return-Path: <stable+bounces-38466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C788A0EBA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B2EB21834
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440914600E;
	Thu, 11 Apr 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H1EWYiQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A413E897;
	Thu, 11 Apr 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830656; cv=none; b=mkoElt306LxkVz/eKAPh585dTMfiIqSeaLDPmaS/ZAdLIEJDTiBQQj6SZa8tb1jbYmHa0WaIIxcfcDm5DGxj5Vp/Ocd0NebE4WxdGKHdHDl/mb2zwLG7m4wTThpLz20NGqgQ48wR0tnTmJwTwbwJrA0WRHfvmHuKb+I0doSYv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830656; c=relaxed/simple;
	bh=O9weEfN/yDZ1YJE76iJW9Oo2OTF+8GrpRjuceZHoiYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOzEp4uRpv/fDMAY8YOS+UTXscH9tAQWS/x/x91vo0f092GOGl6APMQvKrq4iZ6kw3LpfOtgQCF24wBA+M6a8Nc5v52FBy7QiA7t/C1YNfRFe9S8FFvnUcDgLW32TFkwu9td5am7WYekdMU/7MeV2FQhiJAZVw9eF8mvGy5rjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H1EWYiQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C27C433C7;
	Thu, 11 Apr 2024 10:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830656;
	bh=O9weEfN/yDZ1YJE76iJW9Oo2OTF+8GrpRjuceZHoiYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1EWYiQ/4BBaCppxtGA5o4ZdbsjGDaxDy5o1ti3gKSNpnr3Nd49NWxYq6f0NBWn1s
	 5HYl5Zp4srBrC+cvLV8vzgj7MoZFSEXRRgdhrSuPtsq+Hoy6zzf7wNila30SHeld/7
	 sM3WlNLRG79WRrRIwEaeGhHmbQOkpBmno48PXfTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Perches <joe@perches.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/215] nilfs2: use a more common logging style
Date: Thu, 11 Apr 2024 11:54:43 +0200
Message-ID: <20240411095427.124001631@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Perches <joe@perches.com>

[ Upstream commit a1d0747a393a079631130d61faa2a61027d1c789 ]

Add macros for nilfs_<level>(sb, fmt, ...) and convert the uses of
'nilfs_msg(sb, KERN_<LEVEL>, ...)' to 'nilfs_<level>(sb, ...)' so nilfs2
uses a logging style more like the typical kernel logging style.

Miscellanea:

o Realign arguments for these uses

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/1595860111-3920-4-git-send-email-konishi.ryusuke@gmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 269cdf353b5b ("nilfs2: prevent kernel bug at submit_bh_wbc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/alloc.c     | 38 +++++++++----------
 fs/nilfs2/btree.c     | 42 ++++++++++-----------
 fs/nilfs2/cpfile.c    | 10 ++---
 fs/nilfs2/dat.c       | 14 +++----
 fs/nilfs2/direct.c    | 14 ++++---
 fs/nilfs2/gcinode.c   |  2 +-
 fs/nilfs2/ifile.c     |  4 +-
 fs/nilfs2/inode.c     | 29 +++++++--------
 fs/nilfs2/ioctl.c     | 37 +++++++++----------
 fs/nilfs2/mdt.c       |  2 +-
 fs/nilfs2/namei.c     |  6 +--
 fs/nilfs2/nilfs.h     |  9 +++++
 fs/nilfs2/page.c      | 11 +++---
 fs/nilfs2/recovery.c  | 32 +++++++---------
 fs/nilfs2/segbuf.c    |  2 +-
 fs/nilfs2/segment.c   | 38 +++++++++----------
 fs/nilfs2/sufile.c    | 29 +++++++--------
 fs/nilfs2/super.c     | 57 ++++++++++++++---------------
 fs/nilfs2/sysfs.c     | 29 +++++++--------
 fs/nilfs2/the_nilfs.c | 85 ++++++++++++++++++++-----------------------
 20 files changed, 239 insertions(+), 251 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index bbd82f650e93e..279d945d4ebee 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -614,10 +614,10 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "%s (ino=%lu): entry number %llu already freed",
-			  __func__, inode->i_ino,
-			  (unsigned long long)req->pr_entry_nr);
+		nilfs_warn(inode->i_sb,
+			   "%s (ino=%lu): entry number %llu already freed",
+			   __func__, inode->i_ino,
+			   (unsigned long long)req->pr_entry_nr);
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
@@ -655,10 +655,10 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "%s (ino=%lu): entry number %llu already freed",
-			  __func__, inode->i_ino,
-			  (unsigned long long)req->pr_entry_nr);
+		nilfs_warn(inode->i_sb,
+			   "%s (ino=%lu): entry number %llu already freed",
+			   __func__, inode->i_ino,
+			   (unsigned long long)req->pr_entry_nr);
 	else
 		nilfs_palloc_group_desc_add_entries(desc, lock, 1);
 
@@ -764,10 +764,10 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		do {
 			if (!nilfs_clear_bit_atomic(lock, group_offset,
 						    bitmap)) {
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "%s (ino=%lu): entry number %llu already freed",
-					  __func__, inode->i_ino,
-					  (unsigned long long)entry_nrs[j]);
+				nilfs_warn(inode->i_sb,
+					   "%s (ino=%lu): entry number %llu already freed",
+					   __func__, inode->i_ino,
+					   (unsigned long long)entry_nrs[j]);
 			} else {
 				n++;
 			}
@@ -809,10 +809,10 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			ret = nilfs_palloc_delete_entry_block(inode,
 							      last_nrs[k]);
 			if (ret && ret != -ENOENT)
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
-					  ret, (unsigned long long)last_nrs[k],
-					  inode->i_ino);
+				nilfs_warn(inode->i_sb,
+					   "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
+					   ret, (unsigned long long)last_nrs[k],
+					   inode->i_ino);
 		}
 
 		desc_kaddr = kmap_atomic(desc_bh->b_page);
@@ -827,9 +827,9 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		if (nfree == nilfs_palloc_entries_per_group(inode)) {
 			ret = nilfs_palloc_delete_bitmap_block(inode, group);
 			if (ret && ret != -ENOENT)
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "error %d deleting bitmap block of group=%lu, ino=%lu",
-					  ret, group, inode->i_ino);
+				nilfs_warn(inode->i_sb,
+					   "error %d deleting bitmap block of group=%lu, ino=%lu",
+					   ret, group, inode->i_ino);
 		}
 	}
 	return 0;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 1ab5db17e8248..4905b7cd7bf33 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -352,10 +352,10 @@ static int nilfs_btree_node_broken(const struct nilfs_btree_node *node,
 		     (flags & NILFS_BTREE_NODE_ROOT) ||
 		     nchildren < 0 ||
 		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
-			  "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
-			  inode->i_ino, (unsigned long long)blocknr, level,
-			  flags, nchildren);
+		nilfs_crit(inode->i_sb,
+			   "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
+			   inode->i_ino, (unsigned long long)blocknr, level,
+			   flags, nchildren);
 		ret = 1;
 	}
 	return ret;
@@ -382,9 +382,9 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
 		     level >= NILFS_BTREE_LEVEL_MAX ||
 		     nchildren < 0 ||
 		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX)) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
-			  "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
-			  inode->i_ino, level, flags, nchildren);
+		nilfs_crit(inode->i_sb,
+			   "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
+			   inode->i_ino, level, flags, nchildren);
 		ret = 1;
 	}
 	return ret;
@@ -451,10 +451,10 @@ static int nilfs_btree_bad_node(const struct nilfs_bmap *btree,
 {
 	if (unlikely(nilfs_btree_node_get_level(node) != level)) {
 		dump_stack();
-		nilfs_msg(btree->b_inode->i_sb, KERN_CRIT,
-			  "btree level mismatch (ino=%lu): %d != %d",
-			  btree->b_inode->i_ino,
-			  nilfs_btree_node_get_level(node), level);
+		nilfs_crit(btree->b_inode->i_sb,
+			   "btree level mismatch (ino=%lu): %d != %d",
+			   btree->b_inode->i_ino,
+			   nilfs_btree_node_get_level(node), level);
 		return 1;
 	}
 	return 0;
@@ -519,7 +519,7 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 
  out_no_wait:
 	if (!buffer_uptodate(bh)) {
-		nilfs_msg(btree->b_inode->i_sb, KERN_ERR,
+		nilfs_err(btree->b_inode->i_sb,
 			  "I/O error reading b-tree node block (ino=%lu, blocknr=%llu)",
 			  btree->b_inode->i_ino, (unsigned long long)ptr);
 		brelse(bh);
@@ -2094,10 +2094,10 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
 	ret = nilfs_btree_do_lookup(btree, path, key, NULL, level + 1, 0);
 	if (ret < 0) {
 		if (unlikely(ret == -ENOENT))
-			nilfs_msg(btree->b_inode->i_sb, KERN_CRIT,
-				  "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
-				  btree->b_inode->i_ino,
-				  (unsigned long long)key, level);
+			nilfs_crit(btree->b_inode->i_sb,
+				   "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
+				   btree->b_inode->i_ino,
+				   (unsigned long long)key, level);
 		goto out;
 	}
 
@@ -2134,11 +2134,11 @@ static void nilfs_btree_add_dirty_buffer(struct nilfs_bmap *btree,
 	if (level < NILFS_BTREE_LEVEL_NODE_MIN ||
 	    level >= NILFS_BTREE_LEVEL_MAX) {
 		dump_stack();
-		nilfs_msg(btree->b_inode->i_sb, KERN_WARNING,
-			  "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
-			  level, (unsigned long long)key,
-			  btree->b_inode->i_ino,
-			  (unsigned long long)bh->b_blocknr);
+		nilfs_warn(btree->b_inode->i_sb,
+			   "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
+			   level, (unsigned long long)key,
+			   btree->b_inode->i_ino,
+			   (unsigned long long)bh->b_blocknr);
 		return;
 	}
 
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 8d41311b5db4b..86d4d850d1305 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -322,7 +322,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 	int ret, ncps, nicps, nss, count, i;
 
 	if (unlikely(start == 0 || start > end)) {
-		nilfs_msg(cpfile->i_sb, KERN_ERR,
+		nilfs_err(cpfile->i_sb,
 			  "cannot delete checkpoints: invalid range [%llu, %llu)",
 			  (unsigned long long)start, (unsigned long long)end);
 		return -EINVAL;
@@ -376,7 +376,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 								   cpfile, cno);
 					if (ret == 0)
 						continue;
-					nilfs_msg(cpfile->i_sb, KERN_ERR,
+					nilfs_err(cpfile->i_sb,
 						  "error %d deleting checkpoint block",
 						  ret);
 					break;
@@ -981,12 +981,10 @@ int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
 	int err;
 
 	if (cpsize > sb->s_blocksize) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too large checkpoint size: %zu bytes", cpsize);
+		nilfs_err(sb, "too large checkpoint size: %zu bytes", cpsize);
 		return -EINVAL;
 	} else if (cpsize < NILFS_MIN_CHECKPOINT_SIZE) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too small checkpoint size: %zu bytes", cpsize);
+		nilfs_err(sb, "too small checkpoint size: %zu bytes", cpsize);
 		return -EINVAL;
 	}
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index b9c759addd50e..c47e1f6f23a82 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -354,11 +354,11 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 	kaddr = kmap_atomic(entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
 	if (unlikely(entry->de_blocknr == cpu_to_le64(0))) {
-		nilfs_msg(dat->i_sb, KERN_CRIT,
-			  "%s: invalid vblocknr = %llu, [%llu, %llu)",
-			  __func__, (unsigned long long)vblocknr,
-			  (unsigned long long)le64_to_cpu(entry->de_start),
-			  (unsigned long long)le64_to_cpu(entry->de_end));
+		nilfs_crit(dat->i_sb,
+			   "%s: invalid vblocknr = %llu, [%llu, %llu)",
+			   __func__, (unsigned long long)vblocknr,
+			   (unsigned long long)le64_to_cpu(entry->de_start),
+			   (unsigned long long)le64_to_cpu(entry->de_end));
 		kunmap_atomic(kaddr);
 		brelse(entry_bh);
 		return -EINVAL;
@@ -485,11 +485,11 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	int err;
 
 	if (entry_size > sb->s_blocksize) {
-		nilfs_msg(sb, KERN_ERR, "too large DAT entry size: %zu bytes",
+		nilfs_err(sb, "too large DAT entry size: %zu bytes",
 			  entry_size);
 		return -EINVAL;
 	} else if (entry_size < NILFS_MIN_DAT_ENTRY_SIZE) {
-		nilfs_msg(sb, KERN_ERR, "too small DAT entry size: %zu bytes",
+		nilfs_err(sb, "too small DAT entry size: %zu bytes",
 			  entry_size);
 		return -EINVAL;
 	}
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 8d769c5dd5dc6..7faf8c285d6c9 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -333,16 +333,18 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
 
 	key = nilfs_bmap_data_get_key(bmap, *bh);
 	if (unlikely(key > NILFS_DIRECT_KEY_MAX)) {
-		nilfs_msg(bmap->b_inode->i_sb, KERN_CRIT,
-			  "%s (ino=%lu): invalid key: %llu", __func__,
-			  bmap->b_inode->i_ino, (unsigned long long)key);
+		nilfs_crit(bmap->b_inode->i_sb,
+			   "%s (ino=%lu): invalid key: %llu",
+			   __func__,
+			   bmap->b_inode->i_ino, (unsigned long long)key);
 		return -EINVAL;
 	}
 	ptr = nilfs_direct_get_ptr(bmap, key);
 	if (unlikely(ptr == NILFS_BMAP_INVALID_PTR)) {
-		nilfs_msg(bmap->b_inode->i_sb, KERN_CRIT,
-			  "%s (ino=%lu): invalid pointer: %llu", __func__,
-			  bmap->b_inode->i_ino, (unsigned long long)ptr);
+		nilfs_crit(bmap->b_inode->i_sb,
+			   "%s (ino=%lu): invalid pointer: %llu",
+			   __func__,
+			   bmap->b_inode->i_ino, (unsigned long long)ptr);
 		return -EINVAL;
 	}
 
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index cef46650102e7..b0077f5f71124 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -143,7 +143,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer_head *bh)
 	if (!buffer_uptodate(bh)) {
 		struct inode *inode = bh->b_page->mapping->host;
 
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_err(inode->i_sb,
 			  "I/O error reading %s block for GC (ino=%lu, vblocknr=%llu)",
 			  buffer_nilfs_node(bh) ? "node" : "data",
 			  inode->i_ino, (unsigned long long)bh->b_blocknr);
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index 4140d232cadc0..02727ed3a7c6a 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -142,8 +142,8 @@ int nilfs_ifile_get_inode_block(struct inode *ifile, ino_t ino,
 
 	err = nilfs_palloc_get_entry_block(ifile, ino, 0, out_bh);
 	if (unlikely(err))
-		nilfs_msg(sb, KERN_WARNING, "error %d reading inode: ino=%lu",
-			  err, (unsigned long)ino);
+		nilfs_warn(sb, "error %d reading inode: ino=%lu",
+			   err, (unsigned long)ino);
 	return err;
 }
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index ea94dc21af0c9..83dbfd9d25323 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -107,10 +107,10 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 				 * However, the page having this block must
 				 * be locked in this case.
 				 */
-				nilfs_msg(inode->i_sb, KERN_WARNING,
-					  "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
-					  __func__, inode->i_ino,
-					  (unsigned long long)blkoff);
+				nilfs_warn(inode->i_sb,
+					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
+					   __func__, inode->i_ino,
+					   (unsigned long long)blkoff);
 				err = 0;
 			}
 			nilfs_transaction_abort(inode->i_sb);
@@ -862,9 +862,8 @@ static void nilfs_truncate_bmap(struct nilfs_inode_info *ii,
 		goto repeat;
 
 failed:
-	nilfs_msg(ii->vfs_inode.i_sb, KERN_WARNING,
-		  "error %d truncating bmap (ino=%lu)", ret,
-		  ii->vfs_inode.i_ino);
+	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=%lu)",
+		   ret, ii->vfs_inode.i_ino);
 }
 
 void nilfs_truncate(struct inode *inode)
@@ -1097,9 +1096,9 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 			 * This will happen when somebody is freeing
 			 * this inode.
 			 */
-			nilfs_msg(inode->i_sb, KERN_WARNING,
-				  "cannot set file dirty (ino=%lu): the file is being freed",
-				  inode->i_ino);
+			nilfs_warn(inode->i_sb,
+				   "cannot set file dirty (ino=%lu): the file is being freed",
+				   inode->i_ino);
 			spin_unlock(&nilfs->ns_inode_lock);
 			return -EINVAL; /*
 					 * NILFS_I_DIRTY may remain for
@@ -1128,9 +1127,9 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "cannot mark inode dirty (ino=%lu): error %d loading inode block",
-			  inode->i_ino, err);
+		nilfs_warn(inode->i_sb,
+			   "cannot mark inode dirty (ino=%lu): error %d loading inode block",
+			   inode->i_ino, err);
 		return err;
 	}
 	nilfs_update_inode(inode, ibh, flags);
@@ -1156,8 +1155,8 @@ void nilfs_dirty_inode(struct inode *inode, int flags)
 	struct nilfs_mdt_info *mdi = NILFS_MDT(inode);
 
 	if (is_bad_inode(inode)) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "tried to mark bad_inode dirty. ignored.");
+		nilfs_warn(inode->i_sb,
+			   "tried to mark bad_inode dirty. ignored.");
 		dump_stack();
 		return;
 	}
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 83926b9ab4b59..1a266a10d4cf3 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -569,25 +569,25 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
 
 	if (unlikely(ret < 0)) {
 		if (ret == -ENOENT)
-			nilfs_msg(inode->i_sb, KERN_CRIT,
-				  "%s: invalid virtual block address (%s): ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
-				  __func__, vdesc->vd_flags ? "node" : "data",
-				  (unsigned long long)vdesc->vd_ino,
-				  (unsigned long long)vdesc->vd_cno,
-				  (unsigned long long)vdesc->vd_offset,
-				  (unsigned long long)vdesc->vd_blocknr,
-				  (unsigned long long)vdesc->vd_vblocknr);
+			nilfs_crit(inode->i_sb,
+				   "%s: invalid virtual block address (%s): ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
+				   __func__, vdesc->vd_flags ? "node" : "data",
+				   (unsigned long long)vdesc->vd_ino,
+				   (unsigned long long)vdesc->vd_cno,
+				   (unsigned long long)vdesc->vd_offset,
+				   (unsigned long long)vdesc->vd_blocknr,
+				   (unsigned long long)vdesc->vd_vblocknr);
 		return ret;
 	}
 	if (unlikely(!list_empty(&bh->b_assoc_buffers))) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
-			  "%s: conflicting %s buffer: ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
-			  __func__, vdesc->vd_flags ? "node" : "data",
-			  (unsigned long long)vdesc->vd_ino,
-			  (unsigned long long)vdesc->vd_cno,
-			  (unsigned long long)vdesc->vd_offset,
-			  (unsigned long long)vdesc->vd_blocknr,
-			  (unsigned long long)vdesc->vd_vblocknr);
+		nilfs_crit(inode->i_sb,
+			   "%s: conflicting %s buffer: ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
+			   __func__, vdesc->vd_flags ? "node" : "data",
+			   (unsigned long long)vdesc->vd_ino,
+			   (unsigned long long)vdesc->vd_cno,
+			   (unsigned long long)vdesc->vd_offset,
+			   (unsigned long long)vdesc->vd_blocknr,
+			   (unsigned long long)vdesc->vd_vblocknr);
 		brelse(bh);
 		return -EEXIST;
 	}
@@ -837,8 +837,7 @@ int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *nilfs,
 	return 0;
 
  failed:
-	nilfs_msg(nilfs->ns_sb, KERN_ERR, "error %d preparing GC: %s", ret,
-		  msg);
+	nilfs_err(nilfs->ns_sb, "error %d preparing GC: %s", ret, msg);
 	return ret;
 }
 
@@ -947,7 +946,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 
 	ret = nilfs_ioctl_move_blocks(inode->i_sb, &argv[0], kbufs[0]);
 	if (ret < 0) {
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_err(inode->i_sb,
 			  "error %d preparing GC: cannot read source blocks",
 			  ret);
 	} else {
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 7c9055d767d16..e80ef2c0a785c 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -199,7 +199,7 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
  out_no_wait:
 	err = -EIO;
 	if (!buffer_uptodate(first_bh)) {
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_err(inode->i_sb,
 			  "I/O error reading meta-data file (ino=%lu, block-offset=%lu)",
 			  inode->i_ino, block);
 		goto failed_bh;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 9fe6d4ab74f01..a6ec7961d4f5a 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -272,9 +272,9 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	if (!inode->i_nlink) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
-			  "deleting nonexistent file (ino=%lu), %d",
-			  inode->i_ino, inode->i_nlink);
+		nilfs_warn(inode->i_sb,
+			   "deleting nonexistent file (ino=%lu), %d",
+			   inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index dc772eaa13cf1..6b9383ba0049d 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -319,6 +319,15 @@ void __nilfs_error(struct super_block *sb, const char *function,
 
 #endif /* CONFIG_PRINTK */
 
+#define nilfs_crit(sb, fmt, ...)					\
+	nilfs_msg(sb, KERN_CRIT, fmt, ##__VA_ARGS__)
+#define nilfs_err(sb, fmt, ...)						\
+	nilfs_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
+#define nilfs_warn(sb, fmt, ...)					\
+	nilfs_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
+#define nilfs_info(sb, fmt, ...)					\
+	nilfs_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
+
 extern struct nilfs_super_block *
 nilfs_read_super_block(struct super_block *, u64, int, struct buffer_head **);
 extern int nilfs_store_magic_and_option(struct super_block *,
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 108e4528fccd0..fc86cc7a26d72 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -399,9 +399,8 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 	BUG_ON(!PageLocked(page));
 
 	if (!silent)
-		nilfs_msg(sb, KERN_WARNING,
-			  "discard dirty page: offset=%lld, ino=%lu",
-			  page_offset(page), inode->i_ino);
+		nilfs_warn(sb, "discard dirty page: offset=%lld, ino=%lu",
+			   page_offset(page), inode->i_ino);
 
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
@@ -417,9 +416,9 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		do {
 			lock_buffer(bh);
 			if (!silent)
-				nilfs_msg(sb, KERN_WARNING,
-					  "discard dirty block: blocknr=%llu, size=%zu",
-					  (u64)bh->b_blocknr, bh->b_size);
+				nilfs_warn(sb,
+					   "discard dirty block: blocknr=%llu, size=%zu",
+					   (u64)bh->b_blocknr, bh->b_size);
 
 			set_mask_bits(&bh->b_state, clear_bits, 0);
 			unlock_buffer(bh);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 18feb9c7c7066..0923231e9e605 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -51,7 +51,7 @@ static int nilfs_warn_segment_error(struct super_block *sb, int err)
 
 	switch (err) {
 	case NILFS_SEG_FAIL_IO:
-		nilfs_msg(sb, KERN_ERR, "I/O error reading segment");
+		nilfs_err(sb, "I/O error reading segment");
 		return -EIO;
 	case NILFS_SEG_FAIL_MAGIC:
 		msg = "Magic number mismatch";
@@ -72,10 +72,10 @@ static int nilfs_warn_segment_error(struct super_block *sb, int err)
 		msg = "No super root in the last segment";
 		break;
 	default:
-		nilfs_msg(sb, KERN_ERR, "unrecognized segment error %d", err);
+		nilfs_err(sb, "unrecognized segment error %d", err);
 		return -EINVAL;
 	}
-	nilfs_msg(sb, KERN_WARNING, "invalid segment: %s", msg);
+	nilfs_warn(sb, "invalid segment: %s", msg);
 	return -EINVAL;
 }
 
@@ -544,10 +544,10 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 		put_page(page);
 
  failed_inode:
-		nilfs_msg(sb, KERN_WARNING,
-			  "error %d recovering data block (ino=%lu, block-offset=%llu)",
-			  err, (unsigned long)rb->ino,
-			  (unsigned long long)rb->blkoff);
+		nilfs_warn(sb,
+			   "error %d recovering data block (ino=%lu, block-offset=%llu)",
+			   err, (unsigned long)rb->ino,
+			   (unsigned long long)rb->blkoff);
 		if (!err2)
 			err2 = err;
  next:
@@ -670,8 +670,7 @@ static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
 	}
 
 	if (nsalvaged_blocks) {
-		nilfs_msg(sb, KERN_INFO, "salvaged %lu blocks",
-			  nsalvaged_blocks);
+		nilfs_info(sb, "salvaged %lu blocks", nsalvaged_blocks);
 		ri->ri_need_recovery = NILFS_RECOVERY_ROLLFORWARD_DONE;
 	}
  out:
@@ -682,7 +681,7 @@ static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
  confused:
 	err = -EINVAL;
  failed:
-	nilfs_msg(sb, KERN_ERR,
+	nilfs_err(sb,
 		  "error %d roll-forwarding partial segment at blocknr = %llu",
 		  err, (unsigned long long)pseg_start);
 	goto out;
@@ -704,8 +703,8 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	set_buffer_dirty(bh);
 	err = sync_dirty_buffer(bh);
 	if (unlikely(err))
-		nilfs_msg(nilfs->ns_sb, KERN_WARNING,
-			  "buffer sync write failed during post-cleaning of recovery.");
+		nilfs_warn(nilfs->ns_sb,
+			   "buffer sync write failed during post-cleaning of recovery.");
 	brelse(bh);
 }
 
@@ -740,8 +739,7 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 
 	err = nilfs_attach_checkpoint(sb, ri->ri_cno, true, &root);
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_ERR,
-			  "error %d loading the latest checkpoint", err);
+		nilfs_err(sb, "error %d loading the latest checkpoint", err);
 		return err;
 	}
 
@@ -752,8 +750,7 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 	if (ri->ri_need_recovery == NILFS_RECOVERY_ROLLFORWARD_DONE) {
 		err = nilfs_prepare_segment_for_recovery(nilfs, sb, ri);
 		if (unlikely(err)) {
-			nilfs_msg(sb, KERN_ERR,
-				  "error %d preparing segment for recovery",
+			nilfs_err(sb, "error %d preparing segment for recovery",
 				  err);
 			goto failed;
 		}
@@ -767,8 +764,7 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 		nilfs_detach_log_writer(sb);
 
 		if (unlikely(err)) {
-			nilfs_msg(sb, KERN_ERR,
-				  "error %d writing segment for recovery",
+			nilfs_err(sb, "error %d writing segment for recovery",
 				  err);
 			goto failed;
 		}
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index e72466fc8ca93..9f435879a0487 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -511,7 +511,7 @@ static int nilfs_segbuf_wait(struct nilfs_segment_buffer *segbuf)
 	} while (--segbuf->sb_nbio > 0);
 
 	if (unlikely(atomic_read(&segbuf->sb_err) > 0)) {
-		nilfs_msg(segbuf->sb_super, KERN_ERR,
+		nilfs_err(segbuf->sb_super,
 			  "I/O error writing log (start-blocknr=%llu, block-count=%lu) in segment %llu",
 			  (unsigned long long)segbuf->sb_pseg_start,
 			  segbuf->sb_sum.nblocks,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7d1860d33723e..d4610f71d21b7 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -158,7 +158,7 @@ static int nilfs_prepare_segment_lock(struct super_block *sb,
 		 * it is saved and will be restored on
 		 * nilfs_transaction_commit().
 		 */
-		nilfs_msg(sb, KERN_WARNING, "journal info from a different FS");
+		nilfs_warn(sb, "journal info from a different FS");
 		save = current->journal_info;
 	}
 	if (!ti) {
@@ -1983,9 +1983,9 @@ static int nilfs_segctor_collect_dirty_files(struct nilfs_sc_info *sci,
 			err = nilfs_ifile_get_inode_block(
 				ifile, ii->vfs_inode.i_ino, &ibh);
 			if (unlikely(err)) {
-				nilfs_msg(sci->sc_super, KERN_WARNING,
-					  "log writer: error %d getting inode block (ino=%lu)",
-					  err, ii->vfs_inode.i_ino);
+				nilfs_warn(sci->sc_super,
+					   "log writer: error %d getting inode block (ino=%lu)",
+					   err, ii->vfs_inode.i_ino);
 				return err;
 			}
 			spin_lock(&nilfs->ns_inode_lock);
@@ -2495,7 +2495,7 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 		if (likely(!err))
 			break;
 
-		nilfs_msg(sb, KERN_WARNING, "error %d cleaning segments", err);
+		nilfs_warn(sb, "error %d cleaning segments", err);
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(sci->sc_interval);
 	}
@@ -2503,9 +2503,9 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 		int ret = nilfs_discard_segments(nilfs, sci->sc_freesegs,
 						 sci->sc_nfreesegs);
 		if (ret) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "error %d on discard request, turning discards off for the device",
-				  ret);
+			nilfs_warn(sb,
+				   "error %d on discard request, turning discards off for the device",
+				   ret);
 			nilfs_clear_opt(nilfs, DISCARD);
 		}
 	}
@@ -2586,9 +2586,9 @@ static int nilfs_segctor_thread(void *arg)
 	/* start sync. */
 	sci->sc_task = current;
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_start_thread() */
-	nilfs_msg(sci->sc_super, KERN_INFO,
-		  "segctord starting. Construction interval = %lu seconds, CP frequency < %lu seconds",
-		  sci->sc_interval / HZ, sci->sc_mjcp_freq / HZ);
+	nilfs_info(sci->sc_super,
+		   "segctord starting. Construction interval = %lu seconds, CP frequency < %lu seconds",
+		   sci->sc_interval / HZ, sci->sc_mjcp_freq / HZ);
 
 	spin_lock(&sci->sc_state_lock);
  loop:
@@ -2661,8 +2661,8 @@ static int nilfs_segctor_start_thread(struct nilfs_sc_info *sci)
 	if (IS_ERR(t)) {
 		int err = PTR_ERR(t);
 
-		nilfs_msg(sci->sc_super, KERN_ERR,
-			  "error %d creating segctord thread", err);
+		nilfs_err(sci->sc_super, "error %d creating segctord thread",
+			  err);
 		return err;
 	}
 	wait_event(sci->sc_wait_task, sci->sc_task != NULL);
@@ -2772,14 +2772,14 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 		nilfs_segctor_write_out(sci);
 
 	if (!list_empty(&sci->sc_dirty_files)) {
-		nilfs_msg(sci->sc_super, KERN_WARNING,
-			  "disposed unprocessed dirty file(s) when stopping log writer");
+		nilfs_warn(sci->sc_super,
+			   "disposed unprocessed dirty file(s) when stopping log writer");
 		nilfs_dispose_list(nilfs, &sci->sc_dirty_files, 1);
 	}
 
 	if (!list_empty(&sci->sc_iput_queue)) {
-		nilfs_msg(sci->sc_super, KERN_WARNING,
-			  "disposed unprocessed inode(s) in iput queue when stopping log writer");
+		nilfs_warn(sci->sc_super,
+			   "disposed unprocessed inode(s) in iput queue when stopping log writer");
 		nilfs_dispose_list(nilfs, &sci->sc_iput_queue, 1);
 	}
 
@@ -2858,8 +2858,8 @@ void nilfs_detach_log_writer(struct super_block *sb)
 	spin_lock(&nilfs->ns_inode_lock);
 	if (!list_empty(&nilfs->ns_dirty_files)) {
 		list_splice_init(&nilfs->ns_dirty_files, &garbage_list);
-		nilfs_msg(sb, KERN_WARNING,
-			  "disposed unprocessed dirty file(s) when detaching log writer");
+		nilfs_warn(sb,
+			   "disposed unprocessed dirty file(s) when detaching log writer");
 	}
 	spin_unlock(&nilfs->ns_inode_lock);
 	up_write(&nilfs->ns_segctor_sem);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 4626540008c13..379db0c54227f 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -171,9 +171,9 @@ int nilfs_sufile_updatev(struct inode *sufile, __u64 *segnumv, size_t nsegs,
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	for (seg = segnumv; seg < segnumv + nsegs; seg++) {
 		if (unlikely(*seg >= nilfs_sufile_get_nsegments(sufile))) {
-			nilfs_msg(sufile->i_sb, KERN_WARNING,
-				  "%s: invalid segment number: %llu",
-				  __func__, (unsigned long long)*seg);
+			nilfs_warn(sufile->i_sb,
+				   "%s: invalid segment number: %llu",
+				   __func__, (unsigned long long)*seg);
 			nerr++;
 		}
 	}
@@ -230,9 +230,8 @@ int nilfs_sufile_update(struct inode *sufile, __u64 segnum, int create,
 	int ret;
 
 	if (unlikely(segnum >= nilfs_sufile_get_nsegments(sufile))) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
-			  "%s: invalid segment number: %llu",
-			  __func__, (unsigned long long)segnum);
+		nilfs_warn(sufile->i_sb, "%s: invalid segment number: %llu",
+			   __func__, (unsigned long long)segnum);
 		return -EINVAL;
 	}
 	down_write(&NILFS_MDT(sufile)->mi_sem);
@@ -410,9 +409,8 @@ void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
 	kaddr = kmap_atomic(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (unlikely(!nilfs_segment_usage_clean(su))) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
-			  "%s: segment %llu must be clean", __func__,
-			  (unsigned long long)segnum);
+		nilfs_warn(sufile->i_sb, "%s: segment %llu must be clean",
+			   __func__, (unsigned long long)segnum);
 		kunmap_atomic(kaddr);
 		return;
 	}
@@ -468,9 +466,8 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 	kaddr = kmap_atomic(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (nilfs_segment_usage_clean(su)) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
-			  "%s: segment %llu is already clean",
-			  __func__, (unsigned long long)segnum);
+		nilfs_warn(sufile->i_sb, "%s: segment %llu is already clean",
+			   __func__, (unsigned long long)segnum);
 		kunmap_atomic(kaddr);
 		return;
 	}
@@ -1213,12 +1210,12 @@ int nilfs_sufile_read(struct super_block *sb, size_t susize,
 	int err;
 
 	if (susize > sb->s_blocksize) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too large segment usage size: %zu bytes", susize);
+		nilfs_err(sb, "too large segment usage size: %zu bytes",
+			  susize);
 		return -EINVAL;
 	} else if (susize < NILFS_MIN_SEGMENT_USAGE_SIZE) {
-		nilfs_msg(sb, KERN_ERR,
-			  "too small segment usage size: %zu bytes", susize);
+		nilfs_err(sb, "too small segment usage size: %zu bytes",
+			  susize);
 		return -EINVAL;
 	}
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 2263ebedf9d58..59e74e764cd27 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -106,7 +106,7 @@ static void nilfs_set_error(struct super_block *sb)
  *
  * This implements the body of nilfs_error() macro.  Normally,
  * nilfs_error() should be used.  As for sustainable errors such as a
- * single-shot I/O error, nilfs_msg() should be used instead.
+ * single-shot I/O error, nilfs_err() should be used instead.
  *
  * Callers should not add a trailing newline since this will do it.
  */
@@ -179,8 +179,7 @@ static int nilfs_sync_super(struct super_block *sb, int flag)
 	}
 
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_ERR, "unable to write superblock: err=%d",
-			  err);
+		nilfs_err(sb, "unable to write superblock: err=%d", err);
 		if (err == -EIO && nilfs->ns_sbh[1]) {
 			/*
 			 * sbp[0] points to newer log than sbp[1],
@@ -250,7 +249,7 @@ struct nilfs_super_block **nilfs_prepare_super(struct super_block *sb,
 		    sbp[1]->s_magic == cpu_to_le16(NILFS_SUPER_MAGIC)) {
 			memcpy(sbp[0], sbp[1], nilfs->ns_sbsize);
 		} else {
-			nilfs_msg(sb, KERN_CRIT, "superblock broke");
+			nilfs_crit(sb, "superblock broke");
 			return NULL;
 		}
 	} else if (sbp[1] &&
@@ -360,9 +359,9 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 	offset = sb2off & (nilfs->ns_blocksize - 1);
 	nsbh = sb_getblk(sb, newblocknr);
 	if (!nsbh) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "unable to move secondary superblock to block %llu",
-			  (unsigned long long)newblocknr);
+		nilfs_warn(sb,
+			   "unable to move secondary superblock to block %llu",
+			   (unsigned long long)newblocknr);
 		ret = -EIO;
 		goto out;
 	}
@@ -556,7 +555,7 @@ int nilfs_attach_checkpoint(struct super_block *sb, __u64 cno, int curr_mnt,
 	up_read(&nilfs->ns_segctor_sem);
 	if (unlikely(err)) {
 		if (err == -ENOENT || err == -EINVAL) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "Invalid checkpoint (checkpoint number=%llu)",
 				  (unsigned long long)cno);
 			err = -EINVAL;
@@ -654,8 +653,7 @@ static int nilfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	err = nilfs_ifile_count_free_inodes(root->ifile,
 					    &nmaxinodes, &nfreeinodes);
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "failed to count free inodes: err=%d", err);
+		nilfs_warn(sb, "failed to count free inodes: err=%d", err);
 		if (err == -ERANGE) {
 			/*
 			 * If nilfs_palloc_count_max_entries() returns
@@ -787,7 +785,7 @@ static int parse_options(char *options, struct super_block *sb, int is_remount)
 			break;
 		case Opt_snapshot:
 			if (is_remount) {
-				nilfs_msg(sb, KERN_ERR,
+				nilfs_err(sb,
 					  "\"%s\" option is invalid for remount",
 					  p);
 				return 0;
@@ -803,8 +801,7 @@ static int parse_options(char *options, struct super_block *sb, int is_remount)
 			nilfs_clear_opt(nilfs, DISCARD);
 			break;
 		default:
-			nilfs_msg(sb, KERN_ERR,
-				  "unrecognized mount option \"%s\"", p);
+			nilfs_err(sb, "unrecognized mount option \"%s\"", p);
 			return 0;
 		}
 	}
@@ -840,10 +837,10 @@ static int nilfs_setup_super(struct super_block *sb, int is_mount)
 	mnt_count = le16_to_cpu(sbp[0]->s_mnt_count);
 
 	if (nilfs->ns_mount_state & NILFS_ERROR_FS) {
-		nilfs_msg(sb, KERN_WARNING, "mounting fs with errors");
+		nilfs_warn(sb, "mounting fs with errors");
 #if 0
 	} else if (max_mnt_count >= 0 && mnt_count >= max_mnt_count) {
-		nilfs_msg(sb, KERN_WARNING, "maximal mount count reached");
+		nilfs_warn(sb, "maximal mount count reached");
 #endif
 	}
 	if (!max_mnt_count)
@@ -906,7 +903,7 @@ int nilfs_check_feature_compatibility(struct super_block *sb,
 	features = le64_to_cpu(sbp->s_feature_incompat) &
 		~NILFS_FEATURE_INCOMPAT_SUPP;
 	if (features) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "couldn't mount because of unsupported optional features (%llx)",
 			  (unsigned long long)features);
 		return -EINVAL;
@@ -914,7 +911,7 @@ int nilfs_check_feature_compatibility(struct super_block *sb,
 	features = le64_to_cpu(sbp->s_feature_compat_ro) &
 		~NILFS_FEATURE_COMPAT_RO_SUPP;
 	if (!sb_rdonly(sb) && features) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "couldn't mount RDWR because of unsupported optional features (%llx)",
 			  (unsigned long long)features);
 		return -EINVAL;
@@ -933,12 +930,12 @@ static int nilfs_get_root_dentry(struct super_block *sb,
 	inode = nilfs_iget(sb, root, NILFS_ROOT_INO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		nilfs_msg(sb, KERN_ERR, "error %d getting root inode", ret);
+		nilfs_err(sb, "error %d getting root inode", ret);
 		goto out;
 	}
 	if (!S_ISDIR(inode->i_mode) || !inode->i_blocks || !inode->i_size) {
 		iput(inode);
-		nilfs_msg(sb, KERN_ERR, "corrupt root inode");
+		nilfs_err(sb, "corrupt root inode");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -966,7 +963,7 @@ static int nilfs_get_root_dentry(struct super_block *sb,
 	return ret;
 
  failed_dentry:
-	nilfs_msg(sb, KERN_ERR, "error %d getting root dentry", ret);
+	nilfs_err(sb, "error %d getting root dentry", ret);
 	goto out;
 }
 
@@ -986,7 +983,7 @@ static int nilfs_attach_snapshot(struct super_block *s, __u64 cno,
 		ret = (ret == -ENOENT) ? -EINVAL : ret;
 		goto out;
 	} else if (!ret) {
-		nilfs_msg(s, KERN_ERR,
+		nilfs_err(s,
 			  "The specified checkpoint is not a snapshot (checkpoint number=%llu)",
 			  (unsigned long long)cno);
 		ret = -EINVAL;
@@ -995,7 +992,7 @@ static int nilfs_attach_snapshot(struct super_block *s, __u64 cno,
 
 	ret = nilfs_attach_checkpoint(s, cno, false, &root);
 	if (ret) {
-		nilfs_msg(s, KERN_ERR,
+		nilfs_err(s,
 			  "error %d while loading snapshot (checkpoint number=%llu)",
 			  ret, (unsigned long long)cno);
 		goto out;
@@ -1092,7 +1089,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	cno = nilfs_last_cno(nilfs);
 	err = nilfs_attach_checkpoint(sb, cno, true, &fsroot);
 	if (err) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "error %d while loading last checkpoint (checkpoint number=%llu)",
 			  err, (unsigned long long)cno);
 		goto failed_unload;
@@ -1155,8 +1152,8 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 	err = -EINVAL;
 
 	if (!nilfs_valid_fs(nilfs)) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "couldn't remount because the filesystem is in an incomplete recovery state");
+		nilfs_warn(sb,
+			   "couldn't remount because the filesystem is in an incomplete recovery state");
 		goto restore_opts;
 	}
 
@@ -1186,9 +1183,9 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 			~NILFS_FEATURE_COMPAT_RO_SUPP;
 		up_read(&nilfs->ns_sem);
 		if (features) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "couldn't remount RDWR because of unsupported optional features (%llx)",
-				  (unsigned long long)features);
+			nilfs_warn(sb,
+				   "couldn't remount RDWR because of unsupported optional features (%llx)",
+				   (unsigned long long)features);
 			err = -EROFS;
 			goto restore_opts;
 		}
@@ -1247,7 +1244,7 @@ static int nilfs_parse_snapshot_option(const char *option,
 	return 0;
 
 parse_error:
-	nilfs_msg(NULL, KERN_ERR, "invalid option \"%s\": %s", option, msg);
+	nilfs_err(NULL, "invalid option \"%s\": %s", option, msg);
 	return 1;
 }
 
@@ -1350,7 +1347,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	} else if (!sd.cno) {
 		if (nilfs_tree_is_busy(s->s_root)) {
 			if ((flags ^ s->s_flags) & SB_RDONLY) {
-				nilfs_msg(s, KERN_ERR,
+				nilfs_err(s,
 					  "the device already has a %s mount.",
 					  sb_rdonly(s) ? "read-only" : "read/write");
 				err = -EBUSY;
diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 28a2db3b1787f..57afd06db62de 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -261,8 +261,8 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
 	err = nilfs_cpfile_get_stat(nilfs->ns_cpfile, &cpstat);
 	up_read(&nilfs->ns_segctor_sem);
 	if (err < 0) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to get checkpoint stat: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to get checkpoint stat: err=%d",
+			  err);
 		return err;
 	}
 
@@ -284,8 +284,8 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
 	err = nilfs_cpfile_get_stat(nilfs->ns_cpfile, &cpstat);
 	up_read(&nilfs->ns_segctor_sem);
 	if (err < 0) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to get checkpoint stat: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to get checkpoint stat: err=%d",
+			  err);
 		return err;
 	}
 
@@ -403,8 +403,8 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
 	err = nilfs_sufile_get_stat(nilfs->ns_sufile, &sustat);
 	up_read(&nilfs->ns_segctor_sem);
 	if (err < 0) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to get segment stat: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to get segment stat: err=%d",
+			  err);
 		return err;
 	}
 
@@ -777,15 +777,15 @@ nilfs_superblock_sb_update_frequency_store(struct nilfs_superblock_attr *attr,
 
 	err = kstrtouint(skip_spaces(buf), 0, &val);
 	if (err) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "unable to convert string: err=%d", err);
+		nilfs_err(nilfs->ns_sb, "unable to convert string: err=%d",
+			  err);
 		return err;
 	}
 
 	if (val < NILFS_SB_FREQ) {
 		val = NILFS_SB_FREQ;
-		nilfs_msg(nilfs->ns_sb, KERN_WARNING,
-			  "superblock update frequency cannot be lesser than 10 seconds");
+		nilfs_warn(nilfs->ns_sb,
+			   "superblock update frequency cannot be lesser than 10 seconds");
 	}
 
 	down_write(&nilfs->ns_sem);
@@ -988,8 +988,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	nilfs->ns_dev_subgroups = kzalloc(devgrp_size, GFP_KERNEL);
 	if (unlikely(!nilfs->ns_dev_subgroups)) {
 		err = -ENOMEM;
-		nilfs_msg(sb, KERN_ERR,
-			  "unable to allocate memory for device group");
+		nilfs_err(sb, "unable to allocate memory for device group");
 		goto failed_create_device_group;
 	}
 
@@ -1098,15 +1097,13 @@ int __init nilfs_sysfs_init(void)
 	nilfs_kset = kset_create_and_add(NILFS_ROOT_GROUP_NAME, NULL, fs_kobj);
 	if (!nilfs_kset) {
 		err = -ENOMEM;
-		nilfs_msg(NULL, KERN_ERR,
-			  "unable to create sysfs entry: err=%d", err);
+		nilfs_err(NULL, "unable to create sysfs entry: err=%d", err);
 		goto failed_sysfs_init;
 	}
 
 	err = sysfs_create_group(&nilfs_kset->kobj, &nilfs_feature_attr_group);
 	if (unlikely(err)) {
-		nilfs_msg(NULL, KERN_ERR,
-			  "unable to create feature group: err=%d", err);
+		nilfs_err(NULL, "unable to create feature group: err=%d", err);
 		goto cleanup_sysfs_init;
 	}
 
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index c8d869bc25b0c..0480034644aa7 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -183,7 +183,7 @@ static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
 		nilfs_get_segnum_of_block(nilfs, nilfs->ns_last_pseg);
 	nilfs->ns_cno = nilfs->ns_last_cno + 1;
 	if (nilfs->ns_segnum >= nilfs->ns_nsegments) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+		nilfs_err(nilfs->ns_sb,
 			  "pointed segment number is out of range: segnum=%llu, nsegments=%lu",
 			  (unsigned long long)nilfs->ns_segnum,
 			  nilfs->ns_nsegments);
@@ -210,12 +210,12 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	int err;
 
 	if (!valid_fs) {
-		nilfs_msg(sb, KERN_WARNING, "mounting unchecked fs");
+		nilfs_warn(sb, "mounting unchecked fs");
 		if (s_flags & SB_RDONLY) {
-			nilfs_msg(sb, KERN_INFO,
-				  "recovery required for readonly filesystem");
-			nilfs_msg(sb, KERN_INFO,
-				  "write access will be enabled during recovery");
+			nilfs_info(sb,
+				   "recovery required for readonly filesystem");
+			nilfs_info(sb,
+				   "write access will be enabled during recovery");
 		}
 	}
 
@@ -230,12 +230,11 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 			goto scan_error;
 
 		if (!nilfs_valid_sb(sbp[1])) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "unable to fall back to spare super block");
+			nilfs_warn(sb,
+				   "unable to fall back to spare super block");
 			goto scan_error;
 		}
-		nilfs_msg(sb, KERN_INFO,
-			  "trying rollback from an earlier position");
+		nilfs_info(sb, "trying rollback from an earlier position");
 
 		/*
 		 * restore super block with its spare and reconfigure
@@ -248,9 +247,9 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 		/* verify consistency between two super blocks */
 		blocksize = BLOCK_SIZE << le32_to_cpu(sbp[0]->s_log_block_size);
 		if (blocksize != nilfs->ns_blocksize) {
-			nilfs_msg(sb, KERN_WARNING,
-				  "blocksize differs between two super blocks (%d != %d)",
-				  blocksize, nilfs->ns_blocksize);
+			nilfs_warn(sb,
+				   "blocksize differs between two super blocks (%d != %d)",
+				   blocksize, nilfs->ns_blocksize);
 			goto scan_error;
 		}
 
@@ -269,8 +268,7 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 
 	err = nilfs_load_super_root(nilfs, sb, ri.ri_super_root);
 	if (unlikely(err)) {
-		nilfs_msg(sb, KERN_ERR, "error %d while loading super root",
-			  err);
+		nilfs_err(sb, "error %d while loading super root", err);
 		goto failed;
 	}
 
@@ -285,28 +283,28 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 		__u64 features;
 
 		if (nilfs_test_opt(nilfs, NORECOVERY)) {
-			nilfs_msg(sb, KERN_INFO,
-				  "norecovery option specified, skipping roll-forward recovery");
+			nilfs_info(sb,
+				   "norecovery option specified, skipping roll-forward recovery");
 			goto skip_recovery;
 		}
 		features = le64_to_cpu(nilfs->ns_sbp[0]->s_feature_compat_ro) &
 			~NILFS_FEATURE_COMPAT_RO_SUPP;
 		if (features) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "couldn't proceed with recovery because of unsupported optional features (%llx)",
 				  (unsigned long long)features);
 			err = -EROFS;
 			goto failed_unload;
 		}
 		if (really_read_only) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "write access unavailable, cannot proceed");
 			err = -EROFS;
 			goto failed_unload;
 		}
 		sb->s_flags &= ~SB_RDONLY;
 	} else if (nilfs_test_opt(nilfs, NORECOVERY)) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "recovery cancelled because norecovery option was specified for a read/write mount");
 		err = -EINVAL;
 		goto failed_unload;
@@ -322,12 +320,12 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	up_write(&nilfs->ns_sem);
 
 	if (err) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "error %d updating super block. recovery unfinished.",
 			  err);
 		goto failed_unload;
 	}
-	nilfs_msg(sb, KERN_INFO, "recovery complete");
+	nilfs_info(sb, "recovery complete");
 
  skip_recovery:
 	nilfs_clear_recovery_info(&ri);
@@ -335,7 +333,7 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	return 0;
 
  scan_error:
-	nilfs_msg(sb, KERN_ERR, "error %d while searching super root", err);
+	nilfs_err(sb, "error %d while searching super root", err);
 	goto failed;
 
  failed_unload:
@@ -399,7 +397,7 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 	u64 nsegments, nblocks;
 
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
 			  le32_to_cpu(sbp->s_rev_level),
 			  le16_to_cpu(sbp->s_minor_rev_level),
@@ -412,13 +410,11 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 
 	nilfs->ns_inode_size = le16_to_cpu(sbp->s_inode_size);
 	if (nilfs->ns_inode_size > nilfs->ns_blocksize) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "too large inode size: %d bytes",
+		nilfs_err(nilfs->ns_sb, "too large inode size: %d bytes",
 			  nilfs->ns_inode_size);
 		return -EINVAL;
 	} else if (nilfs->ns_inode_size < NILFS_MIN_INODE_SIZE) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "too small inode size: %d bytes",
+		nilfs_err(nilfs->ns_sb, "too small inode size: %d bytes",
 			  nilfs->ns_inode_size);
 		return -EINVAL;
 	}
@@ -427,8 +423,7 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 
 	nilfs->ns_blocks_per_segment = le32_to_cpu(sbp->s_blocks_per_segment);
 	if (nilfs->ns_blocks_per_segment < NILFS_SEG_MIN_BLOCKS) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
-			  "too short segment: %lu blocks",
+		nilfs_err(nilfs->ns_sb, "too short segment: %lu blocks",
 			  nilfs->ns_blocks_per_segment);
 		return -EINVAL;
 	}
@@ -438,7 +433,7 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		le32_to_cpu(sbp->s_r_segments_percentage);
 	if (nilfs->ns_r_segments_percentage < 1 ||
 	    nilfs->ns_r_segments_percentage > 99) {
-		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+		nilfs_err(nilfs->ns_sb,
 			  "invalid reserved segments percentage: %lu",
 			  nilfs->ns_r_segments_percentage);
 		return -EINVAL;
@@ -580,16 +575,16 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 
 	if (!sbp[0]) {
 		if (!sbp[1]) {
-			nilfs_msg(sb, KERN_ERR, "unable to read superblock");
+			nilfs_err(sb, "unable to read superblock");
 			return -EIO;
 		}
-		nilfs_msg(sb, KERN_WARNING,
-			  "unable to read primary superblock (blocksize = %d)",
-			  blocksize);
+		nilfs_warn(sb,
+			   "unable to read primary superblock (blocksize = %d)",
+			   blocksize);
 	} else if (!sbp[1]) {
-		nilfs_msg(sb, KERN_WARNING,
-			  "unable to read secondary superblock (blocksize = %d)",
-			  blocksize);
+		nilfs_warn(sb,
+			   "unable to read secondary superblock (blocksize = %d)",
+			   blocksize);
 	}
 
 	/*
@@ -611,14 +606,14 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
 	}
 	if (!valid[swp]) {
 		nilfs_release_super_block(nilfs);
-		nilfs_msg(sb, KERN_ERR, "couldn't find nilfs on the device");
+		nilfs_err(sb, "couldn't find nilfs on the device");
 		return -EINVAL;
 	}
 
 	if (!valid[!swp])
-		nilfs_msg(sb, KERN_WARNING,
-			  "broken superblock, retrying with spare superblock (blocksize = %d)",
-			  blocksize);
+		nilfs_warn(sb,
+			   "broken superblock, retrying with spare superblock (blocksize = %d)",
+			   blocksize);
 	if (swp)
 		nilfs_swap_super_block(nilfs);
 
@@ -652,7 +647,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 
 	blocksize = sb_min_blocksize(sb, NILFS_MIN_BLOCK_SIZE);
 	if (!blocksize) {
-		nilfs_msg(sb, KERN_ERR, "unable to set blocksize");
+		nilfs_err(sb, "unable to set blocksize");
 		err = -EINVAL;
 		goto out;
 	}
@@ -671,7 +666,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbp->s_log_block_size);
 	if (blocksize < NILFS_MIN_BLOCK_SIZE ||
 	    blocksize > NILFS_MAX_BLOCK_SIZE) {
-		nilfs_msg(sb, KERN_ERR,
+		nilfs_err(sb,
 			  "couldn't mount because of unsupported filesystem blocksize %d",
 			  blocksize);
 		err = -EINVAL;
@@ -681,7 +676,7 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 		int hw_blocksize = bdev_logical_block_size(sb->s_bdev);
 
 		if (blocksize < hw_blocksize) {
-			nilfs_msg(sb, KERN_ERR,
+			nilfs_err(sb,
 				  "blocksize %d too small for device (sector-size = %d)",
 				  blocksize, hw_blocksize);
 			err = -EINVAL;
-- 
2.43.0




