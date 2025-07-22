Return-Path: <stable+bounces-164246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC6B0DE78
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94433AC20C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927D2ECEAB;
	Tue, 22 Jul 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H1rqHt4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B382EA49E;
	Tue, 22 Jul 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193728; cv=none; b=pkc4zaZm7Gh6DbOEi3IALJu/MTvK2dTGK1KubB8ndV5NE0MgCQcAo5U5WA+MsoKEonvuhuSdXnragtB3qbm+0B1By2FRHUmFmbpw4XGrpw1W0qkOkj8pghjaMWIUtjaFtIzPvlsLVlHsBFiDOmkUses138r12OLbvEBYAKKYFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193728; c=relaxed/simple;
	bh=s/z/GdOz/ahvuBG7P2+EueTtN+wYeL7KfI2a3W0C70Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pss6kPOSkVsqmqzZlkwjAK5odiYffjApLWyvURdRK+os4ht6PWkY8v+qJ7IGx3BqVrCDYAdESSastcEnhhOueU4y8au/Y5nOvnazMxIyE5n8zLtjtZW8wlag5GDp96NP0RIMRAbNU9pxm3C7GVtzS7Lkk/JeOKaIbueFp33+GMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H1rqHt4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E2C4CEEB;
	Tue, 22 Jul 2025 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193728;
	bh=s/z/GdOz/ahvuBG7P2+EueTtN+wYeL7KfI2a3W0C70Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1rqHt4wQH15BTK01sM7uI6on4Dr26GGMmZgln780/yS8CcFlSRU+//g0OfdpQfJc
	 8Ocmwyj8VjeD8OHifY3ZMrbT70NLT6IGOn71y+m88QUKwAgWHGN1ky56POTuzCtSuI
	 moNh2kcG9IOOJl0asWmjb75mt0etSs1tRq+oVCBo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 147/187] drm/xe/pf: Prepare to stop SR-IOV support prior GT reset
Date: Tue, 22 Jul 2025 15:45:17 +0200
Message-ID: <20250722134351.263077950@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 81dccec448d204e448ae83e1fe60e8aaeaadadb8 ]

As part of the resume or GT reset, the PF driver schedules work
which is then used to complete restarting of the SR-IOV support,
including resending to the GuC configurations of provisioned VFs.

However, in case of short delay between those two actions, which
could be seen by triggering a GT reset on the suspened device:

 $ echo 1 > /sys/kernel/debug/dri/0000:00:02.0/gt0/force_reset

this PF worker might be still busy, which lead to errors due to
just stopped or disabled GuC CTB communication:

 [ ] xe 0000:00:02.0: [drm:xe_gt_resume [xe]] GT0: resumed
 [ ] xe 0000:00:02.0: [drm] GT0: trying reset from force_reset_show [xe]
 [ ] xe 0000:00:02.0: [drm] GT0: reset queued
 [ ] xe 0000:00:02.0: [drm] GT0: reset started
 [ ] xe 0000:00:02.0: [drm:guc_ct_change_state [xe]] GT0: GuC CT communication channel stopped
 [ ] xe 0000:00:02.0: [drm:guc_ct_send_recv [xe]] GT0: H2G request 0x5503 canceled!
 [ ] xe 0000:00:02.0: [drm] GT0: PF: Failed to push VF1 12 config KLVs (-ECANCELED)
 [ ] xe 0000:00:02.0: [drm] GT0: PF: Failed to push VF1 configuration (-ECANCELED)
 [ ] xe 0000:00:02.0: [drm:guc_ct_change_state [xe]] GT0: GuC CT communication channel disabled
 [ ] xe 0000:00:02.0: [drm] GT0: PF: Failed to push VF2 12 config KLVs (-ENODEV)
 [ ] xe 0000:00:02.0: [drm] GT0: PF: Failed to push VF2 configuration (-ENODEV)
 [ ] xe 0000:00:02.0: [drm] GT0: PF: Failed to push 2 of 2 VFs configurations
 [ ] xe 0000:00:02.0: [drm:pf_worker_restart_func [xe]] GT0: PF: restart completed

While this VFs reprovisioning will be successful during next spin
of the worker, to avoid those errors, make sure to cancel restart
worker if we are about to trigger next reset.

Fixes: 411220808cee ("drm/xe/pf: Restart VFs provisioning after GT reset")
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Link: https://lore.kernel.org/r/20250711193316.1920-2-michal.wajdeczko@intel.com
(cherry picked from commit 9f50b729dd61dfb9f4d7c66900d22a7c7353a8c0)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt.c          |  3 +++
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c | 19 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_sriov_pf.h |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 4bad8894fa12c..7b8556fa17435 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -797,6 +797,9 @@ static int gt_reset(struct xe_gt *gt)
 		goto err_out;
 	}
 
+	if (IS_SRIOV_PF(gt_to_xe(gt)))
+		xe_gt_sriov_pf_stop_prepare(gt);
+
 	xe_uc_gucrc_disable(&gt->uc);
 	xe_uc_stop_prepare(&gt->uc);
 	xe_gt_pagefault_reset(gt);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
index c08efca6420e7..35489fa818259 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
@@ -172,6 +172,25 @@ void xe_gt_sriov_pf_sanitize_hw(struct xe_gt *gt, unsigned int vfid)
 	pf_clear_vf_scratch_regs(gt, vfid);
 }
 
+static void pf_cancel_restart(struct xe_gt *gt)
+{
+	xe_gt_assert(gt, IS_SRIOV_PF(gt_to_xe(gt)));
+
+	if (cancel_work_sync(&gt->sriov.pf.workers.restart))
+		xe_gt_sriov_dbg_verbose(gt, "pending restart canceled!\n");
+}
+
+/**
+ * xe_gt_sriov_pf_stop_prepare() - Prepare to stop SR-IOV support.
+ * @gt: the &xe_gt
+ *
+ * This function can only be called on the PF.
+ */
+void xe_gt_sriov_pf_stop_prepare(struct xe_gt *gt)
+{
+	pf_cancel_restart(gt);
+}
+
 static void pf_restart(struct xe_gt *gt)
 {
 	struct xe_device *xe = gt_to_xe(gt);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf.h
index f474509411c0c..e2b2ff8132dc5 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.h
@@ -13,6 +13,7 @@ int xe_gt_sriov_pf_init_early(struct xe_gt *gt);
 int xe_gt_sriov_pf_init(struct xe_gt *gt);
 void xe_gt_sriov_pf_init_hw(struct xe_gt *gt);
 void xe_gt_sriov_pf_sanitize_hw(struct xe_gt *gt, unsigned int vfid);
+void xe_gt_sriov_pf_stop_prepare(struct xe_gt *gt);
 void xe_gt_sriov_pf_restart(struct xe_gt *gt);
 #else
 static inline int xe_gt_sriov_pf_init_early(struct xe_gt *gt)
@@ -29,6 +30,10 @@ static inline void xe_gt_sriov_pf_init_hw(struct xe_gt *gt)
 {
 }
 
+static inline void xe_gt_sriov_pf_stop_prepare(struct xe_gt *gt)
+{
+}
+
 static inline void xe_gt_sriov_pf_restart(struct xe_gt *gt)
 {
 }
-- 
2.39.5




