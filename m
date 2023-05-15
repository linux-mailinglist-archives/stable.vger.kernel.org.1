Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331ED7033AD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjEOQkK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbjEOQkD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:40:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F440E9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B0516285C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDE4C433EF;
        Mon, 15 May 2023 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168800;
        bh=iKjmHaqOrxb3L09j0BuS3vequ9ACYlcpmnmjftN2+ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ba6vL+qSddL+O3AT03yLIOKAnc5uPiHJ9JfKtFZdZgcwaAEZ1sPWdPPQ5zNWbNiyp
         E1mmjLFhWCA6dOqO7mEY0CoA3GSjC2lgCf0PxOSfEahTIEm19vG3FZkp1TqrPaprg0
         /N6mucCIy397NBSpgptv4EhkxVmSQyeDhfS0uwSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qian Cai <cai@gmx.us>, Zhong Jiang <zhongjiang@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/191] debugobjects: Add percpu free pools
Date:   Mon, 15 May 2023 18:24:42 +0200
Message-Id: <20230515161708.841675721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit d86998b17a01050c0232231fa481e65ef8171ca6 ]

When a multi-threaded workload does a lot of small memory object
allocations and deallocations, it may cause the allocation and freeing of
many debug objects. This will make the global pool_lock a bottleneck in the
performance of the workload.  Since interrupts are disabled when acquiring
the pool_lock, it may even cause hard lockups to happen.

To reduce contention of the global pool_lock, add a percpu debug object
free pool that can be used to buffer some of the debug object allocation
and freeing requests without acquiring the pool_lock.  Each CPU will now
have a percpu free pool that can hold up to a maximum of 64 debug
objects. Allocation and freeing requests will go to the percpu free pool
first. If that fails, the pool_lock will be taken and the global free pool
will be used.

The presence or absence of obj_cache is used as a marker to see if the
percpu cache should be used.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190520141450.7575-2-longman@redhat.com
Stable-dep-of: 63a759694eed ("debugobject: Prevent init race with static objects")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 115 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 24 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 14afeeb7d6ef5..6e2baf9e9eb27 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -25,6 +25,7 @@
 
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
+#define ODEBUG_POOL_PERCPU_SIZE	64
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
@@ -35,6 +36,17 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
+/*
+ * Debug object percpu free list
+ * Access is protected by disabling irq
+ */
+struct debug_percpu_free {
+	struct hlist_head	free_objs;
+	int			obj_free;
+};
+
+static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
 static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
@@ -44,13 +56,19 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
 static HLIST_HEAD(obj_pool);
 static HLIST_HEAD(obj_to_free);
 
+/*
+ * Because of the presence of percpu free pools, obj_pool_free will
+ * under-count those in the percpu free pools. Similarly, obj_pool_used
+ * will over-count those in the percpu free pools. Adjustments will be
+ * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
+ * can be off.
+ */
 static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int			obj_pool_max_used;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
-static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
 static int __maybe_unused	debug_objects_maxchecked __read_mostly;
@@ -63,6 +81,7 @@ static int			debug_objects_pool_size __read_mostly
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
 static struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -162,6 +181,21 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 	return NULL;
 }
 
+/*
+ * Allocate a new object from the hlist
+ */
+static struct debug_obj *__alloc_object(struct hlist_head *list)
+{
+	struct debug_obj *obj = NULL;
+
+	if (list->first) {
+		obj = hlist_entry(list->first, typeof(*obj), node);
+		hlist_del(&obj->node);
+	}
+
+	return obj;
+}
+
 /*
  * Allocate a new object. If the pool is empty, switch off the debugger.
  * Must be called with interrupts disabled.
@@ -169,20 +203,21 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 {
-	struct debug_obj *obj = NULL;
-
-	raw_spin_lock(&pool_lock);
-	if (obj_pool.first) {
-		obj	    = hlist_entry(obj_pool.first, typeof(*obj), node);
-
-		obj->object = addr;
-		obj->descr  = descr;
-		obj->state  = ODEBUG_STATE_NONE;
-		obj->astate = 0;
-		hlist_del(&obj->node);
+	struct debug_percpu_free *percpu_pool;
+	struct debug_obj *obj;
 
-		hlist_add_head(&obj->node, &b->list);
+	if (likely(obj_cache)) {
+		percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+		obj = __alloc_object(&percpu_pool->free_objs);
+		if (obj) {
+			percpu_pool->obj_free--;
+			goto init_obj;
+		}
+	}
 
+	raw_spin_lock(&pool_lock);
+	obj = __alloc_object(&obj_pool);
+	if (obj) {
 		obj_pool_used++;
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
@@ -193,6 +228,14 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	}
 	raw_spin_unlock(&pool_lock);
 
+init_obj:
+	if (obj) {
+		obj->object = addr;
+		obj->descr  = descr;
+		obj->state  = ODEBUG_STATE_NONE;
+		obj->astate = 0;
+		hlist_add_head(&obj->node, &b->list);
+	}
 	return obj;
 }
 
@@ -247,8 +290,21 @@ static bool __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
 	bool work;
+	struct debug_percpu_free *percpu_pool;
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	local_irq_save(flags);
+	/*
+	 * Try to free it into the percpu pool first.
+	 */
+	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	if (obj_cache && percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
+		hlist_add_head(&obj->node, &percpu_pool->free_objs);
+		percpu_pool->obj_free++;
+		local_irq_restore(flags);
+		return false;
+	}
+
+	raw_spin_lock(&pool_lock);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
 	obj_pool_used--;
 
@@ -259,7 +315,8 @@ static bool __free_object(struct debug_obj *obj)
 		obj_pool_free++;
 		hlist_add_head(&obj->node, &obj_pool);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
+	raw_spin_unlock(&pool_lock);
+	local_irq_restore(flags);
 	return work;
 }
 
@@ -822,13 +879,19 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 
 static int debug_stats_show(struct seq_file *m, void *v)
 {
+	int cpu, obj_percpu_free = 0;
+
+	for_each_possible_cpu(cpu)
+		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
+
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", obj_pool_free);
+	seq_printf(m, "pool_free     :%d\n", obj_pool_free + obj_percpu_free);
+	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
+	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
 	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
@@ -1177,9 +1240,20 @@ static int __init debug_objects_replace_static_objects(void)
  */
 void __init debug_objects_mem_init(void)
 {
+	int cpu;
+
 	if (!debug_objects_enabled)
 		return;
 
+	/*
+	 * Initialize the percpu object pools
+	 *
+	 * Initialization is not strictly necessary, but was done for
+	 * completeness.
+	 */
+	for_each_possible_cpu(cpu)
+		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
+
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
 				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
@@ -1191,11 +1265,4 @@ void __init debug_objects_mem_init(void)
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
-
-	/*
-	 * Increase the thresholds for allocating and freeing objects
-	 * according to the number of possible CPUs available in the system.
-	 */
-	debug_objects_pool_size += num_possible_cpus() * 32;
-	debug_objects_pool_min_level += num_possible_cpus() * 4;
 }
-- 
2.39.2



