Return-Path: <stable+bounces-169924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B8B29972
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FCA174083
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 06:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23327272815;
	Mon, 18 Aug 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv+GoBrR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5C2727FE;
	Mon, 18 Aug 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497454; cv=none; b=q8oU9KjrYxS1lo1XvtmhkEqhp75lPRWIVci9N+KntxNO469NO7jdymZaHOaHcXjTCISTViVTj6rZ21LBxovwRwoSjbNOq6naSPg0PAkRjdDGoAihlDMrkCwLE/8Nig4fZGiGbQv6GyFTq1yum2bxka6w5NIpfpu+fSpnoyCLz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497454; c=relaxed/simple;
	bh=6iQinUn50V3p2MMoTw/tU+dRkNLwy+M4K81c73mvUWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE7LRnZZuJEIPzl3f1q2MQtThlR+ToYf/ksIu5SCb8BNGuYkzGkpuMvuXNhDhHkjqvc/RC+dv2Lz1it9AV/OHFjWbg5QcYtMxXJRel7XU+2HlRO2rRaEvs6H7WUaIzQS2xTnZeG93omfqL4TW8GyjZcAO/la+QrAtpwGu3zWYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv+GoBrR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755497453; x=1787033453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6iQinUn50V3p2MMoTw/tU+dRkNLwy+M4K81c73mvUWA=;
  b=Dv+GoBrRzeSVZycEPlPmkkXia+kG2qAIjMMpUBfsCpfi4mgiG/LWeMiV
   MWWt9bqF+JmJ1/soV7EStWPL892EyFg4k6K31ZCUzZBsR4mA/wcdivYr5
   7YQSUaqlsUwVMDwoj052z9b2TpmZkk0YHgJsM/uak1kP3hnkoGW1dffF1
   BU8ywcKlGRnA792N0+SHYnaxwbLWfILG3Wwadkc417eLwXtzzS1oFy6/e
   4RQgiBzDgy/s66GCtTrPjuZOaOcBp1zHYIt4wKCxc2d72LZN0aHsIa34e
   6R8A/2gq225ViFYTu5z6gwIur2LKf96kHCJMZs6ViLXZXsZw2S24xogfM
   w==;
X-CSE-ConnectionGUID: sdtx8t/1QxG4zcucpU17qg==
X-CSE-MsgGUID: j+kSU1jdTASJGd867HkDTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57572664"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57572664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:10:53 -0700
X-CSE-ConnectionGUID: aHHiiUwoT+ml8CB/E86rBw==
X-CSE-MsgGUID: u54RN6bZS/WUFe6S6qQNDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167108331"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:10:49 -0700
Message-ID: <041ab750-3d3e-4878-8bb3-ec888e7d9db1@linux.intel.com>
Date: Mon, 18 Aug 2025 14:08:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3f7a0524-75e1-447f-bdf5-db3f088a0ca9@linux.intel.com>
 <b6122394-0c4e-4082-ae8d-47f4219a0642@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b6122394-0c4e-4082-ae8d-47f4219a0642@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/15/25 22:31, Dave Hansen wrote:
> On 8/15/25 02:16, Baolu Lu wrote:
>> On 8/8/2025 10:57 AM, Tian, Kevin wrote:
>>> pud_free_pmd_page()
>>>      ...
>>>      for (i = 0; i < PTRS_PER_PMD; i++) {
>>>          if (!pmd_none(pmd_sv[i])) {
>>>              pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
>>>              pte_free_kernel(&init_mm, pte);
>>>          }
>>>      }
>>>
>>>      free_page((unsigned long)pmd_sv);
>>>
>>> Otherwise the risk still exists if the pmd page is repurposed before the
>>> pte work is scheduled.
>>
>> You're right that freeing high-level page table pages also requires an
>> IOTLB flush before the pages are freed. But I question the practical
>> risk of the race given the extremely small time window.
> 
> I hear that Linux is gaining popularity these days. There might even be
> dozens of users! Given that large scale of dozens (or even hundreds??)
> of users, I would suggest exercising some care. The race might be small
> but it only needs to happen once to cause chaos.
> 
> Seriously, though... A race is a race. Preemption or interrupts or SMIs
> or VMExits or a million other things can cause a "small time window" to
> become a big time window.
> 
> Even perceived small races need to be fixed.

Yes, agreed.

> 
>> If this is a real concern, a potential mitigation would be to clear
>> the U/S bits in all page table entries for kernel address space? But
>> I am not confident in making that change at this time as I am unsure
>> of the side effects it might cause.
> 
> That doesn't do any good. I even went as far as double-checking months
> ago with the IOMMU hardware folks to confirm the actual implementation.
> I'm really surprised this is being brought up again.

It should not be brought up again. Sorry about it.

I was thinking about deferring pte page table page free plus clearing
U/S bit. That's also not desirable anyway, so let's ignore it.

> 
>>> another observation - pte_free_kernel is not used in remove_pagetable ()
>>> and __change_page_attr(). Is it straightforward to put it in those paths
>>> or do we need duplicate some deferring logic there?
>>
>> The remove_pagetable() function is called in the path where memory is
>> hot-removed from the system, right?
> 
> No. Not right.
> 
> This is in the vmalloc() code: the side of things that _creates_
> mappings for new allocations, not tears them down.

Yeah, let me look into it.

Thanks,
baolu

