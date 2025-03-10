Return-Path: <stable+bounces-122690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F6A5A0C6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3F9170718
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8E232369;
	Mon, 10 Mar 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hSf1gn4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFA17CA12;
	Mon, 10 Mar 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629218; cv=none; b=KWof/YEg0lTIjGxCjNU9TPgs92/sd3fzAucFQkrtbBZmL3HuK2GQuF/kBNTKJ9utNA8DVrdSJY+ci/P2tP03s3BJ2jHlsoKfllNR8sa4d0LP6Vih/AHYdpotXcfw625x+sc7WNDocJRuY1Z7cM3mHPlBdV+ZYSa88MF52gYuw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629218; c=relaxed/simple;
	bh=Jp8+KylSD7gIxwoh6KgN5rHf/jZ4hpGXQwdAmiA3O3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itfvbcMvfSeyvYHf4AU8+d/JtMRYRIrgOiFyNbt4Kqxvx/uLrLG3GosJbr8/CJq+IPo+/9JaB++DjSns3e8FnJgnYD59u4hXN8FK4z4JIWoysl5L8FPQaClfxeT6GWnB5vpZsC5TrKsbrf+lzAm+tncaYYSz4wNx93l0U+DyMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hSf1gn4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E6DC4CEE5;
	Mon, 10 Mar 2025 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629218;
	bh=Jp8+KylSD7gIxwoh6KgN5rHf/jZ4hpGXQwdAmiA3O3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSf1gn4E0HM4F9S9YzV8ji3LKDEBOdBqSlMJu89mzrHdaFpojySFDv9s5YwMBQfa9
	 S60JO2xJSQJ+/D/oPRojyx8vE88EjoCpsQ3DQm2fer0vpBPi5ZzRRtdwW9Znei4HZU
	 VsZsreVrjnOqAayIVIiw6Wt9IUdNXZurh+dsTHp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Lee <chullee@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 5.15 186/620] f2fs: Introduce linear search for dentries
Date: Mon, 10 Mar 2025 18:00:32 +0100
Message-ID: <20250310170552.976978042@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lee <chullee@google.com>

commit 91b587ba79e1b68bb718d12b0758dbcdab4e9cb7 upstream.

This patch addresses an issue where some files in case-insensitive
directories become inaccessible due to changes in how the kernel function,
utf8_casefold(), generates case-folded strings from the commit 5c26d2f1d3f5
("unicode: Don't special case ignorable code points").

F2FS uses these case-folded names to calculate hash values for locating
dentries and stores them on disk. Since utf8_casefold() can produce
different output across kernel versions, stored hash values and newly
calculated hash values may differ. This results in affected files no
longer being found via the hash-based lookup.

To resolve this, the patch introduces a linear search fallback.
If the initial hash-based search fails, F2FS will sequentially scan the
directory entries.

Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219586
Signed-off-by: Daniel Lee <chullee@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/dir.c    |   53 ++++++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/f2fs.h   |    6 ++++--
 fs/f2fs/inline.c |    5 +++--
 3 files changed, 45 insertions(+), 19 deletions(-)

--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -199,7 +199,8 @@ static unsigned long dir_block_index(uns
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct page *dentry_page,
 				const struct f2fs_filename *fname,
-				int *max_slots)
+				int *max_slots,
+				bool use_hash)
 {
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
@@ -207,7 +208,7 @@ static struct f2fs_dir_entry *find_in_bl
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	return f2fs_find_target_dentry(&d, fname, max_slots);
+	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
 }
 
 #ifdef CONFIG_UNICODE
@@ -284,7 +285,8 @@ static inline int f2fs_match_name(const
 }
 
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots)
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
@@ -307,7 +309,7 @@ struct f2fs_dir_entry *f2fs_find_target_
 			continue;
 		}
 
-		if (de->hash_code == fname->hash) {
+		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
 					      le16_to_cpu(de->name_len));
@@ -334,11 +336,12 @@ found:
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
 	unsigned int nbucket, nblock;
-	unsigned int bidx, end_block;
+	unsigned int bidx, end_block, bucket_no;
 	struct page *dentry_page;
 	struct f2fs_dir_entry *de = NULL;
 	bool room = false;
@@ -347,8 +350,11 @@ static struct f2fs_dir_entry *find_in_le
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
 
+	bucket_no = use_hash ? le32_to_cpu(fname->hash) % nbucket : 0;
+
+start_find_bucket:
 	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
-			       le32_to_cpu(fname->hash) % nbucket);
+			       bucket_no);
 	end_block = bidx + nblock;
 
 	for (; bidx < end_block; bidx++) {
@@ -364,7 +370,7 @@ static struct f2fs_dir_entry *find_in_le
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots);
+		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			*res_page = ERR_CAST(de);
 			de = NULL;
@@ -379,12 +385,18 @@ static struct f2fs_dir_entry *find_in_le
 		f2fs_put_page(dentry_page, 0);
 	}
 
-	if (!de && room && F2FS_I(dir)->chash != fname->hash) {
-		F2FS_I(dir)->chash = fname->hash;
-		F2FS_I(dir)->clevel = level;
-	}
+	if (de)
+		return de;
 
-	return de;
+	if (likely(use_hash)) {
+		if (room && F2FS_I(dir)->chash != fname->hash) {
+			F2FS_I(dir)->chash = fname->hash;
+			F2FS_I(dir)->clevel = level;
+		}
+	} else if (++bucket_no < nbucket) {
+		goto start_find_bucket;
+	}
+	return NULL;
 }
 
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
@@ -395,11 +407,15 @@ struct f2fs_dir_entry *__f2fs_find_entry
 	struct f2fs_dir_entry *de = NULL;
 	unsigned int max_depth;
 	unsigned int level;
+	bool use_hash = true;
 
 	*res_page = NULL;
 
+#if IS_ENABLED(CONFIG_UNICODE)
+start_find_entry:
+#endif
 	if (f2fs_has_inline_dentry(dir)) {
-		de = f2fs_find_in_inline_dir(dir, fname, res_page);
+		de = f2fs_find_in_inline_dir(dir, fname, res_page, use_hash);
 		goto out;
 	}
 
@@ -415,11 +431,18 @@ struct f2fs_dir_entry *__f2fs_find_entry
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, fname, res_page);
+		de = find_in_level(dir, level, fname, res_page, use_hash);
 		if (de || IS_ERR(*res_page))
 			break;
 	}
+
 out:
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (IS_CASEFOLDED(dir) && !de && use_hash) {
+		use_hash = false;
+		goto start_find_entry;
+	}
+#endif
 	/* This is to increase the speed of f2fs_create */
 	if (!de)
 		F2FS_I(dir)->task = current;
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3325,7 +3325,8 @@ int f2fs_prepare_lookup(struct inode *di
 			struct f2fs_filename *fname);
 void f2fs_free_filename(struct f2fs_filename *fname);
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots);
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
@@ -3926,7 +3927,8 @@ int f2fs_write_inline_data(struct inode
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page);
+					struct page **res_page,
+					bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -335,7 +335,8 @@ process_inline:
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
@@ -352,7 +353,7 @@ struct f2fs_dir_entry *f2fs_find_in_inli
 	inline_dentry = inline_data_addr(dir, ipage);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = f2fs_find_target_dentry(&d, fname, NULL);
+	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
 	unlock_page(ipage);
 	if (IS_ERR(de)) {
 		*res_page = ERR_CAST(de);



