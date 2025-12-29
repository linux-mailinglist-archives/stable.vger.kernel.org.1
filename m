Return-Path: <stable+bounces-203674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421DCE74B7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3E13027D9F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1D32ED56;
	Mon, 29 Dec 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NgtpE+2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74B32ED40
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024313; cv=none; b=b2kBO+XewaGLtzYwId5s6Vl6H17Au6Wc63AanJIAVR9YuFmOV9c4lW9e6OrFki7yoY7eGZBs8DU9c2TuoZ0SY0/y7CYCex100+AGWCHpVsyhKD65w/KUwRe4pnHTBfX10o4xTl/E1IuECAcH6vXzuEPtzAZZ9ZQ9dxxD3hNLqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024313; c=relaxed/simple;
	bh=LSlEFOFkcZweEgPO1i25nT0sqp4WYuyNXTNivgvVqUE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DM3Kllju/SaXyaMIgrUntCPnIYS36UzP9BHPuJsBagbkXek1PJ6BNN2oWK9dcPQH6/zVJ0Srmd6BxYpTAAeM/GQVB2c2iBzM+emCwkPWDNFRJwppX81chzHjGi3yoTnhlmtmAXDAwgSAtheeSKS+nOJBFek/Y5Pfinbuh78JY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NgtpE+2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9619EC116C6;
	Mon, 29 Dec 2025 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767024313;
	bh=LSlEFOFkcZweEgPO1i25nT0sqp4WYuyNXTNivgvVqUE=;
	h=Subject:To:Cc:From:Date:From;
	b=NgtpE+2kmdyUQVYFDYQ8gbn2+rWUXYDdUwKZYfLszFzKA8RYHuS/b2VEeV0u+Nc6n
	 uvdHleFcmtu7wHo+wd3cX2pjIDYUPuQD4g+ODOW4QUcnvjmN5KuBdNhQCL8d5PVz8U
	 B0mDKVnRHIIGDqn2amHd+ShcaI3zpum7YTWBOjPk=
Subject: FAILED: patch "[PATCH] fuse: fix readahead reclaim deadlock" failed to apply to 6.6-stable tree
To: joannelkoong@gmail.com,mszeredi@redhat.com,osandov@fb.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 17:02:13 +0100
Message-ID: <2025122913-nucleus-deny-f4d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bd5603eaae0aabf527bfb3ce1bb07e979ce5bd50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122913-nucleus-deny-f4d4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd5603eaae0aabf527bfb3ce1bb07e979ce5bd50 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Oct 2025 15:07:38 -0700
Subject: [PATCH] fuse: fix readahead reclaim deadlock

Commit e26ee4efbc79 ("fuse: allocate ff->release_args only if release is
needed") skips allocating ff->release_args if the server does not
implement open. However in doing so, fuse_prepare_release() now skips
grabbing the reference on the inode, which makes it possible for an
inode to be evicted from the dcache while there are inflight readahead
requests. This causes a deadlock if the server triggers reclaim while
servicing the readahead request and reclaim attempts to evict the inode
of the file being read ahead. Since the folio is locked during
readahead, when reclaim evicts the fuse inode and fuse_evict_inode()
attempts to remove all folios associated with the inode from the page
cache (truncate_inode_pages_range()), reclaim will block forever waiting
for the lock since readahead cannot relinquish the lock because it is
itself blocked in reclaim:

>>> stack_trace(1504735)
 folio_wait_bit_common (mm/filemap.c:1308:4)
 folio_lock (./include/linux/pagemap.h:1052:3)
 truncate_inode_pages_range (mm/truncate.c:336:10)
 fuse_evict_inode (fs/fuse/inode.c:161:2)
 evict (fs/inode.c:704:3)
 dentry_unlink_inode (fs/dcache.c:412:3)
 __dentry_kill (fs/dcache.c:615:3)
 shrink_kill (fs/dcache.c:1060:12)
 shrink_dentry_list (fs/dcache.c:1087:3)
 prune_dcache_sb (fs/dcache.c:1168:2)
 super_cache_scan (fs/super.c:221:10)
 do_shrink_slab (mm/shrinker.c:435:9)
 shrink_slab (mm/shrinker.c:626:10)
 shrink_node (mm/vmscan.c:5951:2)
 shrink_zones (mm/vmscan.c:6195:3)
 do_try_to_free_pages (mm/vmscan.c:6257:3)
 do_swap_page (mm/memory.c:4136:11)
 handle_pte_fault (mm/memory.c:5562:10)
 handle_mm_fault (mm/memory.c:5870:9)
 do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
 handle_page_fault (arch/x86/mm/fault.c:1481:3)
 exc_page_fault (arch/x86/mm/fault.c:1539:2)
 asm_exc_page_fault+0x22/0x27

Fix this deadlock by allocating ff->release_args and grabbing the
reference on the inode when preparing the file for release even if the
server does not implement open. The inode reference will be dropped when
the last reference on the fuse file is dropped (see fuse_file_put() ->
fuse_release_end()).

Fixes: e26ee4efbc79 ("fuse: allocate ff->release_args only if release is needed")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reported-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05..4d96e684d736 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -110,7 +110,9 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 			fuse_file_io_release(ff, ra->inode);
 
 		if (!args) {
-			/* Do nothing when server does not implement 'open' */
+			/* Do nothing when server does not implement 'opendir' */
+		} else if (args->opcode == FUSE_RELEASE && ff->fm->fc->no_open) {
+			fuse_release_end(ff->fm, args, 0);
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
@@ -131,8 +133,17 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
 	bool open = isdir ? !fc->no_opendir : !fc->no_open;
+	bool release = !isdir || open;
 
-	ff = fuse_file_alloc(fm, open);
+	/*
+	 * ff->args->release_args still needs to be allocated (so we can hold an
+	 * inode reference while there are pending inflight file operations when
+	 * ->release() is called, see fuse_prepare_release()) even if
+	 * fc->no_open is set else it becomes possible for reclaim to deadlock
+	 * if while servicing the readahead request the server triggers reclaim
+	 * and reclaim evicts the inode of the file being read ahead.
+	 */
+	ff = fuse_file_alloc(fm, release);
 	if (!ff)
 		return ERR_PTR(-ENOMEM);
 
@@ -152,13 +163,14 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
-			/* No release needed */
-			kfree(ff->args);
-			ff->args = NULL;
-			if (isdir)
+			if (isdir) {
+				/* No release needed */
+				kfree(ff->args);
+				ff->args = NULL;
 				fc->no_opendir = 1;
-			else
+			} else {
 				fc->no_open = 1;
+			}
 		}
 	}
 


