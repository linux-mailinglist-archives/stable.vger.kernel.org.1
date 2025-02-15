Return-Path: <stable+bounces-116482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E0BA36C3B
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 06:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7239E18940F7
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 05:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD071624CC;
	Sat, 15 Feb 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SPd7L8Xe"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BB2907;
	Sat, 15 Feb 2025 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598663; cv=none; b=b+m0ctMxBNOgf7AH7a8xvDEf8ZPLteA8/Ekk+3VuHC6N+IQPGPdXf5DfnKBiWUSodGu1mheq6zT6asqeXtyU3lBT9uoAvoorvRNrkMypXmWt2oyWRa1xEHfo4c3bmwZI6CkjWP+A6Bel8xf6ZZtG/zvGxqiI0BCndVWWMjmUE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598663; c=relaxed/simple;
	bh=HoClBAvZD2da3+9BbElBY6ADIVMTozMtYq6pQ/u8mCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjIxoK8NmyC5ZNfo/r/7QPpjlEXglyJQcc7PhLTWE1JnpE4yUwT2BmBXTqPhvcnjHzMTpQq6pf965aBwjZSNkPB53UYlq8YiyQqZV0d2iv8dLAjUiZZt7bTeL15IU2PqWpf82OEpIp760CBcHqKtwO6Li3nrgYqBFQ72UvCR+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SPd7L8Xe; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Mc5SW8GnMLeHxZeokKRv9vWvAzpmR3VljH2nIJCFHOA=;
	b=SPd7L8XemSiJCFisVB+Ehpquqkrcl41L4/HAE3zLayXWmIwdAjuunZYQOwnV7j
	yNbfXIyq20Qf0jKLCNJw00DZr5KmgTrNY/WSXAzwJYSHV0bN5HA/+iiPTlMWyydV
	rzGJgrqKtAdWhmy5dE96SG2b653qGhQu7Bs0pSymHIyQM=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDXf7UXK7Bnf_lLAw--.8703S2;
	Sat, 15 Feb 2025 13:50:16 +0800 (CST)
Message-ID: <d043bdd2-a978-4a09-869e-b6e43f5ce409@126.com>
Date: Sat, 15 Feb 2025 13:50:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: wait for hugepage folios to be freed
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739514729-21265-1-git-send-email-yangge1116@126.com>
 <37363b17-88b0-4ccc-a115-8c9f1d83a1b5@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <37363b17-88b0-4ccc-a115-8c9f1d83a1b5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDXf7UXK7Bnf_lLAw--.8703S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1Dtw4kJw4xJw15AFWDJwb_yoW5WrWDpF
	WrKr4UKayDJr9ayrnrX39Y9r109rWrXFWxGF1aqry3Can8Xr17KF1Sv3Z0ga98Ar10kr40
	qrWjvwnruF1UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbdbbUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhf0G2ewEbrW6AAAsA



在 2025/2/14 16:08, David Hildenbrand 写道:
> On 14.02.25 07:32, yangge1116@126.com wrote:
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer 
>> freeing
>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB 
>> pages,
>> the allocation of contiguous memory through cma_alloc() may fail
>> probabilistically.
>>
>> In the CMA allocation process, if it is found that the CMA area is 
>> occupied
>> by in-use hugepage folios, these in-use hugepage folios need to be 
>> migrated
>> to another location. When there are no available hugepage folios in the
>> free HugeTLB pool during the migration of in-use HugeTLB pages, new 
>> folios
>> are allocated from the buddy system. A temporary state is set on the 
>> newly
>> allocated folio. Upon completion of the hugepage folio migration, the
>> temporary state is transferred from the new folios to the old folios.
>> Normally, when the old folios with the temporary state are freed, it is
>> directly released back to the buddy system. However, due to the deferred
>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
>> to the failure of cma_alloc().
>>
>> Here is a simplified call trace illustrating the process:
>> cma_alloc()
>>      ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>          ->unmap_and_move_huge_page()
>>              ->folio_putback_hugetlb() // Free old folios
>>      ->test_pages_isolated()
>>          ->__test_page_isolated_in_pageblock()
>>               ->PageBuddy(page) // Check if the page is in buddy
>>
>> To resolve this issue, we have implemented a function named
>> wait_for_hugepage_folios_freed(). This function ensures that the hugepage
>> folios are properly released back to the buddy system after their 
>> migration
>> is completed. By invoking wait_for_hugepage_folios_freed() following the
>> migration process, we guarantee that when test_pages_isolated() is
>> executed, it will successfully pass.
> 
> Okay, so after every successful migration -> put of src, we wait for the 
> src to actually get freed.
> 
> When migrating multiple hugetlb folios, we'd wait once per folio.
> 
> It reminds me a bit about pcp caches, where folios are !buddy until the 
> pcp was drained.
> 
It seems that we only track unmovable, reclaimable, and movable pages on 
the pcp lists. For specific details, please refer to the 
free_frozen_pages() function.

> I wonder if that waiting should instead be done exactly once after 
> migrating multiple folios? For example, at the beginning of 
> test_pages_isolated(), to "flush" that state from any previous migration?
> 
Yes, this can improve performance. I will make the modification in the 
next version. Thank you.
> Thanks for all your effort around making CMA allocations / migration 
> more reliable.
> 


