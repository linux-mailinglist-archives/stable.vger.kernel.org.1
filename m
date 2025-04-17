Return-Path: <stable+bounces-134383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EEA92AC6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA556189FD77
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1D257428;
	Thu, 17 Apr 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpDZ9bpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67A3594D;
	Thu, 17 Apr 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915962; cv=none; b=kxXoTd/QUXHWqaz8Y8l5ML9GGLFkzqqcJhZ3P3HHAYJaCc2MRUYRkPDSzlJxebn8mvM21pyQr+HR9Qsaa8yFL9DAx57lQsae4Za+wsBumWrZeep3X2XRfoy51wVo+WJdduLqC7++yG9sM64DREM91cqujpZtIy4+spoSvbnj+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915962; c=relaxed/simple;
	bh=Wt3csYGsv6qCmfACA8VIOI6LyROYe5YkETWeAs2rMkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODO4CUAlWPdzf33AqHDvuesnzxKislRnOxrK0DPGTjPDPVDQsYAJFMhp9dcUVxSKg3CjhW44e4e0duBplEYNreKKDvH7Xe3o5+B2FerlyHc4ald81Q6Kfn3ahFTrWB24wvjnWm/5AFMrx1U71qVwc6rZedNkAzar4VGvCOEWKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpDZ9bpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599B1C4CEE4;
	Thu, 17 Apr 2025 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915961;
	bh=Wt3csYGsv6qCmfACA8VIOI6LyROYe5YkETWeAs2rMkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpDZ9bpaEdeuM3T7x3yqAnAnn5L2KwhSOZWeewxMz7KcbggjemJUre+a91wYcQJ1c
	 BzjoIH8ZSU+K6z+QPxDHS5czR5g746VnLEE2yfz6SOASve7FtGhCR861zpTwiMGmcB
	 2PHWPu+2cmJgvu4vQ5a7jM9irVbfz7avJJQyt8+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.12 298/393] iommu/vt-d: Fix possible circular locking dependency
Date: Thu, 17 Apr 2025 19:51:47 +0200
Message-ID: <20250417175119.599888454@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Baolu <baolu.lu@linux.intel.com>

commit 93ae6e68b6d6b62d92b3a89d1c253d4a1721a1d3 upstream.

We have recently seen report of lockdep circular lock dependency warnings
on platforms like Skylake and Kabylake:

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
Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250317035714.1041549-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/iommu.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3174,6 +3174,7 @@ static int __init probe_acpi_namespace_d
 			if (dev->bus != &acpi_bus_type)
 				continue;
 
+			up_read(&dmar_global_lock);
 			adev = to_acpi_device(dev);
 			mutex_lock(&adev->physical_node_lock);
 			list_for_each_entry(pn,
@@ -3183,6 +3184,7 @@ static int __init probe_acpi_namespace_d
 					break;
 			}
 			mutex_unlock(&adev->physical_node_lock);
+			down_read(&dmar_global_lock);
 
 			if (ret)
 				return ret;



