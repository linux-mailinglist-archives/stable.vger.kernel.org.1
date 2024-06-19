Return-Path: <stable+bounces-53694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7290E3E0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7477B2859F6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6D471B45;
	Wed, 19 Jun 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="voHRkwW0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F76F31F
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780313; cv=none; b=lMLxJhk8hU3JEsFdA6v/PSlk7z7+whEJFxT6/hXui7MPIOOqR9WKRMxB7rRcBgKsLBSLCl11iTlutj83hRRjVJJ0AgsrV0rD1A0PIWX2pysEu8Q2CuRtwoektJbmgle71669o7i1wxCJ5u31qZvS40NJrTYQmKNy+3czUc9qybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780313; c=relaxed/simple;
	bh=5XKNMUZuYV6qcUwvfZIYgqB0QuHNCGSvruvovREuXXY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DMuRzIHguvTWmz5qFh2SZR5aVWpWNybHU+vt1LF/Ec6/rZ5zITrspdwj+CA3x0p2+WwEqOzMG76d1Y7UeCxRygo04EthC3bErw5aq01Y7HrPLN7avL9ErpQRZKxzUeXfgfv8dQzkPPGtGrOOdOD8q1XwuLB9Q8RWIRaDGlEFGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=voHRkwW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CF3C2BBFC;
	Wed, 19 Jun 2024 06:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718780313;
	bh=5XKNMUZuYV6qcUwvfZIYgqB0QuHNCGSvruvovREuXXY=;
	h=Subject:To:Cc:From:Date:From;
	b=voHRkwW0zpsWiPc+I/1lSJ32RaYg2u3HvBGauw2f0QbrTBuxg+g2FSHwwkcYJBqYD
	 Q7BhOSsfwuM+LWIMBmYAOdTX7JN/2bRK5SW/gdy4yj0dqpLBUV2mJrWSjedvS35bCh
	 i1+AryckdbCMKYRr0qGswYQ2Pji39HUpBi0d2SAk=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Disarm breadcrumbs if engines are already idle" failed to apply to 5.15-stable tree
To: chris@chris-wilson.co.uk,andi.shyti@linux.intel.com,andrzej.hajda@intel.com,jani.nikula@intel.com,janusz.krzysztofik@linux.intel.com,nirmoy.das@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 08:58:30 +0200
Message-ID: <2024061929-scalding-tweak-f522@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 70cb9188ffc75e643debf292fcddff36c9dbd4ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061929-scalding-tweak-f522@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

70cb9188ffc7 ("drm/i915/gt: Disarm breadcrumbs if engines are already idle")
c877bed82e10 ("drm/i915/gt: Only kick the signal worker if there's been an update")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 70cb9188ffc75e643debf292fcddff36c9dbd4ae Mon Sep 17 00:00:00 2001
From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Tue, 23 Apr 2024 18:23:10 +0200
Subject: [PATCH] drm/i915/gt: Disarm breadcrumbs if engines are already idle

The breadcrumbs use a GT wakeref for guarding the interrupt, but are
disarmed during release of the engine wakeref. This leaves a hole where
we may attach a breadcrumb just as the engine is parking (after it has
parked its breadcrumbs), execute the irq worker with some signalers still
attached, but never be woken again.

That issue manifests itself in CI with IGT runner timeouts while tests
are waiting indefinitely for release of all GT wakerefs.

