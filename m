Return-Path: <stable+bounces-91694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934C9BF402
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C1A1F242DA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CD206E8F;
	Wed,  6 Nov 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTImXrhx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3C206E69
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912977; cv=none; b=Jzh3/sbACmXlxx6itkH4nSQ6GN81QQSv4UCW8Sb2Q/h5JFbJnXoRHvhABEHC0eftW2pfNVNEyvd2NJyJSrru9FDCzKHs+oTDVZSxVsDLT7dmLWurLE8+Jy7p2JZ6meDUm50DAhNXd9Tz1LgXFyUSYJr5Ag41yqFOm0scacyl8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912977; c=relaxed/simple;
	bh=kuIahg3jpk9UA8AVYVs1lPotdWCLGVT034Hg7tDIk2Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fNazhxXhGr2BJ9QNV1tRZq/1g/0BuTF66GcYdyXDE4rrEsJk55Lcq1aPvWoPecok02CSQdK2XeSjCdn1N2UFK84b7B1nn2RFUrqMq+QuvlyFBdCxGWc1WFXd0YnE/hxiD98WZVt+7lJiYpUa8JXKWjbP7pjRKwa7jEd/lOM6/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTImXrhx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea527764c3so130805747b3.0
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912974; x=1731517774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iMlb3fITLqfQ+yH4R9EpWZGvZ3gmH0AG/NdlPKKA3ak=;
        b=GTImXrhx1PmI3JBeBF9zVFj5pCcIUzVpSMRo8DdHuYBOwJ8ugAZ4vieKaWzsnEIbv0
         W4OsD0pwAHO/nA4RreNbvKwXJySOyoVFT/mS1EJTv80cG2bnEkNantPQdj2IcNXAMAd/
         LqfK7jTGST4C9gRyd2C5QAVV6x0rzd4dc/aQR0xCuFcygVlKUN2LNCqxsiDEd63z6aUl
         M5aXODer5TfU7nq+4ysX/cew9dXcN4K42iUMyvpcTM5+zZQIi0KVh7wQD8lbcZXjGLu+
         M4kKIl9apIgXEud0Qt7DZb9gN3WNtdWAgyl/nUd0116D6VgU1qw3ga0P7JYoFPjlj7qc
         SqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912974; x=1731517774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMlb3fITLqfQ+yH4R9EpWZGvZ3gmH0AG/NdlPKKA3ak=;
        b=QA+OK1XisGghjlqII26oEUpJsyfRlR5I354mvGUYDnd3969bfWdZ97qxRCage7fw4w
         5dS892O0hdHwmiODtaAI6aigdgX2z+B8oAGEnuZP3HZB4HhXBy56obgXUH4Db0QqxfOQ
         TteWY1j8wTdMQEnfjVODe8+OZ2+nw+oUNY9p+3BpN02GkSx470sTHP48cHvDXdeGrWN5
         nBiKr1uym1JL0Za3ZI9PPceG6x6JIvzJA/U4WGWeLu6Nu6TaUyMNkRzQI1xUmBomzCEi
         UYGXgQj9B6qs6BqyhaGMPZay/JoXCvG4RUPSEJvkZDpGfWwCGRGIknqDgsFb9BY+kNBQ
         Yf/A==
X-Forwarded-Encrypted: i=1; AJvYcCUlHbOjZzmt26xTzaGO3ZQQ+RLWjg2RIiXDcIvfpoGg1RSMNJVWPJnioimOspPBsaY1HriZR8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHTuO02q6dHomctwH8YK0TAL8o6LfB4lEEGCDPkLdF60NM0Xe
	yAGF05yrXYyK237wg9j5uK6vlRdlvOmMHv8eTSs39PUIP69nzdxFn3yOd7xjkKpOq7SuGtmfdvF
	E/g==
X-Google-Smtp-Source: AGHT+IGZqlZKChQWJdccKYPoYKX5phL+QLuyS5OR8AWCPP1m4k3YyhT6Vm4vL99een6ileW8pEfCfSHG1qY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:b9c:a9f1:f265:18b4])
 (user=surenb job=sendgmr) by 2002:a0d:cd83:0:b0:6ea:4983:7cbd with SMTP id
 00721157ae682-6ea49837d4cmr1363127b3.7.1730912974717; Wed, 06 Nov 2024
 09:09:34 -0800 (PST)
