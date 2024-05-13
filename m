Return-Path: <stable+bounces-43659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323408C4272
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D501F21312
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA646153571;
	Mon, 13 May 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tTRIhmp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADF15356A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607974; cv=none; b=lhADziQbtQKvpjJyXi3v3N+RkUwJXykXGCvcQCvmXyzGCbRF0rgxLUDG4CTQ8+dN02cFyUEOzCdVLx002yra5QDx0J3BwMKmS/TbblpekNpALm+dSw6djFjP/Pn1BT9mVLqExjRrWfYU/mjEALg+8HRkZEyBWxImqKlmsN6nsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607974; c=relaxed/simple;
	bh=Jqi4TIUm1n4EhmNL+1L0+dBHy4N578CMk7u+yn5Qyq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UtWIT8sSwGynKJrxWYOPIGbUhYG/BsxFLUBKEmBZ3/k3mB1o6ld3fizI+OaGDkBPAObQHzVf49/RxJcWOBEN/qad64op/zBhsMrFFtlAeBflBkuXnFCZT2jjoxeJVMkJq36UbXXXr2loxcscB0/7UXKoGwND4YOeLlyrGW+3SKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tTRIhmp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3BFC4AF07;
	Mon, 13 May 2024 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607974;
	bh=Jqi4TIUm1n4EhmNL+1L0+dBHy4N578CMk7u+yn5Qyq8=;
	h=Subject:To:Cc:From:Date:From;
	b=tTRIhmp2hq4WleX8QXDBxdYUi0Hh4Pigt5DclhzvbwKXzuZd2sECeAiGctCdIawD3
	 VpNsGbREBVtg6CYirmfpY4E/wi5H+oixEc051JOHDWP8TIALDQIL0QpfcWXmnogWxP
	 BsvTV6ZFe+WHr1Vc/+dC910+I32q+EppK5jgl7rQ=
Subject: FAILED: patch "[PATCH] drm/xe: Use ordered WQ for G2H handler" failed to apply to 6.8-stable tree
To: matthew.brost@intel.com,francois.dugast@intel.com,lucas.demarchi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:46:11 +0200
Message-ID: <2024051310-legacy-papaya-0d01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x c002bfe644a29ba600c571f2abba13a155a12dcd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051310-legacy-papaya-0d01@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

c002bfe644a2 ("drm/xe: Use ordered WQ for G2H handler")
7bd9c9f962eb ("drm/xe/guc: Check error code when initializing the CT mutex")
5030e16140b6 ("drm/xe/guc: Only take actions in CT irq handler if CTs are enabled")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c002bfe644a29ba600c571f2abba13a155a12dcd Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 50aec9665e0babd62b9eee4e613d9a1ef8d2b7de)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index c62dbd6420db..8bbfa45798e2 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -120,6 +120,7 @@ static void guc_ct_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	destroy_workqueue(ct->g2h_wq);
 	xa_destroy(&ct->fence_lookup);
 }
 
@@ -145,6 +146,10 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
 
 	xe_assert(xe, !(guc_ct_size() % PAGE_SIZE));
 
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


