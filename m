Return-Path: <stable+bounces-118421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC33A3D8F0
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5B3A5239
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D671F4178;
	Thu, 20 Feb 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp/94yaa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021561F3FE2;
	Thu, 20 Feb 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051507; cv=none; b=LbR5lZQUN+M5H545ejW39rIZMqDQQSbq3WjDEMUZOsK5zp+I4gdZW2Jqy1vVpXgcFHK+YoqG8d4Qbtb4oniOalGFaWqd+M+81iDztbQpB8J8vmFmUNMwKdkWrDGuDHfwjCN22Ak7vE4UkOL5n7zafeYEB+Tk+iINhT9skN/P9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051507; c=relaxed/simple;
	bh=OW4tV7XHQY75duXBFKoVLdDiJWkwE9tK7bUXvwMMnfc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kik4hhAeYTYHa6z/15BaBECP6DjB16eavBhy7EDbBSfHwwaFPRERohbP8KVtWovBC4v161BoKaCmWbLGEvb59BstaWODt/4lKfzG5H/LHkv5lv6VpDvHtza1p5ijDn7Ok3LjzZBEaVorRHTX4v1KuBkPwxo3BH0tQ/9R1DMoIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp/94yaa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740051505; x=1771587505;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OW4tV7XHQY75duXBFKoVLdDiJWkwE9tK7bUXvwMMnfc=;
  b=hp/94yaaTJVa7hRR31/isyBnLIskP5vrRjrjB8gbyWNKdhEYHJ5KzzyO
   +FC/KQSrTS2fsQtLa3cYvTV2cwYnh6uvyh0pRv4xYSdi26BM03nQVcT4v
   VgULu9vdFQLlG06rBxTc0x8d7kYnj+Zlrq7SVSic7FrrzAZslqCMMk11I
   EZ4oVUtcH0hS4s9kpkxIhcHN9xbEi/08C7N53n+IcQGOd/V3wMNHVgLND
   b79cYGTlcuT8S8tajIgyAgFQKeEbGfBoRnFFwoOgtugYZpVWA18+W/j0+
   MXABuLDz6H0cSxt6OyYvJlWkxcy70D4Vm51Gog22Zs+YICPHsrNkDoFMd
   g==;
X-CSE-ConnectionGUID: uE+oW1e/RXqO61icG8nyEQ==
X-CSE-MsgGUID: QD9MMweOSdC6tqP+VDfluA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40681134"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40681134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 03:38:24 -0800
X-CSE-ConnectionGUID: ImoEWPGUT1O38l92vqulmA==
X-CSE-MsgGUID: JBerQi//ThaorSclckLfxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="138216925"
Received: from lzhu41-mobl3.ccr.corp.intel.com (HELO [10.124.240.48]) ([10.124.240.48])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 03:38:22 -0800
Message-ID: <7d58c0bd-2828-4adc-8c57-8b359c9f0b9f@linux.intel.com>
Date: Thu, 20 Feb 2025 19:38:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Ido Schimmel <idosch@idosch.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EEC28691FD6C77EC493A8CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276EEC28691FD6C77EC493A8CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/20 15:21, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, February 18, 2025 10:24 AM
>>
>> Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
>> locally") moved the call to enable_drhd_fault_handling() to a code
>> path that does not hold any lock while traversing the drhd list. Fix
>> it by ensuring the dmar_global_lock lock is held when traversing the
>> drhd list.
>>
>> Without this fix, the following warning is triggered:
>>   =============================
>>   WARNING: suspicious RCU usage
>>   6.14.0-rc3 #55 Not tainted
>>   -----------------------------
>>   drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
>>                 other info that might help us debug this:
>>                 rcu_scheduler_active = 1, debug_locks = 1
>>   2 locks held by cpuhp/1/23:
>>   #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at:
>> cpuhp_thread_fun+0x87/0x2c0
>>   #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at:
>> cpuhp_thread_fun+0x87/0x2c0
>>   stack backtrace:
>>   CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0xb7/0xd0
>>    lockdep_rcu_suspicious+0x159/0x1f0
>>    ? __pfx_enable_drhd_fault_handling+0x10/0x10
>>    enable_drhd_fault_handling+0x151/0x180
>>    cpuhp_invoke_callback+0x1df/0x990
>>    cpuhp_thread_fun+0x1ea/0x2c0
>>    smpboot_thread_fn+0x1f5/0x2e0
>>    ? __pfx_smpboot_thread_fn+0x10/0x10
>>    kthread+0x12a/0x2d0
>>    ? __pfx_kthread+0x10/0x10
>>    ret_from_fork+0x4a/0x60
>>    ? __pfx_kthread+0x10/0x10
>>    ret_from_fork_asm+0x1a/0x30
>>    </TASK>
>>
>> Simply holding the lock in enable_drhd_fault_handling() will trigger a
>> lock order splat. Avoid holding the dmar_global_lock when calling
>> iommu_device_register(), which starts the device probe process.
> Can you elaborate the splat issue? It's not intuitive to me with a quick
> read of the code and iommu_device_register() is not occurred in above
> calling stack.

