Return-Path: <stable+bounces-183354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34590BB8873
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD2344F06B7
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA43217648;
	Sat,  4 Oct 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IO2KSUrz"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA6154BF5
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545471; cv=none; b=riDvrD3iYCfJ/Rw89ljQ7PUgc7G/Pi2IDq0LmUY4GzOD9y/HyKu5x2RIJw+1OHXTF0B3w3yB8mlD7k514IRITpMFeHdry+QFwegcIlSwLmoZ7XMBOEJkE+dSmHep1JQ4kIF0OHyJal5P8WsszNU5f9KNucTC0kI+pSJJTeMMRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545471; c=relaxed/simple;
	bh=ojEC4F74RyQdjtfSesHvInRes6Dm0twjpKoZy9BdHO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uy10pFpEtRpejuml33MDg/qsbWFUygOPsgkbcZtAaR/XUKm3a5kBYMl5+6gq9WX/Dt/ITN9GFDYiWtgBrsCVSxhni8K+E4Vb77zf8PlCt8SGr/JTv3v+UWtrEh7IOwYMCVhHnXO6wYHHwLVXaIH30g+jC8x5nzlC8KVMF7Ef/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IO2KSUrz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c4be2e8-04f5-49c6-9055-cef033716c19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759545467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtsI3lx2659ed28Hsfe3yffVn1tmzg1sTkqeGJ64sdY=;
	b=IO2KSUrzq3V4cuTh3UvbNkBrJC37Pe4HdjZa1lIkRq+QI5SWpv8888ULk3oRQ/d9QYS8Qm
	0dZg+eRRrT2guK4KsRhzfCQtFhiTwyE1bDA9xwVDVDKaG1ZxVGh47HBeZecDDyD59xJk14
	O2bQfUuPDvgjzk1F/Oo+VzJwxOfh0+Q=
Date: Sat, 4 Oct 2025 10:37:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 wangkefeng.wang@huawei.com, stable@vger.kernel.org, ziy@nvidia.com,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com,
 baohua@kernel.org, akpm@linux-foundation.org, david@redhat.com
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
 <20251004020447.slfiuvu5elidwosl@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251004020447.slfiuvu5elidwosl@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/4 10:04, Wei Yang wrote:
> On Fri, Oct 03, 2025 at 09:49:28PM +0800, Lance Yang wrote:
>> Hey Wei,
>>
>> On 2025/10/2 09:38, Wei Yang wrote:
>>> We add pmd folio into ds_queue on the first page fault in
>>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>>> memory pressure. This should be the same for a pmd folio during wp
>>> page fault.
>>>
>>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>>> to add it to ds_queue, which means system may not reclaim enough memory
>>
>> IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
>> started unconditionally adding all new anon THPs to _deferred_list :)
>>
> 
> Thanks for taking a look.
> 
> While at this time do_huge_zero_wp_pmd() is not introduced, how it fix a

Ah, I see. I was focused on the policy change ...

> non-exist case? And how could it be backported? I am confused here.

And, yes, 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") was
merged later and it introduced the new do_huge_zero_wp_pmd() path without
aligning with the policy ...

Thanks for clarifying!
Lance

> 
>>> in case of memory pressure even the pmd folio is under used.
>>>
>>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>>> folio installation consistent.
>>>
>>> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>>
>> Shouldn't this rather be the following?
>>
>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>>
>> Thanks,
>> Lance
> 


