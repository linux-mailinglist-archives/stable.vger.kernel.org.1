Return-Path: <stable+bounces-110558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A535A1C9E8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8319818825D5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586051FAC29;
	Sun, 26 Jan 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e84pl3ES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394F1B4F0E;
	Sun, 26 Jan 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903353; cv=none; b=HLkNwxA4mt7ouzZVAcd38D+tBG0OHZYwKc01jhKkYzZsw9yBlVvhk4jRw1bDXc/KVvKZ4SKRXF/hg+5wAyEjgVrn/qTT0OR/tJ5CN4uwiD4d0LeruwyOp1viS2H6TUEURwce/QRh7ClfgZ5uL9dxmRqgQDF9LQ80lHOA4T72UO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903353; c=relaxed/simple;
	bh=ly/BdMUaVxNlKvJsf6GwQTYCCYOjN30/2pIEhO5hXnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myM+UMLcsSrExkbz8DbMTc6S2EK1bMHq96kU5h2f1Lohlv4wHmrAO8zLP9ldnnphNDpvweruoAPBsRr74TneMe/nFLQwwawA4sLUjfnod9BKK1jiYOBwrsa2fxe3WWh6PGGEgOnneoykLlVjSz+jdXtDHpuZP54nE2wv1TjcuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e84pl3ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A6C4CEE2;
	Sun, 26 Jan 2025 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903352;
	bh=ly/BdMUaVxNlKvJsf6GwQTYCCYOjN30/2pIEhO5hXnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e84pl3ESw23lyBNAll0IwGfYPgZYtppc0G56cWpkB58kZlyM3wu5z8QniWdwmXMwu
	 DyXFIIUUockybDuIGL4OhZziDIeiPInIN05KQD6edU86vaJ77z3ten47BqJ/NreEAs
	 iyOLMIbp9qtVxZvs4KplIS29RiGz1cwXXWphUlq2TpDNHDr/xN6WYkAVyoqmmdIloF
	 FJTaW56WcAsEpkCtM3bC0BDG5o/EGWIN33TY3ajkX5JcSweuacHXUsYgiaWDNEOwF/
	 n7CPOg8s00IcbbtI53uNCVCkT6ndXJwTegr6PKi0/HC2SSs/j8I/qRngRpD5yc6+eS
	 vY3j9n7XBFcXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 22/31] drm/amdkfd: Queue interrupt work to different CPU
Date: Sun, 26 Jan 2025 09:54:38 -0500
Message-Id: <20250126145448.930220-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 34db5a32617d102e8042151bb87590e43c97132e ]

For CPX mode, each KFD node has interrupt worker to process ih_fifo to
send events to user space. Currently all interrupt workers of same adev
queue to same CPU, all workers execution are actually serialized and
this cause KFD ih_fifo overflow when CPU usage is high.

Use per-GPU unbounded highpri queue with number of workers equals to
number of partitions, let queue_work select the next CPU round robin
among the local CPUs of same NUMA.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 25 ++++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 25 ++++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 ++-
 3 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b05be24531e18..d350c7ce35b3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -637,6 +637,14 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 	struct kfd_node *knode;
 	unsigned int i;
 
+	/*
+	 * flush_work ensures that there are no outstanding
+	 * work-queue items that will access interrupt_ring. New work items
+	 * can't be created because we stopped interrupt handling above.
+	 */
+	flush_workqueue(kfd->ih_wq);
+	destroy_workqueue(kfd->ih_wq);
+
 	for (i = 0; i < num_nodes; i++) {
 		knode = kfd->nodes[i];
 		device_queue_manager_uninit(knode->dqm);
@@ -1058,21 +1066,6 @@ static int kfd_resume(struct kfd_node *node)
 	return err;
 }
 
-static inline void kfd_queue_work(struct workqueue_struct *wq,
-				  struct work_struct *work)
-{
-	int cpu, new_cpu;
-
-	cpu = new_cpu = smp_processor_id();
-	do {
-		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
-		if (cpu_to_node(new_cpu) == numa_node_id())
-			break;
-	} while (cpu != new_cpu);
-
-	queue_work_on(new_cpu, wq, work);
-}
-
 /* This is called directly from KGD at ISR. */
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
@@ -1098,7 +1091,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 			    	patched_ihre, &is_patched)
 		    && enqueue_ih_ring_entry(node,
 			    	is_patched ? patched_ihre : ih_ring_entry)) {
-			kfd_queue_work(node->ih_wq, &node->interrupt_work);
+			queue_work(node->kfd->ih_wq, &node->interrupt_work);
 			spin_unlock_irqrestore(&node->interrupt_lock, flags);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 9b6b6e8825934..15b4b70cf1997 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -62,11 +62,14 @@ int kfd_interrupt_init(struct kfd_node *node)
 		return r;
 	}
 
-	node->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
-	if (unlikely(!node->ih_wq)) {
-		kfifo_free(&node->ih_fifo);
-		dev_err(node->adev->dev, "Failed to allocate KFD IH workqueue\n");
-		return -ENOMEM;
+	if (!node->kfd->ih_wq) {
+		node->kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI | WQ_UNBOUND,
+						   node->kfd->num_nodes);
+		if (unlikely(!node->kfd->ih_wq)) {
+			kfifo_free(&node->ih_fifo);
+			dev_err(node->adev->dev, "Failed to allocate KFD IH workqueue\n");
+			return -ENOMEM;
+		}
 	}
 	spin_lock_init(&node->interrupt_lock);
 
@@ -96,16 +99,6 @@ void kfd_interrupt_exit(struct kfd_node *node)
 	spin_lock_irqsave(&node->interrupt_lock, flags);
 	node->interrupts_active = false;
 	spin_unlock_irqrestore(&node->interrupt_lock, flags);
-
-	/*
-	 * flush_work ensures that there are no outstanding
-	 * work-queue items that will access interrupt_ring. New work items
-	 * can't be created because we stopped interrupt handling above.
-	 */
-	flush_workqueue(node->ih_wq);
-
-	destroy_workqueue(node->ih_wq);
-
 	kfifo_free(&node->ih_fifo);
 }
 
@@ -162,7 +155,7 @@ static void interrupt_wq(struct work_struct *work)
 			/* If we spent more than a second processing signals,
 			 * reschedule the worker to avoid soft-lockup warnings
 			 */
-			queue_work(dev->ih_wq, &dev->interrupt_work);
+			queue_work(dev->kfd->ih_wq, &dev->interrupt_work);
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 26e48fdc87289..75523f30cd38b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -273,7 +273,6 @@ struct kfd_node {
 
 	/* Interrupts */
 	struct kfifo ih_fifo;
-	struct workqueue_struct *ih_wq;
 	struct work_struct interrupt_work;
 	spinlock_t interrupt_lock;
 
@@ -366,6 +365,8 @@ struct kfd_dev {
 	struct kfd_node *nodes[MAX_KFD_NODES];
 	unsigned int num_nodes;
 
+	struct workqueue_struct *ih_wq;
+
 	/* Kernel doorbells for KFD device */
 	struct amdgpu_bo *doorbells;
 
-- 
2.39.5


