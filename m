Return-Path: <stable+bounces-62731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF8940E6A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA40282FF7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C81E196D90;
	Tue, 30 Jul 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="X9TpeQsz"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6A1974FA;
	Tue, 30 Jul 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333483; cv=none; b=j883HLDFAljMI2k/N97/hft88Z40dKegkL7BwZTbZj+qPzLZFJWxlXXihhTHcesirMO7SCbgEzOhHsfJufT/dB7Xq1o1lI84bdRMRM1XnN/V98Gb3iwoX4mGX847bwKzzpuG00GvBDsVizhKHMgX6bk7rwBOwLqqnMEAUj0kAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333483; c=relaxed/simple;
	bh=yUvPN3CA0bZgU97K8PhOhi6ebp15vNAEfxa0lel/Mrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPE9bJTpx0ys2lqic4pvuBSFC9rx6kKZ/O3YvO7INhyXSbD/uK0lNWEmhmZYCfy+EWqbR3w3IFAoSQpSh1APeTNraxu5iqCqvUh2VBPBd7S2N60vidBssmLlOvc9VvPjmCyLUmXfKmD8OQGHroOE8BI1kzgQX0+pFqKq4SF0koU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=X9TpeQsz; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Co2lL2cfU3hSe0Vfl/MJK5nN1E61nFj+Hw6DAxjXcvg=;
	b=X9TpeQszSCP541e+3Cu/MwMdYX67ClmK4HmGPUnolpzPrg3fJ/9Tkf6kiSENMh
	esO2TR32LH1FT0KZb59g9VdDnD0kWkUDmWaIcWPj7poMJZQzrJ9WAxUd8sUBhhlB
	1meowXFfiZDIuVbJKyKTDb9eyZeJ961l22h30wCmy3V8Q=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD33ybeuKhmsyKAAw--.48208S2;
	Tue, 30 Jul 2024 17:56:48 +0800 (CST)
Message-ID: <9f1b8c87-6ea4-4f88-9332-13ac4b1b35d9@126.com>
Date: Tue, 30 Jul 2024 17:56:46 +0800
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
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <a8abf253-b1bb-422a-9d3f-d0dd24990617@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33ybeuKhmsyKAAw--.48208S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw13Kr45Aw47WFWUCFyfZwb_yoW8WrW8pF
	WxK3Wqgr4kJr9FyrsFqrn8XFyrtrW3Xa1UXFW3Grn3uFn0y3Z7GF47C34UCFy3Ar4DJF1I
	qay8tF1xZFyjvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYpB-UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQMsG2VLbyW9XgAAsq



在 2024/7/30 17:41, David Hildenbrand 写道:
> On 30.07.24 11:36, Ge Yang wrote:
>>
>>
>> 在 2024/7/30 15:45, David Hildenbrand 写道:
>>>>> Looking at this in more detail, I wonder if we can turn that to
>>>>>
>>>>> if (!folio_test_clear_lru(folio))
>>>>>        return;
>>>>> folio_get(folio);
>>>>>
>>>>> In all cases? The caller must hold a reference, so this should be 
>>>>> fine.
>>>>>
>>>>
>>>> Seems the caller madvise_free_pte_range(...), calling
>>>> folio_mark_lazyfree(...), doesn't hold a reference on folio.
>>>>
>>>
>>> If that would be the case and the folio could get freed concurrently,
>>> the folio_get(folio) would be completely broken.
>>>
>>> In madvise_free_pte_range() we hold the PTL, so the folio cannot get
>>> freed concurrently.
>>>
>>
>> Right.
>>
>>> folio_get() is only allowed when we are sure the folio cannot get freed
>>> concurrently, because we know there is a reference that cannot go away.
>>>
>>>
>>
>> When cpu0 runs folio_activate(), and cpu1 runs folio_put() concurrently,
>> a possible bad scenario would like:
>>
>> cpu0                                           cpu1
>>
>>                                              folio_put_testzero(folio)
>> if (!folio_test_clear_lru(folio))// Seems folio shouldn't be accessed
>>
>>          return;
>> folio_get(folio);
>>                                               __folio_put(folio)
>>                                               __folio_clear_lru(folio)
>>
>>
>> Seems we should use folio_try_get(folio) instead of folio_get(folio).
> 
> In which case is folio_activate() called without the PTL on a mapped 
> page or without a raised refcount?
> 

No such case has been found. But, folio_put() can be run at anytime, so 
folio_activate() may access a folio with a reference count of 0.


