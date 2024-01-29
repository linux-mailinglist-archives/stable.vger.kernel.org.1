Return-Path: <stable+bounces-17087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD8840FC6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A136282C91
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478B115EA86;
	Mon, 29 Jan 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEqi1+sZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB415EA83;
	Mon, 29 Jan 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548500; cv=none; b=WWKtF0XCx1dt+nbPGFjk2pa5zO3h9Ct5yk6W3B38D91bV5lBFdBzERE/Y3Ls0EpWAq0R+TypqLBPpTqRHmLiqORLixinLS1g6K4ceHGghnKeLJu4epYqvsOlWj4O9Z9JaPKaLlyKSbT7qduiyP5KNG0JA6P91aBrJ4V28kTVW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548500; c=relaxed/simple;
	bh=qKTMVSIeH0nG0yDuFqUOxzWoFI1XHpHi1+tQBOgFPL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hs3MywLrdpKcPUPV+LPStAnpZdPu06ugWzoBVT8PeIr6qkLfPQCr1OkVnoC7RGc8gzEcl/9yobZYMXT3PK3oDXNYMvKmAHnUN5bhbvttyS6GP1AmbdFRnTrwuffzDHcaQJKWRC4YBb1mlM7g+ENtUNA/R1CKcEEf3ceYfiyDlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEqi1+sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D90C433F1;
	Mon, 29 Jan 2024 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548499;
	bh=qKTMVSIeH0nG0yDuFqUOxzWoFI1XHpHi1+tQBOgFPL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEqi1+sZYj547lY05LXk0BNSdzUuk7xBltdyvJE/C7Pved8ru0ehS/G5rsgV8ZkkX
	 8UKT7ItA8yrs7ZpnguYBKwmhazLzd9+4s84Za00BxueduIECLO1nZf+y0UiVd91q1e
	 +RsNYJ9TscjiGtjI19WYF8VIR4D5O3Uq3XJki2fI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.6 127/331] rename(): fix the locking of subdirectories
Date: Mon, 29 Jan 2024 09:03:11 -0800
Message-ID: <20240129170018.656686534@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 22e111ed6c83dcde3037fc81176012721bc34c0b upstream.

	We should never lock two subdirectories without having taken
->s_vfs_rename_mutex; inode pointer order or not, the "order" proposed
in 28eceeda130f "fs: Lock moved directories" is not transitive, with
the usual consequences.

	The rationale for locking renamed subdirectory in all cases was
the possibility of race between rename modifying .. in a subdirectory to
reflect the new parent and another thread modifying the same subdirectory.
For a lot of filesystems that's not a problem, but for some it can lead
to trouble (e.g. the case when short directory contents is kept in the
inode, but creating a file in it might push it across the size limit
and copy its contents into separate data block(s)).

	However, we need that only in case when the parent does change -
otherwise ->rename() doesn't need to do anything with .. entry in the
first place.  Some instances are lazy and do a tautological update anyway,
but it's really not hard to avoid.

Amended locking rules for rename():
	find the parent(s) of source and target
	if source and target have the same parent
		lock the common parent
	else
		lock ->s_vfs_rename_mutex
		lock both parents, in ancestor-first order; if neither
		is an ancestor of another, lock the parent of source
		first.
	find the source and target.
	if source and target have the same parent
		if operation is an overwriting rename of a subdirectory
			lock the target subdirectory
	else
		if source is a subdirectory
			lock the source
		if target is a subdirectory
			lock the target
	lock non-directories involved, in inode pointer order if both
	source and target are such.

That way we are guaranteed that parents are locked (for obvious reasons),
that any renamed non-directory is locked (nfsd relies upon that),
that any victim is locked (emptiness check needs that, among other things)
and subdirectory that changes parent is locked (needed to protect the update
of .. entries).  We are also guaranteed that any operation locking more
than one directory either takes ->s_vfs_rename_mutex or locks a parent
followed by its child.

Cc: stable@vger.kernel.org
Fixes: 28eceeda130f "fs: Lock moved directories"
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/directory-locking.rst |   29 ++++++-----
 Documentation/filesystems/locking.rst           |    5 +-
 Documentation/filesystems/porting.rst           |   18 +++++++
 fs/namei.c                                      |   60 ++++++++++++++----------
 4 files changed, 74 insertions(+), 38 deletions(-)

--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,13 +22,16 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
-parent and finds source and target.  We lock both (provided they exist).  If we
-need to lock two inodes of different type (dir vs non-dir), we lock directory
-first.  If we need to lock two inodes of the same type, lock them in inode
-pointer order.  Then call the method.  All locks are exclusive.
-NB: we might get away with locking the source (and target in exchange
-case) shared.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks
+the parent and finds source and target.  Then we decide which of the
+source and target need to be locked.  Source needs to be locked if it's a
+non-directory; target - if it's a non-directory or about to be removed.
+Take the locks that need to be taken, in inode pointer order if need
+to take both (that can happen only when both source and target are
+non-directories - the source because it wouldn't be locked otherwise
+and the target because mixing directory and non-directory is allowed
+only with RENAME_EXCHANGE, and that won't be removing the target).
+After the locks had been taken, call the method.  All locks are exclusive.
 
 5) link creation.  Locking rules:
 
@@ -44,20 +47,17 @@ rules:
 
 	* lock the filesystem
 	* lock parents in "ancestors first" order. If one is not ancestor of