The lockdep splat looks like below:

  ======================================================
  WARNING: possible circular locking dependency detected
  6.14.0-rc3-00002-g8e4617b46db1 #57 Not tainted
  ------------------------------------------------------
  swapper/0/1 is trying to acquire lock:
  ffffffffa2a67c50 (cpu_hotplug_lock){++++}-{0:0}, at: 
iova_domain_init_rcaches.part.0+0x1d3/0x210

  but task is already holding lock:
  ffff9f4a87b171c8 (&domain->iova_cookie->mutex){+.+.}-{4:4}, at: 
iommu_dma_init_domain+0x122/0x2e0

  which lock already depends on the new lock.


  the existing dependency chain (in reverse order) is:

  -> #4 (&domain->iova_cookie->mutex){+.+.}-{4:4}:
         __lock_acquire+0x4a0/0xb50
         lock_acquire+0xd1/0x2e0
         __mutex_lock+0xa5/0xce0
         iommu_dma_init_domain+0x122/0x2e0
         iommu_setup_dma_ops+0x65/0xe0
         bus_iommu_probe+0x100/0x1d0
         iommu_device_register+0xd6/0x130
         intel_iommu_init+0x527/0x870
         pci_iommu_init+0x17/0x60
         do_one_initcall+0x7c/0x390
         do_initcalls+0xe8/0x1e0
         kernel_init_freeable+0x313/0x490
         kernel_init+0x24/0x240
         ret_from_fork+0x4a/0x60
         ret_from_fork_asm+0x1a/0x30

  -> #3 (&group->mutex){+.+.}-{4:4}:
         __lock_acquire+0x4a0/0xb50
         lock_acquire+0xd1/0x2e0
         __mutex_lock+0xa5/0xce0
         bus_iommu_probe+0x95/0x1d0
         iommu_device_register+0xd6/0x130
         intel_iommu_init+0x527/0x870
         pci_iommu_init+0x17/0x60
         do_one_initcall+0x7c/0x390
         do_initcalls+0xe8/0x1e0
         kernel_init_freeable+0x313/0x490
         kernel_init+0x24/0x240
         ret_from_fork+0x4a/0x60
         ret_from_fork_asm+0x1a/0x30

-> #2 (dmar_global_lock){++++}-{4:4}:
        __lock_acquire+0x4a0/0xb50
        lock_acquire+0xd1/0x2e0
        down_read+0x31/0x170
        enable_drhd_fault_handling+0x27/0x1a0
        cpuhp_invoke_callback+0x1e2/0x990
        cpuhp_issue_call+0xac/0x2c0
        __cpuhp_setup_state_cpuslocked+0x229/0x430
        __cpuhp_setup_state+0xc3/0x260
        irq_remap_enable_fault_handling+0x52/0x80
        apic_intr_mode_init+0x59/0xf0
        x86_late_time_init+0x29/0x50
        start_kernel+0x642/0x7f0
        x86_64_start_reservations+0x18/0x30
        x86_64_start_kernel+0x91/0xa0
        common_startup_64+0x13e/0x148

