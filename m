Return-Path: <stable+bounces-118589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB81A3F63D
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01A716EECC
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EAC20B1F5;
	Fri, 21 Feb 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7/TLGhb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD771EEE9
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145139; cv=none; b=pEDWdcHJQ+H9JMpPsYFOn7OkIBOf7ZgpmTSfjyzfbs/fdMiGbNKEUDU03uis72p/U0jOaAmnQVbKYQlEzzWFwKEa/2Nn5YsHKv6328fB0UEcI5hOyWgfzCMYzz78ZzZQP9hpRvPUtJ5UG3jjCNFF0QxA0nAEwq4t3U3wh4wAqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145139; c=relaxed/simple;
	bh=R1/AjwQd2+FA80qhH24d5iay8yuMXpvR81LE1p6ojhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv3jyD07Wl8zIykawRMb92Vw2ZKjxA5mM0i+mArqF/WpUN9x5qTY50Kb3YdMjJH2+Wj2jve805CcbL1Khh+r0u/1Sk7rUnGljkadunxWP9Go3lml8uFhtcxGLBGvwt8oj0shatMgkg3IXPdXywMIPn7OwqcMU0WxGlbTad750U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7/TLGhb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221050f3f00so45111055ad.2
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 05:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145137; x=1740749937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NtcytCYnhG+ArALnzF/7pTBzJfJ2zvweZl0CAX5F8U=;
        b=k7/TLGhbWfQlZMr9xO/zSQorr/utQsyMlRLQWXAVLG+tmRFgKKHLa54aflatjbKoYP
         W2H78QKShu11+t7Q0G1UKdpkB7LA4vglkI9EKdKDVQHsK2NhFv//fIa0C1jivMTiO202
         qDyNjzUw9qECPd8p0ZDsqwLKUh2Jeew+Kh1BYxetV5Z3jb7clSb6UdcRjHenRYa4R3JG
         /oCC5tw6ORlJyoVl6SeljHV9LM5YgyYNcgnvCAhzkgqYede0ZiopFllRif9TMHHWzkly
         rF2cTxQ+EwcIap15ZCUQ+U+Uxa5xcZ5izy3qXArEnYW2t9mscHvIIJrOAk5+iBhkYS2A
         09Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145137; x=1740749937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NtcytCYnhG+ArALnzF/7pTBzJfJ2zvweZl0CAX5F8U=;
        b=MP4y9dzSqLMAA++t+HfzOKnVq5Jdyl1+X06zmUxnxtbW3DFL5n0j3eqbuYR9Mrl7KY
         FYL1z2XS2Qm1K+3uRoAsHVeZ+UiXHpmcnWI4NswlSgL5XSo5oZbxi3sC47gXpECLVlo0
         mvq2fmt12sqjAC6XXZRJCYGi2vt+65J/X3plLh4Wad6/uQ6OVNkwmdigHM9oITOw3XaF
         ERQi6oxPAdpkgS/vu5R6KaO6bsvrRzzcaUmG4OQRWaamrY/7fI9NN0tf8SdwoVniVhbZ
         GxbC+QoBIUhV53CEE+asI/bEoNVyTEm0ueU17V5+Hlvkv6yqptnj70LnHPmNTBBgSNtQ
         hxMg==
X-Gm-Message-State: AOJu0Yx4K/crOJdtqYjfWIjMo0f120Y48fsxc7a4D5CN/6NSe2sgdQBX
	8r9cNtwMSk3tg4lBP/JhizsXaVKvHhsbB+EOb09Y3wL3IHwYTnUYC4amow==
X-Gm-Gg: ASbGncsoSlQ5vraGOq2uP3jJjOSoZXY4kfTvOyoceqKyghk/mDzyWqDneFZ27U+3fNZ
	Xey8zrLGY8djIVdfWf4tE/xtVQB7LkO+79QSzxPPMA9S61OqYzGOspvt3Ieb1zbdW+mXO+ZH9mH
	GYyeqY/PbIg+tlqGXnNXgGjJhkAPI0lAu4fQfX2b4L2X1azrDP8Yno3F5RAwfZmOGDOMCyVJvQe
	Z4KMt3k4lIF9S4LfBiqbngWkb87UyFWmvzsnLc/QHuND3fsYJNvHGLZV25wKJF9YwELaeamKt/j
	+VSpXffWi+S/dKE39hbHSGcUZ5jlyMrBQwF2//795S3E+A9x4srJmH1tR+Fkq1TifS0lyu3M9w=
	=
X-Google-Smtp-Source: AGHT+IF45m8ebYmi4ns6IEKF7krabLpbNPhZzu7eapypPqzt9v9ZXQm/QD3j68lp4N4T+NBTT0WhFQ==
X-Received: by 2002:a17:902:e5d0:b0:21f:9107:fca3 with SMTP id d9443c01a7336-2219ff5efccmr43987075ad.30.1740145136817;
        Fri, 21 Feb 2025 05:38:56 -0800 (PST)
Received: from carrot.. (i121-113-18-240.s41.a014.ap.plala.or.jp. [121.113.18.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm137818645ad.7.2025.02.21.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:38:55 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 1/3] nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
Date: Fri, 21 Feb 2025 22:37:53 +0900
Message-ID: <20250221133848.4335-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
References: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
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
index 652279c8b168..c6dd8ef7d284 100644
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
 	dir->i_mtime = inode_set_ctime_current(dir);
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
 	inode->i_mtime = inode_set_ctime_current(inode);
 out:
-	nilfs_put_page(page);
 	return err;
 }
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index ac0adeb58e41..819ce16c793e 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -297,6 +297,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	err = nilfs_delete_entry(de, page);
+	nilfs_put_page(page);
 	if (err)
 		goto out;
 
@@ -406,6 +407,7 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			goto out_dir;
 		}
 		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		nilfs_put_page(new_page);
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -429,9 +431,11 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	inode_set_ctime_current(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
+	nilfs_put_page(old_page);
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
+		nilfs_put_page(dir_page);
 		drop_nlink(old_dir);
 	}
 	nilfs_mark_inode_dirty(old_dir);
@@ -441,13 +445,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
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
index e2c5376b56cd..fbf74c1cfd1d 100644
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


