Return-Path: <stable+bounces-86917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499829A4F13
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056AE282E90
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E4347A60;
	Sat, 19 Oct 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM7HZo46"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66710E4
	for <stable@vger.kernel.org>; Sat, 19 Oct 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729351305; cv=none; b=qkSmZPFL3I5/Rovm6bqjBeTxYmOiOoDpu5mUpSqDgWVeWyjXqNC65XjmZDxq42peOnn3AmphQjZMRz6rS+bw0MdS4UYSGX8s3Ta5CP+fV2hjJ+rP8xvamtSvgPUhp6DdADzpSwyfHz/qqmAP2DOHpTyhLNfd74eusxKX3oTLWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729351305; c=relaxed/simple;
	bh=zzsUF0HinlkRV8KzwdO//M31rObOdgKgPlWAiT2ke/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dE8sGWdO0ZfL1zkKxa3dxfL7PetR0/PCghAFTLyVgmNu+CVpYqN4AENAYezI3OYsM03J3Okvv8zSV/B7RpPDE56iOHD+6fLV9fWAdyfx5ra5AqsqKuckX8Y3ZVHwT+rwnKsXTVWfD8x9gkK6Sn6J2jLeGuzbQTz28q7+gmQ5Joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM7HZo46; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c693b68f5so33990425ad.1
        for <stable@vger.kernel.org>; Sat, 19 Oct 2024 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729351302; x=1729956102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcdT0IB2H+nZj2bYUoxe8he2CAv8okyz2p4Zs9Y203w=;
        b=FM7HZo46FwhlC1IxoqymfGEVkGPnzSUJ9f4xslY81BiAo9RwbaW6SDgi/sGwmzcvVv
         /FXe4avqgHD40XmMd5hAE0H71Y9KRgELHVOx0Mq88j8zDAMgU5B4mnmNr9UukEu1lEd4
         BwvMV9OUEmhB0uUw2qqCKdwfgKt8oY1H+zrefCxd0MZr0vuM28ieveBRhvftoydlEYo+
         oDSvj1paqLAVxxh0VMYXP1DiYv/G6yNrVCCgYBIHmqvBr2JpPBcQlYUakQnY46j4Dx80
         FBl07JtKioEXOZBKf7+XcYKYv3EqlA7AIxKDvhjpg5JyjSEiV6jgekshpDzM5t50vdHf
         nQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729351302; x=1729956102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcdT0IB2H+nZj2bYUoxe8he2CAv8okyz2p4Zs9Y203w=;
        b=qlbgrunacWmb/BQAd7RrtIUO/3x7jC+U/Mxxnb0luFhz0+ZG8tcW/ZIuZfiKBh0xc5
         46Lx20pDZeYRUvzTs+56aE6MkPSPKGDwLxk7l76v0mpgF1EAeRqVOwmt3RkWvfn0/wME
         iF4YkQ+/1WbDfBYTr2qlpjyxRTj7zQ+tLpaw5L4xscX5X2nv0ohchjBVJJYWbWyEyCGt
         6XxXei036yzIS6ZfmtDh+UgPeLfLMjLOP7CYiKCOwAUmaet//xd1og/Wa/AizT4ovdBN
         5MpJos8/8O0uT/N6IIQ7aGFMIeHbvmKV41mv0Eosw8hFCVAZ4zAfXpislcWbZiAjniDA
         q+aw==
X-Gm-Message-State: AOJu0YzKAbWBg87NDn3Pb+yuxyUZlxezYlMaCq6SjcWfyMNO3LZzk0rL
	CrJp5505YY/jgpxEa/waZ38U1o6yb0CtSr4DY9oU2Gv4+7djn+9/V31JeQ==
X-Google-Smtp-Source: AGHT+IFOg59QW3w36T1RTgXXUZVm5WEQMmqtMz4/1gIGNRjwmUH3JcKMmeAGauyykZF1/OcyMAxSkg==
X-Received: by 2002:a17:903:2447:b0:20c:ee48:94f3 with SMTP id d9443c01a7336-20e5a73e706mr76961955ad.14.1729351301660;
        Sat, 19 Oct 2024 08:21:41 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f1b45sm28816825ad.206.2024.10.19.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:21:40 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lizhi Xu <lizhi.xu@windriver.com>
Subject: [PATCH 4.19 5.4 5.10] nilfs2: propagate directory read errors from nilfs_find_entry()
Date: Sun, 20 Oct 2024 00:21:15 +0900
Message-ID: <20241019152136.5829-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024101853-recall-payee-2d9d@gregkh>
References: <2024101853-recall-payee-2d9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 08cfa12adf888db98879dbd735bc741360a34168 upstream.

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
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the failed patches.

