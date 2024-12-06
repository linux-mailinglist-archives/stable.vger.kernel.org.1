Return-Path: <stable+bounces-99073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABCE9E6F31
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39DF1620DA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F51E1C11;
	Fri,  6 Dec 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xj1YR1ml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E1206F3B
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491093; cv=none; b=UQ3M6Vv+krqeWS7jtqdhksFzmNHHU64TnDIIggL86cF8ALXLCDCDK+6c/NeAVQSt4Y702zfafqJcacECbhPdnWHnsvyI7zrnowzdiWfJFFZGd+hdi/WgS3k4aZvlY7pBk9XrKgNm0EliabCAzuLq3wYqT6pXmviCM1ql8nivh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491093; c=relaxed/simple;
	bh=f3aCS8FmVHFQe0uvgbEpF+bHPQTKdAz9TXagOhNY3sk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sdqa0M8oCDjBB4koHcANU5zyxnyna2jpUb/NhIZZTmDs0e3oHEBMN6IaowyP5YLCbbtXul/BVkUCLLBvwT92F1u2Rc4ifaxrjmQyGP1hyXxm6NBxS1XIHnBru+W6lVs6A4mZqzIqzhmjTZMscwR63j/VYEopT2zstZHDfQuq8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xj1YR1ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB6C4CED1;
	Fri,  6 Dec 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733491092;
	bh=f3aCS8FmVHFQe0uvgbEpF+bHPQTKdAz9TXagOhNY3sk=;
	h=Subject:To:Cc:From:Date:From;
	b=xj1YR1mlBysNqxEwKe0/FftFCFeTHoFn5TQKNN02YTxPiPUGN9w7Hx2hA1my7F+9v
	 g3dbpX0C8hCoSvnAmCqpS7vTNHHH+MrHozvbXlejjbyaJm0a85Rp6j2L73rvLOOewr
	 lW2uIt6AKav8iTxqV6uCefWP6OWI0pfQMSsCFq9M=
Subject: FAILED: patch "[PATCH] drm/xe/guc_submit: fix race around pending_disable" failed to apply to 6.12-stable tree
To: matthew.auld@intel.com,mattheq.brost@intel.com,matthew.brost@intel.com,stable@vger.kernel.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:18:09 +0100
Message-ID: <2024120609-unsorted-footpad-b009@gregkh>
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
git cherry-pick -x 6965f91a000a24b2c25480a92696a007545d97ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120609-unsorted-footpad-b009@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6965f91a000a24b2c25480a92696a007545d97ec Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Fri, 22 Nov 2024 16:19:16 +0000
Subject: [PATCH] drm/xe/guc_submit: fix race around pending_disable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently in some testcases we can trigger:

[drm] *ERROR* GT0: SCHED_DONE: Unexpected engine state 0x02b1, guc_id=8, runnable_state=0
[drm] *ERROR* GT0: G2H action 0x1002 failed (-EPROTO) len 3 msg 02 10 00 90 08 00 00 00 00 00 00 00

Looking at a snippet of corresponding ftrace for this GuC id we can see:

498.852891: xe_sched_msg_add:     dev=0000:03:00.0, gt=0 guc_id=8, opcode=3
498.854083: xe_sched_msg_recv:    dev=0000:03:00.0, gt=0 guc_id=8, opcode=3
498.855389: xe_exec_queue_kill:   dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x3, flags=0x0
498.855436: xe_exec_queue_lr_cleanup: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x83, flags=0x0
498.856767: xe_exec_queue_close:  dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x83, flags=0x0
498.862889: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0xa9, flags=0x0
498.863032: xe_exec_queue_scheduling_disable: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b9, flags=0x0
498.875596: xe_exec_queue_scheduling_done: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b9, flags=0x0
498.875604: xe_exec_queue_deregister: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b1, flags=0x0
499.074483: xe_exec_queue_deregister_done: dev=0000:03:00.0, 5:0x1, gt=0, width=1, guc_id=8, guc_state=0x2b1, flags=0x0

This looks to be the two scheduling_disable racing with each other, one
from the suspend (opcode=3) and then again during lr cleanup. While
those two operations are serialized, the G2H portion is not, therefore
when marking the queue as pending_disabled and then firing off the first
request, we proceed do the same again, however the first disable
response only fires after this which then clears the pending_disabled.
At this point the second comes back and is processed, however the
pending_disabled is no longer set, hence triggering the warning.

To fix this wait for pending_disabled when doing the lr cleanup and
calling disable_scheduling_deregister. Also do the same for all other
disable_scheduling callers.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3515
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <mattheq.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241122161914.321263-5-matthew.auld@intel.com
(cherry picked from commit ddb106d2120a0bf1c5ff87c71d059d193814da41)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 7afcc243037c..ebc85d98b025 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -769,17 +769,19 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
 					  struct xe_exec_queue *q)
 {
 	MAKE_SCHED_CONTEXT_ACTION(q, DISABLE);
-	struct xe_device *xe = guc_to_xe(guc);
 	int ret;
 
 	set_min_preemption_timeout(guc, q);
 	smp_rmb();
-	ret = wait_event_timeout(guc->ct.wq, !exec_queue_pending_enable(q) ||
-				 xe_guc_read_stopped(guc), HZ * 5);
+	ret = wait_event_timeout(guc->ct.wq,
+				 (!exec_queue_pending_enable(q) &&
+				  !exec_queue_pending_disable(q)) ||
+					 xe_guc_read_stopped(guc),
+				 HZ * 5);
 	if (!ret) {
 		struct xe_gpu_scheduler *sched = &q->guc->sched;
 
-		drm_warn(&xe->drm, "Pending enable failed to respond");
+		xe_gt_warn(q->gt, "Pending enable/disable failed to respond\n");
 		xe_sched_submission_start(sched);
 		xe_gt_reset_async(q->gt);
 		xe_sched_tdr_queue_imm(sched);
@@ -1101,7 +1103,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
 			 * modifying state
 			 */
 			ret = wait_event_timeout(guc->ct.wq,
-						 !exec_queue_pending_enable(q) ||
+						 (!exec_queue_pending_enable(q) &&
+						  !exec_queue_pending_disable(q)) ||
 						 xe_guc_read_stopped(guc), HZ * 5);
 			if (!ret || xe_guc_read_stopped(guc))
 				goto trigger_reset;
@@ -1330,8 +1333,8 @@ static void __guc_exec_queue_process_msg_suspend(struct xe_sched_msg *msg)
 
 	if (guc_exec_queue_allowed_to_change_state(q) && !exec_queue_suspended(q) &&
 	    exec_queue_enabled(q)) {
-		wait_event(guc->ct.wq, q->guc->resume_time != RESUME_PENDING ||
-			   xe_guc_read_stopped(guc));
+		wait_event(guc->ct.wq, (q->guc->resume_time != RESUME_PENDING ||
+			   xe_guc_read_stopped(guc)) && !exec_queue_pending_disable(q));
 
 		if (!xe_guc_read_stopped(guc)) {
 			s64 since_resume_ms =


