Return-Path: <stable+bounces-62772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33C94121B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA751F21CA3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56651A0708;
	Tue, 30 Jul 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4rDCCar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BC1A0701;
	Tue, 30 Jul 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343353; cv=none; b=TEOqIBPXk2qmcoebgkAxtOC6U00m3iFJBP8ZEuRe+gILHcRo1jGWJkZLtgfoRE5B/0xNRYJAo64ro030YBTQ9eqk9wbaJkOz1fT3W+XaOyAPzp3Zg8lvzXiZe9595qWNvvpXHcI94L3Wozpu/dutvd2ycopmt9+f8MVeF1XAu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343353; c=relaxed/simple;
	bh=kqQ+rx+Pf1/jO0GvzhbM9HATXM21dtNfmZ1eoR5tEbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siPbFnXnBjtuQtoKfa6toYBoKp9zDLv4cqSu75a4py9HFjnksteHkN/8CMBcJhSLEjItMFct4yRgjfnI1yNQjscQYMqgWtz3CDqEets07u5ONdNsnm7CjSe8BLowF/cWl3ZhaNLE8D7yVXdGfg6BAms8kswYO95/m3OuyB47RYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4rDCCar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BC1C4AF0C;
	Tue, 30 Jul 2024 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343353;
	bh=kqQ+rx+Pf1/jO0GvzhbM9HATXM21dtNfmZ1eoR5tEbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4rDCCarTVezv5jgR6OQq6Kj5UCXt//TkUY78YKYRwOWRT5dWQcqZAJu1Tx2Frk+M
	 aBGuDkZz+TpUFq2k39/uHu0tRv4eCbiM3Zv/GEEZGl1n4E+HHbSmMQ21HtmmhIx4Gz
	 BnYZGW4N90J92WiEeVtyHtQNcYrWBptiNUTePatHK7WDZL1Myec9RsP02v71NnSq91
	 kZtPrmREcQGryTIBc/07IZx2eiiST+GOvHddMP6YYv3vRvn1pjwbIPZpoaCjDqucyq
	 sII7pJhkvo6euQYP+DjkpFmOGWoUPWUwzL6+B4U7c7lxbQgv0bvTNbgZhm2xwVebQi
	 40+7qEur7lf+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 2/2] fs/ntfs3: Check more cases when directory is corrupted
Date: Tue, 30 Jul 2024 08:42:27 -0400
Message-ID: <20240730124228.3083982-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124228.3083982-1-sashal@kernel.org>
References: <20240730124228.3083982-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 744375343662058cbfda96d871786e5a5cbe1947 ]

Mark ntfs dirty in this case.
Rename ntfs_filldir to ntfs_dir_emit.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/dir.c | 52 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index ac8eb8657f1a9..b50b7687c46ac 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -272,9 +272,12 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 	return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
 }
 
-static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
-			       const struct NTFS_DE *e, u8 *name,
-			       struct dir_context *ctx)
+/*
+ * returns false if 'ctx' if full
+ */
+static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
+				 struct ntfs_inode *ni, const struct NTFS_DE *e,
+				 u8 *name, struct dir_context *ctx)
 {
 	const struct ATTR_FILE_NAME *fname;
 	unsigned long ino;
@@ -284,29 +287,29 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	fname = Add2Ptr(e, sizeof(struct NTFS_DE));
 
 	if (fname->type == FILE_NAME_DOS)
-		return 0;
+		return true;
 
 	if (!mi_is_ref(&ni->mi, &fname->home))
-		return 0;
+		return true;
 
 	ino = ino_get(&e->ref);
 
 	if (ino == MFT_REC_ROOT)
-		return 0;
+		return true;
 
 	/* Skip meta files. Unless option to show metafiles is set. */
 	if (!sbi->options->showmeta && ntfs_is_meta_file(sbi, ino))
-		return 0;
+		return true;
 
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
-		return 0;
+		return true;
 
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
 				     PATH_MAX);
 	if (name_len <= 0) {
 		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
 			  ino);
-		return 0;
+		return true;
 	}
 
 	/*
@@ -335,17 +338,20 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		}
 	}
 
-	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
+	return dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
 
 /*
  * ntfs_read_hdr - Helper function for ntfs_readdir().
+ *
+ * returns 0 if ok.
+ * returns -EINVAL if directory is corrupted.
+ * returns +1 if 'ctx' is full.
  */
 static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			 const struct INDEX_HDR *hdr, u64 vbo, u64 pos,
 			 u8 *name, struct dir_context *ctx)
 {
-	int err;
 	const struct NTFS_DE *e;
 	u32 e_size;
 	u32 end = le32_to_cpu(hdr->used);
@@ -353,12 +359,12 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 
 	for (;; off += e_size) {
 		if (off + sizeof(struct NTFS_DE) > end)
-			return -1;
+			return -EINVAL;
 
 		e = Add2Ptr(hdr, off);
 		e_size = le16_to_cpu(e->size);
 		if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
-			return -1;
+			return -EINVAL;
 
 		if (de_is_last(e))
 			return 0;
@@ -368,14 +374,15 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			continue;
 
 		if (le16_to_cpu(e->key_size) < SIZEOF_ATTRIBUTE_FILENAME)
-			return -1;
+			return -EINVAL;
 
 		ctx->pos = vbo + off;
 
 		/* Submit the name to the filldir callback. */
-		err = ntfs_filldir(sbi, ni, e, name, ctx);
-		if (err)
-			return err;
+		if (!ntfs_dir_emit(sbi, ni, e, name, ctx)) {
+			/* ctx is full. */
+			return +1;
+		}
 	}
 }
 
@@ -474,8 +481,6 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
-			ntfs_inode_err(dir, "Looks like your dir is corrupt");
-			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
@@ -498,9 +503,16 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	__putname(name);
 	put_indx_node(node);
 
-	if (err == -ENOENT) {
+	if (err == 1) {
+		/* 'ctx' is full. */
+		err = 0;
+	} else if (err == -ENOENT) {
 		err = 0;
 		ctx->pos = pos;
+	} else if (err < 0) {
+		if (err == -EINVAL)
+			ntfs_inode_err(dir, "directory corrupted");
+		ctx->pos = eod;
 	}
 
 	return err;
-- 
2.43.0


