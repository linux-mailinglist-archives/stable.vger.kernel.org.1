Return-Path: <stable+bounces-240575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAn8IyQo62mPJQAAu9opvQ
	(envelope-from <stable+bounces-240575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:21:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8745B5D0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA326301DE1E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58F314D35;
	Fri, 24 Apr 2026 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOMKksAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11823112D0;
	Fri, 24 Apr 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018831; cv=none; b=bI4WZMOvNqLMW2fy/ftgV+/fyZKeTT+MIRMrodXnWvp60ijB6G59MSsOElNOknN/+QFa6UyOpylRiDqJaZ6wpKgFTVxHxq5PtEsfgQnDu7jlhDC8h0WdSq9kZsmXms26qW9mW9nhUJ1Y+WhIEc8h0kQH8WYHgGlowUsImFGwvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018831; c=relaxed/simple;
	bh=Rv6jBW9C6+YIR0iVvSndpiy1+KRdv3tYvLeHDMmVn0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLiSkEFRbYwYCvaYUty/AzjSkwHoHm7stK6trbmCWc7mBNZLhanDfq8YWF5s8Z2MB/5q5YLR4Qg3EE3Jr+h59Bs2OZYQRKKHzvoBc88369tuufAQi8gkSTNr69fw5TCJmIXae7ovA66e83NYKIZqvKBr4oqgXnhlPBJZbDE0ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOMKksAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68013C19425;
	Fri, 24 Apr 2026 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777018830;
	bh=Rv6jBW9C6+YIR0iVvSndpiy1+KRdv3tYvLeHDMmVn0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOMKksAUWZvCKb8Ojm6kYghsEM28I/Mztw1a92GaD+6XofYQMD1pQHKguAWOCnWjB
	 mTCyWZ3OkABdRLM9eSm+SbbPUvMy2otzMEK1ea5pHoNTIwmN90fPnX4+fAc41Z7+g8
	 QjLLsZLJEJfajKQorsSixJXC+QFFbdXKzmcVZXz68mssOqhvNN/+zrqCUrmfPet45f
	 Q7yhOOr6zoUcXl7tErxPsUGjWtZ5bDM/D/3/qNHD/2j09YrukMF1PMHi8WLDddOZgk
	 jGqxoyyzGn8vdvAf3mgz3hXtt5u+ISYKkrx106+Dc9WhXMb5NeUdq+P491a72duOd0
	 kyqvtA1rMJUCg==
Date: Fri, 24 Apr 2026 11:20:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 6/7] mm/mm_init: Fix uninitialized struct pages for
 ZONE_DEVICE
Message-ID: <aesnxK_Use6wrCfE@kernel.org>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
 <20260424025547.3806072-7-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424025547.3806072-7-songmuchun@bytedance.com>
X-Rspamd-Queue-Id: 97A8745B5D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,suse.de,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email]

On Fri, Apr 24, 2026 at 10:55:46AM +0800, Muchun Song wrote:
> If DAX memory is hotplugged into an unoccupied subsection of an early
> section, section_activate() reuses the unoptimized boot memmap.
> However, compound_nr_pages() still assumes that vmemmap optimization is
> in effect and initializes only the reduced number of struct pages. As a
> result, the remaining tail struct pages are left uninitialized, which
> can later lead to unexpected behavior or crashes.
> 
> Fix this by treating early sections as unoptimized when calculating how
> many struct pages to initialize.
> 
> Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cfc76953e249..bd466a3c10c8 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>   * of how the sparse_vmemmap internals handle compound pages in the lack
>   * of an altmap. See vmemmap_populate_compound_pages().
>   */
> -static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
> +static inline unsigned long compound_nr_pages(unsigned long pfn,
> +					      struct vmem_altmap *altmap,
>  					      struct dev_pagemap *pgmap)
>  {
> -	if (!vmemmap_can_optimize(altmap, pgmap))
> +	/*
> +	 * If DAX memory is hot-plugged into an unoccupied subsection
> +	 * of an early section, the unoptimized boot memmap is reused.
> +	 * See section_activate().
> +	 */
> +	if (early_section(__pfn_to_section(pfn)) ||
> +	    !vmemmap_can_optimize(altmap, pgmap))
>  		return pgmap_vmemmap_nr(pgmap);
>  
>  	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
> @@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  			continue;
>  
>  		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> -				     compound_nr_pages(altmap, pgmap));
> +				     compound_nr_pages(pfn, altmap, pgmap));
>  	}
>  
>  	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

