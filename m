Return-Path: <stable+bounces-188167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B4BF2490
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF1518A5182
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D528314A;
	Mon, 20 Oct 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA7PaQAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D727A46A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976156; cv=none; b=Zea2JydfmVK2i8jYjRF053lZokhwtwUvpmiu+IsfOoUipvM6fME3FkrbQ41pIq/3GQf4KrZ0bvp7bUr6Fhxc+9UVt6ru9EjIaWFRQBOdsvJyWAf+vVM7UGaEyIdBDLLorKRupEc5tXJA/0oO11hXJYYhGBRO88JaUAagWXQujoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976156; c=relaxed/simple;
	bh=7KSCfYOcieDLboDcjt2pSUc6GYfLfDXBSHzhBTLvlRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTGRyMKe3FsEhZPAcqtWnUl0M+f1+0ZW9lWHHPCNN6AaATf9PpIx9W+yPGCn/xLAmn2wASdJLx85fVmU4wxli4ouIsW/drmV6CM7eeWHVrdvu34+irTEdaf2GthR4Yi49oI1dQ/6cUFOijR+ZJ/T8RA2Dk3GJFfFnVFs7GOyW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA7PaQAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B564C4CEFE;
	Mon, 20 Oct 2025 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976155;
	bh=7KSCfYOcieDLboDcjt2pSUc6GYfLfDXBSHzhBTLvlRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iA7PaQAITnM/KjU8xJygfnaHEoZ3YOQLPA9yTCTTHuozYgsawSMdhySKPUlQicAE6
	 URpJoUeSolSw7PFGVXfdzECCumiwG+VgyRvQ4/tuvN2cjZN4FEDfhAzyAh1a9BFGwV
	 FXtBm1770HeHAIEwTKH6ei1r6fTom0UzF9KBsk3tquOSq8KufQQta1ynkoqLawO15u
	 6NZQPjKmeKp3FG3jsWdR6MMCOQS2Bp0PTWhw8/y8TnsvLBGq2SyfBxQ6ugB1MNbqkC
	 nfAfgYNZ04yKpLWrNRGisr4OqGY4zGs2OH0Dwgg2hEd27jY9LtMivXoZn72zyw8O23
	 INLY9rg85Q0EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] fuse: fix livelock in synchronous file put from fuseblk workers
Date: Mon, 20 Oct 2025 12:02:32 -0400
Message-ID: <20251020160232.1828501-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020160232.1828501-1-sashal@kernel.org>
References: <2025101628-exclude-hamstring-8d43@gregkh>
 <20251020160232.1828501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 26e5c67deb2e1f42a951f022fdf5b9f7eb747b01 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 627ad8fadbec0..dd1864c95d074 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -338,8 +338,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
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
-- 
2.51.0


