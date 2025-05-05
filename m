Return-Path: <stable+bounces-140346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35928AAA7BF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C4E165707
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AF33EF9B;
	Mon,  5 May 2025 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzNJ28bV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAEA33EF67;
	Mon,  5 May 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484670; cv=none; b=o9zMO5gGYYy+pu6dvV0kwEA/3aOgYMq/rJBxmYcohmbPdnOKsfq+wH+vYpUp3lz3cS6B1CvCbji1Vk4GNje63Vpt4P8HS0PYU6kFBoon7mA4H0PRvfRsw5tvp4W7C4SkdZ2c6VCK6kjz/PelukkcXkab4SNpOm1CJr6lqRMaX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484670; c=relaxed/simple;
	bh=gFi6sHJ6tPLpA0YfCiCoQ4kFfd40G6cmYkYcUli5dVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwxbRWNLSlxAlNql9cJI/Ozq2uJP8++ifnqOMGVFSC6nsj5AQgojW2qeudo+gdT+xoqr5c6BULu7ub9vfSv4Pl9K9q8l+Eck7JnCglnB6Xe49ND+Zd1ECwLk/yWWHCcdoElYGWUiwgt8nL9ibJeLBtagoPajcR0bdXjxpEvcdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzNJ28bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04371C4CEED;
	Mon,  5 May 2025 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484669;
	bh=gFi6sHJ6tPLpA0YfCiCoQ4kFfd40G6cmYkYcUli5dVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzNJ28bVsmbegV0D5v2iEuU5uJzEApCOWDT/B1DBCNMv9F3UqBPn+AEDTgAA9bfB7
	 K59vcmK4eq4sdS7nHfwGo2vQQfZYsLhJJNDO6xNMmhgFiOwIQat85kc8ZKPX3hTyUc
	 wxJ80aPPjtXJCJ2niT3+0sBbmPFKcbRl3BW8o5UmoANdx3WXJW76nA/H1qSwu4zE0J
	 XYhplWuuLZ4/AnGnh680nr1RE20WGW2XMkwPwW/0CUBMTmp9YZ1qAMDuH9bg02vDya
	 UzXS9dqMbjxCxWrcIizyiW/e9dUv//7I7Q/fpNy6YjdgU+cz2/FfqwO1Z5NZZdWScQ
	 VNtworCnMOizw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 597/642] drm/xe/pf: Move VFs reprovisioning to worker
Date: Mon,  5 May 2025 18:13:33 -0400
Message-Id: <20250505221419.2672473-597-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit a4d1c5d0b99b75263a5626d2e52d569db3844b33 ]

Since the GuC is reset during GT reset, we need to re-send the
entire SR-IOV provisioning configuration to the GuC. But since
this whole configuration is protected by the PF master mutex and
we can't avoid making allocations under this mutex (like during
LMEM provisioning), we can't do this reprovisioning from gt-reset
path if we want to be reclaim-safe. Move VFs reprovisioning to a
async worker that we will start from the gt-reset path.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250125215505.720-1-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c       | 43 +++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h | 10 ++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
index b80930a6bc1a2..c08efca6420e7 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
@@ -15,7 +15,11 @@
 #include "xe_gt_sriov_pf_helpers.h"
 #include "xe_gt_sriov_pf_migration.h"
 #include "xe_gt_sriov_pf_service.h"
+#include "xe_gt_sriov_printk.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
+
+static void pf_worker_restart_func(struct work_struct *w);
 
 /*
  * VF's metadata is maintained in the flexible array where:
@@ -41,6 +45,11 @@ static int pf_alloc_metadata(struct xe_gt *gt)
 	return 0;
 }
 
+static void pf_init_workers(struct xe_gt *gt)
+{
+	INIT_WORK(&gt->sriov.pf.workers.restart, pf_worker_restart_func);
+}
+
 /**
  * xe_gt_sriov_pf_init_early - Prepare SR-IOV PF data structures on PF.
  * @gt: the &xe_gt to initialize
@@ -65,6 +74,8 @@ int xe_gt_sriov_pf_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	pf_init_workers(gt);
+
 	return 0;
 }
 
@@ -161,6 +172,35 @@ void xe_gt_sriov_pf_sanitize_hw(struct xe_gt *gt, unsigned int vfid)
 	pf_clear_vf_scratch_regs(gt, vfid);
 }
 
+static void pf_restart(struct xe_gt *gt)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+
+	xe_pm_runtime_get(xe);
+	xe_gt_sriov_pf_config_restart(gt);
+	xe_gt_sriov_pf_control_restart(gt);
+	xe_pm_runtime_put(xe);
+
+	xe_gt_sriov_dbg(gt, "restart completed\n");
+}
+
+static void pf_worker_restart_func(struct work_struct *w)
+{
+	struct xe_gt *gt = container_of(w, typeof(*gt), sriov.pf.workers.restart);
+
+	pf_restart(gt);
+}
+
+static void pf_queue_restart(struct xe_gt *gt)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+
+	xe_gt_assert(gt, IS_SRIOV_PF(xe));
+
+	if (!queue_work(xe->sriov.wq, &gt->sriov.pf.workers.restart))
+		xe_gt_sriov_dbg(gt, "restart already in queue!\n");
+}
+
 /**
  * xe_gt_sriov_pf_restart - Restart SR-IOV support after a GT reset.
  * @gt: the &xe_gt
@@ -169,6 +209,5 @@ void xe_gt_sriov_pf_sanitize_hw(struct xe_gt *gt, unsigned int vfid)
  */
 void xe_gt_sriov_pf_restart(struct xe_gt *gt)
 {
-	xe_gt_sriov_pf_config_restart(gt);
-	xe_gt_sriov_pf_control_restart(gt);
+	pf_queue_restart(gt);
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h
index 0426b1a77069a..a64a6835ad656 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h
@@ -35,8 +35,17 @@ struct xe_gt_sriov_metadata {
 	struct xe_gt_sriov_state_snapshot snapshot;
 };
 
+/**
+ * struct xe_gt_sriov_pf_workers - GT level workers used by the PF.
+ */
+struct xe_gt_sriov_pf_workers {
+	/** @restart: worker that executes actions post GT reset */
+	struct work_struct restart;
+};
+
 /**
  * struct xe_gt_sriov_pf - GT level PF virtualization data.
+ * @workers: workers data.
  * @service: service data.
  * @control: control data.
  * @policy: policy data.
@@ -45,6 +54,7 @@ struct xe_gt_sriov_metadata {
  * @vfs: metadata for all VFs.
  */
 struct xe_gt_sriov_pf {
+	struct xe_gt_sriov_pf_workers workers;
 	struct xe_gt_sriov_pf_service service;
 	struct xe_gt_sriov_pf_control control;
 	struct xe_gt_sriov_pf_policy policy;
-- 
2.39.5


