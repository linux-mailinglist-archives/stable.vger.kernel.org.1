Return-Path: <stable+bounces-116640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD68A390D7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B6916D99F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B110512CDA5;
	Tue, 18 Feb 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABoCVgk0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A594315E;
	Tue, 18 Feb 2025 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845464; cv=none; b=Pr3K06Llnbrf8T/HSHZu09WsU9G4U4ioo8z0Tp/u2RjZ1b5pRxRxjkZNHTuhKVnlSOhC69OLOpn/jud3Fc5mq9b0xRerO5+rQFObFM1aLrltiKujQE6/Ik1EDVZYTrl4lW9jgmb94xLf5QmEaYsP5RTyQd9KA8uNTmSq5kMd+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845464; c=relaxed/simple;
	bh=7ipJmzLet5YB1c8k2DxOeip5VApJFjbWBfsc/HjE2bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPJ1kS3mYSZtBLxttRhV62aiLhCBF3RzkYonVfTAuRBsLzuguTNEVECdRIJyDxCFMi+BOU22kLffvhegI5yEZ+aa8yI35xPjyg29ZEP+CRQVgYrjRIrZNEjfFYs9MsXvT+06O8zhDcume+/9nFf1/FLredywW3+TdARSRQjaFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABoCVgk0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739845463; x=1771381463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ipJmzLet5YB1c8k2DxOeip5VApJFjbWBfsc/HjE2bA=;
  b=ABoCVgk0nJpkXti4gEneR79MQH+fEweyZqTZxBeuIcjUE021hNXlQ9RS
   K7hKYSKVmw++ANpSn7HcWTnzxOS6dR1HpBQQODQy43U58nWglrQVFRdGF
   zGm8kb3XxOp+hBQtyoPVUob5/GsKR73li31K9KimAb7zNyUEUTp1Eeh/R
   yW7G0vuESIvZLlpE43oVZygz1IMZ1mF8b+uZaGU4ZmUMP4qk+oeZXwlMZ
   JTTX0gwJjIy+YVPyleilw/L5X0wcNuTLXItW4m+0KOhXJWp2E2qNx08J9
   t7nnCgKg01OTjiDlefQLCoS2quqWNwWhOlO4TX5YRR5Fw6Sg8C+wJPyNS
   A==;
X-CSE-ConnectionGUID: H3HGD4mnR9emNOoiT19ROw==
X-CSE-MsgGUID: eCWCNVdjTPeVBEOlUreWwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44284674"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44284674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 18:24:22 -0800
X-CSE-ConnectionGUID: vD97ivTsScudIVqP7A+GBA==
X-CSE-MsgGUID: 2zNvAkghSyW5kn0bTSJyTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114769374"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2025 18:24:19 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Date: Tue, 18 Feb 2025 10:24:21 +0800
Message-ID: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
locally") moved the call to enable_drhd_fault_handling() to a code
path that does not hold any lock while traversing the drhd list. Fix
it by ensuring the dmar_global_lock lock is held when traversing the
drhd list.

Without this fix, the following warning is triggered:
 =============================
 WARNING: suspicious RCU usage
 6.14.0-rc3 #55 Not tainted
 -----------------------------
 drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
               other info that might help us debug this:
               rcu_scheduler_active = 1, debug_locks = 1
 2 locks held by cpuhp/1/23:
 #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
 #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
 stack backtrace:
 CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
 Call Trace:
  <TASK>
  dump_stack_lvl+0xb7/0xd0
  lockdep_rcu_suspicious+0x159/0x1f0
  ? __pfx_enable_drhd_fault_handling+0x10/0x10
  enable_drhd_fault_handling+0x151/0x180
  cpuhp_invoke_callback+0x1df/0x990
  cpuhp_thread_fun+0x1ea/0x2c0
  smpboot_thread_fn+0x1f5/0x2e0
  ? __pfx_smpboot_thread_fn+0x10/0x10
  kthread+0x12a/0x2d0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x4a/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Simply holding the lock in enable_drhd_fault_handling() will trigger a
lock order splat. Avoid holding the dmar_global_lock when calling
iommu_device_register(), which starts the device probe process.

Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
Reported-by: Ido Schimmel <idosch@idosch.org>
Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-a@shredder.mtl.com/
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 1 +
 drivers/iommu/intel/iommu.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9f424acf474e..e540092d664d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2043,6 +2043,7 @@ int enable_drhd_fault_handling(unsigned int cpu)
 	/*
 	 * Enable fault control interrupt.
 	 */
+	guard(rwsem_read)(&dmar_global_lock);
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
 		int ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..9a1e61b429ca 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3146,7 +3146,14 @@ int __init intel_iommu_init(void)
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
 				       "%s", iommu->name);
+		/*
+		 * The iommu device probe is protected by the iommu_probe_device_lock.
+		 * Release the dmar_global_lock before entering the device probe path
+		 * to avoid unnecessary lock order splat.
+		 */
+		up_read(&dmar_global_lock);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
 	}
-- 
2.43.0


