Return-Path: <stable+bounces-203592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B8CE6F5B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D46300C6E9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466D1F4C8E;
	Mon, 29 Dec 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFw/Y/+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B411D5ADE
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016826; cv=none; b=OXHLxnKM03oJg96t+uLBA7D0xKG9UWf7XAlfs1C8susrfQne30zVURPCYvnZtrO3Wr0aksFdNjmY38VhuxPNTsdGiNVqyo6LWEC/EZwiqikiW6YfpXVOKpwIso/w3CmYnjQ0r28ElWExRMtFZoJ5sEBAtcvMpAXGWVJUT3i5R8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016826; c=relaxed/simple;
	bh=9x9j5/qhzrSnwJllFFUz+dw27F5M2uj4VOfQqH3ZMYY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F7Y6ZD6YtSzsxbhVG0ahYgjbrT6AjXm3YEFQ5pnsqKXFO8C66PgpwD62Bl12NkYpHM5+b1odWyr32o4GBoQiko6TV7ANjEagfFMlHWtyIvr76FAbzgCVmtZgK44qWNQ7YJuagZd+ur1eUVrBGGpVWVU3nSqWm1/O8QNY6ToceKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HFw/Y/+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00430C4CEF7;
	Mon, 29 Dec 2025 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016826;
	bh=9x9j5/qhzrSnwJllFFUz+dw27F5M2uj4VOfQqH3ZMYY=;
	h=Subject:To:Cc:From:Date:From;
	b=HFw/Y/+uqxcPrlYVwidn86/jYkcc7NePb7lNMynNQ1GGNF7Me/6FeuMPsNSjZAZbK
	 3l8wAa6eHGRp4T5N3WjWRBSe31jCzoIqv62xapfXy+6IG+kU+NvoWQtc1ir5WqQRrC
	 SxRbwQYwflLB32njWmOtyRAgi9015CBkQbsTKeE8=
Subject: FAILED: patch "[PATCH] f2fs: use global inline_xattr_slab instead of per-sb slab" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,yhong@link.cuhk.edu.hk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:00:21 +0100
Message-ID: <2025122921-skinhead-sensation-61a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1f27ef42bb0b7c0740c5616ec577ec188b8a1d05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122921-skinhead-sensation-61a1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f27ef42bb0b7c0740c5616ec577ec188b8a1d05 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 21 Oct 2025 11:48:56 +0800
Subject: [PATCH] f2fs: use global inline_xattr_slab instead of per-sb slab
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e69b01c1173a..9ca2124aac84 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1885,9 +1885,6 @@ struct f2fs_sb_info {
 	spinlock_t error_lock;			/* protect errors/stop_reason array */
 	bool error_dirty;			/* errors of sb is dirty */
 
-	struct kmem_cache *inline_xattr_slab;	/* inline xattr entry */
-	unsigned int inline_xattr_slab_size;	/* default inline xattr slab size */
-
 	/* For reclaimed segs statistics per each GC mode */
 	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
 	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d0b5791a1f8c..f76ba2b08be0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2027,7 +2027,6 @@ static void f2fs_put_super(struct super_block *sb)
 	kfree(sbi->raw_super);
 
 	f2fs_destroy_page_array_cache(sbi);
-	f2fs_destroy_xattr_caches(sbi);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
@@ -4975,13 +4974,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_iostat;
 
-	/* init per sbi slab cache */
-	err = f2fs_init_xattr_caches(sbi);
-	if (err)
-		goto free_percpu;
 	err = f2fs_init_page_array_cache(sbi);
 	if (err)
-		goto free_xattr_cache;
+		goto free_percpu;
 
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
@@ -5310,8 +5305,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->meta_inode = NULL;
 free_page_array_cache:
 	f2fs_destroy_page_array_cache(sbi);
-free_xattr_cache:
-	f2fs_destroy_xattr_caches(sbi);
 free_percpu:
 	destroy_percpu_info(sbi);
 free_iostat:
@@ -5514,10 +5507,15 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_create_casefold_cache();
 	if (err)
 		goto free_compress_cache;
-	err = register_filesystem(&f2fs_fs_type);
+	err = f2fs_init_xattr_cache();
 	if (err)
 		goto free_casefold_cache;
+	err = register_filesystem(&f2fs_fs_type);
+	if (err)
+		goto free_xattr_cache;
 	return 0;
+free_xattr_cache:
+	f2fs_destroy_xattr_cache();
 free_casefold_cache:
 	f2fs_destroy_casefold_cache();
 free_compress_cache:
@@ -5558,6 +5556,7 @@ static int __init init_f2fs_fs(void)
 static void __exit exit_f2fs_fs(void)
 {
 	unregister_filesystem(&f2fs_fs_type);
+	f2fs_destroy_xattr_cache();
 	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 58632a2b6613..b4e5c406632f 100644
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
@@ -830,25 +831,14 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
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
index 4fc0b2305fbd..bce3d93e4755 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -89,6 +89,8 @@ struct f2fs_xattr_entry {
 			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
 			DEF_INLINE_RESERVED_SIZE -			\
 			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
+#define DEFAULT_XATTR_SLAB_SIZE	(DEFAULT_INLINE_XATTR_ADDRS *		\
+				sizeof(__le32) + XATTR_PADDING_SIZE)
 
 /*
  * On-disk structure of f2fs_xattr
@@ -132,8 +134,8 @@ int f2fs_setxattr(struct inode *, int, const char *, const void *,
 int f2fs_getxattr(struct inode *, int, const char *, void *,
 		size_t, struct folio *);
 ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
-int f2fs_init_xattr_caches(struct f2fs_sb_info *);
-void f2fs_destroy_xattr_caches(struct f2fs_sb_info *);
+int __init f2fs_init_xattr_cache(void);
+void f2fs_destroy_xattr_cache(void);
 #else
 
 #define f2fs_xattr_handlers	NULL
@@ -150,8 +152,8 @@ static inline int f2fs_getxattr(struct inode *inode, int index,
 {
 	return -EOPNOTSUPP;
 }
-static inline int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
-static inline void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
+static inline int __init f2fs_init_xattr_cache(void) { return 0; }
+static inline void f2fs_destroy_xattr_cache(void) { }
 #endif
 
 #ifdef CONFIG_F2FS_FS_SECURITY


