Return-Path: <stable+bounces-161351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D83AFD751
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7686B484F5D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDC2222C3;
	Tue,  8 Jul 2025 19:42:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C5223DCE
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003758; cv=none; b=oeDuf/oSaAYLcbMwhmaKfvhh+vBxnMMMftnE/kVOvVzqDWzp5gfFt6ocnJquWXh1o8D4GwOsu4eA8F97twSJhiuGjXm9pU233FkyP3ARvuLdhL7B/RoeqSk/zsNBI8sP+1Tsl2CeLDqIkIgR5pCUbnkvMIXaDfnRVC8Yt9qk8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003758; c=relaxed/simple;
	bh=Tcpe/wiU9omEHjRSutp5DVMg/u547EhMwy9kv0EZHYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNGA4Phs8wKHKDvFJUXwsKWUj8IAUEU/iC3rUiG9vYVaHXU05I9CAgbdUkR2BoNE93IRiQXBtZWeS2d74IDjDgJP6c6vyf79Q0qtV6C3mLLn10R7jixxhU3I4Ul37oJfEqak9y1U9mSz0A9BuokJjc8Yh6p1rrOYNCohYEAWwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0EE152B;
	Tue,  8 Jul 2025 12:42:24 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6E413F66E;
	Tue,  8 Jul 2025 12:42:34 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Forissier?= <jerome.forissier@linaro.org>
Subject: [BACKPORT][PATCH 6.12.y 2/2] firmware: arm_ffa: Replace mutex with rwlock to avoid sleep in atomic context
Date: Tue,  8 Jul 2025 20:42:23 +0100
Message-Id: <20250708194223.937108-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708194223.937108-1-sudeep.holla@arm.com>
References: <20250708194223.937108-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 9ca7a421229bbdfbe2e1e628cff5cfa782720a10 ]

The current use of a mutex to protect the notifier hashtable accesses
can lead to issues in the atomic context. It results in the below
kernel warnings:

  |  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:258
  |  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9, name: kworker/0:0
  |  preempt_count: 1, expected: 0
  |  RCU nest depth: 0, expected: 0
  |  CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.14.0 #4
  |  Workqueue: ffa_pcpu_irq_notification notif_pcpu_irq_work_fn
  |  Call trace:
  |   show_stack+0x18/0x24 (C)
  |   dump_stack_lvl+0x78/0x90
  |   dump_stack+0x18/0x24
  |   __might_resched+0x114/0x170
  |   __might_sleep+0x48/0x98
  |   mutex_lock+0x24/0x80
  |   handle_notif_callbacks+0x54/0xe0
  |   notif_get_and_handle+0x40/0x88
  |   generic_exec_single+0x80/0xc0
  |   smp_call_function_single+0xfc/0x1a0
  |   notif_pcpu_irq_work_fn+0x2c/0x38
  |   process_one_work+0x14c/0x2b4
  |   worker_thread+0x2e4/0x3e0
  |   kthread+0x13c/0x210
  |   ret_from_fork+0x10/0x20

To address this, replace the mutex with an rwlock to protect the notifier
hashtable accesses. This ensures that read-side locking does not sleep and
multiple readers can acquire the lock concurrently, avoiding unnecessary
contention and potential deadlocks. Writer access remains exclusive,
preserving correctness.

This change resolves warnings from lockdep about potential sleep in
atomic context.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Reported-by: Jérôme Forissier <jerome.forissier@linaro.org>
Closes: https://github.com/OP-TEE/optee_os/issues/7394
Fixes: e0573444edbf ("firmware: arm_ffa: Add interfaces to request notification callbacks")
Message-Id: <20250528-ffa_notif_fix-v1-3-5ed7bc7f8437@arm.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b0d92f411334..83dad9c2da06 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -110,7 +110,7 @@ struct ffa_drv_info {
 	struct work_struct sched_recv_irq_work;
 	struct xarray partition_info;
 	DECLARE_HASHTABLE(notifier_hash, ilog2(FFA_MAX_NOTIFICATIONS));
-	struct mutex notify_lock; /* lock to protect notifier hashtable  */
+	rwlock_t notify_lock; /* lock to protect notifier hashtable  */
 };
 
 static struct ffa_drv_info *drv_info;
@@ -1182,18 +1182,18 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 	if (notify_id >= FFA_MAX_NOTIFICATIONS)
 		return -EINVAL;
 
-	mutex_lock(&drv_info->notify_lock);
+	write_lock(&drv_info->notify_lock);
 
 	rc = update_notifier_cb(notify_id, type, NULL);
 	if (rc) {
 		pr_err("Could not unregister notification callback\n");
-		mutex_unlock(&drv_info->notify_lock);
+		write_unlock(&drv_info->notify_lock);
 		return rc;
 	}
 
 	rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 
-	mutex_unlock(&drv_info->notify_lock);
+	write_unlock(&drv_info->notify_lock);
 
 	return rc;
 }
@@ -1220,7 +1220,7 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	cb_info->cb_data = cb_data;
 	cb_info->cb = cb;
 
-	mutex_lock(&drv_info->notify_lock);
+	write_lock(&drv_info->notify_lock);
 
 	if (is_per_vcpu)
 		flags = PER_VCPU_NOTIFICATION_FLAG;
@@ -1237,7 +1237,7 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	}
 
 out_unlock_free:
-	mutex_unlock(&drv_info->notify_lock);
+	write_unlock(&drv_info->notify_lock);
 	if (rc)
 		kfree(cb_info);
 
@@ -1269,9 +1269,9 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 		if (!(bitmap & 1))
 			continue;
 
-		mutex_lock(&drv_info->notify_lock);
+		read_lock(&drv_info->notify_lock);
 		cb_info = notifier_hash_node_get(notify_id, type);
-		mutex_unlock(&drv_info->notify_lock);
+		read_unlock(&drv_info->notify_lock);
 
 		if (cb_info && cb_info->cb)
 			cb_info->cb(notify_id, cb_info->cb_data);
@@ -1721,7 +1721,7 @@ static void ffa_notifications_setup(void)
 		goto cleanup;
 
 	hash_init(drv_info->notifier_hash);
-	mutex_init(&drv_info->notify_lock);
+	rwlock_init(&drv_info->notify_lock);
 
 	drv_info->notif_enabled = true;
 	return;
-- 
2.34.1


