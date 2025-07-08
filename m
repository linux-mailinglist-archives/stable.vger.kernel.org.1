Return-Path: <stable+bounces-161111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C379AFD36C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B55404FF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9D2DEA94;
	Tue,  8 Jul 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mlU4NRzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88936BE46;
	Tue,  8 Jul 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993626; cv=none; b=pa+3mMIGPhxCoV2X99bLqiMdgQQGhZtRvRmWepHjvT4XCkRxUlK4y53tcI1LWjj/sZ7cLo5l7li4/TnOUGAZo7o5JohAsEjRdfYUMZLqYpL6M3y2qZASno1asnoBSVG0wW4RSCSOCBf+Ty4ZYGNiHIh4c/34RrcNonfRqI8vcIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993626; c=relaxed/simple;
	bh=CFP9JcHxvMGbaOqWT67hcA3S43BgunyYs1skWqaFBK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pub59PuwAVeHygcWvFmtyqAHghlrnJHqgc57oQp3NjHOWQAzLQkuc8jWDCORrMzy6uDXCs16314syTwCDffhiG9EFYC7mHBbNDxtTllF/Ar/XJQ+V9oQ7ZHU94Y/bA8lqA+GlHBhU4VEXA5W9CBDFE7FyriJ7qEZ6e/vUo/EOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mlU4NRzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CD5C4CEED;
	Tue,  8 Jul 2025 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993626;
	bh=CFP9JcHxvMGbaOqWT67hcA3S43BgunyYs1skWqaFBK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlU4NRzItSqlF9ve3PjyMX/eTJUeJr82W3Gi3Qwrf4cPQTDm3ArMSTrOwDHbUnFkG
	 drosCbRy++d9e1wbAV5ubCo2zukhzy5rbA5R70VxYPVt32QeBmxdjzdahJ2UfN+8T/
	 sP8zddSAbXC+GRPwYfZUIyBCS3p7LXK6baB8MidU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 108/178] drm/xe/bmg: Update Wa_22019338487
Date: Tue,  8 Jul 2025 18:22:25 +0200
Message-ID: <20250708162239.450806063@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit 84c0b4a00610afbde650fdb8ad6db0424f7b2cc3 ]

Limit GT max frequency to 2600MHz and wait for frequency to reduce
before proceeding with a transient flush. This is really only needed for
the transient flush: if L2 flush is needed due to 16023588340 then
there's no need to do this additional wait since we are already using
the bigger hammer.

v2: Use generic names, ensure user set max frequency requests wait
for flush to complete (Rodrigo)
v3:
 - User requests wait via wait_var_event_timeout (Lucas)
 - Close races on flush + user requests (Lucas)
 - Fix xe_guc_pc_remove_flush_freq_limit() being called on last gt
   rather than root gt (Lucas)
v4:
 - Only apply the freq reducing part if a TDF is needed: L2 flush trumps
   the need for waiting a lower frequency

Fixes: aaa08078e725 ("drm/xe/bmg: Apply Wa_22019338487")
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Link: https://lore.kernel.org/r/20250618-wa-22019338487-v5-4-b888388477f2@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit deea6a7d6d803d6bb874a3e6f1b312e560e6c6df)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c       |   8 +-
 drivers/gpu/drm/xe/xe_guc_pc.c       | 125 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_guc_pc.h       |   2 +
 drivers/gpu/drm/xe/xe_guc_pc_types.h |   2 +
 4 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 38fdddd7262aa..f3123914b1abf 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -38,6 +38,7 @@
 #include "xe_gt_printk.h"
 #include "xe_gt_sriov_vf.h"
 #include "xe_guc.h"
+#include "xe_guc_pc.h"
 #include "xe_hw_engine_group.h"
 #include "xe_hwmon.h"
 #include "xe_irq.h"
@@ -1057,11 +1058,14 @@ void xe_device_td_flush(struct xe_device *xe)
 		return;
 
 	root_gt = xe_root_mmio_gt(xe);
