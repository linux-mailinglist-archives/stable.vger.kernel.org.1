Return-Path: <stable+bounces-160933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F545AFD2AA
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A01188DA53
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658182E54C3;
	Tue,  8 Jul 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IOeGnGzK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340B2DAFA3;
	Tue,  8 Jul 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993115; cv=none; b=ck3tEvjocrjjqzl0BBfnlKEurv5R6R5t/Wdo3zwTTZ+FITbp9gzLc9ymRl61P+wZeAp8XxDEFRoHCSNOcz4KvT/44s7LNJwMW5KwO5ncPlxmBxCAnLyXxrM32MktuOhvwDlWSDZN2z9wur+Txo+LFzS5dO1zHHEvgNlsMma/TKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993115; c=relaxed/simple;
	bh=XEj6ykCysKgMbKAOhtPSZtOze0xRplssXPl5s4iYw5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjFyWaB8C6NJXTec2Y70nEVD1RNakXE98Rmvfd8vsOvFACw3YYN5LvxWsaIFoYeSogSdcUfcxGcTlp5M5bmOBt85NZkDNWMoyoyGOH7DAHcgW3MObKiZrhide7ceCxH4BwaWgZONl+hZ3pjpnMkhJdtQuduDQR+i9IFmYQzSdUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IOeGnGzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C476C4CEED;
	Tue,  8 Jul 2025 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993114;
	bh=XEj6ykCysKgMbKAOhtPSZtOze0xRplssXPl5s4iYw5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOeGnGzKlO2wg0tQ+J/1QgtK9To6roujtT0yYtewTTGrs4XjH4EhYTMTIZJd9iU6G
	 69gI8H2Nf+HnP2DBTnQUyvu9vDzikEpp/ySEAzs69cQWYqr+YuxPzc7Zdm48gj66t3
	 bd1LLTxBSNdK+iMM0PVONDAa5m4Z2GTQJ32mBnfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 191/232] add a string-to-qstr constructor
Date: Tue,  8 Jul 2025 18:23:07 +0200
Message-ID: <20250708162246.434272872@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

[ Upstream commit c1feab95e0b2e9fce7e4f4b2739baf40d84543af ]

Quite a few places want to build a struct qstr by given string;
it would be convenient to have a primitive doing that, rather
than open-coding it via QSTR_INIT().

The closest approximation was in bcachefs, but that expands to
initializer list - {.len = strlen(string), .name = string}.
It would be more useful to have it as compound literal -
(struct qstr){.len = strlen(string), .name = string}.

Unlike initializer list it's a valid expression.  What's more,
it's a valid lvalue - it's an equivalent of anonymous local
variable with such initializer, so the things like
	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
are valid.  It can also be used as initializer, with identical
effect -
	struct qstr x = (struct qstr){.name = s, .len = strlen(s)};
is equivalent to
	struct qstr anon_variable = {.name = s, .len = strlen(s)};
	struct qstr x = anon_variable;
	// anon_variable is never used after that point
and any even remotely sane compiler will manage to collapse that
into
	struct qstr x = {.name = s, .len = strlen(s)};

What compound literals can't be used for is initialization of
global variables, but those are covered by QSTR_INIT().

