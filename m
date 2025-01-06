Return-Path: <stable+bounces-106994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC2A0299C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8C516455E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E514900B;
	Mon,  6 Jan 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCHimMUZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC0157E82;
	Mon,  6 Jan 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177134; cv=none; b=jqVgy1sjXsfcS+aUtr6JmK2lpsFp5ibCkARTYvGRDPdREMEU33Ye3RvC675E5iuuFJuucHoFVEWl3LXagX2ADX4pCHN42DkRYae5w691GQDVhtQ7zbhJPv+qVOXChRfWJzJ2vFJ+krPYkzd0mLtRULVBXR4sMzpTag0kEuwnBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177134; c=relaxed/simple;
	bh=y2j0dLQCf14AuUd+VRKAQRlG0UcoodKSpmaL0PfEzWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnIW/egJNGf9sWMXZqQ/eEXhpJYPTcUG5N+sYxJtqt3C5/gPgxvAAbnKZ8rUNy2/psg00GgxOq/pFC74JZM7VX8DYKuXHfyya6VryPztEEq99yP7qe3bqCOC8NkUPbcIL92914hkXlxAQya4t+mla6eWmDYV5N/UYoyW+JoNWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCHimMUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4D1C4CED2;
	Mon,  6 Jan 2025 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177133;
	bh=y2j0dLQCf14AuUd+VRKAQRlG0UcoodKSpmaL0PfEzWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCHimMUZnvmO+xvxbfGqS7HGgvgnJ/82utI3kKKYpZWCEwC+izAfA9zx+Hrqv6J8K
	 BEllXwMHInitXWdAJNzIwvaHbgz3nBQyEPrEaIWWdduLvlAyAsd/hAkVhbHcxWRAEf
	 ZqonGao+p/c+1y81Ck3maa919OtGoZw+OxJbppMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 020/222] ext4: convert to new timestamp accessors
Date: Mon,  6 Jan 2025 16:13:44 +0100
Message-ID: <20250106151151.368140281@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit b898ab233611f7903d88c0b10f8145e1c15d3642 ]

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20231004185347.80880-33-jlayton@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h    | 20 +++++++++++++++-----
 fs/ext4/extents.c | 11 ++++++-----
 fs/ext4/ialloc.c  |  4 ++--
 fs/ext4/inline.c  |  4 ++--
 fs/ext4/inode.c   | 19 ++++++++++---------
 fs/ext4/ioctl.c   | 13 +++++++++++--
 fs/ext4/namei.c   | 10 +++++-----
 fs/ext4/super.c   |  2 +-
 fs/ext4/xattr.c   |  8 ++++----
 9 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3db01b933c3e..60455c84a937 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -891,10 +891,13 @@ do {										\
 		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX));	\
 } while (0)
 
-#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
-	EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, (inode)->xtime)
+#define EXT4_INODE_SET_ATIME(inode, raw_inode)						\
+	EXT4_INODE_SET_XTIME_VAL(i_atime, inode, raw_inode, inode_get_atime(inode))
 
-#define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
+#define EXT4_INODE_SET_MTIME(inode, raw_inode)						\
+	EXT4_INODE_SET_XTIME_VAL(i_mtime, inode, raw_inode, inode_get_mtime(inode))
+
+#define EXT4_INODE_SET_CTIME(inode, raw_inode)						\
 	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode))
 
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)				\
@@ -910,9 +913,16 @@ do {										\
 			.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime)	\
 		})
 
-#define EXT4_INODE_GET_XTIME(xtime, inode, raw_inode)				\
+#define EXT4_INODE_GET_ATIME(inode, raw_inode)					\
+do {										\
+	inode_set_atime_to_ts(inode,						\
+		EXT4_INODE_GET_XTIME_VAL(i_atime, inode, raw_inode));		\
+} while (0)
+
+#define EXT4_INODE_GET_MTIME(inode, raw_inode)					\
 do {										\
-	(inode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode);	\
+	inode_set_mtime_to_ts(inode,						\
+		EXT4_INODE_GET_XTIME_VAL(i_mtime, inode, raw_inode));		\
 } while (0)
 
 #define EXT4_INODE_GET_CTIME(inode, raw_inode)					\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 5ea75af6ca22..f2341d99d09f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4532,7 +4532,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			if (epos > new_size)
 				epos = new_size;
 			if (ext4_update_inode_size(inode, epos) & 0x1)
-				inode->i_mtime = inode_get_ctime(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_get_ctime(inode));
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -4670,7 +4671,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
@@ -4695,7 +4696,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5431,7 +5432,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5541,7 +5542,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index d4d0ad689d3c..52f2959d29e6 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1255,8 +1255,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	inode->i_ino = ino + group * EXT4_INODES_PER_GROUP(sb);
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	ei->i_crtime = inode->i_mtime;
+	simple_inode_init_ts(inode);
+	ei->i_crtime = inode_get_mtime(inode);
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_dir_start_lookup = 0;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index cb65052ee3de..3f363276ddd3 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1037,7 +1037,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	return 1;
@@ -2010,7 +2010,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		ext4_orphan_del(handle, inode);
 
 	if (err == 0) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 18ec9106c5b0..04f25a04f35a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4055,7 +4055,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
@@ -4215,7 +4215,7 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	err2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(err2 && !err))
 		err = err2;
@@ -4319,8 +4319,8 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 
 	EXT4_INODE_SET_CTIME(inode, raw_inode);