-	if (XE_WA(root_gt, 16023588340))
+	if (XE_WA(root_gt, 16023588340)) {
 		/* A transient flush is not sufficient: flush the L2 */
 		xe_device_l2_flush(xe);
-	else
+	} else {
+		xe_guc_pc_apply_flush_freq_limit(&root_gt->uc.guc.pc);
 		tdf_request_sync(xe);
+		xe_guc_pc_remove_flush_freq_limit(&root_gt->uc.guc.pc);
+	}
 }
 
 u32 xe_device_ccs_bytes(struct xe_device *xe, u64 size)
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 28b97a2c14e3b..1c7b044413f26 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -7,7 +7,9 @@
 
 #include <linux/cleanup.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/ktime.h>
+#include <linux/wait_bit.h>
 
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
@@ -53,9 +55,11 @@
 #define LNL_MERT_FREQ_CAP	800
 #define BMG_MERT_FREQ_CAP	2133
 #define BMG_MIN_FREQ		1200
+#define BMG_MERT_FLUSH_FREQ_CAP	2600
 
 #define SLPC_RESET_TIMEOUT_MS 5 /* roughly 5ms, but no need for precision */
 #define SLPC_RESET_EXTENDED_TIMEOUT_MS 1000 /* To be used only at pc_start */
+#define SLPC_ACT_FREQ_TIMEOUT_MS 100
 
 /**
  * DOC: GuC Power Conservation (PC)
@@ -143,6 +147,36 @@ static int wait_for_pc_state(struct xe_guc_pc *pc,
 	return -ETIMEDOUT;
 }
 
+static int wait_for_flush_complete(struct xe_guc_pc *pc)
+{
+	const unsigned long timeout = msecs_to_jiffies(30);
+
+	if (!wait_var_event_timeout(&pc->flush_freq_limit,
+				    !atomic_read(&pc->flush_freq_limit),
+				    timeout))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int wait_for_act_freq_limit(struct xe_guc_pc *pc, u32 freq)
+{
+	int timeout_us = SLPC_ACT_FREQ_TIMEOUT_MS * USEC_PER_MSEC;
+	int slept, wait = 10;
+
+	for (slept = 0; slept < timeout_us;) {
+		if (xe_guc_pc_get_act_freq(pc) <= freq)
+			return 0;
+
+		usleep_range(wait, wait << 1);
+		slept += wait;
+		wait <<= 1;
+		if (slept + wait > timeout_us)
+			wait = timeout_us - slept;
+	}
+
+	return -ETIMEDOUT;
+}
 static int pc_action_reset(struct xe_guc_pc *pc)
 {
 	struct xe_guc_ct *ct = pc_to_ct(pc);
@@ -673,6 +707,11 @@ static int xe_guc_pc_set_max_freq_locked(struct xe_guc_pc *pc, u32 freq)
  */
 int xe_guc_pc_set_max_freq(struct xe_guc_pc *pc, u32 freq)
 {
+	if (XE_WA(pc_to_gt(pc), 22019338487)) {
+		if (wait_for_flush_complete(pc) != 0)
+			return -EAGAIN;
+	}
+
 	guard(mutex)(&pc->freq_lock);
 
 	return xe_guc_pc_set_max_freq_locked(pc, freq);
@@ -873,6 +912,92 @@ static int pc_adjust_requested_freq(struct xe_guc_pc *pc)
 	return ret;
 }
 