Date: Wed,  6 Nov 2024 09:09:26 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106170927.130996-1-surenb@google.com>
Subject: [PATCH v2 6.11.y 1/2] rcu/kvfree: Add kvfree_rcu_barrier() API
From: Suren Baghdasaryan <surenb@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, surenb@google.com, 
	stable@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Uladzislau Rezki <urezki@gmail.com>

commit 3c5d61ae919cc377c71118ccc76fa6e8518023f8 upstream.

Add a kvfree_rcu_barrier() function. It waits until all
in-flight pointers are freed over RCU machinery. It does
not wait any GP completion and it is within its right to
return immediately if there are no outstanding pointers.

This function is useful when there is a need to guarantee
that a memory is fully freed before destroying memory caches.
For example, during unloading a kernel module.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]:
- Added SOB, per Greg KH

[1] https://lore.kernel.org/all/20241021171003.2907935-1-surenb@google.com/

 include/linux/rcutiny.h |   5 ++
 include/linux/rcutree.h |   1 +
 kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aea..522123050ff8 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	kvfree(ptr);
 }
 
+static inline void kvfree_rcu_barrier(void)
+{
+	rcu_barrier();
+}
+
 #ifdef CONFIG_KASAN_GENERIC
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 #else
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea9..58e7db80f3a8 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
 
 void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
+void kvfree_rcu_barrier(void);
 
 void rcu_barrier(void);
 void rcu_momentary_dyntick_idle(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..be00aac5f4e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3584,18 +3584,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 }
 
 /*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ * Return: %true if a work is queued, %false otherwise.
  */
-static void kfree_rcu_monitor(struct work_struct *work)
+static bool
+kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 {
-	struct kfree_rcu_cpu *krcp = container_of(work,
-		struct kfree_rcu_cpu, monitor_work.work);
 	unsigned long flags;
+	bool queued = false;
 	int i, j;
 
-	// Drain ready for reclaim.
-	kvfree_rcu_drain_ready(krcp);
-
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 
 	// Attempt to start a new batch.
@@ -3634,11 +3631,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	return queued;
+}
+
+/*
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+
+	// Drain ready for reclaim.
+	kvfree_rcu_drain_ready(krcp);
+
+	// Queue a batch for a rest.
+	kvfree_rcu_queue_batch(krcp);
 
 	// If there is nothing to detach, it means that our job is
 	// successfully done here. In case of having at least one
@@ -3859,6 +3872,86 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	struct kfree_rcu_cpu_work *krwp;
+	struct kfree_rcu_cpu *krcp;
+	bool queued;
+	int i, cpu;
+
+	/*
+	 * Firstly we detach objects and queue them over an RCU-batch
+	 * for all CPUs. Finally queued works are flushed for each CPU.
+	 *
+	 * Please note. If there are outstanding batches for a particular
+	 * CPU, those have to be finished first following by queuing a new.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * Check if this CPU has any objects which have been queued for a
+		 * new GP completion. If not(means nothing to detach), we are done
+		 * with it. If any batch is pending/running for this "krcp", below
+		 * per-cpu flush_rcu_work() waits its completion(see last step).
+		 */
+		if (!need_offload_krc(krcp))
+			continue;
+
+		while (1) {
+			/*
+			 * If we are not able to queue a new RCU work it means:
+			 * - batches for this CPU are still in flight which should
+			 *   be flushed first and then repeat;
+			 * - no objects to detach, because of concurrency.
+			 */
+			queued = kvfree_rcu_queue_batch(krcp);
+
+			/*
+			 * Bail out, if there is no need to offload this "krcp"
+			 * anymore. As noted earlier it can run concurrently.
+			 */
+			if (queued || !need_offload_krc(krcp))
+				break;
+
+			/* There are ongoing batches. */
+			for (i = 0; i < KFREE_N_BATCHES; i++) {
+				krwp = &(krcp->krw_arr[i]);
+				flush_rcu_work(&krwp->rcu_work);
+			}
+		}
+	}
+
+	/*
+	 * Now we guarantee that all objects are flushed.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * A monitor work can drain ready to reclaim objects
+		 * directly. Wait its completion if running or pending.
+		 */
+		cancel_delayed_work_sync(&krcp->monitor_work);
+
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			krwp = &(krcp->krw_arr[i]);
+			flush_rcu_work(&krwp->rcu_work);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {

base-commit: 163b38476c50d64b89c1dfdf4fd57a368b6ebbec
-- 
2.47.0.199.ga7371fff76-goog


