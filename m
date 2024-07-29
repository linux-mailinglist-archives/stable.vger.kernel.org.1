Return-Path: <stable+bounces-62541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F993F53F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19368B20BED
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514851487C6;
	Mon, 29 Jul 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrcUhYuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BB1474CF
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255846; cv=none; b=Bv+r6hrikNlGl/g4SyCRBI+uuGcs45wUNrXScEEAQWJk9gEb+pKFgIg3+gCZaIp1Go7eEu7Hh6fiCbhP12Jg4lfH9VocyvQQ78rb7kh9N/HCHq7mU9H0vikRjZirBGF+TL1FKKTkSCrn4EQo1xZDS7EvmXmHoHPyKUDthtT3r/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255846; c=relaxed/simple;
	bh=HEKFJMwfIOkWW64ItiwPXU1GodmLPoFIimytu/FzzOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pxFziwo7gP3i62EsYKMnRO4xcmNAyNJ3LyTV17p48ziXb0TwlFLsEQ5Vi3CpOeZjgjZiewS2Qhdvf+aaALZHpZjQI1pHHTO+wtNSDHfKhAnnJWwwH9DU4MltRR4WWfJcszw+DqzbKyqsNhlChlnZxnK652POC9JfoHg6SAq8dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrcUhYuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AFBC4AF10;
	Mon, 29 Jul 2024 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255845;
	bh=HEKFJMwfIOkWW64ItiwPXU1GodmLPoFIimytu/FzzOQ=;
	h=Subject:To:Cc:From:Date:From;
	b=RrcUhYuSv2Mh2ZVOnfhAFiCAXFPzVu+pdMKOVLW5usHt87QehVuPG3dECqZPXmbGx
	 WYngG+EvFmtxAtUyWrtfIYCy1KHfIuwtw+epKXjenaS9eAeSvJB/M0WJ52IBJzK90y
	 NE/Onrgz6vuEqUlXx+3VAh+jwcyFfqxMXl3K9Obk=
Subject: FAILED: patch "[PATCH] f2fs: use meta inode for GC of COW file" failed to apply to 6.1-stable tree
To: s_min.jeong@samsung.com,chao@kernel.org,jaegeuk@kernel.org,sj1557.seo@samsung.com,youngjin.gil@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:24:02 +0200
Message-ID: <2024072902-overnight-carried-32ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f18d0076933689775fe7faeeb10ee93ff01be6ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072902-overnight-carried-32ca@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f18d00769336 ("f2fs: use meta inode for GC of COW file")
b40a2b003709 ("f2fs: use meta inode for GC of atomic file")
9f0c4a46be1f ("f2fs: fix to truncate meta inode pages forcely")
fd244524c2cf ("f2fs: compress: fix to cover normal cluster write with cp_rwsem")
55fdc1c24a1d ("f2fs: fix to wait on block writeback for post_read case")
4e4f1eb9949b ("f2fs: introduce f2fs_invalidate_internal_cache() for cleanup")
a46bebd502fe ("f2fs: synchronize atomic write aborts")
2eae077e6e46 ("f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info")
ae267fc1cfe9 ("f2fs: fix to abort atomic write only during do_exist()")
e7547daccd6a ("f2fs: refactor extent_cache to support for read and more")
749d543c0d45 ("f2fs: remove unnecessary __init_extent_tree")
3bac20a8f011 ("f2fs: move internal functions into extent_cache.c")
12607c1ba763 ("f2fs: specify extent cache for read explicitly")
ed8ac22b6b75 ("f2fs: introduce f2fs_is_readonly() for readability")
41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
967eaad1fed5 ("f2fs: fix to set flush_merge opt and show noflush_merge")
4d8d45df2252 ("f2fs: correct i_size change for atomic writes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f18d0076933689775fe7faeeb10ee93ff01be6ab Mon Sep 17 00:00:00 2001
From: Sunmin Jeong <s_min.jeong@samsung.com>
Date: Wed, 10 Jul 2024 20:51:43 +0900
Subject: [PATCH] f2fs: use meta inode for GC of COW file

In case of the COW file, new updates and GC writes are already
separated to page caches of the atomic file and COW file. As some cases
that use the meta inode for GC, there are some race issues between a
foreground thread and GC thread.

To handle them, we need to take care when to invalidate and wait
writeback of GC pages in COW files as the case of using the meta inode.
Also, a pointer from the COW inode to the original inode is required to
check the state of original pages.

For the former, we can solve the problem by using the meta inode for GC
of COW files. Then let's get a page from the original inode in
move_data_block when GCing the COW file to avoid race condition.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e4937af50f3..6457e5bca9c9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2608,7 +2608,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (IS_NOQUOTA(inode))
 		return true;
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_used_in_atomic_write(inode))
 		return true;
 	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
 	if (f2fs_compressed_file(inode) &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 796ae11c0fa3..4a8621e4a33a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -843,7 +843,11 @@ struct f2fs_inode_info {
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
 					/* cached extent_tree entry */
-	struct inode *cow_inode;	/* copy-on-write inode for atomic write */
+	union {
+		struct inode *cow_inode;	/* copy-on-write inode for atomic write */
+		struct inode *atomic_inode;
+					/* point to atomic_inode, available only for cow_inode */
+	};
 
 	/* avoid racing between foreground op and gc */
 	struct f2fs_rwsem i_gc_rwsem[2];
@@ -4263,9 +4267,14 @@ static inline bool f2fs_post_read_required(struct inode *inode)
 		f2fs_compressed_file(inode);
 }
 
+static inline bool f2fs_used_in_atomic_write(struct inode *inode)
+{
+	return f2fs_is_atomic_file(inode) || f2fs_is_cow_file(inode);
+}
+
 static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
 {
-	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
+	return f2fs_post_read_required(inode) || f2fs_used_in_atomic_write(inode);
 }
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e4a7cff00796..547e7ec32b1f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2183,6 +2183,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 		set_inode_flag(fi->cow_inode, FI_COW_FILE);
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
+
+		/* Set the COW inode's atomic_inode to the atomic inode */
+		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cb3006551ab5..724bbcb447d3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1171,7 +1171,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 static int ra_data_block(struct inode *inode, pgoff_t index)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct address_space *mapping = inode->i_mapping;
+	struct address_space *mapping = f2fs_is_cow_file(inode) ?
+				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
 	struct dnode_of_data dn;
 	struct page *page;
 	struct f2fs_io_info fio = {
@@ -1260,6 +1261,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 static int move_data_block(struct inode *inode, block_t bidx,
 				int gc_type, unsigned int segno, int off)
 {
+	struct address_space *mapping = f2fs_is_cow_file(inode) ?
+				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
 		.ino = inode->i_ino,
@@ -1282,7 +1285,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
 
 	/* do not read out */
-	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
+	page = f2fs_grab_cache_page(mapping, bidx, false);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1fba5728be70..cca7d448e55c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -16,7 +16,7 @@
 
 static bool support_inline_data(struct inode *inode)
 {
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_used_in_atomic_write(inode))
 		return false;
 	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
 		return false;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7a3e2458b2d9..18dea43e694b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -804,8 +804,9 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_abort_atomic_write(inode, true);
 
-	if (fi->cow_inode) {
+	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
 		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
+		F2FS_I(fi->cow_inode)->atomic_inode = NULL;
 		iput(fi->cow_inode);
 		fi->cow_inode = NULL;
 	}


