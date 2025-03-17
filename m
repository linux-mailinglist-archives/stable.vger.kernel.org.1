Return-Path: <stable+bounces-124606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1799FA642C6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA4416F75B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354821C16D;
	Mon, 17 Mar 2025 07:03:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752B21B9C8;
	Mon, 17 Mar 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195015; cv=none; b=XXZowidZZ8Ut0tw87X/cd+CoAUvSmNLqqn4kGsmecLDysfNiQMZLpQDP8IDE1HPqvITsMtZwqGa55LcJMGhfKQOwCj2yx7Q0TdvixoianBSsNFYZc2dtjkHqPYtGxaROJNGjXco7+Snql5JutJNp0CYihT3s/INh5Rq941EIXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195015; c=relaxed/simple;
	bh=f2Yg0PMlDrZWlBUIkMlxLmQAOrQOPHfwnyCDrGe/5Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZmbSxMpK95Pxy5H7iZecQTicapUF6lZy++ARSzIxDjpDeYWPZK5gjXd3Bnpx0z2RnSy4tGOkJkIiIHHNoAyCcvLtks+SRD8b5f9SnzRU5rOSx26i2sUsT7vcCAVVOQa4kVvYaetZUIgZci0rTBkRFWBGUO7kare/db48V5uOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E8D13D5;
	Mon, 17 Mar 2025 00:03:40 -0700 (PDT)
Received: from [10.174.36.228] (unknown [10.174.36.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1449D3F694;
	Mon, 17 Mar 2025 00:03:27 -0700 (PDT)
Message-ID: <acdd3003-4a05-4587-93d3-89df3bcd010f@arm.com>
Date: Mon, 17 Mar 2025 12:33:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Update mask post pxd_clear_bad()
To: Yeo Reum Yun <YeoReum.Yun@arm.com>, "jroedel@suse.de" <jroedel@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: Ryan Roberts <Ryan.Roberts@arm.com>, "david@redhat.com"
 <david@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
 "hch@lst.de" <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250313181414.78512-1-dev.jain@arm.com>
 <495ec80f-6cf1-4be8-bc2a-9115562fe60d@arm.com>
 <GV1PR08MB105214AFCE69B0333DF65D3BCFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <GV1PR08MB105214AFCE69B0333DF65D3BCFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/03/25 7:57 pm, Yeo Reum Yun wrote:
> Hi Dev,
> 
>>> Since pxd_clear_bad() is an operation changing the state of the page tables,
>>> we should call arch_sync_kernel_mappings() post this.
>>>
>>> Fixes: e80d3909be42 ("mm: track page table modifications in __apply_to_page_range()")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>    mm/memory.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 78c7ee62795e..9a4a8c710be0 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -2987,6 +2987,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
>>>                        if (!create)
>>>                                continue;
>>>                        pmd_clear_bad(pmd);
>>> +                     *mask = PGTBL_PMD_MODIFIED;
>>
>> Oh well, I guess these should have been *mask |= PGTBL_PMD_MODIFIED.
>>
>>
>>>                }
>>>                err = apply_to_pte_range(mm, pmd, addr, next,
>>>                                         fn, data, create, mask);
>>> @@ -3023,6 +3024,7 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
>>>                        if (!create)
>>>                                continue;
>>>                        pud_clear_bad(pud);
>>> +                     *mask = PGTBL_PUD_MODIFIED;
>>>                }
>>>                err = apply_to_pmd_range(mm, pud, addr, next,
>>>                                         fn, data, create, mask);
>>> @@ -3059,6 +3061,7 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
>>>                        if (!create)
>>>                                continue;
>>>                        p4d_clear_bad(p4d);
>>> +                     *mask = PGTBL_P4D_MODIFIED;
>>>                }
>>>                err = apply_to_pud_range(mm, p4d, addr, next,
>>>                                         fn, data, create, mask);
>>> @@ -3095,6 +3098,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>>>                        if (!create)
>>>                                continue;
>>>                        pgd_clear_bad(pgd);
>> +                     mask = PGTBL_PGD_MODIFIED;
>>>                }
>>>                err = apply_to_p4d_range(mm, pgd, addr, next,
>>>                                         fn, data, create, &mask);
> 
> I don't think this wouldn't need.
> the pXd_clear_bad() is only called at creation of each level of page table,
> and when it clear, the following, apply_to_pXd_range() function would be set
> the make properly via pXd_alloc() and apply_to_pte_range().

Makes sense. But pxd_clear_bad() gets called in case of !pxd_none(), so 
while creating, why would the page containing the page table not be 
none? I believe it should be cleared already?

> 
> Thanks.
> 
> 


