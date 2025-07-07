Return-Path: <stable+bounces-160352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E85AFAF52
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B757C3AFEBB
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED822A1BA;
	Mon,  7 Jul 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZfLbEP/v"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55428CF41
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879640; cv=none; b=k6zf8UhcVdTfyxQVHm7B7NXueVafgirc4pSMCeI3vKMfLS3EqpZyWL01XVSTO9JcVhjN9UBOVsKFwoKHPfn0LNjB+2pgn1wUkUoBXLzeEiVCdZHWxhVr8a1wLTCR8sA825Fe9KcOGWFICRuY7Rfn8KRSv4c3/mIDmAoG/KlNL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879640; c=relaxed/simple;
	bh=1QLjQcEr8pINe9brC2KlEBgSw99MZ6AV9to49+sZsrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7S6NFPUUm8YoJWob4AV9LypHffQLhv5m6o+W3tE4BpufvB43lkIAAWoeLd74kFjimIxraquOR1VWJl6Q3tK1xz2+3ivr6AauzDXPHpArfMow9gLX0Mp7WGiECpkOpmDPe8j1voiJhxSmH2lO+TpkZ++7TsfuV6uprsr43iNyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZfLbEP/v; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <072268ae-3dea-46f8-8c9e-203d062eab82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751879626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgyqmMgmj4RoHL2MEMeBZbWgZV9nUOOsFAtiV0PoOpY=;
	b=ZfLbEP/vZq2o4+akgW+lc4Afrvl/00HiSK0NwhRm0A7WUXvct0BrON8rtglHmdzeq5KYSC
	Xv/RTbWP+ZfT7gszBHH2OFBdN1XVATLskmoyuwGiwM4ktvtQnzZuftIU1kgvxkqx71qwzm
	jpzJevRaDNfnRPuYyjDh/EXfDo5znqo=
Date: Mon, 7 Jul 2025 17:13:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 x86@kernel.org, huang.ying.caritas@gmail.com, zhengtangquan@oppo.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 mingzhe.yang@ly.com, stable@vger.kernel.org, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
References: <20250701143100.6970-1-lance.yang@linux.dev>
 <aGtdwn0bLlO2FzZ6@harry>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aGtdwn0bLlO2FzZ6@harry>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/7 13:40, Harry Yoo wrote:
> On Tue, Jul 01, 2025 at 10:31:00PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
>> may read past the end of a PTE table when a large folio's PTE mappings
>> are not fully contained within a single page table.
>>
>> While this scenario might be rare, an issue triggerable from userspace must
>> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
>> access by refactoring the logic into a new helper, folio_unmap_pte_batch().
>>
>> The new helper correctly calculates the safe batch size by capping the scan
>> at both the VMA and PMD boundaries. To simplify the code, it also supports
>> partial batching (i.e., any number of pages from 1 up to the calculated
>> safe maximum), as there is no strong reason to special-case for fully
>> mapped folios.
>>
>> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-by: David Hildenbrand <david@redhat.com>
>> Closes: https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857fcbe@redhat.com
>> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
>> Suggested-by: Barry Song <baohua@kernel.org>
>> Acked-by: Barry Song <baohua@kernel.org>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
> 
> LGTM,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Hi Harry,

Thanks for taking time to review!

> 
> With a minor comment below.
> 
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index fb63d9256f09..1320b88fab74 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2206,13 +2213,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			hugetlb_remove_rmap(folio);
>>   		} else {
>>   			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
>> -			folio_ref_sub(folio, nr_pages - 1);
>>   		}
>>   		if (vma->vm_flags & VM_LOCKED)
>>   			mlock_drain_local();
>> -		folio_put(folio);
>> -		/* We have already batched the entire folio */
>> -		if (nr_pages > 1)
>> +		folio_put_refs(folio, nr_pages);
>> +
>> +		/*
>> +		 * If we are sure that we batched the entire folio and cleared
>> +		 * all PTEs, we can just optimize and stop right here.
>> +		 */
>> +		if (nr_pages == folio_nr_pages(folio))
>>   			goto walk_done;
> 
> Just a minor comment.
> 
> We should probably teach page_vma_mapped_walk() to skip nr_pages pages,
> or just rely on next_pte: do { ... } while (pte_none(ptep_get(pvmw->pte)))
> loop in page_vma_mapped_walk() to skip those ptes?

Good point. We handle partially-mapped folios by relying on the "next_pte"
loop to skip those ptes. The common case we expect to handle is fully-mapped
folios.

> 
> Taking different paths depending on (nr_pages == folio_nr_pages(folio))
> doesn't seem sensible.

Adding more logic to page_vma_mapped_walk() for the rare partial-folio
case seems like an over-optimization that would complicate the walker.

So, I'd prefer to keep it as is for now ;)


