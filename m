Return-Path: <stable+bounces-124573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7363A63DA8
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 04:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1625216CE6F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 03:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B81547EE;
	Mon, 17 Mar 2025 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtEhN3an"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C214A4F9;
	Mon, 17 Mar 2025 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183817; cv=none; b=qm1NqeGPYRnSS47smwaFb9p2wnICWTYv4h57VnsrEiUdMa5pgZClrSLoCDJOQiv4kTr+1IHChR75Gg90TnfPio9+VSR2YskmiH3rUSQzAphqxt94NN/SlqqaBkyD0Lk0l5fuv6qAaqYVBzjtIx9p9+R8gEEVzBbq5tAzSzvJR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183817; c=relaxed/simple;
	bh=pXTAu4i+lPwO2BP0fApT2DXfArtOvPYetf21fXbZR/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0I+7f8C5BsqScL8QUrAub+wAAcpgrDe8/w+ftSMecSRdmDusUKgH0d3FjGdFd2UkB4gkwKAuYwz8HUEi6p+7vx8IZjWYOc6+rZmGmPOsmR8YY94QPCK4uAtyf/3/dYrFNtdDjrJA7T2Ac03zoiVXBhtAn6DfVQYrEOrBTfmMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtEhN3an; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742183816; x=1773719816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pXTAu4i+lPwO2BP0fApT2DXfArtOvPYetf21fXbZR/I=;
  b=dtEhN3anBNMZLENuruxfV5JJ9OccESL90NbvV616kbRsGLQktu1oHbPe
   qyQTl3CVrRKgPTHNL2o2YFuYzxmg14ekunqtZ4eo5Df6u42IjoM2T3wKi
   UbrPZn9mByXxF3L/1s4hg4bNlsdnZzinVSHq08z11px43aU1mlCCtprZt
   ilDR7v9q2jnKe/M/zJTaQ1q21O6KyhEoMeKf6FLwKKbOMVw5mt2PK59nc
   fTsNzYii8VyxUUXFr99jkkJBgKMpa8JZtpX7hgBM/+rjIqveOXShNtJno
   /mnx34BPwIUNuLycNi1So23wHsdJgM96dh+6w9VladcCwlTP7lbMB9FV9
   g==;
