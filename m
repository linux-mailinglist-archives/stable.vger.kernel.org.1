Return-Path: <stable+bounces-64394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F6941DA4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FD928C96A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B091A76AF;
	Tue, 30 Jul 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTP9Bacl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB1A76A4;
	Tue, 30 Jul 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359979; cv=none; b=n1uKUeyg3fAtDv3zCAjDaxb1xeWBbdBUt3EH7vmS/JPowhq1+rmvuw4PXrCM9Y2nVQYRU5FPQqvNeDnNIy3qHcXKuu2cHhjKW9EHxSs0FOEzDWogNTYjI4wHA5D59su/3RA2OYQ8AEJ6XwE5jrXZCHseGNeKTXoVUCfeCNCf5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359979; c=relaxed/simple;
	bh=mzjwltDuiIsoptHPalgKB3qsyo1T+CurgdxO8CK3ykg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcrelvoCVIj46xeg1LpQ/T5RTwX9BU4gQ5H/Bn0cj0eKEpq2PT9xxZpzy0gn2oNynfM3x0WmLeYp0ZL1D6TE/wFob9MdU21DfinE54fZuR4LPFKxmfQxgYKUaxpQL9h9n2xmzbsfgoAtzAIowl87O9v8JvkXw1UeE9P1BPnCllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTP9Bacl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F6EC32782;
	Tue, 30 Jul 2024 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359978;
	bh=mzjwltDuiIsoptHPalgKB3qsyo1T+CurgdxO8CK3ykg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTP9Bacl+H7oD+642ifeYw3PQdXzRiOp3V14UqWZmimvCsAEwu+7dCIHjTGHGCIQs
	 9J5GaOu4ks2wFLLkWE1FRfbUzjMj5CR2TPPIynPRntl9ITdeMXQRTTlfFFsc/Ey1rN
	 ZATcsM/uEr+ir9CtjPkHLWgtB1mmrdlIDaCUZOMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+40905bca570ae6784745@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10 539/809] mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer
Date: Tue, 30 Jul 2024 17:46:55 +0200
Message-ID: <20240730151746.035689298@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f upstream.

Commit 2b5067a8143e ("mm: mmap_lock: add tracepoints around lock
acquisition") introduced TRACE_MMAP_LOCK_EVENT() macro using
preempt_disable() in order to let get_mm_memcg_path() return a percpu
buffer exclusively used by normal, softirq, irq and NMI contexts
respectively.

Commit 832b50725373 ("mm: mmap_lock: use local locks instead of disabling
preemption") replaced preempt_disable() with local_lock(&memcg_paths.lock)
based on an argument that preempt_disable() has to be avoided because
get_mm_memcg_path() might sleep if PREEMPT_RT=y.

But syzbot started reporting

  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.

and

  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.

messages, for local_lock() does not disable IRQ.

We could replace local_lock() with local_lock_irqsave() in order to
suppress these messages.  But this patch instead replaces percpu buffers
with on-stack buffer, for the size of each buffer returned by
get_memcg_path_buf() is only 256 bytes which is tolerable for allocating
from current thread's kernel stack memory.

Link: https://lkml.kernel.org/r/ef22d289-eadb-4ed9-863b-fbc922b33d8d@I-love.SAKURA.ne.jp
Reported-by: syzbot <syzbot+40905bca570ae6784745@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=40905bca570ae6784745
Fixes: 832b50725373 ("mm: mmap_lock: use local locks instead of disabling preemption")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mmap_lock.c |  175 ++++++---------------------------------------------------
 1 file changed, 20 insertions(+), 155 deletions(-)

--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -19,14 +19,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_relea
 
 #ifdef CONFIG_MEMCG
 
-/*
- * Our various events all share the same buffer (because we don't want or need
- * to allocate a set of buffers *per event type*), so we need to protect against
- * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
- * been made.
- */
-static DEFINE_MUTEX(reg_lock);
-static int reg_refcount; /* Protected by reg_lock. */
+static atomic_t reg_refcount;
 
 /*
  * Size of the buffer for memcg path names. Ignoring stack trace support,
@@ -34,136 +27,22 @@ static int reg_refcount; /* Protected by
  */
 #define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
 
-/*
- * How many contexts our trace events might be called in: normal, softirq, irq,
- * and NMI.
- */
-#define CONTEXT_COUNT 4
-
-struct memcg_path {
-	local_lock_t lock;
-	char __rcu *buf;
-	local_t buf_idx;
-};
-static DEFINE_PER_CPU(struct memcg_path, memcg_paths) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-	.buf_idx = LOCAL_INIT(0),
-};
-
-static char **tmp_bufs;
-
-/* Called with reg_lock held. */
-static void free_memcg_path_bufs(void)
-{
-	struct memcg_path *memcg_path;
-	int cpu;
-	char **old = tmp_bufs;
-
-	for_each_possible_cpu(cpu) {
-		memcg_path = per_cpu_ptr(&memcg_paths, cpu);
-		*(old++) = rcu_dereference_protected(memcg_path->buf,
-			lockdep_is_held(&reg_lock));
-		rcu_assign_pointer(memcg_path->buf, NULL);
-	}
-
-	/* Wait for inflight memcg_path_buf users to finish. */
-	synchronize_rcu();
-
-	old = tmp_bufs;
-	for_each_possible_cpu(cpu) {
-		kfree(*(old++));
-	}
-
-	kfree(tmp_bufs);
-	tmp_bufs = NULL;
-}
-
 int trace_mmap_lock_reg(void)
 {
-	int cpu;
-	char *new;
-
-	mutex_lock(&reg_lock);
-
-	/* If the refcount is going 0->1, proceed with allocating buffers. */
-	if (reg_refcount++)
-		goto out;
-
-	tmp_bufs = kmalloc_array(num_possible_cpus(), sizeof(*tmp_bufs),
-				 GFP_KERNEL);
-	if (tmp_bufs == NULL)
-		goto out_fail;
-
-	for_each_possible_cpu(cpu) {
-		new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
-		if (new == NULL)
-			goto out_fail_free;
-		rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, new);
-		/* Don't need to wait for inflights, they'd have gotten NULL. */
-	}
-
-out:
-	mutex_unlock(&reg_lock);
+	atomic_inc(&reg_refcount);
 	return 0;
-
-out_fail_free:
-	free_memcg_path_bufs();
-out_fail:
-	/* Since we failed, undo the earlier ref increment. */
-	--reg_refcount;
-
-	mutex_unlock(&reg_lock);
-	return -ENOMEM;
 }
 
 void trace_mmap_lock_unreg(void)
 {
-	mutex_lock(&reg_lock);
-
-	/* If the refcount is going 1->0, proceed with freeing buffers. */
-	if (--reg_refcount)
-		goto out;
-
-	free_memcg_path_bufs();
-
-out:
-	mutex_unlock(&reg_lock);
-}
-
-static inline char *get_memcg_path_buf(void)
-{
-	struct memcg_path *memcg_path = this_cpu_ptr(&memcg_paths);
-	char *buf;
-	int idx;
-
-	rcu_read_lock();
-	buf = rcu_dereference(memcg_path->buf);
-	if (buf == NULL) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	idx = local_add_return(MEMCG_PATH_BUF_SIZE, &memcg_path->buf_idx) -
-	      MEMCG_PATH_BUF_SIZE;
-	return &buf[idx];
+	atomic_dec(&reg_refcount);
 }
 
