Return-Path: <stable+bounces-116688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD055A3972B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C5A3BC7DF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423A232395;
	Tue, 18 Feb 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TTGpfDfC"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF73233159;
	Tue, 18 Feb 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870653; cv=none; b=dzdQ3FS/sdWf3l/+FVQrrX8LcDnns06YFjk6awV1AZj2lm+aCjTpAwhUpddCJsS19MVtL6yD/5oNncA37Fv/NQqGnNKsjmp011v76rlKZ6RuCV8z9byp7W65q9CGrCRSHe0u7DtoIr+JtBUlt7e+EOBuhtoCCEE/LIV2gbnpFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870653; c=relaxed/simple;
	bh=QlrFeM/WWhevHbuCRZ3/h/DidYjyTdQ4NVZyCs//d+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFaZOLFITFZWYIHurwGD3dvKXfeeCrOI42dJ6yhP2D2Z1NQ3e5FCQjIrmUmcJE0wdaQvTctdPFjSaZ7owGuP8H4kjjXm9UA/SFvdxu0kZFWrOa8q/AaBDiOa/cTGDrsdo2UI0OXbgWcEUY6u1oQVxIWoHGFV3+6M6PnpdBYarVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TTGpfDfC; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=q0FKelqD4MBXC07LZw1lv1trJGhq02WD8AUCXzMNScg=;
	b=TTGpfDfC9SEr1KevxG+T+nBjD3R/STYOH9ZyeaAKJyA4BQ/t1cFHFCWCYOto0d
	Ss0Nl2zD01rF7zBdeIu4U0rz82bryM6P9goh6Y963VcgeSIPqxA2rGCFDQ7Kspqs
	KhpVKvNXphKYc1lWTk4fF94vA3Gn0hGmlad84Nodt0hAg=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnl6toUbRn6etmBA--.9439S2;
	Tue, 18 Feb 2025 17:22:48 +0800 (CST)
Message-ID: <406c6713-356b-4acf-bcd0-e5a6c1e9adcf@126.com>
Date: Tue, 18 Feb 2025 17:22:47 +0800
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
 <d043bdd2-a978-4a09-869e-b6e43f5ce409@126.com>
 <2d0b01c5-a736-41d5-a0f7-db0da065d049@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <2d0b01c5-a736-41d5-a0f7-db0da065d049@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl6toUbRn6etmBA--.9439S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw17Gry8tFWfXFWruFW3ZFb_yoW5Ww48pF
	W3Ca17G3yDJr9ayrnFqws09r10krWjqFWxWF1aqry3CFs8ArnrKF42ywn8uFW5Zr10ka10
	qrWYvwnruF1UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUo7tUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgD3G2e0Sbh-YAAAsr



在 2025/2/18 16:55, David Hildenbrand 写道:
> On 15.02.25 06:50, Ge Yang wrote:
>>
>>
>> 在 2025/2/14 16:08, David Hildenbrand 写道:
>>> On 14.02.25 07:32, yangge1116@126.com wrote:
>>>> From: Ge Yang <yangge1116@126.com>
>>>>
>>>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer
>>>> freeing
>>>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB
>>>> pages,
>>>> the allocation of contiguous memory through cma_alloc() may fail
>>>> probabilistically.
>>>>
>>>> In the CMA allocation process, if it is found that the CMA area is
>>>> occupied
>>>> by in-use hugepage folios, these in-use hugepage folios need to be
>>>> migrated
>>>> to another location. When there are no available hugepage folios in the
>>>> free HugeTLB pool during the migration of in-use HugeTLB pages, new
>>>> folios
>>>> are allocated from the buddy system. A temporary state is set on the
>>>> newly
>>>> allocated folio. Upon completion of the hugepage folio migration, the
>>>> temporary state is transferred from the new folios to the old folios.
>>>> Normally, when the old folios with the temporary state are freed, it is
>>>> directly released back to the buddy system. However, due to the 
>>>> deferred
>>>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately 
>>>> leading
>>>> to the failure of cma_alloc().
>>>>
>>>> Here is a simplified call trace illustrating the process:
>>>> cma_alloc()
>>>>       ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>>>           ->unmap_and_move_huge_page()
>>>>               ->folio_putback_hugetlb() // Free old folios
>>>>       ->test_pages_isolated()
>>>>           ->__test_page_isolated_in_pageblock()
>>>>                ->PageBuddy(page) // Check if the page is in buddy
>>>>
>>>> To resolve this issue, we have implemented a function named
>>>> wait_for_hugepage_folios_freed(). This function ensures that the 
>>>> hugepage
>>>> folios are properly released back to the buddy system after their
>>>> migration
>>>> is completed. By invoking wait_for_hugepage_folios_freed() following 
>>>> the
>>>> migration process, we guarantee that when test_pages_isolated() is
>>>> executed, it will successfully pass.
>>>
>>> Okay, so after every successful migration -> put of src, we wait for the
>>> src to actually get freed.
>>>
>>> When migrating multiple hugetlb folios, we'd wait once per folio.
>>>
>>> It reminds me a bit about pcp caches, where folios are !buddy until the
>>> pcp was drained.
>>>
>> It seems that we only track unmovable, reclaimable, and movable pages on
>> the pcp lists. For specific details, please refer to the
>> free_frozen_pages() function.
> 
> It reminded me about PCP caches, because we effectively also have to 
> wait for some stuck folios to properly get freed to the buddy.
> 
It seems that when an isolated page is freed, it won't be placed back 
into the PCP caches.


