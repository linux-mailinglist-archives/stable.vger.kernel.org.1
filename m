Return-Path: <stable+bounces-178468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E657B47ECA
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBFA17E9DF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52F212560;
	Sun,  7 Sep 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGv5mM3z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840417BB21;
	Sun,  7 Sep 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276930; cv=none; b=Iqa6oJeixqBUhLH0ARcSRe3vkZbbmU6sPY0rgdyHzVV4RgB9sp8GmMOORZKxWHB/0LspdVOcUGXOqTUtdu9LvpQSGLSUK5M+uKJtcPiPKHqwiE2Oki5zUtSBUhVDHLU0XuJVBp0DMCADUGB52xnE4L2hE3DON0rw2p/hox4BNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276930; c=relaxed/simple;
	bh=xsTMKPi3p57CPk05Bi3VbR+zRAQRQuy7zB4Q3+4E5go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISsVh+E+q2IXTChDqUUnvuVwKYivpsz2UcUdPdYVEIfDuD0uovsy/egCz51FPSYNdtPAk/J8oVjFJyXITZSN9eob6v7DrMR7MqoG/SVrqD/PQr7nVwlThBw2knxLBOhUJ33V2pE8kk4C+uPuDKwSrgUQ+SZc6P9mtb1m6aBfeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HGv5mM3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191C4C4CEF0;
	Sun,  7 Sep 2025 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276930;
	bh=xsTMKPi3p57CPk05Bi3VbR+zRAQRQuy7zB4Q3+4E5go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGv5mM3zR1AYMiERw531k+RFQ/tmMycMuUhBGNT0HHcC9O5gDFn2mIyLnoHKKGKjI
	 j/EoCCH9eBRxs4K3fmQ7imFLfsabRukn0sML1eli5eJXqZonxLGeAWYwHtolmzGRVn
	 fJ+5xgPlOkvH9hHHl2DWYD+d0f72yyBK1cKZTX8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 006/175] btrfs: fix race between setting last_dir_index_offset and inode logging
Date: Sun,  7 Sep 2025 21:56:41 +0200
Message-ID: <20250907195615.040343365@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 59a0dd4ab98970086fd096281b1606c506ff2698 ]

At inode_logged() if we find that the inode was not logged before we
update its ->last_dir_index_offset to (u64)-1 with the goal that the
next directory log operation will see the (u64)-1 and then figure out
it must check what was the index of the last logged dir index key and
update ->last_dir_index_offset to that key's offset (this is done in
update_last_dir_index_offset()).

This however has a possibility for a time window where a race can happen
and lead to directory logging skipping dir index keys that should be
logged. The race happens like this:

1) Task A calls inode_logged(), sees ->logged_trans as 0 and then checks
   that the inode item was logged before, but before it sets the inode's
   ->last_dir_index_offset to (u64)-1...

2) Task B is at btrfs_log_inode() which calls inode_logged() early, and
   that has set ->last_dir_index_offset to (u64)-1;

3) Task B then enters log_directory_changes() which calls
   update_last_dir_index_offset(). There it sees ->last_dir_index_offset
   is (u64)-1 and that the inode was logged before (ctx->logged_before is
   true), and so it searches for the last logged dir index key in the log
   tree and it finds that it has an offset (index) value of N, so it sets
   ->last_dir_index_offset to N, so that we can skip index keys that are
   less than or equal to N (later at process_dir_items_leaf());

4) Task A now sets ->last_dir_index_offset to (u64)-1, undoing the update
   that task B just did;

5) Task B will now skip every index key when it enters
   process_dir_items_leaf(), since ->last_dir_index_offset is (u64)-1.

Fix this by making inode_logged() not touch ->last_dir_index_offset and
initializing it to 0 when an inode is loaded (at btrfs_alloc_inode()) and
then having update_last_dir_index_offset() treat a value of 0 as meaning
we must check the log tree and update with the index of the last logged
index key. This is fine since the minimum possible value for
->last_dir_index_offset is 1 (BTRFS_DIR_START_INDEX - 1 = 2 - 1 = 1).
This also simplifies the management of ->last_dir_index_offset and now
all accesses to it are done under the inode's log_mutex.

Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link when possible")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/tree-log.c    | 17 ++---------------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index db53a3263fbd0..89f582612fb99 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -247,7 +247,7 @@ struct btrfs_inode {
 		u64 new_delalloc_bytes;
 		/*
 		 * The offset of the last dir index key that was logged.
-		 * This is used only for directories.
+		 * This is used only for directories. Protected by 'log_mutex'.
 		 */
 		u64 last_dir_index_offset;
 	};
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f84e3f9fad84a..98d087a14be5e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7767,6 +7767,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_sub_trans = 0;
 	ei->logged_trans = 0;
 	ei->delalloc_bytes = 0;
+	/* new_delalloc_bytes and last_dir_index_offset are in a union. */
 	ei->new_delalloc_bytes = 0;
 	ei->defrag_bytes = 0;
 	ei->disk_i_size = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index bf5d7e52467ac..dc4c9fb0c0113 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3448,19 +3448,6 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	inode->logged_trans = trans->transid;
 	spin_unlock(&inode->lock);
 
-	/*
-	 * If it's a directory, then we must set last_dir_index_offset to the
-	 * maximum possible value, so that the next attempt to log the inode does
-	 * not skip checking if dir index keys found in modified subvolume tree
-	 * leaves have been logged before, otherwise it would result in attempts
-	 * to insert duplicate dir index keys in the log tree. This must be done
-	 * because last_dir_index_offset is an in-memory only field, not persisted
-	 * in the inode item or any other on-disk structure, so its value is lost
-	 * once the inode is evicted.
-	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode))
-		inode->last_dir_index_offset = (u64)-1;
-
 	return 1;
 }
 
@@ -4052,7 +4039,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 
 /*
  * If the inode was logged before and it was evicted, then its
- * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * last_dir_index_offset is 0, so we don't know the value of the last index
  * key offset. If that's the case, search for it and update the inode. This
  * is to avoid lookups in the log tree every time we try to insert a dir index
  * key from a leaf changed in the current transaction, and to allow us to always
@@ -4068,7 +4055,7 @@ static int update_last_dir_index_offset(struct btrfs_inode *inode,
 
 	lockdep_assert_held(&inode->log_mutex);
 
-	if (inode->last_dir_index_offset != (u64)-1)
+	if (inode->last_dir_index_offset != 0)
 		return 0;
 
 	if (!ctx->logged_before) {
-- 
2.50.1




