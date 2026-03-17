Return-Path: <stable+bounces-225921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGfuHPVOuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:54:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 077EA2AA310
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6D9309605A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE23C5DB8;
	Tue, 17 Mar 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07Ji8JZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA73C5528
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751930; cv=none; b=cxroT6JWpeehTFmMXZEGwITF/ABdl9Rr26fSb0fl4wpj2Y1wZx96CRMNNKxQQCovwXv5DMGH2uRbx5ELCrT04Z2BjoB2fSMUfuD7I6yEIEjPD8PpaqjiAcm1nPY0FdEyxPmlYF25hvhnY3Qu38Umkb2I8GJCIJQqCxM883y82I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751930; c=relaxed/simple;
	bh=u2UP79730UWo1VDjGGKtF8/P51/AkW6QNtJhsfZDxfk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CSpEKLmyTEfYSer8yl+AEE3irxa9gL80tTLtLDpJxFBufH2TD6S5maBL3x0X+4c6SbKrYnbAmVLjqaGDcwzeM37L62rBohs6YxMrAJeaDFs+1WVgbXcGV8C5bQFslaHGMFzpt3PXk2O4M6mLXooq4qt0uMP1qOLgvrR6zTtAJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=07Ji8JZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C798C4CEF7;
	Tue, 17 Mar 2026 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751929;
	bh=u2UP79730UWo1VDjGGKtF8/P51/AkW6QNtJhsfZDxfk=;
	h=Subject:To:Cc:From:Date:From;
	b=07Ji8JZsZTpMaJTJOee+5e7sVWUJOyzvtQEZNb4plOf4ZJVcOhzb+wkVqg7rdbJL2
	 uyTtIWdXw7JokQ8se9DlfwGhscKnl2iJftYA9ZLwfPVhalfz4dUznvMRrCpxJVjLBp
	 5ix5u2sqejwE4Kz4HQuNvhC2EpfA2qDI3fQ66v/E=
Subject: FAILED: patch "[PATCH] drm/amdgpu/userq: refcount userqueues to avoid any race" failed to apply to 6.6-stable tree
To: sunil.khatri@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:51:56 +0100
Message-ID: <2026031756-dolly-salami-999b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225921-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 077EA2AA310
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 65b5c326ce4103620c977b8dcb1699bdac4da143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031756-dolly-salami-999b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65b5c326ce4103620c977b8dcb1699bdac4da143 Mon Sep 17 00:00:00 2001
From: Sunil Khatri <sunil.khatri@amd.com>
Date: Mon, 2 Mar 2026 18:50:46 +0530
Subject: [PATCH] drm/amdgpu/userq: refcount userqueues to avoid any race
 conditions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To avoid race condition and avoid UAF cases, implement kref
based queues and protect the below operations using xa lock
a. Getting a queue from xarray
b. Increment/Decrement it's refcount

Every time some one want to access a queue, always get via
amdgpu_userq_get to make sure we have locks in place and get
the object if active.

A userqueue is destroyed on the last refcount is dropped which
typically would be via IOCTL or during fini.

v2: Add the missing drop in one the condition in the signal ioclt [Alex]

v3: remove the queue from the xarray first in the free queue ioctl path
    [Christian]

- Pass queue to the amdgpu_userq_put directly.
- make amdgpu_userq_put xa_lock free since we are doing put for each get
  only and final put is done via destroy and we remove the queue from xa
  with lock.
- use userq_put in fini too so cleanup is done fully.

v4: Use xa_erase directly rather than doing load and erase in free
    ioctl. Also remove some of the error logs which could be exploited
    by the user to flood the logs [Christian]

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4952189b284d4d847f92636bb42dd747747129c0)
Cc: <stable@vger.kernel.org> # 048c1c4e5171: drm/amdgpu/userq: Consolidate wait ioctl exit path
Cc: <stable@vger.kernel.org>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9d67b770bcc2..7c450350847d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 	return ret;
 }
 
-static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
-				 int queue_id)
+static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -461,7 +460,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 	uq_funcs->mqd_destroy(queue);
 	amdgpu_userq_fence_driver_free(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
-	xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
@@ -470,12 +468,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 	up_read(&adev->reset_domain->sem);
 }
 
-static struct amdgpu_usermode_queue *
-amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
-{
-	return xa_load(&uq_mgr->userq_xa, qid);
-}
-
 void
 amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 			     struct amdgpu_eviction_fence_mgr *evf_mgr)
@@ -625,22 +617,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int
-amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
+amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	struct amdgpu_usermode_queue *queue;
 	int r = 0;
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
-	queue = amdgpu_userq_find(uq_mgr, queue_id);
-	if (!queue) {
-		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
-		mutex_unlock(&uq_mgr->userq_mutex);
-		return -EINVAL;
-	}
 	amdgpu_userq_wait_for_last_fence(queue);
 	/* Cancel any pending hang detection work and cleanup */
 	if (queue->hang_detect_fence) {
@@ -672,7 +655,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
-	amdgpu_userq_cleanup(queue, queue_id);
+	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -680,6 +663,37 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	return r;
 }
 
