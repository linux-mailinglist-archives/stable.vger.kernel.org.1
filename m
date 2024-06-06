Return-Path: <stable+bounces-49825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E048C8FEF05
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F201C210A8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074B1A187A;
	Thu,  6 Jun 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcDGyoxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390D1C95D3;
	Thu,  6 Jun 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683728; cv=none; b=OYXfu5RNp2Nx5sb3+PaNVdwqdeuOkKvNEV7FMENSWNHjueRTvny5K+LomRPXLUmLekDqJXyY8KedZCJEK3ubbgWdllGX1UPOBQzvIVpQU8df5kz4BqJt/ZregZZO2n3VdI0rifRdFRDAOE7Sojg0kDyfYacAd1TSIwwlWfFyDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683728; c=relaxed/simple;
	bh=iVfQ2tMZVC70qmKzgI6b7OSVmudhXCmRCtbVJNvNb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVjVAvwnL6XqL8+CRYXNJYtRKSL2fr3FbSkwLhXoJQlHAIg52kBd5fOHlo5wvFVAu/OY9rCgcBNkUbS/1sH/+TAqVYEzYl1j0sai/0zcmZOPBZNlucsN98IGUDQOG+FzT85HOPBeXqXKk6cRcl20SxUa3Ro8D/2poSvESDCXNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcDGyoxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21C2C2BD10;
	Thu,  6 Jun 2024 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683727;
	bh=iVfQ2tMZVC70qmKzgI6b7OSVmudhXCmRCtbVJNvNb0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcDGyoxnqf+YcuZf+tyJT5o0eALBt6odhRM/udHl7rxn8yCfbDwfcUtE8mDT6LgEF
	 kyZ8CJt+TNdQTFLyGRniKnpmMOrLM98osG90zNSxTI90Z7c9EDq11XydH+cfi74G+N
	 iAdLZhkb+N7rNRAbFj8Zlre1X7neBaGOGWNb4pUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 676/744] kthread: add kthread_stop_put
Date: Thu,  6 Jun 2024 16:05:48 +0200
Message-ID: <20240606131754.179013278@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 6309727ef27162deabd5c095c11af24970fba5a2 ]

Add a kthread_stop_put() helper that stops a thread and puts its task
struct.  Use it to replace the various instances of kthread_stop()
followed by put_task_struct().

Remove the kthread_stop_put() macro in usbip that is similar but doesn't
return the result of kthread_stop().

[agruenba@redhat.com: fix kerneldoc comment]
  Link: https://lkml.kernel.org/r/20230911111730.2565537-1-agruenba@redhat.com