-> #1 (cpuhp_state_mutex){+.+.}-{4:4}:
        __lock_acquire+0x4a0/0xb50
        lock_acquire+0xd1/0x2e0
        __mutex_lock+0xa5/0xce0
        __cpuhp_setup_state_cpuslocked+0x81/0x430
        __cpuhp_setup_state+0xc3/0x260
        page_alloc_init_cpuhp+0x2d/0x40
        mm_core_init+0x1e/0x3a0
        start_kernel+0x277/0x7f0
        x86_64_start_reservations+0x18/0x30
        x86_64_start_kernel+0x91/0xa0
        common_startup_64+0x13e/0x148

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
        check_prev_add+0xe2/0xc50
        validate_chain+0x57c/0x800
        __lock_acquire+0x4a0/0xb50
        lock_acquire+0xd1/0x2e0
        __cpuhp_state_add_instance+0x40/0x250
        iova_domain_init_rcaches.part.0+0x1d3/0x210
        iova_domain_init_rcaches+0x41/0x60
        iommu_dma_init_domain+0x1af/0x2e0
        iommu_setup_dma_ops+0x65/0xe0
        bus_iommu_probe+0x100/0x1d0
        iommu_device_register+0xd6/0x130
        intel_iommu_init+0x527/0x870
        pci_iommu_init+0x17/0x60
        do_one_initcall+0x7c/0x390
        do_initcalls+0xe8/0x1e0
        kernel_init_freeable+0x313/0x490
        kernel_init+0x24/0x240
        ret_from_fork+0x4a/0x60
        ret_from_fork_asm+0x1a/0x30

  other info that might help us debug this:

  Chain exists of:
    cpu_hotplug_lock --> &group->mutex --> &domain->iova_cookie->mutex

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&domain->iova_cookie->mutex);
                                 lock(&group->mutex);
                                 lock(&domain->iova_cookie->mutex);
    rlock(cpu_hotplug_lock);

   *** DEADLOCK ***

  3 locks held by swapper/0/1:
   #0: ffffffffa6442ab0 (dmar_global_lock){++++}-{4:4}, at: 
intel_iommu_init+0x42c/0x87
   #1: ffff9f4a87b11310 (&group->mutex){+.+.}-{4:4}, at: 
bus_iommu_probe+0x95/0x1d0
   #2: ffff9f4a87b171c8 (&domain->iova_cookie->mutex){+.+.}-{4:4}, at: 
iommu_dma_init_d

  stack backtrace:
  CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.14.0-rc3-00002-g8e4617b46db1 #57
  Call Trace:
   <TASK>
   dump_stack_lvl+0x93/0xd0
   print_circular_bug+0x133/0x1c0
   check_noncircular+0x12c/0x150
   check_prev_add+0xe2/0xc50
   ? add_chain_cache+0x108/0x460
   validate_chain+0x57c/0x800
   __lock_acquire+0x4a0/0xb50
   lock_acquire+0xd1/0x2e0
   ? iova_domain_init_rcaches.part.0+0x1d3/0x210
   ? rcu_is_watching+0x11/0x50
   __cpuhp_state_add_instance+0x40/0x250
   ? iova_domain_init_rcaches.part.0+0x1d3/0x210
   iova_domain_init_rcaches.part.0+0x1d3/0x210
   iova_domain_init_rcaches+0x41/0x60
   iommu_dma_init_domain+0x1af/0x2e0
   iommu_setup_dma_ops+0x65/0xe0
   bus_iommu_probe+0x100/0x1d0
   iommu_device_register+0xd6/0x130
   intel_iommu_init+0x527/0x870
   ? __pfx_pci_iommu_init+0x10/0x10
   pci_iommu_init+0x17/0x60
   do_one_initcall+0x7c/0x390
   do_initcalls+0xe8/0x1e0
   kernel_init_freeable+0x313/0x490
   ? __pfx_kernel_init+0x10/0x10
   kernel_init+0x24/0x240
   ? _raw_spin_unlock_irq+0x33/0x50
   ret_from_fork+0x4a/0x60
   ? __pfx_kernel_init+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Thanks,
baolu

