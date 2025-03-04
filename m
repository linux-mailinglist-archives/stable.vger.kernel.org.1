Return-Path: <stable+bounces-120321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B317A4E79B
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D333D7A6907
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6766327C86C;
	Tue,  4 Mar 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LOSOpkkY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5025FA0A
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106526; cv=none; b=Py71ozncyXFR1Lf9K2HvZ0K0bjdX9T0FTP/4jVEcUsIAHhQiZbvRnm8Ne/4yPOtRTVaNdpl+gXyahv5W6Hywz1/XFZpC/2ldZH6p5Y1wreLD2DxIR5+FkC2bJ98oCFELMCdNH/Bsvh5BlWCjtE0DWWuhP/VToBxFOtp4nzZc8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106526; c=relaxed/simple;
	bh=/kQ+uALqT2MC1VjyS4augkeTqfMjM+PiWF4HmTtFPmc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nyD3ZPVQlez4wudgjR8MCkcu8/a8Y7NxXGqW0MyCmJMzSFyqD6wV3PZ5/T4JGijZojSSguI1OVLOkMMpRUgpoPbm0rcGqzb6h5h19VLf4ThdPFJIN4eeEQiDjINRSnbmHQVXY3rhsuu9wvZwnreYI/gGL8Pr7H1vKf+E63lr0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LOSOpkkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45387C4CEE5;
	Tue,  4 Mar 2025 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106525;
	bh=/kQ+uALqT2MC1VjyS4augkeTqfMjM+PiWF4HmTtFPmc=;
	h=Subject:To:Cc:From:Date:From;
	b=LOSOpkkY24aLegYoNQOV48qkUW+aWXU0wqTPP/an2hqX4qjC37qRDlTofdDyni1SD
	 2GE08DsUenV5H/kuj08cSXx/Yr8dLZcNzQ+X8rb+8XuSp2QcQNtNAmb2YFQwo1thy8
	 QnfKWsKR5SQ12ZqESrGj9hX0FbzVWlCvX2Wh/9O8=
Subject: FAILED: patch "[PATCH] NFS: O_DIRECT writes must check and adjust the file length" failed to apply to 6.13-stable tree
To: trond.myklebust@hammerspace.com,anna.schumaker@oracle.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:42:03 +0100
Message-ID: <2025030402-discard-florist-4943@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x fcf857ee1958e9247298251f7615d0c76f1e9b38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030402-discard-florist-4943@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcf857ee1958e9247298251f7615d0c76f1e9b38 Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sat, 1 Feb 2025 14:59:02 -0500
Subject: [PATCH] NFS: O_DIRECT writes must check and adjust the file length

While it is uncommon for delegations to be held while O_DIRECT writes
are in progress, it is possible. The xfstests generic/647 and
generic/729 both end up triggering that state, and end up failing due to
the fact that the file size is not adjusted.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219738
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index f45beea92d03..40e13c9a2873 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -130,6 +130,20 @@ static void nfs_direct_truncate_request(struct nfs_direct_req *dreq,
 		dreq->count = req_start;
 }
 
+static void nfs_direct_file_adjust_size_locked(struct inode *inode,
+					       loff_t offset, size_t count)
+{
+	loff_t newsize = offset + (loff_t)count;
+	loff_t oldsize = i_size_read(inode);
+
+	if (newsize > oldsize) {
+		i_size_write(inode, newsize);
+		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
+		trace_nfs_size_grow(inode, newsize);
+		nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
+	}
+}
+
 /**
  * nfs_swap_rw - NFS address space operation for swap I/O
  * @iocb: target I/O control block
@@ -741,6 +755,7 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	struct nfs_direct_req *dreq = hdr->dreq;
 	struct nfs_commit_info cinfo;
 	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
+	struct inode *inode = dreq->inode;
 	int flags = NFS_ODIRECT_DONE;
 
 	trace_nfs_direct_write_completion(dreq);
@@ -762,6 +777,10 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	}
 	spin_unlock(&dreq->lock);
 
+	spin_lock(&inode->i_lock);
+	nfs_direct_file_adjust_size_locked(inode, dreq->io_start, dreq->count);
+	spin_unlock(&inode->i_lock);
+
 	while (!list_empty(&hdr->pages)) {
 
 		req = nfs_list_entry(hdr->pages.next);


