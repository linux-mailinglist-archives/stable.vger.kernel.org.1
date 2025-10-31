Return-Path: <stable+bounces-191802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B0C247B1
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C674608FE
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97039339716;
	Fri, 31 Oct 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nce8sMlE"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AF336EEE
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906865; cv=none; b=ZJ+2JHId8eGvPwZsAcVKQSPZJ5C2OCFiLPwNx8lkG5Dd9/GBuUnktFlSJgPHrrBV23Gz034oRuylr3isxnPjKKYYBafI1D2xIQ9pBbN83BpWvTKlFTgChk/6HSBUZw8gDvaicXgLQ30R8a9ngRMQ4O9xawa8YqU2zdWR85fqTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906865; c=relaxed/simple;
	bh=DgOsns4eXsSGg4ImlNipqf7EsxEa/Phy3SMjBp8pzdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXC+vcEVYplRin08Fkg38uB+q7np6ZvtetIQJFdaQY9IZRn7Dt9jM1mKnN7jKMW9q/kZdXKW+Bs5ghTUBijn/jVIJPpMeYeryMtNCsEuv9XfwaHe0Z0bvBbg3/85hWU3tnLBdeWg5d1qR7/GQArDY15yM9DZ4VRVSRR7JdpDhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nce8sMlE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11c80527-5dc7-440f-b09e-a9e4a8093ee2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761906850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=No4nG0fxP+YGa8mecuIh966uI+UlF5o7DLaj/1/zRLQ=;
	b=Nce8sMlEtSshax3q44vCtydt5Q6Om6F3fG6V8IsPoi85c7l1X3hQpGwgjBtYRssoRogXiu
	s+3HlcOvHRTJKrKoZZIuo3lkykRBBW4X4ovuqyYo/Q17KmbE72Mt65pGhiRQEkew35cDsW
	+lY2qDo1vQSvh+PsnUGQSWVZvW3qM4Y=
Date: Fri, 31 Oct 2025 18:34:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, big-sleep-vuln-reports@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, david@redhat.com,
 stable@vger.kernel.org
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev> <aQSIdCpf-2pJLwAF@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aQSIdCpf-2pJLwAF@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/31 17:59, Mike Rapoport wrote:
> On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The error path in secretmem_fault() frees a folio before restoring its
>> direct map status, which is a race leading to a panic.
> 
> Let's use the issue description from the report:

Will do. I'll also add the missing Fixes: tag.

> 
> When a page fault occurs in a secret memory file created with
> `memfd_secret(2)`, the kernel will allocate a new folio for it, mark
> the underlying page as not-present in the direct map, and add it to
> the file mapping.
> 
> If two tasks cause a fault in the same page concurrently, both could
> end up allocating a folio and removing the page from the direct map,
> but only one would succeed in adding the folio to the file
> mapping. The task that failed undoes the effects of its attempt by (a)
> freeing the folio again and (b) putting the page back into the direct
> map. However, by doing these two operations in this order, the page
> becomes available to the allocator again before it is placed back in
> the direct mapping.
> 
> If another task attempts to allocate the page between (a) and (b), and
> the kernel tries to access it via the direct map, it would result in a
> supervisor not-present page fault.
>   
>> Fix the ordering to restore the map before the folio is freed.
> 
> ... restore the direct map
> 
> With these changes
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!
Lance

> 
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
>> Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/secretmem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/secretmem.c b/mm/secretmem.c
>> index c1bd9a4b663d..37f6d1097853 100644
>> --- a/mm/secretmem.c
>> +++ b/mm/secretmem.c
>> @@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>>   		__folio_mark_uptodate(folio);
>>   		err = filemap_add_folio(mapping, folio, offset, gfp);
>>   		if (unlikely(err)) {
>> -			folio_put(folio);
>>   			/*
>>   			 * If a split of large page was required, it
>>   			 * already happened when we marked the page invalid
>>   			 * which guarantees that this call won't fail
>>   			 */
>>   			set_direct_map_default_noflush(folio_page(folio, 0));
>> +			folio_put(folio);
>>   			if (err == -EEXIST)
>>   				goto retry;
>>   
>> -- 
>> 2.49.0
>>
> 


