Return-Path: <stable+bounces-5339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB580CA46
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC35B20E2C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F53C064;
	Mon, 11 Dec 2023 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0QwzPn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC053BB2B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5045C433C8;
	Mon, 11 Dec 2023 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702299079;
	bh=ShJXSvfCtWzeL0bapRICs4h+dKJA5A55hZVuUlxPYCo=;
	h=Subject:To:Cc:From:Date:From;
	b=v0QwzPn1OTz54DG28T2SIjHg6lNDezws0dgcMr6Tx/k6dCy1zbQn9TzDHNEf0Gzmu
	 THt4fdJpGKWVc9wHW/3d9rZt8WTz14Fi/yt5SrBmZGmslcw2yZJZwFgVYGfKVL6lKo
	 CoU8afv+ufhkhptchLZsE61GAVSveRWtoc3x2sEs=
Subject: FAILED: patch "[PATCH] cifs: Fix flushing, invalidation and file size with FICLONE" failed to apply to 5.10-stable tree
To: dhowells@redhat.com,hch@lst.de,jlayton@kernel.org,nspmangalore@gmail.com,pc@manguebit.com,rohiths.msft@gmail.com,stfrench@microsoft.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:51:14 +0100
Message-ID: <2023121113-waltz-shifter-df2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c54fc3a4f375663f2361a9cbb2955fb4ef912879
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121113-waltz-shifter-df2b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c54fc3a4f375 ("cifs: Fix flushing, invalidation and file size with FICLONE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c54fc3a4f375663f2361a9cbb2955fb4ef912879 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 1 Dec 2023 00:22:01 +0000
Subject: [PATCH] cifs: Fix flushing, invalidation and file size with FICLONE

Fix a number of issues in the cifs filesystem implementation of the FICLONE
ioctl in cifs_remap_file_range().  This is analogous to the previously
fixed bug in cifs_file_copychunk_range() and can share the helper
functions.

Firstly, the invalidation of the destination range is handled incorrectly:
We shouldn't just invalidate the whole file as dirty data in the file may
get lost and we can't just call truncate_inode_pages_range() to invalidate
the destination range as that will erase parts of a partial folio at each
end whilst invalidating and discarding all the folios in the middle.  We
need to force all the folios covering the range to be reloaded, but we
mustn't lose dirty data in them that's not in the destination range.

Further, we shouldn't simply round out the range to PAGE_SIZE at each end
as cifs should move to support multipage folios.

Secondly, there's an issue whereby a write may have extended the file
locally, but not have been written back yet.  This can leaves the local
idea of the EOF at a later point than the server's EOF.  If a clone request
is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
(which gets translated to -EIO locally) if the clone source extends past
the server's EOF.

Fix this by:

 (0) Flush the source region (already done).  The flush does nothing and
     the EOF isn't moved if the source region has no dirty data.

 (1) Move the EOF to the end of the source region if it isn't already at
     least at this point.  If we can't do this, for instance if the server
     doesn't support it, just flush the entire source file.

 (2) Find the folio (if present) at each end of the range, flushing it and
     increasing the region-to-be-invalidated to cover those in their
     entirety.

 (3) Fully discard all the folios covering the range as we want them to be
     reloaded.

 (4) Then perform the extent duplication.

Thirdly, set i_size after doing the duplicate_extents operation as this
value may be used by various things internally.  stat() hides the issue
because setting ->time to 0 causes cifs_getatr() to revalidate the
attributes.

These were causing the cifs/001 xfstest to fail.

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org
cc: Christoph Hellwig <hch@lst.de>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 8097a9b3e98c..c5fc0a35bb19 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1268,9 +1268,12 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
+	struct cifsInodeInfo *src_cifsi = CIFS_I(src_inode);
+	struct cifsInodeInfo *target_cifsi = CIFS_I(target_inode);
 	struct cifsFileInfo *smb_file_src = src_file->private_data;
-	struct cifsFileInfo *smb_file_target;
-	struct cifs_tcon *target_tcon;
+	struct cifsFileInfo *smb_file_target = dst_file->private_data;
+	struct cifs_tcon *target_tcon, *src_tcon;
+	unsigned long long destend, fstart, fend, new_size;
 	unsigned int xid;
 	int rc;
 
@@ -1281,13 +1284,13 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 
 	xid = get_xid();
 
-	if (!src_file->private_data || !dst_file->private_data) {
+	if (!smb_file_src || !smb_file_target) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
 		goto out;
 	}
 
-	smb_file_target = dst_file->private_data;
+	src_tcon = tlink_tcon(smb_file_src->tlink);
 	target_tcon = tlink_tcon(smb_file_target->tlink);
 
 	/*
@@ -1300,20 +1303,63 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	if (len == 0)
 		len = src_inode->i_size - off;
 
-	cifs_dbg(FYI, "about to flush pages\n");
-	/* should we flush first and last page first */
-	truncate_inode_pages_range(&target_inode->i_data, destoff,
-				   PAGE_ALIGN(destoff + len)-1);
+	cifs_dbg(FYI, "clone range\n");
 
-	if (target_tcon->ses->server->ops->duplicate_extents)
+	/* Flush the source buffer */
+	rc = filemap_write_and_wait_range(src_inode->i_mapping, off,
+					  off + len - 1);
+	if (rc)
+		goto unlock;
+
+	/* The server-side copy will fail if the source crosses the EOF marker.
+	 * Advance the EOF marker after the flush above to the end of the range
+	 * if it's short of that.
+	 */
+	if (src_cifsi->netfs.remote_i_size < off + len) {
+		rc = cifs_precopy_set_eof(src_inode, src_cifsi, src_tcon, xid, off + len);
+		if (rc < 0)
+			goto unlock;
+	}
+
+	new_size = destoff + len;
+	destend = destoff + len - 1;
+
+	/* Flush the folios at either end of the destination range to prevent
+	 * accidental loss of dirty data outside of the range.
+	 */
+	fstart = destoff;
+	fend = destend;
+
+	rc = cifs_flush_folio(target_inode, destoff, &fstart, &fend, true);
+	if (rc)
+		goto unlock;
+	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
+	if (rc)
+		goto unlock;
+
+	/* Discard all the folios that overlap the destination region. */
+	cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend);
+	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
+
+	fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
+			   i_size_read(target_inode), 0);
+
+	rc = -EOPNOTSUPP;
+	if (target_tcon->ses->server->ops->duplicate_extents) {
 		rc = target_tcon->ses->server->ops->duplicate_extents(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
-	else
-		rc = -EOPNOTSUPP;
+		if (rc == 0 && new_size > i_size_read(target_inode)) {
+			truncate_setsize(target_inode, new_size);
+			netfs_resize_file(&target_cifsi->netfs, new_size);
+			fscache_resize_cookie(cifs_inode_cookie(target_inode),
+					      new_size);
+		}
+	}
 
 	/* force revalidate of size and timestamps of target file now
 	   that target is updated on the server */
 	CIFS_I(target_inode)->time = 0;
+unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
 	unlock_two_nondirectories(src_inode, target_inode);


