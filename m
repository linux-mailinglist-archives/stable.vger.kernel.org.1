Return-Path: <stable+bounces-62733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DD940E8F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395281C211EC
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE08195F28;
	Tue, 30 Jul 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hBWHkdiZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA97194A49;
	Tue, 30 Jul 2024 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333784; cv=none; b=B6wzvkhQ3daAptfl9H+Sglng13rgCuOhcP+1t3WF9B82SgI/ehsW8ukXuGmtuSDzqBZr/hknjeLXvTRVIyrrdEc+53o5v46bWNBFxVA1J5jWNf1cyHtmm/MNGYKxZp7THhx2LwaRbZe7lxaVcmkEWnUstgepZpVBVhgcQApNLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333784; c=relaxed/simple;
	bh=Sxj6T2e8H3iOl77/RRAmKUj8/cujWJb7+RDEKzzRT34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwdgQZh+SxmnmrVjanKf+JrKGVl4A7r8ZGsm+NbsQd9VaGHApSFCP1wAN/8aWO3pCrrgtThcJ/+Y6cCpLApQM5s5uLrV8KqpX7WJ5JZBy3ZJN8h7vHX563ChhoEK/+lWSPDus18kEbQ21z/DB63nyK2rp+ZrOxc5yImLkj54ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hBWHkdiZ; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZLcbpVCULNRrBnozP+gUuxo88BIerhBLHccbm3mX2/o=;
	b=hBWHkdiZY+IiOOhDa/TGrGVXw83g/Wp15tpiiYWaxcR40ci7D/x8/DKnUsJcFK
	k3yfLqeLoFbCMrKs77Epe5RAQR3dH6oUAzak3OGx4/UWBSEmSor5b1ZkgQLVs2pW
	Hi+4ankNvHGxT7eeC2IXEqkQya6YwgJyDwfV0E4L/rtM8=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnr_kJuqhm1wPgAw--.37433S2;
	Tue, 30 Jul 2024 18:01:46 +0800 (CST)
Message-ID: <18cdbd92-81db-42be-a290-08462759ffe6@126.com>
Date: Tue, 30 Jul 2024 18:01:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <3a2ab0ea-3a07-45a0-ae0e-b9d48bf409bd@redhat.com>
 <79234eac-d7cc-424b-984d-b78861a5e862@126.com>
 <9e018975-8a80-46a6-ab38-f3e2945c8878@redhat.com>
 <1c5f1582-d6ea-4e27-a966-e6e992cf7c22@126.com>
 <a8abf253-b1bb-422a-9d3f-d0dd24990617@redhat.com>
 <9f1b8c87-6ea4-4f88-9332-13ac4b1b35d9@126.com>
 <d41865b4-d6fa-49ba-890a-921eefad27dd@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <d41865b4-d6fa-49ba-890a-921eefad27dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr_kJuqhm1wPgAw--.37433S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur13Xr1DWrW7KFWUZrW8Zwb_yoW8Zry8pr
	WxG3Wqqr4kJr9Fyr4qqr1UJFyUtry3Xa1UXF43GrnrCFn0yrn7Gr47C3yUCFy3Ar1DJF10
	qa4Uta4xXa4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYOJ5UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQosG2VLbyXSowABsw



在 2024/7/30 17:58, David Hildenbrand 写道:
> On 30.07.24 11:56, Ge Yang wrote:
>>
>>
>> 在 2024/7/30 17:41, David Hildenbrand 写道:
>>> On 30.07.24 11:36, Ge Yang wrote:
>>>>
>>>>
>>>> 在 2024/7/30 15:45, David Hildenbrand 写道:
>>>>>>> Looking at this in more detail, I wonder if we can turn that to
>>>>>>>
>>>>>>> if (!folio_test_clear_lru(folio))
>>>>>>>         return;
>>>>>>> folio_get(folio);
>>>>>>>
>>>>>>> In all cases? The caller must hold a reference, so this should be
>>>>>>> fine.
>>>>>>>
>>>>>>
>>>>>> Seems the caller madvise_free_pte_range(...), calling
>>>>>> folio_mark_lazyfree(...), doesn't hold a reference on folio.
>>>>>>
>>>>>
>>>>> If that would be the case and the folio could get freed concurrently,
>>>>> the folio_get(folio) would be completely broken.
>>>>>
>>>>> In madvise_free_pte_range() we hold the PTL, so the folio cannot get
>>>>> freed concurrently.
>>>>>
>>>>
>>>> Right.
>>>>
>>>>> folio_get() is only allowed when we are sure the folio cannot get 
>>>>> freed
>>>>> concurrently, because we know there is a reference that cannot go 
>>>>> away.
>>>>>
>>>>>
>>>>
>>>> When cpu0 runs folio_activate(), and cpu1 runs folio_put() 
>>>> concurrently,
>>>> a possible bad scenario would like:
>>>>
>>>> cpu0                                           cpu1
>>>>
>>>>                                               folio_put_testzero(folio)
>>>> if (!folio_test_clear_lru(folio))// Seems folio shouldn't be accessed
>>>>
>>>>           return;
>>>> folio_get(folio);
>>>>                                                __folio_put(folio)
>>>>                                                __folio_clear_lru(folio)
>>>>
>>>>
>>>> Seems we should use folio_try_get(folio) instead of folio_get(folio).
>>>
>>> In which case is folio_activate() called without the PTL on a mapped
>>> page or without a raised refcount?
>>>
>>
>> No such case has been found. But, folio_put() can be run at anytime, so
>> folio_activate() may access a folio with a reference count of 0.
> 
> If you can't find such a case then nothing is broken and no switch to 
> folio_try_get() is required.
> 

Ok, thanks.


