Return-Path: <stable+bounces-86774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE99A378E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BF01F24A7F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482613C816;
	Fri, 18 Oct 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODPEcqfL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0C18BC3A
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237695; cv=none; b=imbexFcpHOx/Dvv63isGTlCynbP0YhoFRZPf+LRMru9HW5FDjGWmznyDp7+ZPqtDO81UAnSvF9WkyN3ilVfrHNJySYe+8rP+E1zL1NROWFI/tLKBO6ueDYL/aTZWuQ5hDM2JPzCutrat6ZvH3d6RA+qI1Nc8WwegU7M1jW7hoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237695; c=relaxed/simple;
	bh=TYq71J0sahG7uIywNflqU8Dz6NYTpDG4QJEl/wSMzp8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rsK8ocM6MB03NqbYJ15ZNOBESwouyfcEJA1U9vXElXOpV7+m7/xMvjFSSFwege+KefpIkogiDGORqwa2CBVxhcwOpb6e52IyMyu0aIxCOYqLOu15PTxIRay4Mwv9061AtLUFmzk32JECIc4RmiGBpNYJsyJWbTMZmI+GlGe2GcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODPEcqfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D50C4CEC3;
	Fri, 18 Oct 2024 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729237695;
	bh=TYq71J0sahG7uIywNflqU8Dz6NYTpDG4QJEl/wSMzp8=;
	h=Subject:To:Cc:From:Date:From;
	b=ODPEcqfLFidsVgSA+UOFLxULp6r9Z5zxCGuQZsuB9b40XTrrd/e9M38AHJ8dXOy8R
	 0UKHDOPMmrnxK6MOZlK7TX/2Vbit5VOqXMsfCJTdB3wzrkAzuqo1skb4ygeTGUm0Qd
	 jCif/JRENR8Q8ofBlAojrzED9JpaUrXT1QCQrQ0I=
Subject: FAILED: patch "[PATCH] nilfs2: propagate directory read errors from" failed to apply to 4.19-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,lizhi.xu@windriver.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:47:56 +0200
Message-ID: <2024101855-landowner-harness-1529@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 08cfa12adf888db98879dbd735bc741360a34168
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101855-landowner-harness-1529@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08cfa12adf888db98879dbd735bc741360a34168 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 4 Oct 2024 12:35:31 +0900
Subject: [PATCH] nilfs2: propagate directory read errors from
 nilfs_find_entry()

Syzbot reported that a task hang occurs in vcs_open() during a fuzzing
test for nilfs2.

The root cause of this problem is that in nilfs_find_entry(), which
searches for directory entries, ignores errors when loading a directory
page/folio via nilfs_get_folio() fails.

If the filesystem images is corrupted, and the i_size of the directory
inode is large, and the directory page/folio is successfully read but
fails the sanity check, for example when it is zero-filled,
nilfs_check_folio() may continue to spit out error messages in bursts.

Fix this issue by propagating the error to the callers when loading a
page/folio fails in nilfs_find_entry().

The current interface of nilfs_find_entry() and its callers is outdated
and cannot propagate error codes such as -EIO and -ENOMEM returned via
nilfs_find_entry(), so fix it together.

Link: https://lkml.kernel.org/r/20241004033640.6841-1-konishi.ryusuke@gmail.com
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: Lizhi Xu <lizhi.xu@windriver.com>
Closes: https://lkml.kernel.org/r/20240927013806.3577931-1-lizhi.xu@windriver.com
Reported-by: syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index fe5b1a30c509..a8602729586a 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -289,7 +289,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
  * The folio is mapped and unlocked.  When the caller is finished with
  * the entry, it should call folio_release_kmap().
  *
- * On failure, returns NULL and the caller should ignore foliop.
+ * On failure, returns an error pointer and the caller should ignore foliop.
  */
 struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 		const struct qstr *qstr, struct folio **foliop)
