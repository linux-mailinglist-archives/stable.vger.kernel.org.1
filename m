Return-Path: <stable+bounces-118550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC9A3EEA5
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF5D3BA526
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319E1FFC5E;
	Fri, 21 Feb 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/SoqTv+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA741FECA2;
	Fri, 21 Feb 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126451; cv=none; b=Kd9KfshfTZSgAFi3uJDjjEqOdEiCDKAZ2uWPr5a9MaEVHBUHv07cHmfXD6LeGuIOjo+33IVqTRlD/zwcPZZYJUKpwwuxFq48FU7eVxNRgFeBzBkb8Ij+UlzNnDKhb/t1dlSy/pd9Kv3t3YoynBSFRuptdIAqqOnRn55M9D6dVx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126451; c=relaxed/simple;
	bh=/h6MQNga5iVfjnLjCLx6zbyLRUuJqAvt3dTmrQYOmgY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tnXPU0DIjUnhglpBfiIwHTTWoJAJ2HqZQci62sbO9F4xxl/0Q2GHrKhvd1sO1v0o7mto3RePaCjzKEPQJhCBoUuie18/kgMP5VnEmpkbY3EFCPSInsYiBhi2JhIKmWEaMh8pPD5HVH8hRgttPG2lyfsHmBY+pryorgOY+cl9L/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/SoqTv+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740126450; x=1771662450;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/h6MQNga5iVfjnLjCLx6zbyLRUuJqAvt3dTmrQYOmgY=;
  b=H/SoqTv+caY7o0jJKqAGKIBxovg/ArnnomMADMQHSRDT0g95Vtau00m6
   7z4o+SuWHRxc82kbDczwAhEMrFqGfiwfLSEmfoBtM74p4gjldoyzKgPqa
   We8/YX7IrtMschK9h0Um/Id8OzxJ0sBJyQCdubyWKN6jDFI7nj8DOr2Eo
   IVK+Ih6UFGYl6uBmeiptjh+dxwk/V7iot/DLkE0GfYTQxSuJkq7Q2HIDN
   U+oMSeGDLOg/kaAawmwjulv2dfekaES6KW6VbsyrxsFNFKpvi+XEMjGZp
   WeM1oDZEcIG4mU96LIuC/0bhQ1lCE47/+UY89TDpkglCxJ5mWagR0LQ05
   A==;
X-CSE-ConnectionGUID: Fn2HzSLFTVqxCMUxJDv3Pw==
X-CSE-MsgGUID: uaJ2LBXjTCSKzUZXWqc3OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66294409"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="66294409"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:27:27 -0800
X-CSE-ConnectionGUID: XlHuQfjnRi2UYVY0c7IMTw==
X-CSE-MsgGUID: aUBL+3BNRSKjUtTIjknIBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="115136762"
Received: from jingxion-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:27:25 -0800
Message-ID: <b8b215e6-7447-4fbb-a408-20e518c8da4c@linux.intel.com>
Date: Fri, 21 Feb 2025 16:27:22 +0800
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
 <7d58c0bd-2828-4adc-8c57-8b359c9f0b9f@linux.intel.com>
 <BN9PR11MB52768DA79ECE2C5F9D14DC8C8CC72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768DA79ECE2C5F9D14DC8C8CC72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/21 15:22, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Thursday, February 20, 2025 7:38 PM
>>
>> On 2025/2/20 15:21, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, February 18, 2025 10:24 AM
>>>>
>>>> Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
>>>> locally") moved the call to enable_drhd_fault_handling() to a code
>>>> path that does not hold any lock while traversing the drhd list. Fix
>>>> it by ensuring the dmar_global_lock lock is held when traversing the
>>>> drhd list.
>>>>
>>>> Without this fix, the following warning is triggered:
>>>>    =============================
>>>>    WARNING: suspicious RCU usage
>>>>    6.14.0-rc3 #55 Not tainted
>>>>    -----------------------------
>>>>    drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
>>>>                  other info that might help us debug this:
>>>>                  rcu_scheduler_active = 1, debug_locks = 1
>>>>    2 locks held by cpuhp/1/23:
>>>>    #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at:
>>>> cpuhp_thread_fun+0x87/0x2c0
>>>>    #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at:
>>>> cpuhp_thread_fun+0x87/0x2c0
>>>>    stack backtrace:
>>>>    CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
>>>>    Call Trace:
>>>>     <TASK>
>>>>     dump_stack_lvl+0xb7/0xd0
>>>>     lockdep_rcu_suspicious+0x159/0x1f0
>>>>     ? __pfx_enable_drhd_fault_handling+0x10/0x10
>>>>     enable_drhd_fault_handling+0x151/0x180
>>>>     cpuhp_invoke_callback+0x1df/0x990
>>>>     cpuhp_thread_fun+0x1ea/0x2c0
>>>>     smpboot_thread_fn+0x1f5/0x2e0
>>>>     ? __pfx_smpboot_thread_fn+0x10/0x10
>>>>     kthread+0x12a/0x2d0
>>>>     ? __pfx_kthread+0x10/0x10
>>>>     ret_from_fork+0x4a/0x60
>>>>     ? __pfx_kthread+0x10/0x10
>>>>     ret_from_fork_asm+0x1a/0x30
>>>>     </TASK>
>>>>
>>>> Simply holding the lock in enable_drhd_fault_handling() will trigger a
>>>> lock order splat. Avoid holding the dmar_global_lock when calling
>>>> iommu_device_register(), which starts the device probe process.
>>> Can you elaborate the splat issue? It's not intuitive to me with a quick
>>> read of the code and iommu_device_register() is not occurred in above
>>> calling stack.
>> The lockdep splat looks like below:
> Thanks and it's clear now. Probably you can expand "to avoid unnecessary
> lock order splat " a little bit to mark the dead lock between dmar_global_lock
> and cpu_hotplug_lock (acquired in path of iommu_device_register()).

Yes, sure.

