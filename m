Return-Path: <stable+bounces-5335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885880CA40
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BC71C20E92
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EAB3C066;
	Mon, 11 Dec 2023 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vOlLFD7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7BD3C064
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE5EC433C7;
	Mon, 11 Dec 2023 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702299064;
	bh=ykZFcQ0Wmx2fivrLCwuqzwpZvVv4f4TWTyea/RlmCxk=;
	h=Subject:To:Cc:From:Date:From;
	b=vOlLFD7tP5zmAQ1j1UQrY1JxppCqEF85O818FeJvR42mYxJEKdgv8ceJUf/rUsR3V
	 dgHscsSosXgRTfV3xGlKzyLzUZXU6fk2Woa19qaFwpshg3Ti8qt5VjCRfwN9Jgo3Rb
	 1oJVh5A3GO9A0OnnHaseA8Jocbx9xuH4U5EGvB8Q=
Subject: FAILED: patch "[PATCH] cifs: Fix flushing, invalidation and file size with" failed to apply to 5.4-stable tree
To: dhowells@redhat.com,jlayton@kernel.org,nspmangalore@gmail.com,pc@manguebit.com,rohiths.msft@gmail.com,stfrench@microsoft.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:50:59 +0100
Message-ID: <2023121159-dispatch-junkie-39d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7b2404a886f8b91250c31855d287e632123e1746
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121159-dispatch-junkie-39d8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

7b2404a886f8 ("cifs: Fix flushing, invalidation and file size with copy_file_range()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
3e3761f1ec7d ("smb3: use filemap_write_and_wait_range instead of filemap_write_and_wait")
9c8b7a293f50 ("smb3: fix temporary data corruption in insert range")
fa30a81f255a ("smb3: fix temporary data corruption in collapse range")
c3a72bb21320 ("smb3: Move the flush out of smb2_copychunk_range() into its callers")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b2404a886f8b91250c31855d287e632123e1746 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Fri, 1 Dec 2023 00:22:00 +0000
Subject: [PATCH] cifs: Fix flushing, invalidation and file size with
 copy_file_range()

Fix a number of issues in the cifs filesystem implementation of the
copy_file_range() syscall in cifs_file_copychunk_range().

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
idea of the EOF at a later point than the server's EOF.  If a copy request
is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
(which gets translated to -EIO locally) if the copy source extends past the
server's EOF.

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

 (4) Then perform the copy.

Thirdly, set i_size after doing the copychunk_range operation as this value
may be used by various things internally.  stat() hides the issue because
setting ->time to 0 causes cifs_getatr() to revalidate the attributes.

These were causing the generic/075 xfstest to fail.

Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
Cc: stable@vger.kernel.org
Signed-off-by: David Howells <dhowells@redhat.com>
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
index ea3a7a668b45..8097a9b3e98c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1196,6 +1196,72 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.listxattr = cifs_listxattr,
 };
 
+/*
+ * Advance the EOF marker to after the source range.
+ */
+static int cifs_precopy_set_eof(struct inode *src_inode, struct cifsInodeInfo *src_cifsi,
+				struct cifs_tcon *src_tcon,
+				unsigned int xid, loff_t src_end)
+{
+	struct cifsFileInfo *writeable_srcfile;
+	int rc = -EINVAL;
+
+	writeable_srcfile = find_writable_file(src_cifsi, FIND_WR_FSUID_ONLY);
+	if (writeable_srcfile) {
+		if (src_tcon->ses->server->ops->set_file_size)
+			rc = src_tcon->ses->server->ops->set_file_size(
+				xid, src_tcon, writeable_srcfile,
+				src_inode->i_size, true /* no need to set sparse */);
+		else
+			rc = -ENOSYS;
+		cifsFileInfo_put(writeable_srcfile);
+		cifs_dbg(FYI, "SetFSize for copychunk rc = %d\n", rc);
+	}
+
+	if (rc < 0)
+		goto set_failed;
+
+	netfs_resize_file(&src_cifsi->netfs, src_end);
+	fscache_resize_cookie(cifs_inode_cookie(src_inode), src_end);
+	return 0;
+
+set_failed:
+	return filemap_write_and_wait(src_inode->i_mapping);
+}
+
+/*
+ * Flush out either the folio that overlaps the beginning of a range in which
+ * pos resides or the folio that overlaps the end of a range unless that folio
+ * is entirely within the range we're going to invalidate.  We extend the flush
+ * bounds to encompass the folio.
+ */
+static int cifs_flush_folio(struct inode *inode, loff_t pos, loff_t *_fstart, loff_t *_fend,
+			    bool first)
+{
+	struct folio *folio;
+	unsigned long long fpos, fend;
+	pgoff_t index = pos / PAGE_SIZE;
+	size_t size;
+	int rc = 0;
+
+	folio = filemap_get_folio(inode->i_mapping, index);
+	if (IS_ERR(folio))
+		return 0;
+
+	size = folio_size(folio);
+	fpos = folio_pos(folio);
+	fend = fpos + size - 1;
+	*_fstart = min_t(unsigned long long, *_fstart, fpos);
+	*_fend   = max_t(unsigned long long, *_fend, fend);
+	if ((first && pos == fpos) || (!first && pos == fend))
+		goto out;
+
+	rc = filemap_write_and_wait_range(inode->i_mapping, fpos, fend);
+out:
+	folio_put(folio);
+	return rc;
+}
+
 static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 		struct file *dst_file, loff_t destoff, loff_t len,
 		unsigned int remap_flags)
@@ -1263,10 +1329,12 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
+	struct cifsInodeInfo *src_cifsi = CIFS_I(src_inode);
 	struct cifsFileInfo *smb_file_src;
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
 	struct cifs_tcon *target_tcon;
+	unsigned long long destend, fstart, fend;
 	ssize_t rc;
 
 	cifs_dbg(FYI, "copychunk range\n");
@@ -1306,13 +1374,41 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	if (rc)
 		goto unlock;
 
-	/* should we flush first and last page first */
-	truncate_inode_pages(&target_inode->i_data, 0);
+	/* The server-side copy will fail if the source crosses the EOF marker.
+	 * Advance the EOF marker after the flush above to the end of the range
+	 * if it's short of that.
+	 */
+	if (src_cifsi->server_eof < off + len) {
+		rc = cifs_precopy_set_eof(src_inode, src_cifsi, src_tcon, xid, off + len);
+		if (rc < 0)
+			goto unlock;
+	}
+
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
+	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
 
 	rc = file_modified(dst_file);
-	if (!rc)
+	if (!rc) {
 		rc = target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
+		if (rc > 0 && destoff + rc > i_size_read(target_inode))
+			truncate_setsize(target_inode, destoff + rc);
+	}
 
 	file_accessed(src_file);
 


