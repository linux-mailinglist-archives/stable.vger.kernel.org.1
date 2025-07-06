Return-Path: <stable+bounces-159932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37041AF7B89
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B9E4A2D4F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F902EFDAE;
	Thu,  3 Jul 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fj1tq9BW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2F2EACE1;
	Thu,  3 Jul 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555820; cv=none; b=N6j9ziREhfVS3X6pqPtq/Cj9XRaxTFq54NRTjCIUsYsbjyCbxhvmapsapATuNRoP5xs/ccsM7j/FowUCp7uqu069BnOwsva2XCMMpw3cAYNl9XXq0zNkd4alJ/aiEiNqoWg+V1X2sZzUA52H+AGXFjtx0AwKsskGkTPFnUUEYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555820; c=relaxed/simple;
	bh=RHDslgUaUWC35ouhuDPEa1k/TvkxRRaiiaG5BzU7tB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+bUTe0C8+i/AbG/GDRGzOqywcbglKPgp82JDI7SU6i2gcNAppgz0uTvr0QXpKHdTukTF+B/B974+9DyBFclgWn+cvRX42+I7yABPQ0LUTN6go2XYFLlL7ju5anSX7F3SmO6wVMzZpzJ3f+vu1shixTHnZH6PyK8hcwUB9xUZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fj1tq9BW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58A2C4CEE3;
	Thu,  3 Jul 2025 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555820;
	bh=RHDslgUaUWC35ouhuDPEa1k/TvkxRRaiiaG5BzU7tB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj1tq9BW2KWrB+CSK8Fdg6dpRKyI0hGosxvmoOoxhxiCaZYsSLsbIOv04kSTB+LOJ
	 Fq8FwJA/qZucWno5EZuSwrba++lRLIJOQ05Q/y5rwKgM3kjNJlLBxGSo8321QZ5Vbv
	 h5NzmFL1jyLGNsLAfHpZedNREY1gIowLjUjl9aoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 101/139] btrfs: fix a race between renames and directory logging
Date: Thu,  3 Jul 2025 16:42:44 +0200
Message-ID: <20250703143945.118770248@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 3ca864de852bc91007b32d2a0d48993724f4abad upstream.

We have a race between a rename and directory inode logging that if it
happens and we crash/power fail before the rename completes, the next time
the filesystem is mounted, the log replay code will end up deleting the
file that was being renamed.

This is best explained following a step by step analysis of an interleaving
of steps that lead into this situation.

Consider the initial conditions:

1) We are at transaction N;

2) We have directories A and B created in a past transaction (< N);

3) We have inode X corresponding to a file that has 2 hardlinks, one in
   directory A and the other in directory B, so we'll name them as
   "A/foo_link1" and "B/foo_link2". Both hard links were persisted in a
   past transaction (< N);

4) We have inode Y corresponding to a file that as a single hard link and
   is located in directory A, we'll name it as "A/bar". This file was also
   persisted in a past transaction (< N).

The steps leading to a file loss are the following and for all of them we
are under transaction N:

 1) Link "A/foo_link1" is removed, so inode's X last_unlink_trans field
    is updated to N, through btrfs_unlink() -> btrfs_record_unlink_dir();

 2) Task A starts a rename for inode Y, with the goal of renaming from
    "A/bar" to "A/baz", so we enter btrfs_rename();

 3) Task A inserts the new BTRFS_INODE_REF_KEY for inode Y by calling
    btrfs_insert_inode_ref();

 4) Because the rename happens in the same directory, we don't set the
    last_unlink_trans field of directoty A's inode to the current
    transaction id, that is, we don't cal btrfs_record_unlink_dir();

 5) Task A then removes the entries from directory A (BTRFS_DIR_ITEM_KEY
    and BTRFS_DIR_INDEX_KEY items) when calling __btrfs_unlink_inode()
    (actually the dir index item is added as a delayed item, but the
    effect is the same);

 6) Now before task A adds the new entry "A/baz" to directory A by
    calling btrfs_add_link(), another task, task B is logging inode X;

 7) Task B starts a fsync of inode X and after logging inode X, at
    btrfs_log_inode_parent() it calls btrfs_log_all_parents(), since
    inode X has a last_unlink_trans value of N, set at in step 1;

 8) At btrfs_log_all_parents() we search for all parent directories of
    inode X using the commit root, so we find directories A and B and log
    them. Bu when logging direct A, we don't have a dir index item for
    inode Y anymore, neither the old name "A/bar" nor for the new name
    "A/baz" since the rename has deleted the old name but has not yet
    inserted the new name - task A hasn't called yet btrfs_add_link() to
    do that.

    Note that logging directory A doesn't fallback to a transaction
    commit because its last_unlink_trans has a lower value than the
    current transaction's id (see step 4);

 9) Task B finishes logging directories A and B and gets back to
    btrfs_sync_file() where it calls btrfs_sync_log() to persist the log
    tree;

10) Task B successfully persisted the log tree, btrfs_sync_log() completed
    with success, and a power failure happened.

    We have a log tree without any directory entry for inode Y, so the
    log replay code deletes the entry for inode Y, name "A/bar", from the
    subvolume tree since it doesn't exist in the log tree and the log
    tree is authorative for its index (we logged a BTRFS_DIR_LOG_INDEX_KEY
    item that covers the index range for the dentry that corresponds to
    "A/bar").

    Since there's no other hard link for inode Y and the log replay code
    deletes the name "A/bar", the file is lost.

