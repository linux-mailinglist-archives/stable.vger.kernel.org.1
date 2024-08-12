Return-Path: <stable+bounces-66509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3994ECB0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A641F23126
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1023A16DEBB;
	Mon, 12 Aug 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOmPRCaa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DA178CE2
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465024; cv=none; b=GQwnfpHrQj201030j0ZvbFZbdDAfIFtw6yJP4xgvJfNOk/kMelTRMHKJUPt2bjbfmONNxPh3FeJgTQp9TjLtMAXW2khnFMVbp2lk0+KaxlomheJ1PTcrQcnSI8SSetxTn4FQS2tslM8keJz+GbO0DCfUS0w9+aZKl+7bOYLgcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465024; c=relaxed/simple;
	bh=clUxUazoqmvt/uU+CTW3zdj+C2GtEJMbitkxm7dzVqI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IX6AlIeBDvrswMsHsRfgC1ABIjM4QB/Gr44b6DXlPZ/KpdkhBAtb6jLStj3QJUH/JaPGbpzqadSRQuK5YQes8aS6Pf7+j5XKatZr6pC9wSe/wy+VYG3xx34zXrsMgzewFc90nZQTtQJyVZFfvbh+R0uighY3oiIhh/RKXw2XiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOmPRCaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BE5C32782;
	Mon, 12 Aug 2024 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465024;
	bh=clUxUazoqmvt/uU+CTW3zdj+C2GtEJMbitkxm7dzVqI=;
	h=Subject:To:Cc:From:Date:From;
	b=wOmPRCaaSe9DobGDqoYVWI+LGr0N7vlUzpsmmWqpu+p/TYnleri8w99rLkEUFuvDt
	 fjTc+smUnrnsLLn2h2Hq5uUvPzVs+El6VkgURujKvZWcCKhOcFk22FLTcY7tIn7j/J
	 +5SJR8VZy3RyRzgI3Qs5dEGu5+IJWEoXhRiOnfII=
Subject: FAILED: patch "[PATCH] drm/xe: Use ordered WQ for G2H handler" failed to apply to 6.10-stable tree
To: matthew.brost@intel.com,francois.dugast@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:17:01 +0200
Message-ID: <2024081201-impotent-presoak-2c6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081201-impotent-presoak-2c6d@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

50aec9665e0b ("drm/xe: Use ordered WQ for G2H handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Sun, 5 May 2024 20:47:58 -0700
Subject: [PATCH] drm/xe: Use ordered WQ for G2H handler

System work queues are shared, use a dedicated work queue for G2H
processing to avoid G2H processing getting block behind system tasks.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Francois Dugast <francois.dugast@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240506034758.3697397-1-matthew.brost@intel.com

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 8ac819a7061e..0151d29b3c58 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -121,6 +121,7 @@ static void guc_ct_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	destroy_workqueue(ct->g2h_wq);
 	xa_destroy(&ct->fence_lookup);
 }
 
@@ -146,6 +147,10 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
 
 	xe_gt_assert(gt, !(guc_ct_size() % PAGE_SIZE));
 
+	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", 0);
+	if (!ct->g2h_wq)
+		return -ENOMEM;
+
 	spin_lock_init(&ct->fast_lock);
 	xa_init(&ct->fence_lookup);
 	INIT_WORK(&ct->g2h_worker, g2h_worker_func);
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index 5083e099064f..105bb8e99a8d 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -34,7 +34,7 @@ static inline void xe_guc_ct_irq_handler(struct xe_guc_ct *ct)
 		return;
 
 	wake_up_all(&ct->wq);
-	queue_work(system_unbound_wq, &ct->g2h_worker);
+	queue_work(ct->g2h_wq, &ct->g2h_worker);
 	xe_guc_ct_fast_path(ct);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ct_types.h b/drivers/gpu/drm/xe/xe_guc_ct_types.h
index d29144c9f20b..fede4c6e93cb 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct_types.h
@@ -120,6 +120,8 @@ struct xe_guc_ct {
 	wait_queue_head_t wq;
 	/** @g2h_fence_wq: wait queue used for G2H fencing */
 	wait_queue_head_t g2h_fence_wq;
+	/** @g2h_wq: used to process G2H */
+	struct workqueue_struct *g2h_wq;
 	/** @msg: Message buffer */
 	u32 msg[GUC_CTB_MSG_MAX_LEN];
 	/** @fast_msg: Message buffer */


