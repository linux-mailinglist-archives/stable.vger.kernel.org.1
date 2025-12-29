Return-Path: <stable+bounces-203493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB2CE68AF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A7763008F99
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED92E7BA0;
	Mon, 29 Dec 2025 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INfiC0VJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981C2E54D1
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008075; cv=none; b=ok5jFRBgjUxWGbgGsLuqV3iMZI9lnvfENFfdTx4AK4HUEkyN9u1Iec82NoZQtTRzfBmuUtyjkhTE49EBylsg31Rwqbdspxv+l2lJUkfjoAy3Q2IsjgGsz8h13jKz34BmRtXIW4yThHLw5qGDFA5lVSUCZEoWevt5JtBlImlbBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008075; c=relaxed/simple;
	bh=TDiFtPGmV5Aem9tE6F7Kq3qZPJG5W3Sbv3d8CbeA488=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UNM1Mo56c6JwLo/NkBfsfx8CIQrwvjptxFB1jf1CPL58tSWJLXDsYjQ6ilKLai/VaZfxeIHTyF5TowS5NraEM7pacI7cgImBF6WIvC58sHfqEcMB9Mb+YPi4GTMUvIprTLURTZBb6ruNxxNCtO3CInsq3O0sl/baJI1n6ZKWFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INfiC0VJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F80C4CEF7;
	Mon, 29 Dec 2025 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008073;
	bh=TDiFtPGmV5Aem9tE6F7Kq3qZPJG5W3Sbv3d8CbeA488=;
	h=Subject:To:Cc:From:Date:From;
	b=INfiC0VJVkzQxiS7bPynQgLjko9HpJ92othuuOuaBdzOpoHlz//mWJAmKy7KDTWaI
	 9MU8LIyeM7XDWqFyUkAAdkV/ESLNs07alNf4JyVKNASpSNBgHp3d5KfKYwgkq+H6CL
	 SahD/PtYCQbC387qhPR0/gAi1Bjpg+KcQYzRWvMg=
Subject: FAILED: patch "[PATCH] io_uring: fix filename leak in __io_openat_prep()" failed to apply to 6.1-stable tree
To: activprithvi@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:34:31 +0100
Message-ID: <2025122931-primer-motivate-1780@gregkh>
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
git cherry-pick -x b14fad555302a2104948feaff70503b64c80ac01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122931-primer-motivate-1780@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b14fad555302a2104948feaff70503b64c80ac01 Mon Sep 17 00:00:00 2001
From: Prithvi Tambewagh <activprithvi@gmail.com>
Date: Thu, 25 Dec 2025 12:58:29 +0530
Subject: [PATCH] io_uring: fix filename leak in __io_openat_prep()

 __io_openat_prep() allocates a struct filename using getname(). However,
for the condition of the file being installed in the fixed file table as
well as having O_CLOEXEC flag set, the function returns early. At that
point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
the memory for the newly allocated struct filename is not cleaned up,
causing a memory leak.

Fix this by setting the REQ_F_NEED_CLEANUP for the request just after the
successful getname() call, so that when the request is torn down, the
filename will be cleaned up, along with other resources needing cleanup.

Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
Fixes: b9445598d8c6 ("io_uring: openat directly into fixed fd table")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index bfeb91b31bba..15dde9bd6ff6 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -73,13 +73,13 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		open->filename = NULL;
 		return ret;
 	}
+	req->flags |= REQ_F_NEED_CLEANUP;
 
 	open->file_slot = READ_ONCE(sqe->file_index);
 	if (open->file_slot && (open->how.flags & O_CLOEXEC))
 		return -EINVAL;
 
 	open->nofile = rlimit(RLIMIT_NOFILE);
-	req->flags |= REQ_F_NEED_CLEANUP;
 	if (io_openat_force_async(open))
 		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;


