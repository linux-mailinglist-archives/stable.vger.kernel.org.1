Return-Path: <stable+bounces-200197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E8CA90FC
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893FB31D85FC
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70A354ADA;
	Fri,  5 Dec 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPiLfJVt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCEA352F9B
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961701; cv=none; b=PxUcLazqPtxZL3mhRD1S+bKbvnkkruP9KGXk1OOGeHJKndUqczeLJHswUB4dZMv51GRYK40ARvrpv0HXO9TVGzCYS6bKHSMVb1nmqkQNTZGKeH8AApJfPknsLIGJ6uf7FCY6N7PGVWzA5fkKOoDqqD9C6YVFLrZPeN8kiyOTG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961701; c=relaxed/simple;
	bh=pYdkb3n8v/XTYzqyR1s2pUuDRnhcJIROSSdK6rm8Zvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxmozVsv1bZ5RYTLCdQoAEUsnt4Tw3nYqJ+XpHv7/784cPVTiTFsyPXf2I+NOq7DrLTSJs/uzzPtmjN7ciDRQTID/j2sefh0JioI0xJ2MBL0TeUJa7UVtnlq4nBGwg2y88ULRDt4tJSPc6HTqqLaWcTFPnqhVApa9LZFC541LI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPiLfJVt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764961699; x=1796497699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYdkb3n8v/XTYzqyR1s2pUuDRnhcJIROSSdK6rm8Zvs=;
  b=JPiLfJVt3m42bkD8Shb/w+knV5R/ZR2TflTEDBimVB6zr/C3ZTrunwuY
   rpBs8zuJGeyGpbHOfjdDwVe7yhdOxRoUjTPNb7/ZLQtUzcYixqipj1oAh
   M4VSjUIuzuPhKRXdpo+8cotujsZeWWxSy2XZcsYxM0Hxe5Y5pV07QxplS
   dCmnXNpzI6gJuEjGIYV1b/a9547bwlnRultXjv25Eb840/bvB6Pe6Cn1C
   I+1mYZ0MFJ/ovuVGw6rQ3tjBRPZjKXHuXFU6nTYQEtiHoTZ9mFLVlpxz0
   UKqhSa26oJ4JUJFAMCtS/dOvmB09af96NFWQxTszk7Vu4P4U33u++0RGW
   Q==;
X-CSE-ConnectionGUID: lpTLU1FzRiOHvni5c/8NmA==
X-CSE-MsgGUID: q3p/n/wMRumHw0DHVJRNmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66188615"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="66188615"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:08:19 -0800
X-CSE-ConnectionGUID: Jg6Ybz9zRkqq/+ibs+z9NA==
X-CSE-MsgGUID: Tfu/6xFgR5WAoytBU2bUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="226013750"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2025 11:08:16 -0800
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
Subject: [PATCH 1/3] drm/xe/exec: Limit num_syncs to prevent oversized allocations
Date: Fri,  5 Dec 2025 19:05:08 +0000
Message-ID: <20251205190506.2426471-6-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205190506.2426471-5-shuicheng.lin@intel.com>
References: <20251205190506.2426471-5-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The exec ioctl allows userspace to specify an arbitrary num_syncs
value. Without bounds checking, a very large num_syncs can force
an excessively large allocation, leading to kernel warnings from
the page allocator as below.

Introduce XE_MAX_SYNCS (set to 1024) and reject any request
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

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Reported-by: Koen Koning <koen.koning@intel.com>
Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
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
 include/uapi/drm/xe_drm.h    | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 4d81210e41f5..fdc7d410defa 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (args->num_syncs) {
+		if (XE_IOCTL_DBG(xe, args->num_syncs > XE_MAX_SYNCS)) {
+			err = -EINVAL;
+			goto err_exec_queue;
+		}
+
 		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
 		if (!syncs) {
 			err = -ENOMEM;
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 876a076fa6c0..ae040989fca8 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1237,6 +1237,7 @@ struct drm_xe_vm_bind {
 	/** @pad2: MBZ */
 	__u32 pad2;
 
+#define XE_MAX_SYNCS 1024
 	/** @num_syncs: amount of syncs to wait on */
 	__u32 num_syncs;
 
-- 
2.50.1


