Return-Path: <stable+bounces-3921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316D803F7F
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836E81C20BC8
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8035EF4;
	Mon,  4 Dec 2023 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHU6ht/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB4364AB
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5A4C433C7;
	Mon,  4 Dec 2023 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722032;
	bh=oQZsZ4MZN5UxA81sG8wmKWKSLNwx9Tan/KFg+Ti7ghU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHU6ht/uLXoxf0LwHMXtG3CW5wV9+vAVwE7qDTEU6gDaFPAA2Ms8M8BFCFUU3Egmv
	 Tm9CYBEqGII1UP+70ElgfSa3vDJmYM++eTjvClqPA1zYvtYatINn4gG0URfl0gA937
	 wZ8YzY25MUL9WyYdcsbN9yrgj8H2KIQFID5w2FFJiaziH3yfFb4jCMsD0a6/rGJd5/
	 LUQvRFFjW4jy2/YtboAu5p+2jGBqKiSMA9ITpGLL+PXNSJCe9F15Grh7miRzEutn+o
	 qzJVOOYIW01SE0Lu+fwz3m0f56SnNiJaXIvDBlLBnkC8ZFx0lB8wBPKBvE4+KWH19I
	 UrL/kogOVogKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 14/32] debugfs: fix automount d_fsdata usage
Date: Mon,  4 Dec 2023 15:32:34 -0500
Message-ID: <20231204203317.2092321-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 0ed04a1847a10297595ac24dc7d46b35fb35f90a ]

debugfs_create_automount() stores a function pointer in d_fsdata,
but since commit 7c8d469877b1 ("debugfs: add support for more
elaborate ->d_fsdata") debugfs_release_dentry() will free it, now
conditionally on DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, but that's not
set for the function pointer in automount. As a result, removing
an automount dentry would attempt to free the function pointer.
Luckily, the only user of this (tracing) never removes it.

Nevertheless, it's safer if we just handle the fsdata in one way,
namely either DEBUGFS_FSDATA_IS_REAL_FOPS_BIT or allocated. Thus,
change the automount to allocate it, and use the real_fops in the
data to indicate whether or not automount is filled, rather than
adding a type tag. At least for now this isn't actually needed,
but the next changes will require it.

Also check in debugfs_file_get() that it gets only called
on regular files, just to make things clearer.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c     |  8 ++++++++
 fs/debugfs/inode.c    | 27 ++++++++++++++++++++-------
 fs/debugfs/internal.h | 10 ++++++++--
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c45e8c2d62e11..e40229c47fe58 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -84,6 +84,14 @@ int debugfs_file_get(struct dentry *dentry)
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
 
+	/*
+	 * This could only happen if some debugfs user erroneously calls
+	 * debugfs_file_get() on a dentry that isn't even a file, let
+	 * them know about it.
+	 */
+	if (WARN_ON(!d_is_reg(dentry)))
+		return -EINVAL;
+
 	d_fsd = READ_ONCE(dentry->d_fsdata);
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 83e57e9f9fa03..dcde4199a625d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -236,17 +236,19 @@ static const struct super_operations debugfs_super_operations = {
 
 static void debugfs_release_dentry(struct dentry *dentry)
 {
-	void *fsd = dentry->d_fsdata;
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		kfree(dentry->d_fsdata);
+	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+		return;
+
+	kfree(fsd);
 }
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	debugfs_automount_t f;
-	f = (debugfs_automount_t)path->dentry->d_fsdata;
-	return f(path->dentry, d_inode(path->dentry)->i_private);
+	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+
+	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -634,13 +636,23 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
+	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
+	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
+	if (!fsd) {
+		failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fsd->automount = f;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
+		kfree(fsd);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -648,13 +660,14 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
+		kfree(fsd);
 		return failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = (void *)f;
+	dentry->d_fsdata = fsd;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 92af8ae313134..f7c489b5a368c 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -17,8 +17,14 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
-	refcount_t active_users;
-	struct completion active_users_drained;
+	union {
+		/* automount_fn is used when real_fops is NULL */
+		debugfs_automount_t automount;
+		struct {
+			refcount_t active_users;
+			struct completion active_users_drained;
+		};
+	};
 };
 
 /*
-- 
2.42.0


