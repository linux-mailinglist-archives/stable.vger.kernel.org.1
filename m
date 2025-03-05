Return-Path: <stable+bounces-121073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748AFA509BF
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339853A5F61
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24D2571CF;
	Wed,  5 Mar 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plGB6gqy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70225333B;
	Wed,  5 Mar 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198804; cv=none; b=mOUbFjJe+Mu1dA3ijfW5LsigT40qWEAX4yxmxhN/yt0l7w1/DvzLhPUob6ohGhdzaouKEyaRTnZHIqLrVrP4lj/04FdqzAHYTucFSKx0cMyCKSfBo1tkCE8jQr7TVjmUfWf+ApE9dQU0FO/vcS9kW9TzvEjwdJfq7ZtnwBw17Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198804; c=relaxed/simple;
	bh=n6BJWNCXyd9EQ72tcLqPHeGXrR/lsTXMqJQGeE3aDOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJexh/2PIJ4BXDv7LsZxUjx1Jecx7YXbSifi02xv/4mnHLzq4jb1LZx2F3qgeaBHuL3VX6LljJZXiP4BYtb89dw43x9TzHFND0l/LvmbSciQ1L2SrElii8waodF5HSTDZ8qRQ3II5880SgOSexR42MGeZdPfYiPdB3mYovKrfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plGB6gqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1318CC4CED1;
	Wed,  5 Mar 2025 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198804;
	bh=n6BJWNCXyd9EQ72tcLqPHeGXrR/lsTXMqJQGeE3aDOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plGB6gqymA0/O3m4aR90K35hXKx7/qDBr2ht/OgQIXWNkYbFSIFdOYHo/j32h5Bzx
	 D7jXSaGP6DNqSHSDNBlVlKeEP4C+Jb1BCyS4qK+WltGErFGtENl9YkJpQYv0usqx9S
	 7PAtd85OOYuSgBhn+Zz1QJtvki8YpkWLp08a8rDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.13 126/157] iommu/vt-d: Fix suspicious RCU usage
Date: Wed,  5 Mar 2025 18:49:22 +0100
Message-ID: <20250305174510.368576857@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Baolu <baolu.lu@linux.intel.com>

commit b150654f74bf0df8e6a7936d5ec51400d9ec06d8 upstream.

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

Holding the lock in enable_drhd_fault_handling() triggers a lockdep splat
about a possible deadlock between dmar_global_lock and cpu_hotplug_lock.
This is avoided by not holding dmar_global_lock when calling
iommu_device_register(), which initiates the device probe process.

Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
Reported-and-tested-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-a@shredder.mtl.com/
Tested-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250218022422.2315082-1-baolu.lu@linux.intel.com
Tested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/dmar.c  |    1 +
 drivers/iommu/intel/iommu.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2043,6 +2043,7 @@ int enable_drhd_fault_handling(unsigned
 	/*
 	 * Enable fault control interrupt.
 	 */
+	guard(rwsem_read)(&dmar_global_lock);
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
 		int ret;
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3155,7 +3155,14 @@ int __init intel_iommu_init(void)
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



