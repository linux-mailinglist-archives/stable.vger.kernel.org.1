Return-Path: <stable+bounces-143210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF05AB3487
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734E5188C3E6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA1151991;
	Mon, 12 May 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QjEqWDer"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC9255F5A
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044411; cv=none; b=gWXweO3kz4tlDzVA6ZExxKM+co/joYJHWgnwcCjm803RS5rpgwZ4aLlkX/SxUWxnhcmf92LWgvp8AH6UmSoGyj92u8Ngw4wWAj8QZHYKBSwBsJ1QTQ4Ljgm92bdjLRyVu+eZ/Cjh9TVVDK+JQR1B3OUnC5Iuw342iI6AHkGMWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044411; c=relaxed/simple;
	bh=jbK4+tYsF0fQRGPDOzZ5t0ZTZ44W/WZT3W4cigXaMAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cYdtFjZ8bfkLZj9kLADcM8OdkrmFG4Xe1LXGYpEZP7YwrVvU1epF2n9RihwsRDF02GmzSYDSeCirc30ml6jVgwmm7vOJaz3m7JPNGed5Pg5gFJMQuTcirTwDp/WaSewq+GstfQ1eWMliOdGo3wKh3IqblZZ00fEK67+mi4YClPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QjEqWDer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78ABC4CEE7;
	Mon, 12 May 2025 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044410;
	bh=jbK4+tYsF0fQRGPDOzZ5t0ZTZ44W/WZT3W4cigXaMAY=;
	h=Subject:To:Cc:From:Date:From;
	b=QjEqWDer0Jd5I8NStSjyjGVPU9E1JavWQcPhrgm0Q55YbVCbolQcygomLs8UZ9hmy
	 zvATv1dAy/ZiNWq7os84roJqmgLrxVkm8wVPuvyRp1IY0gbAZP6eLFNwqgYXWQjMYi
	 AJx8uCN3Kzj/ifEgL2MIxVOWttI7mitr1NNrKChA=
Subject: FAILED: patch "[PATCH] drm/xe/gsc: do not flush the GSC worker from the reset path" failed to apply to 6.12-stable tree
To: daniele.ceraolospurio@intel.com,John.C.Harrison@Intel.com,alan.previn.teres.alexis@intel.com,julia.filipchuk@intel.com,lucas.demarchi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:06:39 +0200
Message-ID: <2025051239-ceremony-rehab-8e6c@gregkh>
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
git cherry-pick -x 03552d8ac0afcc080c339faa0b726e2c0e9361cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051239-ceremony-rehab-8e6c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03552d8ac0afcc080c339faa0b726e2c0e9361cb Mon Sep 17 00:00:00 2001
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Date: Fri, 2 May 2025 08:51:04 -0700
Subject: [PATCH] drm/xe/gsc: do not flush the GSC worker from the reset path

The workqueue used for the reset worker is marked as WQ_MEM_RECLAIM,
while the GSC one isn't (and can't be as we need to do memory
allocations in the gsc worker). Therefore, we can't flush the latter
from the former.

The reason why we had such a flush was to avoid interrupting either
the GSC FW load or in progress GSC proxy operations. GSC proxy
operations fall into 2 categories:

1) GSC proxy init: this only happens once immediately after GSC FW load
   and does not support being interrupted. The only way to recover from
   an interruption of the proxy init is to do an FLR and re-load the GSC.

2) GSC proxy request: this can happen in response to a request that
   the driver sends to the GSC. If this is interrupted, the GSC FW will
   timeout and the driver request will be failed, but overall the GSC
   will keep working fine.

Flushing the work allowed us to avoid interruption in both cases (unless
the hang came from the GSC engine itself, in which case we're toast
anyway). However, a failure on a proxy request is tolerable if we're in
a scenario where we're triggering a GT reset (i.e., something is already
gone pretty wrong), so what we really need to avoid is interrupting
the init flow, which we can do by polling on the register that reports
when the proxy init is complete (as that ensure us that all the load and
init operations have been completed).

Note that during suspend we still want to do a flush of the worker to
make sure it completes any operations involving the HW before the power
is cut.

v2: fix spelling in commit msg, rename waiter function (Julia)

Fixes: dd0e89e5edc2 ("drm/xe/gsc: GSC FW load")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4830
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Julia Filipchuk <julia.filipchuk@intel.com>
Link: https://lore.kernel.org/r/20250502155104.2201469-1-daniele.ceraolospurio@intel.com
(cherry picked from commit 12370bfcc4f0bdf70279ec5b570eb298963422b5)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index fd41113f8572..0bcf97063ff6 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -555,6 +555,28 @@ void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc)
 		flush_work(&gsc->work);
 }
 
