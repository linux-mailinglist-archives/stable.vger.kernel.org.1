Return-Path: <stable+bounces-108908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957AA120E1
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD761889B64
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6D248BC1;
	Wed, 15 Jan 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uxePgWkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39199248BA1;
	Wed, 15 Jan 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938209; cv=none; b=gwj8cpTH/wkJRVeVrmaVmBDlhDtbqFNiyFZjKO0L4enWUfbG9UyhhxY/xSYarcJ8F4b3IXrtMpy2vTM1gE1v/am2r2sxL1YS+nyN1ASSVXtD5aMpycIjK5kyZe+HxWmiP48SCGrnwNKTyELlPMigfHxmIsl4OTrw3qSeXBbFQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938209; c=relaxed/simple;
	bh=PZkXuHhXNOxT0kwtSTgTOvQmSL9EU2vINZF6Vmr3R4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG4a/e3BTIizlnwqOeUFlj6Xnfz5h07LSS+BPiBGlMiesqVMBxCS4Nks45AK+MniJNKVG5/OqqC5faFVsREKkxpQop30lXf7ayzffkX9KE/68pNvIf8EbEiFgohjrgqr5Wh6CeDPG6moUzZbt8go3XsMsGdoL2NQSW+U2thrdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uxePgWkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F39C4CEDF;
	Wed, 15 Jan 2025 10:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938209;
	bh=PZkXuHhXNOxT0kwtSTgTOvQmSL9EU2vINZF6Vmr3R4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxePgWknufcZqSh/xP8tQ6Tp1SfUBlw6WMVjsdqtQOxjpHzd9uBa65M7UGnMenR9k
	 jvQflNwBbupc6lJ+cORnjDhCWbLe1u73304fwOkWwDeTZT+JXlApB6S8K2b1BclsWb
	 HMIhXz2lfe6+xkbJO63FCjKUsy+7aYXZu4QYa9uU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.12 115/189] fs: kill MNT_ONRB
Date: Wed, 15 Jan 2025 11:36:51 +0100
Message-ID: <20250115103611.051614899@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

From: Christian Brauner <brauner@kernel.org>

commit 344bac8f0d73fe970cd9f5b2f132906317d29e8b upstream.

Move mnt->mnt_node into the union with mnt->mnt_rcu and mnt->mnt_llist
instead of keeping it with mnt->mnt_list. This allows us to use
RB_CLEAR_NODE(&mnt->mnt_node) in umount_tree() as well as
list_empty(&mnt->mnt_node). That in turn allows us to remove MNT_ONRB.

This also fixes the bug reported in [1] where seemingly MNT_ONRB wasn't
set in @mnt->mnt_flags even though the mount was present in the mount
rbtree of the mount namespace.

The root cause is the following race. When a btrfs subvolume is mounted
a temporary mount is created:

btrfs_get_tree_subvol()
{
        mnt = fc_mount()
        // Register the newly allocated mount with sb->mounts:
        lock_mount_hash();
        list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
        unlock_mount_hash();
}

and registered on sb->s_mounts. Later it is added to an anonymous mount
namespace via mount_subvol():

-> mount_subvol()
   -> mount_subtree()
      -> alloc_mnt_ns()
         mnt_add_to_ns()
         vfs_path_lookup()
         put_mnt_ns()

The mnt_add_to_ns() call raises MNT_ONRB in @mnt->mnt_flags. If someone
concurrently does a ro remount:

reconfigure_super()
-> sb_prepare_remount_readonly()
   {
           list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
   }

all mounts registered in sb->s_mounts are visited and first
MNT_WRITE_HOLD is raised, then MNT_READONLY is raised, and finally
MNT_WRITE_HOLD is removed again.

The flag modification for MNT_WRITE_HOLD/MNT_READONLY and MNT_ONRB race
so MNT_ONRB might be lost.

Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
Cc: <stable@kernel.org> # v6.8+
Link: https://lore.kernel.org/r/20241215-vfs-6-14-mount-work-v1-1-fd55922c4af8@kernel.org
Link: https://lore.kernel.org/r/ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/mount.h            | 15 +++++++++------
 fs/namespace.c        | 14 ++++++--------
 include/linux/mount.h |  3 +--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 185fc56afc13..179f690a0c72 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -38,6 +38,7 @@ struct mount {
 	struct dentry *mnt_mountpoint;
 	struct vfsmount mnt;
 	union {
+		struct rb_node mnt_node; /* node in the ns->mounts rbtree */
 		struct rcu_head mnt_rcu;
 		struct llist_node mnt_llist;
 	};
@@ -51,10 +52,7 @@ struct mount {
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
-	union {
-		struct rb_node mnt_node;	/* Under ns->mounts */
-		struct list_head mnt_list;
-	};
+	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct list_head mnt_share;	/* circular list of shared mounts */
 	struct list_head mnt_slave_list;/* list of slave mounts */
@@ -145,11 +143,16 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
+static inline bool mnt_ns_attached(const struct mount *mnt)
+{
+	return !RB_EMPTY_NODE(&mnt->mnt_node);
+}
+
 static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 {
-	WARN_ON(!(mnt->mnt.mnt_flags & MNT_ONRB));
-	mnt->mnt.mnt_flags &= ~MNT_ONRB;
+	WARN_ON(!mnt_ns_attached(mnt));
 	rb_erase(&mnt->mnt_node, &mnt->mnt_ns->mounts);
+	RB_CLEAR_NODE(&mnt->mnt_node);
 	list_add_tail(&mnt->mnt_list, dt_list);
 }
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..847fa8443e8a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -344,6 +344,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
+		RB_CLEAR_NODE(&mnt->mnt_node);
 		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
 	}
 	return mnt;
@@ -1124,7 +1125,7 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	struct rb_node **link = &ns->mounts.rb_node;
 	struct rb_node *parent = NULL;
 
-	WARN_ON(mnt->mnt.mnt_flags & MNT_ONRB);
+	WARN_ON(mnt_ns_attached(mnt));
 	mnt->mnt_ns = ns;
 	while (*link) {
 		parent = *link;
@@ -1135,7 +1136,6 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	}
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
-	mnt->mnt.mnt_flags |= MNT_ONRB;
 }
 
 /*
@@ -1305,7 +1305,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_ONRB);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1763,7 +1763,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	/* Gather the mounts to umount */
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		p->mnt.mnt_flags |= MNT_UMOUNT;
-		if (p->mnt.mnt_flags & MNT_ONRB)
+		if (mnt_ns_attached(p))
 			move_from_ns(p, &tmp_list);
 		else
 			list_move(&p->mnt_list, &tmp_list);
@@ -1912,16 +1912,14 @@ static int do_umount(struct mount *mnt, int flags)
 
 	event++;
 	if (flags & MNT_DETACH) {
-		if (mnt->mnt.mnt_flags & MNT_ONRB ||
-		    !list_empty(&mnt->mnt_list))
+		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
-			if (mnt->mnt.mnt_flags & MNT_ONRB ||
-			    !list_empty(&mnt->mnt_list))
+			if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
 				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 			retval = 0;
 		}
diff --git a/include/linux/mount.h b/include/linux/mount.h
index c34c18b4e8f3..04213d8ef837 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -50,7 +50,7 @@ struct path;
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | MNT_ONRB)
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
 
 #define MNT_INTERNAL	0x4000
 
@@ -64,7 +64,6 @@ struct path;
 #define MNT_SYNC_UMOUNT		0x2000000
 #define MNT_MARKED		0x4000000
 #define MNT_UMOUNT		0x8000000
-#define MNT_ONRB		0x10000000
 
 struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
-- 
2.48.0