@@ -312,22 +312,24 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 	do {
 		char *kaddr = nilfs_get_folio(dir, n, foliop);
 
-		if (!IS_ERR(kaddr)) {
-			de = (struct nilfs_dir_entry *)kaddr;
-			kaddr += nilfs_last_byte(dir, n) - reclen;
-			while ((char *) de <= kaddr) {
-				if (de->rec_len == 0) {
-					nilfs_error(dir->i_sb,
-						"zero-length directory entry");
-					folio_release_kmap(*foliop, kaddr);
-					goto out;
-				}
-				if (nilfs_match(namelen, name, de))
-					goto found;
-				de = nilfs_next_entry(de);
+		if (IS_ERR(kaddr))
+			return ERR_CAST(kaddr);
+
+		de = (struct nilfs_dir_entry *)kaddr;
+		kaddr += nilfs_last_byte(dir, n) - reclen;
+		while ((char *)de <= kaddr) {
+			if (de->rec_len == 0) {
+				nilfs_error(dir->i_sb,
+					    "zero-length directory entry");
+				folio_release_kmap(*foliop, kaddr);
+				goto out;
 			}
-			folio_release_kmap(*foliop, kaddr);
+			if (nilfs_match(namelen, name, de))
+				goto found;
+			de = nilfs_next_entry(de);
 		}
+		folio_release_kmap(*foliop, kaddr);
+
 		if (++n >= npages)
 			n = 0;
 		/* next folio is past the blocks we've got */
@@ -340,7 +342,7 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 		}
 	} while (n != start);
 out:
-	return NULL;
+	return ERR_PTR(-ENOENT);
 
 found:
 	ei->i_dir_start_lookup = n;
@@ -384,18 +386,18 @@ fail:
 	return NULL;
 }
 
-ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
+int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 {
-	ino_t res = 0;
 	struct nilfs_dir_entry *de;
 	struct folio *folio;
 
 	de = nilfs_find_entry(dir, qstr, &folio);
-	if (de) {
-		res = le64_to_cpu(de->inode);
-		folio_release_kmap(folio, de);
-	}
-	return res;
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+
+	*ino = le64_to_cpu(de->inode);
+	folio_release_kmap(folio, de);
+	return 0;
 }
 
 void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index c950139db6ef..4905063790c5 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -55,12 +55,20 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	ino_t ino;
+	int res;
 
 	if (dentry->d_name.len > NILFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	ino = nilfs_inode_by_name(dir, &dentry->d_name);
-	inode = ino ? nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino) : NULL;
+	res = nilfs_inode_by_name(dir, &dentry->d_name, &ino);
+	if (res) {
+		if (res != -ENOENT)
+			return ERR_PTR(res);
+		inode = NULL;
+	} else {
+		inode = nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino);
+	}
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -263,10 +271,11 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 	struct folio *folio;
 	int err;
 
-	err = -ENOENT;
 	de = nilfs_find_entry(dir, &dentry->d_name, &folio);
-	if (!de)
+	if (IS_ERR(de)) {
+		err = PTR_ERR(de);
 		goto out;
+	}
 
 	inode = d_inode(dentry);
 	err = -EIO;
@@ -362,10 +371,11 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	if (unlikely(err))
 		return err;
 
-	err = -ENOENT;
 	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
-	if (!old_de)
+	if (IS_ERR(old_de)) {
+		err = PTR_ERR(old_de);
 		goto out;
+	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
@@ -382,10 +392,12 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 		if (dir_de && !nilfs_empty_dir(new_inode))
 			goto out_dir;
 
-		err = -ENOENT;
-		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
-		if (!new_de)
+		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name,
+					  &new_folio);
+		if (IS_ERR(new_de)) {
+			err = PTR_ERR(new_de);
 			goto out_dir;
+		}
 		nilfs_set_link(new_dir, new_de, new_folio, old_inode);
 		folio_release_kmap(new_folio, new_de);
 		nilfs_mark_inode_dirty(new_dir);
@@ -440,12 +452,13 @@ out:
  */
 static struct dentry *nilfs_get_parent(struct dentry *child)
 {
-	unsigned long ino;
+	ino_t ino;
+	int res;
 	struct nilfs_root *root;
 
-	ino = nilfs_inode_by_name(d_inode(child), &dotdot_name);
-	if (!ino)
-		return ERR_PTR(-ENOENT);
+	res = nilfs_inode_by_name(d_inode(child), &dotdot_name, &ino);
+	if (res)
+		return ERR_PTR(res);
 
 	root = NILFS_I(d_inode(child))->i_root;
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index fb1c4c5bae7c..45d03826eaf1 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -254,7 +254,7 @@ static inline __u32 nilfs_mask_flags(umode_t mode, __u32 flags)
 
 /* dir.c */
 int nilfs_add_link(struct dentry *, struct inode *);
-ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
+int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino);
 int nilfs_make_empty(struct inode *, struct inode *);
 struct nilfs_dir_entry *nilfs_find_entry(struct inode *, const struct qstr *,
 		struct folio **);