[akpm@linux-foundation.org: document kthread_stop_put()'s argument]
Link: https://lkml.kernel.org/r/20230907234048.2499820-1-agruenba@redhat.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: bb9025f4432f ("dma-mapping: benchmark: fix up kthread-related error handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_job.c              |  3 +--
 drivers/dma-buf/st-dma-fence-chain.c       | 12 ++++--------
 drivers/dma-buf/st-dma-fence.c             |  4 +---
 drivers/gpu/drm/i915/gt/selftest_migrate.c |  4 +---
 drivers/net/xen-netback/interface.c        |  3 +--
 drivers/usb/usbip/usbip_common.h           |  6 ------
 fs/gfs2/ops_fstype.c                       |  9 +++------
 include/linux/kthread.h                    |  1 +
 kernel/irq/manage.c                        | 15 +++++----------
 kernel/kthread.c                           | 18 ++++++++++++++++++
 kernel/smpboot.c                           |  3 +--
 mm/damon/core.c                            |  3 +--
 net/core/pktgen.c                          |  3 +--
 13 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index de9e69f70af7e..76f468c9f761b 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -618,6 +618,5 @@ int ivpu_job_done_thread_init(struct ivpu_device *vdev)
 
 void ivpu_job_done_thread_fini(struct ivpu_device *vdev)
 {
-	kthread_stop(vdev->job_done_thread);
-	put_task_struct(vdev->job_done_thread);
+	kthread_stop_put(vdev->job_done_thread);
 }
diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index 661de4add4c72..ed4b323886e43 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -476,10 +476,9 @@ static int find_race(void *arg)
 	for (i = 0; i < ncpus; i++) {
 		int ret;
 
-		ret = kthread_stop(threads[i]);
+		ret = kthread_stop_put(threads[i]);
 		if (ret && !err)
 			err = ret;
-		put_task_struct(threads[i]);
 	}
 	kfree(threads);
 
@@ -591,8 +590,7 @@ static int wait_forward(void *arg)
 	for (i = 0; i < fc.chain_length; i++)
 		dma_fence_signal(fc.fences[i]);
 
-	err = kthread_stop(tsk);
-	put_task_struct(tsk);
+	err = kthread_stop_put(tsk);
 
 err:
 	fence_chains_fini(&fc);
@@ -621,8 +619,7 @@ static int wait_backward(void *arg)
 	for (i = fc.chain_length; i--; )
 		dma_fence_signal(fc.fences[i]);
 
-	err = kthread_stop(tsk);
-	put_task_struct(tsk);
+	err = kthread_stop_put(tsk);
 
 err:
 	fence_chains_fini(&fc);
@@ -669,8 +666,7 @@ static int wait_random(void *arg)
 	for (i = 0; i < fc.chain_length; i++)
 		dma_fence_signal(fc.fences[i]);
 
-	err = kthread_stop(tsk);
-	put_task_struct(tsk);
+	err = kthread_stop_put(tsk);
 
 err:
 	fence_chains_fini(&fc);
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index fb6e0a6ae2c96..b7c6f7ea9e0c8 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -548,11 +548,9 @@ static int race_signal_callback(void *arg)
 		for (i = 0; i < ARRAY_SIZE(t); i++) {
 			int err;
 
-			err = kthread_stop(t[i].task);
+			err = kthread_stop_put(t[i].task);
 			if (err && !ret)
 				ret = err;
-
-			put_task_struct(t[i].task);
 		}
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 3def5ca72decf..0fb07f073baa6 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -719,11 +719,9 @@ static int threaded_migrate(struct intel_migrate *migrate,
 		if (IS_ERR_OR_NULL(tsk))
 			continue;
 
-		status = kthread_stop(tsk);
+		status = kthread_stop_put(tsk);
 		if (status && !err)
 			err = status;
-
-		put_task_struct(tsk);
 	}
 
 	kfree(thread);
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index fc3bb63b9ac3e..acf310e58f7e2 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -668,8 +668,7 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 static void xenvif_disconnect_queue(struct xenvif_queue *queue)
 {
 	if (queue->task) {
-		kthread_stop(queue->task);
-		put_task_struct(queue->task);
+		kthread_stop_put(queue->task);
 		queue->task = NULL;
 	}
 
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index d8cbd2dfc2c25..282efca64a012 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -298,12 +298,6 @@ struct usbip_device {
 	__k;								   \
 })
 
-#define kthread_stop_put(k)		\
-	do {				\
-		kthread_stop(k);	\
-		put_task_struct(k);	\
-	} while (0)
-
 /* usbip_common.c */
 void usbip_dump_urb(struct urb *purb);
 void usbip_dump_header(struct usbip_header *pdu);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 5d51bc58a9a03..f4c066aa24b96 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1127,8 +1127,7 @@ static int init_threads(struct gfs2_sbd *sdp)
 	return 0;
 
 fail:
-	kthread_stop(sdp->sd_logd_process);
-	put_task_struct(sdp->sd_logd_process);
+	kthread_stop_put(sdp->sd_logd_process);
 	sdp->sd_logd_process = NULL;
 	return error;
 }
