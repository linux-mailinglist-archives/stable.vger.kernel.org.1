Return-Path: <stable+bounces-94656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B39D652A
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B9C282D38
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF91DFD97;
	Fri, 22 Nov 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho8LG4Fm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6F185935
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309672; cv=none; b=u2f2bwAPZwyRpwTm68vnDKqCnBK1UXylnBvOQ2rLy5B5sch/B61ODvWYTMwFBMxO8ouaZ9cMrQzRg6mn/QcnQG+Avm3nXLS4yM6IQFeUhYen/7wwSQl7hEqZsG5rkhcrGh5aDXf/bYE2QJxkzLZANkevGEA4fzxO8/9zdmmF83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309672; c=relaxed/simple;
	bh=d3cz1Ottvy+22HfbxlXYFtFEEV21cUgCMXnQ5jQLoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkJ7knF5UA7kPoIlGpw218OAA9LE75phydJS5un/JrsrW/IFt0bfjIdRXZ983+eIYmL73mk+CRkNJji+7SEb09HExL4vHCiKJpukLxlnGNE8LEqULmN5uH3WZunD7j5FHmjGtMaNgSGcvDe/4gT2ZLPfolngj33yq2XUsmYTcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho8LG4Fm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309670; x=1763845670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3cz1Ottvy+22HfbxlXYFtFEEV21cUgCMXnQ5jQLoiI=;
  b=ho8LG4FmSL2wruteZTc5VkiLcL68yMlBhyGv6Cz0DJSUdBkNXLaPntpe
   Ritr1EqfJ1dhem+TMDq54gFas2lKme5G8ffFosPd+kQ4FdTzEKCONfKXQ
   z7u9JUqQ4qjqQdSPAvbbYkYxVxtjcFRMRv1InjZcpMpbS9PJ2+Xna0sV+
   8CAWHmRXdmCUMTYQFsOywHITCK5RcMjvsQVa6ci9BBvNjwqLZOlk2hV5k
   +ya00YgrVyGwuIt11uONRLdiTYy+efKg9hMtmdUAK2cX0/zZuCSu48kCb
   0G0UjYSsh50vC7ukn/D9DX+Rnf/VbGApivEQEOTYSvt2I6srsefnyShS5
   A==;
X-CSE-ConnectionGUID: zvM6EwPrS+qysqLy6ZtgtQ==
X-CSE-MsgGUID: HkINTQ+qTtq3GHicB+X78A==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878275"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878275"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
X-CSE-ConnectionGUID: cia4BDU2TcqJTFs+blKP/A==
X-CSE-MsgGUID: 3yw+jfwoQ9qQ7PMhUovZow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457260"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Auld, Matthew" <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 19/31] drm/xe: Use separate rpm lockdep map for non-d3cold-capable devices
Date: Fri, 22 Nov 2024 13:07:07 -0800
Message-ID: <20241122210719.213373-20-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 379cad69bdfe522e840ed5f5c01ac8769006d53e upstream.

For non-d3cold-capable devices we'd like to be able to wake up the
device from reclaim. In particular, for Lunar Lake we'd like to be
able to blit CCS metadata to system at shrink time; at least from
kswapd where it's reasonable OK to wait for rpm resume and a
preceding rpm suspend.

Therefore use a separate lockdep map for such devices and prime it
reclaim-tainted.

v2:
- Rename lockmap acquire- and release functions. (Rodrigo Vivi).
- Reinstate the old xe_pm_runtime_lockdep_prime() function and
  rename it to xe_rpm_might_enter_cb(). (Matthew Auld).
- Introduce a separate xe_pm_runtime_lockdep_prime function
  called from module init for known required locking orders.
