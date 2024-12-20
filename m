Return-Path: <stable+bounces-105406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F19F8E95
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C15218923FE
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0781A83ED;
	Fri, 20 Dec 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LMxBIfQ/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E11A726B;
	Fri, 20 Dec 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685466; cv=none; b=tIRzQNsldG/QPybyXdY5qpXT4lAyv8fvUh7kct9sAiiL0NUiVSMtPjrNWKAjUFBNLqCAmmfNN0HGEe9nOkeZpZeILbd1ptV4hbWFWJri4MoLVDtFhE0eqIcDfNL5b/0IadtXkjHRSXgfdsm2xc9ZABJ8D36fCwWmqxtWwyxgSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685466; c=relaxed/simple;
	bh=1Ti6XMH9pUXfXmyxQjyGxz1LxhgclpBCO8+qlbHmMlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLebs0JqqPqnGz7n1WvrytrO/lKhUTdD1S398ix5UTxvx/BOPluQ9qAcDSBhqyLwsV5ke0mMk1ijdrI4wB2kX25Rl6XtLj3RbCd2dyKk583c5rncqDwoDWyP4WGsNXkSDNAzizX8ufb9hmk9sqw/C27oaG5mC9mM3Hz8wCCyXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LMxBIfQ/; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=2tfd3OeQZhvI5s/uqg7ObNyfdEbgcw00VOEf8s5Q39Y=;
	b=LMxBIfQ/6s5HdH5tuYLCTk50lSZueaxbNM8GuKaOMTxzX44ZLRw95DYT+imuju
	OVV0HQ+mNX3BXLUtCfXHsyo6B/WSpT/Cs6b57KpoDKvJGY85YHdK164y32OVniRi
	5WHilgR0V1U7V49CBOIZyR7k4TzTJt0GYqhUJyOZP7Mmc=
Received: from [172.20.10.3] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3H3nhMmVnd+hkAA--.65229S2;
	Fri, 20 Dec 2024 17:03:30 +0800 (CST)
Message-ID: <1c05db02-f1f7-475b-ad89-9c00ab970604@126.com>
Date: Fri, 20 Dec 2024 17:03:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn
References: <20241219184301.63011-1-sj@kernel.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20241219184301.63011-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H3nhMmVnd+hkAA--.65229S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw48AFy3tr18CFyfKF4kJFb_yoW8Jw43pF
	ykGF1DtrW8trykurZ7trsxAFyavrn0qryjkrWxJa47A3W3tw1qgF15Zr15Ar4rurZ7GF4I
	v3y2gF4q9a1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut8nOUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhG7G2dlJ1XGEwAAsu



在 2024/12/20 2:43, SeongJae Park 写道:
> Hello,
> 
> On Wed, 18 Dec 2024 14:33:08 +0800 yangge1116@126.com wrote:
> 
> [...]
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index ae4fe86..7d36ac8 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -681,6 +681,7 @@ struct huge_bootmem_page {
>>   };
>>   
>>   int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
>> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
>>   struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>   				unsigned long addr, int avoid_reserve);
>>   struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
>> @@ -1059,6 +1060,11 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
>>   	return -ENOMEM;
>>   }
>>   
>> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
>> +{
>> +	return 0;
>> +}
>> +
> 
> I think this should be static inline.  Otherwise, build fails when
> CONFIG_HUGETLB_PAGE is unset.  Since this is already merged into mm-unstable
> and the problem and fix seems straigthforward, I directly sent my fix:
> https://lore.kernel.org/20241219183753.62922-1-sj@kernel.org
> 
> 
> Thanks,
> SJ
> 
> [...]

Thanks.



