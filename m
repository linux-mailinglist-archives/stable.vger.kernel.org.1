Return-Path: <stable+bounces-87964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1C99AD8B1
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 01:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3251C2187A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA46200120;
	Wed, 23 Oct 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RAPaK2sQ"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70461FF7CB;
	Wed, 23 Oct 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727545; cv=none; b=cR9lBfdO2hNiP9Jp1Ls1cNvNFTtquUa28BJpI7vEClI3yKXYds6yzRREBAXxRaxHG6QVrjSkIQEEo3uqSbycgAgWBavUitsNkMfWD17PgSKEkQ93NJWZYb0RTq8Pxks9Hf7imPxq9HifhyS56uTn6PDTaSJ8jmmj5zG3ms9UZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727545; c=relaxed/simple;
	bh=tsqUPM/PR8xfiBAclCOaHQKBESque+aEHCT06C3Sarg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aS03bznTRCorbSxh4vdFlvSVTo8hIeNbMJ40+jZ3WT+wRvhW9YFn9NzkIOFqq6KLJ9Cue8xP7Gb7T9bB5PPch7psaO/WdyMrmjeG13ywp7jTosR0fJ02F/FYcFyM7fxgB31A7efoO445wqGaesewBfiH+ovs8noJuhCACQGI5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=RAPaK2sQ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5B2CF14C2DD;
	Thu, 24 Oct 2024 01:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1729727542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oCYvnKC+qsBiQ6wpcOfEeHkKt8lulKZ/lLgqGbYceI=;
	b=RAPaK2sQx4Jo3GHxnQXO4A7Hlmx9yFPz3YDmKPeSKezvirsWsBmDmVKK4NTZxIYlI++YBN
	Tq0e2qbH5FIQ8o/X0RnDbuoVesqI/WazCOVP7Zo+2fPKjhea4QQDprYV2uRY3V3qQYFuDu
	6FWcIbaEbNfJxp5cLYWVwln9WWEXonen1bfoxJALs798vUTqCXpD0BofDUx5MDxB6roZPa
	WQLSWPxpHlGFHownqs6etfObqAAyXEkBV0Igt/suLsO5KJnHUJcnR8oxQI05CPxVXDe13s
	QTpHCYR9cdeGJHAKwtXaCTX8XuP/xs0c3eAWzrutmROvUMLAoGsbZ6MaUPyVgg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 04112cb7;
	Wed, 23 Oct 2024 23:52:14 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 24 Oct 2024 08:52:10 +0900
Subject: [PATCH 1/4] Revert " fs/9p: mitigate inode collisions"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-revert_iget-v1-1-4cac63d25f72@codewreck.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8144;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=tsqUPM/PR8xfiBAclCOaHQKBESque+aEHCT06C3Sarg=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBnGYwuGciyQHcgdjLOxNKBzAGyGA8TzqwkCvfe4
 je3Q8vJ6gSJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZxmMLgAKCRCrTpvsapjm
 cMCND/9LufOUyOUzMBZn8LT8J/R+6+49eiyOkEwPeorw7lKQyhFS/6KYtNqxA4zOect6y3viQPv
 kZkFbxbOP6LMNAtCgmTlqtRFst+7t5WFe0uM3+z1tlXyrzxrXGKdlYJG2k96jwBCESpFjNGsP3Y
 N3Wx3zw6EFZR7PkOJ266q2Y1OJ2+J8VsVHX5IT3yX3rvPmbnLlHhmTnlPPDbjJlCizskkGQhv7W
 gKpW0ULdSTQ0RB6idf/e8kHzp7UBUebTutGbvRB5wdHglvEzSaqvUe8Gsm3b9Xq2KUTgb4qSYMB
 Z3tTJ3Xm1uHXXuhw9kra6+gg76ZDOT3qhTYvpDkRcOdvuo7NOvM2jOien2eZTYdPpNXt4IOJrB9
 VkS6zwqsaFPbfN+6t75tnekaGllP+fZYg+JZ/O6ZmRXxSk3K2c0U7i663xztsG2KQnccTh325jk
 EFW89iwf9528lPOLIEXujwrOmgrr0H4HmiQGDTUCHlVK7/AMPmAKhMJtLEtnN1m2eC4wYWhsPnm
 B9FfjatADqofHYk0BS/JqKoebFwQNmBAQtdr7Sq5EkrthhGWKLx4Ak0Ih5B+Vqm54XwGpFEJLkr
 rPoeZwWbEwbz9uneQp7o7HA/jtK36pOd2bRGmIwkl6RVFv1eFSoTQthWaeYkr6k1wQhjPoMls/k
 4SjVHIV8mIkqLmg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This reverts commit d05dcfdf5e1659b2949d13060284eff3888b644e.

