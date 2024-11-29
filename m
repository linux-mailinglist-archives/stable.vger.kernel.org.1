Return-Path: <stable+bounces-95800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577809DC2EE
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AAD161378
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15EA15B551;
	Fri, 29 Nov 2024 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Iss45/wK"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335B132C38
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880013; cv=none; b=P9dmYqhRDWHecjo+9kJELWBi2iN8Yb/Y0eRBO6aq99C9ZxdoLTaGSjRocsYXsgm8VoNh40KiphOADwTPLqgUivVMzBSKIYEr/sKBhpgoCiS0euUfJGOvHCsqCkN0qgcmYdMUHvengozdBtsV5IgEpwscn1v/sDrhtUROf0/TBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880013; c=relaxed/simple;
	bh=UmU8o+oTJ9HqcoBh353TMyjckKLohodj/0myXFV1k80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SQ1z2DeopCdW6rk1USqnZGZPhknVqlGVRbiZUN6j+FDr+2NHnjmaA0nZD0j6laxrqvMj2lr8zqsIpjuAhuvkHDbv8uognv6HJUJCemTuxxdTSAnDIwYNIkX3kzw9XWUfTmzu8l/C2Xig+CS7KwJIxAEnJZgKlqEvTFxt7Xik6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Iss45/wK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from LAPTOP-I1KNRUTF.home (unknown [20.107.5.167])
	by linux.microsoft.com (Postfix) with ESMTPSA id 695102053072;
	Fri, 29 Nov 2024 03:33:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 695102053072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732880005;
	bh=PLwzMsNjfvFTR1skr6/FAl0NlLxkpHpd57HHIyfd5JI=;
	h=From:To:Cc:Subject:Date:From;
	b=Iss45/wKdKNiDC0sA69pmb9vVl6LJSwfiYJE8Hr2ODO2g+7ZLRL2ZvqfwwnCq7gKt
	 fAEq8AR42r2U5VKGdVUXm766vKQaqz6YgCovCtpkdKeGy1KS/BbCrWXUIpbm8HIg5v
	 b5sWgCOa5HK2NtBcBYhmMQEGy9lAKUV4rnHKCJP8=
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [PATCH 5.15] kernfs: switch global kernfs_rwsem lock to per-fs lock
Date: Fri, 29 Nov 2024 12:32:36 +0100
Message-Id: <20241129113236.209845-1-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minchan Kim <minchan@kernel.org>

[ Upstream commit 393c3714081a53795bbff0e985d24146def6f57f ]

The kernfs implementation has big lock granularity(kernfs_rwsem) so
every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
lock. It makes trouble for some cases to wait the global lock
for a long time even though they are totally independent contexts
each other.

A general example is process A goes under direct reclaim with holding
the lock when it accessed the file in sysfs and process B is waiting
the lock with exclusive mode and then process C is waiting the lock
until process B could finish the job after it gets the lock from
process A.

This patch switches the global kernfs_rwsem to per-fs lock, which
put the rwsem into kernfs_root.

Suggested-by: Tejun Heo <tj@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
Link: https://lore.kernel.org/r/20211118230008.2679780-1-minchan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
Hi Stable Maintainers,

This upstream commit fixes a kernel hang due to severe lock contention on
kernfs_rwsem that occurs when container workloads perform a lot of cgroupfs
accesses. Could you please apply to 5.15.y? I cherry-pick the upstream commit
to v5.15.173 and then performed `git format-patch`.

Thanks,
Jeremi

 fs/kernfs/dir.c        | 110 ++++++++++++++++++++++++-----------------
 fs/kernfs/file.c       |   6 ++-
 fs/kernfs/inode.c      |  22 ++++++---
 fs/kernfs/mount.c      |  15 +++---
 fs/kernfs/symlink.c    |   5 +-
 include/linux/kernfs.h |   2 +
 6 files changed, 97 insertions(+), 63 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 36430bdf9381..ebe4ab0765ee 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,6 @@
 
 #include "kernfs-internal.h"
 
-DECLARE_RWSEM(kernfs_rwsem);
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
@@ -34,7 +33,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_rwsem);
+	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -465,14 +464,15 @@ void kernfs_put_active(struct kernfs_node *kn)
  * return after draining is complete.
  */
 static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_rwsem) __acquires(&kernfs_rwsem)
+	__releases(&kernfs_root(kn)->kernfs_rwsem)
+	__acquires(&kernfs_root(kn)->kernfs_rwsem)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&kernfs_rwsem);
+	lockdep_assert_held_write(&root->kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -491,7 +491,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 }
 
 /**
@@ -740,11 +740,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
+	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
 	bool has_ns;
 	int ret;
 
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -775,7 +776,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -789,7 +790,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 	return ret;
 }
 
@@ -810,7 +811,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_rwsem);
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -842,7 +843,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_rwsem);
+	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
@@ -880,11 +881,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
+	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&kernfs_rwsem);
+	down_read(&root->kernfs_rwsem);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 
 	return kn;
 }
@@ -904,11 +906,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
+	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&kernfs_rwsem);
+	down_read(&root->kernfs_rwsem);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 
 	return kn;
 }
@@ -933,6 +936,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
+	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
@@ -1056,6 +1060,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
+	struct kernfs_root *root;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1067,18 +1072,19 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		/* If the kernfs parent node has changed discard and
 		 * proceed to ->lookup.
 		 */
-		down_read(&kernfs_rwsem);
 		spin_lock(&dentry->d_lock);
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
+			spin_unlock(&dentry->d_lock);
+			root = kernfs_root(parent);
+			down_read(&root->kernfs_rwsem);
 			if (kernfs_dir_changed(parent, dentry)) {
-				spin_unlock(&dentry->d_lock);
-				up_read(&kernfs_rwsem);
+				up_read(&root->kernfs_rwsem);
 				return 0;
 			}
