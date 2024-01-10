Return-Path: <stable+bounces-9595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33F823310
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8040D283CC5
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040321C28A;
	Wed,  3 Jan 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o8Uj25Qa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207A1BDEC;
	Wed,  3 Jan 2024 17:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281F0C433C7;
	Wed,  3 Jan 2024 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704302115;
	bh=JEWPxkFXJSNtEcucTwSuHZ47t8iPcktYI0/kI5qA3y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8Uj25QaBu16gSLQ9SZwnqxMVjWivp52uqSQmMzYm2CZ9vYviGrMuJ63fobL6AERj
	 OHhzCHDsUl39/Kg09MqrRdGd9axiyfQRb/YyKxwXaL5u8E0gNVV0YOJz7FLxLwvJrG
	 zl2KHvf5+TOk5kJFoEuqdUOTf8ZVXLVXDsLTPZuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 21/49] client: convert to new timestamp accessors
Date: Wed,  3 Jan 2024 17:55:41 +0100
Message-ID: <20240103164838.253449782@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 8f22ce7088835444418f0775efb455d10b825596 ]

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20231004185347.80880-66-jlayton@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 01fe654f78fd ("fs: cifs: Fix atime update check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c    | 18 ++++++++++--------
 fs/smb/client/fscache.h |  6 +++---
 fs/smb/client/inode.c   | 17 ++++++++---------
 fs/smb/client/smb2ops.c |  6 ++++--
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2108b3b40ce92..cf17e3dd703e6 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1085,7 +1085,8 @@ int cifs_close(struct inode *inode, struct file *file)
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 			}
 			spin_lock(&cinode->deferred_lock);
 			cifs_add_deferred_close(cfile, dclose);
@@ -2596,7 +2597,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 					   write_data, to - from, &offset);
 		cifsFileInfo_put(open_file);
 		/* Does mm or vfs already set times? */
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		if ((bytes_written > 0) && (offset))
 			rc = 0;
 		else if (bytes_written < 0)
@@ -4647,11 +4648,13 @@ static void cifs_readahead(struct readahead_control *ractl)
 static int cifs_readpage_worker(struct file *file, struct page *page,
 	loff_t *poffset)
 {
+	struct inode *inode = file_inode(file);
+	struct timespec64 atime, mtime;
 	char *read_data;
 	int rc;
 
 	/* Is the page cached? */
-	rc = cifs_readpage_from_fscache(file_inode(file), page);
+	rc = cifs_readpage_from_fscache(inode, page);
 	if (rc == 0)
 		goto read_complete;
 
@@ -4666,11 +4669,10 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 		cifs_dbg(FYI, "Bytes read %d\n", rc);
 
 	/* we do not want atime to be less than mtime, it broke some apps */
-	file_inode(file)->i_atime = current_time(file_inode(file));
-	if (timespec64_compare(&(file_inode(file)->i_atime), &(file_inode(file)->i_mtime)))
-		file_inode(file)->i_atime = file_inode(file)->i_mtime;
-	else
-		file_inode(file)->i_atime = current_time(file_inode(file));
+	atime = inode_set_atime_to_ts(inode, current_time(inode));
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&atime, &mtime))
+		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 
 	if (PAGE_SIZE > rc)
 		memset(read_data + rc, 0, PAGE_SIZE - rc);
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 84f3b09367d2c..a3d73720914f8 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -49,12 +49,12 @@ static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
 				 struct cifs_fscache_inode_coherency_data *cd)
 {
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
 
 	memset(cd, 0, sizeof(*cd));
-	cd->last_write_time_sec   = cpu_to_le64(cifsi->netfs.inode.i_mtime.tv_sec);
-	cd->last_write_time_nsec  = cpu_to_le32(cifsi->netfs.inode.i_mtime.tv_nsec);
+	cd->last_write_time_sec   = cpu_to_le64(mtime.tv_sec);
+	cd->last_write_time_nsec  = cpu_to_le32(mtime.tv_nsec);
 	cd->last_change_time_sec  = cpu_to_le64(ctime.tv_sec);
 	cd->last_change_time_nsec = cpu_to_le32(ctime.tv_nsec);
 }
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 6a856945f2b42..09c5c0f5c96e2 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -82,6 +82,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 {
 	struct cifs_fscache_inode_coherency_data cd;
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
+	struct timespec64 mtime;
 
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
@@ -101,7 +102,8 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 
 	 /* revalidate if mtime or size have changed */
 	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
-	if (timespec64_equal(&inode->i_mtime, &fattr->cf_mtime) &&
+	mtime = inode_get_mtime(inode);
+	if (timespec64_equal(&mtime, &fattr->cf_mtime) &&
 	    cifs_i->server_eof == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
 			 __func__, cifs_i->uniqueid);
@@ -164,10 +166,10 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	fattr->cf_ctime = timestamp_truncate(fattr->cf_ctime, inode);
 	/* we do not want atime to be less than mtime, it broke some apps */
 	if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime) < 0)
-		inode->i_atime = fattr->cf_mtime;
+		inode_set_atime_to_ts(inode, fattr->cf_mtime);
 	else
-		inode->i_atime = fattr->cf_atime;
-	inode->i_mtime = fattr->cf_mtime;
+		inode_set_atime_to_ts(inode, fattr->cf_atime);
+	inode_set_mtime_to_ts(inode, fattr->cf_mtime);
 	inode_set_ctime_to_ts(inode, fattr->cf_ctime);
 	inode->i_rdev = fattr->cf_rdev;
 	cifs_nlink_fattr_to_inode(inode, fattr);
@@ -1868,7 +1870,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 					   when needed */
 		inode_set_ctime_current(inode);
 	}
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
@@ -2183,7 +2185,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	cifsInode->time = 0;
 
 	inode_set_ctime_current(d_inode(direntry));
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2389,9 +2391,6 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	/* force revalidate to go get info when needed */
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
-	source_dir->i_mtime = target_dir->i_mtime = inode_set_ctime_to_ts(source_dir,
-									  inode_set_ctime_current(target_dir));
-
 cifs_rename_exit:
 	kfree(info_buf_source);
 	free_dentry_path(page2);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2187921580ac6..e917eeba9c772 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1409,12 +1409,14 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Creation time should not need to be updated on close */
 	if (file_inf.LastWriteTime)
-		inode->i_mtime = cifs_NTtimeToUnix(file_inf.LastWriteTime);
+		inode_set_mtime_to_ts(inode,
+				      cifs_NTtimeToUnix(file_inf.LastWriteTime));
 	if (file_inf.ChangeTime)
 		inode_set_ctime_to_ts(inode,
 				      cifs_NTtimeToUnix(file_inf.ChangeTime));
 	if (file_inf.LastAccessTime)
-		inode->i_atime = cifs_NTtimeToUnix(file_inf.LastAccessTime);
+		inode_set_atime_to_ts(inode,
+				      cifs_NTtimeToUnix(file_inf.LastAccessTime));
 
 	/*
 	 * i_blocks is not related to (i_size / i_blksize),
-- 
2.43.0




