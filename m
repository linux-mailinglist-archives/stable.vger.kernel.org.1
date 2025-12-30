Return-Path: <stable+bounces-204285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E0CEA910
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75D43300D313
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F03195E4;
	Tue, 30 Dec 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKBm6R1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677C2F1FD5
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124519; cv=none; b=TjqjiuDSQNgs5MqME9jUc8Xs8R/PIEpPDa/F54HdTC0cvvi5os6faqHozop59ElriFLfiIe82I3idGP/R5Nykn9zmwPuPvu/Td48YAc1YiqjQgCLcp/IFS5ZyV+vUSQrimkA+QKb0PEPC/NHGPE36K08AI7uzGXkm6BaqTaJ1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124519; c=relaxed/simple;
	bh=nejhAwr8q8eMBtRldFxk6r/L8Lu00LwTRf6bAfWVwiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWshbKfKu+sa/Bp+OavV0ImyzIYgxyrkHg2hvmVnsa/zQXQW4fBac49mJ5idIbrXM9gEVtb4qc+v0dE0EZ79pU7wsT83IjSjULv2FtwiA5GXqcGomNszR/mePE823aoEiezQfdQR/bpRIEFDxWBEeDPFW/SPoq1JJiqIAfLWASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKBm6R1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B17C4CEFB;
	Tue, 30 Dec 2025 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767124519;
	bh=nejhAwr8q8eMBtRldFxk6r/L8Lu00LwTRf6bAfWVwiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKBm6R1oSClbiTAmjDlRaaWlOUIU8hy8PTAZ/ywbdiiwxbpwL8FysEKonaCm3Ouzk
	 C59rUpp8NJNI0sTF4k15tDFQX/tELPK4HmutLa8Y9+Gwb//KAhhfstTf0kpIhfkk6n
	 7uT0LEs+KpKfiMKTvXsKDYc631lkz2aAtv13fU6xJfkyYL2nl2WShDe8C1BCe48llG
	 EE/gPvky5R5/7WxOnOvRatu1JWGhRkYCuBGJblsxmmBg4lUl5G8Omb/AgFxUlu4lGR
	 YWr0MVP3Gvrq6lC5kouMjh534KRycndXBEFoWRn2udV/FI3FsG9ifVb1Rxd0TsBYEd
	 5tk2Z76XXKqoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Hong Yun <yhong@link.cuhk.edu.hk>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: use global inline_xattr_slab instead of per-sb slab cache
Date: Tue, 30 Dec 2025 14:55:17 -0500
Message-ID: <20251230195517.2448220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122923-untie-obscure-aaff@gregkh>
References: <2025122923-untie-obscure-aaff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 1f27ef42bb0b7c0740c5616ec577ec188b8a1d05 ]

As Hong Yun reported in mailing list:

loop7: detected capacity change from 0 to 131072
------------[ cut here ]------------
kmem_cache of name 'f2fs_xattr_entry-7:7' already exists
WARNING: CPU: 0 PID: 24426 at mm/slab_common.c:110 kmem_cache_sanity_check mm/slab_common.c:109 [inline]
WARNING: CPU: 0 PID: 24426 at mm/slab_common.c:110 __kmem_cache_create_args+0xa6/0x320 mm/slab_common.c:307
CPU: 0 UID: 0 PID: 24426 Comm: syz.7.1370 Not tainted 6.17.0-rc4 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:109 [inline]
RIP: 0010:__kmem_cache_create_args+0xa6/0x320 mm/slab_common.c:307
Call Trace:
 __kmem_cache_create include/linux/slab.h:353 [inline]
 f2fs_kmem_cache_create fs/f2fs/f2fs.h:2943 [inline]
 f2fs_init_xattr_caches+0xa5/0xe0 fs/f2fs/xattr.c:843
 f2fs_fill_super+0x1645/0x2620 fs/f2fs/super.c:4918
 get_tree_bdev_flags+0x1fb/0x260 fs/super.c:1692
 vfs_get_tree+0x43/0x140 fs/super.c:1815
 do_new_mount+0x201/0x550 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x298/0x2f0 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x8e/0x3a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The bug can be reproduced w/ below scripts:
- mount /dev/vdb /mnt1
- mount /dev/vdc /mnt2
- umount /mnt1
- mounnt /dev/vdb /mnt1

The reason is if we created two slab caches, named f2fs_xattr_entry-7:3
and f2fs_xattr_entry-7:7, and they have the same slab size. Actually,
slab system will only create one slab cache core structure which has
slab name of "f2fs_xattr_entry-7:3", and two slab caches share the same
structure and cache address.

So, if we destroy f2fs_xattr_entry-7:3 cache w/ cache address, it will
decrease reference count of slab cache, rather than release slab cache
entirely, since there is one more user has referenced the cache.

Then, if we try to create slab cache w/ name "f2fs_xattr_entry-7:3" again,
slab system will find that there is existed cache which has the same name
and trigger the warning.

Let's changes to use global inline_xattr_slab instead of per-sb slab cache
for fixing.