-		}
-		spin_unlock(&dentry->d_lock);
-		up_read(&kernfs_rwsem);
+			up_read(&root->kernfs_rwsem);
+		} else
+			spin_unlock(&dentry->d_lock);
 
 		/* The kernfs parent node hasn't changed, leave the
 		 * dentry negative and return success.
@@ -1087,7 +1093,8 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	down_read(&kernfs_rwsem);
+	root = kernfs_root(kn);
+	down_read(&root->kernfs_rwsem);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1106,10 +1113,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 	return 1;
 out_bad:
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 	return 0;
 }
 
@@ -1123,10 +1130,12 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
+	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 
-	down_read(&kernfs_rwsem);
+	root = kernfs_root(parent);
+	down_read(&root->kernfs_rwsem);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1137,7 +1146,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&kernfs_rwsem);
+			up_read(&root->kernfs_rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1152,7 +1161,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1275,7 +1284,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_rwsem);
+	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1310,8 +1319,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
+	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1325,14 +1335,14 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held_write(&kernfs_rwsem);
+	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1402,9 +1412,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	down_write(&kernfs_rwsem);
+	struct kernfs_root *root = kernfs_root(kn);
+
+	down_write(&root->kernfs_rwsem);
 	__kernfs_remove(kn);
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 }
 
 /**
@@ -1490,8 +1502,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
+	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1519,9 +1532,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&kernfs_rwsem);
+			up_write(&root->kernfs_rwsem);
 			schedule();
-			down_write(&kernfs_rwsem);
+			down_write(&root->kernfs_rwsem);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1534,7 +1547,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 	return ret;
 }
 
@@ -1551,6 +1564,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
+	struct kernfs_root *root;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1558,7 +1572,8 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	down_write(&kernfs_rwsem);
+	root = kernfs_root(parent);
+	down_write(&root->kernfs_rwsem);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn) {
@@ -1567,7 +1582,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		kernfs_put(kn);
 	}
 
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 
 	if (kn)
 		return 0;
@@ -1586,6 +1601,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
+	struct kernfs_root *root;
 	const char *old_name = NULL;
 	int error;
 
@@ -1593,7 +1609,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	down_write(&kernfs_rwsem);
+	root = kernfs_root(kn);
+	down_write(&root->kernfs_rwsem);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1647,7 +1664,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 	return error;
 }
 
@@ -1718,11 +1735,14 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
+	struct kernfs_root *root;
 	const void *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	down_read(&kernfs_rwsem);
+
+	root = kernfs_root(parent);
+	down_read(&root->kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1739,12 +1759,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&kernfs_rwsem);
+		up_read(&root->kernfs_rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&kernfs_rwsem);
+		down_read(&root->kernfs_rwsem);
 	}
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 60e2a86c535e..9414a7a60a9f 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -847,6 +847,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
+	struct kernfs_root *root;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -859,8 +860,9 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	kn->attr.notify_next = NULL;
 	spin_unlock_irq(&kernfs_notify_lock);
 
+	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
@@ -898,7 +900,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index c0eae1725435..3d783d80f5da 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,10 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
+	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 	return ret;
 }
 
@@ -111,12 +112,14 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
+	struct kernfs_root *root;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	down_write(&kernfs_rwsem);
+	root = kernfs_root(kn);
+	down_write(&root->kernfs_rwsem);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -129,7 +132,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 	return error;
 }
 
@@ -184,13 +187,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
+	struct kernfs_root *root = kernfs_root(kn);
 
-	down_read(&kernfs_rwsem);
+	down_read(&root->kernfs_rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 
 	return 0;
 }
@@ -274,19 +278,21 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
+	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
+	root = kernfs_root(kn);
 
-	down_read(&kernfs_rwsem);
+	down_read(&root->kernfs_rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f2f909d09f52..cfa79715fc1a 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -236,6 +236,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
+	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
 
@@ -255,9 +256,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kernfs_rwsem);
+	down_read(&kf_root->kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kernfs_rwsem);
+	up_read(&kf_root->kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
@@ -334,6 +335,7 @@ int kernfs_get_tree(struct fs_context *fc)
 
 	if (!sb->s_root) {
 		struct kernfs_super_info *info = kernfs_info(sb);
+		struct kernfs_root *root = kfc->root;
 
 		kfc->new_sb_created = true;
 
@@ -344,9 +346,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&kernfs_rwsem);
+		down_write(&root->kernfs_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&kernfs_rwsem);
+		up_write(&root->kernfs_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -371,10 +373,11 @@ void kernfs_free_fs_context(struct fs_context *fc)
 void kernfs_kill_sb(struct super_block *sb)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
+	struct kernfs_root *root = info->root;
 
-	down_write(&kernfs_rwsem);
+	down_write(&root->kernfs_rwsem);
 	list_del(&info->node);
-	up_write(&kernfs_rwsem);
+	up_write(&root->kernfs_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index c8f8e41b8411..efb0b9ca9057 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -114,11 +114,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
+	struct kernfs_root *root = kernfs_root(parent);
 	int error;
 
-	down_read(&kernfs_rwsem);
+	down_read(&root->kernfs_rwsem);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&kernfs_rwsem);
+	up_read(&root->kernfs_rwsem);
 
 	return error;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 1093abf7c28c..e7078cde3522 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -16,6 +16,7 @@
 #include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/wait.h>
+#include <linux/rwsem.h>
 
 struct file;
 struct dentry;
@@ -197,6 +198,7 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
+	struct rw_semaphore	kernfs_rwsem;
 };
 
 struct kernfs_open_file {
-- 
2.39.5


