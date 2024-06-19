Return-Path: <stable+bounces-54068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3490EC81
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010E91F20FA4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAD143C43;
	Wed, 19 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+htW2yW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DCA12FB31;
	Wed, 19 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802497; cv=none; b=faDIoCXtpUh6Y0IwwRN9CHjQ4z7ecpAee0oss+GLu1V4GWSMzoWAq5DgGILusBcQDB5ElqNfRzoNPs0b5hp10NsfPsE1RjVY0YmD3Osn+l2MUykdBaFxJTsbkXNjru48BWz6E46aEeCSSg82v7U1D5rquoBQUNrcbOOvZaj4NbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802497; c=relaxed/simple;
	bh=ZFZwFbxJe0CkA23tNAnI8JLvgwvjuAZcsbsYI4qGC/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjHjY14AEyhDEZ39/PLN19e4rJn11UeRr6himjpcQXy2MmcAjU3+GneRepNL+n5ly6kX46/lfs2xahtojFml8BU0aJIFunCO1P33LUPD4k5Hd0H11Pcl3UsF9F8pS5fwjHWtH2UuICDnsj3rFUkwFbXyvmoQtJ36jouNfVnHG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+htW2yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC04C2BBFC;
	Wed, 19 Jun 2024 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802497;
	bh=ZFZwFbxJe0CkA23tNAnI8JLvgwvjuAZcsbsYI4qGC/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+htW2yWQNThRz6NKVD22LN4SJSNNJeVlAPoZk/1RY5dglGL31n6z9xT4bQWaWJev
	 T8G58x+3XONibcv3Mf08J6JQI2LPco0/t38IrEaXpl1K8+JrYuw6hjgoZPDX3WdnZM
	 2Ff+tt7m1tMlJ/gPEUrP7iAeIMdou/+NglGQpRak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.6 215/267] drm/i915/gt: Disarm breadcrumbs if engines are already idle
Date: Wed, 19 Jun 2024 14:56:06 +0200
Message-ID: <20240619125614.578827100@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 70cb9188ffc75e643debf292fcddff36c9dbd4ae upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -258,8 +258,13 @@ static void signal_irq_work(struct irq_w
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
@@ -310,13 +315,7 @@ void __intel_breadcrumbs_park(struct int
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
@@ -399,7 +398,7 @@ static void insert_breadcrumb(struct i91
 	 * the request as it may have completed and raised the interrupt as
 	 * we were attaching it into the lists.
 	 */
-	if (!b->irq_armed || __i915_request_is_complete(rq))
+	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
 		irq_work_queue(&b->irq_work);
 }
 



