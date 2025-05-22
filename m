Return-Path: <stable+bounces-146080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A443AC0ACE
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4C71BA76A4
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367528A1D5;
	Thu, 22 May 2025 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TP1WDE6e"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFCC1EEA28;
	Thu, 22 May 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914652; cv=none; b=sPWMqTM0lcLxY3FzfqmSQQT7FZryOTV0pc0urOMzfP89OY9uIJuk3u9Kpoq6q2EDm8ahEj9/QH6VLya1o35ThNqsQhETjXutm5FECZzEWfdwaxbgwhC7iRKEphR5zy0g3EzbFLuzQdhOQqI2Hwzv9LBf5yOoPwZPwtBCuCV/EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914652; c=relaxed/simple;
	bh=m1aYqpnYR3p47ZZC7i88pquhuOJRKBIaUCM/8zSDaLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUTyCcQZKudyAuicr9HqAoG5xPHL6SWi8lhIebeE3egUhatWTAyD2iGzqJi4actGFvFbIgJQKem6kBUHafi1G4uoWRNvipDvtiotla/+i3g0YKZPvf0oqwy9wDpHSaf3m1MauVeRAp6iypbcv4FEK9MnSAB8/ngptyM6afCqCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TP1WDE6e; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+2YR3SBQV4q9Lx7C2ALD+oH2dckWuf9RbQ/n1pINFmI=;
	b=TP1WDE6e5efu4PqMX/PdpVITZahk/W7M6eIoxd2qOJybqRliUO7zGy77BHQR9k
	uCXjhdX7wWnS/HJVhDPkuC7JGrq/iAYyrk5X7gOt+6q4cKB0/3hjTV8H4PDYr953
	ngZNEsMf7WplyzT+zZmwEs2txoK8QOtyg2um5GjdkGHl8=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD3R1vgCy9o0ZusAQ--.12490S2;
	Thu, 22 May 2025 19:34:57 +0800 (CST)
Message-ID: <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
Date: Thu, 22 May 2025 19:34:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
To: Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <aC63fmFKK84K7YiZ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgD3R1vgCy9o0ZusAQ--.12490S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF15AFyruFWUZr4UZrW3trb_yoW8AF1kpF
	W7KrnxXF4DJas8ur4Iyw1kJr15ArWUXa45GFWxGr43ZF43XasrKr1jqws0qayfCrn3Ja1I
	vF4IgF4vgF1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbmiiUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiih9VG2gvBbqcNwAAsI



在 2025/5/22 13:34, Oscar Salvador 写道:
> On Thu, May 22, 2025 at 11:47:05AM +0800, Muchun Song wrote:
>> Thanks for fixing this problem. BTW, in order to catch future similar problem,
>> it is better to add WARN_ON into folio_hstate() to assert if hugetlb_lock
>> is not held when folio's reference count is zero. For this fix, LGTM.
> 
> Why cannot we put all the burden in alloc_and_dissolve_hugetlb_folio(),
> which will again check things under the lock?
> I mean, I would be ok to save cycles and check upfront in
> replace_free_hugepage_folios(), but the latter has only one user which
> is alloc_contig_range(), which is not really an expected-to-be optimized
> function.
> 
>   diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>   index bd8971388236..b4d937732256 100644
>   --- a/mm/hugetlb.c
>   +++ b/mm/hugetlb.c
>   @@ -2924,13 +2924,6 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
>   
>    	while (start_pfn < end_pfn) {
>    		folio = pfn_folio(start_pfn);
>   -		if (folio_test_hugetlb(folio)) {
>   -			h = folio_hstate(folio);
>   -		} else {
>   -			start_pfn++;
>   -			continue;
>   -		}
>   -
>    		if (!folio_ref_count(folio)) {
>    			ret = alloc_and_dissolve_hugetlb_folio(h, folio,
>    							       &isolate_list);
> 
>   
> 
It seems that we cannot simply remove the folio_test_hugetlb() check. 
The reasons are as follows:

1）If we remove it, we will be unable to obtain the hstat corresponding 
to the folio, and consequently, we won't be able to call 
alloc_and_dissolve_hugetlb_folio().

2）The alloc_and_dissolve_hugetlb_folio() function is also called within 
the isolate_or_dissolve_huge_folio() function. However, the 
folio_test_hugetlb() check within the isolate_or_dissolve_huge_folio() 
function cannot be removed.