This is a requirement to revert commit 724a08450f74 ("fs/9p: simplify
iget to remove unnecessary paths"), see that revert for details.

Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
Reported-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20240923100508.GA32066@willie-the-truck
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/v9fs.h           | 11 +++++------
 fs/9p/vfs_inode.c      | 37 ++++++++-----------------------------
 fs/9p/vfs_inode_dotl.c | 28 ++++++++--------------------
 fs/9p/vfs_super.c      |  2 +-
 4 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 1775fcc7f0e8..9defa12208f9 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -179,14 +179,13 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
-extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid,
-						bool new);
+extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
 extern struct inode *v9fs_fid_iget_dotl(struct super_block *sb,
-						struct p9_fid *fid, bool new);
+					struct p9_fid *fid);
 
 /* other default globals */
 #define V9FS_PORT	564
@@ -225,12 +224,12 @@ static inline int v9fs_proto_dotl(struct v9fs_session_info *v9ses)
  */
 static inline struct inode *
 v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			struct super_block *sb, bool new)
+			struct super_block *sb)
 {
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_fid_iget_dotl(sb, fid, new);
+		return v9fs_fid_iget_dotl(sb, fid);
 	else
-		return v9fs_fid_iget(sb, fid, new);
+		return v9fs_fid_iget(sb, fid);
 }
 
 #endif
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index effb3aa1f3ed..5e05ec7af42e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -366,8 +366,7 @@ void v9fs_evict_inode(struct inode *inode)
 		clear_inode(inode);
 }
 
-struct inode *
-v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid, bool new)
+struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
 {
 	dev_t rdev;
 	int retval;
@@ -379,18 +378,8 @@ v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid, bool new)
 	inode = iget_locked(sb, QID2INO(&fid->qid));
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
-		if (!new) {
-			goto done;
-		} else {
-			p9_debug(P9_DEBUG_VFS, "WARNING: Inode collision %ld\n",
-						inode->i_ino);
-			iput(inode);
-			remove_inode_hash(inode);
-			inode = iget_locked(sb, QID2INO(&fid->qid));
-			WARN_ON(!(inode->i_state & I_NEW));
-		}
-	}
+	if (!(inode->i_state & I_NEW))
+		return inode;
 
 	/*
 	 * initialize the inode with the stat info
@@ -414,11 +403,11 @@ v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid, bool new)
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
-done:
 	return inode;
 error:
 	iget_failed(inode);
 	return ERR_PTR(retval);
+
 }
 
 /**
@@ -450,15 +439,8 @@ static int v9fs_at_to_dotl_flags(int flags)
  */
 static void v9fs_dec_count(struct inode *inode)
 {
-	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2) {
-		if (inode->i_nlink) {
-			drop_nlink(inode);
-		} else {
-			p9_debug(P9_DEBUG_VFS,
-						"WARNING: unexpected i_nlink zero %d inode %ld\n",
-						inode->i_nlink, inode->i_ino);
-		}
-	}
+	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
+		drop_nlink(inode);
 }
 
 /**
@@ -509,9 +491,6 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 		} else
 			v9fs_dec_count(inode);
 
-		if (inode->i_nlink <= 0)	/* no more refs unhash it */
-			remove_inode_hash(inode);
-
 		v9fs_invalidate_inode_attr(inode);
 		v9fs_invalidate_inode_attr(dir);
 
@@ -577,7 +556,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 		/*
 		 * instantiate inode and assign the unopened fid to the dentry
 		 */
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, true);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -706,7 +685,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
 	else
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb, false);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c61b97bd13b9..55dde186041a 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,10 +52,7 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 	return current_fsgid();
 }
 
-
-
-struct inode *
-v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid, bool new)
+struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 {
 	int retval;
 	struct inode *inode;
@@ -65,18 +62,8 @@ v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid, bool new)
 	inode = iget_locked(sb, QID2INO(&fid->qid));
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
-		if (!new) {
-			goto done;
-		} else { /* deal with race condition in inode number reuse */
-			p9_debug(P9_DEBUG_ERROR, "WARNING: Inode collision %lx\n",
-						inode->i_ino);
-			iput(inode);
-			remove_inode_hash(inode);
-			inode = iget_locked(sb, QID2INO(&fid->qid));
-			WARN_ON(!(inode->i_state & I_NEW));
-		}
-	}
+	if (!(inode->i_state & I_NEW))
+		return inode;
 
 	/*
 	 * initialize the inode with the stat info
@@ -103,11 +90,12 @@ v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid, bool new)
 		goto error;
 
 	unlock_new_inode(inode);
-done:
+
 	return inode;
 error:
 	iget_failed(inode);
 	return ERR_PTR(retval);
+
 }
 
 struct dotl_openflag_map {
@@ -259,7 +247,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid, true);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -352,7 +340,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid, true);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -788,7 +776,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-	inode = v9fs_fid_iget_dotl(dir->i_sb, fid, true);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index f52fdf42945c..55e67e36ae68 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_inode_from_fid(v9ses, fid, sb, true);
+	inode = v9fs_get_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;

-- 
2.46.0


