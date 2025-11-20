Return-Path: <stable+bounces-195275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13019C74510
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5BD4F7942
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AEE341070;
	Thu, 20 Nov 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJvTYk3a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E7340A4C
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645271; cv=none; b=KmUAbXQzKvAWamvJ79ZhUlCVO3oZ4Wv2fQWecVUwGlQ+826uJpVrtr973cghPZKCpv/LGXRBeV3sC45361qNY3l84ropxm1Vp8zB8A0cPj3gi6fo+6m5HzxkZZV/i5E4qWzUWiJpZkhfx3QKhkTP+LZeIZDW+UkYRZ4WNbZsEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645271; c=relaxed/simple;
	bh=IcKEET7hBR4ODS94EV/iVpUY2cnqLukR7BOxCGCitks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6KkrcfPJqcnQYC4ygw9TniQSe+BgDJavp7L5wgN9T4WklkyXQoogbNRcHrRs091u0G3PZ/FwHSen4nYivc5bJSJK7rVdAEZGhDxWfr8CyUqrpa3lATHVFtEY0tcGEpp5oKq3ir+bpFM2NZ3a8Wp/Wg3UXVs+oVt04vrfzTv7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJvTYk3a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763645268; x=1795181268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcKEET7hBR4ODS94EV/iVpUY2cnqLukR7BOxCGCitks=;
  b=dJvTYk3aGnK3xyy3LcXkyAGL04f4eqmVAHLuNDrS1F95jQcSecbdMBrj
   lUHNXfH3G/SOzT4VcFIOcq4rQiTxk12399SW7DN/g45VSSBG8m9Ol10HZ
   a6/IQNLEbiNcEDL1xttRKoIpUAhH5DNKWbX0hTZg6CKz5MDawTl3SpPhI
   oGWMHiIkcJyRSXAW1fkRIkyNRjwMnbf15Zr1uWQewoKZEMipTGYYP2Ve7
   MlEK9sDuD8GaIsNSz+F0K+u2I/nuOJ7yOAzNaWM45+qEU/idzN6TO4dEC
   VyHAS/W4nCE4TjzYmgr7Am18QXdcuCyEz/HKPGmyklUoQl2SitLru1pKd
   w==;
X-CSE-ConnectionGUID: Zo1mQ39VRvS/BM9RQF4Tfg==
X-CSE-MsgGUID: JdYcbv0gRUq4iOJqtzv3AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83335116"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="83335116"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 05:27:44 -0800
X-CSE-ConnectionGUID: 4MtpMdqXSoye52dT69hNqg==
X-CSE-MsgGUID: riLOElLyQECSPrr7CZdSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191485756"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.162])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 05:27:43 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Carl Zhang <carl.zhang@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Date: Thu, 20 Nov 2025 13:27:29 +0000
Message-ID: <20251120132727.575986-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120132727.575986-4-matthew.auld@intel.com>
References: <20251120132727.575986-4-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently this is very broken if someone attempts to create a bind
queue and share it across multiple VMs. For example currently we assume
it is safe to acquire the user VM lock to protect some of the bind queue
state, but if allow sharing the bind queue with multiple VMs then this
quickly breaks down.

To fix this reject using a bind queue with any VM that is not the same
VM that was originally passed when creating the bind queue. This a uAPI
change, however this was more of an oversight on kernel side that we
didn't reject this, and expectation is that userspace shouldn't be using
bind queues in this way, so in theory this change should go unnoticed.

Based on a patch from Matt Brost.

v2 (Matt B):
  - Hold the vm lock over queue create, to ensure it can't be closed as
    we attach the user_vm to the queue.
  - Make sure we actually check for NULL user_vm in destruction path.
v3:
  - Fix error path handling.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Carl Zhang <carl.zhang@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Acked-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c       | 32 +++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_exec_queue.h       |  1 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h |  6 +++++
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c     |  2 +-
 drivers/gpu/drm/xe/xe_vm.c               |  7 +++++-
 5 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 8724f8de67e2..779d7e7e2d2e 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -328,6 +328,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
  * @xe: Xe device.
  * @tile: tile which bind exec queue belongs to.
  * @flags: exec queue creation flags
+ * @user_vm: The user VM which this exec queue belongs to
  * @extensions: exec queue creation extensions
  *
  * Normalize bind exec queue creation. Bind exec queue is tied to migration VM
@@ -341,6 +342,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
  */
 struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 						struct xe_tile *tile,
