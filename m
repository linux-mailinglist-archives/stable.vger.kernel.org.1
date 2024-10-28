Return-Path: <stable+bounces-88963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0309B283E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666651F21B35
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582F18E35B;
	Mon, 28 Oct 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dzerjFyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32822AF07;
	Mon, 28 Oct 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098518; cv=none; b=QRHnM3iTCM5Sl6V9QuMaigbci0sHjQznv1qhZmdwZAkq8oM2MDM35bhwvilcU3WL8ojMR+NSBYho26h9/ONLG3mIX9fCZ1rG8YNN9qG2MVmq4It4XhNsPoS0JqVbuhwPoEpe5MwU/rUQZ1F8SCNd/BNnl0EpjEezGsifV6UzF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098518; c=relaxed/simple;
	bh=elffZZDTsuR/sNHqRLHaUDWVU3Ot2lIxOQ4lw98bo84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC3VFboB6o82Hmj3ddFq5ymNZO3OwH5DILjhIJzIh19cikQrmpwgEVV3i2tg+1MmpDWNI7WOtxLE89be4UrSqT8dhodkVFuVuWPujW82b8APx1KdSHi8+mz2LeF2/Xsr3TYNtielOJWVlntDWv3ONx518ZRWUORBIRpzdcKBt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dzerjFyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15FCC4CEC3;
	Mon, 28 Oct 2024 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098518;
	bh=elffZZDTsuR/sNHqRLHaUDWVU3Ot2lIxOQ4lw98bo84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzerjFyoCuohGWKFFn8hl+9la4Y+baW2hxVih8DdZJlcGhk9lYlQu7MA2xy4pFhxO
	 ZGJTksXDB9mUgflCH+zGtOJehEymu2/0xB2SLckDe5r1c2VVPlYu7PPjhuGd0Ttmjw
	 F/6RH0zjBqmeNVAQb5ouRbsF3zqHYJxO9I57cri0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 6.11 254/261] Revert "fs/9p: simplify iget to remove unnecessary paths"
Date: Mon, 28 Oct 2024 07:26:36 +0100
Message-ID: <20241028062318.467905899@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <asmadeus@codewreck.org>

commit be2ca3825372085d669d322dccd0542a90e5b434 upstream.

This reverts commit 724a08450f74b02bd89078a596fd24857827c012.

This code simplification introduced significant regressions on servers
that do not remap inode numbers when exporting multiple underlying
filesystems with colliding inodes, as can be illustrated with simple
tmpfs exports in qemu with remapping disabled:
```
# host side
cd /tmp/linux-test
mkdir m1 m2
mount -t tmpfs tmpfs m1
mount -t tmpfs tmpfs m2
mkdir m1/dir m2/dir
echo foo > m1/dir/foo
echo bar > m2/dir/bar

# guest side
# started with -virtfs local,path=/tmp/linux-test,mount_tag=tmp,security_model=mapped-file
mount -t 9p -o trans=virtio,debug=1 tmp /mnt/t

ls /mnt/t/m1/dir
# foo
ls /mnt/t/m2/dir
# bar (works ok if directry isn't open)

# cd to keep first dir's inode alive
cd /mnt/t/m1/dir
ls /mnt/t/m2/dir
# foo (should be bar)
```
Other examples can be crafted with regular files with fscache enabled,
in which case I/Os just happen to the wrong file leading to
corruptions, or guest failing to boot with:
  | VFS: Lookup of 'com.android.runtime' in 9p 9p would have caused loop

