Return-Path: <stable+bounces-87604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF349A70A9
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468722841A2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93A1E9089;
	Mon, 21 Oct 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smvgW4gN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA451E9072
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530610; cv=none; b=P7oeE8AEBCps7cjfHp/aVWHmBst1i+T6l0qpRPcXEtQk8fz8v+XT9y0r4hv2hDFJ0JAN0a5PGzQlIZi4UGqqP+7T2SwbgZGe06ZudJQgE/r+P8ueQHwBMZoquEfW6nUjxGs00zMy5W2Uujl4krfSUPhQrm7yrDlxCPfbNk4tknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530610; c=relaxed/simple;
	bh=EgxByLbqMuyVq+wsrIwXYH52ePf7l1ykLcKjgCJd7fk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z3zSRtzTlktkoBnLIayQnBulZV5hoy62+FsBp9El0Z28QsGljm3acommxEk2wr4TTOsgF9viBHbf7ONLpTVPtkht53gC4wREn4wkM0AD1ew6RcWYdZa9PhNotkOtVQfdi8S/61TOMcm0X52gn78tT8nXGDLus+EMs3weM9Qp4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smvgW4gN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so8152308276.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729530606; x=1730135406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KW8xVNW7kAHLKAdfvzj4axh/ytWTysYE+wy9p2w6gm4=;
        b=smvgW4gNygWuRdiSq+T95TR5hgrWSJ45mFjVIwSGk2ThMn6vtQoiHcuG9unRx/1Zkg
         +9lU44nFVDXM64FNkby4rjldpkH32hnSKGNLJOI1flusIuIu81QvoEEkqQfLqs2AnBEz
         IPRe9kh3qRcPYrn8IobgD/b0yQlOPcNzwKr9bBDu08LKi7tnCZVa9VcB2LclDCan+VOG
         WNYYkRnZVXC9ZCXG9WCwAkZbZ9OZuxaqDy6lxotBjEox4WXBFvOqN1DfykVkHPgNfCo/
         a2mHM0km1zGeWa9Lsf5BauL86D3GQzwOBdvbbVNLgXYqzP+iwRGLVqhnRkdN+X9dON6p
         zrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530606; x=1730135406;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW8xVNW7kAHLKAdfvzj4axh/ytWTysYE+wy9p2w6gm4=;
        b=cvfwk+0ErPVG6E9fRJ5X1tF/sX+bqKZ/AaVnjzlbijHw1TzW1uj5UywBwsX6TRvlcb
         GloPkfGFPxW9rp05JQsYFEaf4hPCwDc/2KSoK6g7hASM97OtEvr15g0agddlFErFlJIa
         J4od/lt0X+0Setdgitjg8dHtufHsOUsWkXaD+tcURaYniC0s0B+BMIWT5WpJiEsaIsAC
         LMoAJzzS6sR1GEK2rddwXpw2oKNcS7QoPgMJ4KNcuMdyBmrHFjxn3kCupOG0iSNswe9I
         bpMEa07K9ScMWLCLYfyt/R2a9dnEfG1h+LAJWqSOgUo5hQ9loSKbUVNBsKiktzSRUe9n
         /t2A==
X-Forwarded-Encrypted: i=1; AJvYcCVW5V4HmXZt5Kj3nUYBUbLHZ3O+KI6IbYg0Be7/tIEqHWnt2jSAhbd4pGYpw3uWwl1qGijY2EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WSbPyAFtWWitsYBXnhYrxSEfWp8DMzQBUk8hVokm1GZZMXKb
	M9WF+RnGE39w0N8/VbsR3l8duZqF7DwwnJj4fHZw+X0WbffQjommosGftWANr8V/RVXY8aho1nv
	OCA==
X-Google-Smtp-Source: AGHT+IHFDt81jPcPeIVKlm6JLoSlE7G+Zs5Md8NJw339+HdffO+tG2R8vi5CkfIVuwkpe6wI38+cZC1BM54=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cfa8:1167:32cd:5d81])
 (user=surenb job=sendgmr) by 2002:a25:868a:0:b0:e24:9f58:dd17 with SMTP id
 3f1490d57ef6-e2bb11aae47mr15746276.1.1729530606487; Mon, 21 Oct 2024 10:10:06
 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:10:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021171003.2907935-1-surenb@google.com>
Subject: [PATCH 6.11.y 1/2] rcu/kvfree: Add kvfree_rcu_barrier() API
From: Suren Baghdasaryan <surenb@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, surenb@google.com, 
	stable@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

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
---
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

base-commit: 17365d66f1c6aa6bf4f4cb9842f5edeac027bcfb
-- 
2.47.0.105.g07ac214952-goog


