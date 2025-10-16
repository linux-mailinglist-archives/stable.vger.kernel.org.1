Return-Path: <stable+bounces-186039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E102EBE36A9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B016353EE4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600C31CA7D;
	Thu, 16 Oct 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GM/ydOOf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66092E36F2
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618193; cv=none; b=lnMZuLFeKMQQWMD4Me0XqrtvLBMo67pyGhmuIDimZ5VQJt8E73KV5F0fD4VLaH9+3xzm0Nmn8X0qUh3mdsU6uka858GGA7OJJ+chPpr7prGSMDb42sfgKQ/e648jZkTvrZFs7+TGTLARIILeKXOWi70K2vCZCk5VPeHVC2WrjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618193; c=relaxed/simple;
	bh=FJo3G9O2D5wdgrW6LIK5SB+tfTtLxVmMZRKVIzOAkOc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=efJ5yhgOAu+rejxy+iK6Nv9HGzWdRdQ/Bbvz7IZB7URSLm1ac2Xf95G1Um86giHm5/VtiJumePVkEs4la2sDArOS8aWxBvu2+YOkXGj/2fDMBFUzbTBqUR2g2QbiBusL7ILrugv0kK3wu9zgUeq9BkguD/ZysUzTN/yl0VOJy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GM/ydOOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0787FC4CEF1;
	Thu, 16 Oct 2025 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618193;
	bh=FJo3G9O2D5wdgrW6LIK5SB+tfTtLxVmMZRKVIzOAkOc=;
	h=Subject:To:Cc:From:Date:From;
	b=GM/ydOOfSba78v5061kRayGKO6eEK9XzgenlPH+OS/3ecQc8wmHHsobuApeeYHJVH
	 6SEdRLcWUdKUsuE1951cbOvBIX/WWj6L50XyHH3LyDRDZC9Mr76G1xvBeQD1JmJfiJ
	 OdQzWgEcM/8+dJPue53abhJw/eIspRFM6DV4h+D0=
Subject: FAILED: patch "[PATCH] fuse: fix livelock in synchronous file put from fuseblk" failed to apply to 6.1-stable tree
To: djwong@kernel.org,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:36:28 +0200
Message-ID: <2025101628-exclude-hamstring-8d43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 26e5c67deb2e1f42a951f022fdf5b9f7eb747b01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101628-exclude-hamstring-8d43@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26e5c67deb2e1f42a951f022fdf5b9f7eb747b01 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 15 Sep 2025 17:24:17 -0700
Subject: [PATCH] fuse: fix livelock in synchronous file put from fuseblk
 workers

I observed a hang when running generic/323 against a fuseblk server.
This test opens a file, initiates a lot of AIO writes to that file
descriptor, and closes the file descriptor before the writes complete.
Unsurprisingly, the AIO exerciser threads are mostly stuck waiting for
responses from the fuseblk server:

# cat /proc/372265/task/372313/stack
[<0>] request_wait_answer+0x1fe/0x2a0 [fuse]
[<0>] __fuse_simple_request+0xd3/0x2b0 [fuse]
[<0>] fuse_do_getattr+0xfc/0x1f0 [fuse]
[<0>] fuse_file_read_iter+0xbe/0x1c0 [fuse]
[<0>] aio_read+0x130/0x1e0
[<0>] io_submit_one+0x542/0x860
[<0>] __x64_sys_io_submit+0x98/0x1a0
[<0>] do_syscall_64+0x37/0xf0
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

But the /weird/ part is that the fuseblk server threads are waiting for
responses from itself:

# cat /proc/372210/task/372232/stack
[<0>] request_wait_answer+0x1fe/0x2a0 [fuse]
[<0>] __fuse_simple_request+0xd3/0x2b0 [fuse]
[<0>] fuse_file_put+0x9a/0xd0 [fuse]
[<0>] fuse_release+0x36/0x50 [fuse]
[<0>] __fput+0xec/0x2b0
[<0>] task_work_run+0x55/0x90
[<0>] syscall_exit_to_user_mode+0xe9/0x100
[<0>] do_syscall_64+0x43/0xf0
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

The fuseblk server is fuse2fs so there's nothing all that exciting in
the server itself.  So why is the fuse server calling fuse_file_put?
The commit message for the fstest sheds some light on that:

"By closing the file descriptor before calling io_destroy, you pretty
much guarantee that the last put on the ioctx will be done in interrupt
context (during I/O completion).

Aha.  AIO fgets a new struct file from the fd when it queues the ioctx.
The completion of the FUSE_WRITE command from userspace causes the fuse
server to call the AIO completion function.  The completion puts the
struct file, queuing a delayed fput to the fuse server task.  When the
fuse server task returns to userspace, it has to run the delayed fput,
which in the case of a fuseblk server, it does synchronously.

Sending the FUSE_RELEASE command sychronously from fuse server threads
is a bad idea because a client program can initiate enough simultaneous
AIOs such that all the fuse server threads end up in delayed_fput, and
now there aren't any threads left to handle the queued fuse commands.

Fix this by only using asynchronous fputs when closing files, and leave
a comment explaining why.

Cc: stable@vger.kernel.org # v2.6.38
Fixes: 5a18ec176c934c ("fuse: fix hang of single threaded fuseblk filesystem")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 54786f62a9d8..f1ef77a0be05 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -356,8 +356,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * Always use the asynchronous file put because the current thread
+	 * might be the fuse server.  This can happen if a process starts some
+	 * aio and closes the fd before the aio completes.  Since aio takes its
+	 * own ref to the file, the IO completion has to drop the ref, which is
+	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy);
+	fuse_file_put(ff, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)


