Return-Path: <stable+bounces-113299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C4A2911E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F573A6D14
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F571FCCE1;
	Wed,  5 Feb 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HRio5GAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234B1FC7E7;
	Wed,  5 Feb 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766490; cv=none; b=XPGiq4typ75a3qiS4RAiw7YEIMgTr5p/js+z76D4EB8KmqDQ48BWtYxtTK/Djjh9UuOV65ycEbYsPrem5JrDPyEIyvGhbi+6OWHjPY30bpLQSc8CKDAe6qfztXjoKVhx0FQEDcZ/B0ZM/aCOaojkhwYaCCWEdJTynklTv2ELg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766490; c=relaxed/simple;
	bh=mqzY2JrK7Q7A62kycUwCj9tyimLWLpesm7El4BEpVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN4je8APT4sDdnMuhfaxUxayiFPjzHfbyi11vnwIOVnpSwHzkO77EjoceCwAS4J+HWBQk0SKlbGwzKlj65h4Qlj2sN3ohEvxpousvBMRmtpD3GSfUKg7Ow0SXmWyDXo7O0286+OENnrO963WYcIcn9Kgx2+xdhTaje2GWrHGz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HRio5GAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BE7C4CEE2;
	Wed,  5 Feb 2025 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766489;
	bh=mqzY2JrK7Q7A62kycUwCj9tyimLWLpesm7El4BEpVZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRio5GAve4TEUoe0joIO9pgtEugdPpsOWp+HfqC2Mry5AF9u5y9W+jcWmGQQImSTJ
	 SzOACkpHXER/KE2sSYwSxWMyjQs07QT6hgwZGDclaBL0oU/z7KBt5GDmSWnnifYJ7D
	 +iTBShEL004hvwqLXpyOpaBNzxz6Fb4B18AnmrWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Lee <chullee@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 6.6 367/393] f2fs: Introduce linear search for dentries
Date: Wed,  5 Feb 2025 14:44:46 +0100
Message-ID: <20250205134434.342979910@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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
@@ -166,7 +166,8 @@ static unsigned long dir_block_index(uns
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct page *dentry_page,
 				const struct f2fs_filename *fname,
-				int *max_slots)
+				int *max_slots,
+				bool use_hash)
 {
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
@@ -174,7 +175,7 @@ static struct f2fs_dir_entry *find_in_bl
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	return f2fs_find_target_dentry(&d, fname, max_slots);
+	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
@@ -251,7 +252,8 @@ static inline int f2fs_match_name(const
 }
 
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots)
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
@@ -274,7 +276,7 @@ struct f2fs_dir_entry *f2fs_find_target_
 			continue;
 		}
 
-		if (de->hash_code == fname->hash) {
+		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
 					      le16_to_cpu(de->name_len));
@@ -301,11 +303,12 @@ found:
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
 	pgoff_t next_pgofs;
@@ -315,8 +318,11 @@ static struct f2fs_dir_entry *find_in_le
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
 
+	bucket_no = use_hash ? le32_to_cpu(fname->hash) % nbucket : 0;
+
+start_find_bucket:
 	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
-			       le32_to_cpu(fname->hash) % nbucket);
+			       bucket_no);
 	end_block = bidx + nblock;
 
 	while (bidx < end_block) {
@@ -333,7 +339,7 @@ static struct f2fs_dir_entry *find_in_le
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots);
+		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			*res_page = ERR_CAST(de);
 			de = NULL;
@@ -350,12 +356,18 @@ static struct f2fs_dir_entry *find_in_le
 		bidx++;
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
@@ -366,11 +378,15 @@ struct f2fs_dir_entry *__f2fs_find_entry
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
 
@@ -386,11 +402,18 @@ struct f2fs_dir_entry *__f2fs_find_entry
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
@@ -3531,7 +3531,8 @@ int f2fs_prepare_lookup(struct inode *di
 			struct f2fs_filename *fname);
 void f2fs_free_filename(struct f2fs_filename *fname);
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots);
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
@@ -4148,7 +4149,8 @@ int f2fs_write_inline_data(struct inode
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
@@ -353,7 +353,8 @@ process_inline:
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
@@ -370,7 +371,7 @@ struct f2fs_dir_entry *f2fs_find_in_inli
 	inline_dentry = inline_data_addr(dir, ipage);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = f2fs_find_target_dentry(&d, fname, NULL);
+	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
 	unlock_page(ipage);
 	if (IS_ERR(de)) {
 		*res_page = ERR_CAST(de);



