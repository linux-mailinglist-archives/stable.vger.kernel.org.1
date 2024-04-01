Return-Path: <stable+bounces-34718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D453894087
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C271C21524
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2B1EB37;
	Mon,  1 Apr 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dEL9XhIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B11E525;
	Mon,  1 Apr 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989065; cv=none; b=Bzg7ecBsPHeXU2zxtbPzkm0y6YOnaJUX+YuktreMwM+42fgBmRLwtUvHaNxWL1JSDzdXnGPV9RQKgMA8iQ+1GUC8/T5QgY2eJXg4bMq3GLlQf9HPTLOIckPAHVreSpteUwcUumV0dilRoYV1tMAAe8YCOF3OBPIfUpmTucfENK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989065; c=relaxed/simple;
	bh=/8bdXSkIKEXb55Q2KpIeQNsVHxcefj6k87fbwU8yhnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl00VfPDb0M8PtQ7vvXK0NIpbm3G96HKbCy0AdZt6OOFPilq4oDtor7A9Z/BgvdhkDZEPBRlyCy8iRzmohwCorUgW6CTDycDkxgmGtm4p1X+4mJEZMFb7JF9H4N5XCu0ytEbM87QfXaUcKXc27bjKrMhyV/2azlUaBolgy6bx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dEL9XhIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAF5C43390;
	Mon,  1 Apr 2024 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989065;
	bh=/8bdXSkIKEXb55Q2KpIeQNsVHxcefj6k87fbwU8yhnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEL9XhISVQXsev8P6jaCYo2SKxmID6SX3bqMxsh9ALnIkFjaHT5WX0QQb7ZuisFx5
	 VCanJV+xQpxgEJW9T4/698ILMuVonKEODVIbfbx+7GUqYbc/bZQXzTGsvWUFRKIs6s
	 YiCK7c12mSBQOfOVYzVyEY2ch/fWUra75EU6bmUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH 6.7 370/432] drm/i915/hwmon: Fix locking inversion in sysfs getter
Date: Mon,  1 Apr 2024 17:45:57 +0200
Message-ID: <20240401152604.318660751@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

commit b212b79768ccde74429f872c37618c543fa11333 upstream.

In i915 hwmon sysfs getter path we now take a hwmon_lock, then acquire an
rpm wakeref.  That results in lock inversion:

<4> [197.079335] ======================================================
<4> [197.085473] WARNING: possible circular locking dependency detected
<4> [197.091611] 6.8.0-rc7-Patchwork_129026v7-gc4dc92fb1152+ #1 Not tainted
<4> [197.098096] ------------------------------------------------------
<4> [197.104231] prometheus-node/839 is trying to acquire lock:
<4> [197.109680] ffffffff82764d80 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc+0x9a/0x350
<4> [197.116939]
but task is already holding lock:
<4> [197.122730] ffff88811b772a40 (&hwmon->hwmon_lock){+.+.}-{3:3}, at: hwm_energy+0x4b/0x100 [i915]
<4> [197.131543]
which lock already depends on the new lock.
...
<4> [197.507922] Chain exists of:
  fs_reclaim --> &gt->reset.mutex --> &hwmon->hwmon_lock
<4> [197.518528]  Possible unsafe locking scenario:
<4> [197.524411]        CPU0                    CPU1
<4> [197.528916]        ----                    ----
<4> [197.533418]   lock(&hwmon->hwmon_lock);
<4> [197.537237]                                lock(&gt->reset.mutex);
<4> [197.543376]                                lock(&hwmon->hwmon_lock);
<4> [197.549682]   lock(fs_reclaim);
...
<4> [197.632548] Call Trace:
<4> [197.634990]  <TASK>
<4> [197.637088]  dump_stack_lvl+0x64/0xb0
<4> [197.640738]  check_noncircular+0x15e/0x180
<4> [197.652968]  check_prev_add+0xe9/0xce0
<4> [197.656705]  __lock_acquire+0x179f/0x2300
<4> [197.660694]  lock_acquire+0xd8/0x2d0
<4> [197.673009]  fs_reclaim_acquire+0xa1/0xd0
<4> [197.680478]  __kmalloc+0x9a/0x350
<4> [197.689063]  acpi_ns_internalize_name.part.0+0x4a/0xb0
<4> [197.694170]  acpi_ns_get_node_unlocked+0x60/0xf0
<4> [197.720608]  acpi_ns_get_node+0x3b/0x60
<4> [197.724428]  acpi_get_handle+0x57/0xb0
<4> [197.728164]  acpi_has_method+0x20/0x50
<4> [197.731896]  acpi_pci_set_power_state+0x43/0x120
<4> [197.736485]  pci_power_up+0x24/0x1c0
<4> [197.740047]  pci_pm_default_resume_early+0x9/0x30
<4> [197.744725]  pci_pm_runtime_resume+0x2d/0x90
<4> [197.753911]  __rpm_callback+0x3c/0x110
<4> [197.762586]  rpm_callback+0x58/0x70
<4> [197.766064]  rpm_resume+0x51e/0x730
<4> [197.769542]  rpm_resume+0x267/0x730
<4> [197.773020]  rpm_resume+0x267/0x730
<4> [197.776498]  rpm_resume+0x267/0x730
<4> [197.779974]  __pm_runtime_resume+0x49/0x90
<4> [197.784055]  __intel_runtime_pm_get+0x19/0xa0 [i915]
<4> [197.789070]  hwm_energy+0x55/0x100 [i915]
<4> [197.793183]  hwm_read+0x9a/0x310 [i915]
<4> [197.797124]  hwmon_attr_show+0x36/0x120
<4> [197.800946]  dev_attr_show+0x15/0x60
<4> [197.804509]  sysfs_kf_seq_show+0xb5/0x100