+static void amdgpu_userq_kref_destroy(struct kref *kref)
+{
+	int r;
+	struct amdgpu_usermode_queue *queue =
+		container_of(kref, struct amdgpu_usermode_queue, refcount);
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+
+	r = amdgpu_userq_destroy(uq_mgr, queue);
+	if (r)
+		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
+}
+
+struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
+{
+	struct amdgpu_usermode_queue *queue;
+
+	xa_lock(&uq_mgr->userq_xa);
+	queue = xa_load(&uq_mgr->userq_xa, qid);
+	if (queue)
+		kref_get(&queue->refcount);
+	xa_unlock(&uq_mgr->userq_xa);
+
+	return queue;
+}
+
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
+{
+	if (queue)
+		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
+}
+
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
 					int priority)
 {
@@ -834,6 +848,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* drop this refcount during queue destroy */
+	kref_init(&queue->refcount);
+
 	/* Wait for mode-1 reset to complete */
 	down_read(&adev->reset_domain->sem);
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
@@ -985,7 +1002,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
 	union drm_amdgpu_userq *args = data;
-	int r;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_usermode_queue *queue;
+	int r = 0;
 
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
@@ -1000,11 +1019,16 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
-	case AMDGPU_USERQ_OP_FREE:
-		r = amdgpu_userq_destroy(filp, args->in.queue_id);
-		if (r)
-			drm_file_err(filp, "Failed to destroy usermode queue\n");
+	case AMDGPU_USERQ_OP_FREE: {
+		xa_lock(&fpriv->userq_mgr.userq_xa);
+		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
+		xa_unlock(&fpriv->userq_mgr.userq_xa);
+		if (!queue)
+			return -ENOENT;
+
+		amdgpu_userq_put(queue);
 		break;
+	}
 
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
@@ -1023,16 +1047,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		queue = amdgpu_userq_get(uq_mgr, queue_id);
+		if (!queue)
+			continue;
+
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			amdgpu_userq_put(queue);
 			continue;
 		}
 
 		r = amdgpu_userq_restore_helper(queue);
 		if (r)
 			ret = r;
+
+		amdgpu_userq_put(queue);
 	}
 
 	if (ret)
@@ -1266,9 +1297,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		queue = amdgpu_userq_get(uq_mgr, queue_id);
+		if (!queue)
+			continue;
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
+		amdgpu_userq_put(queue);
 	}
 
 	if (ret)
@@ -1301,16 +1336,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	int ret;
 
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		queue = amdgpu_userq_get(uq_mgr, queue_id);
+		if (!queue)
+			continue;
+
 		struct dma_fence *f = queue->last_fence;
 
-		if (!f || dma_fence_is_signaled(f))
+		if (!f || dma_fence_is_signaled(f)) {
+			amdgpu_userq_put(queue);
 			continue;
+		}
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			amdgpu_userq_put(queue);
 			return -ETIMEDOUT;
 		}
+		amdgpu_userq_put(queue);
 	}
 
 	return 0;
@@ -1361,20 +1404,23 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 
-	cancel_delayed_work_sync(&userq_mgr->resume_work);
+	for (;;) {
+		xa_lock(&userq_mgr->userq_xa);
+		queue = xa_find(&userq_mgr->userq_xa, &queue_id, ULONG_MAX,
+				XA_PRESENT);
+		if (queue)
+			__xa_erase(&userq_mgr->userq_xa, queue_id);
+		xa_unlock(&userq_mgr->userq_xa);
 
-	mutex_lock(&userq_mgr->userq_mutex);
-	amdgpu_userq_detect_and_reset_queues(userq_mgr);
-	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
-		amdgpu_userq_wait_for_last_fence(queue);
-		amdgpu_userq_unmap_helper(queue);
-		amdgpu_userq_cleanup(queue, queue_id);
+		if (!queue)
+			break;
+
+		amdgpu_userq_put(queue);
 	}
 
 	xa_destroy(&userq_mgr->userq_xa);
-	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5845d8959034..736c1d38297c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
 	struct dentry		*debugfs_queue;
 	struct delayed_work hang_detect_work;
 	struct dma_fence *hang_detect_fence;
+	struct kref		refcount;
 
 	struct list_head	userq_va_list;
 };
@@ -112,6 +113,9 @@ struct amdgpu_db_info {
 	struct amdgpu_userq_obj	*db_obj;
 };
 
+struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 77969a6017a4..5239b06b9ab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -466,7 +466,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct drm_amdgpu_userq_signal *args = data;
 	struct drm_gem_object **gobj_write = NULL;
 	struct drm_gem_object **gobj_read = NULL;
-	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_usermode_queue *queue = NULL;
 	struct amdgpu_userq_fence *userq_fence;
 	struct drm_syncobj **syncobj = NULL;
 	u32 *bo_handles_write, num_write_bo_handles;
@@ -553,7 +553,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Retrieve the user queue */
-	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
+	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
 		goto put_gobj_write;
@@ -648,6 +648,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 free_syncobj_handles:
 	kfree(syncobj_handles);
 
+	if (queue)
+		amdgpu_userq_put(queue);
+
 	return r;
 }
 
@@ -660,7 +663,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	struct drm_amdgpu_userq_wait *wait_info = data;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_usermode_queue *waitq;
+	struct amdgpu_usermode_queue *waitq = NULL;
 	struct drm_gem_object **gobj_write;
 	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
@@ -926,7 +929,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
+		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
 		if (!waitq) {
 			r = -EINVAL;
 			goto free_fences;
@@ -1014,5 +1017,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 free_bo_handles_read:
 	kfree(bo_handles_read);
 
+	if (waitq)
+		amdgpu_userq_put(waitq);
+
 	return r;
 }


