Return-Path: <stable+bounces-204415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94527CED104
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 15:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A153006F43
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB820C463;
	Thu,  1 Jan 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaugLIqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942042AA9
	for <stable@vger.kernel.org>; Thu,  1 Jan 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767276824; cv=none; b=G2lTB/FweNEK6JItC20GZYFnqBFoOJK34acID2pLvYvLPKjf6ppJ1Jh+s+ES5MvXmj2sAu5Rauj6MXKRJHeYYK5TU1CI2H45dijD8vetE8/6yMaZhtt1MxYKGb9uqiPb/RJvdwnhBGF/YgU5lEu9tfmOzkpQNnKpIqlKR87zSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767276824; c=relaxed/simple;
	bh=91qTqrr/r1se45MzTb1EWbg/sH83XxU52s1nfxN/vLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arB4qcozUnkUqxg0hwKdM2vYemOJqpHh1BEwlztzRNAjpaZuzUiDPq5eImCJ6wpYXRVEonHBIMz3O5c2glzMz2uGX3+Leceb8/EKUmaU00XcWk4WDZoYDBDSPCUNG7/mDDTt0jGU9Ftpx7Q7wQABL35RY8FWThdhETKYrAunF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaugLIqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2A8C4CEF7;
	Thu,  1 Jan 2026 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767276824;
	bh=91qTqrr/r1se45MzTb1EWbg/sH83XxU52s1nfxN/vLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaugLIqRqOt7JJOTCySziGVgH0xYbbRHtaf2Z2GBbZX6PwILdimiIOYg4Ks/kR2FK
	 D7h6KqZABmv/QDgU83JSQMj9q+uykYYqsTs/DSvw705KgBYKYWimOeMWUqUT4Umk9e
	 CJZa/Fp6/XKqutf8h2l+KIFXDWD6CsWE+tXyQS5mq6keHZVrzuL/rfqulAEIXubf50
	 sKLUZoCT8MRA69LJmyAEmLZVTStCsNclBFBKlMiDUtK8sWGd0W3prfV6IhDXgscYm9
	 vsyffxefYO1hQOZKj2C3BEvdJDs9tnW8AbdOkMpa0nWIyNqgFkUfNvNyVpAheh+wqR
	 UELdR1gIIAJ2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Omar Sandoval <osandov@fb.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fuse: fix readahead reclaim deadlock
Date: Thu,  1 Jan 2026 09:13:41 -0500
Message-ID: <20260101141342.4003826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122913-nucleus-deny-f4d4@gregkh>
References: <2025122913-nucleus-deny-f4d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit bd5603eaae0aabf527bfb3ce1bb07e979ce5bd50 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2055af1ffaf3..2b7adc83b64e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -113,7 +113,9 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		struct fuse_args *args = (ra ? &ra->args : NULL);
 
 		if (!args) {
-			/* Do nothing when server does not implement 'open' */
+			/* Do nothing when server does not implement 'opendir' */
+		} else if (args->opcode == FUSE_RELEASE && ff->fm->fc->no_open) {
+			fuse_release_end(ff->fm, args, 0);
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
@@ -134,8 +136,17 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
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
 
@@ -154,13 +165,14 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
-			/* No release needed */
-			kfree(ff->release_args);
-			ff->release_args = NULL;
-			if (isdir)
+			if (isdir) {
+				/* No release needed */
+				kfree(ff->release_args);
+				ff->release_args = NULL;
 				fc->no_opendir = 1;
-			else
+			} else {
 				fc->no_open = 1;
+			}
 		}
 	}
 
-- 
2.51.0


