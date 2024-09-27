Return-Path: <stable+bounces-78074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5E9884F7
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566761F23407
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE618C901;
	Fri, 27 Sep 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JabJs6sL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8218C358;
	Fri, 27 Sep 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440350; cv=none; b=pXmau9lByCxFmFdoONDvpGsCxG3GchpkdjsfwSw9R3k+ijYW65wguE7VLiPLGpgAxHcKkOfsIv+yGNRSgB+U9HB/iizQJQ/eda4cuy9yBMozHq0UoqKAw6sAJvNDk6f530dzRUxHSAECl33o8L7Ver/eZW5Pj9ToHJpW3NM5Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440350; c=relaxed/simple;
	bh=+SiVWrNa5OpGieO1KFuJ83gibPidVr9Iz8mAYHQkvMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlKhqwDPRpxqsnqDBs2o1KCRM0hNrRQyH1l6ZNul1azMR0j69YFocI5PIICNmO/c+f9WrTK+agK2xcSGpoL/LjhSZu5GfGhrhJKOd9V/6Nx57U10JBMFuXBh46GqMEacwt4fOWQN72yzNh2ZQK0aD57/Zv8DxBje3qm4QkHxwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JabJs6sL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288A5C4CEC4;
	Fri, 27 Sep 2024 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440350;
	bh=+SiVWrNa5OpGieO1KFuJ83gibPidVr9Iz8mAYHQkvMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JabJs6sLTVAolUkisn1zZW2vmvhxyP7Vmj2MwtKQGDd5+mTVdS0CW2WBoqDlhF2CV
	 Xdn5SB8COgWBKNZSYTp8zPI7T2i2V7kzX5b3TrU2xuMnoRuxY+oERhQDT3V+1HEvqn
	 3M/sOpIZq6UvNcHK0QxcrJOg382wFN/f6DUQNG4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 51/73] xfs: fix unlink vs cluster buffer instantiation race
Date: Fri, 27 Sep 2024 14:24:02 +0200
Message-ID: <20240927121721.977658809@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
References: <20240927121719.897851549@linuxfoundation.org>
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

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 348a1983cf4cf5099fc398438a968443af4c9f65 ]

Luis has been reporting an assert failure when freeing an inode
cluster during inode inactivation for a while. The assert looks
like:

 XFS: Assertion failed: bp->b_flags & XBF_DONE, file: fs/xfs/xfs_trans_buf.c, line: 241
 ------------[ cut here ]------------
 kernel BUG at fs/xfs/xfs_message.c:102!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
 CPU: 4 PID: 73 Comm: kworker/4:1 Not tainted 6.10.0-rc1 #4
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Workqueue: xfs-inodegc/loop5 xfs_inodegc_worker [xfs]
 RIP: 0010:assfail (fs/xfs/xfs_message.c:102) xfs
 RSP: 0018:ffff88810188f7f0 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff88816e748250 RCX: 1ffffffff844b0e7
 RDX: 0000000000000004 RSI: ffff88810188f558 RDI: ffffffffc2431fa0
 RBP: 1ffff11020311f01 R08: 0000000042431f9f R09: ffffed1020311e9b
 R10: ffff88810188f4df R11: ffffffffac725d70 R12: ffff88817a3f4000
 R13: ffff88812182f000 R14: ffff88810188f998 R15: ffffffffc2423f80
 FS:  0000000000000000(0000) GS:ffff8881c8400000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055fe9d0f109c CR3: 000000014426c002 CR4: 0000000000770ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
 xfs_trans_read_buf_map (fs/xfs/xfs_trans_buf.c:241 (discriminator 1)) xfs
 xfs_imap_to_bp (fs/xfs/xfs_trans.h:210 fs/xfs/libxfs/xfs_inode_buf.c:138) xfs
 xfs_inode_item_precommit (fs/xfs/xfs_inode_item.c:145) xfs
 xfs_trans_run_precommits (fs/xfs/xfs_trans.c:931) xfs
 __xfs_trans_commit (fs/xfs/xfs_trans.c:966) xfs
 xfs_inactive_ifree (fs/xfs/xfs_inode.c:1811) xfs
 xfs_inactive (fs/xfs/xfs_inode.c:2013) xfs
 xfs_inodegc_worker (fs/xfs/xfs_icache.c:1841 fs/xfs/xfs_icache.c:1886) xfs
 process_one_work (kernel/workqueue.c:3231)
 worker_thread (kernel/workqueue.c:3306 (discriminator 2) kernel/workqueue.c:3393 (discriminator 2))
 kthread (kernel/kthread.c:389)
 ret_from_fork (arch/x86/kernel/process.c:147)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
  </TASK>

And occurs when the the inode precommit handlers is attempt to look
up the inode cluster buffer to attach the inode for writeback.

The trail of logic that I can reconstruct is as follows.

	1. the inode is clean when inodegc runs, so it is not
	   attached to a cluster buffer when precommit runs.

	2. #1 implies the inode cluster buffer may be clean and not
	   pinned by dirty inodes when inodegc runs.

	3. #2 implies that the inode cluster buffer can be reclaimed
	   by memory pressure at any time.

	4. The assert failure implies that the cluster buffer was
	   attached to the transaction, but not marked done. It had
	   been accessed earlier in the transaction, but not marked
	   done.

	5. #4 implies the cluster buffer has been invalidated (i.e.
	   marked stale).

	6. #5 implies that the inode cluster buffer was instantiated
	   uninitialised in the transaction in xfs_ifree_cluster(),
	   which only instantiates the buffers to invalidate them
	   and never marks them as done.

Given factors 1-3, this issue is highly dependent on timing and
environmental factors. Hence the issue can be very difficult to
reproduce in some situations, but highly reliable in others. Luis
has an environment where it can be reproduced easily by g/531 but,
OTOH, I've reproduced it only once in ~2000 cycles of g/531.

I think the fix is to have xfs_ifree_cluster() set the XBF_DONE flag
on the cluster buffers, even though they may not be initialised. The
reasons why I think this is safe are:

	1. A buffer cache lookup hit on a XBF_STALE buffer will
	   clear the XBF_DONE flag. Hence all future users of the
	   buffer know they have to re-initialise the contents
	   before use and mark it done themselves.

	2. xfs_trans_binval() sets the XFS_BLI_STALE flag, which
	   means the buffer remains locked until the journal commit
	   completes and the buffer is unpinned. Hence once marked
	   XBF_STALE/XFS_BLI_STALE by xfs_ifree_cluster(), the only
	   context that can access the freed buffer is the currently
	   running transaction.

	3. #2 implies that future buffer lookups in the currently
	   running transaction will hit the transaction match code
	   and not the buffer cache. Hence XBF_STALE and
	   XFS_BLI_STALE will not be cleared unless the transaction
	   initialises and logs the buffer with valid contents
	   again. At which point, the buffer will be marked marked
	   XBF_DONE again, so having XBF_DONE already set on the
	   stale buffer is a moot point.

	4. #2 also implies that any concurrent access to that
	   cluster buffer will block waiting on the buffer lock
	   until the inode cluster has been fully freed and is no
	   longer an active inode cluster buffer.

	5. #4 + #1 means that any future user of the disk range of
	   that buffer will always see the range of disk blocks
	   covered by the cluster buffer as not done, and hence must
	   initialise the contents themselves.

	6. Setting XBF_DONE in xfs_ifree_cluster() then means the
	   unlinked inode precommit code will see a XBF_DONE buffer
	   from the transaction match as it expects. It can then
	   attach the stale but newly dirtied inode to the stale
	   but newly dirtied cluster buffer without unexpected
	   failures. The stale buffer will then sail through the
	   journal and do the right thing with the attached stale
	   inode during unpin.

Hence the fix is just one line of extra code. The explanation of
why we have to set XBF_DONE in xfs_ifree_cluster, OTOH, is long and
complex....

Fixes: 82842fee6e59 ("xfs: fix AGF vs inode cluster buffer deadlock")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_inode.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2297,11 +2297,26 @@ xfs_ifree_cluster(
 		 * This buffer may not have been correctly initialised as we
 		 * didn't read it from disk. That's not important because we are
 		 * only using to mark the buffer as stale in the log, and to
-		 * attach stale cached inodes on it. That means it will never be
-		 * dispatched for IO. If it is, we want to know about it, and we
-		 * want it to fail. We can acheive this by adding a write
-		 * verifier to the buffer.
+		 * attach stale cached inodes on it.
+		 *
+		 * For the inode that triggered the cluster freeing, this
+		 * attachment may occur in xfs_inode_item_precommit() after we
+		 * have marked this buffer stale.  If this buffer was not in
+		 * memory before xfs_ifree_cluster() started, it will not be
+		 * marked XBF_DONE and this will cause problems later in
+		 * xfs_inode_item_precommit() when we trip over a (stale, !done)
+		 * buffer to attached to the transaction.
+		 *
+		 * Hence we have to mark the buffer as XFS_DONE here. This is
+		 * safe because we are also marking the buffer as XBF_STALE and
+		 * XFS_BLI_STALE. That means it will never be dispatched for
+		 * IO and it won't be unlocked until the cluster freeing has
+		 * been committed to the journal and the buffer unpinned. If it
+		 * is written, we want to know about it, and we want it to
+		 * fail. We can acheive this by adding a write verifier to the
+		 * buffer.
 		 */
+		bp->b_flags |= XBF_DONE;
 		bp->b_ops = &xfs_inode_buf_ops;
 
 		/*



