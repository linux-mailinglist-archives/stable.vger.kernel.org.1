Return-Path: <stable+bounces-119731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A807A468CD
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00583170551
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5622A7F0;
	Wed, 26 Feb 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUFz/4W6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED5221F21
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592977; cv=none; b=WDZHNagiBG0yImfL/VfJivYCHKVG8wgqnJMpB88sn0oM2EnkjR9ohu0usD1UGHIM8ywWlogYlswal7fuaE4aAyG7XfIOUBiJk/uvC72vy+UEcG/XLmdiFzOXIKUpj0F/nCrrOXvlo78sQU5gzAYvWNa0aZPg/ZR+/WeLfnYz5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592977; c=relaxed/simple;
	bh=6Z9hOMlAQBlnFyRmpO0nHNkaXh6OCp2kvcpXkfjXKIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4Mgd6lf8MM87HcJHSKWPVikVoKzdeTasWFM2Pdpd2zx+vRrLHYOILuZh1n55iSCn+jzO03g/FK+Ai6Lep4PkCu1bpoQIKd9AvQ8wG0WGmkER7GFBVHuT7VaBlGsGkudbD1wasiZi/rObVD+q+PRkJZlUIMp/yZNWAnxjFvgGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUFz/4W6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2230c74c8b6so1366875ad.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592975; x=1741197775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjGqXA8AeMveWrjuWoCMDo+7Ra6K/g/9MSNGxw1WN7Q=;
        b=TUFz/4W69os80NEEWN6SSWkjrxEBr+uRCzawk2CjZmKfMwzrg9oNszWDEBcHBHPBSW
         Cy8R9CE1z3bnkwo5iXULBL2VVuy/vEyArTaTCPdeFBkx49qwHufj8c25KE9dV8VNJjWe
         SsfjleL8LykVjXbjJdAWFPFI8vyUTQMjq5n0jtNGA09haFZtA2/HwSnQ8g4PqJ1czZFn
         zALC7XLwoV6QKGgUA5qqM8eeDAh84mNZrsQU3nr8z4V0qEc14T48Ozd9dBegxV82QY8w
         aKWJuKu8zoQfI6bwNPaw/sD4j+6a4Y8cC6aATwsAVSus7ZfQIScMhC77esBCzJ+5R4yq
         +/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592975; x=1741197775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjGqXA8AeMveWrjuWoCMDo+7Ra6K/g/9MSNGxw1WN7Q=;
        b=XNbWPX7v7Yn1Lx1Fd04LiCAib+5R+x9x1i+dE5b0eq/DeqwrOHhY+WYZRj8VP5poUJ
         Nd46uiV4lIdxnwWXmQbdrlTGFvjQqSv6brFpQ3LlOun6Ndw2BMG2r2AMgp2jxn3Z/3z7
         h4pgXuDfDmKvk4daWEOjpQCpXYTjESrhgCiG1HdBir6g4Y9xq+MghuePC2fcjc+wfNq0
         vLZh8s+GV7YKRaiILvp+HU9HtVhXV4a5+qkvl8Vc2MkHJ/QmsMJFkZemJViis2m6CE0O
         8TUEHJv3lf+qnrzOwNODr21L4hmWliDfATaOz0WmM+LEc3RyRjHjloUV8hsOxlADfAV4
         RXwQ==
X-Gm-Message-State: AOJu0YzJo1rRsq58/9+uuwFu8e3T+e8bmSW/xBYcbsD8vdRYBSBI8PFn
	YtwXarC3MaGTKze6UgxylUOkIFYW+IOgU/6vudOyQ76k/tyBopCRnvrf8g==
X-Gm-Gg: ASbGncv61X7yUNKLOzOwke5H4A712YSS85RurXKB4uGCGkX5t+ZJrUGTpa7tr46Kdyv
	e++AAqUaGEwT9jkcmMiSKS1rmOTXo0nq/6rHZtYRw3nTYc/d8I1fjauVrQ16aPT7XirKjpbeVVT
	/GzALfuP6pjaYqMiPh71B9NfayqXxqI/Tjeh5wnDL2nWuUV7QBHr7i/8KnUCp2grG6Lwipj4xYf
	XWDBErZqr0unHoUlZdgKJcrk8l1/8U8md9GsTHFUasqn3ZGHHKpM9lsKVyWIVr7XgH8er9jY4+m
	0g5hqWpGRm/nybpP4VfAVz5t6+G5bOuFEhw0WJPopFRBloMqc8VNe/qcHO4Y+gYP0w==
