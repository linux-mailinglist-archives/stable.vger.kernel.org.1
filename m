Return-Path: <stable+bounces-35852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D183689779B
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC7828386E
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D015445B;
	Wed,  3 Apr 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CxCzEQui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCEA14E2F9;
	Wed,  3 Apr 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167016; cv=none; b=iWJzdhlFBVnDA5FW2WljeZkCXxVgrHRyjhXOH3C8EXjdxTgi5FQqOsXvc3KTN304UPSc6IsgChccU+LBhtsbunpjJL9lP9RpHdSqv/20FMP88+adFwUw+Hh5JeJgxSOauV36KLvIOLfFvUsl0WmxMljgpMibAqPWJgMBgfO0In0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167016; c=relaxed/simple;
	bh=EOYgcXpnjyF8F7BxHvLrR0MgC3+o6HJgqpIA0zYGiNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5NKkXDko58CyEfQPKOFOfb87OfO2viM+lugih8OqIY+DVsgS6Ohqty8Yi51e9GE05kIPbqTF0DaDVbxanKLWTCj3YIV2tES+EmAFoa2FFEJIxE+1PyenfavDcmgpGGtuXlcUDeovoUzFQDhpIv8Y3Y1SVsW4T+5bguHM5CUvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CxCzEQui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA02C433F1;
	Wed,  3 Apr 2024 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712167016;
	bh=EOYgcXpnjyF8F7BxHvLrR0MgC3+o6HJgqpIA0zYGiNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxCzEQuis79Bu6it5jObWXAiFgNdg3oZ6rVnlvNBl18KqIi7w49JrmWNNpCoPaO+w
	 Ag4s5oW45y0GeSWaf+MtVtbWRWKjwpsqBXy12jRsZGHSRJlegR7P1b+WJS7rMO8N7p
	 L7e3d7hXs/GjuLVNX2v29H7FydvQExzqU4KScw+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Tejun Heo <tj@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Audra Mitchell <audra@redhat.com>
Subject: [PATCH 6.6 04/11] Revert "workqueue: Introduce struct wq_node_nr_active"
Date: Wed,  3 Apr 2024 19:55:53 +0200
Message-ID: <20240403175126.979011183@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
References: <20240403175126.839589571@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit b522229a56941adac1ea1da6593b2b5c734b5359 which is
commit 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5 upstream.

The workqueue patches backported to 6.6.y caused some reported
regressions, so revert them for now.

Reported-by: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Audra Mitchell <audra@redhat.com>
Link: https://lore.kernel.org/all/ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |  142 ++---------------------------------------------------
 1 file changed, 7 insertions(+), 135 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -281,16 +281,6 @@ struct wq_flusher {
 struct wq_device;
 
 /*
- * Unlike in a per-cpu workqueue where max_active limits its concurrency level
- * on each CPU, in an unbound workqueue, max_active applies to the whole system.
- * As sharing a single nr_active across multiple sockets can be very expensive,
- * the counting and enforcement is per NUMA node.
- */
-struct wq_node_nr_active {
-	atomic_t		nr;		/* per-node nr_active count */
-};
-
-/*
  * The externally visible workqueue.  It relays the issued work items to
  * the appropriate worker_pool through its pool_workqueues.
  */
@@ -336,7 +326,6 @@ struct workqueue_struct {
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
-	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
 };
 
 static struct kmem_cache *pwq_cache;
@@ -1427,31 +1416,6 @@ work_func_t wq_worker_last_func(struct t
 }
 
 /**
- * wq_node_nr_active - Determine wq_node_nr_active to use
- * @wq: workqueue of interest
- * @node: NUMA node, can be %NUMA_NO_NODE
- *
- * Determine wq_node_nr_active to use for @wq on @node. Returns:
- *
- * - %NULL for per-cpu workqueues as they don't need to use shared nr_active.
- *
- * - node_nr_active[nr_node_ids] if @node is %NUMA_NO_NODE.
- *
- * - Otherwise, node_nr_active[@node].
- */
-static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
-						   int node)
-{
-	if (!(wq->flags & WQ_UNBOUND))
-		return NULL;
-
-	if (node == NUMA_NO_NODE)
-		node = nr_node_ids;
-
-	return wq->node_nr_active[node];
-}
-
-/**
  * get_pwq - get an extra reference on the specified pool_workqueue
  * @pwq: pool_workqueue to get
  *
@@ -1532,17 +1496,12 @@ static bool pwq_activate_work(struct poo
 			      struct work_struct *work)
 {
 	struct worker_pool *pool = pwq->pool;
-	struct wq_node_nr_active *nna;
 
 	lockdep_assert_held(&pool->lock);
 
 	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
 		return false;
 
-	nna = wq_node_nr_active(pwq->wq, pool->node);
-	if (nna)
-		atomic_inc(&nna->nr);
-
 	pwq->nr_active++;
 	__pwq_activate_work(pwq, work);
 	return true;
@@ -1559,18 +1518,14 @@ static bool pwq_tryinc_nr_active(struct
 {
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
-	struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
 	bool obtained;
 
 	lockdep_assert_held(&pool->lock);
 
 	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
 
-	if (obtained) {
+	if (obtained)
 		pwq->nr_active++;
-		if (nna)
-			atomic_inc(&nna->nr);
-	}
 	return obtained;
 }
 
@@ -1607,26 +1562,10 @@ static bool pwq_activate_first_inactive(
 static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 {
 	struct worker_pool *pool = pwq->pool;
-	struct wq_node_nr_active *nna = wq_node_nr_active(pwq->wq, pool->node);
 
 	lockdep_assert_held(&pool->lock);
 
-	/*
-	 * @pwq->nr_active should be decremented for both percpu and unbound
-	 * workqueues.
-	 */
 	pwq->nr_active--;
