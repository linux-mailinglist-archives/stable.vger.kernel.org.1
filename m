Return-Path: <stable+bounces-172908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E515B350FC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 03:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286D61B26FE2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A225F98A;
	Tue, 26 Aug 2025 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPCO9S49"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B51223338;
	Tue, 26 Aug 2025 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171655; cv=none; b=C+unoW/6JmGj3HGwaHh+eGTiKjnaiu17UzYL93De3bJ+qsaGDpQDGqiEBbWwpp7Yuvztf2nonGW2IKaGVFuJuC+Yu9lDqv9j8J0qAOwBcif5OgWRWckENIxUm8+tKn+FRTqeOUfeYiIByAgdWE0lxHgWz0tO5bBgAvmw8fR2/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171655; c=relaxed/simple;
	bh=AdpUiE/wJBetOMVQkBzJaBKwSBZOYbe+QTmNwnaCSQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHh7umgEJP70HMP65shWTGbfGkHUnB6QcUsO9/vqn4B+ckeO9+TGwSEvOdFq/cPmCqzaCdxPpRr1fKZbbiXT2PlkJuLF5+udEUZ7PKh+1wu7DWTnq+EHXTnbbI1i/dV+CuwGl9KU6lawn+Et8BdnFwDvmlEhJEdFOk/p7bPjlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPCO9S49; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756171654; x=1787707654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AdpUiE/wJBetOMVQkBzJaBKwSBZOYbe+QTmNwnaCSQY=;
  b=MPCO9S49GZdQsI1kKswkFPkBdualcRdG3yv4qop5eRO7upk3P/PO4rPE
   Reg+sQbYmMgK7QmN8gzuldAIq4vqIAvwgdVVbGSLBgHQ6rjA8vu2FnOy5
   oL2qVAXu2v8oyMaWAEnTQ7LzFf4P8nIbUXfY9fUYtcuOZGBhd0q7BWri4
   yp9U56XV2q83J1ojtkhU5fpsuFnWBRa9JzYRyLY8sXTZ9DARE2IgzUljr
   LLaTQc9KYh5TOJ/IHHrUcSPSCPGW98uu5JZOFWR8x0lrxY/pYvJRB+p1H
   e/Viq9z/ceZ3qve4DfYFBYdFT1NQopUk1PBd2xWYLYO2AnBGzxXINn5VA
   Q==;
X-CSE-ConnectionGUID: /ee054CfSDOtQj3cDmHDEQ==
X-CSE-MsgGUID: pLZfGXMeSma8SyJrj8LWog==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="75847554"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75847554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 18:27:33 -0700
X-CSE-ConnectionGUID: tIGsR0QISxaWhVKMXaVS4g==
X-CSE-MsgGUID: znpgCPBKTXW8CYZBlzEZYw==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 18:27:29 -0700
Message-ID: <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
Date: Tue, 26 Aug 2025 09:25:03 +0800
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
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/25 06:36, Dave Hansen wrote:
> On 8/22/25 20:26, Baolu Lu wrote:
>> +static struct {
>> +    /* list for pagetable_dtor_free() */
>> +    struct list_head dtor;
>> +    /* list for __free_page() */
>> +    struct list_head page;
>> +    /* list for free_pages() */
>> +    struct list_head pages;
>> +    /* protect all the ptdesc lists */
>> +    spinlock_t lock;
>> +    struct work_struct work;
> 
> Could you explain a bit why this now needs three separate lists? Seems
> like pure overkill.

Yes, sure.

The three separate lists are needed because we're handling three
distinct types of page deallocation. Grouping the pages this way allows
the workqueue handler to free each type using the correct function.

- pagetable_dtor_free(): This is for freeing PTE pages, which require
   specific cleanup of a ptdesc structure.

  - __free_page(): This is for freeing a single page.

  - free_pages(): This is for freeing a contiguous block of pages that
    were allocated together.

Using separate lists for each type ensures that every page is handled
correctly without having to check the page's type at runtime.

This seems like overkill, it was chosen to ensure functional
correctness. Any better solution?

Thanks,
baolu

