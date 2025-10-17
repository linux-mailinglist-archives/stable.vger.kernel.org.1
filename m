Return-Path: <stable+bounces-186311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0EBE8453
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6521AA2D67
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820133CEA5;
	Fri, 17 Oct 2025 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVS25rQ8"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3833EAF8
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699688; cv=none; b=kPeIX650dVP+/io8kBr3DqadquL8XFsD9yxnkSgvRRI5cNoMh9VfRtX0088D5xdbgyAueUjATREdBDl2GA9X4pE6VO70Re4Ji/VSAzVPOQ4dBGpr+EWdCt3nFotXZgmdrlAWY1ohfQlIoranUGY58HfQ/0k1FNCLMp/a3Sj3Ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699688; c=relaxed/simple;
	bh=uiEOhX59jKsl980FD369FU/qtRzkOpxrotwds16kBqU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IOPu817+csAQrUnm74/eO/f7vGFzZCrpTDE8ByHivt3Vnl+Fgq1yZ4yysvixTks9p/B2nN7bFgLJAssPZxG7keachk3DzHUmCH/nxADdkRyOuwOG0loHmQE2vbHh/F2pPsQvAyMXxcxGJF9txtcibVcFlECrpoUPL2gq/94xpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVS25rQ8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <384aa808-1893-4f44-9c76-96a21c1989d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760699683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YA/xLAG8p45THXYYw7JCFQ9A+nLtvOhAjcG32D7eHo=;
	b=rVS25rQ865xS2yGt3O/yQdSrncZauX78g1/G02hwqFi+vY+Kp8bbebzjrHfnBPsBlcHOSi
	MZU7eFIaVjCdjwWXgV10d1oD6IZmCf/q1+6CrAI8qaqEeiambsRra6jrOmeKlL3E5OWmJR
	tJsIReAZdoG59daw1s1T6JGuSc8jBOA=
Date: Fri, 17 Oct 2025 19:14:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.12.y 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss
 when remapping zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
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
 <3390d129-e540-42f0-aada-0c8b6fe96f26@linux.dev>
In-Reply-To: <3390d129-e540-42f0-aada-0c8b6fe96f26@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/17 18:25, Lance Yang wrote:
> 
> 
> On 2025/10/17 17:52, Lorenzo Stoakes wrote:
>> On Fri, Oct 17, 2025 at 04:51:06PM +0800, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> When splitting an mTHP and replacing a zero-filled subpage with the 
>>> shared
>>> zeropage, try_to_map_unused_to_zeropage() currently drops several
>>> important PTE bits.
>>>
>>> For userspace tools like CRIU, which rely on the soft-dirty mechanism 
>>> for
>>> incremental snapshots, losing the soft-dirty bit means modified pages 
>>> are
>>> missed, leading to inconsistent memory state after restore.
>>>
>>> As pointed out by David, the more critical uffd-wp bit is also dropped.
>>> This breaks the userfaultfd write-protection mechanism, causing 
>>> writes to
>>> be silently missed by monitoring applications, which can lead to data
>>> corruption.
>>>
>>> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
>>> creating the new zeropage mapping to ensure they are correctly tracked.
>>>
>>> Link: https://lkml.kernel.org/r/20250930081040.80926-1- 
>>> lance.yang@linux.dev
>>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage 
>>> when splitting isolated thp")
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Dev Jain <dev.jain@arm.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>
>> You're missing my R-b...
> 
> Sorry, I missed it! I just cherry-picked the commit from
> upstream and didn't notice ...
> 
> Hopefully Greg can add your Reviewed-by when applying.

Looking at the timeline again, the fix was actually merged
upstream before your review arrived, so the commit I
cherry-picked never had your tag to begin with :(

Still hoping Greg can add it!

