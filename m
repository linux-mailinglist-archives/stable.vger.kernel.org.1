Return-Path: <stable+bounces-155070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC8AE17A9
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889691BC1F10
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D427D76E;
	Fri, 20 Jun 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lS0VPug8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1130E830
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412134; cv=none; b=O1n/oY+5qkhmthojVURxWGM+40hirpIyWsEXAGarjmBkCIZKOd7S7eHGSoVyHKnTm9Ioo6XnHEtVvG5QaGIlnoEqpWxRNx8dGVJgGkcEQnv3lDkfIXRX9A0FGzNLNGfSEu9vOrFgojYNmsnS0lNBMzrpnlE9MZrWjjXipm3fWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412134; c=relaxed/simple;
	bh=N+t7tRnfJDlOD2Smapa+9BkDML7pIqnZAjgKwozJbaY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LWbz0q9TQGIgvjRt+/FCTtToXj30mpaYFy6Lf+K8UfQjJ2XAKCOz+M/fHIXYDYBoLa9h+fGN8Ey6GhfD54+lRUvocPXOzBMUETWWOo+qwh0i9Rf+Yvft1b4WAMp2Y0hqdvnAshYiTS3b8WxGBxW7VlM1WzHZjh4CbKhNnuupZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lS0VPug8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C588C4CEED;
	Fri, 20 Jun 2025 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750412134;
	bh=N+t7tRnfJDlOD2Smapa+9BkDML7pIqnZAjgKwozJbaY=;
	h=Subject:To:Cc:From:Date:From;
	b=lS0VPug83M/12AeRZY3YHPH33uWZBEMizFzqgX/EhyeMXF/lh4MD+NvINCCZyZ+3M
	 K7/+xtD+kRFO27zcFsqP/92DnkNXct1A2qi2ysqTOFGTO781CYEftsAITun4oGlmVt
	 z96aekwizuNRyYAZtndZKAGvZIla6BuhIumk1yyA=
Subject: FAILED: patch "[PATCH] accel/ivpu: Trigger device recovery on engine reset/resume" failed to apply to 6.12-stable tree
To: karol.wachowski@intel.com,jacek.lawrynowicz@linux.intel.com,lizhi.hou@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:35:31 +0200
Message-ID: <2025062031-unrented-debtless-6980@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a47e36dc5d90dc664cac87304c17d50f1595d634
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062031-unrented-debtless-6980@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a47e36dc5d90dc664cac87304c17d50f1595d634 Mon Sep 17 00:00:00 2001
From: Karol Wachowski <karol.wachowski@intel.com>
Date: Wed, 28 May 2025 17:42:53 +0200
Subject: [PATCH] accel/ivpu: Trigger device recovery on engine reset/resume
 failure

Trigger full device recovery when the driver fails to restore device state
via engine reset and resume operations. This is necessary because, even if
submissions from a faulty context are blocked, the NPU may still process
previously submitted faulty jobs if the engine reset fails to abort them.
Such jobs can continue to generate faults and occupy device resources.
When engine reset is ineffective, the only way to recover is to perform
a full device recovery.

Fixes: dad945c27a42 ("accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://lore.kernel.org/r/20250528154253.500556-1-jacek.lawrynowicz@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 1c8e283ad985..fae8351aa330 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -986,7 +986,8 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 		return;
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
-		ivpu_jsm_reset_engine(vdev, 0);
+		if (ivpu_jsm_reset_engine(vdev, 0))
+			return;
 
 	mutex_lock(&vdev->context_list_lock);
 	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
@@ -1009,7 +1010,8 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		goto runtime_put;
 
-	ivpu_jsm_hws_resume_engine(vdev, 0);
+	if (ivpu_jsm_hws_resume_engine(vdev, 0))
+		return;
 	/*
 	 * In hardware scheduling mode NPU already has stopped processing jobs
 	 * and won't send us any further notifications, thus we have to free job related resources
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 219ab8afefab..0256b2dfefc1 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -7,6 +7,7 @@
 #include "ivpu_hw.h"
 #include "ivpu_ipc.h"
 #include "ivpu_jsm_msg.h"
+#include "ivpu_pm.h"
 #include "vpu_jsm_api.h"
 
 const char *ivpu_jsm_msg_type_to_str(enum vpu_ipc_msg_type type)
@@ -163,8 +164,10 @@ int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine)
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_RESET_DONE, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-	if (ret)
+	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to reset engine %d: %d\n", engine, ret);
+		ivpu_pm_trigger_recovery(vdev, "Engine reset failed");
+	}
 
 	return ret;
 }
@@ -354,8 +357,10 @@ int ivpu_jsm_hws_resume_engine(struct ivpu_device *vdev, u32 engine)
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_HWS_RESUME_ENGINE_DONE, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-	if (ret)
+	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to resume engine %d: %d\n", engine, ret);
+		ivpu_pm_trigger_recovery(vdev, "Engine resume failed");
+	}
 
 	return ret;
 }


