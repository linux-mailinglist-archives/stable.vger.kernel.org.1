Return-Path: <stable+bounces-129734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A906A8014C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE7A881BD7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F632268FED;
	Tue,  8 Apr 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x4zuD4Lo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7C263C90;
	Tue,  8 Apr 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111837; cv=none; b=MtG2gEGqbwRzQ7LxteWBsLNFwHpIEtTzVWdSkC8xlqJ0dsFgXSAMlyOoZPSl0ESkzLQBCAmQZPLA3gGr8ycH6ZbLkqzLn29FT3NvdNcIIvzynF9FSSqfMSLo/LgEJufEq9LlhTp0TWxMLAtMBX3YKtgmGsu4n4g0s/TiJI/5NxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111837; c=relaxed/simple;
	bh=YGlN5+LPqxKvZpou4VN7YlVsh2YumDmMAAOVascCSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5nOT+WmdeqjyUctewCz1siKuSsN17z0h6PghSYbxxDPYRLEfuFr81xB+J6q+lvNzU3Yg57rcnZitTuM7AK62sT6fUv3cRIdhDG6nAj7Qp7+2z7j4SjquA4oQhS0qP8P9xWOTKSimpRvNuGLwTODmPM+Ue6SMLLPuybF5VjDncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x4zuD4Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FCEC4CEE5;
	Tue,  8 Apr 2025 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111836;
	bh=YGlN5+LPqxKvZpou4VN7YlVsh2YumDmMAAOVascCSew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x4zuD4Lo3F7k2QsEuqXzpv/ioRQctXcWMuQbirlxy/uR4Xtx2ZRBZ2m/A+TnJBcDH
	 kciX5pGeDHoi4q/zeppUrzKvhphZNQNH2bpMcDZtHUN8U161CA+T3YTkewBTSSeDFo
	 VmPwTTErIGl2PNGpR6igAfOBC0OmPJmU0BNX6l8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 578/731] spufs: fix gang directory lifetimes
Date: Tue,  8 Apr 2025 12:47:55 +0200
Message-ID: <20250408104927.718462316@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit c134deabf4784e155d360744d4a6a835b9de4dd4 ]

prior to "[POWERPC] spufs: Fix gang destroy leaks" we used to have
a problem with gang lifetimes - creation of a gang returns opened
gang directory, which normally gets removed when that gets closed,
but if somebody has created a context belonging to that gang and
kept it alive until the gang got closed, removal failed and we
ended up with a leak.

Unfortunately, it had been fixed the wrong way.  Dentry of gang
directory was no longer pinned, and rmdir on close was gone.
One problem was that failure of open kept calling simple_rmdir()
as cleanup, which meant an unbalanced dput().  Another bug was
in the success case - gang creation incremented link count on
root directory, but that was no longer undone when gang got
destroyed.

Fix consists of
	* reverting the commit in question
	* adding a counter to gang, protected by ->i_rwsem
of gang directory inode.
	* having it set to 1 at creation time, dropped
in both spufs_dir_close() and spufs_gang_close() and bumped
in spufs_create_context(), provided that it's not 0.
	* using simple_recursive_removal() to take the gang
directory out when counter reaches zero.

Fixes: 877907d37da9 "[POWERPC] spufs: Fix gang destroy leaks"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/gang.c  |  1 +
 arch/powerpc/platforms/cell/spufs/inode.c | 54 +++++++++++++++++++----
 arch/powerpc/platforms/cell/spufs/spufs.h |  2 +
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/gang.c b/arch/powerpc/platforms/cell/spufs/gang.c
index 827d338deaf4c..2c2999de6bfa2 100644
--- a/arch/powerpc/platforms/cell/spufs/gang.c
+++ b/arch/powerpc/platforms/cell/spufs/gang.c
@@ -25,6 +25,7 @@ struct spu_gang *alloc_spu_gang(void)
 	mutex_init(&gang->aff_mutex);
 	INIT_LIST_HEAD(&gang->list);
 	INIT_LIST_HEAD(&gang->aff_list_head);
