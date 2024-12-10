Return-Path: <stable+bounces-100355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63819EABF0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C32161B76
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A67233D96;
	Tue, 10 Dec 2024 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsC7lDi0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E392327A8
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822866; cv=none; b=aqOVbiBIHB0SNfGWJySr3IhgkeYLsbhKzhyLsJIT39zZQTOO2Idz6sY2w18n1790afOXteb11KHV+KUB+s8+ypRMxFM+uVmcyyUCai4DPA6bddxCYj4xjFGj8tYEAVjrqT7mcnYy22hsnpl2LrZBXqMxJMAMNWszm/KEbPml1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822866; c=relaxed/simple;
	bh=B7V8J7zmFQETDCiqIYljaGq3fjv4aSZLd/XSONB8H8E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hgUbyQ+14aOl0umkbckYSzNFpAjAQwBKi+n+XiYohBQk8JSoDCcZir7Rxq3fDRLWs7fsBLLF0Ln6oAMzKYUOKBfOPEvloObtPPEpbrQBnpBtP6J3eEI8JmT8BUK92sWl4E0g5wkKxhC1kBlQ0gk1T67osHedXvnTLUbnrcOiH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsC7lDi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35569C4CEDD;
	Tue, 10 Dec 2024 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822865;
	bh=B7V8J7zmFQETDCiqIYljaGq3fjv4aSZLd/XSONB8H8E=;
	h=Subject:To:Cc:From:Date:From;
	b=HsC7lDi0JqwYdzy1vX8qUceXqsMTXgx6RU+X4lBvLcsr8AVGvmjmeDhdK3EbGISbA
	 UX7MJZWHYYHGIiwnGv+9PeP0hqe/FiXmou60hNnynEYNrwk+QPx9sfij4hNv609Q+T
	 eq/SWXEAMrF8gvfw1vZY9PNK+vrk17XkXYOXPtlI=
Subject: FAILED: patch "[PATCH] drm/xe: Move the coredump registration to the worker thread" failed to apply to 6.12-stable tree
To: John.C.Harrison@Intel.com,christian.koenig@amd.com,daniel.vetter@ffwll.ch,francois.dugast@intel.com,jani.nikula@linux.intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org,sumit.semwal@linaro.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:27:09 +0100
Message-ID: <2024121009-unusable-patronage-0895@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5dce85fecb87751ec94526e1ac516dd7871e2e0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121009-unusable-patronage-0895@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5dce85fecb87751ec94526e1ac516dd7871e2e0c Mon Sep 17 00:00:00 2001
From: John Harrison <John.C.Harrison@Intel.com>
Date: Thu, 28 Nov 2024 13:08:23 -0800
Subject: [PATCH] drm/xe: Move the coredump registration to the worker thread
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding lockdep checking to the coredump code showed that there was an
existing violation. The dev_coredumpm_timeout() call is used to
register the dump with the base coredump subsystem. However, that
makes multiple memory allocations, only some of which use the GFP_
flags passed in. So that also needs to be deferred to the worker
function where it is safe to allocate with arbitrary flags.

In order to not add protoypes for the callback functions, moving the
_timeout call also means moving the worker thread function to later in
the file.

v2: Rebased after other changes to the worker function.

Fixes: e799485044cb ("drm/xe: Introduce the dev_coredump infrastructure.")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: intel-xe@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241128210824.3302147-3-John.C.Harrison@Intel.com
(cherry picked from commit 90f51a7f4ec1004fc4ddfbc6d1f1068d85ef4771)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 0b0cd6aa1d9f..f8947e7e917e 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -155,36 +155,6 @@ static void xe_devcoredump_snapshot_free(struct xe_devcoredump_snapshot *ss)
 	ss->vm = NULL;
 }
 
-static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
-{
-	struct xe_devcoredump_snapshot *ss = container_of(work, typeof(*ss), work);
-	struct xe_devcoredump *coredump = container_of(ss, typeof(*coredump), snapshot);
-	struct xe_device *xe = coredump_to_xe(coredump);
-	unsigned int fw_ref;
-
-	xe_pm_runtime_get(xe);
-
-	/* keep going if fw fails as we still want to save the memory and SW data */
-	fw_ref = xe_force_wake_get(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
-		xe_gt_info(ss->gt, "failed to get forcewake for coredump capture\n");
-	xe_vm_snapshot_capture_delayed(ss->vm);
-	xe_guc_exec_queue_snapshot_capture_delayed(ss->ge);
-	xe_force_wake_put(gt_to_fw(ss->gt), fw_ref);
-
-	xe_pm_runtime_put(xe);
-
-	/* Calculate devcoredump size */
-	ss->read.size = __xe_devcoredump_read(NULL, INT_MAX, coredump);
-
-	ss->read.buffer = kvmalloc(ss->read.size, GFP_USER);
-	if (!ss->read.buffer)
-		return;
-
-	__xe_devcoredump_read(ss->read.buffer, ss->read.size, coredump);
-	xe_devcoredump_snapshot_free(ss);
-}
-
 static ssize_t xe_devcoredump_read(char *buffer, loff_t offset,
 				   size_t count, void *data, size_t datalen)
 {
@@ -234,6 +204,45 @@ static void xe_devcoredump_free(void *data)
 		 "Xe device coredump has been deleted.\n");
 }
 
+static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
+{
+	struct xe_devcoredump_snapshot *ss = container_of(work, typeof(*ss), work);
+	struct xe_devcoredump *coredump = container_of(ss, typeof(*coredump), snapshot);
+	struct xe_device *xe = coredump_to_xe(coredump);
+	unsigned int fw_ref;
+
+	/*
+	 * NB: Despite passing a GFP_ flags parameter here, more allocations are done
+	 * internally using GFP_KERNEL expliictly. Hence this call must be in the worker
+	 * thread and not in the initial capture call.
+	 */
+	dev_coredumpm_timeout(gt_to_xe(ss->gt)->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
+			      xe_devcoredump_read, xe_devcoredump_free,
+			      XE_COREDUMP_TIMEOUT_JIFFIES);
+
+	xe_pm_runtime_get(xe);
+
+	/* keep going if fw fails as we still want to save the memory and SW data */
+	fw_ref = xe_force_wake_get(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL);
+	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+		xe_gt_info(ss->gt, "failed to get forcewake for coredump capture\n");
+	xe_vm_snapshot_capture_delayed(ss->vm);
+	xe_guc_exec_queue_snapshot_capture_delayed(ss->ge);
+	xe_force_wake_put(gt_to_fw(ss->gt), fw_ref);
+
+	xe_pm_runtime_put(xe);
+
+	/* Calculate devcoredump size */
+	ss->read.size = __xe_devcoredump_read(NULL, INT_MAX, coredump);
+
+	ss->read.buffer = kvmalloc(ss->read.size, GFP_USER);
+	if (!ss->read.buffer)
+		return;
+
+	__xe_devcoredump_read(ss->read.buffer, ss->read.size, coredump);
+	xe_devcoredump_snapshot_free(ss);
+}
+
 static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 				 struct xe_sched_job *job)
 {
@@ -310,10 +319,6 @@ void xe_devcoredump(struct xe_sched_job *job)
 	drm_info(&xe->drm, "Xe device coredump has been created\n");
 	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
 		 xe->drm.primary->index);
-
-	dev_coredumpm_timeout(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
-			      xe_devcoredump_read, xe_devcoredump_free,
-			      XE_COREDUMP_TIMEOUT_JIFFIES);
 }
 
 static void xe_driver_devcoredump_fini(void *arg)


