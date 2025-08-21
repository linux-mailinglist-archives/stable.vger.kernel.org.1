Return-Path: <stable+bounces-172000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E9B2F8D3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C73177296
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E216321F32;
	Thu, 21 Aug 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="km3D9B4v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99C322C80
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780361; cv=none; b=MafjNGohQDZPETkiUgozzE3Da37aPNgSKapKKQIwSn/c/yzNTCLF3T+ZJt2VwgTGSCiT5pOwOgEbk6jrXbT/MT8RC7jpe8JqVif0QwkRRuSLcVAZMRGWli+hcONLdIutyFfgcgPIXJNotHVQ7cMen2GYJotjlCzNwCNxTFhE5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780361; c=relaxed/simple;
	bh=IB2Lp4VVf529VwPWPf+pF1nDzNuS4afg+uR7NKhB+ns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G7K1fWxI4+VSVf0xNTALxOxZ0GVCbcACzr/9LAskaf+t+iClLJ5uXTRbmNsJSb65v+iwJnVAtuc9yYBmy8n/jjjL4WQPVGJxv5XRGLXm23MzGQpmHepJYPgfjxkMnGG80+l/QWCkOCFfW33j0QDv+lMEKePGXv4q/ymb6hcdFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=km3D9B4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A07C4CEEB;
	Thu, 21 Aug 2025 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780360;
	bh=IB2Lp4VVf529VwPWPf+pF1nDzNuS4afg+uR7NKhB+ns=;
	h=Subject:To:Cc:From:Date:From;
	b=km3D9B4vKil+wgrccUWIh/bm5PZkeg9F72vDQvzrJ1CZL0L35HFiKv6feK8ggRqXM
	 bBNtHCMk8s+jC86ModqTGwJDTDol0cgq1oPIYYTZNlr/izqnTEJMpUqK6ywMmHNVWn
	 rN0JfGw/9KXiSdZWhCmUulG1TsDplnFGmj4RTl1o=
Subject: FAILED: patch "[PATCH] netfs: Fix unbuffered write error handling" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,brauner@kernel.org,fengxiaoli0714@gmail.com,pc@manguebit.org,sfrench@samba.org,sprasad@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:45:57 +0200
Message-ID: <2025082157-dedicator-hurled-4d65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a3de58b12ce074ec05b8741fa28d62ccb1070468
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082157-dedicator-hurled-4d65@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3de58b12ce074ec05b8741fa28d62ccb1070468 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Aug 2025 22:45:50 +0100
Subject: [PATCH] netfs: Fix unbuffered write error handling

If all the subrequests in an unbuffered write stream fail, the subrequest
collector doesn't update the stream->transferred value and it retains its
initial LONG_MAX value.  Unfortunately, if all active streams fail, then we
take the smallest value of { LONG_MAX, LONG_MAX, ... } as the value to set
in wreq->transferred - which is then returned from ->write_iter().

LONG_MAX was chosen as the initial value so that all the streams can be
quickly assessed by taking the smallest value of all stream->transferred -
but this only works if we've set any of them.

Fix this by adding a flag to indicate whether the value in
stream->transferred is valid and checking that when we integrate the
values.  stream->transferred can then be initialised to zero.

This was found by running the generic/750 xfstest against cifs with
cache=none.  It splices data to the target file.  Once (if) it has used up
all the available scratch space, the writes start failing with ENOSPC.
This causes ->write_iter() to fail.  However, it was returning
wreq->transferred, i.e. LONG_MAX, rather than an error (because it thought
the amount transferred was non-zero) and iter_file_splice_write() would
then try to clean up that amount of pipe bufferage - leading to an oops
when it overran.  The kernel log showed:

    CIFS: VFS: Send error in write = -28

followed by:

    BUG: kernel NULL pointer dereference, address: 0000000000000008

with:

    RIP: 0010:iter_file_splice_write+0x3a4/0x520
    do_splice+0x197/0x4e0

or:

    RIP: 0010:pipe_buf_release (include/linux/pipe_fs_i.h:282)
    iter_file_splice_write (fs/splice.c:755)

Also put a warning check into splice to announce if ->write_iter() returned
that it had written more than it was asked to.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220445
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/915443.1755207950@warthog.procyon.org.uk
cc: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3e804da1e1eb..a95e7aadafd0 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -281,8 +281,10 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 		} else if (test_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags)) {
 			notes |= MADE_PROGRESS;
 		} else {
-			if (!stream->failed)
+			if (!stream->failed) {
 				stream->transferred += transferred;
+				stream->transferred_valid = true;
+			}
 			if (front->transferred < front->len)
 				set_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags);
 			notes |= MADE_PROGRESS;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 0f3a36852a4d..cbf3d9194c7b 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -254,6 +254,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to = front->start + front->transferred;
 				stream->transferred = stream->collected_to - wreq->start;
+				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -356,6 +357,7 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 {
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid = false;
 	int s;
 
 	_enter("R=%x", wreq->debug_id);
@@ -376,12 +378,16 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 			continue;
 		if (!list_empty(&stream->subrequests))
 			return false;
-		if (stream->transferred < transferred)
+		if (stream->transferred_valid &&
+		    stream->transferred < transferred) {
 			transferred = stream->transferred;
+			transferred_valid = true;
+		}
 	}
 
 	/* Okay, declare that all I/O is complete. */
-	wreq->transferred = transferred;
+	if (transferred_valid)
+		wreq->transferred = transferred;
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 50bee2c4130d..0584cba1a043 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -118,12 +118,12 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	wreq->io_streams[0].prepare_write	= ictx->ops->prepare_write;
 	wreq->io_streams[0].issue_write		= ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	= start;
-	wreq->io_streams[0].transferred		= LONG_MAX;
+	wreq->io_streams[0].transferred		= 0;
 
 	wreq->io_streams[1].stream_nr		= 1;
 	wreq->io_streams[1].source		= NETFS_WRITE_TO_CACHE;
 	wreq->io_streams[1].collected_to	= start;
-	wreq->io_streams[1].transferred		= LONG_MAX;
+	wreq->io_streams[1].transferred		= 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
 		wreq->io_streams[1].active	= true;
diff --git a/fs/splice.c b/fs/splice.c
index 4d6df083e0c0..f5094b6d00a0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -739,6 +739,9 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
+		WARN_ONCE(ret > sd.total_len - left,
+			  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+			  ret, sd.total_len, left);
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 185bd8196503..98c96d649bf9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -150,6 +150,7 @@ struct netfs_io_stream {
 	bool			active;		/* T if stream is active */
 	bool			need_retry;	/* T if this stream needs retrying */
 	bool			failed;		/* T if this stream failed */
+	bool			transferred_valid; /* T is ->transferred is valid */
 };
 
 /*