+	gang->alive = 1;
 
 out:
 	return gang;
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 793c005607cf0..c566e7997f2c1 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -201,6 +201,23 @@ static int spufs_fill_dir(struct dentry *dir,
 	return 0;
 }
 
+static void unuse_gang(struct dentry *dir)
+{
+	struct inode *inode = dir->d_inode;
+	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
+
+	if (gang) {
+		bool dead;
+
+		inode_lock(inode); // exclusion with spufs_create_context()
+		dead = !--gang->alive;
+		inode_unlock(inode);
+
+		if (dead)
+			simple_recursive_removal(dir, NULL);
+	}
+}
+
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
 	struct inode *parent;
@@ -215,6 +232,7 @@ static int spufs_dir_close(struct inode *inode, struct file *file)
 	inode_unlock(parent);
 	WARN_ON(ret);
 
+	unuse_gang(dir->d_parent);
 	return dcache_dir_close(inode, file);
 }
 
@@ -407,7 +425,7 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 {
 	int ret;
 	int affinity;
-	struct spu_gang *gang;
+	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
 	struct spu_context *neighbor;
 	struct path path = {.mnt = mnt, .dentry = dentry};
 
@@ -422,11 +440,15 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 	if ((flags & SPU_CREATE_ISOLATE) && !isolated_loader)
 		return -ENODEV;
 
-	gang = NULL;
+	if (gang) {
+		if (!gang->alive)
+			return -ENOENT;
+		gang->alive++;
+	}
+
 	neighbor = NULL;
 	affinity = flags & (SPU_CREATE_AFFINITY_MEM | SPU_CREATE_AFFINITY_SPU);
 	if (affinity) {
-		gang = SPUFS_I(inode)->i_gang;
 		if (!gang)
 			return -EINVAL;
 		mutex_lock(&gang->aff_mutex);
@@ -455,6 +477,8 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 out_aff_unlock:
 	if (affinity)
 		mutex_unlock(&gang->aff_mutex);
+	if (ret && gang)
+		gang->alive--; // can't reach 0
 	return ret;
 }
 
@@ -484,6 +508,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_fop = &simple_dir_operations;
 
 	d_instantiate(dentry, inode);
+	dget(dentry);
 	inc_nlink(dir);
 	inc_nlink(d_inode(dentry));
 	return ret;
@@ -494,6 +519,21 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return ret;
 }
 
+static int spufs_gang_close(struct inode *inode, struct file *file)
+{
+	unuse_gang(file->f_path.dentry);
+	return dcache_dir_close(inode, file);
+}
+
+static const struct file_operations spufs_gang_fops = {
+	.open		= dcache_dir_open,
+	.release	= spufs_gang_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.fsync		= noop_fsync,
+};
+
 static int spufs_gang_open(const struct path *path)
 {
 	int ret;
@@ -513,7 +553,7 @@ static int spufs_gang_open(const struct path *path)
 		return PTR_ERR(filp);
 	}
 
-	filp->f_op = &simple_dir_operations;
+	filp->f_op = &spufs_gang_fops;
 	fd_install(ret, filp);
 	return ret;
 }
@@ -528,10 +568,8 @@ static int spufs_create_gang(struct inode *inode,
 	ret = spufs_mkgang(inode, dentry, mode & 0777);
 	if (!ret) {
 		ret = spufs_gang_open(&path);
-		if (ret < 0) {
-			int err = simple_rmdir(inode, dentry);
-			WARN_ON(err);
-		}
+		if (ret < 0)
+			unuse_gang(dentry);
 	}
 	return ret;
 }
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 84958487f696a..d33787c57c39a 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -151,6 +151,8 @@ struct spu_gang {
 	int aff_flags;
 	struct spu *aff_ref_spu;
 	atomic_t aff_sched_count;
+
+	int alive;
 };
 
 /* Flag bits for spu_gang aff_flags */
-- 
2.39.5




