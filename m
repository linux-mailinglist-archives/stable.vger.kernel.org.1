Return-Path: <stable+bounces-90867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245689BEB69
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C91CB210F5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366D1EABB4;
	Wed,  6 Nov 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qB4IspR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C21EABC7;
	Wed,  6 Nov 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897050; cv=none; b=NJ3P72EEtKJA1ufjeAzH9fo73fAAy3V6iS0DJq/baMESGqsZCP39qRgFivQb4Cqs71sLnhXaNrypWY3SrTmdJENgYCj0BPIp93KZUAVD9Okt5zmgjFqSNJF+Nfs+V4r1E9OuvqHlGt3+4RYYCwx7lrApJyQu2UDJ0vVoiC2qxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897050; c=relaxed/simple;
	bh=JEJ3xWldJFg4aFVRXjkQHIVjIn08yvN36UZvltAWH2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVV/1PDY3yMb3EDMCVGiYNUU+ToD+aKe0SUylro/0Mpi7IosoV0W/j89kLlwCk5h+aWuDLzcGWFO95Cjb6hh2kMuHiIURmXHy4xhFVLEkIZTTAkr9vaGJDWAh1hxTedU6rrAWCVIbpXwW/p3+PI/fm5r8nX0geqDb8q7WvLg3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qB4IspR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92F6C4CED5;
	Wed,  6 Nov 2024 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897050;
	bh=JEJ3xWldJFg4aFVRXjkQHIVjIn08yvN36UZvltAWH2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qB4IspR1xLLXKmXOQtQtzqqYFGW9YIYmxsrC01Ha5mXWqqUQj+Ol74RlFhjxXQSEJ
	 Axs9uJX7gUEu95IgPs+YBJqUgyIHwoekhF9N8SBuCe6tWlJO3oubvw+vAphAdOGXdu
	 d/kXu+d9puwL/GTs516ykolgBs7O2pGsa6cbTUhY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/126] afs: Fix missing subdir edit when renamed between parent dirs
Date: Wed,  6 Nov 2024 13:04:11 +0100
Message-ID: <20241106120307.454136988@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 247d65fb122ad560be1c8c4d87d7374fb28b0770 ]

When rename moves an AFS subdirectory between parent directories, the
subdir also needs a bit of editing: the ".." entry needs updating to point
to the new parent (though I don't make use of the info) and the DV needs
incrementing by 1 to reflect the change of content.  The server also sends
a callback break notification on the subdirectory if we have one, but we
can take care of recovering the promise next time we access the subdir.

This can be triggered by something like:

    mount -t afs %example.com:xfstest.test20 /xfstest.test/
    mkdir /xfstest.test/{aaa,bbb,aaa/ccc}
    touch /xfstest.test/bbb/ccc/d
    mv /xfstest.test/{aaa/ccc,bbb/ccc}
    touch /xfstest.test/bbb/ccc/e

When the pathwalk for the second touch hits "ccc", kafs spots that the DV
is incorrect and downloads it again (so the fix is not critical).

Fix this, if the rename target is a directory and the old and new
parents are different, by:

 (1) Incrementing the DV number of the target locally.

 (2) Editing the ".." entry in the target to refer to its new parent's
     vnode ID and uniquifier.

Link: https://lore.kernel.org/r/3340431.1729680010@warthog.procyon.org.uk
Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c               | 25 +++++++++++
 fs/afs/dir_edit.c          | 91 +++++++++++++++++++++++++++++++++++++-
 fs/afs/internal.h          |  2 +
 include/trace/events/afs.h |  7 ++-
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 07dc4ec73520c..38d5260c4614f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -12,6 +12,7 @@
 #include <linux/swap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
+#include <linux/iversion.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 #include "afs_fs.h"
@@ -1808,6 +1809,8 @@ static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 static void afs_rename_success(struct afs_operation *op)
 {
+	struct afs_vnode *vnode = AFS_FS_I(d_inode(op->dentry));
+
 	_enter("op=%08x", op->debug_id);
 
 	op->ctime = op->file[0].scb.status.mtime_client;
@@ -1817,6 +1820,22 @@ static void afs_rename_success(struct afs_operation *op)
 		op->ctime = op->file[1].scb.status.mtime_client;
 		afs_vnode_commit_status(op, &op->file[1]);
 	}
+
+	/* If we're moving a subdir between dirs, we need to update
+	 * its DV counter too as the ".." will be altered.
+	 */
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    op->file[0].vnode != op->file[1].vnode) {
+		u64 new_dv;
+
+		write_seqlock(&vnode->cb_lock);
+
+		new_dv = vnode->status.data_version + 1;
+		vnode->status.data_version = new_dv;
+		inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
+
+		write_sequnlock(&vnode->cb_lock);
+	}
 }
 
 static void afs_rename_edit_dir(struct afs_operation *op)
