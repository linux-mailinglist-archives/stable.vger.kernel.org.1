Return-Path: <stable+bounces-188166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C511BF248D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3982118A4FAD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F826B2B0;
	Mon, 20 Oct 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llt/AUgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D227A46A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976155; cv=none; b=NLZLw6+BWRhzYO8BXjuXEgpX6jpQ8FADbOwpJODnlGr83ESTikYwH3gbs5LckaGXsLtnOw1fJaIDoQebWxNMoW+TcbEsRgJPq9BExq9kqCsEMOp5YvqEJqt9j/Nw3PKkmxH3b5l1tG9zzC1UWlKE1bMoSLJU2yASVsxYefXOhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976155; c=relaxed/simple;
	bh=oVony/1dHok6EV78ehOvyDCn7RpehiefIYSOjlc1Zvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO8sd/s2dGN8sA9cDir/WnwrLgLuK/6nuv3VLvmSWVJpkUhVAdU6vtfZcsc83cBA2+VKQc+kHcAtuUcKkBhU1TVaxK9g6ozmdFXblG8UrfmrMS8UKBrnzlCMj4eZWt5mmD5VSnOtMUvq/Pli7P0tAdjWu/8qsfjCsC7zyMgAyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llt/AUgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41130C4CEF9;
	Mon, 20 Oct 2025 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976154;
	bh=oVony/1dHok6EV78ehOvyDCn7RpehiefIYSOjlc1Zvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llt/AUgMvclIO52DSaOyNB0SXIGZV7FHnH9zZRlX3gXXsHPRVA91QhWpCTz3/DSKY
	 mhvMR8GIaVAl/s+1Lm9g0SrdCvMNFWUGXy3pG//XcMkPMhVuwrZuk91FBaJoa21xRS
	 LysJ0fAF+lDDphVfIvUkN1oxO56je1zXFn1U6yWXS5a8EE5U5u1TUQjOt0wDWKopRs
	 +UY5DvmGrX4KOSK8WhS/bLqzx9Tu46e4CQ6wateV1wde1/DSwrmoJ3n8vCb58tFs7g
	 TiqMbTxf7nAoe+RfY7sFFoAi1eLxznvd78Le9Rc7k8xcS3kFN5LcDgRyxFZZoj75dZ
	 4YBZT2n6kBCYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] fuse: allocate ff->release_args only if release is needed
Date: Mon, 20 Oct 2025 12:02:31 -0400
Message-ID: <20251020160232.1828501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101628-exclude-hamstring-8d43@gregkh>
References: <2025101628-exclude-hamstring-8d43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit e26ee4efbc79610b20e7abe9d96c87f33dacc1ff ]

This removed the need to pass isdir argument to fuse_put_file().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 69 +++++++++++++++++++++++++++---------------------
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0dbacdd7bb0d8..e54d70a42519b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -584,7 +584,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -ENOMEM;
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index db5ba56a837a8..627ad8fadbec0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -54,7 +54,7 @@ struct fuse_release_args {
 	struct inode *inode;
 };
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 {
 	struct fuse_file *ff;
 
@@ -63,11 +63,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
 		return NULL;
 
 	ff->fm = fm;
-	ff->release_args = kzalloc(sizeof(*ff->release_args),
-				   GFP_KERNEL_ACCOUNT);
-	if (!ff->release_args) {
-		kfree(ff);
-		return NULL;
+	if (release) {
+		ff->release_args = kzalloc(sizeof(*ff->release_args),
+					   GFP_KERNEL_ACCOUNT);
+		if (!ff->release_args) {
+			kfree(ff);
+			return NULL;
+		}
 	}
 
 	INIT_LIST_HEAD(&ff->write_entry);
@@ -103,14 +105,14 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
+static void fuse_file_put(struct fuse_file *ff, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
-		struct fuse_args *args = &ff->release_args->args;
+		struct fuse_release_args *ra = ff->release_args;
+		struct fuse_args *args = (ra ? &ra->args : NULL);
 
-		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
-			/* Do nothing when client does not implement 'open' */
-			fuse_release_end(ff->fm, args, 0);
+		if (!args) {
+			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
@@ -130,15 +132,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	bool open = isdir ? !fc->no_opendir : !fc->no_open;
 
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, open);
 	if (!ff)
 		return ERR_PTR(-ENOMEM);
 
 	ff->fh = 0;
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
-	if (isdir ? !fc->no_opendir : !fc->no_open) {
+	if (open) {
 		struct fuse_open_out outarg;
 		int err;
 
@@ -146,11 +149,13 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
+			/* No release needed */
+			kfree(ff->release_args);
+			ff->release_args = NULL;
 			if (isdir)
 				fc->no_opendir = 1;
 			else
@@ -272,7 +277,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 }
 
 static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
-				 unsigned int flags, int opcode)
+				 unsigned int flags, int opcode, bool sync)
 {
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
@@ -290,6 +295,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 
 	wake_up_interruptible_all(&ff->poll_wait);
 
+	if (!ra)
+		return;
+
 	ra->inarg.fh = ff->fh;
 	ra->inarg.flags = flags;
 	ra->args.in_numargs = 1;
@@ -299,6 +307,13 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	ra->args.nodeid = ff->nodeid;
 	ra->args.force = true;
 	ra->args.nocreds = true;
+
+	/*
+	 * Hold inode until release is finished.
+	 * From fuse_sync_release() the refcount is 1 and everything's
+	 * synchronous, so we are fine with not doing igrab() here.
+	 */
+	ra->inode = sync ? NULL : igrab(&fi->inode);
 }
 
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
@@ -308,14 +323,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
-	fuse_prepare_release(fi, ff, open_flags, opcode);
+	fuse_prepare_release(fi, ff, open_flags, opcode, false);
 
-	if (ff->flock) {
+	if (ra && ff->flock) {
 		ra->inarg.release_flags |= FUSE_RELEASE_FLOCK_UNLOCK;
 		ra->inarg.lock_owner = fuse_lock_owner_id(ff->fm->fc, id);
 	}
-	/* Hold inode until release is finished */
-	ra->inode = igrab(inode);
 
 	/*
 	 * Normally this will send the RELEASE request, however if
@@ -326,7 +339,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy, isdir);
+	fuse_file_put(ff, ff->fm->fc->destroy);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -361,12 +374,8 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags)
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
-	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE);
-	/*
-	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
-	 * synchronous, we are fine with not doing igrab() here"
-	 */
-	fuse_file_put(ff, true, false);
+	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
+	fuse_file_put(ff, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -923,7 +932,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		put_page(page);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false, false);
+		fuse_file_put(ia->ff, false);
 
 	fuse_io_free(ia);
 }
@@ -1670,7 +1679,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 		__free_page(ap->pages[i]);
 
 	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false, false);
+		fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1918,7 +1927,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false, false);
+		fuse_file_put(ff, false);
 
 	return err;
 }
@@ -2316,7 +2325,7 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false, false);
+		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6c3ec70c1b70d..d280ef6e346b4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1022,7 +1022,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
  */
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 
-- 
2.51.0


