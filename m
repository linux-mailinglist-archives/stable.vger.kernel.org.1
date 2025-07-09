Return-Path: <stable+bounces-161374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3EAFDCE2
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 03:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34419584422
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D817A305;
	Wed,  9 Jul 2025 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xc3tmFaA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E9156F4A;
	Wed,  9 Jul 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024450; cv=none; b=BEicd3gZx52QZjuz8w2dxuKdylOeNiT73nkVI0o4Kia1zcNPEJOTU0IaILisJ1JEkfF0IkU7pYfxjwlGV+8THe/ns1ZkW+bJMpZvxaTBZUt+O7iWmqeROlsxdjU1hSFmwmQlUnHu+jk+eIUgXyNjG+coFNueIHynIPK8UDIxp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024450; c=relaxed/simple;
	bh=Mtu3ryYM7nbSc66VaKGc/UqsJYQrmCDah4qStzUswrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uINmBFyqmqnRwhr99jjhmYhMzENmo10CAX+x/+eUtx1FQEK+70WSmuKF4bLiCpvbcJCh+4xxyZD6d/a2NelMX4ALeVZ+Z/53m16J00zWRjJcN5uBexZdbZ5Jf13anY1UeTCevyZhi8y9sqi/W5Aj/fVqnIf+kEoDbzyOkrS67Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xc3tmFaA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752024449; x=1783560449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mtu3ryYM7nbSc66VaKGc/UqsJYQrmCDah4qStzUswrc=;
  b=Xc3tmFaAd0sBkIzRRITNRCDZHNOgunSYoU+1lvWQPEm3M80Zzf88Xdlg
   uMqdApSRiG3nz/PjC0W+oKFBa/DQdNCQ4SZJMWYjmplldLwxbJ4SqN6JQ
   nIxS2MUMYpFCKbycmv3p7tDgTil0HLLibdRf30cn3yPvbFmtYzOXsXT28
   pW+B0KwQpxLIe7F1LF/qg39gcY7Q25TeP88dI0/uU0l1th4SBQU4MWTJP
   9b6s5jethRX5urxDIU7r0l17SrEjqRuUsP8qWOZjJpsivo/eI/mPlIljY
   6DPNSFQgaZ8AJjOL19FiJ52OcBFh87iBjmKBeGC2SFcjTMUW1WtSeeLH/
   A==;
X-CSE-ConnectionGUID: H3c1VB/1ReOcFFSIFnomvA==
X-CSE-MsgGUID: m6xmqTVMRC+8ADqkaxJNpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71723356"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71723356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:27:28 -0700
X-CSE-ConnectionGUID: bn+3Qc0+S0mV/AlaNPSL+A==
X-CSE-MsgGUID: lu07r9b4T+mrbZrwXkPw/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159670990"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:27:24 -0700
Message-ID: <41dd5505-8a3a-4718-b906-936059620940@linux.intel.com>
Date: Wed, 9 Jul 2025 09:25:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <0c6f6b3e-d68d-4deb-963e-6074944afff7@linux.intel.com>
 <20250708122755.GV1410929@nvidia.com> <20250708140629.GQ904431@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250708140629.GQ904431@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 22:06, Jason Gunthorpe wrote:
> On Tue, Jul 08, 2025 at 09:27:55AM -0300, Jason Gunthorpe wrote:
>> On Tue, Jul 08, 2025 at 01:42:53PM +0800, Baolu Lu wrote:
>>>> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
>>>> +{
>>>> +	struct iommu_mm_data *iommu_mm;
>>>> +
>>>> +	might_sleep();
>>>
>>> Yi Lai <yi1.lai@intel.com> reported an issue here. This interface could
>>> potentially be called in a non-sleepable context.
>>
>> Oh thats really bad, the notifiers inside the iommu driver are not
>> required to be called in a sleepable context either and I don't really
>> want to change that requirement.
> 
> Actually, I have got confused here with the hmm use of notifiers.
> 
> The iommu drivers use arch_invalidate_secondary_tlbs so they are
> already in atomic contexts.
> 
> So your idea to use a spinlock seems correct.

Okay, then let me post an updated version.

Thanks,
baolu

