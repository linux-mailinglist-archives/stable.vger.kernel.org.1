Return-Path: <stable+bounces-78503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF198BEA9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CE01F22152
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D41C7B75;
	Tue,  1 Oct 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2li24Vt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8801C57AB
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791001; cv=none; b=I9PdJ3+7d7Gnfc3EX2FmKw5NB5cYDZ5s+MRhf5VLDimE9rcz1DB8lT/ctF5pB9DPFf0LZh7Y9BgB8rnz6bbMlj1UyaK6K2vnw6djSUa0LYM7PHRsVLUNQIeF8djscrIlR2+fDbQrqH0DaprzbiVzpDwi5jUt15dK/JT07qMGXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791001; c=relaxed/simple;
	bh=9VWGvKwOQnkUgvinZkTpo1fqAV0rXGD4vmXmDig/5Zw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BBDFTgvpaltLMOipk4I0nc+aEvkpTDhQl3OEgUB2tugWFdFku8qRChIckfszLvm3ItXaozgmnwdztjt2Lze+tGzozOyyVPigJTsBsZi5G7UIQBfxXG8yejkIUvNcXyiakpvh1UeDoXfjkq3H6aIrSktsNUFi7k5SFi2c3mZF8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2li24Vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7A9C4CEC6;
	Tue,  1 Oct 2024 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791000;
	bh=9VWGvKwOQnkUgvinZkTpo1fqAV0rXGD4vmXmDig/5Zw=;
	h=Subject:To:Cc:From:Date:From;
	b=D2li24VtxmF3E/xa4vvTVvSK+cL3cAaX5vdrcId6bp3EOv/KBjl6XFgZWPrbbWZAJ
	 ZpjD3IilK7xAimo5v+MPWRelYfKpQSTyZ5pVWg1GXeUIA60l22CiQhEHyTy6etAplO
	 cDWpIf10p6Y9ceL+0iPNvmZ0upX9pwiujHMQtde0=
Subject: FAILED: patch "[PATCH] btrfs: fix race setting file private on concurrent lseek" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,dsterba@suse.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 15:56:32 +0200
Message-ID: <2024100131-uncharted-flyaway-8acd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7ee85f5515e86a4e2a2f51969795920733912bad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100131-uncharted-flyaway-8acd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

7ee85f5515e8 ("btrfs: fix race setting file private on concurrent lseek using same fd")
68539bd0e73b ("btrfs: update comment for struct btrfs_inode::lock")
398fb9131f31 ("btrfs: reorder btrfs_inode to fill gaps")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ee85f5515e86a4e2a2f51969795920733912bad Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Tue, 3 Sep 2024 10:55:36 +0100
Subject: [PATCH] btrfs: fix race setting file private on concurrent lseek
 using same fd

When doing concurrent lseek(2) system calls against the same file
descriptor, using multiple threads belonging to the same process, we have
a short time window where a race happens and can result in a memory leak.

The race happens like this:

1) A program opens a file descriptor for a file and then spawns two
   threads (with the pthreads library for example), lets call them
   task A and task B;

2) Task A calls lseek with SEEK_DATA or SEEK_HOLE and ends up at
   file.c:find_desired_extent() while holding a read lock on the inode;

3) At the start of find_desired_extent(), it extracts the file's
   private_data pointer into a local variable named 'private', which has
   a value of NULL;

4) Task B also calls lseek with SEEK_DATA or SEEK_HOLE, locks the inode
   in shared mode and enters file.c:find_desired_extent(), where it also
   extracts file->private_data into its local variable 'private', which
   has a NULL value;

5) Because it saw a NULL file private, task A allocates a private
   structure and assigns to the file structure;

6) Task B also saw a NULL file private so it also allocates its own file
   private and then assigns it to the same file structure, since both
   tasks are using the same file descriptor.

   At this point we leak the private structure allocated by task A.

Besides the memory leak, there's also the detail that both tasks end up
using the same cached state record in the private structure (struct
btrfs_file_private::llseek_cached_state), which can result in a
use-after-free problem since one task can free it while the other is
still using it (only one task took a reference count on it). Also, sharing
the cached state is not a good idea since it could result in incorrect
results in the future - right now it should not be a problem because it
end ups being used only in extent-io-tree.c:count_range_bits() where we do
range validation before using the cached state.

Fix this by protecting the private assignment and check of a file while
holding the inode's spinlock and keep track of the task that allocated
the private, so that it's used only by that task in order to prevent
user-after-free issues with the cached state record as well as potentially
using it incorrectly in the future.

Fixes: 3c32c7212f16 ("btrfs: use cached state when looking for delalloc ranges with lseek")
CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9a4b7c119318..e152fde888fc 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -152,6 +152,7 @@ struct btrfs_inode {
 	 * logged_trans), to access/update delalloc_bytes, new_delalloc_bytes,
 	 * defrag_bytes, disk_i_size, outstanding_extents, csum_bytes and to
 	 * update the VFS' inode number of bytes used.
+	 * Also protects setting struct file::private_data.
 	 */
 	spinlock_t lock;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1a44fb9845e3..317a3712270f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -463,6 +463,8 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
+	/* Task that allocated this structure. */
+	struct task_struct *owner_task;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c5e36f58eb07..4fb521d91b06 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3485,7 +3485,7 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
 static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 {
 	struct btrfs_inode *inode = BTRFS_I(file->f_mapping->host);
-	struct btrfs_file_private *private = file->private_data;
+	struct btrfs_file_private *private;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
 	struct extent_state **delalloc_cached_state;
@@ -3513,7 +3513,19 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	    inode_get_bytes(&inode->vfs_inode) == i_size)
 		return i_size;
 
-	if (!private) {
+	spin_lock(&inode->lock);
+	private = file->private_data;
+	spin_unlock(&inode->lock);
+
+	if (private && private->owner_task != current) {
+		/*
+		 * Not allocated by us, don't use it as its cached state is used
+		 * by the task that allocated it and we don't want neither to
+		 * mess with it nor get incorrect results because it reflects an
+		 * invalid state for the current task.
+		 */
+		private = NULL;
+	} else if (!private) {
 		private = kzalloc(sizeof(*private), GFP_KERNEL);
 		/*
 		 * No worries if memory allocation failed.
@@ -3521,7 +3533,23 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		 * lseek SEEK_HOLE/DATA calls to a file when there's delalloc,
 		 * so everything will still be correct.
 		 */
-		file->private_data = private;
+		if (private) {
+			bool free = false;
+
+			private->owner_task = current;
+
+			spin_lock(&inode->lock);
+			if (file->private_data)
+				free = true;
+			else
+				file->private_data = private;
+			spin_unlock(&inode->lock);
+
+			if (free) {
+				kfree(private);
+				private = NULL;
+			}
+		}
 	}
 
 	if (private)