Fixes: a999150f4fe3 ("f2fs: use kmem_cache pool during inline xattr lookups")
Cc: stable@kernel.org
Reported-by: Hong Yun <yhong@link.cuhk.edu.hk>
Tested-by: Hong Yun <yhong@link.cuhk.edu.hk>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ folio => page + different module init/exit ordering ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  |  3 ---
 fs/f2fs/super.c | 15 +++++++--------
 fs/f2fs/xattr.c | 32 +++++++++++---------------------
 fs/f2fs/xattr.h | 10 ++++++----
 4 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5475d017ad1e..31968257ad8e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1763,9 +1763,6 @@ struct f2fs_sb_info {
 
 	struct workqueue_struct *post_read_wq;	/* post read workqueue */
 
-	struct kmem_cache *inline_xattr_slab;	/* inline xattr entry */
-	unsigned int inline_xattr_slab_size;	/* default inline xattr slab size */
-
 	/* For reclaimed segs statistics per each GC mode */
 	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
 	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b9da3074a1af..e8488b3517c9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1655,7 +1655,6 @@ static void f2fs_put_super(struct super_block *sb)
 
 	destroy_device_list(sbi);
 	f2fs_destroy_page_array_cache(sbi);
-	f2fs_destroy_xattr_caches(sbi);
 	mempool_destroy(sbi->write_io_dummy);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
@@ -4166,13 +4165,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	/* init per sbi slab cache */
-	err = f2fs_init_xattr_caches(sbi);
-	if (err)
-		goto free_io_dummy;
 	err = f2fs_init_page_array_cache(sbi);
 	if (err)
-		goto free_xattr_cache;
+		goto free_io_dummy;
 
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
@@ -4488,8 +4483,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->meta_inode = NULL;
 free_page_array_cache:
 	f2fs_destroy_page_array_cache(sbi);
-free_xattr_cache:
-	f2fs_destroy_xattr_caches(sbi);
 free_io_dummy:
 	mempool_destroy(sbi->write_io_dummy);
 free_percpu:
@@ -4656,7 +4649,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_create_casefold_cache();
 	if (err)
 		goto free_compress_cache;
+	err = f2fs_init_xattr_cache();
+	if (err)
+		goto free_casefold_cache;
 	return 0;
+free_casefold_cache:
+	f2fs_destroy_casefold_cache();
 free_compress_cache:
 	f2fs_destroy_compress_cache();
 free_compress_mempool:
@@ -4696,6 +4694,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	f2fs_destroy_xattr_cache();
 	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 6bc8efda406a..4f49b660f9b6 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -23,11 +23,12 @@
 #include "xattr.h"
 #include "segment.h"
 
+static struct kmem_cache *inline_xattr_slab;
 static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
 {
-	if (likely(size == sbi->inline_xattr_slab_size)) {
+	if (likely(size == DEFAULT_XATTR_SLAB_SIZE)) {
 		*is_inline = true;
-		return f2fs_kmem_cache_alloc(sbi->inline_xattr_slab,
+		return f2fs_kmem_cache_alloc(inline_xattr_slab,
 					GFP_F2FS_ZERO, false, sbi);
 	}
 	*is_inline = false;
@@ -38,7 +39,7 @@ static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
 							bool is_inline)
 {
 	if (is_inline)
-		kmem_cache_free(sbi->inline_xattr_slab, xattr_addr);
+		kmem_cache_free(inline_xattr_slab, xattr_addr);
 	else
 		kfree(xattr_addr);
 }
@@ -818,25 +819,14 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	return err;
 }
 
-int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi)
+int __init f2fs_init_xattr_cache(void)
 {
-	dev_t dev = sbi->sb->s_bdev->bd_dev;
-	char slab_name[32];
-
-	sprintf(slab_name, "f2fs_xattr_entry-%u:%u", MAJOR(dev), MINOR(dev));
-
-	sbi->inline_xattr_slab_size = F2FS_OPTION(sbi).inline_xattr_size *
-					sizeof(__le32) + XATTR_PADDING_SIZE;
-
-	sbi->inline_xattr_slab = f2fs_kmem_cache_create(slab_name,
-					sbi->inline_xattr_slab_size);
-	if (!sbi->inline_xattr_slab)
-		return -ENOMEM;
-
-	return 0;
+	inline_xattr_slab = f2fs_kmem_cache_create("f2fs_xattr_entry",
+					DEFAULT_XATTR_SLAB_SIZE);
+	return inline_xattr_slab ? 0 : -ENOMEM;
 }
 
-void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi)
+void f2fs_destroy_xattr_cache(void)
 {
-	kmem_cache_destroy(sbi->inline_xattr_slab);
-}
+	kmem_cache_destroy(inline_xattr_slab);
+}
\ No newline at end of file
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 416d652774a3..c1d3b3520ea6 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -88,6 +88,8 @@ struct f2fs_xattr_entry {
 			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
 			DEF_INLINE_RESERVED_SIZE -			\
 			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
+#define DEFAULT_XATTR_SLAB_SIZE	(DEFAULT_INLINE_XATTR_ADDRS *		\
+				sizeof(__le32) + XATTR_PADDING_SIZE)
 
 /*
  * On-disk structure of f2fs_xattr
@@ -131,8 +133,8 @@ extern int f2fs_setxattr(struct inode *, int, const char *,
 extern int f2fs_getxattr(struct inode *, int, const char *, void *,
 						size_t, struct page *);
 extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
-extern int f2fs_init_xattr_caches(struct f2fs_sb_info *);
-extern void f2fs_destroy_xattr_caches(struct f2fs_sb_info *);
+int __init f2fs_init_xattr_cache(void);
+void f2fs_destroy_xattr_cache(void);
 #else
 
 #define f2fs_xattr_handlers	NULL
@@ -149,8 +151,8 @@ static inline int f2fs_getxattr(struct inode *inode, int index,
 {
 	return -EOPNOTSUPP;
 }
-static inline int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
-static inline void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
+static inline int __init f2fs_init_xattr_cache(void) { return 0; }
+static inline void f2fs_destroy_xattr_cache(void) { }
 #endif
 
 #ifdef CONFIG_F2FS_FS_SECURITY
-- 
2.51.0