The issue wouldn't happen if task B synced the log only after task A
called btrfs_log_new_name(), which would update the log with the new name
for inode Y ("A/bar").

Fix this by pinning the log root during renames before removing the old
directory entry, and unpinning after btrfs_log_new_name() is called.

Fixes: 259c4b96d78d ("btrfs: stop doing unnecessary log updates during a rename")
CC: stable@vger.kernel.org # 5.18+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   81 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 17 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8754,6 +8754,7 @@ static int btrfs_rename_exchange(struct
 	int ret;
 	int ret2;
 	bool need_abort = false;
+	bool logs_pinned = false;
 	struct fscrypt_name old_fname, new_fname;
 	struct fscrypt_str *old_name, *new_name;
 
@@ -8877,6 +8878,31 @@ static int btrfs_rename_exchange(struct
 	inode_inc_iversion(new_inode);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID &&
+	    new_ino != BTRFS_FIRST_FREE_OBJECTID) {
+		/*
+		 * If we are renaming in the same directory (and it's not for
+		 * root entries) pin the log early to prevent any concurrent
+		 * task from logging the directory after we removed the old
+		 * entries and before we add the new entries, otherwise that
+		 * task can sync a log without any entry for the inodes we are
+		 * renaming and therefore replaying that log, if a power failure
+		 * happens after syncing the log, would result in deleting the
+		 * inodes.
+		 *
+		 * If the rename affects two different directories, we want to
+		 * make sure the that there's no log commit that contains
+		 * updates for only one of the directories but not for the
+		 * other.
+		 *
+		 * If we are renaming an entry for a root, we don't care about
+		 * log updates since we called btrfs_set_log_full_commit().
+		 */
+		btrfs_pin_log_trans(root);
+		btrfs_pin_log_trans(dest);
+		logs_pinned = true;
+	}
+
 	if (old_dentry->d_parent != new_dentry->d_parent) {
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
 					BTRFS_I(old_inode), true);
@@ -8934,30 +8960,23 @@ static int btrfs_rename_exchange(struct
 		BTRFS_I(new_inode)->dir_index = new_idx;
 
 	/*
-	 * Now pin the logs of the roots. We do it to ensure that no other task
-	 * can sync the logs while we are in progress with the rename, because
-	 * that could result in an inconsistency in case any of the inodes that
-	 * are part of this rename operation were logged before.
+	 * Do the log updates for all inodes.
+	 *
+	 * If either entry is for a root we don't need to update the logs since
+	 * we've called btrfs_set_log_full_commit() before.
 	 */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
-		btrfs_pin_log_trans(root);
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
-		btrfs_pin_log_trans(dest);
-
-	/* Do the log updates for all inodes. */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+	if (logs_pinned) {
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   old_rename_ctx.index, new_dentry->d_parent);
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
 				   new_rename_ctx.index, old_dentry->d_parent);
+	}
 
-	/* Now unpin the logs. */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+out_fail:
+	if (logs_pinned) {
 		btrfs_end_log_trans(root);
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_end_log_trans(dest);
-out_fail:
+	}
 	ret2 = btrfs_end_transaction(trans);
 	ret = ret ? ret : ret2;
 out_notrans:
@@ -9007,6 +9026,7 @@ static int btrfs_rename(struct mnt_idmap
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	struct fscrypt_name old_fname, new_fname;
+	bool logs_pinned = false;
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -9141,6 +9161,29 @@ static int btrfs_rename(struct mnt_idmap
 	inode_inc_iversion(old_inode);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID) {
+		/*
+		 * If we are renaming in the same directory (and it's not a
+		 * root entry) pin the log to prevent any concurrent task from
+		 * logging the directory after we removed the old entry and
+		 * before we add the new entry, otherwise that task can sync
+		 * a log without any entry for the inode we are renaming and
+		 * therefore replaying that log, if a power failure happens
+		 * after syncing the log, would result in deleting the inode.
+		 *
+		 * If the rename affects two different directories, we want to
+		 * make sure the that there's no log commit that contains
+		 * updates for only one of the directories but not for the
+		 * other.
+		 *
+		 * If we are renaming an entry for a root, we don't care about
+		 * log updates since we called btrfs_set_log_full_commit().
+		 */
+		btrfs_pin_log_trans(root);
+		btrfs_pin_log_trans(dest);
+		logs_pinned = true;
+	}
+
 	if (old_dentry->d_parent != new_dentry->d_parent)
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
 					BTRFS_I(old_inode), true);
@@ -9189,7 +9232,7 @@ static int btrfs_rename(struct mnt_idmap
 	if (old_inode->i_nlink == 1)
 		BTRFS_I(old_inode)->dir_index = index;
 
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+	if (logs_pinned)
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   rename_ctx.index, new_dentry->d_parent);
 
@@ -9205,6 +9248,10 @@ static int btrfs_rename(struct mnt_idmap
 		}
 	}
 out_fail:
+	if (logs_pinned) {
+		btrfs_end_log_trans(root);
+		btrfs_end_log_trans(dest);
+	}
 	ret2 = btrfs_end_transaction(trans);
 	ret = ret ? ret : ret2;
 out_notrans:



