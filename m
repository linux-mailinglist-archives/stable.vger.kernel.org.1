Return-Path: <stable+bounces-112158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73E8A2740B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE81885DA1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ED9215165;
	Tue,  4 Feb 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hB5GmTu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE870839
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677670; cv=none; b=F/wOI5InAfx0spBgO00j9dV6YDjkYXoZzHidTAxv8/UE0D/7oxbKru2DfiKekF4RW6HhNUARRXfdPWDCv8AMFhpi0aTeNOav8xkdS+S6DlAesn8ElFZSdeDmttHuKWZFlFvPcnXVOZv0qNSj4BggiQMpaKlLUzv4VXaJjmYQz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677670; c=relaxed/simple;
	bh=oy7GKJ2dTrGuns0vOShT4V8FszD9ud2+ZleCJyJWk0w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JqynPTTJrTD2iG5a0yHr3nvUjzeufve5MoRdqMVmJ7X0gKt13YuqS+9NLyKe2MxMoQD7hTnuKREgqJgFBTNH+UbQrYNP0EfhoB92vUgQNcBU7DYVtGd1Yy3XuwYjxnRDSxnHYs0JpxEHtSjCEwRRMjH/KtebBy/3TOLfXqjIE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hB5GmTu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EC5C4CEDF;
	Tue,  4 Feb 2025 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677669;
	bh=oy7GKJ2dTrGuns0vOShT4V8FszD9ud2+ZleCJyJWk0w=;
	h=Subject:To:Cc:From:Date:From;
	b=hB5GmTu8YvyKWbPQGsnq/nCpUSwxwufBai41l+9FqOZGeliWA1lGB+9xd3LcHerSs
	 yE3fZ3ytaZkZGzX/RvpFg8CMJfhspivXGW1LWs7u+8glY5rHQqkFu269es+VHipBvd
	 Vx1hetHkOeqyVucprn36rRrFqbPhbnN8sSOEiJbs=
Subject: FAILED: patch "[PATCH] xfs: fix mount hang during primary superblock recovery" failed to apply to 6.12-stable tree
To: leo.lilong@huawei.com,cem@kernel.org,djwong@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:00:58 +0100
Message-ID: <2025020458-showoff-enclosure-b449@gregkh>
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
git cherry-pick -x efebe42d95fbba91dca6e3e32cb9e0612eb56de5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020458-showoff-enclosure-b449@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efebe42d95fbba91dca6e3e32cb9e0612eb56de5 Mon Sep 17 00:00:00 2001
From: Long Li <leo.lilong@huawei.com>
Date: Sat, 11 Jan 2025 15:05:44 +0800
Subject: [PATCH] xfs: fix mount hang during primary superblock recovery
 failure

When mounting an image containing a log with sb modifications that require
log replay, the mount process hang all the time and stack as follows:

  [root@localhost ~]# cat /proc/557/stack
  [<0>] xfs_buftarg_wait+0x31/0x70
  [<0>] xfs_buftarg_drain+0x54/0x350
  [<0>] xfs_mountfs+0x66e/0xe80
  [<0>] xfs_fs_fill_super+0x7f1/0xec0
  [<0>] get_tree_bdev_flags+0x186/0x280
  [<0>] get_tree_bdev+0x18/0x30
  [<0>] xfs_fs_get_tree+0x1d/0x30
  [<0>] vfs_get_tree+0x2d/0x110
  [<0>] path_mount+0xb59/0xfc0
  [<0>] do_mount+0x92/0xc0
  [<0>] __x64_sys_mount+0xc2/0x160
  [<0>] x64_sys_call+0x2de4/0x45c0
  [<0>] do_syscall_64+0xa7/0x240
  [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

During log recovery, while updating the in-memory superblock from the
primary SB buffer, if an error is encountered, such as superblock
corruption occurs or some other reasons, we will proceed to out_release
and release the xfs_buf. However, this is insufficient because the
xfs_buf's log item has already been initialized and the xfs_buf is held
by the buffer log item as follows, the xfs_buf will not be released,
causing the mount thread to hang.

  xlog_recover_do_primary_sb_buffer
    xlog_recover_do_reg_buffer
      xlog_recover_validate_buf_type
        xfs_buf_item_init(bp, mp)

The solution is straightforward, we simply need to allow it to be
handled by the normal buffer write process. The filesystem will be
shutdown before the submission of buffer_list in xlog_do_recovery_pass(),
ensuring the correct release of the xfs_buf as follows:

  xlog_do_recovery_pass
    error = xlog_recover_process
      xlog_recover_process_data
        xlog_recover_process_ophdr
          xlog_recovery_process_trans
            ...
              xlog_recover_buf_commit_pass2
                error = xlog_recover_do_primary_sb_buffer
                  //Encounter error and return
                if (error)
                  goto out_writebuf
                ...
              out_writebuf:
                xfs_buf_delwri_queue(bp, buffer_list) //add bp to list
                return  error
            ...
    if (!list_empty(&buffer_list))
      if (error)
        xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR); //shutdown first
      xfs_buf_delwri_submit(&buffer_list); //submit buffers in list
        __xfs_buf_submit
          if (bp->b_mount->m_log && xlog_is_shutdown(bp->b_mount->m_log))
            xfs_buf_ioend_fail(bp)  //release bp correctly

Fixes: 6a18765b54e2 ("xfs: update the file system geometry after recoverying superblock buffers")
Cc: stable@vger.kernel.org # v6.12
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index b05d5b81f642..05a2f6927c12 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -1087,7 +1087,7 @@ xlog_recover_buf_commit_pass2(
 		error = xlog_recover_do_primary_sb_buffer(mp, item, bp, buf_f,
 				current_lsn);
 		if (error)
-			goto out_release;
+			goto out_writebuf;
 
 		/* Update the rt superblock if we have one. */
 		if (xfs_has_rtsb(mp) && mp->m_rtsb_bp) {
@@ -1104,6 +1104,15 @@ xlog_recover_buf_commit_pass2(
 		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
 	}
 
+	/*
+	 * Buffer held by buf log item during 'normal' buffer recovery must
+	 * be committed through buffer I/O submission path to ensure proper
+	 * release. When error occurs during sb buffer recovery, log shutdown
+	 * will be done before submitting buffer list so that buffers can be
+	 * released correctly through ioend failure path.
+	 */
+out_writebuf:
+
 	/*
 	 * Perform delayed write on the buffer.  Asynchronous writes will be
 	 * slower when taking into account all the buffers to be flushed.