-	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
-	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
+	EXT4_INODE_SET_MTIME(inode, raw_inode);
+	EXT4_INODE_SET_ATIME(inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
 
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
@@ -4928,8 +4928,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	EXT4_INODE_GET_CTIME(inode, raw_inode);
-	EXT4_INODE_GET_XTIME(i_mtime, inode, raw_inode);
-	EXT4_INODE_GET_XTIME(i_atime, inode, raw_inode);
+	EXT4_INODE_GET_ATIME(inode, raw_inode);
+	EXT4_INODE_GET_MTIME(inode, raw_inode);
 	EXT4_EINODE_GET_XTIME(i_crtime, ei, raw_inode);
 
 	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT))) {
@@ -5054,8 +5054,8 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 
 		spin_lock(&ei->i_raw_lock);
 		EXT4_INODE_SET_CTIME(inode, raw_inode);
-		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
-		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
+		EXT4_INODE_SET_MTIME(inode, raw_inode);
+		EXT4_INODE_SET_ATIME(inode, raw_inode);
 		ext4_inode_csum_set(inode, raw_inode, ei);
 		spin_unlock(&ei->i_raw_lock);
 		trace_ext4_other_inode_update_time(inode, orig_ino);
@@ -5451,7 +5451,8 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 * update c/mtime in shrink case below
 			 */
 			if (!shrink)
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 
 			if (shrink)
 				ext4_fc_track_range(handle, inode,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0bfe2ce589e2..4f931f80cb34 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -312,13 +312,22 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
 	struct ext4_inode_info *ei1;
 	struct ext4_inode_info *ei2;
 	unsigned long tmp;
+	struct timespec64 ts1, ts2;
 
 	ei1 = EXT4_I(inode1);
 	ei2 = EXT4_I(inode2);
 
 	swap(inode1->i_version, inode2->i_version);
-	swap(inode1->i_atime, inode2->i_atime);
-	swap(inode1->i_mtime, inode2->i_mtime);
+
+	ts1 = inode_get_atime(inode1);
+	ts2 = inode_get_atime(inode2);
+	inode_set_atime_to_ts(inode1, ts2);
+	inode_set_atime_to_ts(inode2, ts1);
+
+	ts1 = inode_get_mtime(inode1);
+	ts2 = inode_get_mtime(inode2);
+	inode_set_mtime_to_ts(inode1, ts2);
+	inode_set_mtime_to_ts(inode2, ts1);
 
 	memswap(ei1->i_data, ei2->i_data, sizeof(ei1->i_data));
 	tmp = ei1->i_flags & EXT4_FL_SHOULD_SWAP;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4de1f61bba76..96a048d3f51b 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2210,7 +2210,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	err2 = ext4_mark_inode_dirty(handle, dir);
@@ -3248,7 +3248,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	 * recovery. */
 	inode->i_size = 0;
 	ext4_orphan_add(handle, inode);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_set_ctime_current(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (retval)
@@ -3323,7 +3323,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		retval = ext4_delete_entry(handle, dir, de, bh);
 		if (retval)
 			goto out_handle;
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 		ext4_update_dx_flag(dir);
 		retval = ext4_mark_inode_dirty(handle, dir);
 		if (retval)
@@ -3691,7 +3691,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	if (ext4_has_feature_filetype(ent->dir->i_sb))
 		ent->de->file_type = file_type;
 	inode_inc_iversion(ent->dir);
-	ent->dir->i_mtime = inode_set_ctime_current(ent->dir);
+	inode_set_mtime_to_ts(ent->dir, inode_set_ctime_current(ent->dir));
 	retval = ext4_mark_inode_dirty(handle, ent->dir);
 	BUFFER_TRACE(ent->bh, "call ext4_handle_dirty_metadata");
 	if (!ent->inlined) {
@@ -4006,7 +4006,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		ext4_dec_count(new.inode);
 		inode_set_ctime_current(new.inode);
 	}
-	old.dir->i_mtime = inode_set_ctime_current(old.dir);
+	inode_set_mtime_to_ts(old.dir, inode_set_ctime_current(old.dir));
 	ext4_update_dx_flag(old.dir);
 	if (old.dir_bh) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2346ef071b24..71ced0ada9a2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7180,7 +7180,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	}
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f40785bc4e55..df5ab1a75fc4 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -356,7 +356,7 @@ ext4_xattr_inode_hash(struct ext4_sb_info *sbi, const void *buffer, size_t size)
 
 static u64 ext4_xattr_inode_get_ref(struct inode *ea_inode)
 {
-	return ((u64) inode_get_ctime(ea_inode).tv_sec << 32) |
+	return ((u64) inode_get_ctime_sec(ea_inode) << 32) |
 		(u32) inode_peek_iversion_raw(ea_inode);
 }
 
@@ -368,12 +368,12 @@ static void ext4_xattr_inode_set_ref(struct inode *ea_inode, u64 ref_count)
 
 static u32 ext4_xattr_inode_get_hash(struct inode *ea_inode)
 {
-	return (u32)ea_inode->i_atime.tv_sec;
+	return (u32) inode_get_atime_sec(ea_inode);
 }
 
 static void ext4_xattr_inode_set_hash(struct inode *ea_inode, u32 hash)
 {
-	ea_inode->i_atime.tv_sec = hash;
+	inode_set_atime(ea_inode, hash, 0);
 }
 
 /*
@@ -418,7 +418,7 @@ static int ext4_xattr_inode_read(struct inode *ea_inode, void *buf, size_t size)
 	return ret;
 }
 
-#define EXT4_XATTR_INODE_GET_PARENT(inode) ((__u32)(inode)->i_mtime.tv_sec)
+#define EXT4_XATTR_INODE_GET_PARENT(inode) ((__u32)(inode_get_mtime_sec(inode)))
 
 static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 				 u32 ea_inode_hash, struct inode **ea_inode)
-- 
2.39.5




