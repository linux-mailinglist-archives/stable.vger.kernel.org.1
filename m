Return-Path: <stable+bounces-161508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C1AFF72B
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 04:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965B356245B
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 02:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C2280303;
	Thu, 10 Jul 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzXbufC1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37A27FB28;
	Thu, 10 Jul 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116346; cv=none; b=VbAqZ0aSpQMR5lo1WeZHzYuPZtjkTHmfuNkvWu3wSbz/XamUFWBFlceAyaDwgKNbeuCpbByp0ScnKAM5b0kgi8HfqdlEO+pBR+O77sv3NuilTwLC2K80psfhA9dt0UGmImgj73GvprRef1+ObvZ4Znx374s2tmDY6C6Tko1TQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116346; c=relaxed/simple;
	bh=Cwe2l0isPRTuKo8Nrd5nELed2nvCRgGEUmCPpnkdj38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNow9qWyKOGbFYqiGS/6mpXtKUjgmSL1ISS7J7f9a/7hR449fE/7Ssx3USn7zUaCm7MZTKk3WVUA0cgsrC55V2T31LgzBxglWcArFGDYreip29mjGKMSj9CHuhT/XFG4gyuAU6oDz1EeNhrecO3r18xexDeKzNJItY8ma+BA974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzXbufC1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752116345; x=1783652345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cwe2l0isPRTuKo8Nrd5nELed2nvCRgGEUmCPpnkdj38=;
  b=GzXbufC1cS3Hg0TBZ1/2Y4VbZ0rzXMbNuP7Ko5hPMZs8K/NzmwETQW2b
   kPsoK/D8yIlkmKPfKcPLBSM3iQkTHxinTTZ1UKhbgnVsFzLHHo/RmIuue
   Fw2Xnq7ZYWx0mqrQQS4gCdHIJaRccVUi+t+4+2yhKZ2n2AO8qjdlk46Ls
   YBBiH3s2TGXZZlPrxjl2SbRdBf7rFJNExw0HYIdT51pL5k3uSxW1uvzgF
   JoWZkdp+4ERM/3WNil5Unbi4RmDjBrG/gZWO6qb2ZWE7hc/wrks0tVNFZ
   Oz7DOmsf87KGxJq8tml5nafVR/2KkuzOQCvWQtG1hBk8zrIz7/lalYqSS
   Q==;
X-CSE-ConnectionGUID: Uu4yJdq7Q5Opa0ft2l6zeQ==
X-CSE-MsgGUID: qfnVaxYgRuuAVBCyG4YgRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="79824127"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="79824127"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:59:04 -0700
X-CSE-ConnectionGUID: vrEkL49dQzuSb13f/lp5xw==
X-CSE-MsgGUID: F9u9x/NJSlOUzGbTyPC80A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="193151516"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:59:00 -0700
Message-ID: <2080aaea-0d6e-418e-8391-ddac9b39c109@linux.intel.com>
Date: Thu, 10 Jul 2025 10:57:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
To: jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
 security@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jacob,

On 7/10/25 02:15, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 9 Jul 2025 13:27:24 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Wed, Jul 09, 2025 at 08:51:58AM -0700, Jacob Pan wrote:
>>>> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
>>>> hardware shares and walks the CPU's page tables. Architectures
>>>> like x86 share static kernel address mappings across all user
>>>> page tables, allowing the IOMMU to access the kernel portion of
>>>> these tables.
>>
>>> Is there a use case where a SVA user can access kernel memory in the
>>> first place?
>>
>> No. It should be fully blocked.
>>
> Then I don't understand what is the "vulnerability condition" being
> addressed here. We are talking about KVA range here.

Let me take a real example:

A device might be mistakenly configured to access memory at IOVA
0xffffa866001d5000 (a vmalloc'd memory region) with user-mode access
permission. The corresponding page table entries for this IOVA
translation, assuming a five-level page table, would appear as follows:

PGD: Entry present with U/S bit set (1)
P4D: Entry present with U/S bit set (1)
PUD: Entry present with U/S bit set (1)
PMD: Entry present with U/S bit set (1)
PTE: Entry present with U/S bit clear (0)

When the IOMMU walks this page table, it may potentially cache all
present entries, regardless of the U/S bit's state. Upon reaching the
leaf PTE, the IOMMU performs a permission check. This involves comparing
the device's DMA access mode (in this case, user mode) against the
cumulative U/S permission derived from an AND operation across all U/S
bits in the traversed page table entries (which here results in U/S ==
0).

The IOMMU correctly blocks this DMA access because the device's
requested access (user mode) exceeds the permissions granted by the page
table (supervisor-only at the PTE level). However, the PGD, P4D, PUD,
and PMD entries that were traversed might remain cached within the
IOMMU's paging structure cache.

Now, consider a scenario where the page table leaf page is freed and
subsequently repurposed, and the U/S bit at its previous location is
modified to 1. From the IOMMU's perspective, the page table for the
aforementioned IOVA would now appear as follows:

PGD: Entry present with U/S bit set (1) [retrieved from paging cache]
P4D: Entry present with U/S bit set (1) [retrieved from paging cache]
PUD: Entry present with U/S bit set (1) [retrieved from paging cache]
PMD: Entry present with U/S bit set (1) [retrieved from paging cache]
PTE: Entry present with U/S bit set (1) {read from physical memory}

As a result, the device could then potentially access the memory at IOVA
0xffffa866001d5000 with user-mode permission, which was explicitly
disallowed.

Thanks,
baolu

