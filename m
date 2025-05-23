Return-Path: <stable+bounces-146175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49EAC1E49
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27E21B662C6
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 08:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233E2882D8;
	Fri, 23 May 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SKPOna0M"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C03213235;
	Fri, 23 May 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987722; cv=none; b=Zz5QONXXHnhnNOgJ4N0199B7rH7g+v5RFGlK7plTt4D+66gU/RwO/z1aV/R+DdKkxv1uzTLe+xLK2STDfA3F5cK/wKKLLgLpWsBxM+2Bf7Ss/TIm1Vxs2KVuIb7va1EOlbuB7eJvNDLmXKPMRiQ10sB4CeUQakUMsG/snBsCcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987722; c=relaxed/simple;
	bh=MgVgCl1iX1UzjCpwnuVxFoJJLNutyQ18+npIzepKsvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzZ6Ck0mXLIgslm3dI3omN/jfu9mMNb60AGeNnD+zxTBHyv5Yvlswm2dd50axiV8X9KsoTMeFYDZw1vaVzz1c2vZhdQIn1RsrtcxONMT9XJL/exEkIKgIkB9zymGCmPsoIqXfEYyMC93J7nW3bi2ICyOhNR5DrKQ/Vjl4wTeZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SKPOna0M; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fYdsG1Zlzgn0Ck8jGE+RvNMGqHp4epmhTOfgvqbXWA0=;
	b=SKPOna0MvG79ANsXTA6n6MYbRIXPQHyD5dRORt9kesK+6/5ult/spC7nHzd4wF
	H++Hp26nQA53CZoWVckQbY3usXw0ZJxmeBmTK+PjXp3qI2AJZa1mZcQ4d5A6sJJh
	m0h0nncV4TWqCQVWH6tT5zOvjqCg5LGYpWDDiUEb+Gqns=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXP6PfLDBo7NZQAg--.42231S2;
	Fri, 23 May 2025 16:08:00 +0800 (CST)
Message-ID: <ffb3b8ae-ab18-4680-8a76-1d3ae1685ab7@126.com>
Date: Fri, 23 May 2025 16:07:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
To: Oscar Salvador <osalvador@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
 <aC8PRkyd3y74Ph5R@localhost.localdomain>
 <3B8641A1-5345-44A5-B610-9BCBC980493D@linux.dev>
 <aC974OtOuj9Tqzsa@localhost.localdomain>
 <DF103E57-601C-4CBB-99CA-088E1C29F517@linux.dev>
 <4e408146-7c77-4f6d-90e8-bb311d7ab53d@126.com>
 <aDAH7nI8H_JfGExm@localhost.localdomain>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <aDAH7nI8H_JfGExm@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP6PfLDBo7NZQAg--.42231S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxD73UUUUU
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbidRBWG2gwKKR7LAABsq



在 2025/5/23 13:30, Oscar Salvador 写道:
> On Fri, May 23, 2025 at 11:46:51AM +0800, Ge Yang wrote:
>> The implementation of alloc_and_dissolve_hugetlb_folio differs between
>> kernel 6.6 and kernel 6.15. To facilitate backporting, I'm planning to
>> submit another patch based on Oscar Salvador's suggestion.
> 
> If the code differs a lot between a stable version and upstream, the way
> to go is to submit a specific patch for the stable one that applies
> to that tree, e.g: [PATCH 6.6]...
> 
> 

Ok, thanks.


