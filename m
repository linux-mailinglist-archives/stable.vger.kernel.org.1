Return-Path: <stable+bounces-195449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82DC77120
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDE993550A7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B9254B18;
	Fri, 21 Nov 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vAbv4k9w"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111F2DC350
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693542; cv=none; b=sFVP9U6IlvlsySteMzTaj6qQiyEcoKOSRN+bJUfJ4RF3/GPullAkCCaR8nSbPldpFb6XGxrKZm8ioajdIClf8dNQX0P3v3F/iPp+/sibrEbJy21hV05JurfityvCdEF8Yv2TUh4/+Am257QhW4tfz5BbY+IwEbFZIrx8FAWPhok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693542; c=relaxed/simple;
	bh=22kvScepeUgzy9u+iV1TUCoKsrEkefE67Zj+ksREK4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZRqRPZLVdzgiZY4vK2fsbALjOlFjlPCFo0I0zMC1Zjw+bAl/2wNosqUj+Ht9lICQTfF86RnS1EjADS7xyVVR9dUUCP7GNeMAgTJdXRLiWlQuAsq4aLzzxoYk+cEdF6fgwwfa2/stMc+ykXiCkkq9gQgqC9afbAFLvsQCXvLRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vAbv4k9w; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9cab398-5d55-45fb-b155-50919546300c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763693538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0RxOUEnJhI6YS05bfTKGDCbdsZIWZGOMrBhCkCIu1s=;
	b=vAbv4k9w0csPoygKpVNy7oXlMQLlU8N7fNv0rm7sqb71qjM8dbwqv4GcSoZH7xLZTawj2B
	C8adv7WhxQvzceifh0wHI2Q75vxXaMxxgniAgg5xHWha4NdIfZx52UBNKbMODpaxunadFh
	BQQQhrUv9JsP0s5MN95OAylivfkOMeI=
Date: Fri, 21 Nov 2025 10:52:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] mm/secretmem: fix use-after-free race in fault
 handler
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Google Big Sleep <big-sleep-vuln-reports@google.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <2025112032-parted-progeny-cd9e@gregkh>
 <20251120191547.2344004-1-rppt@kernel.org> <aR9vzeI5Tso6g7PO@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aR9vzeI5Tso6g7PO@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Mike,

Thanks for taking care of the backport conflicts, much appreciated! That
saved me a lot of work/time!

Cheers,
Lance

On 2025/11/21 03:45, Mike Rapoport wrote:
> Oops, copied the wrong git send-email command, sorry for the noise
> 
> On Thu, Nov 20, 2025 at 09:15:47PM +0200, Mike Rapoport wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When a page fault occurs in a secret memory file created with
>> `memfd_secret(2)`, the kernel will allocate a new page for it, mark the
>> underlying page as not-present in the direct map, and add it to the file
>> mapping.
>>
>> If two tasks cause a fault in the same page concurrently, both could end
>> up allocating a page and removing the page from the direct map, but only
>> one would succeed in adding the page to the file mapping.  The task that
>> failed undoes the effects of its attempt by (a) freeing the page again
>> and (b) putting the page back into the direct map.  However, by doing
>> these two operations in this order, the page becomes available to the
>> allocator again before it is placed back in the direct mapping.
>>
>> If another task attempts to allocate the page between (a) and (b), and the
>> kernel tries to access it via the direct map, it would result in a
>> supervisor not-present page fault.
>>
>> Fix the ordering to restore the direct map before the page is freed.
>>
>> Link: https://lkml.kernel.org/r/20251031120955.92116-1-lance.yang@linux.dev
>> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
>> Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> (cherry picked from commit 6f86d0534fddfbd08687fa0f01479d4226bc3c3d)
>> [rppt: replaced folio with page in the patch and in the changelog]
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>>   mm/secretmem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/secretmem.c b/mm/secretmem.c
>> index 624663a94808..0c86133ad33f 100644
>> --- a/mm/secretmem.c
>> +++ b/mm/secretmem.c
>> @@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>>   		__SetPageUptodate(page);
>>   		err = add_to_page_cache_lru(page, mapping, offset, gfp);
>>   		if (unlikely(err)) {
>> -			put_page(page);
>>   			/*
>>   			 * If a split of large page was required, it
>>   			 * already happened when we marked the page invalid
>>   			 * which guarantees that this call won't fail
>>   			 */
>>   			set_direct_map_default_noflush(page);
>> +			put_page(page);
>>   			if (err == -EEXIST)
>>   				goto retry;
>>   
>> -- 
>> 2.50.1
>>
> 


