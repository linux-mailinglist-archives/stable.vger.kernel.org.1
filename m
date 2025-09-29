Return-Path: <stable+bounces-181868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ADABA8D87
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 12:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E2C3C229E
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732D1898F8;
	Mon, 29 Sep 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gzO39fAC"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C126FDB2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140947; cv=none; b=VMZ9E7QpmklXAWkmrT0XcK3RKWcfY3DD0P+swqeA/dHr2J/1GdneYNpZUUz05qbOxNWELMbX8+PUOZeTkYPcVcyry3mBcxO7C1Gou4BRAieDu6DvuwUDrVGGWCLq7QryYqjvX4+Ojg2rHUootUYtPjZxmqWENF9n/eBounYqWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140947; c=relaxed/simple;
	bh=OlJqGE1Z97dkVyrN0caTtErA3Xa9MnJBfPFMdEyvW9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEbFA+hs7UHYhxPdVYm4zEST4z88MMDBqGLMnEhkgX7MOuM5b3RYQpztpnKro+DhsJdqCGmJYAbTWdiXypjrTHQHDYUk2SctTarxNeGUs0g+yN2A2SidU2OxLbI0JmpZgnKg4ikbO08L51Bye/0wKvF8HsYK3EnQCKzV+QHATlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gzO39fAC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e88cbc23-16af-458e-9f5f-6b06eff0d8f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759140943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lDTfGg/6Uyqwfi6NmuvIilfdfFny0fXjAuu0Bjee84=;
	b=gzO39fACECb42zPXJwdyj6Jv27mioHJsXOtNOgcfJ+jWFO9VImd3+gUNkHtBP/obtV3B7B
	pFJMjkkPJqkUu67chDrlvcIkKpsNMrW9Bn08O92QVgLhNIqIFhRQ4VYEvvxjJgrjLaQWri
	YMHMpUqryT0WsiiYzr+1JRdaCwrF8G8=
Date: Mon, 29 Sep 2025 18:15:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping
 zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, david@redhat.com
References: <20250928044855.76359-1-lance.yang@linux.dev>
 <2065263d-a2c0-437e-a096-695c6d17f97a@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2065263d-a2c0-437e-a096-695c6d17f97a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/29 12:44, Dev Jain wrote:
> 
> On 28/09/25 10:18 am, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When splitting an mTHP and replacing a zero-filled subpage with the 
>> shared
>> zeropage, try_to_map_unused_to_zeropage() currently drops the soft-dirty
>> bit.
>>
>> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
>> incremental snapshots, losing this bit means modified pages are missed,
>> leading to inconsistent memory state after restore.
>>
>> Preserve the soft-dirty bit from the old PTE when creating the zeropage
>> mapping to ensure modified pages are correctly tracked.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage 
>> when splitting isolated thp")
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/migrate.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ce83c2c3c287..bf364ba07a3f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct 
>> page_vma_mapped_walk *pvmw,
>>       newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>                       pvmw->vma->vm_page_prot));
>> +
>> +    if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
>> +        newpte = pte_mksoft_dirty(newpte);
>> +
>>       set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>       dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> 
> I think this should work.
> 
> You can pass old_pte = ptep_get(pvmw->pte) to this function to avoid 
> calling ptep_get()
> multiple times.

Good catch! Will do in v2, thanks.


