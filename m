Return-Path: <stable+bounces-54260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6890ED65
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BBEB22B77
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D796143C65;
	Wed, 19 Jun 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h5/+PaG4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1412FB27;
	Wed, 19 Jun 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803054; cv=none; b=ZLFO/RsTWb7tX0rZkRNmz1jN+V6oqGshW88jyMdnLxJme5tqFnMsqwwb1DdbhLTkiKXLziv9A2CCxrnMn7ao5iSWWSTG2z/Kh3tE75E4DQJf7y4mKQ+Vaj+7zR5ZE65CIrFhtD4YFURGbUkvRI6G7Cck7AUSDx3Vfah/+9F4OXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803054; c=relaxed/simple;
	bh=r3EJj/J2MvN3fHTKac1u+7HCsoz8Uyqv7YgA4A42Xk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAyXvTw1g+ebLaZiazro6ZxnVlenaaVCL0V+PGMdjDx0e2l2pQ1yaJRB1KekrmjwL9KduWpydjAKEmDkIP6frCM3U0v2rlMFloaDMUiW3WvOknndo3yeBuhCCCpyWTlUJVFUzkJ+AP+oXJ2yefsik/czucFfvFvqMT1VRnwbSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h5/+PaG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430A7C2BBFC;
	Wed, 19 Jun 2024 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803054;
	bh=r3EJj/J2MvN3fHTKac1u+7HCsoz8Uyqv7YgA4A42Xk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5/+PaG4lNcJUcplIAcy59JqeNwGlB0e9NGZ+7LnJKxNQo5rG/cmu74uTDd06OCp+
	 KvChm2ACQ9YzS3v1W6a5qfreGDDz5/UApbRVTrOyIgHYXc8J56zAAfRJwvB2kfwY1P
	 2fXgxMQicQybgRXkOSvvubqN3KjKd9L+99iR5Sso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 137/281] io_uring/io-wq: Use set_bit() and test_bit() at worker->flags
Date: Wed, 19 Jun 2024 14:54:56 +0200
Message-ID: <20240619125615.114599863@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 8a565304927fbd28c9f028c492b5c1714002cbab ]

Utilize set_bit() and test_bit() on worker->flags within io_uring/io-wq
to address potential data races.

The structure io_worker->flags may be accessed through various data
paths, leading to concurrency issues. When KCSAN is enabled, it reveals
data races occurring in io_worker_handle_work and
io_wq_activate_free_worker functions.

	 BUG: KCSAN: data-race in io_worker_handle_work / io_wq_activate_free_worker
	 write to 0xffff8885c4246404 of 4 bytes by task 49071 on cpu 28:
	 io_worker_handle_work (io_uring/io-wq.c:434 io_uring/io-wq.c:569)
	 io_wq_worker (io_uring/io-wq.c:?)
<snip>

	 read to 0xffff8885c4246404 of 4 bytes by task 49024 on cpu 5:
	 io_wq_activate_free_worker (io_uring/io-wq.c:? io_uring/io-wq.c:285)
	 io_wq_enqueue (io_uring/io-wq.c:947)
	 io_queue_iowq (io_uring/io_uring.c:524)
	 io_req_task_submit (io_uring/io_uring.c:1511)
	 io_handle_tw_list (io_uring/io_uring.c:1198)
<snip>

Line numbers against commit 18daea77cca6 ("Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/virt/kvm/kvm").

These races involve writes and reads to the same memory location by
different tasks running on different CPUs. To mitigate this, refactor
the code to use atomic operations such as set_bit(), test_bit(), and
clear_bit() instead of basic "and" and "or" operations. This ensures
thread-safe manipulation of worker flags.

