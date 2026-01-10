Return-Path: <stable+bounces-207927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A015FD0CAAE
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A5E3014DBA
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A21FF7C7;
	Sat, 10 Jan 2026 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTuGdW8Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854F1FF1C7
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006397; cv=none; b=Z5EjWE42Kh+uD1pnTV8wSl5LBzet1m2Ax7yXdsGVQFobEzC200gAJ6OCQPTcwldnBZNrPo0uMlKUuv8TQvbRdBnatN3QFKMNfBVZ37X+bP5X4H8mYaAg6LuTwwMJvwKFfRESv8tJpM9IvckF5/gze0RpuQ1qtAzErWEv/NdiY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006397; c=relaxed/simple;
	bh=lUNJC7BM4DoTLwCN4geoILRPgR4c0qBcwJoLmHynr/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGEZZ5UUiufdmzc+8oR0V7uWL7Y55YnlwdQF48865VDAXF78rpe2Ua15MgVLyQPgUH/hiId9Ruh8M1Pm02vW1jPxMUfCXMYnlA+15tTKsv6szuvSjHdwMzT7/w9E6QbuvKAW3iLyWavYnkFszynfqSDX4VbVGGYauo2ilE8qVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTuGdW8Q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768006396; x=1799542396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lUNJC7BM4DoTLwCN4geoILRPgR4c0qBcwJoLmHynr/k=;
  b=DTuGdW8QzQWxJoChZmV1IoqAl9+9U92UlTSpoiaDOqsg2HnsY8PqC2qO
   EZZQXluj1yuEalRUOyPvDxvveq67RiOj/9lAYqDuo6bB5uoDEFVGL1Kb1
   Mvr40ia5qWVsh+otAZYdAKXBXTEvF1EFLqcZNIoimnzp7Um4ggVF/SiY6
   Cry4968SeYWXiJFmSKpoXDVzSUui1YUsmFStwx+an4BD9H4NMo3VqqOL9
   q+LQjnBdlyEqzYv0DTHslXwGuFW7R4fx6ZJEMp+q3W58Ax1TukS8ut9MP
   peJH0vh9LiCI7U93DeJbcJl0xnroGPm11nL7oGtdKsnSscNUVyzUSEFcI
   w==;
X-CSE-ConnectionGUID: zFj5lNgvT1ChWm91CChs4g==
X-CSE-MsgGUID: BwYfvTyQTk+pRRdkdyYPkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="79683567"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="79683567"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 16:53:15 -0800
X-CSE-ConnectionGUID: nTd9GyNJSeen73qXKha91g==
X-CSE-MsgGUID: IfGAa79FRrW9dFn4NAzMOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="234300468"
Received: from dut6304bmgfrd.fm.intel.com ([10.36.21.42])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2026 16:53:15 -0800
From: Xin Wang <x.wang@intel.com>
To: stable@vger.kernel.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	Xin Wang <x.wang@intel.com>
Subject: [PATCH 6.12 1/2] drm/xe: make xe_gt_idle_disable_c6() handle the forcewake internally
Date: Sat, 10 Jan 2026 00:52:45 +0000
Message-ID: <20260110005246.608138-1-x.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 1313351e71181a4818afeb8dfe202e4162091ef6 ]

Move forcewake_get() into xe_gt_idle_enable_c6() to streamline the
code and make it easier to use.

Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Xin Wang <x.wang@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://lore.kernel.org/r/20250827000633.1369890-2-x.wang@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_idle.c | 20 +++++++++++++-------
 drivers/gpu/drm/xe/xe_gt_idle.h |  2 +-
 drivers/gpu/drm/xe/xe_guc_pc.c  | 10 +---------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_idle.c b/drivers/gpu/drm/xe/xe_gt_idle.c
index 67aba4140510..0ab9667c223f 100644
--- a/drivers/gpu/drm/xe/xe_gt_idle.c
+++ b/drivers/gpu/drm/xe/xe_gt_idle.c
@@ -204,11 +204,8 @@ static void gt_idle_fini(void *arg)
 
 	xe_gt_idle_disable_pg(gt);
 
-	if (gt_to_xe(gt)->info.skip_guc_pc) {
-		XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FW_GT));
+	if (gt_to_xe(gt)->info.skip_guc_pc)
 		xe_gt_idle_disable_c6(gt);
-		xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
-	}
 
 	sysfs_remove_files(kobj, gt_idle_attrs);
 	kobject_put(kobj);
@@ -266,14 +263,23 @@ void xe_gt_idle_enable_c6(struct xe_gt *gt)
 			RC_CTL_HW_ENABLE | RC_CTL_TO_MODE | RC_CTL_RC6_ENABLE);
 }
 
-void xe_gt_idle_disable_c6(struct xe_gt *gt)
+int xe_gt_idle_disable_c6(struct xe_gt *gt)
 {
+	unsigned int fw_ref;
+
 	xe_device_assert_mem_access(gt_to_xe(gt));
-	xe_force_wake_assert_held(gt_to_fw(gt), XE_FW_GT);
 
 	if (IS_SRIOV_VF(gt_to_xe(gt)))
-		return;
+		return 0;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (!fw_ref)
+		return -ETIMEDOUT;
 
 	xe_mmio_write32(gt, RC_CONTROL, 0);
 	xe_mmio_write32(gt, RC_STATE, 0);
+
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_idle.h b/drivers/gpu/drm/xe/xe_gt_idle.h
index 554447b5d46d..cdd02aa5c150 100644
--- a/drivers/gpu/drm/xe/xe_gt_idle.h
+++ b/drivers/gpu/drm/xe/xe_gt_idle.h
@@ -12,7 +12,7 @@ struct xe_gt;
 
 int xe_gt_idle_init(struct xe_gt_idle *gtidle);
 void xe_gt_idle_enable_c6(struct xe_gt *gt);
-void xe_gt_idle_disable_c6(struct xe_gt *gt);
+int xe_gt_idle_disable_c6(struct xe_gt *gt);
 void xe_gt_idle_enable_pg(struct xe_gt *gt);
 void xe_gt_idle_disable_pg(struct xe_gt *gt);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index af02803c145b..209bb7c0f9ac 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -1008,15 +1008,7 @@ int xe_guc_pc_gucrc_disable(struct xe_guc_pc *pc)
 	if (ret)
 		return ret;
 
-	ret = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (ret)
-		return ret;
-
-	xe_gt_idle_disable_c6(gt);
-
-	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
-
-	return 0;
+	return xe_gt_idle_disable_c6(gt);
 }
 
 /**
-- 
2.43.0


