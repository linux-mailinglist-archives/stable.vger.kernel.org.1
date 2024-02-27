Return-Path: <stable+bounces-24009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C987E869232
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD25293DFA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE241419A6;
	Tue, 27 Feb 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LxykBk/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5113DB92;
	Tue, 27 Feb 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040772; cv=none; b=hGzdViXsXosGMBBY9ORIyyAGSPpvyHn9v3KTRq9N0Yl+kDz5LVvVNEq6I8ucf+wle+SQdqVkCVV+9QvfOAO2fTQChdV+iw99BnhYViaEZR4U+nX0WV/wL9XBTSNIRkqZAgTZ/sjS9PAqOKUYfpOedWZzDtkAAJglgbcoXDZa7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040772; c=relaxed/simple;
	bh=z/IK3HvzWF+37PMtaXSp5wT7a3IJzmnM7ZyeiDgevfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUeXydVX2Jxz39Q5oIrEPSNkz3HbJtHj4fxBYil4oHYw3V/IUvVa1bENKm4MsFxjibUEgZDJiGq4dNWAUGzCMhQ2ifkP5lvRaXB0gBdK7cYlsELWUkBaImxP4/qbJSWL7wR472EMnDDU0XFtkpp5kY/MhN6s+oiafvLwMkOCeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LxykBk/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D9C433F1;
	Tue, 27 Feb 2024 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040772;
	bh=z/IK3HvzWF+37PMtaXSp5wT7a3IJzmnM7ZyeiDgevfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxykBk/6L2aJrD4LZ+qLGKTcqTNTTWgdfXh3e+zQgrHtlC0EonytbQqGNnut1d6sC
	 nax+sPEN51gxYoyakeLzMYI0IS3vRWa0Okth6uEJ7JMFZ99kUhfz51HyEfCZWQJwgS
	 eLgU+Ow+Oa4lQFwZ3jKiK6BgV/5DLwubefc2fmD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 087/334] fs/ntfs3: Implement super_operations::shutdown
Date: Tue, 27 Feb 2024 14:19:05 +0100
Message-ID: <20240227131633.330746498@linuxfoundation.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 6c3684e703837d2116b5cf4beb37aa7145a66b60 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c    | 18 ++++++++++++++++++
 fs/ntfs3/frecord.c |  3 +++
 fs/ntfs3/inode.c   | 21 +++++++++++++++++++--
 fs/ntfs3/namei.c   | 12 ++++++++++++
 fs/ntfs3/ntfs_fs.h |  9 ++++++++-
 fs/ntfs3/super.c   | 12 ++++++++++++
 fs/ntfs3/xattr.c   |  3 +++
 7 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 0ff5d3af28897..07ed3d946e7c5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -260,6 +260,9 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	bool rw = vma->vm_flags & VM_WRITE;
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "mmap encrypted not supported");
 		return -EOPNOTSUPP;
@@ -677,6 +680,9 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		goto out;
@@ -732,6 +738,9 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file->f_mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
@@ -766,6 +775,9 @@ static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
 	struct inode *inode = in->f_mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
