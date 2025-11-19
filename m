Return-Path: <stable+bounces-195143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E39C6C6C5
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4310C4E5A1B
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E5285073;
	Wed, 19 Nov 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvmzSXWo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFA15ECCC
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520328; cv=none; b=STspBSS4YpTz0vQFM+cfLS5Ge5Mm9cGmjBIUNfVsoabxqiMW2tuIjBtBvDLGxig1ZvXTB/yx7z/GNbFRhirKqi7Wxwp+VRKDT++KBjFBwsYMwf+5EyGSDSt29gMdYCSZ8THgCvp5Y9eMANwl43KC84gJfh4G10MNinVb8e30vCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520328; c=relaxed/simple;
	bh=BinYbUUSNfd/1Qc5DQDlaH+ZkiJrjVRbWCCQhIiNf6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgJxE6+5UfqKtP/25uefbaPFiYbANfDi4Cu1o+8icBukRef12KLuqRFWhJmcmCxZSxnBVbm17AIMxerkYZrdn5z1PI1hkwkIM/rRZqYaPK5lgiNsURBwKZZ7oj0SF1z8EUK47MYjycCvF+UD5B2S6zxnb6wVWQVLGTHSKlCvNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvmzSXWo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763520327; x=1795056327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BinYbUUSNfd/1Qc5DQDlaH+ZkiJrjVRbWCCQhIiNf6U=;
  b=WvmzSXWo4Mgu1QANjhFLMMileZFaJ/kF+NbpmTC0tO3F+SCc7LR2HTQ0
   xTWaF/+7iCrl0oSh/8wHgRAL7/rwYSqmoL8y1nb5cwNK4H6AR+BVwzUiG
   GJF/IPFD66GShfbUKZ32SeRTIaVG1kgOO94U1g26Gu5C10fdCZNGK32bx
   Y5Z9iGn/VyFs4aYGjB8z1+Xbv2qLL592BIsE/ToGDb4XRxmd81l0WWq1p
   pwtH1nbnlve5d/0IYY82EP7UUIbJ55p7Qy1vkVwZAoIzgaRQ/2wdmzwHu
   +FJc+UqE2/AZCdWkFLxhYhgz2BekABG7CDEHW2rCmIxGLIexDsSVfxYPH
   A==;
X-CSE-ConnectionGUID: 0BC3NzY1Sk+CQXr29PnZog==
X-CSE-MsgGUID: COLN+T3eTTCgl84nbdHmlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69172814"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="69172814"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 18:45:27 -0800
X-CSE-ConnectionGUID: IMKnPxGeS9mRKAu8ouLyxA==
X-CSE-MsgGUID: r5h6p7J2T3aSNC0BKE2x4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="228267877"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by orviesa001.jf.intel.com with ESMTP; 18 Nov 2025 18:45:24 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2] drm/xe/exec: Validate num_syncs to prevent oversized allocations
Date: Wed, 19 Nov 2025 02:42:54 +0000
Message-ID: <20251119024253.91942-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exec ioctl allows userspace to specify an arbitrary num_syncs
value. Without bounds checking, a very large num_syncs can force
an excessively large allocation, leading to kernel warnings from
the page allocator as below.

Introduce XE_EXEC_MAX_SYNCS (set to 64) and reject any request
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

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Reported-by: Koen Koning <koen.koning@intel.com>
Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
Cc: <stable@vger.kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_exec.c | 5 +++++
 include/uapi/drm/xe_drm.h    | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 4d81210e41f5..01c56fd95d5b 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (args->num_syncs) {
+		if (XE_IOCTL_DBG(xe, args->num_syncs > XE_EXEC_MAX_SYNCS)) {
+			err = -EINVAL;
+			goto err_exec_queue;
+		}
+
 		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
 		if (!syncs) {
 			err = -ENOMEM;
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 47853659a705..1901ca26621a 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1463,6 +1463,7 @@ struct drm_xe_exec {
 	/** @exec_queue_id: Exec queue ID for the batch buffer */
 	__u32 exec_queue_id;
 
+#define XE_EXEC_MAX_SYNCS 64
 	/** @num_syncs: Amount of struct drm_xe_sync in array. */
 	__u32 num_syncs;
 
-- 
2.49.0


