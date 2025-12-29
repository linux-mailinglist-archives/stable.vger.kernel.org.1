Return-Path: <stable+bounces-203529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 976BACE6AC6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B50C30155DC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7B2C0F60;
	Mon, 29 Dec 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p49KcdtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554230F81F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010934; cv=none; b=E7+gRQeuw8CgxxW9BGMmb65chK5LpNWIBaorojQ6jKl9snJB7UsGRZmhMLmUC65pe2yx+FOFBQozzDShpbTylc9BUMLaBO3mjSFrXnWd0oQxNDXaJYAD1LZTUuXXpGFy8QlUy6i7Ds+ZghI/YxWwxDX/rvN2LAK6JU3EobgZk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010934; c=relaxed/simple;
	bh=DaOPpw0H7sZ3rC6QblymyyMJGmX10AZFtMvnQM2ZaG4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WD5G36tJB6oCzMxWULBz+Q6st39YQbgcBY1hqZ4MLJ1alN+yTeyvIESxJDnzT6OOvnlqku+30VqA9GpwrHGLgBS/ue8KE90ex3TWhkMjv5XnCNz0RROjAVOT2A+zEfWd5OqQ97cEUMHhq/E2NCR69Ypbz5XymWYsSBEerqumz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p49KcdtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F400EC4CEF7;
	Mon, 29 Dec 2025 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767010934;
	bh=DaOPpw0H7sZ3rC6QblymyyMJGmX10AZFtMvnQM2ZaG4=;
	h=Subject:To:Cc:From:Date:From;
	b=p49KcdtY564pWgGpSVnWwXoZkp9Ut1oiEcysya/BSH8DAQ7zKC+WnVpg1EyZ4oInH
	 FTo/fE3qtWRhwkzPonD8A82leKJmp6WKNGnDyKN8mdmseLg7gtGxYoqRCF9Uv8lXIm
	 gperqfMccnVcrLopT+u1m/EVE31ItNByKg62yNZo=
Subject: FAILED: patch "[PATCH] io_uring/poll: correctly handle io_poll_add() return value on" failed to apply to 6.12-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 13:22:11 +0100
Message-ID: <2025122911-bonding-sampling-8ca0@gregkh>
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
git cherry-pick -x 84230ad2d2afbf0c44c32967e525c0ad92e26b4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122911-bonding-sampling-8ca0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84230ad2d2afbf0c44c32967e525c0ad92e26b4e Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 1 Dec 2025 13:25:22 -0700
Subject: [PATCH] io_uring/poll: correctly handle io_poll_add() return value on
 update

When the core of io_uring was updated to handle completions
consistently and with fixed return codes, the POLL_REMOVE opcode
with updates got slightly broken. If a POLL_ADD is pending and
then POLL_REMOVE is used to update the events of that request, if that
update causes the POLL_ADD to now trigger, then that completion is lost
and a CQE is never posted.

Additionally, ensure that if an update does cause an existing POLL_ADD
to complete, that the completion value isn't always overwritten with
-ECANCELED. For that case, whatever io_poll_add() set the value to
should just be retained.

Cc: stable@vger.kernel.org
Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
Reported-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
Tested-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 8aa4e3a31e73..3f1d716dcfab 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -937,12 +937,17 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 		ret2 = io_poll_add(preq, issue_flags & ~IO_URING_F_UNLOCKED);
 		/* successfully updated, don't complete poll request */
-		if (!ret2 || ret2 == -EIOCBQUEUED)
+		if (ret2 == IOU_ISSUE_SKIP_COMPLETE)
 			goto out;
+		/* request completed as part of the update, complete it */
+		else if (ret2 == IOU_COMPLETE)
+			goto complete;
 	}
 
-	req_set_fail(preq);
 	io_req_set_res(preq, -ECANCELED, 0);
+complete:
+	if (preq->cqe.res < 0)
+		req_set_fail(preq);
 	preq->io_task_work.func = io_req_task_complete;
 	io_req_task_work_add(preq);
 out:


