Return-Path: <stable+bounces-54246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3290ED55
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79031C21614
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578C12FB27;
	Wed, 19 Jun 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hz8KfGRU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2978AD58;
	Wed, 19 Jun 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803013; cv=none; b=Rj3ugJ8HwvHafLop3JUX02if82SV7QcURfl6/fJVAQhOypl3GhsnKv+6cZtDvw1wfAdBuqb23Pd13v2C1obXg8OKR/TcQ0uHek/Z8K2KZEawPoFz3FW0YHE33T+Nf/WIAphmTJBpQ8/Phqffnb3HzelJVWsVP25WhjaFdd0Y9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803013; c=relaxed/simple;
	bh=43ul5ftEKTSOXCGvbMivRst27y929MHEZuJ/JhSTFBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/gHIrtBtLF2LMKQCS1gH0ycZMGclSqW8XMFbG9G+KwVfIDEEjVGYTlS+FrswIv+CtguS1Rt0oOVAgD5cZPz5iQCqPM2p5y1JCjEVbX/lh+r5HLboiSp5MN4jGl/Bw/u564YQAg5QlgNuljl0EgXulUh2BC/D3Oo2NpHhG8NSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hz8KfGRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285DDC2BBFC;
	Wed, 19 Jun 2024 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803013;
	bh=43ul5ftEKTSOXCGvbMivRst27y929MHEZuJ/JhSTFBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hz8KfGRUqR6xx5ynG4xofomzABJp9xTEDuL4BD3wQo9Eo9u562jQPo8dh7aeWnkhH
	 oumowVeY10USfoNuEj2eH0uDsI/U7mvNmii9hZ6XsMbGn6bwAfmTzG5F9ciSp5OZpt
	 7PCBjXrgb0kJ5ghJHr1z/tx1OP0iWmhQQeOSNUOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>
Subject: [PATCH 6.9 124/281] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
Date: Wed, 19 Jun 2024 14:54:43 +0200
Message-ID: <20240619125614.616691392@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit 99bc9f2eb3f79a2b4296d9bf43153e1d10ca50d3 ]

dentry->d_fsdata is set to NFS_FSDATA_BLOCKED while unlinking or
renaming-over a file to ensure that no open succeeds while the NFS
operation progressed on the server.

Setting dentry->d_fsdata to NFS_FSDATA_BLOCKED is done under ->d_lock
after checking the refcount is not elevated.  Any attempt to open the
file (through that name) will go through lookp_open() which will take
->d_lock while incrementing the refcount, we can be sure that once the
new value is set, __nfs_lookup_revalidate() *will* see the new value and
will block.

We don't have any locking guarantee that when we set ->d_fsdata to NULL,
the wait_var_event() in __nfs_lookup_revalidate() will notice.
wait/wake primitives do NOT provide barriers to guarantee order.  We
must use smp_load_acquire() in wait_var_event() to ensure we look at an
up-to-date value, and must use smp_store_release() before wake_up_var().

This patch adds those barrier functions and factors out
block_revalidate() and unblock_revalidate() far clarity.

There is also a hypothetical bug in that if memory allocation fails
(which never happens in practice) we might leave ->d_fsdata locked.
This patch adds the missing call to unblock_revalidate().

Reported-and-tested-by: Richard Kojedzinszky <richard+debian+bugreport@kojedz.in>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071501
Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/dir.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbdb..bdd6cb33a3708 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1802,9 +1802,10 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
 		if (parent != READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else {
-		/* Wait for unlink to complete */
+		/* Wait for unlink to complete - see unblock_revalidate() */
 		wait_var_event(&dentry->d_fsdata,
-			       dentry->d_fsdata != NFS_FSDATA_BLOCKED);
+			       smp_load_acquire(&dentry->d_fsdata)
+			       != NFS_FSDATA_BLOCKED);
 		parent = dget_parent(dentry);
 		ret = reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -1817,6 +1818,29 @@ static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate);
 }
 
+static void block_revalidate(struct dentry *dentry)
+{
+	/* old devname - just in case */
+	kfree(dentry->d_fsdata);
+
+	/* Any new reference that could lead to an open
+	 * will take ->d_lock in lookup_open() -> d_lookup().
+	 * Holding this lock ensures we cannot race with
+	 * __nfs_lookup_revalidate() and removes and need
+	 * for further barriers.
+	 */
+	lockdep_assert_held(&dentry->d_lock);
+
+	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+}
+
+static void unblock_revalidate(struct dentry *dentry)
+{
+	/* store_release ensures wait_var_event() sees the update */
+	smp_store_release(&dentry->d_fsdata, NULL);
+	wake_up_var(&dentry->d_fsdata);
+}
+
 /*
  * A weaker form of d_revalidate for revalidating just the d_inode(dentry)
  * when we don't really care about the dentry name. This is called when a
@@ -2501,15 +2525,12 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		goto out;
 	}
-	/* old devname */
-	kfree(dentry->d_fsdata);
-	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+	block_revalidate(dentry);
 
 	spin_unlock(&dentry->d_lock);
 	error = nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	dentry->d_fsdata = NULL;
-	wake_up_var(&dentry->d_fsdata);
+	unblock_revalidate(dentry);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;
@@ -2616,8 +2637,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
 {
 	struct dentry *new_dentry = data->new_dentry;
 
-	new_dentry->d_fsdata = NULL;
-	wake_up_var(&new_dentry->d_fsdata);
+	unblock_revalidate(new_dentry);
 }
 
 /*
@@ -2679,11 +2699,6 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (WARN_ON(new_dentry->d_flags & DCACHE_NFSFS_RENAMED) ||
 		    WARN_ON(new_dentry->d_fsdata == NFS_FSDATA_BLOCKED))
 			goto out;
-		if (new_dentry->d_fsdata) {
-			/* old devname */
-			kfree(new_dentry->d_fsdata);
-			new_dentry->d_fsdata = NULL;
-		}
 
 		spin_lock(&new_dentry->d_lock);
 		if (d_count(new_dentry) > 2) {
@@ -2705,7 +2720,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			new_dentry = dentry;
 			new_inode = NULL;
 		} else {
-			new_dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+			block_revalidate(new_dentry);
 			must_unblock = true;
 			spin_unlock(&new_dentry->d_lock);
 		}
@@ -2717,6 +2732,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
 	if (IS_ERR(task)) {
+		if (must_unblock)
+			unblock_revalidate(new_dentry);
 		error = PTR_ERR(task);
 		goto out;
 	}
-- 
2.43.0