+static bool needs_flush_freq_limit(struct xe_guc_pc *pc)
+{
+	struct xe_gt *gt = pc_to_gt(pc);
+
+	return  XE_WA(gt, 22019338487) &&
+		pc->rp0_freq > BMG_MERT_FLUSH_FREQ_CAP;
+}
+
+/**
+ * xe_guc_pc_apply_flush_freq_limit() - Limit max GT freq during L2 flush
+ * @pc: the xe_guc_pc object
+ *
+ * As per the WA, reduce max GT frequency during L2 cache flush
+ */
+void xe_guc_pc_apply_flush_freq_limit(struct xe_guc_pc *pc)
+{
+	struct xe_gt *gt = pc_to_gt(pc);
+	u32 max_freq;
+	int ret;
+
+	if (!needs_flush_freq_limit(pc))
+		return;
+
+	guard(mutex)(&pc->freq_lock);
+
+	ret = xe_guc_pc_get_max_freq_locked(pc, &max_freq);
+	if (!ret && max_freq > BMG_MERT_FLUSH_FREQ_CAP) {
+		ret = pc_set_max_freq(pc, BMG_MERT_FLUSH_FREQ_CAP);
+		if (ret) {
+			xe_gt_err_once(gt, "Failed to cap max freq on flush to %u, %pe\n",
+				       BMG_MERT_FLUSH_FREQ_CAP, ERR_PTR(ret));
+			return;
+		}
+
+		atomic_set(&pc->flush_freq_limit, 1);
+
+		/*
+		 * If user has previously changed max freq, stash that value to
+		 * restore later, otherwise use the current max. New user
+		 * requests wait on flush.
+		 */
+		if (pc->user_requested_max != 0)
+			pc->stashed_max_freq = pc->user_requested_max;
+		else
+			pc->stashed_max_freq = max_freq;
+	}
+
+	/*
+	 * Wait for actual freq to go below the flush cap: even if the previous
+	 * max was below cap, the current one might still be above it
+	 */
+	ret = wait_for_act_freq_limit(pc, BMG_MERT_FLUSH_FREQ_CAP);
+	if (ret)
+		xe_gt_err_once(gt, "Actual freq did not reduce to %u, %pe\n",
+			       BMG_MERT_FLUSH_FREQ_CAP, ERR_PTR(ret));
+}
+
+/**
+ * xe_guc_pc_remove_flush_freq_limit() - Remove max GT freq limit after L2 flush completes.
+ * @pc: the xe_guc_pc object
+ *
+ * Retrieve the previous GT max frequency value.
+ */
+void xe_guc_pc_remove_flush_freq_limit(struct xe_guc_pc *pc)
+{
+	struct xe_gt *gt = pc_to_gt(pc);
+	int ret = 0;
+
+	if (!needs_flush_freq_limit(pc))
+		return;
+
+	if (!atomic_read(&pc->flush_freq_limit))
+		return;
+
+	mutex_lock(&pc->freq_lock);
+
+	ret = pc_set_max_freq(&gt->uc.guc.pc, pc->stashed_max_freq);
+	if (ret)
+		xe_gt_err_once(gt, "Failed to restore max freq %u:%d",
+			       pc->stashed_max_freq, ret);
+
+	atomic_set(&pc->flush_freq_limit, 0);
+	mutex_unlock(&pc->freq_lock);
+	wake_up_var(&pc->flush_freq_limit);
+}
+
 static int pc_set_mert_freq_cap(struct xe_guc_pc *pc)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.h b/drivers/gpu/drm/xe/xe_guc_pc.h
index 39102b79602fd..0302c7426ccde 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.h
+++ b/drivers/gpu/drm/xe/xe_guc_pc.h
@@ -37,5 +37,7 @@ u64 xe_guc_pc_mc6_residency(struct xe_guc_pc *pc);
 void xe_guc_pc_init_early(struct xe_guc_pc *pc);
 int xe_guc_pc_restore_stashed_freq(struct xe_guc_pc *pc);
 void xe_guc_pc_raise_unslice(struct xe_guc_pc *pc);
+void xe_guc_pc_apply_flush_freq_limit(struct xe_guc_pc *pc);
+void xe_guc_pc_remove_flush_freq_limit(struct xe_guc_pc *pc);
 
 #endif /* _XE_GUC_PC_H_ */
diff --git a/drivers/gpu/drm/xe/xe_guc_pc_types.h b/drivers/gpu/drm/xe/xe_guc_pc_types.h
index 2978ac9a249b5..c02053948a579 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_pc_types.h
@@ -15,6 +15,8 @@
 struct xe_guc_pc {
 	/** @bo: GGTT buffer object that is shared with GuC PC */
 	struct xe_bo *bo;
+	/** @flush_freq_limit: 1 when max freq changes are limited by driver */
+	atomic_t flush_freq_limit;
 	/** @rp0_freq: HW RP0 frequency - The Maximum one */
 	u32 rp0_freq;
 	/** @rpa_freq: HW RPa frequency - The Achievable one */
-- 
2.39.5




