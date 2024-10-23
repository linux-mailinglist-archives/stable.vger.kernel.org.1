Return-Path: <stable+bounces-87967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6C9AD8B8
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 01:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158411C216CE
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1C201104;
	Wed, 23 Oct 2024 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="yqJicc7f"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5808200B81;
	Wed, 23 Oct 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727551; cv=none; b=uB7yM/mW49uHNPJfaWvhGRNSOeLoq7lUHU4OQpnMA6vwS93fbVXTgz4DgGmFk2liLiC540sK3fnRH2w87Wg5rFt4Bzfts8uOn52udV1N00yfLuxWw6IjHLGXy1GhHFDiZDOztuz7s9pFgJyy4G2gLfuWrh2KIcsr/Z7BpUYXg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727551; c=relaxed/simple;
	bh=PPkik43Ft+ziz/KL7sgGGZXrZDSANPKFv63JbrbMYKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+5MTcDWqSnEWiN/tWnPguyWvWreeJnRhweGEsCoW3r+SSDOz/+cwBDJv9YBPu6t3xuAMba5fYgpXsqu6mvkrLgoW1MtYoq7A9LiqSRpTh1LsRVfFDN7CqIxIbYn5bqqIdPHXpL7xOQwpLkF20Q8HgAhdHQVtqkujVP5YQbKdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=yqJicc7f; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 856F014C2E0;
	Thu, 24 Oct 2024 01:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729727547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBuilkAE0mEP50w0sfwMqno3aFOex5ZsPzmLQrBt/eU=;
	b=yqJicc7f4niXza4eh2/DFr/EMwE4QxVsdMY0U2eR0HzhYYlXmdumPxJ1Q1W4D5mUPBeFYW
	VrF6PbK7z9k2ax6fy84kVaEt85fYWGE19M/T2Q0HqmoY2LCoZa1ArgoC315QFJAd/+HYOL
	zT6KrK5q9BebNOC2cJMvjVLakTcfwEzmPP0kibs3pXAGHR5S2oshLfYvBM+G6pg35NM5aX
	ak+1XVNLtj+HOSoyf9dbKB2YXZVKzeK4a5TwrYeGk3GOjx/JG4HOAdwZHQcU3MGS65J1ex
	P3YQmbPm0d7eeySRC+xO5SKXMiK+JPmJrFO0tPU2KQfuHF287UrqtHYl1x2E2Q==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 9385011d;
	Wed, 23 Oct 2024 23:52:14 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 24 Oct 2024 08:52:13 +0900
Subject: [PATCH 4/4] Revert "fs/9p: simplify iget to remove unnecessary
 paths"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-revert_iget-v1-4-4cac63d25f72@codewreck.org>
References: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
In-Reply-To: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>, Will Deacon <will@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=15014;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=PPkik43Ft+ziz/KL7sgGGZXrZDSANPKFv63JbrbMYKk=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnGYwuVSjuK+6OOqZl2inM7epu748jxmsciFjrS
 6nXenBLrMuJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZxmMLgAKCRCrTpvsapjm
 cO8wD/oDyKbCOSsDyzLtQCVDMbSM4krc8ST19/4iAZMoJSs9N8TC5vn4GCRs56BQd/WPXtBWpln
 8HQvxD5AECP6iG8FNnn99QkWZ3+PWF84qDNtky+2TGUD3u3YsqHC1Pw3jwqWHmdMX6opl1KijZO
 6Lq3NU+AXLSjfQuBfUgljRsS5+EoD4knE62C9Rr5ttzVi2gsV6BBDJg6w11ofiyB9WHM3VOe3gF
 llJOHe1M1k6pn//HxGPgfaWGZ7p/VAawAQ2+W/la1zcY5NRt9ArhD8c0isBUUTDvaO3ChOWV4xL
 b+44JVdN+DEXXIDsVp27wfcgHmtv0/16S93PfFOY/2T9eJmt+K9MciOozGUho2+25I33Ul/Suw4
 /U5TPOjxiULmH/QziNm7nq0078mwTpYqiFoaS+GjGCIESVnPMv4JUmgHdRDM1YtZj2fWD58Pek9
 L1XbOpMIeWWGZi5/Ra/CLSb306eXkMhrwODrlUx8LJ5vWrzZrdL+wfiW1tkhlQWc+06y2aKmQmX
 Tj8Ky8C2kKoARsPVPjCTvOLiLkKqCqTRDr+0cLIEejXRwiQ6HlAGMBg8MJs1+GIW9cgINB8eani
 0uflN1hxfDsPLniDRZ7RPsuNm+l8pQSRQ6kJ/bz3chnTLttPXSCX40kTvzkXJ4Imxi6554+D+ub
 ub1B1/L+iXYakAA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This reverts commit 724a08450f74b02bd89078a596fd24857827c012.

This code simplification introduced significant regressions on servers
that do not remap inode numbers when exporting multiple underlying
filesystems with colliding inodes, as can be illustrated with simple
tmpfs exports in qemu with remapping disabled:
---
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
---
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
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/v9fs.h           | 31 +++++++++++++---
 fs/9p/v9fs_vfs.h       |  2 +-
 fs/9p/vfs_inode.c      | 98 +++++++++++++++++++++++++++++++++++++++-----------
 fs/9p/vfs_inode_dotl.c | 92 ++++++++++++++++++++++++++++++++++++++---------
 fs/9p/vfs_super.c      |  2 +-
 5 files changed, 180 insertions(+), 45 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 9defa12208f9..698c43dd5dc8 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -179,13 +179,16 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
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
@@ -227,9 +230,27 @@ v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
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
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 7923c3c347cb..d3aefbec4de6 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -42,7 +42,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
 void v9fs_set_netfs_context(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev);
+		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
 #if (BITS_PER_LONG == 32)
 #define QID2INO(q) ((ino_t) (((q)->path+2) ^ (((q)->path) >> 32)))
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5e05ec7af42e..e9c052b35dd9 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -256,12 +256,9 @@ void v9fs_set_netfs_context(struct inode *inode)
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
@@ -366,40 +363,80 @@ void v9fs_evict_inode(struct inode *inode)
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
 
-	inode = iget_locked(sb, QID2INO(&fid->qid));
-	if (unlikely(!inode))
+	if (new)
+		test = v9fs_test_new_inode;
+	else
+		test = v9fs_test_inode;
+
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
@@ -410,6 +447,23 @@ struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
 
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
@@ -556,7 +610,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 		/*
 		 * instantiate inode and assign the unopened fid to the dentry
 		 */
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -684,8 +738,10 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
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
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..143ac03b7425 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,33 +52,76 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
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
 
@@ -90,7 +133,6 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 		goto error;
 
 	unlock_new_inode(inode);
-
 	return inode;
 error:
 	iget_failed(inode);
@@ -98,6 +140,22 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 
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
@@ -247,7 +305,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -342,7 +400,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -780,7 +838,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 55e67e36ae68..489db161abc9 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_inode_from_fid(v9ses, fid, sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;

-- 
2.46.0