This commit lifts definition(s) of QSTR() into linux/dcache.h,
converts it to compound literal (all bcachefs users are fine
with that) and converts assorted open-coded instances to using
that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/anon_inodes.c       |  4 ++--
 fs/bcachefs/fsck.c     |  2 +-
 fs/bcachefs/recovery.c |  2 --
 fs/bcachefs/util.h     |  2 --
 fs/erofs/xattr.c       |  2 +-
 fs/file_table.c        |  4 +---
 fs/kernfs/file.c       |  2 +-
 include/linux/dcache.h |  1 +
 mm/secretmem.c         |  3 +--
 net/sunrpc/rpc_pipe.c  | 14 +++++---------
 10 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 42bd1cb7c9cdd..583ac81669c24 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -60,14 +60,14 @@ static struct inode *anon_inode_make_secure_inode(
 	const struct inode *context_inode)
 {
 	struct inode *inode;
-	const struct qstr qname = QSTR_INIT(name, strlen(name));
 	int error;
 
 	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
-	error =	security_inode_init_security_anon(inode, &qname, context_inode);
+	error =	security_inode_init_security_anon(inode, &QSTR(name),
+						  context_inode);
 	if (error) {
 		iput(inode);
 		return ERR_PTR(error);
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 75c8a97a6954c..7b3b63ed747cf 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -405,7 +405,7 @@ static int reattach_inode(struct btree_trans *trans, struct bch_inode_unpacked *
 		return ret;
 
 	struct bch_hash_info dir_hash = bch2_hash_info_init(c, &lostfound);
-	struct qstr name = (struct qstr) QSTR(name_buf);
+	struct qstr name = QSTR(name_buf);
 
 	inode->bi_dir = lostfound.bi_inum;
 
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 3c7f941dde39a..ebabba2968821 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -32,8 +32,6 @@
 #include <linux/sort.h>
 #include <linux/stat.h>
 
-#define QSTR(n) { { { .len = strlen(n) } }, .name = n }
-
 void bch2_btree_lost_data(struct bch_fs *c, enum btree_id btree)
 {
 	if (btree >= BTREE_ID_NR_MAX)
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index fb02c1c360044..a27f4b84fe775 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -647,8 +647,6 @@ static inline int cmp_le32(__le32 l, __le32 r)
 
 #include <linux/uuid.h>
 
-#define QSTR(n) { { { .len = strlen(n) } }, .name = n }
-
 static inline bool qstr_eq(const struct qstr l, const struct qstr r)
 {
 	return l.len == r.len && !memcmp(l.name, r.name, l.len);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a90d7d6497390..60d2cf26e837e 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -407,7 +407,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	}
 
 	it.index = index;
-	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
+	it.name = QSTR(name);
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 18735dc8269a1..cf3422edf737c 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -332,9 +332,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 static inline int alloc_path_pseudo(const char *name, struct inode *inode,
 				    struct vfsmount *mnt, struct path *path)
 {
-	struct qstr this = QSTR_INIT(name, strlen(name));
-
-	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
+	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
 	if (!path->dentry)
 		return -ENOMEM;
 	path->mnt = mntget(mnt);
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 1943c8bd479bf..2d9d5dfa19b87 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -928,7 +928,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (!inode)
 			continue;
 
-		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
+		name = QSTR(kn->name);
 		parent = kernfs_get_parent(kn);
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bff956f7b2b98..3d53a60145911 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -57,6 +57,7 @@ struct qstr {
 };
 
 #define QSTR_INIT(n,l) { { { .len = l } }, .name = n }
+#define QSTR(n) (struct qstr)QSTR_INIT(n, strlen(n))
 
 extern const struct qstr empty_name;
 extern const struct qstr slash_name;
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 399552814fd0f..1b0a214ee5580 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,14 +195,13 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
 	int err;
 
 	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	err = security_inode_init_security_anon(inode, &qname, NULL);
+	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
 	if (err) {
 		file = ERR_PTR(err);
 		goto err_free_inode;
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 7ce3721c06ca5..eadc00410ebc5 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -630,7 +630,7 @@ static int __rpc_rmpipe(struct inode *dir, struct dentry *dentry)
 static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 					  const char *name)
 {
-	struct qstr q = QSTR_INIT(name, strlen(name));
+	struct qstr q = QSTR(name);
 	struct dentry *dentry = d_hash_and_lookup(parent, &q);
 	if (!dentry) {
 		dentry = d_alloc(parent, &q);
@@ -1190,8 +1190,7 @@ static const struct rpc_filelist files[] = {
 struct dentry *rpc_d_lookup_sb(const struct super_block *sb,
 			       const unsigned char *dir_name)
 {
-	struct qstr dir = QSTR_INIT(dir_name, strlen(dir_name));
-	return d_hash_and_lookup(sb->s_root, &dir);
+	return d_hash_and_lookup(sb->s_root, &QSTR(dir_name));
 }
 EXPORT_SYMBOL_GPL(rpc_d_lookup_sb);
 
@@ -1300,11 +1299,9 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	struct dentry *gssd_dentry;
 	struct dentry *clnt_dentry = NULL;
 	struct dentry *pipe_dentry = NULL;
-	struct qstr q = QSTR_INIT(files[RPCAUTH_gssd].name,
-				  strlen(files[RPCAUTH_gssd].name));
 
 	/* We should never get this far if "gssd" doesn't exist */
-	gssd_dentry = d_hash_and_lookup(root, &q);
+	gssd_dentry = d_hash_and_lookup(root, &QSTR(files[RPCAUTH_gssd].name));
 	if (!gssd_dentry)
 		return ERR_PTR(-ENOENT);
 
@@ -1314,9 +1311,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 		goto out;
 	}
 
-	q.name = gssd_dummy_clnt_dir[0].name;
-	q.len = strlen(gssd_dummy_clnt_dir[0].name);
-	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
+	clnt_dentry = d_hash_and_lookup(gssd_dentry,
+					&QSTR(gssd_dummy_clnt_dir[0].name));
 	if (!clnt_dentry) {
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
-- 
2.39.5