<6> [209.151778] i915: Running live_engine_pm_selftests/live_engine_busy_stats
<7> [209.231628] i915 0000:00:02.0: [drm:intel_power_well_disable [i915]] disabling PW_5
<7> [209.231816] i915 0000:00:02.0: [drm:intel_power_well_disable [i915]] disabling PW_4
<7> [209.231944] i915 0000:00:02.0: [drm:intel_power_well_disable [i915]] disabling PW_3
<7> [209.232056] i915 0000:00:02.0: [drm:intel_power_well_disable [i915]] disabling PW_2
<7> [209.232166] i915 0000:00:02.0: [drm:intel_power_well_disable [i915]] disabling DC_off
<7> [209.232270] i915 0000:00:02.0: [drm:skl_enable_dc6 [i915]] Enabling DC6
<7> [209.232368] i915 0000:00:02.0: [drm:gen9_set_dc_state.part.0 [i915]] Setting DC state from 00 to 02
<4> [299.356116] [IGT] Inactivity timeout exceeded. Killing the current test with SIGQUIT.
...
<6> [299.356526] sysrq: Show State
...
<6> [299.373964] task:i915_selftest   state:D stack:11784 pid:5578  tgid:5578  ppid:873    flags:0x00004002
<6> [299.373967] Call Trace:
<6> [299.373968]  <TASK>
<6> [299.373970]  __schedule+0x3bb/0xda0
<6> [299.373974]  schedule+0x41/0x110
<6> [299.373976]  intel_wakeref_wait_for_idle+0x82/0x100 [i915]
<6> [299.374083]  ? __pfx_var_wake_function+0x10/0x10
<6> [299.374087]  live_engine_busy_stats+0x9b/0x500 [i915]
<6> [299.374173]  __i915_subtests+0xbe/0x240 [i915]
<6> [299.374277]  ? __pfx___intel_gt_live_setup+0x10/0x10 [i915]
<6> [299.374369]  ? __pfx___intel_gt_live_teardown+0x10/0x10 [i915]
<6> [299.374456]  intel_engine_live_selftests+0x1c/0x30 [i915]
<6> [299.374547]  __run_selftests+0xbb/0x190 [i915]
<6> [299.374635]  i915_live_selftests+0x4b/0x90 [i915]
<6> [299.374717]  i915_pci_probe+0x10d/0x210 [i915]

At the end of the interrupt worker, if there are no more engines awake,
disarm the breadcrumb and go to sleep.

Fixes: 9d5612ca165a ("drm/i915/gt: Defer enabling the breadcrumb interrupt to after submission")
Closes: https://gitlab.freedesktop.org/drm/intel/issues/10026
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: <stable@vger.kernel.org> # v5.12+
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Acked-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240423165505.465734-2-janusz.krzysztofik@linux.intel.com
(cherry picked from commit fbad43eccae5cb14594195c20113369aabaa22b5)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index d650beb8ed22..20b9b04ec1e0 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -263,8 +263,13 @@ static void signal_irq_work(struct irq_work *work)
 		i915_request_put(rq);
 	}
 
+	/* Lazy irq enabling after HW submission */
 	if (!READ_ONCE(b->irq_armed) && !list_empty(&b->signalers))
 		intel_breadcrumbs_arm_irq(b);
+
+	/* And confirm that we still want irqs enabled before we yield */
+	if (READ_ONCE(b->irq_armed) && !atomic_read(&b->active))
+		intel_breadcrumbs_disarm_irq(b);
 }
 
 struct intel_breadcrumbs *
@@ -315,13 +320,7 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 		return;
 
 	/* Kick the work once more to drain the signalers, and disarm the irq */
-	irq_work_sync(&b->irq_work);
-	while (READ_ONCE(b->irq_armed) && !atomic_read(&b->active)) {
-		local_irq_disable();
-		signal_irq_work(&b->irq_work);
-		local_irq_enable();
-		cond_resched();
-	}
+	irq_work_queue(&b->irq_work);
 }
 
 void intel_breadcrumbs_free(struct kref *kref)
@@ -404,7 +403,7 @@ static void insert_breadcrumb(struct i915_request *rq)
 	 * the request as it may have completed and raised the interrupt as
 	 * we were attaching it into the lists.
 	 */
-	if (!b->irq_armed || __i915_request_is_complete(rq))
+	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
 		irq_work_queue(&b->irq_work);
 }
 