-	  the other, lock them in inode pointer order.
+	  the other, lock the parent of source first.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* Lock both the source and the target provided they exist. If we
-	  need to lock two inodes of different type (dir vs non-dir), we lock
-	  the directory first. If we need to lock two inodes of the same type,
-	  lock them in inode pointer order.
+	* Lock subdirectories involved (source before target).
+	* Lock non-directories involved, in inode pointer order.
 	* call the method.
 
-All ->i_rwsem are taken exclusive.  Again, we might get away with locking
-the source (and target in exchange case) shared.
+All ->i_rwsem are taken exclusive.
 
 The rules above obviously guarantee that all directories that are going to be
 read, modified or removed by method will be locked by caller.
@@ -67,6 +67,7 @@ If no directory is its own ancestor, the
 
 Proof:
 
+[XXX: will be updated once we are done massaging the lock_rename()]
 	First of all, at any moment we have a linear ordering of the
 	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
         of A and ptr(A) < ptr(B)).
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -101,7 +101,7 @@ symlink:	exclusive
 mkdir:		exclusive
 unlink:		exclusive (both)
 rmdir:		exclusive (both)(see below)
-rename:		exclusive (all)	(see below)
+rename:		exclusive (both parents, some children)	(see below)
 readlink:	no
 get_link:	no
 setattr:	exclusive
@@ -123,6 +123,9 @@ get_offset_ctx  no
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
 	exclusive on victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directories
+	involved.
+	->rename() has ->i_rwsem exclusive on any subdirectory that changes parent.
 
 See Documentation/filesystems/directory-locking.rst for more detailed discussion
 of the locking scheme for directory operations.
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1045,3 +1045,21 @@ filesystem type is now moved to a later
 As this is a VFS level change it has no practical consequences for filesystems
 other than that all of them must use one of the provided kill_litter_super(),
 kill_anon_super(), or kill_block_super() helpers.
+
+---
+
+**mandatory**
+
+If ->rename() update of .. on cross-directory move needs an exclusion with
+directory modifications, do *not* lock the subdirectory in question in your
+->rename() - it's done by the caller now [that item should've been added in
+28eceeda130f "fs: Lock moved directories"].
+
+---
+
+**mandatory**
+
+On same-directory ->rename() the (tautological) update of .. is not protected
+by any locks; just don't do it if the old parent is the same as the new one.
+We really can't lock two subdirectories in same-directory rename - not without
+deadlocks.
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3021,20 +3021,14 @@ static struct dentry *lock_two_directori
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT2);
 		return p;
 	}
 
 	p = d_ancestor(p1, p2);
-	if (p) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
-		return p;
-	}
-
-	lock_two_inodes(p1->d_inode, p2->d_inode,
-			I_MUTEX_PARENT, I_MUTEX_PARENT2);
-	return NULL;
+	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	return p;
 }
 
 /*
@@ -4733,11 +4727,12 @@ SYSCALL_DEFINE2(link, const char __user
  *
  *	a) we can get into loop creation.
  *	b) race potential - two innocent renames can create a loop together.
- *	   That's where 4.4 screws up. Current fix: serialization on
+ *	   That's where 4.4BSD screws up. Current fix: serialization on
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
- *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source.
+ *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
+ *	   and source (if it's a non-directory or a subdirectory that moves to
+ *	   different parent).
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4769,6 +4764,7 @@ int vfs_rename(struct renamedata *rd)
 	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
+	bool lock_old_subdir, lock_new_subdir;
 
 	if (source == target)
 		return 0;
@@ -4822,15 +4818,32 @@ int vfs_rename(struct renamedata *rd)
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
 	/*
-	 * Lock all moved children. Moved directories may need to change parent
-	 * pointer so they need the lock to prevent against concurrent
-	 * directory changes moving parent pointer. For regular files we've
-	 * historically always done this. The lockdep locking subclasses are
-	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
-	 * regular files and directories so it's difficult to tell which
-	 * subclasses to use.
+	 * Lock children.
+	 * The source subdirectory needs to be locked on cross-directory
+	 * rename or cross-directory exchange since its parent changes.
+	 * The target subdirectory needs to be locked on cross-directory
+	 * exchange due to parent change and on any rename due to becoming
+	 * a victim.
+	 * Non-directories need locking in all cases (for NFS reasons);
+	 * they get locked after any subdirectories (in inode address order).
+	 *
+	 * NOTE: WE ONLY LOCK UNRELATED DIRECTORIES IN CROSS-DIRECTORY CASE.
+	 * NEVER, EVER DO THAT WITHOUT ->s_vfs_rename_mutex.
 	 */
-	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
+	lock_old_subdir = new_dir != old_dir;
+	lock_new_subdir = new_dir != old_dir || !(flags & RENAME_EXCHANGE);
+	if (is_dir) {
+		if (lock_old_subdir)
+			inode_lock_nested(source, I_MUTEX_CHILD);
+		if (target && (!new_is_dir || lock_new_subdir))
+			inode_lock(target);
+	} else if (new_is_dir) {
+		if (lock_new_subdir)
+			inode_lock_nested(target, I_MUTEX_CHILD);
+		inode_lock(source);
+	} else {
+		lock_two_nondirectories(source, target);
+	}
 
 	error = -EPERM;
 	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
@@ -4878,8 +4891,9 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	inode_unlock(source);
-	if (target)
+	if (!is_dir || lock_old_subdir)
+		inode_unlock(source);
+	if (target && (!new_is_dir || lock_new_subdir))
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {



