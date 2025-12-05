Return-Path: <stable+bounces-200208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F5CA98C5
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 23:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C64F304A12B
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 22:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0126F467;
	Fri,  5 Dec 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAGR/QhN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FC40855
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975173; cv=none; b=PeDRr40XqlSgoODA+GtpI/ecPCxdRLB9LP5y6McRtkGdM5gYKHEzmOcJF906eMy29oZ1OyOTUL7hgzbBgsfuXojKc2DfoDVbbZ9kaae3B0J8bpup60UvH9C7SmvFVkTlGkoLpn7PndgOhLGRmt15r31rQ5ABU1uFByw7lXrB9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975173; c=relaxed/simple;
	bh=Wu5/FXD8+u5RZGwRY8d0Cf0RY8+i2O9zRz52d/c/qF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT+xowbo0sc3KseK6U7aXTsWcV1cnDJ4P8UbdDOmv7aer9X5tVKvQa/Q+GLIoT926VUzz9LOQrIj5cHkEIwduXYU1kJ85mB2Tcy/pXxhZAiA0bMBW/9SQhaKH7htyYyyo9//3qoHvDD81Kf+4YxQ8ryfS/b+Ljp/WTytDqukIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAGR/QhN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764975172; x=1796511172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wu5/FXD8+u5RZGwRY8d0Cf0RY8+i2O9zRz52d/c/qF4=;
  b=lAGR/QhNlBWz/ZUaP8MY/ooU3VXTPCrAke1HCJDB7P1TW0ICbR8DCAG5
   nFnCnv26skFD9uSlCQmnIl9wj4Hw7mDnt8KPMpi9u+dswFecl26nu5qQH
   4ZqB1sgC9BxoE9n4YpcxugZIyeXnAyPpPTeTHaFXn1ekvAG7Pg3xTb2/c
   wx5JhfoZQaapOgPH8T9nRJ+XGIkbhLwKita3rOUAmtx+CyU/7KPYWl3Bx
   tMM5XqEYiWJz9D+fJFr9iH12jaZ9aOfBuOtS2kinRjdAcijdGEurKpL+R
   T4qG2HsEDoUdsm6aw2a58J42Kdps7xShi9Eznf3cEcoJQAQKQdRxFB7sW
   g==;
X-CSE-ConnectionGUID: z8heSYTjSs+Ar92Isi8FZA==
X-CSE-MsgGUID: mraoCo9nSsiVU6sWdDBBLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="70862074"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="70862074"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 14:52:51 -0800
X-CSE-ConnectionGUID: iO/4cuo2SrKsoy4xdCnnAg==
X-CSE-MsgGUID: gIel+v6ZSe6fC9mGeafFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="195849027"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by fmviesa009.fm.intel.com with ESMTP; 05 Dec 2025 14:52:48 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Carl Zhang <carl.zhang@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	Ivan Briano <ivan.briano@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 1/2] drm/xe: Limit num_syncs to prevent oversized allocations
Date: Fri,  5 Dec 2025 22:48:10 +0000
Message-ID: <20251205224808.2466416-5-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205224808.2466416-4-shuicheng.lin@intel.com>
References: <20251205224808.2466416-4-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The exec and vm_bind ioctl allow userspace to specify an arbitrary
num_syncs value. Without bounds checking, a very large num_syncs
can force an excessively large allocation, leading to kernel warnings
from the page allocator as below.

Introduce DRM_XE_MAX_SYNCS (set to 1024) and reject any request
exceeding this limit.

"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1217 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2f8/0x2180 mm/page_alloc.c:5124
...
Call Trace:
 <TASK>
 alloc_pages_mpol+0xe4/0x330 mm/mempolicy.c:2416
 ___kmalloc_large_node+0xd8/0x110 mm/slub.c:4317
 __kmalloc_large_node_noprof+0x18/0xe0 mm/slub.c:4348
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x3d4/0x4b0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 xe_exec_ioctl+0xa47/0x1e70 drivers/gpu/drm/xe/xe_exec.c:158
 drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:797
 drm_ioctl+0x5e7/0xc50 drivers/gpu/drm/drm_ioctl.c:894
 xe_drm_ioctl+0x10b/0x170 drivers/gpu/drm/xe/xe_device.c:224
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xbb/0x380 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
...
"

v2: Add "Reported-by" and Cc stable kernels.
v3: Change XE_MAX_SYNCS from 64 to 1024. (Matt & Ashutosh)
v4: s/XE_MAX_SYNCS/DRM_XE_MAX_SYNCS/ (Matt)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Reported-by: Koen Koning <koen.koning@intel.com>
Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
Cc: <stable@vger.kernel.org> # v6.12+
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Carl Zhang <carl.zhang@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Ivan Briano <ivan.briano@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_exec.c | 5 +++++
 drivers/gpu/drm/xe/xe_vm.c   | 3 +++
 include/uapi/drm/xe_drm.h    | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 4d81210e41f5..0356d40ee8e4 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (args->num_syncs) {
+		if (XE_IOCTL_DBG(xe, args->num_syncs > DRM_XE_MAX_SYNCS)) {
+			err = -EINVAL;
+			goto err_exec_queue;
+		}
+
 		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
 		if (!syncs) {
 			err = -ENOMEM;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c2012d20faa6..24eced1d970c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3341,6 +3341,9 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 	if (XE_IOCTL_DBG(xe, args->extensions))
 		return -EINVAL;
 
+	if (XE_IOCTL_DBG(xe, args->num_syncs > DRM_XE_MAX_SYNCS))
+		return -EINVAL;
+
 	if (args->num_binds > 1) {
 		u64 __user *bind_user =
 			u64_to_user_ptr(args->vector_of_binds);
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 876a076fa6c0..f7f3573b8d6f 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1484,6 +1484,7 @@ struct drm_xe_exec {
 	/** @exec_queue_id: Exec queue ID for the batch buffer */
 	__u32 exec_queue_id;
 
+#define DRM_XE_MAX_SYNCS 1024
 	/** @num_syncs: Amount of struct drm_xe_sync in array. */
 	__u32 num_syncs;
 
-- 
2.50.1