@@ -1858,6 +1877,12 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 				 &vnode->fid, afs_edit_dir_for_rename_2);
 	}
 
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    new_dvnode != orig_dvnode &&
+	    test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+		afs_edit_dir_update_dotdot(vnode, new_dvnode,
+					   afs_edit_dir_for_rename_sub);
+
 	new_inode = d_inode(new_dentry);
 	if (new_inode) {
 		spin_lock(&new_inode->i_lock);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 0ab7752d1b758..e22682c577302 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -126,10 +126,10 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
 /*
  * Scan a directory block looking for a dirent of the right name.
  */
-static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
+static int afs_dir_scan_block(const union afs_xdr_dir_block *block, const struct qstr *name,
 			      unsigned int blocknum)
 {
-	union afs_xdr_dirent *de;
+	const union afs_xdr_dirent *de;
 	u64 bitmap;
 	int d, len, n;
 
@@ -491,3 +491,90 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
+
+/*
+ * Edit a subdirectory that has been moved between directories to update the
+ * ".." entry.
+ */
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
+				enum afs_edit_dir_reason why)
+{
+	union afs_xdr_dir_block *block;
+	union afs_xdr_dirent *de;
+	struct folio *folio;
+	unsigned int nr_blocks, b;
+	pgoff_t index;
+	loff_t i_size;
+	int slot;
+
+	_enter("");
+
+	i_size = i_size_read(&vnode->netfs.inode);
+	if (i_size < AFS_DIR_BLOCK_SIZE) {
+		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		return;
+	}
+	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
+
+	/* Find a block that has sufficient slots available.  Each folio
+	 * contains two or more directory blocks.
+	 */
+	for (b = 0; b < nr_blocks; b++) {
+		index = b / AFS_DIR_BLOCKS_PER_PAGE;
+		folio = afs_dir_get_folio(vnode, index);
+		if (!folio)
+			goto error;
+
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
+
+		/* Abandon the edit if we got a callback break. */
+		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+			goto invalidated;
+
+		slot = afs_dir_scan_block(block, &dotdot_name, b);
+		if (slot >= 0)
+			goto found_dirent;
+
+		kunmap_local(block);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	/* Didn't find the dirent to clobber.  Download the directory again. */
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+found_dirent:
+	de = &block->dirents[slot];
+	de->u.vnode  = htonl(new_dvnode->fid.vnode);
+	de->u.unique = htonl(new_dvnode->fid.unique);
+
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_dd, b, slot,
+			   ntohl(de->u.vnode), ntohl(de->u.unique), "..");
+
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_version);
+
+out:
+	_leave("");
+	return;
+
+invalidated:
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+error:
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a25fdc3e52310..097d5a5f07b1a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1043,6 +1043,8 @@ extern void afs_check_for_remote_deletion(struct afs_operation *);
 extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *,
 			     enum afs_edit_dir_reason);
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
+				enum afs_edit_dir_reason why);
 
 /*
  * dir_silly.c
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 54d10c69e55ec..d1ee4272d1cb8 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -295,7 +295,11 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_delete,			"delete") \
 	EM(afs_edit_dir_delete_error,		"d_err ") \
 	EM(afs_edit_dir_delete_inval,		"d_invl") \
-	E_(afs_edit_dir_delete_noent,		"d_nent")
+	EM(afs_edit_dir_delete_noent,		"d_nent") \
+	EM(afs_edit_dir_update_dd,		"u_ddot") \
+	EM(afs_edit_dir_update_error,		"u_fail") \
+	EM(afs_edit_dir_update_inval,		"u_invl") \
+	E_(afs_edit_dir_update_nodd,		"u_nodd")
 
 #define afs_edit_dir_reasons				  \
 	EM(afs_edit_dir_for_create,		"Create") \
@@ -304,6 +308,7 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_for_rename_0,		"Renam0") \
 	EM(afs_edit_dir_for_rename_1,		"Renam1") \
 	EM(afs_edit_dir_for_rename_2,		"Renam2") \
+	EM(afs_edit_dir_for_rename_sub,		"RnmSub") \
 	EM(afs_edit_dir_for_rmdir,		"RmDir ") \
 	EM(afs_edit_dir_for_silly_0,		"S_Ren0") \
 	EM(afs_edit_dir_for_silly_1,		"S_Ren1") \
-- 
2.43.0




