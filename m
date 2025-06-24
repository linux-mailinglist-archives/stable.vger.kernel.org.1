Return-Path: <stable+bounces-158121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D800AE570D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD541C23A01
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EB82264BF;
	Mon, 23 Jun 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ywn0+DDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066A222581;
	Mon, 23 Jun 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717536; cv=none; b=dpu6DT+LZB0XXe4PHO0ZP5IU0fU3IRi5qnK1DjS75aeAa4P3wzfxj7vaqeHkCXY8NlotbA5Lt85eD0hVhgWhaWHjbSa+Qf4LCP2X2c9i2txeuf96nne1JbRRV8vxe0THliXwaipt+BNBhWlx3nhcV3u8EvdnhNZ6ARiYvig56L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717536; c=relaxed/simple;
	bh=ktY+8X/rj0qkVFA7G8UTHVhhfOohpFrnNQEqT4ErWeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuVDfCTfdzZ28PYSNOjlg+10x6BjLk7fyKNTm+OpWWzv7VuKsyS/KJF61VE3gFfQRyqCmBKRCAuPOO0v7Bmlzf0ZDingURtae6oY6ir7XanG5tpyRIvYl5Fes1anZ2bFCmJOQ/3yGKTIAFE9xgjaMMK+2tkCXtnllWE0cMeU1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ywn0+DDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A618C4CEEA;
	Mon, 23 Jun 2025 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717535;
	bh=ktY+8X/rj0qkVFA7G8UTHVhhfOohpFrnNQEqT4ErWeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ywn0+DDRaf61P+UUaB+vUFEiyXIqm77/92RApj3Hq6qP2Wx/Q8cqr8kkjwVcS0apM
	 S/se1IOOud5CdPz/TU3dJxdu19p1sHg4C7qIG91PoVp9bytJ3F1yeHdPR6Fv+RFHzg
	 h+uyjWuzdpy3FSkFg2kJVVHDldRyrhJybSRWSPWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bharath SM <bharathsm@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 448/508] smb: improve directory cache reuse for readdir operations
Date: Mon, 23 Jun 2025 15:08:13 +0200
Message-ID: <20250623130656.179011702@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharath SM <bharathsm.hsk@gmail.com>

commit 72dd7961a4bb4fa1fc456169a61dd12e68e50645 upstream.

Currently, cached directory contents were not reused across subsequent
'ls' operations because the cache validity check relied on comparing
the ctx pointer, which changes with each readdir invocation. As a
result, the cached dir entries was not marked as valid and the cache was
not utilized for subsequent 'ls' operations.

This change uses the file pointer, which remains consistent across all
readdir calls for a given directory instance, to associate and validate
the cache. As a result, cached directory contents can now be
correctly reused, improving performance for repeated directory listings.

Performance gains with local windows SMB server:

Without the patch and default actimeo=1:
 1000 directory enumeration operations on dir with 10k files took 135.0s

With this patch and actimeo=0:
 1000 directory enumeration operations on dir with 10k files took just 5.1s

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.h |    8 ++++----
 fs/smb/client/readdir.c    |   28 +++++++++++++++-------------
 2 files changed, 19 insertions(+), 17 deletions(-)

--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -21,10 +21,10 @@ struct cached_dirent {
 struct cached_dirents {
 	bool is_valid:1;
 	bool is_failed:1;
-	struct dir_context *ctx; /*
-				  * Only used to make sure we only take entries
-				  * from a single context. Never dereferenced.
-				  */
+	struct file *file; /*
+			    * Used to associate the cache with a single
+			    * open file instance.
+			    */
 	struct mutex de_mutex;
 	int pos;		 /* Expected ctx->pos */
 	struct list_head entries;
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -882,9 +882,9 @@ static bool emit_cached_dirents(struct c
 }
 
 static void update_cached_dirents_count(struct cached_dirents *cde,
-					struct dir_context *ctx)
+					struct file *file)
 {
-	if (cde->ctx != ctx)
+	if (cde->file != file)
 		return;
 	if (cde->is_valid || cde->is_failed)
 		return;
@@ -893,9 +893,9 @@ static void update_cached_dirents_count(
 }
 
 static void finished_cached_dirents_count(struct cached_dirents *cde,
-					struct dir_context *ctx)
+					struct dir_context *ctx, struct file *file)
 {
-	if (cde->ctx != ctx)
+	if (cde->file != file)
 		return;
 	if (cde->is_valid || cde->is_failed)
 		return;
@@ -908,11 +908,12 @@ static void finished_cached_dirents_coun
 static void add_cached_dirent(struct cached_dirents *cde,
 			      struct dir_context *ctx,
 			      const char *name, int namelen,
-			      struct cifs_fattr *fattr)
+			      struct cifs_fattr *fattr,
+				  struct file *file)
 {
 	struct cached_dirent *de;
 
-	if (cde->ctx != ctx)
+	if (cde->file != file)
 		return;
 	if (cde->is_valid || cde->is_failed)
 		return;
@@ -942,7 +943,8 @@ static void add_cached_dirent(struct cac
 static bool cifs_dir_emit(struct dir_context *ctx,
 			  const char *name, int namelen,
 			  struct cifs_fattr *fattr,
-			  struct cached_fid *cfid)
+			  struct cached_fid *cfid,
+			  struct file *file)
 {
 	bool rc;
 	ino_t ino = cifs_uniqueid_to_ino_t(fattr->cf_uniqueid);
@@ -954,7 +956,7 @@ static bool cifs_dir_emit(struct dir_con
 	if (cfid) {
 		mutex_lock(&cfid->dirents.de_mutex);
 		add_cached_dirent(&cfid->dirents, ctx, name, namelen,
-				  fattr);
+				  fattr, file);
 		mutex_unlock(&cfid->dirents.de_mutex);
 	}
 
@@ -1054,7 +1056,7 @@ static int cifs_filldir(char *find_entry
 	cifs_prime_dcache(file_dentry(file), &name, &fattr);
 
 	return !cifs_dir_emit(ctx, name.name, name.len,
-			      &fattr, cfid);
+			      &fattr, cfid, file);
 }
 
 
@@ -1105,8 +1107,8 @@ int cifs_readdir(struct file *file, stru
 	 * we need to initialize scanning and storing the
 	 * directory content.
 	 */
-	if (ctx->pos == 0 && cfid->dirents.ctx == NULL) {
-		cfid->dirents.ctx = ctx;
+	if (ctx->pos == 0 && cfid->dirents.file == NULL) {
+		cfid->dirents.file = file;
 		cfid->dirents.pos = 2;
 	}
 	/*
@@ -1174,7 +1176,7 @@ int cifs_readdir(struct file *file, stru
 	} else {
 		if (cfid) {
 			mutex_lock(&cfid->dirents.de_mutex);
-			finished_cached_dirents_count(&cfid->dirents, ctx);
+			finished_cached_dirents_count(&cfid->dirents, ctx, file);
 			mutex_unlock(&cfid->dirents.de_mutex);
 		}
 		cifs_dbg(FYI, "Could not find entry\n");
@@ -1215,7 +1217,7 @@ int cifs_readdir(struct file *file, stru
 		ctx->pos++;
 		if (cfid) {
 			mutex_lock(&cfid->dirents.de_mutex);
-			update_cached_dirents_count(&cfid->dirents, ctx);
+			update_cached_dirents_count(&cfid->dirents, file);
 			mutex_unlock(&cfid->dirents.de_mutex);
 		}
 



