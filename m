Return-Path: <stable+bounces-86912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09C9A4DA1
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 14:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8286AB24C60
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1071DF997;
	Sat, 19 Oct 2024 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjxKFEDi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F31917E4
	for <stable@vger.kernel.org>; Sat, 19 Oct 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339527; cv=none; b=pgYM7AHHaOqliqFFwXo+k89J9WHbQ8WQdkihzgOK2PbP8+GobGqYzbnIkG224FOG7TgeZuSdK15L2Ro9hdHwvu4zD49+ihbDS1yY94txecsCcshKfeHqoZjcGjTLbKmvvNea6tKK+zsPjGe6wPyDV0L1UkaGueWzAOxvHcEXvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339527; c=relaxed/simple;
	bh=+DBEyIFjkUAGVIQSnSDkifZt7FJIANz5JY1Zpq7WTQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JitISmFLz8tw52sa8aSlKGcOkzRUl/bYD0+sGjuM4zLo0oE3rqJiWOuL4odA7F8pBXJ7UCiTzaottEc88c97u1JvCOREPBCDovqK5A7SlAedSp9WWV14YVvimWfOYG4GWd7050nv/wwzxLyQgH/jFbrdN+Pjn62019uy3TjPVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjxKFEDi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so2474170a12.1
        for <stable@vger.kernel.org>; Sat, 19 Oct 2024 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729339524; x=1729944324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayK2R3tzApM+JXufk/umBCMoHmXNKr0KgciO9Gs5pT0=;
        b=gjxKFEDiC3glr9tKU5wiENWVnoEVUgSU0Ti+r/pjG3YzOOxf+EvtuBIpZsTaf5fuZj
         Pkz1jW6eudLPo1+U1k28n0BL56x8W64TcXWCWbkPkAYQAmOdaEdrC07rHp9cc5paKwWd
         kTBdPEC3MCkVB+8EN8bAtMuqf40k/P0iYBIM1Uk4+85BLSroM9tUj0lS28uaosqY5DCu
         k88l88mpu+yoMsDGHYvHNHI2RT/1R0gC4Cbyk8ELZhd8IK28Dc7OlYwClJf+NGC9/Rtx
         m2OfQUq9tyc5+kiYkpununIUJNskfY67rTs4HNMdRglBms8/6eLipi4z7a4XX0JwefTC
         K2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729339524; x=1729944324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayK2R3tzApM+JXufk/umBCMoHmXNKr0KgciO9Gs5pT0=;
        b=I9WFjRPa0Hmn7yKJkM1JwpP1y4prPK4wmvqVnRv8qBPnXYkYucq3ShzwcieJDZZNzD
         8BD/fdN/F0e1fnodXmkTr2qnaWLd6kW/qahJPe9+7czhjXRhqWUF6ts79Hqo4Y1DA51D
         c2nz3AAiFuPPXVx85JyorlQtDsARR2gJ9G9GZUhLqANlVblxWgx29J+yl8vez4SCWRnW
         dJvmR9CpUOJNeh1uOx3bTXRTx7MCnk/NSHUmBIXtVnd4ltSwOo2515xzvKJ+3YZp5UGM
         +dDu/QFxEXdFXdZLz6tJFxYQRFXGlg6iLIqLAO6n6U4u9gFd2KZifcY3j41voBaFscS8
         X5lg==
X-Gm-Message-State: AOJu0YxHgohh0CRwrRYqpzpIRZN3jzrNIl7BockfGkX/kxoPb8x2vw0J
	9VPcGzV+g4fMXrOn099dQZ2Mogod7I80IOPhTJdA0NfTHZ2JQAcaOwXNLA==
X-Google-Smtp-Source: AGHT+IHYVQQt+a/hNTeDY2zbbzJ7892WUFrRAYEHtRAupuXbp5dEpohk97P5bVjU7ovqT8AX9bLAXw==
X-Received: by 2002:a05:6a21:a343:b0:1d8:fdb1:c0d8 with SMTP id adf61e73a8af0-1d92c49b1a5mr7047767637.3.1729339523789;
        Sat, 19 Oct 2024 05:05:23 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc208d4csm2858122a12.1.2024.10.19.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 05:05:22 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lizhi Xu <lizhi.xu@windriver.com>
Subject: [PATCH 6.6] nilfs2: propagate directory read errors from nilfs_find_entry()
Date: Sat, 19 Oct 2024 21:04:23 +0900
Message-ID: <20241019120518.4269-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024101851-treble-echo-a580@gregkh>
References: <2024101851-treble-echo-a580@gregkh>
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
Please apply this patch to the 6.6-stable instead of the failed patch.

This patch is tailored to take page/folio conversion into account.
Compiled and tested successfully.

Thanks,
Ryusuke Konishi

 fs/nilfs2/dir.c   | 50 +++++++++++++++++++++++++----------------------
 fs/nilfs2/namei.c | 39 ++++++++++++++++++++++++------------
 fs/nilfs2/nilfs.h |  2 +-
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 53e4e63c607e..ddf8e575e489 100644
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
index 2a4e7f4a8102..9f9b0762ff69 100644
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
@@ -361,10 +370,11 @@ static int nilfs_rename(struct mnt_idmap *idmap,
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
@@ -381,10 +391,12 @@ static int nilfs_rename(struct mnt_idmap *idmap,
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
 		inode_set_ctime_current(new_inode);
@@ -438,13 +450,14 @@ static int nilfs_rename(struct mnt_idmap *idmap,
  */
 static struct dentry *nilfs_get_parent(struct dentry *child)
 {
-	unsigned long ino;
+	ino_t ino;
+	int res;
 	struct inode *inode;
 	struct nilfs_root *root;
 
-	ino = nilfs_inode_by_name(d_inode(child), &dotdot_name);
-	if (!ino)
-		return ERR_PTR(-ENOENT);
+	res = nilfs_inode_by_name(d_inode(child), &dotdot_name, &ino);
+	if (res)
+		return ERR_PTR(res);
 
 	root = NILFS_I(d_inode(child))->i_root;
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 9a157e5051d0..ad13e74af65f 100644
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


