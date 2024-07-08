Return-Path: <stable+bounces-58208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13692A1A7
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D9E1F224DE
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A73C73461;
	Mon,  8 Jul 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ol7Q5XJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40D7C081
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439543; cv=none; b=OshIDTFMR1TQOGxcYpP+u3CmI66ptEFLxYqjudvpTelej5Xu+aZrTKLzEUJ3IBQPd9PtIXy+0XtcWdgc/EAKafyLtamsZvYUdligsL3oopt2n/4t8Eq5KMOS9bmsU3iSVzDjWlAZNT64wRPFlCcQlvE0ORy5TLrWQ0TSd2YLTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439543; c=relaxed/simple;
	bh=Wvduei4nRQ/Amjsyy7BHh0epnZ//33Drn/adSWY4BT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BIov0rtldD6WTlkprYKeEC+kcN2nuUEoBRIFJgF3C/1OSSJ2Ma7znYnsqFLuxrcw+YGIxIQgHTnQdg/KgLiWm4siqQoYzYsz39ImdU60h32pphhlk0XZD1kOOKXppAnekqXkLNj2ga6L+8WbQDyP0R/qdy+wET3ObyNHsBjNcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ol7Q5XJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652E1C116B1;
	Mon,  8 Jul 2024 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720439543;
	bh=Wvduei4nRQ/Amjsyy7BHh0epnZ//33Drn/adSWY4BT4=;
	h=Subject:To:Cc:From:Date:From;
	b=ol7Q5XJwev9K83V3NCWr44HGMK/W6yTloZY+gL6UlqGqDhhvChj/Etps5YbHz0BZP
	 q3y15VK8RiZTzgLkjI0/liMX1CHyh/OIfqoXVklMoqY8e0ZLUaK+IOVfw8Dijy4FQf
	 1yNHXwnA86Unkhf2IMk65AkhQA6At+w3Nqh07Txg=
Subject: FAILED: patch "[PATCH] nilfs2: fix incorrect inode allocation from reserved inodes" failed to apply to 4.19-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,hdanton@sina.com,jack@suse.cz,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 13:52:11 +0200
Message-ID: <2024070811-tutor-disinfect-e4e6@gregkh>
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
git cherry-pick -x 93aef9eda1cea9e84ab2453fcceb8addad0e46f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070811-tutor-disinfect-e4e6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

93aef9eda1ce ("nilfs2: fix incorrect inode allocation from reserved inodes")
af6eae646851 ("nilfs2: convert persistent object allocator to use kmap_local")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93aef9eda1cea9e84ab2453fcceb8addad0e46f1 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 23 Jun 2024 14:11:35 +0900
Subject: [PATCH] nilfs2: fix incorrect inode allocation from reserved inodes

If the bitmap block that manages the inode allocation status is corrupted,
nilfs_ifile_create_inode() may allocate a new inode from the reserved
inode area where it should not be allocated.

Previous fix commit d325dc6eb763 ("nilfs2: fix use-after-free bug of
struct nilfs_root"), fixed the problem that reserved inodes with inode
numbers less than NILFS_USER_INO (=11) were incorrectly reallocated due to
bitmap corruption, but since the start number of non-reserved inodes is
read from the super block and may change, in which case inode allocation
may occur from the extended reserved inode area.

If that happens, access to that inode will cause an IO error, causing the
file system to degrade to an error state.

Fix this potential issue by adding a wraparound option to the common
metadata object allocation routine and by modifying
nilfs_ifile_create_inode() to disable the option so that it only allocates
inodes with inode numbers greater than or equal to the inode number read
in "nilfs->ns_first_ino", regardless of the bitmap status of reserved
inodes.

Link: https://lkml.kernel.org/r/20240623051135.4180-4-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 89caef7513db..ba50388ee4bf 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -377,11 +377,12 @@ void *nilfs_palloc_block_get_entry(const struct inode *inode, __u64 nr,
  * @target: offset number of an entry in the group (start point)
  * @bsize: size in bits
  * @lock: spin lock protecting @bitmap
+ * @wrap: whether to wrap around
  */
 static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 					    unsigned long target,
 					    unsigned int bsize,
-					    spinlock_t *lock)
+					    spinlock_t *lock, bool wrap)
 {
 	int pos, end = bsize;
 
@@ -397,6 +398,8 @@ static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 
 		end = target;
 	}
