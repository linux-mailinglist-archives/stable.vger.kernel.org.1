Return-Path: <stable+bounces-92271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE99C5351
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABC11F2433C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038691F7558;
	Tue, 12 Nov 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1+Al51f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449220F5D3;
	Tue, 12 Nov 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407111; cv=none; b=lijWX/VKRT2TfQhBs5LdjG0AE0VD7qIJhHaFemkut4Ro1UAbzF97g5NsOh1UOto2UT9mmVWsHhjl9vFagl73Lj1kXUI8aHFnXUzRBTv9qB1sOLapmFWIpL/bjMuRhX8B/qgJcOWk1kzLcGT7oEw0k8sZCzDhEfKtkQxrwoTb2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407111; c=relaxed/simple;
	bh=Jd2AT4gGlltjXvB/1nRQgtJaAFrtPWkd7Z9oy+0jID0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfzQ/Mum8L9qcUxQk8HubR4ROjwuMFjMMBA5mhXKoB1kzcMmiqs+lXO/g8J0Mg4FpP0OI49njnQA2yYCii+uLvUJYjwVQrMCgpNI9Su+o1qoYml24RuBXagnX5iBFCLhUkltvCifxOim9viskvdROUbaGb+UNrNd0W3PZzCYy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A1+Al51f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C3C4CECD;
	Tue, 12 Nov 2024 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407111;
	bh=Jd2AT4gGlltjXvB/1nRQgtJaAFrtPWkd7Z9oy+0jID0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1+Al51fQL+tzuwq2WrmMNKivnGH1Eru9wIFyxvro9J3GdyfIFdXrGbA6KkMk5Vuc
	 1sbSNQbLictE71Z9m3kBzeVF0T81v8xME2PROt6poH07ZByjX3FUEN/C4B19K2NIk9
	 yiiwfXeh21KmwjUXl4f7T32d5xBcPvDdPvp+RVmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Mann <peter.mann@sh.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 53/76] io_uring/rw: fix missing NOWAIT check for O_DIRECT start write
Date: Tue, 12 Nov 2024 11:21:18 +0100
Message-ID: <20241112101841.799632310@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 1d60d74e852647255bd8e76f5a22dc42531e4389 upstream.

When io_uring starts a write, it'll call kiocb_start_write() to bump the
super block rwsem, preventing any freezes from happening while that
write is in-flight. The freeze side will grab that rwsem for writing,
excluding any new writers from happening and waiting for existing writes
to finish. But io_uring unconditionally uses kiocb_start_write(), which
will block if someone is currently attempting to freeze the mount point.
This causes a deadlock where freeze is waiting for previous writes to
complete, but the previous writes cannot complete, as the task that is
supposed to complete them is blocked waiting on starting a new write.
This results in the following stuck trace showing that dependency with
the write blocked starting a new write:

task:fio             state:D stack:0     pid:886   tgid:886   ppid:876
Call trace:
 __switch_to+0x1d8/0x348
 __schedule+0x8e8/0x2248
 schedule+0x110/0x3f0
 percpu_rwsem_wait+0x1e8/0x3f8
 __percpu_down_read+0xe8/0x500
 io_write+0xbb8/0xff8
 io_issue_sqe+0x10c/0x1020
 io_submit_sqes+0x614/0x2110
 __arm64_sys_io_uring_enter+0x524/0x1038
 invoke_syscall+0x74/0x268
 el0_svc_common.constprop.0+0x160/0x238
 do_el0_svc+0x44/0x60
 el0_svc+0x44/0xb0
 el0t_64_sync_handler+0x118/0x128
 el0t_64_sync+0x168/0x170
INFO: task fsfreeze:7364 blocked for more than 15 seconds.
      Not tainted 6.12.0-rc5-00063-g76aaf945701c #7963

with the attempting freezer stuck trying to grab the rwsem:

task:fsfreeze        state:D stack:0     pid:7364  tgid:7364  ppid:995
Call trace:
 __switch_to+0x1d8/0x348
 __schedule+0x8e8/0x2248
 schedule+0x110/0x3f0
 percpu_down_write+0x2b0/0x680
 freeze_super+0x248/0x8a8
 do_vfs_ioctl+0x149c/0x1b18
 __arm64_sys_ioctl+0xd0/0x1a0
 invoke_syscall+0x74/0x268
 el0_svc_common.constprop.0+0x160/0x238
 do_el0_svc+0x44/0x60
 el0_svc+0x44/0xb0
 el0t_64_sync_handler+0x118/0x128
 el0t_64_sync+0x168/0x170

Fix this by having the io_uring side honor IOCB_NOWAIT, and only attempt a
blocking grab of the super block rwsem if it isn't set. For normal issue
where IOCB_NOWAIT would always be set, this returns -EAGAIN which will
have io_uring core issue a blocking attempt of the write. That will in
turn also get completions run, ensuring forward progress.

Since freezing requires CAP_SYS_ADMIN in the first place, this isn't
something that can be triggered by a regular user.

Cc: stable@vger.kernel.org # 5.10+
Reported-by: Peter Mann <peter.mann@sh.cz>
Link: https://lore.kernel.org/io-uring/38c94aec-81c9-4f62-b44e-1d87f5597644@sh.cz
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 718ab6a418425..b53099b595cc7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3724,6 +3724,25 @@ static int io_write_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return io_prep_rw(req, sqe, WRITE);
 }
 
+static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
+{
+	struct inode *inode;
+	bool ret;
+
+	if (!(req->flags & REQ_F_ISREG))
+		return true;
+	if (!(kiocb->ki_flags & IOCB_NOWAIT)) {
+		kiocb_start_write(kiocb);
+		return true;
+	}
+
+	inode = file_inode(kiocb->ki_filp);
+	ret = sb_start_write_trylock(inode->i_sb);
+	if (ret)
+		__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	return ret;
+}
+
 static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -3770,8 +3789,8 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		goto out_free;
 
-	if (req->flags & REQ_F_ISREG)
-		kiocb_start_write(kiocb);
+	if (unlikely(!io_kiocb_start_write(req, kiocb)))
+		goto copy_iov;
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (req->file->f_op->write_iter)
-- 
2.43.0




