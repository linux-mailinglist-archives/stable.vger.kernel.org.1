Return-Path: <stable+bounces-105599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA19FADAE
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30B61884585
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E9A1993B5;
	Mon, 23 Dec 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5HeRaFv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278CA198E90
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734953299; cv=none; b=Xs85Svhg2guxFLtLpH/m4goM0Hw4QG6jsnnzzmJiN/Rh6iWH8Z+6jTDoysIEN47x+8Uwb81GLXnsA48t84G8UzBDIk4u9vdJFT9ARqMAdX1ENMZ8FhUuJgXnxXyyD9uVvrCylape5hnVe3MgkTQarta7+px0BWhkbWm3hqpRmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734953299; c=relaxed/simple;
	bh=tB9e7s7SRTg0fzMJiAHhT7YCW0qLGnPlIBSLnvm7GCw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sYfNFVgVfcFPNyZVebyAgjHux9Uow/6T6npnQef649zkmD4qQD72anx9gw1ukZcrVupjb0n3RVoXXDFyQpgfqYtd+07Fd5g5psmSEUWwdHA4wjaiCFBWq/T01mvBqq75dE8ibtOLEr952ufo3fICvyRMmo4EPIPwn8J05zk4qN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5HeRaFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363CDC4CED3;
	Mon, 23 Dec 2024 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734953298;
	bh=tB9e7s7SRTg0fzMJiAHhT7YCW0qLGnPlIBSLnvm7GCw=;
	h=Subject:To:Cc:From:Date:From;
	b=H5HeRaFvXcic7Qdnqtdl/jMZKzEUfKcl0VySFzg5mktH+pJA++tyaJKuRIiFdS3wZ
	 76RICiBIYg+4UOfYgkVBiB5iRK5fp4ldTBRZl0QzcfHuJ3EM74G9lfju7eoVSEYzdG
	 D00PHvWlm/yHOjyVbgIlE3c72wKld7yV4EYcxMxI=
Subject: FAILED: patch "[PATCH] io_uring: check if iowq is killed before queuing" failed to apply to 5.15-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,willsroot@protonmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 12:28:14 +0100
Message-ID: <2024122314-twice-deuce-e49d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dbd2ca9367eb19bc5e269b8c58b0b1514ada9156
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122314-twice-deuce-e49d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbd2ca9367eb19bc5e269b8c58b0b1514ada9156 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Thu, 19 Dec 2024 19:52:58 +0000
Subject: [PATCH] io_uring: check if iowq is killed before queuing

task work can be executed after the task has gone through io_uring
termination, whether it's the final task_work run or the fallback path.
In this case, task work will find ->io_wq being already killed and
null'ed, which is a problem if it then tries to forward the request to
io_queue_iowq(). Make io_queue_iowq() fail requests in this case.

Note that it also checks PF_KTHREAD, because the user can first close
a DEFER_TASKRUN ring and shortly after kill the task, in which case
->iowq check would race.

Cc: stable@vger.kernel.org
Fixes: 50c52250e2d74 ("block: implement async io_uring discard cmd")
Fixes: 773af69121ecc ("io_uring: always reissue from task_work context")
Reported-by: Will <willsroot@protonmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/63312b4a2c2bb67ad67b857d17a300e1d3b078e8.1734637909.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 432b95ca9c85..d3403c8216db 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -514,7 +514,11 @@ static void io_queue_iowq(struct io_kiocb *req)
 	struct io_uring_task *tctx = req->tctx;
 
 	BUG_ON(!tctx);
-	BUG_ON(!tctx->io_wq);
+
+	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
+		io_req_task_queue_fail(req, -ECANCELED);
+		return;
+	}
 
 	/* init ->work of the whole link before punting */
 	io_prep_async_link(req);


