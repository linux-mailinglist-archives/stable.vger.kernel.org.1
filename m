Return-Path: <stable+bounces-62408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DB293EF23
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233251C21B23
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14350126F2A;
	Mon, 29 Jul 2024 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="He5DTcjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949B1EB2C
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239726; cv=none; b=Bk+aigtka8HYru3cYFBFqueNw0P77Zw3B/OyMLeh/QcJVNgfI0czD3+16e9TpGncXn3TGWl87JaET/e30h7L+0dJNd5QyJqNIlnsdmBVZKsVBQfHdtlYgDvCZOYlceXHRK1T4V9rSiNzS/OycbIjokfLv9XVbQ3ii7FYTCuk+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239726; c=relaxed/simple;
	bh=Sc+ZCX6UpDjUSmZ+I9DeWV3FMS82f4C56DT0ETCp8hA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UgQRPcM50/zbGpsInKbXxt60mA1fhZQydI9ci6RnsB3c3EowwhBtkTzpNwlJfsmZizkXKwi+dHcLVnDIVpHt+9FNJO13Gw7mEcu0Au7rJyBKHXz/3Y+xbSNBf6Cy4iuiIFgy82QmZmzuoEZSaShSn5yAWOJAj72KNKgTwyRw/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=He5DTcjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F1FC32786;
	Mon, 29 Jul 2024 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239726;
	bh=Sc+ZCX6UpDjUSmZ+I9DeWV3FMS82f4C56DT0ETCp8hA=;
	h=Subject:To:Cc:From:Date:From;
	b=He5DTcjou2/7T7RtOD2Act3ruOaIf+OA+9yI/olqJnQUYH7Q06GxmU+30s0lGIuOd
	 2qNSfXNdHQ58Z5IK5gQipkVyN+m/4Xp/LKb/EZwuQwZ6edNnys6kPe1M0o4uCZrLSK
	 yrIX4sE1WPBpnOXKftIbHmHcAVNg/ekHsnFf0ohk=
Subject: FAILED: patch "[PATCH] io_uring/io-wq: limit retrying worker initialisation" failed to apply to 6.1-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,ju.orth@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:55:23 +0200
Message-ID: <2024072923-bodacious-claw-442b@gregkh>
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
git cherry-pick -x 0453aad676ff99787124b9b3af4a5f59fbe808e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072923-bodacious-claw-442b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0453aad676ff ("io_uring/io-wq: limit retrying worker initialisation")
8a565304927f ("io_uring/io-wq: Use set_bit() and test_bit() at worker->flags")
eb47943f2238 ("io-wq: Drop struct io_wqe")
dfd63baf892c ("io-wq: Move wq accounting to io_wq")
da64d6db3bd3 ("io_uring: One wqe per wq")
01e68ce08a30 ("io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0453aad676ff99787124b9b3af4a5f59fbe808e2 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 10 Jul 2024 18:58:17 +0100
Subject: [PATCH] io_uring/io-wq: limit retrying worker initialisation

If io-wq worker creation fails, we retry it by queueing up a task_work.
tasK_work is needed because it should be done from the user process
context. The problem is that retries are not limited, and if queueing a
task_work is the reason for the failure, we might get into an infinite
loop.

It doesn't seem to happen now but it would with the following patch
executing task_work in the freezer's loop. For now, arbitrarily limit the
number of attempts to create a worker.

Cc: stable@vger.kernel.org
Fixes: 3146cba99aa28 ("io-wq: make worker creation resilient against signals")
Reported-by: Julian Orth <ju.orth@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/8280436925db88448c7c85c6656edee1a43029ea.1720634146.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 913c92249522..f1e7c670add8 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -23,6 +23,7 @@
 #include "io_uring.h"
 
 #define WORKER_IDLE_TIMEOUT	(5 * HZ)
+#define WORKER_INIT_LIMIT	3
 
 enum {
 	IO_WORKER_F_UP		= 0,	/* up and active */
@@ -58,6 +59,7 @@ struct io_worker {
 
 	unsigned long create_state;
 	struct callback_head create_work;
+	int init_retries;
 
 	union {
 		struct rcu_head rcu;
@@ -745,7 +747,7 @@ static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
 	return true;
 }
 
-static inline bool io_should_retry_thread(long err)
+static inline bool io_should_retry_thread(struct io_worker *worker, long err)
 {
 	/*
 	 * Prevent perpetual task_work retry, if the task (or its group) is
@@ -753,6 +755,8 @@ static inline bool io_should_retry_thread(long err)
 	 */
 	if (fatal_signal_pending(current))
 		return false;
+	if (worker->init_retries++ >= WORKER_INIT_LIMIT)
+		return false;
 
 	switch (err) {
 	case -EAGAIN:
@@ -779,7 +783,7 @@ static void create_worker_cont(struct callback_head *cb)
 		io_init_new_worker(wq, worker, tsk);
 		io_worker_release(worker);
 		return;
-	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
+	} else if (!io_should_retry_thread(worker, PTR_ERR(tsk))) {
 		struct io_wq_acct *acct = io_wq_get_acct(worker);
 
 		atomic_dec(&acct->nr_running);
@@ -846,7 +850,7 @@ static bool create_io_worker(struct io_wq *wq, int index)
 	tsk = create_io_thread(io_wq_worker, worker, NUMA_NO_NODE);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wq, worker, tsk);
-	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
+	} else if (!io_should_retry_thread(worker, PTR_ERR(tsk))) {
 		kfree(worker);
 		goto fail;
 	} else {