@@ -1136,13 +1135,11 @@ static int init_threads(struct gfs2_sbd *sdp)
 void gfs2_destroy_threads(struct gfs2_sbd *sdp)
 {
 	if (sdp->sd_logd_process) {
-		kthread_stop(sdp->sd_logd_process);
-		put_task_struct(sdp->sd_logd_process);
+		kthread_stop_put(sdp->sd_logd_process);
 		sdp->sd_logd_process = NULL;
 	}
 	if (sdp->sd_quotad_process) {
-		kthread_stop(sdp->sd_quotad_process);
-		put_task_struct(sdp->sd_quotad_process);
+		kthread_stop_put(sdp->sd_quotad_process);
 		sdp->sd_quotad_process = NULL;
 	}
 }
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2c30ade43bc87..b11f53c1ba2e6 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -86,6 +86,7 @@ void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
+int kthread_stop_put(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
 bool kthread_should_stop_or_park(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d309ba84e08a9..1782f90cd8c6c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1852,15 +1852,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		struct task_struct *t = new->thread;
 
 		new->thread = NULL;
-		kthread_stop(t);
-		put_task_struct(t);
+		kthread_stop_put(t);
 	}
 	if (new->secondary && new->secondary->thread) {
 		struct task_struct *t = new->secondary->thread;
 
 		new->secondary->thread = NULL;
-		kthread_stop(t);
-		put_task_struct(t);
+		kthread_stop_put(t);
 	}
 out_mput:
 	module_put(desc->owner);
@@ -1971,12 +1969,9 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * the same bit to a newly requested action.
 	 */
 	if (action->thread) {
-		kthread_stop(action->thread);
-		put_task_struct(action->thread);
-		if (action->secondary && action->secondary->thread) {
-			kthread_stop(action->secondary->thread);
-			put_task_struct(action->secondary->thread);
-		}
+		kthread_stop_put(action->thread);
+		if (action->secondary && action->secondary->thread)
+			kthread_stop_put(action->secondary->thread);
 	}
 
 	/* Last action releases resources */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1eea53050babc..290cbc845225e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -715,6 +715,24 @@ int kthread_stop(struct task_struct *k)
 }
 EXPORT_SYMBOL(kthread_stop);
 
+/**
+ * kthread_stop_put - stop a thread and put its task struct
+ * @k: thread created by kthread_create().
+ *
+ * Stops a thread created by kthread_create() and put its task_struct.
+ * Only use when holding an extra task struct reference obtained by
+ * calling get_task_struct().
+ */
+int kthread_stop_put(struct task_struct *k)
+{
+	int ret;
+
+	ret = kthread_stop(k);
+	put_task_struct(k);
+	return ret;
+}
+EXPORT_SYMBOL(kthread_stop_put);
+
 int kthreadd(void *unused)
 {
 	struct task_struct *tsk = current;
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f47d8f375946b..1992b62e980b7 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -272,8 +272,7 @@ static void smpboot_destroy_threads(struct smp_hotplug_thread *ht)
 		struct task_struct *tsk = *per_cpu_ptr(ht->store, cpu);
 
 		if (tsk) {
-			kthread_stop(tsk);
-			put_task_struct(tsk);
+			kthread_stop_put(tsk);
 			*per_cpu_ptr(ht->store, cpu) = NULL;
 		}
 	}
diff --git a/mm/damon/core.c b/mm/damon/core.c
index aff611b6eafe1..38e206075143a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -708,8 +708,7 @@ static int __damon_stop(struct damon_ctx *ctx)
 	if (tsk) {
 		get_task_struct(tsk);
 		mutex_unlock(&ctx->kdamond_lock);
-		kthread_stop(tsk);
-		put_task_struct(tsk);
+		kthread_stop_put(tsk);
 		return 0;
 	}
 	mutex_unlock(&ctx->kdamond_lock);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 4d1696677c48c..0e472f6fab853 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3982,8 +3982,7 @@ static void __net_exit pg_net_exit(struct net *net)
 	list_for_each_safe(q, n, &list) {
 		t = list_entry(q, struct pktgen_thread, th_list);
 		list_del(&t->th_list);
-		kthread_stop(t->tsk);
-		put_task_struct(t->tsk);
+		kthread_stop_put(t->tsk);
 		kfree(t);
 	}
 
-- 
2.43.0