+	if (!wrap)
+		return -ENOSPC;
 
 	/* wrap around */
 	for (pos = 0; pos < end; pos++) {
@@ -495,9 +498,10 @@ int nilfs_palloc_count_max_entries(struct inode *inode, u64 nused, u64 *nmaxp)
  * nilfs_palloc_prepare_alloc_entry - prepare to allocate a persistent object
  * @inode: inode of metadata file using this allocator
  * @req: nilfs_palloc_req structure exchanged for the allocation
+ * @wrap: whether to wrap around
  */
 int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
-				     struct nilfs_palloc_req *req)
+				     struct nilfs_palloc_req *req, bool wrap)
 {
 	struct buffer_head *desc_bh, *bitmap_bh;
 	struct nilfs_palloc_group_desc *desc;
@@ -516,7 +520,7 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 	entries_per_group = nilfs_palloc_entries_per_group(inode);
 
 	for (i = 0; i < ngroups; i += n) {
-		if (group >= ngroups) {
+		if (group >= ngroups && wrap) {
 			/* wrap around */
 			group = 0;
 			maxgroup = nilfs_palloc_group(inode, req->pr_entry_nr,
@@ -550,7 +554,14 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 			bitmap_kaddr = kmap_local_page(bitmap_bh->b_page);
 			bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
 			pos = nilfs_palloc_find_available_slot(
-				bitmap, group_offset, entries_per_group, lock);
+				bitmap, group_offset, entries_per_group, lock,
+				wrap);
+			/*
+			 * Since the search for a free slot in the second and
+			 * subsequent bitmap blocks always starts from the
+			 * beginning, the wrap flag only has an effect on the
+			 * first search.
+			 */
 			kunmap_local(bitmap_kaddr);
 			if (pos >= 0)
 				goto found;
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index b667e869ac07..d825a9faca6d 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -50,8 +50,8 @@ struct nilfs_palloc_req {
 	struct buffer_head *pr_entry_bh;
 };
 
-int nilfs_palloc_prepare_alloc_entry(struct inode *,
-				     struct nilfs_palloc_req *);
+int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
+				     struct nilfs_palloc_req *req, bool wrap);
 void nilfs_palloc_commit_alloc_entry(struct inode *,
 				     struct nilfs_palloc_req *);
 void nilfs_palloc_abort_alloc_entry(struct inode *, struct nilfs_palloc_req *);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 180fc8d36213..fc1caf63a42a 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -75,7 +75,7 @@ int nilfs_dat_prepare_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 {
 	int ret;
 
-	ret = nilfs_palloc_prepare_alloc_entry(dat, req);
+	ret = nilfs_palloc_prepare_alloc_entry(dat, req, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index 612e609158b5..1e86b9303b7c 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -56,13 +56,10 @@ int nilfs_ifile_create_inode(struct inode *ifile, ino_t *out_ino,
 	struct nilfs_palloc_req req;
 	int ret;
 
-	req.pr_entry_nr = 0;  /*
-			       * 0 says find free inode from beginning
-			       * of a group. dull code!!
-			       */
+	req.pr_entry_nr = NILFS_FIRST_INO(ifile->i_sb);
 	req.pr_entry_bh = NULL;
 
-	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req);
+	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req, false);
 	if (!ret) {
 		ret = nilfs_palloc_get_entry_block(ifile, req.pr_entry_nr, 1,
 						   &req.pr_entry_bh);


