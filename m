Return-Path: <stable+bounces-161933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48115B04D60
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 03:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409C61A6809E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 01:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA91D5CE8;
	Tue, 15 Jul 2025 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDJluRDr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B11C862F;
	Tue, 15 Jul 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542468; cv=none; b=Oufo2lgo7OO/wtYRPa7t/u4ocTiZCmAFdQ7JH5WERNqyl+AUX7ws5/6efzHWtEaiy5GpEuui4YVhN269EwtOmqc2b4rqOgV3enFYlEx7WUtkKBAU4dsffJVEFgGcITt4ysbIp/DMfmHjiW7iGZQYZjVpYlrzLt2eZ7umcXoZHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542468; c=relaxed/simple;
	bh=1NoS/lqGTXCj1KTV5hwu6EGc0wLTF8DtWwPpJd/GL0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbyIsncdKDHz/xNNEkDL8QTXnxidBlPFrc22HwdSI+xKcHlHWdxpo7PGR9+IdiRXt/bwQE8VDm2TcI5XThHwosnsgqthDL6gXTNmCkMTX7NrS5PEjXjswFeEW/utL7551HKuy6Tl2PMOhSxPAjwlnFIok4nEJWR/NtAbDdnEv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDJluRDr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752542467; x=1784078467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1NoS/lqGTXCj1KTV5hwu6EGc0wLTF8DtWwPpJd/GL0M=;
  b=TDJluRDryDX1lRDdij79Lvph5bngrAtiRSW15GdPFaOgGFB5fIhjcXv9
   vG8bY6OmRiyDhtLn+U4+oAaSlytREanalcJVZh4AgwhBjc7oTCK1Qm+dN
   sPoit4anyIGIgGwC6JR0H8+xql6xqMDBYb4NPyIRAUchYXuuBrlIG9Z9y
   qsg5WmWQavaS6EXhaIQz6/dN5MqBzNjkiSDKXjUIhggPwEN5HPYNkBiqQ
   SlvFG5ADwM5LhH1JPwyD+zSjzbZf+Erv4vcxTYpk2bKib7Zcsva/7wVvB
   lY+DldffY+CFn9zTK1M88Rl8/BO3948RUDUbc15P7aq8sOd7rxTFtjzp1
   A==;
X-CSE-ConnectionGUID: H3hLJD2sRIW/V8gTlfQHug==
X-CSE-MsgGUID: ei+Yke0AQ7K7wt3TOixZgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58555878"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="58555878"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:21:03 -0700
X-CSE-ConnectionGUID: wARs0erJRAGR8mChmTR8Ag==
X-CSE-MsgGUID: vClZwxRhQd+g/NCe2+JDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="161401611"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:20:57 -0700
Message-ID: <9d289b97-570d-49af-aa6e-acc98df41015@linux.intel.com>
Date: Tue, 15 Jul 2025 09:19:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
To: Mike Rapoport <rppt@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Dave Hansen <dave.hansen@intel.com>, jacob.pan@linux.microsoft.com,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
 security@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
 <20250714133920.55fde0f5@pumpkin> <aHUD1cklhydR-gE5@pc636>
 <aHUZIVbLV9KAoZ3H@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aHUZIVbLV9KAoZ3H@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 22:50, Mike Rapoport wrote:
> On Mon, Jul 14, 2025 at 03:19:17PM +0200, Uladzislau Rezki wrote:
>> On Mon, Jul 14, 2025 at 01:39:20PM +0100, David Laight wrote:
>>> On Wed, 9 Jul 2025 11:22:34 -0700
>>> Dave Hansen<dave.hansen@intel.com> wrote:
>>>
>>>> On 7/9/25 11:15, Jacob Pan wrote:
>>>>>>> Is there a use case where a SVA user can access kernel memory in the
>>>>>>> first place?
>>>>>> No. It should be fully blocked.
>>>>>>   
>>>>> Then I don't understand what is the "vulnerability condition" being
>>>>> addressed here. We are talking about KVA range here.
>>>> SVA users can't access kernel memory, but they can compel walks of
>>>> kernel page tables, which the IOMMU caches. The trouble starts if the
>>>> kernel happens to free that page table page and the IOMMU is using the
>>>> cache after the page is freed.
>>>>
>>>> That was covered in the changelog, but I guess it could be made a bit
>>>> more succinct.
> But does this really mean that every flush_tlb_kernel_range() should flush
> the IOMMU page tables as well? AFAIU, set_memory flushes TLB even when bits
> in pte change and it seems like an overkill...

As far as I can see, only the next-level page table pointer in the
middle-level entry matters. SVA is not allowed to access kernel
addresses, which has been ensured by the U/S bit in the leaf PTEs, so
other bit changes don't matter here.

Thanks,
baolu

