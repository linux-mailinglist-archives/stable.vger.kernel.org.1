Return-Path: <stable+bounces-153064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D6ADD25F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9657A6BB4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339822ECD0A;
	Tue, 17 Jun 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xFceh+ks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4220F090;
	Tue, 17 Jun 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174750; cv=none; b=kWVEx/LgahEHQHrHwsNYPfsBNuGACXNlmoxKzfllOD2n4CS2Mxl5By6CCAVJ2QcTxritq2MLvuVlQcByyyRaSEPCi7d+1y3F4OYwRnhHsPnjJSBoN2RUIHN8wR3HG0r4qe0XlzQ8oSk3ZL0JLKpYNyFiHQDfJljTiX+MVNkFhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174750; c=relaxed/simple;
	bh=IruC1aHYkPPDQLolQfawMohOKLm2kv/VuYfJ7C3Assw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aucbmUDXtgfaRjamXrCHmxxvmxPLmclUrcQOnRyFq+DXMMaoUrShE5hwJABQQcAQcoR96i9M7q4bMDghaJzZhjmyfsPX4FcFLmM1graZmah2U9ixLqi3KsAMMJ61IftsPKSGn/f7LU76cv4Eb7RjWzGZ00bc/9JEOp1LPxMNW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xFceh+ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1E7C4CEE3;
	Tue, 17 Jun 2025 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174749;
	bh=IruC1aHYkPPDQLolQfawMohOKLm2kv/VuYfJ7C3Assw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xFceh+ks451cd8XLqe8Js4Zb54z4rCA3DCOZTZILFiEJ7hXzGPO786rWsLjAzbPVV
	 +5GbUBcgHaGQWyvjYxpRj3m6AGEjOhnaitOpwVN96E22M4P8AbeKBaJzw2sBg+PXcY
	 N1c4vsZd3+BLw05DBY6ypV93LR2gVr7uDC82NoB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 017/780] gfs2: deallocate inodes in gfs2_create_inode
Date: Tue, 17 Jun 2025 17:15:25 +0200
Message-ID: <20250617152452.203029241@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 2c63986dd35fa9eb0d7d1530b5eb2244b7296e22 ]

When creating and destroying inodes, we are relying on the inode hash
table to make sure that for a given inode number, only a single inode
will exist.  We then link that inode to its inode and iopen glock and
let those glocks point back at the inode.  However, when iget_failed()
is called, the inode is removed from the inode hash table before
gfs_evict_inode() is called, and uniqueness is no longer guaranteed.

Commit f1046a472b70 ("gfs2: gl_object races fix") was trying to work
around that problem by detaching the inode glock from the inode before
calling iget_failed(), but that broke the inode deallocation code in
gfs_evict_inode().

To fix that, deallocate partially created inodes in gfs2_create_inode()
instead of relying on gfs_evict_inode() for doing that.

This means that gfs2_evict_inode() and its helper functions will no
longer see partially created inodes, and so some simplifications are
possible there.

Fixes: 9ffa18884cce ("gfs2: gl_object races fix")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 27 +++++++++++++++++++--------
 fs/gfs2/super.c |  6 +-----
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index b2d38d09af7e8..8fd81444ffea0 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -697,10 +697,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	struct gfs2_inode *dip = GFS2_I(dir), *ip;
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
 	struct gfs2_glock *io_gl;
-	int error;
+	int error, dealloc_error;
 	u32 aflags = 0;
 	unsigned blocks = 1;
 	struct gfs2_diradd da = { .bh = NULL, .save_loc = 1, };
+	bool xattr_initialized = false;
 
 	if (!name->len || name->len > GFS2_FNAMESIZE)
 		return -ENAMETOOLONG;
@@ -813,11 +814,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
 	if (error)
-		goto fail_free_inode;
+		goto fail_dealloc_inode;
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
 	if (error)
-		goto fail_free_inode;
+		goto fail_dealloc_inode;
 	gfs2_cancel_delete_work(io_gl);
 	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
 
@@ -841,8 +842,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_gunlock3;
 
-	if (blocks > 1)
+	if (blocks > 1) {
 		gfs2_init_xattr(ip);
+		xattr_initialized = true;
+	}
 	init_dinode(dip, ip, symname);
 	gfs2_trans_end(sdp);
 
@@ -897,6 +900,18 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 fail_gunlock2:
 	gfs2_glock_put(io_gl);
+fail_dealloc_inode:
+	set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
+	dealloc_error = 0;
+	if (ip->i_eattr)
+		dealloc_error = gfs2_ea_dealloc(ip, xattr_initialized);
+	clear_nlink(inode);
+	mark_inode_dirty(inode);
+	if (!dealloc_error)
+		dealloc_error = gfs2_dinode_dealloc(ip);
+	if (dealloc_error)
+		fs_warn(sdp, "%s: %d\n", __func__, dealloc_error);
+	ip->i_no_addr = 0;
 fail_free_inode:
 	if (ip->i_gl) {
 		gfs2_glock_put(ip->i_gl);
@@ -911,10 +926,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(&d_gh);
 	if (!IS_ERR_OR_NULL(inode)) {
-		set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
-		clear_nlink(inode);
-		if (ip->i_no_addr)
-			mark_inode_dirty(inode);
 		if (inode->i_state & I_NEW)
 			iget_failed(inode);
 		else
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e25a24ae2197f..54f1efd47a3e5 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1258,9 +1258,6 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int ret;
 
-	if (unlikely(test_bit(GIF_ALLOC_FAILED, &ip->i_flags)))
-		goto should_delete;
-
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(GLF_DEFER_DELETE, &ip->i_iopen_gh.gh_gl->gl_flags))
 		return EVICT_SHOULD_DEFER_DELETE;
@@ -1290,7 +1287,6 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 	if (inode->i_nlink)
 		return EVICT_SHOULD_SKIP_DELETE;
 
-should_delete:
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags))
 		return gfs2_upgrade_iopen_glock(inode);
@@ -1314,7 +1310,7 @@ static int evict_unlinked_inode(struct inode *inode)
 	}
 
 	if (ip->i_eattr) {
-		ret = gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
+		ret = gfs2_ea_dealloc(ip, true);
 		if (ret)
 			goto out;
 	}
-- 
2.39.5