+						struct xe_vm *user_vm,
 						u32 flags, u64 extensions)
 {
 	struct xe_gt *gt = tile->primary_gt;
@@ -377,6 +379,9 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 			xe_exec_queue_put(q);
 			return ERR_PTR(err);
 		}
+
+		if (user_vm)
+			q->user_vm = xe_vm_get(user_vm);
 	}
 
 	return q;
@@ -407,6 +412,11 @@ void xe_exec_queue_destroy(struct kref *ref)
 			xe_exec_queue_put(eq);
 	}
 
+	if (q->user_vm) {
+		xe_vm_put(q->user_vm);
+		q->user_vm = NULL;
+	}
+
 	q->ops->destroy(q);
 }
 
@@ -742,6 +752,22 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 		    XE_IOCTL_DBG(xe, eci[0].engine_instance != 0))
 			return -EINVAL;
 
+		vm = xe_vm_lookup(xef, args->vm_id);
+		if (XE_IOCTL_DBG(xe, !vm))
+			return -ENOENT;
+
+		err = down_read_interruptible(&vm->lock);
+		if (err) {
+			xe_vm_put(vm);
+			return err;
+		}
+
+		if (XE_IOCTL_DBG(xe, xe_vm_is_closed_or_banned(vm))) {
+			up_read(&vm->lock);
+			xe_vm_put(vm);
+			return -ENOENT;
+		}
+
 		for_each_tile(tile, xe, id) {
 			struct xe_exec_queue *new;
 
@@ -749,9 +775,11 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 			if (id)
 				flags |= EXEC_QUEUE_FLAG_BIND_ENGINE_CHILD;
 
-			new = xe_exec_queue_create_bind(xe, tile, flags,
+			new = xe_exec_queue_create_bind(xe, tile, vm, flags,
 							args->extensions);
 			if (IS_ERR(new)) {
+				up_read(&vm->lock);
+				xe_vm_put(vm);
 				err = PTR_ERR(new);
 				if (q)
 					goto put_exec_queue;
@@ -763,6 +791,8 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 				list_add_tail(&new->multi_gt_list,
 					      &q->multi_gt_link);
 		}
+		up_read(&vm->lock);
+		xe_vm_put(vm);
 	} else {
 		logical_mask = calc_validate_logical_mask(xe, eci,
 							  args->width,
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
index fda4d4f9bda8..37a9da22f420 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue.h
@@ -28,6 +28,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
 						 u32 flags, u64 extensions);
 struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 						struct xe_tile *tile,
+						struct xe_vm *user_vm,
 						u32 flags, u64 extensions);
 
 void xe_exec_queue_fini(struct xe_exec_queue *q);
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 771ffe35cd0c..3a4263c92b3d 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -54,6 +54,12 @@ struct xe_exec_queue {
 	struct kref refcount;
 	/** @vm: VM (address space) for this exec queue */
 	struct xe_vm *vm;
+	/**
+	 * @user_vm: User VM (address space) for this exec queue (bind queues
+	 * only)
+	 */
+	struct xe_vm *user_vm;
+
 	/** @class: class of this exec queue */
 	enum xe_engine_class class;
 	/**
diff --git a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
index 052a5071e69f..db023fb66a27 100644
--- a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
+++ b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
@@ -350,7 +350,7 @@ int xe_sriov_vf_ccs_init(struct xe_device *xe)
 		flags = EXEC_QUEUE_FLAG_KERNEL |
 			EXEC_QUEUE_FLAG_PERMANENT |
 			EXEC_QUEUE_FLAG_MIGRATE;
-		q = xe_exec_queue_create_bind(xe, tile, flags, 0);
+		q = xe_exec_queue_create_bind(xe, tile, NULL, flags, 0);
 		if (IS_ERR(q)) {
 			err = PTR_ERR(q);
 			goto err_ret;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index f9989a7a710c..7973d654540a 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1614,7 +1614,7 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 			if (!vm->pt_root[id])
 				continue;
 
-			q = xe_exec_queue_create_bind(xe, tile, create_flags, 0);
+			q = xe_exec_queue_create_bind(xe, tile, vm, create_flags, 0);
 			if (IS_ERR(q)) {
 				err = PTR_ERR(q);
 				goto err_close;
@@ -3571,6 +3571,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		}
 	}
 
+	if (XE_IOCTL_DBG(xe, q && vm != q->user_vm)) {
+		err = -EINVAL;
+		goto put_exec_queue;
+	}
+
 	/* Ensure all UNMAPs visible */
 	xe_svm_flush(vm);
 
-- 
2.51.1


