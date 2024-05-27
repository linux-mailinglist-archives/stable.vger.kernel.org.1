Return-Path: <stable+bounces-47174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175A8D0CEB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF6F2875D7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36035168C4;
	Mon, 27 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4sU5Wnq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640215FD1E;
	Mon, 27 May 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837861; cv=none; b=MwtuRhf1T7NizfocK7TtCmiS3o3I8cWGLldoDtf8awWMleGObUBd2b9Hy97+Sm5QfFHRn84LR8iGSEYRoCxGHFVMkmIkxjbRY1x1c79hOWggI55g/eJRRu5w+smLgY1Jl3bO8fg+ZXsddoCvrJx6TL0spjArvBN6QDt0tpjMscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837861; c=relaxed/simple;
	bh=AcHFeG6iZJki8Sow9tHVGkYIHRfTnBuAz+xuEYmbU+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxhBo5wCoGoAQeSAF7juQhx4k3knsGlS60IlDfAmEQh3Y9Uvjr06Oy18WYM3EpVBlCJOd2cNRecYSJ2d7gsy0jRDmbxJJ+/IWwiAHE9AtXGYHTZyzMem6Zukh6QAUIwPYYrwcO/bezoexLGWNWsYSDnA8DSMe2EipgbWNKYUiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4sU5Wnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF32C2BBFC;
	Mon, 27 May 2024 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837860;
	bh=AcHFeG6iZJki8Sow9tHVGkYIHRfTnBuAz+xuEYmbU+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4sU5WnqVWOqWtSmMeV8rRmYA6oQBnbELIxEvz/FMb4f0b8XrRjHwxLFv1xqQfbqF
	 koWOM9N8D4Lr//BkyltAh3quzdZDmDyDjYYDXsw//14Wqz/OHqzF8xdqYEvQiT2NCQ
	 ZMm/Pc8bGDBqCfciq/2f7C5UKQ9STkYHTx//6dls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	kernel test robot <oliver.sang@intel.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 132/493] libfs: Convert simple directory offsets to use a Maple Tree
Date: Mon, 27 May 2024 20:52:14 +0200
Message-ID: <20240527185634.795397015@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 0e4a862174f2a8d1653a8a9cf0815020e1d3af24 ]

Test robot reports:
> kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
>
> commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Feng Tang further clarifies that:
> ... the new simple_offset_add()
> called by shmem_mknod() brings extra cost related with slab,
> specifically the 'radix_tree_node', which cause the regression.

Willy's analysis is that, over time, the test workload causes
xa_alloc_cyclic() to fragment the underlying SLAB cache.

This patch replaces the offset_ctx's xarray with a Maple Tree in the
hope that Maple Tree's dense node mode will handle this scenario
more scalably.

In addition, we can widen the simple directory offset maximum to
signed long (as loff_t is also signed).

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 23cdd0eed3f1 ("libfs: Fix simple_offset_rename_exchange()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/libfs.c         | 47 +++++++++++++++++++++++-----------------------
 include/linux/fs.h |  5 +++--
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f7f92a49a4182..d3d31197c8e43 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -245,17 +245,17 @@ enum {
 	DIR_OFFSET_MIN	= 2,
 };
 
-static void offset_set(struct dentry *dentry, u32 offset)
+static void offset_set(struct dentry *dentry, long offset)
 {
-	dentry->d_fsdata = (void *)((uintptr_t)(offset));
+	dentry->d_fsdata = (void *)offset;
 }
 
-static u32 dentry2offset(struct dentry *dentry)
+static long dentry2offset(struct dentry *dentry)
 {
-	return (u32)((uintptr_t)(dentry->d_fsdata));
+	return (long)dentry->d_fsdata;
 }
 
-static struct lock_class_key simple_offset_xa_lock;
+static struct lock_class_key simple_offset_lock_class;
 
 /**
  * simple_offset_init - initialize an offset_ctx
@@ -264,8 +264,8 @@ static struct lock_class_key simple_offset_xa_lock;
  */
 void simple_offset_init(struct offset_ctx *octx)
 {
-	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
-	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
+	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
+	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
 	octx->next_offset = DIR_OFFSET_MIN;
 }
 
@@ -274,20 +274,19 @@ void simple_offset_init(struct offset_ctx *octx)
  * @octx: directory offset ctx to be updated
  * @dentry: new dentry being added
  *
- * Returns zero on success. @so_ctx and the dentry offset are updated.
+ * Returns zero on success. @octx and the dentry's offset are updated.
  * Otherwise, a negative errno value is returned.
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
-	u32 offset;
+	unsigned long offset;
 	int ret;
 
 	if (dentry2offset(dentry) != 0)
 		return -EBUSY;
 
-	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
-			      &octx->next_offset, GFP_KERNEL);
+	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
+				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -303,13 +302,13 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
  */
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 {
-	u32 offset;
+	long offset;
 
 	offset = dentry2offset(dentry);
 	if (offset == 0)
 		return;
 
-	xa_erase(&octx->xa, offset);
+	mtree_erase(&octx->mt, offset);
 	offset_set(dentry, 0);
 }
 
@@ -332,7 +331,7 @@ int simple_offset_empty(struct dentry *dentry)
 
 	index = DIR_OFFSET_MIN;
 	octx = inode->i_op->get_offset_ctx(inode);
-	xa_for_each(&octx->xa, index, child) {
+	mt_for_each(&octx->mt, child, index, LONG_MAX) {
 		spin_lock(&child->d_lock);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
@@ -362,8 +361,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
-	u32 old_index = dentry2offset(old_dentry);
-	u32 new_index = dentry2offset(new_dentry);
+	long old_index = dentry2offset(old_dentry);
+	long new_index = dentry2offset(new_dentry);
 	int ret;
 
 	simple_offset_remove(old_ctx, old_dentry);
@@ -389,9 +388,9 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 
 out_restore:
 	offset_set(old_dentry, old_index);
-	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
+	mtree_store(&old_ctx->mt, old_index, old_dentry, GFP_KERNEL);
 	offset_set(new_dentry, new_index);
-	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
 	return ret;
 }
 
@@ -404,7 +403,7 @@ int simple_offset_rename_exchange(struct inode *old_dir,
  */
 void simple_offset_destroy(struct offset_ctx *octx)
 {
-	xa_destroy(&octx->xa);
+	mtree_destroy(&octx->mt);
 }
 
 /**
@@ -434,16 +433,16 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	/* In this case, ->private_data is protected by f_pos_lock */
 	file->private_data = NULL;
-	return vfs_setpos(file, offset, U32_MAX);
+	return vfs_setpos(file, offset, LONG_MAX);
 }
 
 static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 {
+	MA_STATE(mas, &octx->mt, offset, offset);
 	struct dentry *child, *found = NULL;
-	XA_STATE(xas, &octx->xa, offset);
 
 	rcu_read_lock();
-	child = xas_next_entry(&xas, U32_MAX);
+	child = mas_find(&mas, LONG_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -457,8 +456,8 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
-	u32 offset = dentry2offset(dentry);
 	struct inode *inode = d_inode(dentry);
+	long offset = dentry2offset(dentry);
 
 	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e684b9fa64819..3350f875ca91c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/maple_tree.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3259,8 +3260,8 @@ extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
 struct offset_ctx {
-	struct xarray		xa;
-	u32			next_offset;
+	struct maple_tree	mt;
+	unsigned long		next_offset;
 };
 
 void simple_offset_init(struct offset_ctx *octx);
-- 
2.43.0