-
-	/*
-	 * For a percpu workqueue, it's simple. Just need to kick the first
-	 * inactive work item on @pwq itself.
-	 */
-	if (!nna) {
-		pwq_activate_first_inactive(pwq);
-		return;
-	}
-
-	atomic_dec(&nna->nr);
 	pwq_activate_first_inactive(pwq);
 }
 
@@ -4081,63 +4020,11 @@ static void wq_free_lockdep(struct workq
 }
 #endif
 
-static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
-{
-	int node;
-
-	for_each_node(node) {
-		kfree(nna_ar[node]);
-		nna_ar[node] = NULL;
-	}
-
-	kfree(nna_ar[nr_node_ids]);
-	nna_ar[nr_node_ids] = NULL;
-}
-
-static void init_node_nr_active(struct wq_node_nr_active *nna)
-{
-	atomic_set(&nna->nr, 0);
-}
-
-/*
- * Each node's nr_active counter will be accessed mostly from its own node and
- * should be allocated in the node.
- */
-static int alloc_node_nr_active(struct wq_node_nr_active **nna_ar)
-{
-	struct wq_node_nr_active *nna;
-	int node;
-
-	for_each_node(node) {
-		nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, node);
-		if (!nna)
-			goto err_free;
-		init_node_nr_active(nna);
-		nna_ar[node] = nna;
-	}
-
-	/* [nr_node_ids] is used as the fallback */
-	nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, NUMA_NO_NODE);
-	if (!nna)
-		goto err_free;
-	init_node_nr_active(nna);
-	nna_ar[nr_node_ids] = nna;
-
-	return 0;
-
-err_free:
-	free_node_nr_active(nna_ar);
-	return -ENOMEM;
-}
-
 static void rcu_free_wq(struct rcu_head *rcu)
 {
 	struct workqueue_struct *wq =
 		container_of(rcu, struct workqueue_struct, rcu);
 
-	if (wq->flags & WQ_UNBOUND)
-		free_node_nr_active(wq->node_nr_active);
-
 	wq_free_lockdep(wq);
 	free_percpu(wq->cpu_pwq);
 	free_workqueue_attrs(wq->unbound_attrs);
@@ -4889,8 +4776,7 @@ struct workqueue_struct *alloc_workqueue
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	size_t wq_size;
-	int name_len;
+	int len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4906,12 +4792,7 @@ struct workqueue_struct *alloc_workqueue
 		flags |= WQ_UNBOUND;
 
 	/* allocate wq and format name */
-	if (flags & WQ_UNBOUND)
-		wq_size = struct_size(wq, node_nr_active, nr_node_ids + 1);
-	else
-		wq_size = sizeof(*wq);
-
-	wq = kzalloc(wq_size, GFP_KERNEL);
+	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return NULL;
 
@@ -4922,12 +4803,11 @@ struct workqueue_struct *alloc_workqueue
 	}
 
 	va_start(args, max_active);
-	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
-	if (name_len >= WQ_NAME_LEN)
-		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
-			     wq->name);
+	if (len >= WQ_NAME_LEN)
+		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
 
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
@@ -4946,13 +4826,8 @@ struct workqueue_struct *alloc_workqueue
 	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
-	if (flags & WQ_UNBOUND) {
-		if (alloc_node_nr_active(wq->node_nr_active) < 0)
-			goto err_unreg_lockdep;
-	}
-
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_free_node_nr_active;
+		goto err_unreg_lockdep;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4977,9 +4852,6 @@ struct workqueue_struct *alloc_workqueue
 
 	return wq;
 
-err_free_node_nr_active:
-	if (wq->flags & WQ_UNBOUND)
-		free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);



