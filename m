Return-Path: <stable+bounces-176389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22846B36D43
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242DE98347F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFC1494D9;
	Tue, 26 Aug 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH8mWj2U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BA1F55F8;
	Tue, 26 Aug 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220262; cv=none; b=VV6J6wk1kWYTj96hN3j2r+ObVWrv5adKTaTVf0X5+qrknQtvreyyJF8AVshYKIo9PcgKU5EDdk6EUy5cc81Dpnm+Wz8k7DK2W4K2q4uT/AvQMEo7lrm9RFq2/UzKP3/9sdUH/CPIB0+/cIShzvGMQvMNiPAd7/cTte+ekahrrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220262; c=relaxed/simple;
	bh=NPGrp4PIJq9p++NBl9nPYj3PiNhQa/M5uji2+s9cYQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJGiSodgRJacDfC2AzEigxrmlZXYrE+ftEzO8emAjRkj/EITDlKp5DT7RE9Pz+o+n3y8sxzOPJXneR4wtQrKOUtISEd5vJ7QkE0ndaSSeBE24lGb7lG72Wvyui3VKSkrZNWaAe9zPZic2Pd9Mu4RxGLB9cMlOUn4zopBfdY5GXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH8mWj2U; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756220262; x=1787756262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NPGrp4PIJq9p++NBl9nPYj3PiNhQa/M5uji2+s9cYQo=;
  b=iH8mWj2UfLUzxvXDjHYM8DG1mMBsiYh+hVxyfWNvDya0fMtTgOU40Bv6
   9p/jW1oR4dgzzHNUo2rs99d5LBVe552F0juy3ELz7ojgjMAd5kQfuXdaY
   uMsm+Z6AXM1JMQj6O6tiLEqwFoqjuoPTMhf+iMbJPmqPesg1KE3YU/qef
   94OBnat2vLnhLeCpTEAMMgX0TgaFgR3jqTb47TAUzKQVck4+3t7vQK+7J
   CsPvTjqsTn4MJBapGTxuiB62eXFsJlYgeQJgrJlXXhCyJrpBj3WVqG069
   IM/CCIZVs2X2kUBnCJx9Msvq/0pubiez7vQ4JnKTGxXM5W8WEYWcmiwpX
   w==;
X-CSE-ConnectionGUID: aTfehCBHSd2IQhQdLqGS4Q==
X-CSE-MsgGUID: Bfvk9ZjMSU6WDCVFdVHkPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69827618"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69827618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 07:57:41 -0700
X-CSE-ConnectionGUID: XAdhmmn3S+a0JV/GHtEwjg==
X-CSE-MsgGUID: e9QSuoMKTYKd7lgioe2J0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173990072"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.16]) ([10.125.109.16])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 07:57:41 -0700
Message-ID: <9e0e12c7-72e2-4e92-a9c5-765c93053506@intel.com>
Date: Tue, 26 Aug 2025 07:57:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Matthew Wilcox <willy@infradead.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, vishal.moola@gmail.com
References: <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
 <aK3FsU1Dds4OG79o@casper.infradead.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aK3FsU1Dds4OG79o@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 07:33, Matthew Wilcox wrote:
...
> One memdesc type already assigned is for page tables.  Maybe iommu page
> tables are the same

One bit of context: This is an IOMMU problem but the IOMMU is walking
the normal x86 page tables in this case, specifically kernel page
tables. There are separate IOMMU page tables, of course, but those
aren't at issue here.