This patch is tailored to take page/folio conversion into account and
avoid a few conflicts.  Compiled and tested successfully.

Thanks,
Ryusuke Konishi

 fs/nilfs2/dir.c   | 50 +++++++++++++++++++++++++----------------------
 fs/nilfs2/namei.c | 39 ++++++++++++++++++++++++------------
 fs/nilfs2/nilfs.h |  2 +-
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 5c0e280c83ee..365cae5c3e35 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -331,6 +331,8 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
  * returns the page in which the entry was found, and the entry itself
  * (as a parameter - res_dir). Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
+ *
+ * On failure, returns an error pointer and the caller should ignore res_page.
  */
 struct nilfs_dir_entry *
 nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
@@ -358,22 +360,24 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 	do {
 		char *kaddr = nilfs_get_page(dir, n, &page);
 
-		if (!IS_ERR(kaddr)) {
-			de = (struct nilfs_dir_entry *)kaddr;
-			kaddr += nilfs_last_byte(dir, n) - reclen;
-			while ((char *) de <= kaddr) {
-				if (de->rec_len == 0) {
-					nilfs_error(dir->i_sb,
-						"zero-length directory entry");
-					nilfs_put_page(page);
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
+				nilfs_put_page(page);
+				goto out;
 			}
-			nilfs_put_page(page);
+			if (nilfs_match(namelen, name, de))
+				goto found;
+			de = nilfs_next_entry(de);
 		}
+		nilfs_put_page(page);
+
 		if (++n >= npages)
 			n = 0;
 		/* next page is past the blocks we've got */
@@ -386,7 +390,7 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 		}
 	} while (n != start);
 out:
-	return NULL;
+	return ERR_PTR(-ENOENT);
 
 found:
 	*res_page = page;
@@ -431,19 +435,19 @@ struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
 	return NULL;
 }
 
-ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
+int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 {
-	ino_t res = 0;
 	struct nilfs_dir_entry *de;
 	struct page *page;
 
 	de = nilfs_find_entry(dir, qstr, &page);
-	if (de) {
-		res = le64_to_cpu(de->inode);
-		kunmap(page);
-		put_page(page);
-	}
-	return res;
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+
+	*ino = le64_to_cpu(de->inode);
+	kunmap(page);
+	put_page(page);
+	return 0;
 }
 
 /* Releases the page */
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index a6ec7961d4f5..08c6d985edeb 100644
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
 
@@ -261,10 +269,11 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 	struct page *page;
 	int err;
 
-	err = -ENOENT;
 	de = nilfs_find_entry(dir, &dentry->d_name, &page);
-	if (!de)
+	if (IS_ERR(de)) {
+		err = PTR_ERR(de);
 		goto out;
+	}
 
 	inode = d_inode(dentry);
 	err = -EIO;
@@ -358,10 +367,11 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (unlikely(err))
 		return err;
 
-	err = -ENOENT;
 	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_page);
-	if (!old_de)
+	if (IS_ERR(old_de)) {
+		err = PTR_ERR(old_de);
 		goto out;
+	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
@@ -378,10 +388,12 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (dir_de && !nilfs_empty_dir(new_inode))
 			goto out_dir;
 
-		err = -ENOENT;
-		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_page);
-		if (!new_de)
+		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name,
+					  &new_page);
+		if (IS_ERR(new_de)) {
+			err = PTR_ERR(new_de);
 			goto out_dir;
+		}
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
 		nilfs_mark_inode_dirty(new_dir);
 		new_inode->i_ctime = current_time(new_inode);
@@ -435,14 +447,15 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
  */
 static struct dentry *nilfs_get_parent(struct dentry *child)
 {
-	unsigned long ino;
+	ino_t ino;
+	int res;
 	struct inode *inode;
 	struct qstr dotdot = QSTR_INIT("..", 2);
 	struct nilfs_root *root;
 
-	ino = nilfs_inode_by_name(d_inode(child), &dotdot);
-	if (!ino)
-		return ERR_PTR(-ENOENT);
+	res = nilfs_inode_by_name(d_inode(child), &dotdot, &ino);
+	if (res)
+		return ERR_PTR(res);
 
 	root = NILFS_I(d_inode(child))->i_root;
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 3f3971e0292d..e1b230a5011a 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -233,7 +233,7 @@ static inline __u32 nilfs_mask_flags(umode_t mode, __u32 flags)
 
 /* dir.c */
 extern int nilfs_add_link(struct dentry *, struct inode *);
-extern ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
+int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino);
 extern int nilfs_make_empty(struct inode *, struct inode *);
 extern struct nilfs_dir_entry *
 nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
-- 
2.43.5


