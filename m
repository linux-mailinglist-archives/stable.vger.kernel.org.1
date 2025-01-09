Return-Path: <stable+bounces-108069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F7A07245
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 10:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6BA7A5104
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572EB21771E;
	Thu,  9 Jan 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RQPcjC8W"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345D0216E24;
	Thu,  9 Jan 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416280; cv=none; b=SqRzhoKPeRAVVEL0yUZDRGJkynHkateyYdBdi+YfdNgeela2EeXIds4G89bFI9lKN3bXWVj/799kPLjWKYRmoDXAifuvRc9NVOlDDv1qDjzZfNN5HL6FkVQLtcYzvFPEfRlk3TNPqkhCI3h+srqCVAsRbaJQ2d3+p5mMgEUgqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416280; c=relaxed/simple;
	bh=Y9CPanSPdEA702PCBA385wSs2/VFoRtVLlH4Jvb2y2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDvyOsITh/FMBJWcAyh0DlHIC7zPgy3ZpB1ow8DLRXN42mQTpnbvwkEEy4QOsnvqAdHjxPYwi4bdl7uBuum15etxXJB6rYx9s62xqtmUvLNDpnWgPlMH4qINIWImNg1gXM0JUraE0TQx3xdHgDPylk0/fYYGK7FSHg6alJkLU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RQPcjC8W; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=jIsY2cpnT+tIRQNZjatzrDUodDqoUKk2a2OvKJzbtbo=;
	b=RQPcjC8WlK3c6OA6bErtZWOMjElDPHSD4M2JJSusT9hI1rbXZMfyrrT/swirY9
	R2IeAynSlDPhtibO0MRMBnGK5pTHH4m2uJHAUTL/TKOwAk/OYyjwode9xBq4hgXs
	nvrWoXPbJwJHMLWF2+XHbJGCHNCp0ICj6bi8+mUkVQYE0=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v6Xwm39nae7KAw--.35704S2;
	Thu, 09 Jan 2025 17:50:41 +0800 (CST)
Message-ID: <85bfb9b7-09fc-45e3-888d-71c848aaf00d@126.com>
Date: Thu, 9 Jan 2025 17:50:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0ca35fe5-9799-4518-9fb1-701c88501a8d@redhat.com>
 <d6d92a36-4ed7-4ae8-8b74-48f79a502a36@126.com>
 <fc1241a6-6760-4f73-840d-4f3a538644aa@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <fc1241a6-6760-4f73-840d-4f3a538644aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v6Xwm39nae7KAw--.35704S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1DZF4fAryDAr43JrWxtFb_yoW5WFykpF
	4xKrW3GayDXF9Fkr1vqw48Jr18u3yxGrW8JF4fKrWruFnxXry7KFnFvwn5uayIkF1FyF4I
	vr4qv3srKF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgrPG2d-mgcakAAAsv



在 2025/1/9 5:05, David Hildenbrand 写道:
> Sorry for the late reply, holidays ...
> 
>>> Did you ever try allocating a larger range with a single
>>> alloc_contig_range() call, that possibly has to migrate multiple hugetlb
>>> folios in one go (and maybe just allocates one of the just-freed hugetlb
>>> folios as migration target)?
>>>
>>
>> I have tried using a single alloc_contig_range() call to allocate a
>> larger contiguous range, and it works properly. This is because during
>> the period between __alloc_contig_migrate_range() and
>> isolate_freepages_range(), no one allocates a hugetlb folio from the
>> free hugetlb pool.
> 
> Did you trigger the following as well?
> 
> alloc_contig_range() that covers multiple in-use hugetlb pages, like
> 
> [ huge 0 ] [ huge 1 ] [ huge 2 ] [ huge 3 ]
> 
> I assume the following happens:
> 
> To migrate huge 0, we have to allocate a fresh page from the buddy. 
> After migration, we return now-free huge 0 to the pool.
> 
> To migrate huge 1, we can just grab now-free huge 0 from the pool, and 
> not allocate a fresh one from the buddy.
> 
> At least that's my impression when reading alloc_migration_target()- 
>  >alloc_hugetlb_folio_nodemask().

Thank you very much for your suggestions.

It needs to be discussed in two different scenarios:

1, When All Free HugeTLB Pages in the Pool Are Allocated, 
available_huge_page() Returns false

If available_huge_page() returns false, indicating that no free huge 
pages are available in the hugeTLB pool, we will invoke 
alloc_migrate_hugetlb_folio() to allocate a new folio. A temporary flag 
will be set on this new folio. After the migration of the hugeTLB folio 
is completed, the temporary flag will be transferred from the new folio 
to the old one. Any folio with the temporary flag, when freed, will be 
directly released to the buddy allocator.

2, When Some Free HugeTLB Pages in the Pool Are Still Available, 
available_huge_page() Returns true

If available_huge_page() returns true, indicating that there are still 
free huge pages available in the hugeTLB pool, we will call 
dequeue_hugetlb_folio_node() to allocate a new folio. After the 
migration of the hugeTLB folio is completed, the old folio will be 
released back to the free hugeTLB pool. However, this scenario may pose 
potential issues, as you mentioned earlier. It seems that the issue can 
be resolved by the following approach:

dequeue_hugetlb_folio_node_exact() {
     list_for_each_entry(folio, &h->hugepage_freelists[nid], lru) {
         if (is_migrate_isolate_page(folio)) {  //determine whether a 
hugetlb page is isolated
              continue;
         }
     }
}



> 
> Or is for some reason available_huge_pages()==false and we always end up 
> in alloc_migrate_hugetlb_folio()->alloc_fresh_hugetlb_folio()?
> 
> Sorry for the stupid questions, the code is complicated, and I cannot 
> see how this would work.
> 


