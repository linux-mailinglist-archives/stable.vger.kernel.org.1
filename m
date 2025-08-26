Return-Path: <stable+bounces-172911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79451B351E7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 04:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C1768663C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08B285C83;
	Tue, 26 Aug 2025 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbUg30/n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71125279346;
	Tue, 26 Aug 2025 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176721; cv=none; b=EwCRU7e7sYRWVMlmqDp+0FW40egH36xLc/YMYa0gvctWR2nyLGp4Bgc6/4L1NQiUpj90RwWsfZDvIQ0ek2W/5NUEg4guXZ24oHxugoMtWnWxnEba8xO02Sqk+JmtLGIHiwSwjl1XYZuMn8hy5YNkufvmMJT97y6jdUqtUcG66T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176721; c=relaxed/simple;
	bh=DMN39XlEXuf7uIgDoXm2mjQcLKXK4t78gZNEvwqiI/E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g60omY5znn64KEHn3Rk7tGgW/rF/5EAgIZFwIIOO5j10mcY0wJaRCXdXhs1GW+BdJYTru8+Mje5YDOHvXwywNTPZkdvh+KWXiucMbGnAmc6BqTrIkVZoOdzYl8iER+fO4Hq/VnKaQ4ZBz1x5tZuasOK8uZwD6gEqFfjuwRsXfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbUg30/n; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756176719; x=1787712719;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DMN39XlEXuf7uIgDoXm2mjQcLKXK4t78gZNEvwqiI/E=;
  b=gbUg30/nBzq47eQDa+KXlrOD69Sps1U9cCAQUlpw2RanMzoOiWFuT9Bu
   uMYnT96fxJg6gV3obAl7TT4rsVTlbhgUsDoJWxS/v51HuMarBUPC6g92p
   Dm/nSEXrujM223c8aFU4JIk2xcTOr9HJq/KiGKCNpPWvs7UW8He3Es1LC
   iila96JB2LKgVE1qO0DQiEEboG0u0hPbRDUIwTssYm+0zgzKIUYCrStbT
   ltI+DkRyjSVpbynkX4CTuXvsRghGcnHFUf9o3xXi3SDhTz8N3bj4oIGth
   V6jD84O/wY6KFSeAKUl2UbXn1aij1b+///Z8nwdHwoWDskkC5l8dgg9DB
   g==;
X-CSE-ConnectionGUID: aRZoQ4OnSkOAxh+BxA+tGg==
X-CSE-MsgGUID: 7hbs4AagRVGlzgramDJSvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="61037366"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61037366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:51:58 -0700
X-CSE-ConnectionGUID: 7x62P4XgTkGQzHGQufWCTw==
X-CSE-MsgGUID: sB+U/l7aQHGJChXPsKBrAA==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 19:51:54 -0700
Message-ID: <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
Date: Tue, 26 Aug 2025 10:49:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
From: Baolu Lu <baolu.lu@linux.intel.com>
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
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
Content-Language: en-US
In-Reply-To: <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/25 09:25, Baolu Lu wrote:
> On 8/26/25 06:36, Dave Hansen wrote:
>> On 8/22/25 20:26, Baolu Lu wrote:
>>> +static struct {
>>> +    /* list for pagetable_dtor_free() */
>>> +    struct list_head dtor;
>>> +    /* list for __free_page() */
>>> +    struct list_head page;
>>> +    /* list for free_pages() */
>>> +    struct list_head pages;
>>> +    /* protect all the ptdesc lists */
>>> +    spinlock_t lock;
>>> +    struct work_struct work;
>>
>> Could you explain a bit why this now needs three separate lists? Seems
>> like pure overkill.
> 
> Yes, sure.
> 
> The three separate lists are needed because we're handling three
> distinct types of page deallocation. Grouping the pages this way allows
> the workqueue handler to free each type using the correct function.

Please allow me to add more details.

> 
> - pagetable_dtor_free(): This is for freeing PTE pages, which require
>    specific cleanup of a ptdesc structure.

This is used in

static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)

and

int pud_free_pmd_page(pud_t *pud, unsigned long addr)

> 
>   - __free_page(): This is for freeing a single page.

This is used in

static void cpa_collapse_large_pages(struct cpa_data *cpa)
{
         ... ...

	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
                 list_del(&ptdesc->pt_list);
                 __free_page(ptdesc_page(ptdesc));
         }
}

> 
>   - free_pages(): This is for freeing a contiguous block of pages that
>     were allocated together.

This is used in

static void __meminit free_pagetable(struct page *page, int order)
{
	... ...

	free_pages((unsigned long)page_address(page), order);
}

What's strange is that order is almost always 0, except in the path of
remove_pmd_table() -> free_hugepage_table(), where order can be greater
than 0. However, in this context path, free_hugepage_table() isn't used
to free a page table page itself. Instead, it's used to free the actual
pages that a leaf PMD is pointing to.

static void __meminit
remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
                  bool direct, struct vmem_altmap *altmap)
{
         ... ...

         if (pmd_leaf(*pmd)) {
                 if (IS_ALIGNED(addr, PMD_SIZE) &&
                     IS_ALIGNED(next, PMD_SIZE)) {
                         if (!direct)
                                 free_hugepage_table(pmd_page(*pmd),
                                                     altmap);

                         spin_lock(&init_mm.page_table_lock);
                         pmd_clear(pmd);
                         spin_unlock(&init_mm.page_table_lock);
                         pages++;
                 } else if (vmemmap_pmd_is_unused(addr, next)) {
                                 free_hugepage_table(pmd_page(*pmd),
                                                     altmap);
                                 spin_lock(&init_mm.page_table_lock);
                                 pmd_clear(pmd);
                                 spin_unlock(&init_mm.page_table_lock);
                 }
                 continue;

         ... ...
}

Is this a misuse of free_pagetable() or anything overlooked?

Thanks,
baolu


