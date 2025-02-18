Return-Path: <stable+bounces-116767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05062A39D06
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357721885455
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC0269D12;
	Tue, 18 Feb 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UFmOU2AJ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC532690DD;
	Tue, 18 Feb 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884015; cv=none; b=dZmeS+eNVxDGdo9HOG1jsJm+oMtuI5IRCESK/ZpVKcIgOFdv6WGZKa4uVUiaTQ0c/smc1t5Omq9upoD2eFfzZaEnDr3eTlYJOOYg+ALD8TRVBsJtGt1EtJKqVZ5mxuR2jXBdatNAZwmr9fHCHC3FjKr+xT9Ko0/Pfb+AX2QDy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884015; c=relaxed/simple;
	bh=3RdfPZ+mVGcziAKFck3VokvkXlNM4g/j1Eywe5SORbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1cdFXPuASvANMpFmL7xo16hkJgbwdilEtBvhggeZYLKOys8Iq/gq/HNduEWIIXYudKgS36NpcM8M7A8Ii6I7PNnM4Jb88Y6e1eG8Qzcg++Y4TIPH6VMxTgSg3ZPYojpDd/j+XQwd2H5uUtISp+7hQqBD+EPrtC92HCW+PKkLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UFmOU2AJ; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=PjVps/mbL29xZmKfD5xoWxmNLay5V9tgBzGtJ2OKIkM=;
	b=UFmOU2AJs0pnz9fhcg4UtLj5zdpnEgMCDNnW5z7A/7nKvIXAp7gY3jlvIF01NC
	pKTYYT/FjYW5Wiuz29BOeM19S7TsYOhoAoqKuYJ2trqiVNHuqYFPDo0DOwK3ajE+
	QBbgnfN1dOA1hC5YKl6OziGLPtQLNFA5mgRphBSn+g25k=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3n4TverRnbKJTBA--.2790S2;
	Tue, 18 Feb 2025 20:19:59 +0800 (CST)
Message-ID: <17ad5bf5-545c-4418-8d08-459ce6ef54cb@126.com>
Date: Tue, 18 Feb 2025 20:19:58 +0800
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
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <f5c31616-41e8-464b-84ec-8aa0cedfa556@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n4TverRnbKJTBA--.2790S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy5tw4DuFWkXw1kJw4UCFg_yoW5XFyrpF
	WUKr13GFWDJrZakrn2qw4vkw10krWDZFWxKr4Sq3y3uFnxJ3s7KFyav3Z0gay8Cr1SkrW8
	trWvqrsruFyUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjYL9UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifhT3G2e0c8dX-gAAsI



在 2025/2/18 19:45, David Hildenbrand 写道:
> On 18.02.25 12:40, yangge1116@126.com wrote:
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer 
>> freeing
>> of huge pages if in non-task context"), which supports deferring the
>> freeing of hugetlb pages, the allocation of contiguous memory through
>> cma_alloc() may fail probabilistically.
>>
>> In the CMA allocation process, if it is found that the CMA area is 
>> occupied
>> by in-use hugetlb folios, these in-use hugetlb folios need to be migrated
>> to another location. When there are no available hugetlb folios in the
>> free hugetlb pool during the migration of in-use hugetlb folios, new 
>> folios
>> are allocated from the buddy system. A temporary state is set on the 
>> newly
>> allocated folio. Upon completion of the hugetlb folio migration, the
>> temporary state is transferred from the new folios to the old folios.
>> Normally, when the old folios with the temporary state are freed, it is
>> directly released back to the buddy system. However, due to the deferred
>> freeing of hugetlb pages, the PageBuddy() check fails, ultimately leading
>> to the failure of cma_alloc().
>>
>> Here is a simplified call trace illustrating the process:
>> cma_alloc()
>>      ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>>          ->unmap_and_move_huge_page()
>>              ->folio_putback_hugetlb() // Free old folios
>>      ->test_pages_isolated()
>>          ->__test_page_isolated_in_pageblock()
>>               ->PageBuddy(page) // Check if the page is in buddy
>>
>> To resolve this issue, we have implemented a function named
>> wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
>> folios are properly released back to the buddy system after their 
>> migration
>> is completed. By invoking wait_for_freed_hugetlb_folios() before calling
>> PageBuddy(), we ensure that PageBuddy() will succeed.
>>
>> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in 
>> non-task context")
>> Signed-off-by: Ge Yang <yangge1116@126.com>
>> Cc: <stable@vger.kernel.org>
> 
> 
> 
> Acked-by: David Hildenbrand <david@redhat.com>
>> +void wait_for_freed_hugetlb_folios(void)
>> +{
>> +    flush_work(&free_hpage_work);
> 
> BTW, I was wondering if we could optimize out some calls here by sensing 
> if there is actually work.
> 
for_each_hstate(h) {
	if (hugetlb_vmemmap_optimizable(h)) {
		flush_work(&free_hpage_work);
		break;
	}
}
Is this adjustment okay?
> In most cases, we'll never ever have to actually wait here, especially 
> on systems without any configured hugetlb pages etc ...
> 
> It's rather a corner case that we have to wait here on most systems.
> 


