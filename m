Return-Path: <stable+bounces-176802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DFB3DCB4
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A79179A0A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE62FB602;
	Mon,  1 Sep 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhZnGt6O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD42FB979
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715936; cv=none; b=RDAOCBRBnEH3QXGhRTkuDSqitvJbtMKQmsliQIYlB3/D1u2B8/mKmdgG5c7IDhYXloEHd/KSaWxPtpYqvn8M5Pao3cLtbqx4+9HYH/I6NldWI77TALXgk8bUR3PFl7V5fQZzhjzgYzPKkxH9A843PV+AjhJHAXo2UGj1HUpA6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715936; c=relaxed/simple;
	bh=myEraqHrwlpKq0dPBDwUdwmmV4+V7DyNocOkSyynlNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDKK5qGDg4+snb7vShsWyK7XmCKZNnC5Z0a9W3pPOFoGT0EEQ5PDCmxZxAejmZ5idwccGmGcQ89u2a+Z/nwaDPMM0qpe179DBD3BfXTLmNYBI8X4ciFaCyNy2qfOj02Qfs3bLYRcLkV0MIgCUyj6z0Y+r8E4LCSeRaLPDE0m/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhZnGt6O; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756715935; x=1788251935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=myEraqHrwlpKq0dPBDwUdwmmV4+V7DyNocOkSyynlNg=;
  b=RhZnGt6OK5c+sdw5H8RfcfST4QudgK8HuZwrO9IYnFiEqVRdkLCqJHZb
   mB9LXEKheTrYFV+JhdYw3QW93Cf/OKps3dzU4jjI/+SPNWpLp+knqVrKa
   0DRaVHtjAwP/Mr+FNbh1kMr2sJzNz0RXSmizrzYn2P+i0m6zBL+U+CKlo
   KVg8HRgq5uwo+hfgxCA70uc9DxEemm5+dbFjhn4zkbc00yHO712VsNvej
   VwykRrzHmE77dv6QZHAENksv28tGHP6D79M2ZW+jTEksiGpr3Ew0NQ1Yl
   wnQxbq8z5kqoSIBZ07Gw+yTtjQnl1m0+3XT3sMoDyYF3MJ8UHO03mJhcB
   w==;
X-CSE-ConnectionGUID: Y8YX2UOxTxaQrE50FHW/PQ==
X-CSE-MsgGUID: FQHOD0eJQiSsAtAM94Ab6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58899198"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58899198"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 01:38:54 -0700
X-CSE-ConnectionGUID: 0B5c18kcSkCkiGa2xICqIw==
X-CSE-MsgGUID: cy6rjyxGSs20FtFV8sRA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201910255"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.244.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 01:38:52 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v2 3/3] drm/xe: Block exec and rebind worker while evicting for suspend / hibernate
Date: Mon,  1 Sep 2025 10:38:29 +0200
Message-ID: <20250901083829.27341-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901083829.27341-1-thomas.hellstrom@linux.intel.com>
References: <20250901083829.27341-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the xe pm_notifier evicts for suspend / hibernate, there might be
racing tasks trying to re-validate again. This can lead to suspend taking
excessive time or get stuck in a live-lock. This behaviour becomes
much worse with the fix that actually makes re-validation bring back
bos to VRAM rather than letting them remain in TT.

Prevent that by having exec and the rebind worker waiting for a completion
that is set to block by the pm_notifier before suspend and is signaled
by the pm_notifier after resume / wakeup.

It's probably still possible to craft malicious applications that block
suspending. More work is pending to fix that.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4288
Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  2 ++
 drivers/gpu/drm/xe/xe_exec.c         |  9 +++++++++
 drivers/gpu/drm/xe/xe_pm.c           |  4 ++++
 drivers/gpu/drm/xe/xe_vm.c           | 14 ++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 092004d14db2..6602bd678cbc 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -507,6 +507,8 @@ struct xe_device {
 
 	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
 	struct notifier_block pm_notifier;
+	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
+	struct completion pm_block;
 
 	/** @pmt: Support the PMT driver callback interface */
 	struct {
diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 44364c042ad7..374c831e691b 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -237,6 +237,15 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto err_unlock_list;
 	}
 
+	/*
+	 * It's OK to block interruptible here with the vm lock held, since
+	 * on task freezing during suspend / hibernate, the call will
+	 * return -ERESTARTSYS and the IOCTL will be rerun.
+	 */
+	err = wait_for_completion_interruptible(&xe->pm_block);
+	if (err)
+		goto err_unlock_list;
+
 	vm_exec.vm = &vm->gpuvm;
 	vm_exec.flags = DRM_EXEC_INTERRUPTIBLE_WAIT;
 	if (xe_vm_in_lr_mode(vm)) {
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index bee9aacd82e7..f4c7a84270ea 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -306,6 +306,7 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	switch (action) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+		reinit_completion(&xe->pm_block);
 		xe_pm_runtime_get(xe);
 		err = xe_bo_evict_all_user(xe);
 		if (err)
@@ -322,6 +323,7 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		complete_all(&xe->pm_block);
 		xe_bo_notifier_unprepare_all_pinned(xe);
 		xe_pm_runtime_put(xe);
 		break;
@@ -348,6 +350,8 @@ int xe_pm_init(struct xe_device *xe)
 	if (err)
 		return err;
 
+	init_completion(&xe->pm_block);
+	complete_all(&xe->pm_block);
 	/* For now suspend/resume is only allowed with GuC */
 	if (!xe_device_uc_enabled(xe))
 		return 0;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 3ff3c67aa79d..edcdb0528f2a 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -394,6 +394,9 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 		list_move_tail(&gpuva_to_vma(gpuva)->combined_links.rebind,
 			       &vm->rebind_list);
 
+	if (!try_wait_for_completion(&vm->xe->pm_block))
+		return -EAGAIN;
+
 	ret = xe_bo_validate(gem_to_xe_bo(vm_bo->obj), vm, false);
 	if (ret)
 		return ret;
@@ -494,6 +497,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	xe_assert(vm->xe, xe_vm_in_preempt_fence_mode(vm));
 	trace_xe_vm_rebind_worker_enter(vm);
 
+	/*
+	 * This blocks the wq during suspend / hibernate.
+	 * Don't hold any locks.
+	 */
+retry_pm:
+	wait_for_completion(&vm->xe->pm_block);
 	down_write(&vm->lock);
 
 	if (xe_vm_is_closed_or_banned(vm)) {
@@ -503,6 +512,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	}
 
 retry:
+	if (!try_wait_for_completion(&vm->xe->pm_block)) {
+		up_write(&vm->lock);
+		goto retry_pm;
+	}
+
 	if (xe_vm_userptr_check_repin(vm)) {
 		err = xe_vm_userptr_pin(vm);
 		if (err)
-- 
2.50.1