In theory, we'd want the servers to be smart enough and ensure they
never send us two different files with the same 'qid.path', but while
qemu has an option to remap that is recommended (and qemu prints a
warning if this case happens), there are many other servers which do
not (kvmtool, nfs-ganesha, probably diod...), we should at least ensure
we don't cause regressions on this:
- assume servers can't be trusted and operations that should get a 'new'
inode properly do so. commit d05dcfdf5e16 (" fs/9p: mitigate inode
collisions") attempted to do this, but v9fs_fid_iget_dotl() was not
called so some higher level of caching got in the way; this needs to be
fixed properly before we can re-apply the patches.
- if we ever want to really simplify this code, we will need to add some
negotiation with the server at mount time where the server could claim
they handle this properly, at which point we could optimize this out.
(but that might not be needed at all if we properly handle the 'new'
check?)

Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
Reported-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20240408141436.GA17022@redhat.com/
Link: https://lkml.kernel.org/r/20240923100508.GA32066@willie-the-truck
Cc: stable@vger.kernel.org # v6.9+
Message-ID: <20241024-revert_iget-v1-4-4cac63d25f72@codewreck.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/v9fs.h           |   31 +++++++++++++--
 fs/9p/v9fs_vfs.h       |    2 -
 fs/9p/vfs_inode.c      |   98 ++++++++++++++++++++++++++++++++++++++-----------
 fs/9p/vfs_inode_dotl.c |   92 +++++++++++++++++++++++++++++++++++++---------
 fs/9p/vfs_super.c      |    2 -
 5 files changed, 180 insertions(+), 45 deletions(-)

--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -179,13 +179,16 @@ extern int v9fs_vfs_rename(struct mnt_id
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
-extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid);
+extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
+					 struct p9_fid *fid,
+					 struct super_block *sb, int new);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
-extern struct inode *v9fs_fid_iget_dotl(struct super_block *sb,
-					struct p9_fid *fid);
+extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
+					      struct p9_fid *fid,
+					      struct super_block *sb, int new);
 
 /* other default globals */
 #define V9FS_PORT	564
@@ -227,9 +230,27 @@ v9fs_get_inode_from_fid(struct v9fs_sess
 			struct super_block *sb)
 {
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_fid_iget_dotl(sb, fid);
+		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 0);
 	else
