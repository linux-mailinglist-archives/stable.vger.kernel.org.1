Return-Path: <stable+bounces-176699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE198B3B9FD
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA48F2054FC
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D62C11D3;
	Fri, 29 Aug 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yz9Iv2vL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE529E110
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467270; cv=none; b=BTDNcS/vdj/r127gYTT9pRcBj67fUEjCMvuy8LEQMs/4UEQEiRI85/91+Lm0aavOTFSdxp+9OFbpi7RZTYk99oIj+G9/C9liutFQdpjXrB0c4LR3ic0Fumg0tLCqb/566ifs6oPFP1VtwiCN+ivehB4xi/ZAo8ThrMVLg2QNbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467270; c=relaxed/simple;
	bh=c4pMw3FnvNq3gw9sGMMKq1FeYDvsHSq7a/zH8qGWbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPkYie3pARDSKKt26Wmh0ssoCBio9igynzeiw96e9DYjcytq0taxf7JK6wtHuevlX2N85qU5RT2MABR2QO3B0IP9MfdKPvyR3LCSVnqFjQTign7+8/bjayXtwwIIGF9KIWVDtxnZZM/C8x5IM11uZbKr2z6XWp8/bgWbmeaYEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yz9Iv2vL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756467268; x=1788003268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4pMw3FnvNq3gw9sGMMKq1FeYDvsHSq7a/zH8qGWbAE=;
  b=Yz9Iv2vLDh1ndCHKO+qLtc+3BrIrvlmbHTM1HXBycVZI3y1v5317k8Gt
   fw4UdgbOZ2WZhpXfYY+6Mq22miJIw7qBgPldaFItV27yvRRGvh/jWQ2v+
   FnMCo0IlrWwhYrCgmVrezcUkF9/nREuZfTJs5F9kO49G1RpOaEYeEvM0S
   eqnIXFj6aqHkf/1jWjeZsV42ln893oUtXD3XrG9RHGUNnHCjb07iNzgDZ
   H3zKeu/OqXLE2PCO/GUEKhma7/ZqjY8B8ks4YnPozWU4EceABdFOt2eIz
   hxekEVamE2JdpD5QQ6BA9kY8xeac/LDVDJDFB29yAYuQazYT17mALx1qX
   w==;
X-CSE-ConnectionGUID: 0IyPW2aZTBq6MQ56uibL+A==
X-CSE-MsgGUID: +XiernpZSrieJBm3XM7g/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69025648"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69025648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:34:28 -0700
X-CSE-ConnectionGUID: bO0q5sf3RROHMhO7OvijNg==
X-CSE-MsgGUID: eTbbSM7pTg6A4iZA3YZQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170748287"
Received: from agladkov-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:34:26 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 3/3] drm/xe: Block exec and rebind worker while evicting for suspend / hibernate
Date: Fri, 29 Aug 2025 13:33:50 +0200
Message-ID: <20250829113350.40959-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
References: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
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
index b57b46ad9f7c..2d7b05d8a78b 100644
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
@@ -318,6 +319,7 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		complete_all(&xe->pm_block);
 		xe_pm_runtime_get(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
 		xe_pm_runtime_put(xe);
@@ -345,6 +347,8 @@ int xe_pm_init(struct xe_device *xe)
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