v3:
- Actually hook up the prime function at module init.
v4:
- Rebase.
v5:
- Don't use reclaim-safe RPM with sriov.

Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Cc: "Auld, Matthew" <matthew.auld@intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240826143450.92511-1-thomas.hellstrom@linux.intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_module.c |  9 ++++
 drivers/gpu/drm/xe/xe_pm.c     | 84 ++++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_pm.h     |  1 +
 3 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 464ec24e2dd20..5791670c22a3b 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -13,6 +13,7 @@
 #include "xe_drv.h"
 #include "xe_hw_fence.h"
 #include "xe_pci.h"
+#include "xe_pm.h"
 #include "xe_observation.h"
 #include "xe_sched_job.h"
 
@@ -76,6 +77,10 @@ struct init_funcs {
 	void (*exit)(void);
 };
 
+static void xe_dummy_exit(void)
+{
+}
+
 static const struct init_funcs init_funcs[] = {
 	{
 		.init = xe_check_nomodeset,
@@ -96,6 +101,10 @@ static const struct init_funcs init_funcs[] = {
 		.init = xe_observation_sysctl_register,
 		.exit = xe_observation_sysctl_unregister,
 	},
+	{
+		.init = xe_pm_module_init,
+		.exit = xe_dummy_exit,
+	},
 };
 
 static int __init xe_call_init_func(unsigned int i)
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 1402156e4b7e6..356c66fb74a4f 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -69,11 +69,34 @@
  */
 
 #ifdef CONFIG_LOCKDEP
-static struct lockdep_map xe_pm_runtime_lockdep_map = {
-	.name = "xe_pm_runtime_lockdep_map"
+static struct lockdep_map xe_pm_runtime_d3cold_map = {
+	.name = "xe_rpm_d3cold_map"
+};
+
+static struct lockdep_map xe_pm_runtime_nod3cold_map = {
+	.name = "xe_rpm_nod3cold_map"
 };
 #endif
 
+static bool __maybe_unused xe_rpm_reclaim_safe(const struct xe_device *xe)
+{
+	return !xe->d3cold.capable && !xe->info.has_sriov;
+}
+
+static void xe_rpm_lockmap_acquire(const struct xe_device *xe)
+{
+	lock_map_acquire(xe_rpm_reclaim_safe(xe) ?
+			 &xe_pm_runtime_nod3cold_map :
+			 &xe_pm_runtime_d3cold_map);
+}
+
+static void xe_rpm_lockmap_release(const struct xe_device *xe)
+{
+	lock_map_release(xe_rpm_reclaim_safe(xe) ?
+			 &xe_pm_runtime_nod3cold_map :
+			 &xe_pm_runtime_d3cold_map);
+}
+
 /**
  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
  * @xe: xe device instance
@@ -350,7 +373,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 	 * annotation here and in xe_pm_runtime_get() lockdep will see
 	 * the potential lock inversion and give us a nice splat.
 	 */
-	lock_map_acquire(&xe_pm_runtime_lockdep_map);
+	xe_rpm_lockmap_acquire(xe);
 
 	/*
 	 * Applying lock for entire list op as xe_ttm_bo_destroy and xe_bo_move_notify
@@ -383,7 +406,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 out:
 	if (err)
 		xe_display_pm_resume(xe, true);
-	lock_map_release(&xe_pm_runtime_lockdep_map);
+	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return err;
 }
@@ -403,7 +426,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	/* Disable access_ongoing asserts and prevent recursive pm calls */
 	xe_pm_write_callback_task(xe, current);
 
-	lock_map_acquire(&xe_pm_runtime_lockdep_map);
+	xe_rpm_lockmap_acquire(xe);
 
 	if (xe->d3cold.allowed) {
 		err = xe_pcode_ready(xe, true);
@@ -435,7 +458,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	}
 
 out:
-	lock_map_release(&xe_pm_runtime_lockdep_map);
+	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
 	return err;
 }
@@ -449,15 +472,37 @@ int xe_pm_runtime_resume(struct xe_device *xe)
  * stuff that can happen inside the runtime_resume callback by acquiring
  * a dummy lock (it doesn't protect anything and gets compiled out on
  * non-debug builds).  Lockdep then only needs to see the
- * xe_pm_runtime_lockdep_map -> runtime_resume callback once, and then can
- * hopefully validate all the (callers_locks) -> xe_pm_runtime_lockdep_map.
+ * xe_pm_runtime_xxx_map -> runtime_resume callback once, and then can
+ * hopefully validate all the (callers_locks) -> xe_pm_runtime_xxx_map.
  * For example if the (callers_locks) are ever grabbed in the
  * runtime_resume callback, lockdep should give us a nice splat.
  */
-static void pm_runtime_lockdep_prime(void)
+static void xe_rpm_might_enter_cb(const struct xe_device *xe)
 {
-	lock_map_acquire(&xe_pm_runtime_lockdep_map);
-	lock_map_release(&xe_pm_runtime_lockdep_map);
+	xe_rpm_lockmap_acquire(xe);
+	xe_rpm_lockmap_release(xe);
+}
+
+/*
+ * Prime the lockdep maps for known locking orders that need to
+ * be supported but that may not always occur on all systems.
+ */
+static void xe_pm_runtime_lockdep_prime(void)
+{
+	struct dma_resv lockdep_resv;
+
+	dma_resv_init(&lockdep_resv);
+	lock_map_acquire(&xe_pm_runtime_d3cold_map);
+	/* D3Cold takes the dma_resv locks to evict bos */
+	dma_resv_lock(&lockdep_resv, NULL);
+	dma_resv_unlock(&lockdep_resv);
+	lock_map_release(&xe_pm_runtime_d3cold_map);
+
+	/* Shrinkers might like to wake up the device under reclaim. */
+	fs_reclaim_acquire(GFP_KERNEL);
+	lock_map_acquire(&xe_pm_runtime_nod3cold_map);
+	lock_map_release(&xe_pm_runtime_nod3cold_map);
+	fs_reclaim_release(GFP_KERNEL);
 }
 
 /**
@@ -471,7 +516,7 @@ void xe_pm_runtime_get(struct xe_device *xe)
 	if (xe_pm_read_callback_task(xe) == current)
 		return;
 
-	pm_runtime_lockdep_prime();
+	xe_rpm_might_enter_cb(xe);
 	pm_runtime_resume(xe->drm.dev);
 }
 
@@ -501,7 +546,7 @@ int xe_pm_runtime_get_ioctl(struct xe_device *xe)
 	if (WARN_ON(xe_pm_read_callback_task(xe) == current))
 		return -ELOOP;
 
-	pm_runtime_lockdep_prime();
+	xe_rpm_might_enter_cb(xe);
 	return pm_runtime_get_sync(xe->drm.dev);
 }
 
@@ -569,7 +614,7 @@ bool xe_pm_runtime_resume_and_get(struct xe_device *xe)
 		return true;
 	}
 
-	pm_runtime_lockdep_prime();
+	xe_rpm_might_enter_cb(xe);
 	return pm_runtime_resume_and_get(xe->drm.dev) >= 0;
 }
 
@@ -661,3 +706,14 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
 	drm_dbg(&xe->drm,
 		"d3cold: allowed=%s\n", str_yes_no(xe->d3cold.allowed));
 }
+
+/**
+ * xe_pm_module_init() - Perform xe_pm specific module initialization.
+ *
+ * Return: 0 on success. Currently doesn't fail.
+ */
+int __init xe_pm_module_init(void)
+{
+	xe_pm_runtime_lockdep_prime();
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
index 104a21ae6dfd0..9aef673b1c8ad 100644
--- a/drivers/gpu/drm/xe/xe_pm.h
+++ b/drivers/gpu/drm/xe/xe_pm.h
@@ -32,5 +32,6 @@ void xe_pm_assert_unbounded_bridge(struct xe_device *xe);
 int xe_pm_set_vram_threshold(struct xe_device *xe, u32 threshold);
 void xe_pm_d3cold_allowed_toggle(struct xe_device *xe);
 struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
+int xe_pm_module_init(void);
 
 #endif
-- 
2.47.0


