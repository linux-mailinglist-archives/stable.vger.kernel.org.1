Return-Path: <stable+bounces-24373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A6869427
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D9E1C23D76
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250BE14690E;
	Tue, 27 Feb 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGOC6rGj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFB1468F9;
	Tue, 27 Feb 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041815; cv=none; b=lRqjm92v3RDyh0gc+rwMrGbhFayEYsVC0JUs5iWWjDA2AA7hvnpGTyqXkI+ZGcLVjuQOGafenBHy6VtQ3dI/Df4SuLuShoAVHV7mn36RWWwFoByhRbDHFafIn6FpDiNk/PRE+YyBxrm+X6vieo56LWSkEkHxPRY+myKoLbBz9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041815; c=relaxed/simple;
	bh=+vy89iCqtqwcVLS7FDc4Qky94e0Ok83EouhCHOLCXFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k88+g9yPy7IAWTuSQPJQzr+O1tkJ9WvAx4br/q9HPHbvUGhuuISw6C6XWEGfIhXv9umac8X5dUZsgWIf3XUfZoCDh9SymjX1b0iuFz57T5o5rDieqPkDV7XHuyXCcERH4VMSEULX5+J0GcUJsiAQO5m+fg+lhJ0pZB5dXmhSpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGOC6rGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C860C43390;
	Tue, 27 Feb 2024 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041815;
	bh=+vy89iCqtqwcVLS7FDc4Qky94e0Ok83EouhCHOLCXFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGOC6rGjZm4EdzC2vPTv9ccb1asIvUWt1ROUPikQEAnih65MZBovew5Gf8AZJG78S
	 HXUsG1GCQUWmhIVNvJcvGktlQvRra+c5BZnDrgC8Vv7NC241+JkQHaqCC7FAQAmIFc
	 TwPWb/t0ciapawHQd0AvZZ9LSBKdlBgMd/VMFG6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 080/299] fs/ntfs3: Implement super_operations::shutdown
Date: Tue, 27 Feb 2024 14:23:11 +0100
Message-ID: <20240227131628.502993535@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 5530b4cf1ee52..a5bbf7b5775af 100644
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
index dad976a689859..86b43051f39cd 100644
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
index fb0466c115040..012dbc8ac5ec7 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -851,9 +851,13 @@ static int ntfs_resident_writepage(struct folio *folio,
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
@@ -867,7 +871,12 @@ static int ntfs_resident_writepage(struct folio *folio,
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
@@ -887,6 +896,9 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	*pagep = NULL;
 	if (is_resident(ni)) {
 		struct page *page =
@@ -1303,6 +1315,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
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
index eedacf94edd80..b5687d74b4495 100644
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
index 29a9b0b29e4f8..466ee5bd62260 100644
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
index aa3b2c262ab6e..a313b4ddee16f 100644
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
index 4920548192a0c..838a79157fb99 100644
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




