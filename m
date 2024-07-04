Return-Path: <stable+bounces-58009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD5926F73
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 08:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E1E2841D9
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8D1A00F5;
	Thu,  4 Jul 2024 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BOfhcVi8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077511BDCF;
	Thu,  4 Jul 2024 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074337; cv=none; b=rWyTLhm4DD4u5GIHJLI0kUr0hnAVWCeMn17Tz9RH0XFufFo+41mlMPDTlkPvgZZHyYd/QeSl7rHy2caCLciK7PrcOZpuCRKXKRKVRinJ7gjGM+o0a0udMcVW0HF31PYHYY33HYfSFuq9JNEG6GJA0RB0yMnAKhrkB7rrMsaGWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074337; c=relaxed/simple;
	bh=T2BXVPG0Xciyi6KtfRni/IEp7xhSTzvD3uma1vOVg90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnmPHsxOFDF6QGAUnR8Qy+cEekXH25aJCDJVrHbXnpwQ+vxBLwMKkjsx0/yeXp396JGwmvuFcMv79a3gSqHgyt9e+zTjpv5czUqL3frQFK7R3I69plWoAwLbCNcwMPdsVwP1q1ScDJu+c3Oh0vAYKH3rKz4S/M6sOcLpr+M3p5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BOfhcVi8; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=/AKERoNUk3QOspjtoJsYJHGJH3MzhEmNn77tnVZjOls=;
	b=BOfhcVi8iWK8aFiViJYt4G9BC6pASMp8AFGgf4Bp6m/VWeZu+8Dzp1sjCZYUpA
	2UWjo+FI+O0h8TGOSchnGjmfY9YPLl3fxxoRDMTge7DTifnBkFhjegFd0eeAJib4
	XOz8G0V3CNHrRWx68NDaHoMV/bQSrZ/a9JiKW9wxqOk84=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3P+YOQIZm42A0AQ--.856S2;
	Thu, 04 Jul 2024 14:24:16 +0800 (CST)
Message-ID: <ef7eee42-ebee-477c-83f5-d2103886ccd5@126.com>
Date: Thu, 4 Jul 2024 14:24:14 +0800
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
 <26efe5f2-0cad-404c-82ca-a556469ba9c7@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <26efe5f2-0cad-404c-82ca-a556469ba9c7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+YOQIZm42A0AQ--.856S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1rCryxAr4UuF45CF1xXwb_yoW5XryrpF
	Wft3WakrWDXFZa9rn7J3yDCr1SyrZ2yw45Ar1fJr18Cws8WFya9rW5K3WDWa45CrWYga1a
	vr409rn5uF4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5WrXUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBUSG2VLcMptdgAAsL



在 2024/7/3 20:02, David Hildenbrand 写道:
> On 22.06.24 08:48, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> If a large number of CMA memory are configured in system (for example, 
>> the
>> CMA memory accounts for 50% of the system memory), starting a virtual
>> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
>> ...) to pin memory.  Normally if a page is present and in CMA area,
>> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
>> area because of FOLL_LONGTERM flag. But the current code will cause the
>> migration failure due to unexpected page refcounts, and eventually cause
>> the virtual machine fail to start.
>>
>> If a page is added in LRU batch, its refcount increases one, remove the
>> page from LRU batch decreases one. Page migration requires the page is 
>> not
>> referenced by others except page mapping. Before migrating a page, we
>> should try to drain the page from LRU batch in case the page is in it,
>> however, folio_test_lru() is not sufficient to tell whether the page is
>> in LRU batch or not, if the page is in LRU batch, the migration will 
>> fail.
>>
>> To solve the problem above, we modify the logic of adding to LRU batch.
>> Before adding a page to LRU batch, we clear the LRU flag of the page so
>> that we can check whether the page is in LRU batch by 
>> folio_test_lru(page).
>> Seems making the LRU flag of the page invisible a long time is no 
>> problem,
>> because a new page is allocated from buddy and added to the lru batch,
>> its LRU flag is also not visible for a long time.
>>
> 
> I think we need to describe the impact of this change in a better way. 
> This example here is certainly interesting, but if pages are new they 
> are also not candidate for immediate reclaim (tail of the LRU).
> 
> The positive thing is that we can more reliably identify pages that are 
> on an LRU batch.
> 
> Further, a page can now only be on exactly one LRU batch.
> 
> But, as long as a page is on a LRU batch, we cannot isolate it, and we 
> cannot check if it's an LRU page. The latter can currently already 
> happen for a shorter time when moving LRU pages, and temporarily 
> clearing the flag.
> 
> I shared some examples where we don't care, because we'd check for 
> additional folio references either way (and the one from the LRU batch).
> 
> But I think we have to identify if there are any LRU folio/page checks 
> that could now be impacted "more". At least we should document it 
> properly to better understand the possible impact (do we maybe have to 
> flush more often?).
> 

Thanks.
I have reviewed a lot of paths using LRU folio/page checks and haven't 
seen more impact. I will documnt possible impact in next version, thanks.



