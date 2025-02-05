Return-Path: <stable+bounces-112509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95EA28D18
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D5118895C0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587C14F9E7;
	Wed,  5 Feb 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HIK6Ecgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEC14B942;
	Wed,  5 Feb 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763805; cv=none; b=JXM3kLVPTdaJlFwYPQRrsFl6PiZlyMfGIsm61W5151bRe1YDhLyqiG78TXHt7a8n7alrFA07mwGIHUDJcTMYld3wSkXxSRUVDOgEETfV2PJdFc0eT7WqQNNzoZZ3sWEbDYvXm0vQPd4utTN8L+X2SeyfPbd2WWtv2QYKqk4OFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763805; c=relaxed/simple;
	bh=RzYeR52BkUsiFwRjeGQA9+DWmaWPprzfhWhuxx+5g5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYcoNk2mpmSX9e/VFs4XE69HySKTQ5xnZth/ffzOUz5SLlv5hCsZxjPSOfdrSX6NYEBcfcUSxTklhc39lzw+0Kf09mo+5gycemf+Yc4MRStdangWcOjpRZO/PeUT2K7LWSJF7FzfOuhIgTGwRDk1QBBkX6XlKbxWm2ysRDGHwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HIK6Ecgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A2C4CED1;
	Wed,  5 Feb 2025 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763805;
	bh=RzYeR52BkUsiFwRjeGQA9+DWmaWPprzfhWhuxx+5g5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIK6EcgfIOkV13Lav+hTzoQVvwBTUFEVWbdRIjIJqw+RQ8scyI7dkQvGDPyIk011T
	 OyA7XAoZpmgR8PlsrAUQ69Y7P8vHIyS/wp78wSQgaLA+EL+mQarLOp84nP8Hk+y2he
	 sRofaU3GSvLjwVzg+4QnfVMsdOUVAyhvnTN2D8Ps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 020/623] nvme-tcp: Fix I/O queue cpu spreading for multiple controllers
Date: Wed,  5 Feb 2025 14:36:02 +0100
Message-ID: <20250205134457.001394229@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 32193789878c259e39b97bd0c0f2f0ccbe5cb8a8 ]

Since day-1 we are assigning the queue io_cpu very naively. We always
base the queue id (controller scope) and assign it its matching cpu
from the online mask. This works fine when the number of queues match
the number of cpu cores.

The problem starts when we have less queues than cpu cores. First, we
should take into account the mq_map and select a cpu within the cpus
that are assigned to this queue by the mq_map in order to minimize cross
numa cpu bouncing.

Second, even worse is that we don't take into account multiple
controllers may have assigned queues to a given cpu. As a result we may
simply compund more and more queues on the same set of cpus, which is
suboptimal.

We fix this by introducing global per-cpu counters that tracks the
number of queues assigned to each cpu, and we select the least used cpu
based on the mq_map and the per-cpu counters, and assign it as the queue
io_cpu.

The behavior for a single controller is slightly optimized by selecting
better cpu candidates by consulting with the mq_map, and multiple
controllers are spreading queues among cpu cores much better, resulting
in lower average cpu load, and less likelihood to hit hotspots.

Note that the accounting is not 100% perfect, but we don't need to be,
we're simply putting our best effort to select the best candidate cpu
core that we find at any given point.

Another byproduct is that every controller reset/reconnect may change
the queues io_cpu mapping, based on the current LRU accounting scheme.

Here is the baseline queue io_cpu assignment for 4 controllers, 2 queues
per controller, and 4 cpus on the host:
nvme1: queue 0: using cpu 0
nvme1: queue 1: using cpu 1
nvme2: queue 0: using cpu 0
nvme2: queue 1: using cpu 1
nvme3: queue 0: using cpu 0
nvme3: queue 1: using cpu 1
nvme4: queue 0: using cpu 0
nvme4: queue 1: using cpu 1

And this is the fixed io_cpu assignment:
nvme1: queue 0: using cpu 0
nvme1: queue 1: using cpu 2
nvme2: queue 0: using cpu 1
nvme2: queue 1: using cpu 3
nvme3: queue 0: using cpu 0
nvme3: queue 1: using cpu 2
nvme4: queue 0: using cpu 1
nvme4: queue 1: using cpu 3

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Suggested-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[fixed kbuild reported errors]
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 70 +++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b127d41dbbfee..841238f38fdda 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -54,6 +54,8 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -127,6 +129,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_IO_CPU_SET	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -1562,23 +1565,56 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
+/**
+ * Track the number of queues assigned to each cpu using a global per-cpu
+ * counter and select the least used cpu from the mq_map. Our goal is to spread
+ * different controllers I/O threads across different cpu cores.
+ *
+ * Note that the accounting is not 100% perfect, but we don't need to be, we're
+ * simply putting our best effort to select the best candidate cpu core that we
+ * find at any given point.
+ */
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
-	int n = 0;
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map = NULL;
+	int cpu, min_queues = INT_MAX, io_cpu;
+
+	if (wq_unbound)
+		goto out;
 
 	if (nvme_tcp_default_queue(queue))
-		n = qid - 1;
+		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
 	else if (nvme_tcp_read_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
+		mq_map = set->map[HCTX_TYPE_READ].mq_map;
 	else if (nvme_tcp_poll_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
-				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	if (wq_unbound)
-		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
+
+	if (WARN_ON(!mq_map))
+		goto out;
+
+	/* Search for the least used cpu from the mq_map */
+	io_cpu = WORK_CPU_UNBOUND;
+	for_each_online_cpu(cpu) {
+		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+
+		if (mq_map[cpu] != qid)
+			continue;
+		if (num_queues < min_queues) {
+			io_cpu = cpu;
+			min_queues = num_queues;
+		}
+	}
+	if (io_cpu != WORK_CPU_UNBOUND) {
+		queue->io_cpu = io_cpu;
+		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
+		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
+	}
+out:
+	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+		qid, queue->io_cpu);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1722,7 +1758,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1844,6 +1880,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
@@ -1878,9 +1917,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
+		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+	} else
 		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
@@ -2845,6 +2885,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -2862,6 +2903,9 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu)
+		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
-- 
2.39.5




