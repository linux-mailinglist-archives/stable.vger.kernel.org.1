Return-Path: <stable+bounces-182037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CBDBABB44
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE97C3B6572
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7B2BCF4A;
	Tue, 30 Sep 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcLHUDPa"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B37D07D;
	Tue, 30 Sep 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215104; cv=none; b=iwXbrzTsM8fR2903aMns5snMaLxNwARJEwg6zeiRFYnnD6pfAWKM1EEnQMsVWhhUw4w9YNk6hXsWpkUNp2ik2A6byiBB6BPQ4rNAJqE0jYWtQSY8stFukbdy7KG68yhXFe1ec237+t4SwMUN4i2TJciylEl4VUcrj0KhQ/2z53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215104; c=relaxed/simple;
	bh=aJX3DGU+W1LZ8Dh+Z/Lm/fAFVzq9jzJXUxHKVTd4I1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNUh/FsUruIyRgJ1/fFh4iVgQU1DSxlDag+aqKTk2EbQyLh+uQMRcXfS5b8uyx10HdVvbrFagn3lBanhz0eVU5GkuVK1HNIwgqpNQgNcu+11r/s+dyTeFGzdiCVN/qa1d9bmOwYzYWar45hYgoSyDZssjidkU0SrpNLElAyKXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcLHUDPa; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ad95cd2-3a09-4873-b6c4-1e00a88dceb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759215099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGN6BMSkXgx6PB6NEFYkeWWUVlKsILAVHZBwRtmuzRI=;
	b=RcLHUDPak47T8AShrEH2BQNBqjOkZVnsG6DDUI6CgHbkDdkuF/qi+GBb1hVpjXJOcJs5tI
	xqTja3a64qobHcaFO05TFcvfPnaKyOLYen9dXJTqom6mF4e0ZJK5KGMDeLEpv6UJRpFGye
	CckGYTS2op4N2qbq6P99hGEv6fuQY/o=
Date: Tue, 30 Sep 2025 14:51:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, ryan.roberts@arm.com, dev.jain@arm.com,
 npache@redhat.com, riel@surriel.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, usamaarif642@gmail.com, yuzhao@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250930060557.85133-1-lance.yang@linux.dev>
 <026a2673-8195-4927-8cde-f7517b601125@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <026a2673-8195-4927-8cde-f7517b601125@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/30 14:31, David Hildenbrand wrote:
> On 30.09.25 08:05, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When splitting an mTHP and replacing a zero-filled subpage with the 
>> shared
>> zeropage, try_to_map_unused_to_zeropage() currently drops several 
>> important
>> PTE bits.
>>
>> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
>> incremental snapshots, losing the soft-dirty bit means modified pages are
>> missed, leading to inconsistent memory state after restore.
>>
>> As pointed out by David, the more critical uffd-wp bit is also dropped.
>> This breaks the userfaultfd write-protection mechanism, causing writes
>> to be silently missed by monitoring applications, which can lead to data
>> corruption.
>>
>> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
>> creating the new zeropage mapping to ensure they are correctly tracked.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage 
>> when splitting isolated thp")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Dev Jain <dev.jain@arm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v2 -> v3:
>>   - ptep_get() gets called only once per iteration (per Dev)
>>   - https://lore.kernel.org/linux-mm/20250930043351.34927-1- 
>> lance.yang@linux.dev/
>>
>> v1 -> v2:
>>   - Avoid calling ptep_get() multiple times (per Dev)
>>   - Double-check the uffd-wp bit (per David)
>>   - Collect Acked-by from David - thanks!
>>   - https://lore.kernel.org/linux-mm/20250928044855.76359-1- 
>> lance.yang@linux.dev/
>>
>>   mm/migrate.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ce83c2c3c287..bafd8cb3bebe 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -297,6 +297,7 @@ bool isolate_folio_to_list(struct folio *folio, 
>> struct list_head *list)
>>   static bool try_to_map_unused_to_zeropage(struct 
>> page_vma_mapped_walk *pvmw,
>>                         struct folio *folio,
>> +                      pte_t old_pte,
>>                         unsigned long idx)
> 
> Nit:
> 
> static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk 
> *pvmw,
>          struct folio *folio, pte_t old_pte, unsigned long idx)

Well, let me clean that up ;p

> 
> LGTM, Thanks!

Cheers!


