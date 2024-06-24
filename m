Return-Path: <stable+bounces-55102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675891581C
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 22:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DE0285C31
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AD1A073E;
	Mon, 24 Jun 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaIHlxej"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB72233B
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261557; cv=none; b=aJRfbyZa4LqctHGb/DjbyjZ74pDZlnmz4legIMFveIHt9mmRv3WF7cPRAUya3/3RTo/aCrTu8ReYpC7Ikwvj5Pnnosk9l0gwd2LO82GNK3XZ69jwomX02l8zlI66kOxV9OtMlzLvHU6wtXN2CHB1LK9zppWpAxCDPRtjSDZUxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261557; c=relaxed/simple;
	bh=qp1rsKA8JlxRKDBOpmiN+WwWtR4s0TDQZ5UZ8aYrpY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ3DRTyVwv9vLOhyGPljaeDVC25dig0YOz6Zf3nZh1vjM6pqiNwQA+Xp8SirDf5O2g/IW7m4H8H2T4z2j7FplCpXXEUMrRi+1zB/XqqZvu1VhlFRI7He/hym4dV3732QB2p1v8cXEIMgDQ1Z645U7y5l8hU72NbpcqkQv4LhE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaIHlxej; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261556; x=1750797556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qp1rsKA8JlxRKDBOpmiN+WwWtR4s0TDQZ5UZ8aYrpY0=;
  b=SaIHlxejZGTqrpsW8iB4dttQps2v2mM+37s5oaP6P7BZf/lXkWMqlbfd
   RdvnjR9YfiNyEVLpR2Vw8bQdLJfdtgWn5lQR4xH/fGk5vBSYLx+ycZc08
   tLtpDZkWUBpiTa7tZc8Vx4VfsKZjricNSL2f1PqvN2PqTE5RE4rHW8yhz
   1J/o0sEACWPEnS6j8aphqSFHTegjlimxTjUKkjOGUHtsAfJ0oDdBXZ4N0
   BnXoJ6nRlx5HC2FvDVc4mQq3hB7mFujc3Oz+splQHco+3T5qQFTj0Sds7
   GJW59P9KadCrruj267XhrnA1ZrIJMeU2gVXKYqPeRw7aOFfv2qb5ThToG
   g==;
X-CSE-ConnectionGUID: TQhtQa1kRSm4UtNr3pdCtg==
X-CSE-MsgGUID: q8L03NGYQ+KumEPmt9MCrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33711562"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33711562"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:39:15 -0700
X-CSE-ConnectionGUID: 9JCo60XdSpq5JkXmV5aLIA==
X-CSE-MsgGUID: j8r+ORyRT8+6PN2LL0UUjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="66633983"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.22.228])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:39:14 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: stable@vger.kernel.org
Cc: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH 5.15.y] drm/i915/gt: Disarm breadcrumbs if engines are already idle
Date: Mon, 24 Jun 2024 22:38:02 +0200
Message-ID: <20240624203901.630305-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061929-scalding-tweak-f522@gregkh>
References: <2024061929-scalding-tweak-f522@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wilson <chris@chris-wilson.co.uk>

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
(cherry picked from commit 70cb9188ffc75e643debf292fcddff36c9dbd4ae)
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index 209cf265bf746..ad8c0a4f4a31f 100644
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
-- 
2.45.2


