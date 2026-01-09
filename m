Return-Path: <stable+bounces-206425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C69D071E3
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 05:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CC7430360D3
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 04:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04A40855;
	Fri,  9 Jan 2026 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DaWBXmAw"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EF500958
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767933168; cv=none; b=rzVEeW2dqRgHH1M9ruigrHICatJ1UqvFhL+3sIlSOv3mSgdO+ATJdAEl0EXhWrox1GsdQzq8zcJSdgDbxvA5ofaniZoAkL8aTD1gc+UHESPEgqVmKBk0fFYunJTtXxtEQzueqqVG9eMae9J3jZvKv9qP0/l2uNhxyXOdRUCurHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767933168; c=relaxed/simple;
	bh=ZMGsDqZwYQ/+NhIVCyUBkAXv4uFfVGmp3bt6ezjOGvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGIBtmZ+RJNjSAH/jeIq6PQPmh76ecqQcpuZuv5+MlglyZqE3vIXXi2naIYi1HmEaN6QjZVqUMzHRrmHEN+zGhrm8TtBjVxghnmFEsaoWx65BypBRakbp+nnHUEsz5tqpxoHkZQe0xqaij5SEQmuXmWIvpOw3WFsmnfzoD3QxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DaWBXmAw; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0cd1362b-ebb4-4c62-bc18-026209777acb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767933164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JXzEUi2PNnrcw0JJqHt09/EBNofffg/9tanxUTmX1o=;
	b=DaWBXmAw0xDY/7DK4M5ajxWnvQ7aJvdkJQ+uZzkmmFOCjGolT9NnkEaWdhjM12Qg3DlOmb
	Nul5yjEDBlqihotvNs7HO2mP57DE9hKpe6pyd63SCVNA4DQJqZf/She5WLp0AG4hF+33Ww
	SOPcUuWIc+WrGVuRueI1ddMHXrxoypw=
Date: Fri, 9 Jan 2026 12:32:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] migrate: Correct lock ordering for hugetlb file
 folios
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20260109041345.3863089-1-willy@infradead.org>
 <20260109041345.3863089-2-willy@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260109041345.3863089-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/9 12:13, Matthew Wilcox (Oracle) wrote:
> Syzbot has found a deadlock (analyzed by Lance Yang):
> 
> 1) Task (5749): Holds folio_lock, then tries to acquire i_mmap_rwsem(read lock).
> 2) Task (5754): Holds i_mmap_rwsem(write lock), then tries to acquire
> folio_lock.
> 
> migrate_pages()
>    -> migrate_hugetlbs()
>      -> unmap_and_move_huge_page()     <- Takes folio_lock!
>        -> remove_migration_ptes()
>          -> __rmap_walk_file()
>            -> i_mmap_lock_read()       <- Waits for i_mmap_rwsem(read lock)!
> 
> hugetlbfs_fallocate()
>    -> hugetlbfs_punch_hole()           <- Takes i_mmap_rwsem(write lock)!
>      -> hugetlbfs_zero_partial_page()
>       -> filemap_lock_hugetlb_folio()
>        -> filemap_lock_folio()
>          -> __filemap_get_folio        <- Waits for folio_lock!
> 
> The migration path is the one taking locks in the wrong order according
> to the documentation at the top of mm/rmap.c.  So expand the scope of the
> existing i_mmap_lock to cover the calls to remove_migration_ptes() too.
> 
> This is (mostly) how it used to be after commit c0d0381ade79.  That was
> removed by 336bf30eb765 for both file & anon hugetlb pages when it should
> only have been removed for anon hugetlb pages.

Cool. Thanks for the fix!

As someone new to hugetlb, learned something about the lock ordering here.

Cheers,
Lance

> 
> Fixes: 336bf30eb765 (hugetlbfs: fix anon huge page migration race)
> Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/68e9715a.050a0220.1186a4.000d.GAE@google.com
> Debugged-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: stable@vger.kernel.org
> ---
>   mm/migrate.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5169f9717f60..4688b9e38cd2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1458,6 +1458,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   	int page_was_mapped = 0;
>   	struct anon_vma *anon_vma = NULL;
>   	struct address_space *mapping = NULL;
> +	enum ttu_flags ttu = 0;
>   
>   	if (folio_ref_count(src) == 1) {
>   		/* page was freed from under us. So we are done. */
> @@ -1498,8 +1499,6 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   		goto put_anon;
>   
>   	if (folio_mapped(src)) {
> -		enum ttu_flags ttu = 0;
> -
>   		if (!folio_test_anon(src)) {
>   			/*
>   			 * In shared mappings, try_to_unmap could potentially
> @@ -1516,16 +1515,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   
>   		try_to_migrate(src, ttu);
>   		page_was_mapped = 1;
> -
> -		if (ttu & TTU_RMAP_LOCKED)
> -			i_mmap_unlock_write(mapping);
>   	}
>   
>   	if (!folio_mapped(src))
>   		rc = move_to_new_folio(dst, src, mode);
>   
>   	if (page_was_mapped)
> -		remove_migration_ptes(src, !rc ? dst : src, 0);
> +		remove_migration_ptes(src, !rc ? dst : src,
> +				ttu ? RMP_LOCKED : 0);
> +
> +	if (ttu & TTU_RMAP_LOCKED)
> +		i_mmap_unlock_write(mapping);
>   
>   unlock_put_anon:
>   	folio_unlock(dst);


