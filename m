Return-Path: <stable+bounces-210486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAXGNSFwcGktYAAAu9opvQ
	(envelope-from <stable+bounces-210486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:20:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E251F9E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8561D56875D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99D3DA7EF;
	Tue, 20 Jan 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwLNON5I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522123A9611
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907193; cv=none; b=WQFXLjc2C8SPcv71R7a6kjxOfENwh8tVInhl8cy5Wo70Bj/PpVaBl3Z/7i7qDN2g+LmSPtISOdNzbx9EIk/UlqAFa7H3TYn8I35l2lZ7aCjk1KHd4zd3Ui0tvNhEzgjKNKyrA947WYSfw+PXVsqAYjxQBzhDHjxkW86P2EyVTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907193; c=relaxed/simple;
	bh=PdEFh4w2HGHIcyUxq9kVsE0ObuDDlz5FSJcCU9RrpMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrBEEQFN1JmNmfxB8S85TH/k7C6iZadmtk3HU9jBWZoppXxYkgEjOwFSxDLuRUNWSW2/qjZksXMcnBy/EdkDgXNwe5b8Ro/y6Sxr4OWexLg6KNjU7EDdgVc9kvQRupoSZeQI/QZ5woTF+mZFNsuOfSGFPTMefQLLaWcc6W6c5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwLNON5I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768907191; x=1800443191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PdEFh4w2HGHIcyUxq9kVsE0ObuDDlz5FSJcCU9RrpMg=;
  b=KwLNON5I/zFUcwD7Amh60dQYLsZRDcnndk/YtEiDilyfoRaEbQkDF8Mf
   YADfTobZKYVlWDqISWYX7V50CwUgXEVmOI/DwgZAtXO1howjRUFyfXQzu
   pIQrOZjEC+OQFnyc0EH9nkMnGrU8hdVP44BibvrhJC8S5ygPb9Y73sTsL
   92mFypUPyDIiVefmNfFzbnqLSltFcvu68HSSTK6Yk59DyIOlGWnOOzk4Q
   t9+cC+yEyeBBWjO2OciBn7lHCasPpkPLRmJoDUAhg1itmTfWQTUaifhh2
   MM+2/WYSZxzEBCZXo3xJRKUBnNeST2Gj1SQX9MtX6atxNUPdtJ795sT43
   Q==;
X-CSE-ConnectionGUID: 3BRp+ycWRY+XHnsDbV+4xg==
X-CSE-MsgGUID: z7lOC86FQpmoT534rqwRIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80833556"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80833556"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 03:06:31 -0800
X-CSE-ConnectionGUID: EtPvXMKhTzaFXxGDGogOjQ==
X-CSE-MsgGUID: COIUq4RtTDWv4j0mH4g/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="229029116"
Received: from amilburn-desk.amilburn-desk (HELO mwauld-desk.intel.com) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 03:06:29 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Carl Zhang <carl.zhang@intel.com>,
	stable@vger.kernel.org,
	Arvind Yadav <arvind.yadav@intel.com>
Subject: [CI 1/2] drm/xe/uapi: disallow bind queue sharing
Date: Tue, 20 Jan 2026 11:06:10 +0000
Message-ID: <20260120110609.77958-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-210486-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8F1E251F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Arvind Yadav <arvind.yadav@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
---
 drivers/gpu/drm/xe/xe_exec_queue.c       | 32 +++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_exec_queue.h       |  1 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h |  6 +++++
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c     |  2 +-
 drivers/gpu/drm/xe/xe_vm.c               |  7 +++++-
 5 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index a58968a0a781..7e7e663189e4 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -412,6 +412,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
  * @xe: Xe device.
  * @tile: tile which bind exec queue belongs to.
  * @flags: exec queue creation flags
+ * @user_vm: The user VM which this exec queue belongs to
  * @extensions: exec queue creation extensions
  *
  * Normalize bind exec queue creation. Bind exec queue is tied to migration VM
@@ -425,6 +426,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
  */
 struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 						struct xe_tile *tile,
+						struct xe_vm *user_vm,
 						u32 flags, u64 extensions)
 {
 	struct xe_gt *gt = tile->primary_gt;
@@ -461,6 +463,9 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
 			xe_exec_queue_put(q);
 			return ERR_PTR(err);
 		}
+
+		if (user_vm)
+			q->user_vm = xe_vm_get(user_vm);
 	}
 
 	return q;
@@ -491,6 +496,11 @@ void xe_exec_queue_destroy(struct kref *ref)
 			xe_exec_queue_put(eq);
 	}
 
+	if (q->user_vm) {
+		xe_vm_put(q->user_vm);
+		q->user_vm = NULL;
+	}
+
 	q->ops->destroy(q);
 }
 
@@ -1121,6 +1131,22 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
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
 
@@ -1128,9 +1154,11 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
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
@@ -1142,6 +1170,8 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 				list_add_tail(&new->multi_gt_list,
 					      &q->multi_gt_link);
 		}
+		up_read(&vm->lock);
+		xe_vm_put(vm);
 	} else {
 		logical_mask = calc_validate_logical_mask(xe, eci,
 							  args->width,
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
index b1e51789128f..c9e3a7c2d249 100644
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
index 601e742c79ff..e987d431ce27 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -92,6 +92,12 @@ struct xe_exec_queue {
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
index 67c9348b36dd..2b2afbb5da93 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1651,7 +1651,7 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
 			if (!vm->pt_root[id])
 				continue;
 
-			q = xe_exec_queue_create_bind(xe, tile, create_flags, 0);
+			q = xe_exec_queue_create_bind(xe, tile, vm, create_flags, 0);
 			if (IS_ERR(q)) {
 				err = PTR_ERR(q);
 				goto err_close;
@@ -3647,6 +3647,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
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
2.52.0