Also, move `create_index` to avoid holes in the structure.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20240507170002.2269003-1-leitao@debian.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 91215f70ea85 ("io_uring/io-wq: avoid garbage value of 'match' in io_wq_enqueue()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io-wq.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 318ed067dbf64..4a07742349048 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -25,10 +25,10 @@
 #define WORKER_IDLE_TIMEOUT	(5 * HZ)
 
 enum {
-	IO_WORKER_F_UP		= 1,	/* up and active */
-	IO_WORKER_F_RUNNING	= 2,	/* account as running */
-	IO_WORKER_F_FREE	= 4,	/* worker on free list */
-	IO_WORKER_F_BOUND	= 8,	/* is doing bounded work */
+	IO_WORKER_F_UP		= 0,	/* up and active */
+	IO_WORKER_F_RUNNING	= 1,	/* account as running */
+	IO_WORKER_F_FREE	= 2,	/* worker on free list */
+	IO_WORKER_F_BOUND	= 3,	/* is doing bounded work */
 };
 
 enum {
@@ -44,7 +44,8 @@ enum {
  */
 struct io_worker {
 	refcount_t ref;
-	unsigned flags;
+	int create_index;
+	unsigned long flags;
 	struct hlist_nulls_node nulls_node;
 	struct list_head all_list;
 	struct task_struct *task;
@@ -58,7 +59,6 @@ struct io_worker {
 
 	unsigned long create_state;
 	struct callback_head create_work;
-	int create_index;
 
 	union {
 		struct rcu_head rcu;
@@ -165,7 +165,7 @@ static inline struct io_wq_acct *io_work_get_acct(struct io_wq *wq,
 
 static inline struct io_wq_acct *io_wq_get_acct(struct io_worker *worker)
 {
-	return io_get_acct(worker->wq, worker->flags & IO_WORKER_F_BOUND);
+	return io_get_acct(worker->wq, test_bit(IO_WORKER_F_BOUND, &worker->flags));
 }
 
 static void io_worker_ref_put(struct io_wq *wq)
@@ -225,7 +225,7 @@ static void io_worker_exit(struct io_worker *worker)
 	wait_for_completion(&worker->ref_done);
 
 	raw_spin_lock(&wq->lock);
-	if (worker->flags & IO_WORKER_F_FREE)
+	if (test_bit(IO_WORKER_F_FREE, &worker->flags))
 		hlist_nulls_del_rcu(&worker->nulls_node);
 	list_del_rcu(&worker->all_list);
 	raw_spin_unlock(&wq->lock);
@@ -410,7 +410,7 @@ static void io_wq_dec_running(struct io_worker *worker)
 	struct io_wq_acct *acct = io_wq_get_acct(worker);
 	struct io_wq *wq = worker->wq;
 
-	if (!(worker->flags & IO_WORKER_F_UP))
+	if (!test_bit(IO_WORKER_F_UP, &worker->flags))
 		return;
 
 	if (!atomic_dec_and_test(&acct->nr_running))
@@ -430,8 +430,8 @@ static void io_wq_dec_running(struct io_worker *worker)
  */
 static void __io_worker_busy(struct io_wq *wq, struct io_worker *worker)
 {
-	if (worker->flags & IO_WORKER_F_FREE) {
-		worker->flags &= ~IO_WORKER_F_FREE;
+	if (test_bit(IO_WORKER_F_FREE, &worker->flags)) {
+		clear_bit(IO_WORKER_F_FREE, &worker->flags);
 		raw_spin_lock(&wq->lock);
 		hlist_nulls_del_init_rcu(&worker->nulls_node);
 		raw_spin_unlock(&wq->lock);
@@ -444,8 +444,8 @@ static void __io_worker_busy(struct io_wq *wq, struct io_worker *worker)
 static void __io_worker_idle(struct io_wq *wq, struct io_worker *worker)
 	__must_hold(wq->lock)
 {
-	if (!(worker->flags & IO_WORKER_F_FREE)) {
-		worker->flags |= IO_WORKER_F_FREE;
+	if (!test_bit(IO_WORKER_F_FREE, &worker->flags)) {
+		set_bit(IO_WORKER_F_FREE, &worker->flags);
 		hlist_nulls_add_head_rcu(&worker->nulls_node, &wq->free_list);
 	}
 }
@@ -634,7 +634,8 @@ static int io_wq_worker(void *data)
 	bool exit_mask = false, last_timeout = false;
 	char buf[TASK_COMM_LEN];
 
-	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
+	set_mask_bits(&worker->flags, 0,
+		      BIT(IO_WORKER_F_UP) | BIT(IO_WORKER_F_RUNNING));
 
 	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
 	set_task_comm(current, buf);
@@ -698,11 +699,11 @@ void io_wq_worker_running(struct task_struct *tsk)
 
 	if (!worker)
 		return;
-	if (!(worker->flags & IO_WORKER_F_UP))
+	if (!test_bit(IO_WORKER_F_UP, &worker->flags))
 		return;
-	if (worker->flags & IO_WORKER_F_RUNNING)
+	if (test_bit(IO_WORKER_F_RUNNING, &worker->flags))
 		return;
-	worker->flags |= IO_WORKER_F_RUNNING;
+	set_bit(IO_WORKER_F_RUNNING, &worker->flags);
 	io_wq_inc_running(worker);
 }
 
@@ -716,12 +717,12 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 
 	if (!worker)
 		return;
-	if (!(worker->flags & IO_WORKER_F_UP))
+	if (!test_bit(IO_WORKER_F_UP, &worker->flags))
 		return;
-	if (!(worker->flags & IO_WORKER_F_RUNNING))
+	if (!test_bit(IO_WORKER_F_RUNNING, &worker->flags))
 		return;
 
-	worker->flags &= ~IO_WORKER_F_RUNNING;
+	clear_bit(IO_WORKER_F_RUNNING, &worker->flags);
 	io_wq_dec_running(worker);
 }
 
@@ -735,7 +736,7 @@ static void io_init_new_worker(struct io_wq *wq, struct io_worker *worker,
 	raw_spin_lock(&wq->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wq->free_list);
 	list_add_tail_rcu(&worker->all_list, &wq->all_list);
-	worker->flags |= IO_WORKER_F_FREE;
+	set_bit(IO_WORKER_F_FREE, &worker->flags);
 	raw_spin_unlock(&wq->lock);
 	wake_up_new_task(tsk);
 }
@@ -841,7 +842,7 @@ static bool create_io_worker(struct io_wq *wq, int index)
 	init_completion(&worker->ref_done);
 
 	if (index == IO_WQ_ACCT_BOUND)
-		worker->flags |= IO_WORKER_F_BOUND;
+		set_bit(IO_WORKER_F_BOUND, &worker->flags);
 
 	tsk = create_io_thread(io_wq_worker, worker, NUMA_NO_NODE);
 	if (!IS_ERR(tsk)) {
@@ -927,8 +928,8 @@ static bool io_wq_work_match_item(struct io_wq_work *work, void *data)
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work)
 {
 	struct io_wq_acct *acct = io_work_get_acct(wq, work);
+	unsigned long work_flags = work->flags;
 	struct io_cb_cancel_data match;
-	unsigned work_flags = work->flags;
 	bool do_create;
 
 	/*
-- 
2.43.0