+void xe_gsc_stop_prepare(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+	int ret;
+
+	if (!xe_uc_fw_is_loadable(&gsc->fw) || xe_uc_fw_is_in_error_state(&gsc->fw))
+		return;
+
+	xe_force_wake_assert_held(gt_to_fw(gt), XE_FW_GSC);
+
+	/*
+	 * If the GSC FW load or the proxy init are interrupted, the only way
+	 * to recover it is to do an FLR and reload the GSC from scratch.
+	 * Therefore, let's wait for the init to complete before stopping
+	 * operations. The proxy init is the last step, so we can just wait on
+	 * that
+	 */
+	ret = xe_gsc_wait_for_proxy_init_done(gsc);
+	if (ret)
+		xe_gt_err(gt, "failed to wait for GSC init completion before uc stop\n");
+}
+
 /*
  * wa_14015076503: if the GSC FW is loaded, we need to alert it before doing a
  * GSC engine reset by writing a notification bit in the GS1 register and then
diff --git a/drivers/gpu/drm/xe/xe_gsc.h b/drivers/gpu/drm/xe/xe_gsc.h
index d99f66c38075..b8b8e0810ad9 100644
--- a/drivers/gpu/drm/xe/xe_gsc.h
+++ b/drivers/gpu/drm/xe/xe_gsc.h
@@ -16,6 +16,7 @@ struct xe_hw_engine;
 int xe_gsc_init(struct xe_gsc *gsc);
 int xe_gsc_init_post_hwconfig(struct xe_gsc *gsc);
 void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc);
+void xe_gsc_stop_prepare(struct xe_gsc *gsc);
 void xe_gsc_load_start(struct xe_gsc *gsc);
 void xe_gsc_hwe_irq_handler(struct xe_hw_engine *hwe, u16 intr_vec);
 
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.c b/drivers/gpu/drm/xe/xe_gsc_proxy.c
index 8cf70b228ff3..d0519cd6704a 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.c
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.c
@@ -71,6 +71,17 @@ bool xe_gsc_proxy_init_done(struct xe_gsc *gsc)
 	       HECI1_FWSTS1_PROXY_STATE_NORMAL;
 }
 
+int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+
+	/* Proxy init can take up to 500ms, so wait double that for safety */
+	return xe_mmio_wait32(&gt->mmio, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
+			      HECI1_FWSTS1_CURRENT_STATE,
+			      HECI1_FWSTS1_PROXY_STATE_NORMAL,
+			      USEC_PER_SEC, NULL, false);
+}
+
 static void __gsc_proxy_irq_rmw(struct xe_gsc *gsc, u32 clr, u32 set)
 {
 	struct xe_gt *gt = gsc_to_gt(gsc);
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.h b/drivers/gpu/drm/xe/xe_gsc_proxy.h
index fdef56995cd4..765602221dbc 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.h
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.h
@@ -12,6 +12,7 @@ struct xe_gsc;
 
 int xe_gsc_proxy_init(struct xe_gsc *gsc);
 bool xe_gsc_proxy_init_done(struct xe_gsc *gsc);
+int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc);
 int xe_gsc_proxy_start(struct xe_gsc *gsc);
 
 int xe_gsc_proxy_request_handler(struct xe_gsc *gsc);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 10a9e3c72b36..66198cf2662c 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -857,7 +857,7 @@ void xe_gt_suspend_prepare(struct xe_gt *gt)
 
 	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 
-	xe_uc_stop_prepare(&gt->uc);
+	xe_uc_suspend_prepare(&gt->uc);
 
 	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
diff --git a/drivers/gpu/drm/xe/xe_uc.c b/drivers/gpu/drm/xe/xe_uc.c
index c14bd2282044..3a8751a8b92d 100644
--- a/drivers/gpu/drm/xe/xe_uc.c
+++ b/drivers/gpu/drm/xe/xe_uc.c
@@ -244,7 +244,7 @@ void xe_uc_gucrc_disable(struct xe_uc *uc)
 
 void xe_uc_stop_prepare(struct xe_uc *uc)
 {
-	xe_gsc_wait_for_worker_completion(&uc->gsc);
+	xe_gsc_stop_prepare(&uc->gsc);
 	xe_guc_stop_prepare(&uc->guc);
 }
 
@@ -278,6 +278,12 @@ static void uc_reset_wait(struct xe_uc *uc)
 		goto again;
 }
 
+void xe_uc_suspend_prepare(struct xe_uc *uc)
+{
+	xe_gsc_wait_for_worker_completion(&uc->gsc);
+	xe_guc_stop_prepare(&uc->guc);
+}
+
 int xe_uc_suspend(struct xe_uc *uc)
 {
 	/* GuC submission not enabled, nothing to do */
diff --git a/drivers/gpu/drm/xe/xe_uc.h b/drivers/gpu/drm/xe/xe_uc.h
index 3813c1ede450..c23e6f5e2514 100644
--- a/drivers/gpu/drm/xe/xe_uc.h
+++ b/drivers/gpu/drm/xe/xe_uc.h
@@ -18,6 +18,7 @@ int xe_uc_reset_prepare(struct xe_uc *uc);
 void xe_uc_stop_prepare(struct xe_uc *uc);
 void xe_uc_stop(struct xe_uc *uc);
 int xe_uc_start(struct xe_uc *uc);
+void xe_uc_suspend_prepare(struct xe_uc *uc);
 int xe_uc_suspend(struct xe_uc *uc);
 int xe_uc_sanitize_reset(struct xe_uc *uc);
 void xe_uc_declare_wedged(struct xe_uc *uc);