-static inline void put_memcg_path_buf(void)
-{
-	local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_idx);
-	rcu_read_unlock();
-}
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-	do {                                                                   \
-		const char *memcg_path;                                        \
-		local_lock(&memcg_paths.lock);                                 \
-		memcg_path = get_mm_memcg_path(mm);                            \
-		trace_mmap_lock_##type(mm,                                     \
-				       memcg_path != NULL ? memcg_path : "",   \
-				       ##__VA_ARGS__);                         \
-		if (likely(memcg_path != NULL))                                \
-			put_memcg_path_buf();                                  \
-		local_unlock(&memcg_paths.lock);                               \
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                    \
+	do {                                                    \
+		char buf[MEMCG_PATH_BUF_SIZE];                  \
+		get_mm_memcg_path(mm, buf, sizeof(buf));        \
+		trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
 	} while (0)
 
 #else /* !CONFIG_MEMCG */
@@ -185,37 +64,23 @@ void trace_mmap_lock_unreg(void)
 #ifdef CONFIG_TRACING
 #ifdef CONFIG_MEMCG
 /*
- * Write the given mm_struct's memcg path to a percpu buffer, and return a
- * pointer to it. If the path cannot be determined, or no buffer was available
- * (because the trace event is being unregistered), NULL is returned.
- *
- * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
- * disabled by the caller before calling us, and re-enabled only after the
- * caller is done with the pointer.
- *
- * The caller must call put_memcg_path_buf() once the buffer is no longer
- * needed. This must be done while preemption is still disabled.
+ * Write the given mm_struct's memcg path to a buffer. If the path cannot be
+ * determined or the trace event is being unregistered, empty string is written.
  */
-static const char *get_mm_memcg_path(struct mm_struct *mm)
+static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
 {
-	char *buf = NULL;
-	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
+	struct mem_cgroup *memcg;
 
+	buf[0] = '\0';
+	/* No need to get path if no trace event is registered. */
+	if (!atomic_read(&reg_refcount))
+		return;
+	memcg = get_mem_cgroup_from_mm(mm);
 	if (memcg == NULL)
-		goto out;
-	if (unlikely(memcg->css.cgroup == NULL))
-		goto out_put;
-
-	buf = get_memcg_path_buf();
-	if (buf == NULL)
-		goto out_put;
-
-	cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
-
-out_put:
+		return;
+	if (memcg->css.cgroup)
+		cgroup_path(memcg->css.cgroup, buf, buflen);
 	css_put(&memcg->css);
-out:
-	return buf;
 }
 
 #endif /* CONFIG_MEMCG */



