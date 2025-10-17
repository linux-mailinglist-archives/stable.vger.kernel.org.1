Return-Path: <stable+bounces-186308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC61BE80CE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 12:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E66474E616E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963042848AE;
	Fri, 17 Oct 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkG5700c"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427733469C
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696757; cv=none; b=GnYOJvXj/N0DtxMapn1e5SR50RzhOR+XJHE+XG9sXig5KNe+b0hR7npdkrqbdvn8XldX0KLPcOw9WYTVZq95uuvsp2IzxDIv6FjcO9wj7f5jRtRdxgDKg6RuUDNFescOqRFngIAWS2MImoLdC3JcKQP+cDe/AWfTRnIqseLHQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696757; c=relaxed/simple;
	bh=qXiF43uiFomGjDeNbC1nneO5jLyARTJEYGeXT1QyCMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbDfJ/fsJ5exFYfBw0mUIEksaG1hih0aI9dlmgcJF+XT/VLUtJ5re/gGo6EOhrTJtuIcFBUq+T/y5mcp0Vr1ys9Qa4JyfJCYx1HEYMLo4Tb1HAFSpCi8jSEmVJuxEqwfhH2z4XQhaMcXewkUSTX9uSf4Nwy1geOsE6ouBbCwgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkG5700c; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3390d129-e540-42f0-aada-0c8b6fe96f26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760696752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGhwijPMwyEwfmctPnZ8jN0o9Q6RvMEbft3ZkUnGkAE=;
	b=kkG5700cy0SYvdodYajjQExF+3CwG7ntqL1YH5oF1g3z3DTkrbMoJ2W4s3ftqCD5/IIxrs
	RPutPb0PloNzNxXk65HIHq+k/XH7eO/N+9m1iABDw4dZ7OWolx6Ca8ZPR+yju1fiAOT1N9
	aBkw0IApPDuYPaYjwtqvUn7tavkBxAc=
Date: Fri, 17 Oct 2025 18:25:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.12.y 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss
 when remapping zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, ioworker0@gmail.com,
 David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, Jann Horn <jannh@google.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Mariano Pache <npache@redhat.com>,
 Mathew Brost <matthew.brost@intel.com>, Peter Xu <peterx@redhat.com>,
 Rakie Kim <rakie.kim@sk.com>, Rik van Riel <riel@surriel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Usama Arif <usamaarif642@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <2025101627-shortage-author-7f5b@gregkh>
 <20251017085106.16330-1-lance.yang@linux.dev>
 <121d5933-16d9-4eb5-b2b5-2edff9b36c16@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <121d5933-16d9-4eb5-b2b5-2edff9b36c16@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/17 17:52, Lorenzo Stoakes wrote:
> On Fri, Oct 17, 2025 at 04:51:06PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When splitting an mTHP and replacing a zero-filled subpage with the shared
>> zeropage, try_to_map_unused_to_zeropage() currently drops several
>> important PTE bits.
>>
>> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
>> incremental snapshots, losing the soft-dirty bit means modified pages are
>> missed, leading to inconsistent memory state after restore.
>>
>> As pointed out by David, the more critical uffd-wp bit is also dropped.
>> This breaks the userfaultfd write-protection mechanism, causing writes to
>> be silently missed by monitoring applications, which can lead to data
>> corruption.
>>
>> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
>> creating the new zeropage mapping to ensure they are correctly tracked.
>>
>> Link: https://lkml.kernel.org/r/20250930081040.80926-1-lance.yang@linux.dev
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Dev Jain <dev.jain@arm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> You're missing my R-b...

Sorry, I missed it! I just cherry-picked the commit from
upstream and didn't notice ...

Hopefully Greg can add your Reviewed-by when applying.