X-Google-Smtp-Source: AGHT+IHDOqY5m66jwAD13IqRMqfjBlR1++YMS4VjeTdnRrkYkXVbhrBD2DoqCJPwfzlPEdBxWFM2Jg==
X-Received: by 2002:a17:903:1984:b0:223:4b88:77ff with SMTP id d9443c01a7336-2234b887eb6mr1836455ad.6.1740592974782;
        Wed, 26 Feb 2025 10:02:54 -0800 (PST)
Received: from carrot.. (i118-19-4-47.s41.a014.ap.plala.or.jp. [118.19.4.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000995sm35747655ad.46.2025.02.26.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:02:53 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 6.1 1/3] nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
Date: Thu, 27 Feb 2025 03:00:21 +0900
Message-ID: <20250226180247.4950-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
References: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 584db20c181f5e28c0386d7987406ace7fbd3e49 upstream.

Patch series "nilfs2: Folio conversions for directory paths".

This series applies page->folio conversions to nilfs2 directory
operations.  This reduces hidden compound_head() calls and also converts
deprecated kmap calls to kmap_local in the directory code.

Although nilfs2 does not yet support large folios, Matthew has done his
best here to include support for large folios, which will be needed for
devices with large block sizes.

This series corresponds to the second half of the original post [1], but
with two complementary patches inserted at the beginning and some
adjustments, to prevent a kmap_local constraint violation found during
testing with highmem mapping.

[1] https://lkml.kernel.org/r/20231106173903.1734114-1-willy@infradead.org

I have reviewed all changes and tested this for regular and small block
sizes, both on machines with and without highmem mapping.  No issues
found.

This patch (of 17):

In a few directory operations, the call to nilfs_put_page() for a page
obtained using nilfs_find_entry() or nilfs_dotdot() is hidden in
nilfs_set_link() and nilfs_delete_entry(), making it difficult to track
page release and preventing change of its call position.

By moving nilfs_put_page() out of these functions, this makes the page
get/put correspondence clearer and makes it easier to swap
nilfs_put_page() calls (and kunmap calls within them) when modifying
multiple directory entries simultaneously in nilfs_rename().

Also, update comments for nilfs_set_link() and nilfs_delete_entry() to
reflect changes in their behavior.

To make nilfs_put_page() visible from namei.c, this moves its definition
to nilfs.h and replaces existing equivalents to use it, but the exposure
of that definition is temporary and will be removed on a later kmap ->
kmap_local conversion.

Link: https://lkml.kernel.org/r/20231127143036.2425-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20231127143036.2425-2-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
---
 fs/nilfs2/dir.c   | 11 +----------
 fs/nilfs2/namei.c | 13 +++++++------
 fs/nilfs2/nilfs.h |  6 ++++++
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 889e3e570213..de040ab05d37 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -64,12 +64,6 @@ static inline unsigned int nilfs_chunk_size(struct inode *inode)
 	return inode->i_sb->s_blocksize;
 }
 
-static inline void nilfs_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /*
  * Return the offset into page `page_nr' of the last valid
  * byte in that page, plus one.
@@ -450,7 +444,6 @@ int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 	return 0;
 }
 
-/* Releases the page */
 void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct page *page, struct inode *inode)
 {
@@ -465,7 +458,6 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
-	nilfs_put_page(page);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 }
 
@@ -569,7 +561,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 
 /*
  * nilfs_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date. Releases the page.
+ * previous entry. Page is up-to-date.
  */
 int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 {
@@ -605,7 +597,6 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 	nilfs_commit_chunk(page, mapping, from, to);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 out:
-	nilfs_put_page(page);
 	return err;
 }
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index a14f6342a025..9283a707c013 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -297,6 +297,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
+	nilfs_put_page(page);
 	if (err)
 		goto out;
 
@@ -406,6 +407,7 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 			goto out_dir;
 		}
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		nilfs_put_page(new_page);
 		nilfs_mark_inode_dirty(new_dir);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
@@ -429,9 +431,11 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 	old_inode->i_ctime = current_time(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
+	nilfs_put_page(old_page);
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
+		nilfs_put_page(dir_page);
 		drop_nlink(old_dir);
 	}
 	nilfs_mark_inode_dirty(old_dir);
@@ -441,13 +445,10 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 	return err;
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		nilfs_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	nilfs_put_page(old_page);
 out:
 	nilfs_transaction_abort(old_dir->i_sb);
 	return err;
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 5a880b4edf3d..b577ca0575d7 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -243,6 +243,12 @@ extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
 extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
 			   struct page *, struct inode *);
 
+static inline void nilfs_put_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
+
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
 
-- 
2.43.5


