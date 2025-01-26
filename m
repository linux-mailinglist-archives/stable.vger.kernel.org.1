Return-Path: <stable+bounces-110527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02747A1C9B0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2105F1887F2B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F91F560D;
	Sun, 26 Jan 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDD83mlg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6A1A9B48;
	Sun, 26 Jan 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903268; cv=none; b=l2hqeCaru2YdGAaPbnQ2I0wCc29KQhqavAN57gWTQgtyqm64LrMdnzx67ThYGuCylsRRleedN22MPFbtxMd40FKG8o7kKpkwF1rkNqCrLB030MuAkBH2GciFvDx+uNzQKiZyrIqFnFPYKY/DwQ4Dl2CzC1OLeG0asska/Ro2e/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903268; c=relaxed/simple;
	bh=jr+njAPJPtrffhbrexdXiHtdDn4WQiC8q9V5BBCE4Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEta5H5jSaTAMCiNIUKPLDmCCN+2CHzd2B1q2p4Xy8V+M/4Q/EXGiXdCi3FthGdYwTlBUPCS6sBOwHoqXF80FcKleDF1Of/KDur3uSY1HXhHYmJLzy6HI9CIMXheVtYXPiNjYHas15jCZ9rz+0kjrR9DV2pyqqlHMO05IuaJxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDD83mlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10054C4CED3;
	Sun, 26 Jan 2025 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903268;
	bh=jr+njAPJPtrffhbrexdXiHtdDn4WQiC8q9V5BBCE4Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDD83mlgyKDs4i/n3qvS19ASWQXhFpp6PcAs2dyj3tJKoi2HKijMeYvnbA6y4918l
	 SIuo9ht05rSZziVhH4MEmUahXsKURbLOhiVEK+xBHbmGTgZoDtSJneVAIEwlMBuHyN
	 TZ7LkhkXM/iH2KQZ8M7Fo8WThYobO72sJaZF0iVb81n3WozvABEOeBCSa3N1NiO1ES
	 D2S+MxdUW4SR5gLWUvwkf7sczTxP5wI89IRtExjdWOPiewZgCY/MO9pCpgutBBwQRG
	 1jhkp8kSE7nUe77r/fegnc2NyeYhri66lSzJm+yxxK/9PJqsjrVzu7EIiqkh0XmQLG
	 EZKzLZWPDDPfA==
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
Subject: [PATCH AUTOSEL 6.13 25/34] drm/amdkfd: Queue interrupt work to different CPU
Date: Sun, 26 Jan 2025 09:53:01 -0500
Message-Id: <20250126145310.926311-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 9b51dd75fefc7..35caa71f317dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -638,6 +638,14 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
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
@@ -1059,21 +1067,6 @@ static int kfd_resume(struct kfd_node *node)
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
@@ -1099,7 +1092,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
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
index 9e5ca0b93b2a2..74881a5ca59ad 100644
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


