Return-Path: <stable+bounces-137999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF42AA165C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949979874D4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2325178C;
	Tue, 29 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMmbR3Zh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556002472B4;
	Tue, 29 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947792; cv=none; b=b82JBTyHRex5XU5b8UK3gHRatmlj1elvA7I5uWvYJibZB3fkAWxAOhV5bM7oqzs1vIv1TYfL7npSTKxlNnEyXef1qyR12Jvs5pr1gLI4exA6qewQ7w6EE/kbyK+uYGYz+FXvrzNXavliYhyRIpsAvQeY+YGT5Y4NyVcOlv/DunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947792; c=relaxed/simple;
	bh=O1NwR6PBDfmyNKBuLHeO89HFEFgI652fSlpWSTabbBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt19ITmhn3sjkwMscO38McctIsgrgG+52ULP2wuoxjgdsj66P7PtkY1pbfZjakemo6Wgr3b1o7AeY73QUiP/m8yabwe3yx5h25q+SPrXvGuujXt3kASb6WvUWIknhYYOxqGEVhEh61mJSMuNJZ/KrXpq0gBtTyG/QWmcHtCbdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMmbR3Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01BEC4CEE9;
	Tue, 29 Apr 2025 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947792;
	bh=O1NwR6PBDfmyNKBuLHeO89HFEFgI652fSlpWSTabbBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMmbR3ZhwBobomsz0uP5FAI254eXONITkkwUFIWHVPYXLPxF9Uhuj9rU40hskmVRq
	 ce/1cP2+ZOw8rQb6uJOwpGSfzCE39wOLh7+6Ii8u+1HFK7B2ixkKVjjGqDbfqMRSUr
	 lQqgJhDiWPtsl97fa2pgRv9ULGMayD0UC8lq37uw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 074/280] fix a couple of races in MNT_TREE_BENEATH handling by do_move_mount()
Date: Tue, 29 Apr 2025 18:40:15 +0200
Message-ID: <20250429161118.138870246@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 0d039eac6e5950f9d1ecc9e410c2fd1feaeab3b6 ]

Normally do_lock_mount(path, _) is locking a mountpoint pinned by
*path and at the time when matching unlock_mount() unlocks that
location it is still pinned by the same thing.

Unfortunately, for 'beneath' case it's no longer that simple -
the object being locked is not the one *path points to.  It's the
mountpoint of path->mnt.  The thing is, without sufficient locking
->mnt_parent may change under us and none of the locks are held
at that point.  The rules are
	* mount_lock stabilizes m->mnt_parent for any mount m.
	* namespace_sem stabilizes m->mnt_parent, provided that
m is mounted.
	* if either of the above holds and refcount of m is positive,
we are guaranteed the same for refcount of m->mnt_parent.

namespace_sem nests inside inode_lock(), so do_lock_mount() has
to take inode_lock() before grabbing namespace_sem.  It does
recheck that path->mnt is still mounted in the same place after
getting namespace_sem, and it does take care to pin the dentry.
It is needed, since otherwise we might end up with racing mount --move
(or umount) happening while we were getting locks; in that case
dentry would no longer be a mountpoint and could've been evicted
on memory pressure along with its inode - not something you want
when grabbing lock on that inode.

However, pinning a dentry is not enough - the matching mount is
also pinned only by the fact that path->mnt is mounted on top it
and at that point we are not holding any locks whatsoever, so
the same kind of races could end up with all references to
that mount gone just as we are about to enter inode_lock().
If that happens, we are left with filesystem being shut down while
we are holding a dentry reference on it; results are not pretty.

What we need to do is grab both dentry and mount at the same time;
that makes inode_lock() safe *and* avoids the problem with fs getting
shut down under us.  After taking namespace_sem we verify that
path->mnt is still mounted (which stabilizes its ->mnt_parent) and
check that it's still mounted at the same place.  From that point
on to the matching namespace_unlock() we are guaranteed that
mount/dentry pair we'd grabbed are also pinned by being the mountpoint
of path->mnt, so we can quietly drop both the dentry reference (as
the current code does) and mnt one - it's OK to do under namespace_sem,
since we are not dropping the final refs.

That solves the problem on do_lock_mount() side; unlock_mount()
also has one, since dentry is guaranteed to stay pinned only until
the namespace_unlock().  That's easy to fix - just have inode_unlock()
done earlier, while it's still pinned by mp->m_dentry.

Fixes: 6ac392815628 "fs: allow to mount beneath top mount" # v6.5+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 69 ++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f898de3a6f705..bd601ab26e781 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2596,56 +2596,62 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
 	struct mountpoint *mp = ERR_PTR(-ENOENT);
+	struct path under = {};
 
 	for (;;) {
-		struct mount *m;
+		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
-			m = real_mount(mnt);
+			path_put(&under);
 			read_seqlock_excl(&mount_lock);
-			dentry = dget(m->mnt_mountpoint);
+			under.mnt = mntget(&m->mnt_parent->mnt);
+			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
+			dentry = under.dentry;
 		} else {
 			dentry = path->dentry;
 		}
 
 		inode_lock(dentry->d_inode);
-		if (unlikely(cant_mount(dentry))) {
-			inode_unlock(dentry->d_inode);
-			goto out;
-		}
-
 		namespace_lock();
 
-		if (beneath && (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {
+		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
+			break;		// not to be mounted on
+
+		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
+				        &m->mnt_parent->mnt != under.mnt)) {
 			namespace_unlock();
 			inode_unlock(dentry->d_inode);
-			goto out;
+			continue;	// got moved
 		}
 
 		mnt = lookup_mnt(path);
-		if (likely(!mnt))
+		if (unlikely(mnt)) {
+			namespace_unlock();
+			inode_unlock(dentry->d_inode);
+			path_put(path);
+			path->mnt = mnt;
+			path->dentry = dget(mnt->mnt_root);
+			continue;	// got overmounted
+		}
+		mp = get_mountpoint(dentry);
+		if (IS_ERR(mp))
 			break;
-
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
-		if (beneath)
-			dput(dentry);
-		path_put(path);
-		path->mnt = mnt;
-		path->dentry = dget(mnt->mnt_root);
-	}
-
-	mp = get_mountpoint(dentry);
-	if (IS_ERR(mp)) {
-		namespace_unlock();
-		inode_unlock(dentry->d_inode);
+		if (beneath) {
+			/*
+			 * @under duplicates the references that will stay
+			 * at least until namespace_unlock(), so the path_put()
+			 * below is safe (and OK to do under namespace_lock -
+			 * we are not dropping the final references here).
+			 */
+			path_put(&under);
+		}
+		return mp;
 	}
-
-out:
+	namespace_unlock();
+	inode_unlock(dentry->d_inode);
 	if (beneath)
-		dput(dentry);
-
+		path_put(&under);
 	return mp;
 }
 
@@ -2656,14 +2662,11 @@ static inline struct mountpoint *lock_mount(struct path *path)
 
 static void unlock_mount(struct mountpoint *where)
 {
-	struct dentry *dentry = where->m_dentry;
-
+	inode_unlock(where->m_dentry->d_inode);
 	read_seqlock_excl(&mount_lock);
 	put_mountpoint(where);
 	read_sequnlock_excl(&mount_lock);
-
 	namespace_unlock();
-	inode_unlock(dentry->d_inode);
 }
 
 static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
-- 
2.39.5




