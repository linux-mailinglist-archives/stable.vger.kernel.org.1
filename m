Return-Path: <stable+bounces-57806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26185925E1D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992881F257E6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0E17B410;
	Wed,  3 Jul 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OXTtPHJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262F17B4F7;
	Wed,  3 Jul 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005989; cv=none; b=Z/iluHWFxd6QvQfDtv1OIheERkT1M9X9VFVktsEk0F/HBWHU0bsSK2rhYc0jqOR992Jq0I5+VahrdtzuTLZi7Yam/uL3LAxpaFC0sszwqrWoW12addyzBs4jyoF/z2rd+RVQ5u6jLJfPf6QsXb+j50RhBdbOIcURSKNZ+G1ENag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005989; c=relaxed/simple;
	bh=MfkvEtMzhvPCKcEwxpNzdf2cnELnK8FJMkOWE7nDTTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keC/lZJFXvLR4WWUVgY7zjhsaF1WoKT2+XeTv+JmLBvmLnDXZSDC/3+aHarrjgF8UnOd5PqCtvjaf+nXwmTkVrwowzMsw63VQN4TcfK5FSJbGzGJUEXntEl8ZtopSo9QfUttNLC5oOUja/Qu271NUh7WydiMNx+298mThPjjfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OXTtPHJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91B4C2BD10;
	Wed,  3 Jul 2024 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005989;
	bh=MfkvEtMzhvPCKcEwxpNzdf2cnELnK8FJMkOWE7nDTTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXTtPHJKdg14c0mGfzw1llz3wlfPdF1HzOgFo58sQqi1vE9hT6PuOx/r8efXTALFg
	 RotRhs60imSuY/GNIeC/trZrO/QNiOu2SFObG4ukENdtyfm6G4eaeqthuKseAj0UiZ
	 rGLXW4S3b2uy57vTauMRaVEgp2e30CkhQr4PxTG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 246/356] drm/i915/gt: Disarm breadcrumbs if engines are already idle
Date: Wed,  3 Jul 2024 12:39:42 +0200
Message-ID: <20240703102922.421142572@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 70cb9188ffc75e643debf292fcddff36c9dbd4ae ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index e8cd7effea2b0..56985edda8baf 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -257,8 +257,13 @@ static void signal_irq_work(struct irq_work *work)
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
@@ -309,13 +314,7 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
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
@@ -398,7 +397,7 @@ static void insert_breadcrumb(struct i915_request *rq)
 	 * the request as it may have completed and raised the interrupt as
 	 * we were attaching it into the lists.
 	 */
-	if (!b->irq_armed || __i915_request_is_complete(rq))
+	if (!READ_ONCE(b->irq_armed) || __i915_request_is_complete(rq))
 		irq_work_queue(&b->irq_work);
 }
 
-- 
2.43.0




