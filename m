Return-Path: <stable+bounces-146151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F1AC1ABE
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 05:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E791B655CE
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 03:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301C13AD05;
	Fri, 23 May 2025 03:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="j0CqrPB3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417742AB4;
	Fri, 23 May 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972047; cv=none; b=tLDp/8Xuqkei3LL9bqm6aHAmEyju69iBujxSq4Hy7Sn9ZfBqjaf4tg5f/wAgOhALj2GTPil2Z/8T3VQF506S4VEJfol6xV3g9dF6+qfdTep44OaqXMYyDMhHTueMxU6wwwcLlSbYMCR1VuqanDdnsEH4YV1RrrEjsrvBouxp3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972047; c=relaxed/simple;
	bh=IkdmFrSh2VwCtODceQe1mvxAb3VAK663r9TayBQV6g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSebJrIt4LuAVCIR5UGpptEworGirFWXRqk3GWTlf5AdTWvdTf7mJZi73pV2+ZDfh1e/i8Q83zVe3XiCiC9E+X8SCbiU6MnV7hgiyNVuqiU/VVJztq0bNO5NSI75pqyaG1YsqwSPLbxNPINqMstY2iLfitlTbKbqvWIWSYNP3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=j0CqrPB3; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=BRlhWrT2SoYXDlWZPjcJEikz+rURnIHTSURTtEo/7GI=;
	b=j0CqrPB3BVJ2NkTWzNNJzTs2suu7ZY2L22yVmswZVziThaQUpJh9t9b4pblpVs
	IFWdrQZMU8ehbQTkmMo1ChtK6BuZdCzFHAaH3jZEaw+tacAVzITJ4PXLQxo8XlXs
	/SWybH5CWos2S04jMlGdC2HIdu7xn8Nax3cAAbQiaKIrg=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3Xyar7y9oVPJEAg--.40133S2;
	Fri, 23 May 2025 11:46:51 +0800 (CST)
Message-ID: <4e408146-7c77-4f6d-90e8-bb311d7ab53d@126.com>
Date: Fri, 23 May 2025 11:46:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
 <aC8PRkyd3y74Ph5R@localhost.localdomain>
 <3B8641A1-5345-44A5-B610-9BCBC980493D@linux.dev>
 <aC974OtOuj9Tqzsa@localhost.localdomain>
 <DF103E57-601C-4CBB-99CA-088E1C29F517@linux.dev>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <DF103E57-601C-4CBB-99CA-088E1C29F517@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Xyar7y9oVPJEAg--.40133S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1xWrykuFyrZry7Kr18Grg_yoWkGwc_ZF
	W0vas7Gw4UZFy0kF4DGrn0qF98Kw45ZF1YvFWrWrWUCFyftF95Xr98tr4fZwsrWa1jkF45
	tw1Yva93Ar12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8OJ55UUUUU==
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbidRxWG2gv70MMjAAAsP



在 2025/5/23 11:27, Muchun Song 写道:
> 
> 
>> On May 23, 2025, at 03:32, Oscar Salvador <osalvador@suse.de> wrote:
>>
>> On Thu, May 22, 2025 at 08:39:39PM +0800, Muchun Song wrote:
>>> But I think we could use "folio_order() > MAX_PAGE_ORDER" to replace the check
>>> of hstate_is_gigantic(), right? Then ee could remove the first parameter of hstate
>>> from alloc_and_dissolve_hugetlb_folio() and obtain hstate in it.
>>
>> Yes, I think we can do that.
>> So something like the following (compily-tested only) maybe?
>>
>>  From d7199339e905f83b54d22849e8f21f631916ce94 Mon Sep 17 00:00:00 2001
>> From: Oscar Salvador <osalvador@suse.de>
>> Date: Thu, 22 May 2025 19:51:04 +0200
>> Subject: [PATCH] TMP
>>
>> ---
>>   mm/hugetlb.c | 38 +++++++++-----------------------------
>>   1 file changed, 9 insertions(+), 29 deletions(-)
> 
> Pretty simple. The code LGTM.
> 
> Thanks.

Thanks.

The implementation of alloc_and_dissolve_hugetlb_folio differs between 
kernel 6.6 and kernel 6.15. To facilitate backporting, I'm planning to 
submit another patch based on Oscar Salvador's suggestion.


