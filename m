Return-Path: <stable+bounces-62540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785AA93F53A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2209F2811AB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC331147C86;
	Mon, 29 Jul 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rKWQHcTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36C147C71
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255835; cv=none; b=Lr2hTNRsl3MxsCQQIcyvuIstsa+kE5t6LfysU9b2DWKrseIUpnUsHUFS7RtUW8Y1WoT1zEX/gCDoqXZ45biLxCf5phrhD28z2WQUd8hatk9CqSaenXi2Hq2LJqYNLFdQo85fcO0bPXKZo6CJAPWAPgP/eRB/S+hNNOH3xQaVuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255835; c=relaxed/simple;
	bh=LcgnUOxYq9o0yJIArpEADB57ZbGyfzQGjmVrLqflhRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K635EQTfB1ljUF6IQznoUnxAaZ0iJdh1AgTyivlxEChOkjDVWYo/OXyqqz6mzmMfkIeLXunc27ICxZ7XVDJK86J2IX+fY65e3I9DzfhAOQCXLX6ndOO3fIJwcT+QEtP7Bn15snwy2lER4WGpTUd0uwY7zOp0ZblCeVdC7CWvyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rKWQHcTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88808C32786;
	Mon, 29 Jul 2024 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255835;
	bh=LcgnUOxYq9o0yJIArpEADB57ZbGyfzQGjmVrLqflhRU=;
	h=Subject:To:Cc:From:Date:From;
	b=rKWQHcTsQ0eEeL0wEjxpdoV3vQh1U6ajZY5WQR0KgNOz7A3y4v9Y8pxU4PKGupTtk
	 ulPRScbkeBzlL+xhhqeqNYTiEclyOSrzNWvuon04tYg3JMWVxCEn/KY60pzOO2DYPy
	 bARXEMP4Mc/ouZ6clPIZwdjismM0xLBEI9Ww+RkU=
Subject: FAILED: patch "[PATCH] f2fs: use meta inode for GC of atomic file" failed to apply to 6.1-stable tree
To: s_min.jeong@samsung.com,chao@kernel.org,jaegeuk@kernel.org,sj1557.seo@samsung.com,youngjin.gil@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:23:46 +0200
Message-ID: <2024072946-footpad-posh-e008@gregkh>
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
git cherry-pick -x b40a2b00370931b0c50148681dd7364573e52e6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072946-footpad-posh-e008@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b40a2b003709 ("f2fs: use meta inode for GC of atomic file")
9f0c4a46be1f ("f2fs: fix to truncate meta inode pages forcely")
fd244524c2cf ("f2fs: compress: fix to cover normal cluster write with cp_rwsem")
55fdc1c24a1d ("f2fs: fix to wait on block writeback for post_read case")
4e4f1eb9949b ("f2fs: introduce f2fs_invalidate_internal_cache() for cleanup")
2eae077e6e46 ("f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info")
ed8ac22b6b75 ("f2fs: introduce f2fs_is_readonly() for readability")
967eaad1fed5 ("f2fs: fix to set flush_merge opt and show noflush_merge")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b40a2b00370931b0c50148681dd7364573e52e6b Mon Sep 17 00:00:00 2001
From: Sunmin Jeong <s_min.jeong@samsung.com>
Date: Wed, 10 Jul 2024 20:51:17 +0900
Subject: [PATCH] f2fs: use meta inode for GC of atomic file

The page cache of the atomic file keeps new data pages which will be
stored in the COW file. It can also keep old data pages when GCing the
atomic file. In this case, new data can be overwritten by old data if a
GC thread sets the old data page as dirty after new data page was
evicted.

Also, since all writes to the atomic file are redirected to COW inodes,
GC for the atomic file is not working well as below.

f2fs_gc(gc_type=FG_GC)
  - select A as a victim segment
  do_garbage_collect
    - iget atomic file's inode for block B
    move_data_page
      f2fs_do_write_data_page
        - use dn of cow inode
        - set fio->old_blkaddr from cow inode
    - seg_freed is 0 since block B is still valid
  - goto gc_more and A is selected as victim again

To solve the problem, let's separate GC writes and updates in the atomic
file by using the meta inode for GC writes.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1aa7eefa659c..1e4937af50f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2695,7 +2695,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	}
 
 	/* wait for GCed page writeback via META_MAPPING */
-	if (fio->post_read)
+	if (fio->meta_gc)
 		f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
 	/*
@@ -2790,7 +2790,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.submitted = 0,
 		.compr_blocks = compr_blocks,
 		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
-		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
+		.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7ee6c5e371e..796ae11c0fa3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1211,7 +1211,7 @@ struct f2fs_io_info {
 	unsigned int in_list:1;		/* indicate fio is in io_list */
 	unsigned int is_por:1;		/* indicate IO is from recovery or not */
 	unsigned int encrypted:1;	/* indicate file is encrypted */
-	unsigned int post_read:1;	/* require post read */
+	unsigned int meta_gc:1;		/* require meta inode GC */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
@@ -4263,6 +4263,11 @@ static inline bool f2fs_post_read_required(struct inode *inode)
 		f2fs_compressed_file(inode);
 }
 
+static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
+{
+	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
+}
+
 /*
  * compress.c
  */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ef667fec9a12..cb3006551ab5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1589,7 +1589,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
 								ofs_in_node;
 
-			if (f2fs_post_read_required(inode)) {
+			if (f2fs_meta_inode_gc_required(inode)) {
 				int err = ra_data_block(inode, start_bidx);
 
 				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -1640,7 +1640,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
-			if (f2fs_post_read_required(inode))
+			if (f2fs_meta_inode_gc_required(inode))
 				err = move_data_block(inode, start_bidx,
 							gc_type, segno, off);
 			else
@@ -1648,7 +1648,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 								segno, off);
 
 			if (!err && (gc_type == FG_GC ||
-					f2fs_post_read_required(inode)))
+					f2fs_meta_inode_gc_required(inode)))
 				submitted++;
 
 			if (locked) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 64b11d88a21c..78c3198a6308 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3859,7 +3859,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	if (fio->post_read)
+	if (fio->meta_gc)
 		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
@@ -4029,7 +4029,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *cpage;
 
-	if (!f2fs_post_read_required(inode))
+	if (!f2fs_meta_inode_gc_required(inode))
 		return;
 
 	if (!__is_valid_data_blkaddr(blkaddr))
@@ -4048,7 +4048,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
-	if (!f2fs_post_read_required(inode))
+	if (!f2fs_meta_inode_gc_required(inode))
 		return;
 
 	for (i = 0; i < len; i++)


