Return-Path: <stable+bounces-195436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2539C76A58
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 00:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 4AC0228E0F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEBC30DEDD;
	Thu, 20 Nov 2025 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSAEDPwc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD530DD16
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682329; cv=none; b=imhFa9FPOtAes3mZkS9n8CY+iSMlMW1/b+KWlgWqlL4WtAkRwylGml5fuIXZlFFnHWyLZALJp+sbnBIhzeU2Q9FRtOKMSuaWVloDoFofNawxxQHoBi8jfhwa8Ev1AkPDRm1NBgHueDiSHhfgc4VciXpOXFZPEcnQIoL5Xra4YRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682329; c=relaxed/simple;
	bh=9lIHYCSTcRSR/s8JLmeMZzpnXSlwApdKoObVN6CQO8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeZNb8sPa4WcrrQaVTraL5Nkxbg8kKrhoqI5fbjF++bh7+elOdlZg1ZKCuaWhU/aFcS5bJ5txbzQ/rr7L8lrSdIl6JKGCq9Lu72M8vTlUkrr6mGl44silveFksN9vL1HBDLhy8rGO8dUmtmgYCrIu0Fp+5ZNXfjQXS8H0SVrevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSAEDPwc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763682327; x=1795218327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9lIHYCSTcRSR/s8JLmeMZzpnXSlwApdKoObVN6CQO8g=;
  b=BSAEDPwcmv/OZV+ZP3YDLW5VeZNK+LI32SgkmdXe16EgbzGm8SFir1bd
   bo3+3L5RQq3lUXdT/Wn1JRdXyanXLN8Tcu63tzRN9JMpPzWdgf1CMxs3k
   qQ0CI2C6B16ufGliGhMarxFNxDTIpuE//33Y29pk3NyDSlov61YQX2s/s
   vRoT/xh7uYRqu0n4DCDdwjFWzxtQ+C+NVuSZMbEVYFqsmLwj2eywJ4NxN
   uwKlRJz4NI4hZfxjgS1C2/15DqqqohVD9yHYo1dEEzcuEs2UnBpn8kaPh
   sXCk7WPZuPoOTaMd7P73wUmfLEMBbnalZdcKaOtzajJefFs/R1G4MCTqY
   g==;
X-CSE-ConnectionGUID: K+Lea6NJTDOuSBEBhFmkbw==
X-CSE-MsgGUID: 6fT4sb23R/yL8Otyfoq+mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65807605"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65807605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 15:45:26 -0800
X-CSE-ConnectionGUID: Gkdc8KvBRWGwAjAKTsqJzQ==
X-CSE-MsgGUID: I1IUKRo5TwauwdkgmFtCRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="214877069"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2025 15:45:24 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH 1/2] drm/xe: Silence allocation warnings for sync arrays
Date: Thu, 20 Nov 2025 23:42:55 +0000
Message-ID: <20251120234254.427452-5-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251120234254.427452-4-shuicheng.lin@intel.com>
References: <20251120234254.427452-4-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

args->num_syncs comes from userspace and may be large or fuzzed.
When kcalloc() attempts a large allocation, the allocator may emit
warning like below, even though the driver already returns -ENOMEM
safely.

Suppress it by using __GFP_NOWARN when allocating the sync array.

"
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

Reported-by: Koen Koning <koen.koning@intel.com>
Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: <stable@vger.kernel.org> # v6.12+
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_exec.c | 3 ++-
 drivers/gpu/drm/xe/xe_vm.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 4d81210e41f5..7ef78a94e168 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -162,7 +162,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (args->num_syncs) {
-		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
+		syncs = kcalloc(args->num_syncs, sizeof(*syncs),
+				GFP_KERNEL | __GFP_NOWARN);
 		if (!syncs) {
 			err = -ENOMEM;
 			goto err_exec_queue;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index f9989a7a710c..8cebf7285640 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3640,7 +3640,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (args->num_syncs) {
-		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
+		syncs = kcalloc(args->num_syncs, sizeof(*syncs),
+				GFP_KERNEL | __GFP_NOWARN);
 		if (!syncs) {
 			err = -ENOMEM;
 			goto put_obj;
-- 
2.49.0


