Return-Path: <stable+bounces-158955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10702AEDF62
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D1B1892EFD
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C328B7E1;
	Mon, 30 Jun 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvzH9EN2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA928B519
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290892; cv=none; b=GJrdN15D7LRVMmO9DkmucE6G4alNB4mdMTC7pwkquJ5ASomdrPCpwTdtmjqoU0F4ZJDseqA0jfj2a84NKDXWuLdggaCcirzDg31CCxwA34SuhzyZLcVxxGcYbCveNrIMGqSJOzm+MnlKJ6r8oaXtBaIQwbvnYLRr6uLWDH25gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290892; c=relaxed/simple;
	bh=QZn2BEF/evNs8BvFiNzRZp8rMPW8oD3AV94A/f5+hRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLY+sxaPUsHG02Z56wBHPOZoO6sD/Z9b+ONdCgIstacZjPZ7EoDYxMRHNbzyWWZT2tgJzjUSU8TLIdFtBSOf2xV/03nEzk0xAmPS3YyhUQM6xxsI7HJ4cedQ/pnaCu0fF9R+uqylbvJ2NgWl1snfyhY6qwm+hdiFRruQk9Hy56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvzH9EN2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751290889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0k2rxKDyTrLeAGCInolANnXu3A8lQ0DXnhu+vRzUrjA=;
	b=YvzH9EN2l0cI2FK2nvtXeu/Vf9R8jUU/ftguiiSwGx6r1BcRspevGCdIN2NUutyLcelwVw
	4J1KlMrbmeEhG90C6Djef+nu4J0iz1hduD1eQh3WVANbFmLfjg6MvOgvLVAyCShxM8shlr
	VKBylXOnSFz4soU8pJB7Y5qf+3TblX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-deWqSgYKPQurJEfGTQ4A5Q-1; Mon, 30 Jun 2025 09:41:25 -0400
X-MC-Unique: deWqSgYKPQurJEfGTQ4A5Q-1
X-Mimecast-MFC-AGG-ID: deWqSgYKPQurJEfGTQ4A5Q_1751290885
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451deff247cso26241265e9.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 06:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290884; x=1751895684;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0k2rxKDyTrLeAGCInolANnXu3A8lQ0DXnhu+vRzUrjA=;
        b=csZrdb5a0a7HC13g36dd0RseTdKr8vif+WRYQ8IXSuK7rarn0gsTIYrVsJOZZb4zc+
         HGjMA5WklTMy0bK4qMInMmSs+CNbnYM69b42/hwNNyy0+E9kRpR11MToRddp2jbKZTfg
         UbhLuImSRRb58K6KhVB7P30akKCxUBQ6QPrgUNKKd85JI8JwDCX13PQrusDgU8g1xuKZ
         Lp7n2slRcbdoK+GLUu3vRSZYLo1g30YCZsYC0MALh/Cehxx2MorR4yofL/quBFFi7Gpf
         wzir1oakziKgv9dsSZBArNJCBfd9u7u44HoxQGIltdpFScYu5ZxRpy7ULkEbMMeHmG+X
         F9vA==
X-Forwarded-Encrypted: i=1; AJvYcCXHgHN+RJECkXZAE6LUUYW6mapqJAlUoLYhVq2R8U6Bw1etwveDRyGcILxmZv2cmKOFvgdw1T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoSV+D7HMnhkzEHwde5kboITD8AYP+4Ymk2VzUcrqpzH0XO1w
	W8b9kWSRLlA+3cl+3XHVkQBD87G+PmomITeHpxtqeTs/I526kZGjTjY1y9nAh26FbwPXmo8iSWN
	Y9dLi3mTXEcMP/qEpE8LXlByb/P7pFwkoEY98+oMMkI8Jg97N6GBE/Y295Q==
X-Gm-Gg: ASbGncuD9LdLvxqZtMBlZzCFZg1CWtwkNfgcIIEjRmNLnGyRPFJMoHED+2Ri2ByF0lU
	9C1yfHLrEO+vDQWhSPynkEZkXE94LqDhF5oqRSCUUpKyPPxvxWcdKjNen9Y+Rrh0DIpgggoGUCg
	RhLCzf3gW5Uwjsq1okV9Ry+7g8OE31GxmXhzhqnXqxK9yBoqkPcENgNrWalM8kZB72z5ih7vWSe
	PX7Q0gng4M7dKLhbQe7gyFBBoHs+RJ2L4pKMl4GOOhlpYSWLPYX/JJ9GPDhC/GJ3TG3eqe1RDcX
	JVTw8QnsbJUk0KrjIFbq8GZfz0/5YVwATLpnLHySKiQTouDbxJiu19rlzWz0tZa3WHmxu6q2hmK
	F0Af0B/RogJw+9IBVSqjvpXvEwWk3xmgjlGZ2wfaOYVeFKtQkvg==
