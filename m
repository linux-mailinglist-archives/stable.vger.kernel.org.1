Return-Path: <stable+bounces-147948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AEAC6872
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1EB16647E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7927C145;
	Wed, 28 May 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuScxgf+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA9202C26
	for <stable@vger.kernel.org>; Wed, 28 May 2025 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432074; cv=none; b=Xdu4XCl+hnFIYDl4h9mSg9hPtj5VzTr+bdI9af+VlKTY7ddd1qzfTqNZJvx1ovQvGvmltivXM9M7VHGe3G10UYJPMNVbf/K4/7ulbMFLr6P/c1ebxOq/1K1mlzO/Nb2g5QYyBUulPAmbXLFZKrvoXXFyUTt+V7/1J/czZDX9wDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432074; c=relaxed/simple;
	bh=XTsYmHa8O+M54w6Bbck79J9D2BCwlsauPmBnmMsiWOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZrFCuylUTXG5oKkPZT0XSiMynjbEwR9gAqKxOghwTRZZ1hp69ZP6OQaEnBm0Y7VPEj6LttXaRKnWR7PUnAUCxwI+XfFhJ70dfYwOAu16g3Myq0U+VYpMIhJtshSRJWyns0YX6pEhZGeZwCrVWkV0g7OFLpYlUfAc6BANQT2njkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuScxgf+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748432073; x=1779968073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XTsYmHa8O+M54w6Bbck79J9D2BCwlsauPmBnmMsiWOo=;
  b=TuScxgf+b+rMkxCEr0a3Nud6MvLk/OCrpu7M91sdcAysCTrEiLwc0izt
   /ifCatClV8AdNxVVmD6a1xVOCEHwsImll935+9kwf/L5Nqnhfz39Be9aB
   ij85NNuc6PFpxLaLpDzMQUz4xk/R82E1D9nKI6S6iUWSslbPdTdm++tgL
   qjiIBCFCvW3QbcgGH5K6pYb7Fef6IujABITO1R78icBYLhnmqH0nHrAwK
   GSUFG9pIVW9E+IZALyscJyZjrLYtNqODc9Dr4EDUjK4/O1XBetrFr5Wbl
   yiB5rMfp60mFTYyO/nTqbFG7kNuzVvq7pc84ZW1rfK98LG2sJ/VFEYkJ/
   Q==;
X-CSE-ConnectionGUID: bupbUjsTQH68N8RjcqoHUw==
X-CSE-MsgGUID: x7/WTqH1T/2U+CqyjuYxnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61510331"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61510331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:34:32 -0700
X-CSE-ConnectionGUID: UFUR5oA5TJCaBlUo5Z5FXw==
X-CSE-MsgGUID: F8YCgTWlT1u8pDYyIFSARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144190591"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:34:31 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	William Tseng <william.tseng@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
Date: Wed, 28 May 2025 12:33:29 +0100
Message-ID: <20250528113328.289392-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Customer is reporting a really subtle issue where we get random DMAR
faults, hangs and other nasties for kernel migration jobs when stressing
stuff like s2idle/s3/s4. The explosions seems to happen somewhere
after resuming the system with splats looking something like:

PM: suspend exit
rfkill: input handler disabled
xe 0000:00:02.0: [drm] GT0: Engine reset: engine_class=bcs, logical_mask: 0x2, guc_id=0
xe 0000:00:02.0: [drm] GT0: Timedout job: seqno=24496, lrc_seqno=24496, guc_id=0, flags=0x13 in no process [-1]
xe 0000:00:02.0: [drm] GT0: Kernel-submitted job timed out

The likely cause appears to be a race between suspend cancelling the
worker that processes the free_job()'s, such that we still have pending
jobs to be freed after the cancel. Following from this, on resume the
pending_list will now contain at least one already complete job, but it
looks like we call drm_sched_resubmit_jobs(), which will then call
run_job() on everything still on the pending_list. But if the job was
already complete, then all the resources tied to the job, like the bb
itself, any memory that is being accessed, the iommu mappings etc. might
be long gone since those are usually tied to the fence signalling.

This scenario can be seen in ftrace when running a slightly modified
xe_pm (kernel was only modified to inject artificial latency into
free_job to make the race easier to hit):

xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0, lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0, guc_state=0x0, flags=0x13
xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=1, guc_state=0x0, flags=0x4
xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=0, guc_state=0x0, flags=0x3
xe_exec_queue_stop:   dev=0000:00:02.0, 1:0x1, gt=1, width=1, guc_id=1, guc_state=0x0, flags=0x3
xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=2, guc_state=0x0, flags=0x3
xe_exec_queue_resubmit: dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0, guc_state=0x0, flags=0x13
xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0, lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
.....
xe_exec_queue_memory_cat_error: dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0, guc_state=0x3, flags=0x13

So the job_run() is clearly triggered twice for the same job, even
though the first must have already signalled to completion during
suspend. We can also see a CAT error after the re-submit.

To prevent this try to call xe_sched_stop() to forcefully remove
anything on the pending_list that has already signalled, before we
re-submit.

v2:
  - Make sure to re-arm the fence callbacks with sched_start().
v3 (Matt B):
  - Stop using drm_sched_resubmit_jobs(), which appears to be deprecated
    and just open-code a simple loop such that we skip calling run_job()
    and anything already signalled.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4856
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: William Tseng <william.tseng@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_gpu_scheduler.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index c250ea773491..308061f0cf37 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -51,7 +51,15 @@ static inline void xe_sched_tdr_queue_imm(struct xe_gpu_scheduler *sched)
 
 static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_resubmit_jobs(&sched->base);
+	struct drm_sched_job *s_job;
+
+	list_for_each_entry(s_job, &sched->base.pending_list, list) {
+		struct drm_sched_fence *s_fence = s_job->s_fence;
+		struct dma_fence *hw_fence = s_fence->parent;
+
+		if (hw_fence && !dma_fence_is_signaled(hw_fence))
+			sched->base.ops->run_job(s_job);
+	}
 }
 
 static inline bool
-- 
2.49.0