X-CSE-ConnectionGUID: qG37IcUTSw6K2UGdFTDZ4A==
X-CSE-MsgGUID: W4hOmRJ4TguyWzwN3RZGwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="42998744"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="42998744"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 20:56:55 -0700
X-CSE-ConnectionGUID: nImjPajCTwGxdSCetvpK3w==
X-CSE-MsgGUID: 8m5c0qZ+QZK5aqukcgoDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="152702313"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa002.jf.intel.com with ESMTP; 16 Mar 2025 20:56:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	chaitanya.kumar.borah@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Fix possible circular locking dependency
Date: Mon, 17 Mar 2025 11:57:14 +0800
Message-ID: <20250317035714.1041549-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have recently seen report of lockdep circular lock dependency warnings
on platforms like skykale and kabylake:

 ======================================================
 WARNING: possible circular locking dependency detected
 6.14.0-rc6-CI_DRM_16276-gca2c04fe76e8+ #1 Not tainted
 ------------------------------------------------------
 swapper/0/1 is trying to acquire lock:
 ffffffff8360ee48 (iommu_probe_device_lock){+.+.}-{3:3},
   at: iommu_probe_device+0x1d/0x70

 but task is already holding lock:
 ffff888102c7efa8 (&device->physical_node_lock){+.+.}-{3:3},
   at: intel_iommu_init+0xe75/0x11f0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #6 (&device->physical_node_lock){+.+.}-{3:3}:
        __mutex_lock+0xb4/0xe40
        mutex_lock_nested+0x1b/0x30
        intel_iommu_init+0xe75/0x11f0
        pci_iommu_init+0x13/0x70
        do_one_initcall+0x62/0x3f0
        kernel_init_freeable+0x3da/0x6a0
        kernel_init+0x1b/0x200
        ret_from_fork+0x44/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #5 (dmar_global_lock){++++}-{3:3}:
        down_read+0x43/0x1d0
        enable_drhd_fault_handling+0x21/0x110
        cpuhp_invoke_callback+0x4c6/0x870
        cpuhp_issue_call+0xbf/0x1f0
        __cpuhp_setup_state_cpuslocked+0x111/0x320
        __cpuhp_setup_state+0xb0/0x220
        irq_remap_enable_fault_handling+0x3f/0xa0
        apic_intr_mode_init+0x5c/0x110
        x86_late_time_init+0x24/0x40
        start_kernel+0x895/0xbd0
        x86_64_start_reservations+0x18/0x30
        x86_64_start_kernel+0xbf/0x110
        common_startup_64+0x13e/0x141

 -> #4 (cpuhp_state_mutex){+.+.}-{3:3}:
        __mutex_lock+0xb4/0xe40
        mutex_lock_nested+0x1b/0x30
        __cpuhp_setup_state_cpuslocked+0x67/0x320
        __cpuhp_setup_state+0xb0/0x220
        page_alloc_init_cpuhp+0x2d/0x60
        mm_core_init+0x18/0x2c0
        start_kernel+0x576/0xbd0
        x86_64_start_reservations+0x18/0x30
        x86_64_start_kernel+0xbf/0x110
        common_startup_64+0x13e/0x141

 -> #3 (cpu_hotplug_lock){++++}-{0:0}:
        __cpuhp_state_add_instance+0x4f/0x220
        iova_domain_init_rcaches+0x214/0x280
        iommu_setup_dma_ops+0x1a4/0x710
        iommu_device_register+0x17d/0x260
        intel_iommu_init+0xda4/0x11f0
        pci_iommu_init+0x13/0x70
        do_one_initcall+0x62/0x3f0
        kernel_init_freeable+0x3da/0x6a0
        kernel_init+0x1b/0x200
        ret_from_fork+0x44/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #2 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
        __mutex_lock+0xb4/0xe40
        mutex_lock_nested+0x1b/0x30
        iommu_setup_dma_ops+0x16b/0x710
        iommu_device_register+0x17d/0x260
        intel_iommu_init+0xda4/0x11f0
        pci_iommu_init+0x13/0x70
        do_one_initcall+0x62/0x3f0
        kernel_init_freeable+0x3da/0x6a0
        kernel_init+0x1b/0x200
        ret_from_fork+0x44/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #1 (&group->mutex){+.+.}-{3:3}:
        __mutex_lock+0xb4/0xe40
        mutex_lock_nested+0x1b/0x30
        __iommu_probe_device+0x24c/0x4e0
        probe_iommu_group+0x2b/0x50
        bus_for_each_dev+0x7d/0xe0
        iommu_device_register+0xe1/0x260
        intel_iommu_init+0xda4/0x11f0
        pci_iommu_init+0x13/0x70
        do_one_initcall+0x62/0x3f0
        kernel_init_freeable+0x3da/0x6a0
        kernel_init+0x1b/0x200
        ret_from_fork+0x44/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #0 (iommu_probe_device_lock){+.+.}-{3:3}:
        __lock_acquire+0x1637/0x2810
        lock_acquire+0xc9/0x300
        __mutex_lock+0xb4/0xe40
        mutex_lock_nested+0x1b/0x30
        iommu_probe_device+0x1d/0x70
        intel_iommu_init+0xe90/0x11f0
        pci_iommu_init+0x13/0x70
        do_one_initcall+0x62/0x3f0
        kernel_init_freeable+0x3da/0x6a0
        kernel_init+0x1b/0x200
        ret_from_fork+0x44/0x70
        ret_from_fork_asm+0x1a/0x30

 other info that might help us debug this:

 Chain exists of:
   iommu_probe_device_lock --> dmar_global_lock -->
     &device->physical_node_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&device->physical_node_lock);
                                lock(dmar_global_lock);
                                lock(&device->physical_node_lock);
   lock(iommu_probe_device_lock);

  *** DEADLOCK ***

This driver uses a global lock to protect the list of enumerated DMA
remapping units. It is necessary due to the driver's support for dynamic
addition and removal of remapping units at runtime.

Two distinct code paths require iteration over this remapping unit list:

- Device registration and probing: the driver iterates the list to
  register each remapping unit with the upper layer IOMMU framework
  and subsequently probe the devices managed by that unit.
- Global configuration: Upper layer components may also iterate the list
  to apply configuration changes.

The lock acquisition order between these two code paths was reversed. This
caused lockdep warnings, indicating a risk of deadlock. Fix this warning
by releasing the global lock before invoking upper layer interfaces for
device registration.

Fixes: b150654f74bf ("iommu/vt-d: Fix suspicious RCU usage")
Closes: https://lore.kernel.org/linux-iommu/SJ1PR11MB612953431F94F18C954C4A9CB9D32@SJ1PR11MB6129.namprd11.prod.outlook.com/
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 85aa66ef4d61..ec2f385ae25b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3049,6 +3049,7 @@ static int __init probe_acpi_namespace_devices(void)
 			if (dev->bus != &acpi_bus_type)
 				continue;
 
+			up_read(&dmar_global_lock);
 			adev = to_acpi_device(dev);
 			mutex_lock(&adev->physical_node_lock);
 			list_for_each_entry(pn,
@@ -3058,6 +3059,7 @@ static int __init probe_acpi_namespace_devices(void)
 					break;
 			}
 			mutex_unlock(&adev->physical_node_lock);
+			down_read(&dmar_global_lock);
 
 			if (ret)
 				return ret;
-- 
2.43.0