Acquire the wakeref before the lock and hold it as long as the lock is
also held.  Follow that pattern across the whole source file where similar
lock inversion can happen.

v2: Keep hardware read under the lock so the whole operation of updating
    energy from hardware is still atomic (Guenter),
  - instead, acquire the rpm wakeref before the lock and hold it as long
    as the lock is held,
  - use the same aproach for other similar places across the i915_hwmon.c
    source file (Rodrigo).

Fixes: 1b44019a93e2 ("drm/i915/guc: Disable PL1 power limit when loading GuC firmware")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: <stable@vger.kernel.org> # v6.5+
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240311203500.518675-2-janusz.krzysztofik@linux.intel.com
(cherry picked from commit 71b218771426ea84c0e0148a2b7ac52c1f76e792)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_hwmon.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -72,12 +72,13 @@ hwm_locked_with_pm_intel_uncore_rmw(stru
 	struct intel_uncore *uncore = ddat->uncore;
 	intel_wakeref_t wakeref;
 
-	mutex_lock(&hwmon->hwmon_lock);
+	with_intel_runtime_pm(uncore->rpm, wakeref) {
+		mutex_lock(&hwmon->hwmon_lock);
 
-	with_intel_runtime_pm(uncore->rpm, wakeref)
 		intel_uncore_rmw(uncore, reg, clear, set);
 
-	mutex_unlock(&hwmon->hwmon_lock);
+		mutex_unlock(&hwmon->hwmon_lock);
+	}
 }
 
 /*
@@ -136,20 +137,21 @@ hwm_energy(struct hwm_drvdata *ddat, lon
 	else
 		rgaddr = hwmon->rg.energy_status_all;
 
-	mutex_lock(&hwmon->hwmon_lock);
+	with_intel_runtime_pm(uncore->rpm, wakeref) {
+		mutex_lock(&hwmon->hwmon_lock);
 
-	with_intel_runtime_pm(uncore->rpm, wakeref)
 		reg_val = intel_uncore_read(uncore, rgaddr);
 
-	if (reg_val >= ei->reg_val_prev)
-		ei->accum_energy += reg_val - ei->reg_val_prev;
-	else
-		ei->accum_energy += UINT_MAX - ei->reg_val_prev + reg_val;
-	ei->reg_val_prev = reg_val;
+		if (reg_val >= ei->reg_val_prev)
+			ei->accum_energy += reg_val - ei->reg_val_prev;
+		else
+			ei->accum_energy += UINT_MAX - ei->reg_val_prev + reg_val;
+		ei->reg_val_prev = reg_val;
 
-	*energy = mul_u64_u32_shr(ei->accum_energy, SF_ENERGY,
-				  hwmon->scl_shift_energy);
-	mutex_unlock(&hwmon->hwmon_lock);
+		*energy = mul_u64_u32_shr(ei->accum_energy, SF_ENERGY,
+					  hwmon->scl_shift_energy);
+		mutex_unlock(&hwmon->hwmon_lock);
+	}
 }
 
 static ssize_t
@@ -404,6 +406,7 @@ hwm_power_max_write(struct hwm_drvdata *
 
 	/* Block waiting for GuC reset to complete when needed */
 	for (;;) {
+		wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
 		mutex_lock(&hwmon->hwmon_lock);
 
 		prepare_to_wait(&ddat->waitq, &wait, TASK_INTERRUPTIBLE);
@@ -417,14 +420,13 @@ hwm_power_max_write(struct hwm_drvdata *
 		}
 
 		mutex_unlock(&hwmon->hwmon_lock);
+		intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
 
 		schedule();
 	}
 	finish_wait(&ddat->waitq, &wait);
 	if (ret)
-		goto unlock;
-
-	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
+		goto exit;
 
 	/* Disable PL1 limit and verify, because the limit cannot be disabled on all platforms */
 	if (val == PL1_DISABLE) {
@@ -444,9 +446,8 @@ hwm_power_max_write(struct hwm_drvdata *
 	intel_uncore_rmw(ddat->uncore, hwmon->rg.pkg_rapl_limit,
 			 PKG_PWR_LIM_1_EN | PKG_PWR_LIM_1, nval);
 exit:
-	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
-unlock:
 	mutex_unlock(&hwmon->hwmon_lock);
+	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
 	return ret;
 }
 