@@ -1058,6 +1070,9 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (is_encrypted(ni)) {
 		ntfs_inode_warn(inode, "encrypted i/o not supported");
 		return -EOPNOTSUPP;
@@ -1118,6 +1133,9 @@ int ntfs_file_open(struct inode *inode, struct file *file)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if (unlikely((is_compressed(ni) || is_encrypted(ni)) &&
 		     (file->f_flags & O_DIRECT))) {
 		return -EOPNOTSUPP;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3df2d9e34b914..8744ba36d4222 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3259,6 +3259,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	if (is_bad_inode(inode) || sb_rdonly(sb))
 		return 0;
 
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return -EIO;
+
 	if (!ni_trylock(ni)) {
 		/* 'ni' is under modification, skip for now. */
 		mark_inode_dirty_sync(inode);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bba0208c4afde..85452a6b1d40a 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -852,9 +852,13 @@ static int ntfs_resident_writepage(struct folio *folio,
 				   struct writeback_control *wbc, void *data)
 {
 	struct address_space *mapping = data;
-	struct ntfs_inode *ni = ntfs_i(mapping->host);
+	struct inode *inode = mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
 	int ret;
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	ni_lock(ni);
 	ret = attr_data_write_resident(ni, &folio->page);
 	ni_unlock(ni);
@@ -868,7 +872,12 @@ static int ntfs_resident_writepage(struct folio *folio,
 static int ntfs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	if (is_resident(ntfs_i(mapping->host)))
+	struct inode *inode = mapping->host;
+
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	if (is_resident(ntfs_i(inode)))
 		return write_cache_pages(mapping, wbc, ntfs_resident_writepage,
 					 mapping);
 	return mpage_writepages(mapping, wbc, ntfs_get_block);
@@ -888,6 +897,9 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	*pagep = NULL;
 	if (is_resident(ni)) {
 		struct page *page =
@@ -1305,6 +1317,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		goto out1;
 	}
 
+	if (unlikely(ntfs3_forced_shutdown(sb))) {
+		err = -EIO;
+		goto out2;
+	}
+
 	/* Mark rw ntfs as dirty. it will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ee3093be51701..cae41db0aaa7d 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -181,6 +181,9 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct ntfs_inode *ni = ntfs_i(dir);
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+		return -EIO;
+
 	ni_lock_dir(ni);
 
 	err = ntfs_unlink_inode(dir, dentry);
@@ -199,6 +202,9 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	u32 size = strlen(symname);
 	struct inode *inode;
 
+	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+		return -EIO;
+
 	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
 				  symname, size, NULL);
 
@@ -227,6 +233,9 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct ntfs_inode *ni = ntfs_i(dir);
 	int err;
 
+	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
+		return -EIO;
+
 	ni_lock_dir(ni);
 
 	err = ntfs_unlink_inode(dir, dentry);
@@ -264,6 +273,9 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		      1024);
 	static_assert(PATH_MAX >= 4 * 1024);
 
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return -EIO;
+
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a46d30b84bf39..7ce61fb89216a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -61,6 +61,8 @@ enum utf16_endian;
 
 /* sbi->flags */
 #define NTFS_FLAGS_NODISCARD		0x00000001
+/* ntfs in shutdown state. */
+#define NTFS_FLAGS_SHUTDOWN		0x00000002
 /* Set when LogFile is replaying. */
 #define NTFS_FLAGS_LOG_REPLAYING	0x00000008
 /* Set when we changed first MFT's which copy must be updated in $MftMirr. */
@@ -226,7 +228,7 @@ struct ntfs_sb_info {
 	u64 maxbytes; // Maximum size for normal files.
 	u64 maxbytes_sparse; // Maximum size for sparse file.
 
-	u32 flags; // See NTFS_FLAGS_XXX.
+	unsigned long flags; // See NTFS_FLAGS_
 
 	CLST zone_max; // Maximum MFT zone length in clusters
 	CLST bad_clusters; // The count of marked bad clusters.
@@ -999,6 +1001,11 @@ static inline struct ntfs_sb_info *ntfs_sb(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+static inline bool ntfs3_forced_shutdown(struct super_block *sb)
+{
+	return test_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+}
+
 /*
  * ntfs_up_cluster - Align up on cluster boundary.
  */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 09d61c6c90aaf..af8521a6ed954 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -714,6 +714,14 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+/*
+ * ntfs_shutdown - super_operations::shutdown
+ */
+static void ntfs_shutdown(struct super_block *sb)
+{
+	set_bit(NTFS_FLAGS_SHUTDOWN, &ntfs_sb(sb)->flags);
+}
+
 /*
  * ntfs_sync_fs - super_operations::sync_fs
  */
@@ -724,6 +732,9 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 	struct ntfs_inode *ni;
 	struct inode *inode;
 
+	if (unlikely(ntfs3_forced_shutdown(sb)))
+		return -EIO;
+
 	ni = sbi->security.ni;
 	if (ni) {
 		inode = &ni->vfs_inode;
@@ -763,6 +774,7 @@ static const struct super_operations ntfs_sops = {
 	.put_super = ntfs_put_super,
 	.statfs = ntfs_statfs,
 	.show_options = ntfs_show_options,
+	.shutdown = ntfs_shutdown,
 	.sync_fs = ntfs_sync_fs,
 	.write_inode = ntfs3_write_inode,
 };
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4274b6f31cfa1..071356d096d83 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -744,6 +744,9 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	/* Dispatch request. */
 	if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
 		/* system.dos_attrib */
-- 
2.43.0