-		return v9fs_fid_iget(sb, fid);
+		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
+}
+
+/**
+ * v9fs_get_new_inode_from_fid - Helper routine to populate an inode by
+ * issuing a attribute request
+ * @v9ses: session information
+ * @fid: fid to issue attribute request for
+ * @sb: superblock on which to create inode
+ *
+ */
+static inline struct inode *
+v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
+			    struct super_block *sb)
+{
+	if (v9fs_proto_dotl(v9ses))
+		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 1);
+	else
+		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
 }
 
 #endif
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -42,7 +42,7 @@ struct inode *v9fs_alloc_inode(struct su
 void v9fs_free_inode(struct inode *inode);
 void v9fs_set_netfs_context(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev);
+		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
 #if (BITS_PER_LONG == 32)
 #define QID2INO(q) ((ino_t) (((q)->path+2) ^ (((q)->path) >> 32)))
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -256,12 +256,9 @@ void v9fs_set_netfs_context(struct inode
 }
 
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev)
+		    struct inode *inode, umode_t mode, dev_t rdev)
 {
 	int err = 0;
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-
-	memcpy(&v9inode->qid, qid, sizeof(struct p9_qid));
 
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
@@ -365,40 +362,80 @@ void v9fs_evict_inode(struct inode *inod
 		clear_inode(inode);
 }
 
-struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
+static int v9fs_test_inode(struct inode *inode, void *data)
+{
+	int umode;
+	dev_t rdev;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct p9_wstat *st = (struct p9_wstat *)data;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	umode = p9mode2unixmode(v9ses, st, &rdev);
+	/* don't match inode of different type */
+	if (inode_wrong_type(inode, umode))
+		return 0;
+
+	/* compare qid details */
+	if (memcmp(&v9inode->qid.version,
+		   &st->qid.version, sizeof(v9inode->qid.version)))
+		return 0;
+
+	if (v9inode->qid.type != st->qid.type)
+		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
+	return 1;
+}
+
+static int v9fs_test_new_inode(struct inode *inode, void *data)
+{
+	return 0;
+}
+
+static int v9fs_set_inode(struct inode *inode,  void *data)
+{
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct p9_wstat *st = (struct p9_wstat *)data;
+
+	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
+	return 0;
+}
+
+static struct inode *v9fs_qid_iget(struct super_block *sb,
+				   struct p9_qid *qid,
+				   struct p9_wstat *st,
+				   int new)
 {
 	dev_t rdev;
 	int retval;
 	umode_t umode;
 	struct inode *inode;
-	struct p9_wstat *st;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
+	int (*test)(struct inode *inode, void *data);
+
+	if (new)
+		test = v9fs_test_new_inode;
+	else
+		test = v9fs_test_inode;
 
-	inode = iget_locked(sb, QID2INO(&fid->qid));
-	if (unlikely(!inode))
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
-
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	st = p9_client_stat(fid);
-	if (IS_ERR(st)) {
-		retval = PTR_ERR(st);
-		goto error;
-	}
-
+	inode->i_ino = QID2INO(qid);
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	retval = v9fs_init_inode(v9ses, inode, &fid->qid, umode, rdev);
-	v9fs_stat2inode(st, inode, sb, 0);
-	p9stat_free(st);
-	kfree(st);
+	retval = v9fs_init_inode(v9ses, inode, umode, rdev);
 	if (retval)
 		goto error;
 
+	v9fs_stat2inode(st, inode, sb, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
@@ -409,6 +446,23 @@ error:
 
 }
 
+struct inode *
+v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
+		    struct super_block *sb, int new)
+{
+	struct p9_wstat *st;
+	struct inode *inode = NULL;
+
+	st = p9_client_stat(fid);
+	if (IS_ERR(st))
+		return ERR_CAST(st);
+
+	inode = v9fs_qid_iget(sb, &st->qid, st, new);
+	p9stat_free(st);
+	kfree(st);
+	return inode;
+}
+
 /**
  * v9fs_at_to_dotl_flags- convert Linux specific AT flags to
  * plan 9 AT flag.
@@ -555,7 +609,7 @@ v9fs_create(struct v9fs_session_info *v9
 		/*
 		 * instantiate inode and assign the unopened fid to the dentry
 		 */
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -683,8 +737,10 @@ struct dentry *v9fs_vfs_lookup(struct in
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else
+	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+	else
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,33 +52,76 @@ static kgid_t v9fs_get_fsgid_for_create(
 	return current_fsgid();
 }
 
-struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
+static int v9fs_test_inode_dotl(struct inode *inode, void *data)
+{
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+
+	/* don't match inode of different type */
+	if (inode_wrong_type(inode, st->st_mode))
+		return 0;
+
+	if (inode->i_generation != st->st_gen)
+		return 0;
+
+	/* compare qid details */
+	if (memcmp(&v9inode->qid.version,
+		   &st->qid.version, sizeof(v9inode->qid.version)))
+		return 0;
+
+	if (v9inode->qid.type != st->qid.type)
+		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
+	return 1;
+}
+
+/* Always get a new inode */
+static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
+{
+	return 0;
+}
+
+static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
+{
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+
+	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
+	inode->i_generation = st->st_gen;
+	return 0;
+}
+
+static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
+					struct p9_qid *qid,
+					struct p9_fid *fid,
+					struct p9_stat_dotl *st,
+					int new)
 {
 	int retval;
 	struct inode *inode;
-	struct p9_stat_dotl *st;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
+	int (*test)(struct inode *inode, void *data);
 
-	inode = iget_locked(sb, QID2INO(&fid->qid));
-	if (unlikely(!inode))
+	if (new)
+		test = v9fs_test_new_inode_dotl;
+	else
+		test = v9fs_test_inode_dotl;
+
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
+	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
-
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
-	if (IS_ERR(st)) {
-		retval = PTR_ERR(st);
-		goto error;
-	}
-
-	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
+	inode->i_ino = QID2INO(qid);
+	retval = v9fs_init_inode(v9ses, inode,
 				 st->st_mode, new_decode_dev(st->st_rdev));
-	kfree(st);
 	if (retval)
 		goto error;
 
@@ -90,7 +133,6 @@ struct inode *v9fs_fid_iget_dotl(struct
 		goto error;
 
 	unlock_new_inode(inode);
-
 	return inode;
 error:
 	iget_failed(inode);
@@ -98,6 +140,22 @@ error:
 
 }
 
+struct inode *
+v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
+			 struct super_block *sb, int new)
+{
+	struct p9_stat_dotl *st;
+	struct inode *inode = NULL;
+
+	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
+	if (IS_ERR(st))
+		return ERR_CAST(st);
+
+	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, new);
+	kfree(st);
+	return inode;
+}
+
 struct dotl_openflag_map {
 	int open_flag;
 	int dotl_flag;
@@ -247,7 +305,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -342,7 +400,7 @@ static int v9fs_vfs_mkdir_dotl(struct mn
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -780,7 +838,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *id
 			 err);
 		goto error;
 	}
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_inode_from_fid(v9ses, fid, sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;



