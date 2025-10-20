Return-Path: <stable+bounces-188168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFB3BF24C9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BD6420CFD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7733279798;
	Mon, 20 Oct 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+vaGELK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670C26B2B0
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976179; cv=none; b=MrtYkvCdEPdDRj+MsYC1BlfftvenTeFRwrTXb1dy3HAIyArX5fJluvpWC2qxPKPS/upv+mmnTba75nFcHbke3frvfzF8PgPJUf1c5CgCGRHcVATf2s8oGUZq2LBShKVNxyhMXlwyDHRalLQ7iazpZlgVRPmx8omXvEkNO6mYXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976179; c=relaxed/simple;
	bh=XzF1LtdUxiIpFGkDXxiXBGw8xKgSP7kij/dmbWGuVOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQoWkVrQNEXtca4O5Sztm1ICLzhw2aE+pyL0QJ8UxIPhlP9XEjw3d4nu6fcddNJmSgy1l00pY09LT3r0Vj4eY5YYWFRHbStG4FEB9NTACCK4pywbyAdzOJdasrbyKH2AbmoU+Ln1cjO6WOwZQ/XldCzkr6anFkJdtVvkWCTT4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+vaGELK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BD7C4CEF9;
	Mon, 20 Oct 2025 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976179;
	bh=XzF1LtdUxiIpFGkDXxiXBGw8xKgSP7kij/dmbWGuVOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+vaGELKytWDmGl1kmSk9Lhlzjv7SXbs28Y9ZEevwSRR3SDeUSQxuyPJ/+2JbT7y8
	 CFeKPDfcFnNEhqBfgyoq5g2r01yLyYob7uLMRkkkdrVd2BdFCPoRdvrJy6JiVpGWaG
	 aXBhOb4MlojN0oGErHA+AcwUqVFwtiFGi4nhde/xmbVJr/HpDE/GhtQceHEPY7bEx6
	 +DQVqwIHJfqoXInXmXgeG5zAv4bh7ISMQve9oJpZPo8EDLQMvkGtWPXTOKB1qddIFQ
	 2oDVnOQ8wLDzAUOQeM5x6wVZyhGenk7j/qYKyTNJHYXIf4CjSqxBbjeKa/77LJ6Oxx
	 ve296glVA2YZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] fuse: allocate ff->release_args only if release is needed
Date: Mon, 20 Oct 2025 12:02:55 -0400
Message-ID: <20251020160256.1828701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101629-privacy-morally-5172@gregkh>
References: <2025101629-privacy-morally-5172@gregkh>
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
index 1b8bf81d6c16b..43d311ff246bb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -491,7 +491,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -ENOMEM;
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bb4c5d1848cb7..d940bebe623e8 100644
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
@@ -274,7 +279,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 }
 
 static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
-				 unsigned int flags, int opcode)
+				 unsigned int flags, int opcode, bool sync)
 {
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
@@ -292,6 +297,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 
 	wake_up_interruptible_all(&ff->poll_wait);
 
+	if (!ra)
+		return;
+
 	ra->inarg.fh = ff->fh;
 	ra->inarg.flags = flags;
 	ra->args.in_numargs = 1;
@@ -301,6 +309,13 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
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
@@ -310,14 +325,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
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
@@ -328,7 +341,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy, isdir);
+	fuse_file_put(ff, ff->fm->fc->destroy);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -360,12 +373,8 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
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
 
@@ -918,7 +927,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		put_page(page);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false, false);
+		fuse_file_put(ia->ff, false);
 
 	fuse_io_free(ia);
 }
@@ -1625,7 +1634,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 		__free_page(ap->pages[i]);
 
 	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false, false);
+		fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1874,7 +1883,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false, false);
+		fuse_file_put(ff, false);
 
 	return err;
 }
@@ -2263,7 +2272,7 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false, false);
+		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ac655c7a15db2..7688122c1976a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -996,7 +996,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
  */
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 
-- 
2.51.0