X-Received: by 2002:a05:600c:6212:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-45388a0371cmr160686195e9.12.1751290884459;
        Mon, 30 Jun 2025 06:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrR723N0U4a8LBGYdriPUXtPEH33drejJE1WXOFzTtappaVkC0Rw6pAoF4eAVkr6seqmnUEg==
X-Received: by 2002:a05:600c:6212:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-45388a0371cmr160685765e9.12.1751290883904;
        Mon, 30 Jun 2025 06:41:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5b7fsm138954025e9.10.2025.06.30.06.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:41:23 -0700 (PDT)
Message-ID: <498648fd-655e-47b3-8b7b-9c2ee11acc9b@redhat.com>
Date: Mon, 30 Jun 2025 15:41:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, ryan.roberts@arm.com,
 v-songbaohua@oppo.com, x86@kernel.org, huang.ying.caritas@gmail.com,
 zhengtangquan@oppo.com, riel@surriel.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, harry.yoo@oracle.com, mingzhe.yang@ly.com,
 stable@vger.kernel.org, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>
References: <20250630011305.23754-1-lance.yang@linux.dev>
 <41483c78-84f2-42fc-b9ab-09823eb796c4@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <41483c78-84f2-42fc-b9ab-09823eb796c4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 15:39, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 09:13:05AM +0800, Lance Yang wrote:
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
>> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
>> Cc: <stable@vger.kernel.org>
>> Acked-by: Barry Song <baohua@kernel.org>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> This LGTM:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>> v2 -> v3:
>>   - Tweak changelog (per Barry and David)
>>   - Pick AB from Barry - thanks!
>>   - https://lore.kernel.org/linux-mm/20250627062319.84936-1-lance.yang@linux.dev
>>
>> v1 -> v2:
>>   - Update subject and changelog (per Barry)
>>   - https://lore.kernel.org/linux-mm/20250627025214.30887-1-lance.yang@linux.dev
>>
>>   mm/rmap.c | 46 ++++++++++++++++++++++++++++------------------
>>   1 file changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index fb63d9256f09..1320b88fab74 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1845,23 +1845,32 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
>>   #endif
>>   }
>>
>> -/* We support batch unmapping of PTEs for lazyfree large folios */
>> -static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
>> -			struct folio *folio, pte_t *ptep)
>> +static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
>> +			struct page_vma_mapped_walk *pvmw,
>> +			enum ttu_flags flags, pte_t pte)
>>   {
>>   	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>> -	int max_nr = folio_nr_pages(folio);
>> -	pte_t pte = ptep_get(ptep);
>> +	unsigned long end_addr, addr = pvmw->address;
>> +	struct vm_area_struct *vma = pvmw->vma;
>> +	unsigned int max_nr;
>> +
>> +	if (flags & TTU_HWPOISON)
>> +		return 1;
>> +	if (!folio_test_large(folio))
>> +		return 1;
>>
>> +	/* We may only batch within a single VMA and a single page table. */
>> +	end_addr = pmd_addr_end(addr, vma->vm_end);
>> +	max_nr = (end_addr - addr) >> PAGE_SHIFT;
>> +
>> +	/* We only support lazyfree batching for now ... */
>>   	if (!folio_test_anon(folio) || folio_test_swapbacked(folio))
>> -		return false;
>> +		return 1;
>>   	if (pte_unused(pte))
>> -		return false;
>> -	if (pte_pfn(pte) != folio_pfn(folio))
>> -		return false;
>> +		return 1;
>>
>> -	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
>> -			       NULL, NULL) == max_nr;
>> +	return folio_pte_batch(folio, addr, pvmw->pte, pte, max_nr, fpb_flags,
>> +			       NULL, NULL, NULL);
> 
> I guess this will conflict with David's changes, but maybe in this simpler case
> and given this was existing code a bit less? Anyway let's see.

It's a fix, so this is fine to go in first. (I already rebased on top of 
mm/mm-new where this is in)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


