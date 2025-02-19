Return-Path: <stable+bounces-116954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A2A3B020
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 04:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E57B16A71B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64A1A841F;
	Wed, 19 Feb 2025 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PmBfPsb0"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEBC191F6A;
	Wed, 19 Feb 2025 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936486; cv=none; b=H689w5ix8PhbgMjcLzXFTIL/vMJSgYZr+7tLCPUG8IILrhYsum4r9TDP2P+/DWT/Q18mG4jD+qsY3gwx2zf2+CaLE1CZGyyEEhJu2NXl77R1/adHrehgpjJaWrEx1lDETzvP14QhcP4TA8ZWW6QZHXnHkSbvnIhlijOBqTG9a5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936486; c=relaxed/simple;
	bh=lYmU3jNMFnWvp4qwM/KagSvdxMoE3OdWx4ePB/DRziA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tm57ds7eKDIL5ULjPnck8wmn9Gli9U5gR7G0CDoFS/VALZ2PbzsANb0jVkJ7tiuhBF3GCs0+OO+++9ybL7+oN+ZQE/H0Oqi956CdOYiDsBJEiN8r5AKR9gOZigUtYQcsD+7QyG1nyL4U8F52B5D0InIJOtnULPI/izjKgR7QsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PmBfPsb0; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=VskwbQNxxGXSCd9W0yEExCUDqdZuOrvg+FF0QwLaHys=;
	b=PmBfPsb0HiGDtL3NfDx3O1o1ajAsex+lnq3k3gCigLM5JJV9Nme/u2NlizN+sG
	gv/ZFVnXui9EqAYC4CCP8YOdE8o2x4b01drz/qh7qegzdi0vWEyi/SLHespbB2Kr
	4y/Ciz0tchOPs9bnvQekW4GTvjF3Yi28cImNZKS9dE04E=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3306SUrVnoI4wBA--.1330S2;
	Wed, 19 Feb 2025 11:40:03 +0800 (CST)
Message-ID: <462e8d90-c0d0-474b-851c-46a44282b768@126.com>
Date: Wed, 19 Feb 2025 11:40:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mm/hugetlb: wait for hugetlb folios to be freed
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739878828-9960-1-git-send-email-yangge1116@126.com>
 <f5c31616-41e8-464b-84ec-8aa0cedfa556@redhat.com>
 <17ad5bf5-545c-4418-8d08-459ce6ef54cb@126.com>
 <950cae5a-bff0-49e6-8fe4-a2447c63d8bc@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <950cae5a-bff0-49e6-8fe4-a2447c63d8bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3306SUrVnoI4wBA--.1330S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy5KrW7tFyrXF4fWF47XFb_yoW5ZFW7pF
	W5KF13GFWkJr9IyrnFqw1qkw1vkrWjvFW0gr4rtw13CFnIyrn3KFWayw1Y9ayrAr10kF40
	qr40qrZxWF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjoGQUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgL4G2e1Un4BNgAAsW



在 2025/2/19 1:22, David Hildenbrand 写道:
> On 18.02.25 13:19, Ge Yang wrote:
>>
>>
>> 在 2025/2/18 19:45, David Hildenbrand 写道:
>>> On 18.02.25 12:40, yangge1116@126.com wrote:
>>>> From: Ge Yang <yangge1116@126.com>
>>>>
>>>> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer
>>>> freeing
>>>> of huge pages if in non-task context"), which supports deferring the
>>>> freeing of hugetlb pages, the allocation of contiguous memory through
>>>> cma_alloc() may fail probabilistically.
>>>>
>>>> In the CMA allocation process, if it is found that the CMA area is
>>>> occupied
>>>> by in-use hugetlb folios, these in-use hugetlb folios need to be 
>>>> migrated
>>>> to another location. When there are no available hugetlb folios in the
>>>> free hugetlb pool during the migration of in-use hugetlb folios, new
>>>> folios
>>>> are allocated from the buddy system. A temporary state is set on the
>>>> newly
>>>> allocated folio. Upon completion of the hugetlb folio migration, the
>>>> temporary state is transferred from the new folios to the old folios.
>>>> Normally, when the old folios with the temporary state are freed, it is
>>>> directly released back to the buddy system. However, due to the 
>>>> deferred
>>>> freeing of hugetlb pages, the PageBuddy() check fails, ultimately 
>>>> leading
>>>> to the failure of cma_alloc().
>>>>
>>>> Here is a simplified call trace illustrating the process:
>>>> cma_alloc()
>>>>       ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>>>>           ->unmap_and_move_huge_page()
>>>>               ->folio_putback_hugetlb() // Free old folios
>>>>       ->test_pages_isolated()
>>>>           ->__test_page_isolated_in_pageblock()
>>>>                ->PageBuddy(page) // Check if the page is in buddy
>>>>
>>>> To resolve this issue, we have implemented a function named
>>>> wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
>>>> folios are properly released back to the buddy system after their
>>>> migration
>>>> is completed. By invoking wait_for_freed_hugetlb_folios() before 
>>>> calling
>>>> PageBuddy(), we ensure that PageBuddy() will succeed.
>>>>
>>>> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in
>>>> non-task context")
>>>> Signed-off-by: Ge Yang <yangge1116@126.com>
>>>> Cc: <stable@vger.kernel.org>
>>>
>>>
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> +void wait_for_freed_hugetlb_folios(void)
>>>> +{
>>>> +    flush_work(&free_hpage_work);
>>>
>>> BTW, I was wondering if we could optimize out some calls here by sensing
>>> if there is actually work.
>>>
>> for_each_hstate(h) {
>>     if (hugetlb_vmemmap_optimizable(h)) {
>>         flush_work(&free_hpage_work);
>  >         break;>     }
>> }
>> Is this adjustment okay?
> 
> I think that's better, except that it would still trigger in scenarios 
> where hugetlb is completely unused if 
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is around.
> 
> Can't we check hpage_freelist?
> 
> if (llist_empty(&hpage_freelist))
>      return;
> flush_work(&free_hpage_work);
> 
Ok, thanks.
> It should be able to deal with races (we don't care if something is 
> getting added concurrently, only if there is something right now).
> 


