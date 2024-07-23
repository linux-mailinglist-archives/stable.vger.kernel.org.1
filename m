Return-Path: <stable+bounces-60732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A84939BBC
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE7281B3A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199F14AD10;
	Tue, 23 Jul 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tp0Zvpek";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VItdnO17";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bcgkBsQ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Hd4G4DE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961613C9A3;
	Tue, 23 Jul 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719832; cv=none; b=VttAbYRKUGoU7iSJ2UNphHTdgD4TxywD+J5CMayIOm6zwVKKS674emFnArbZk9/jUr9rl9ZpOYDfI034SQxTetifp1mITHtwe6GKzPj43a/D4/+5fABor+M7Wrf0L5pWCZ74Mc06fFCf/TzgJDuYdK+0r0HE9JsvUdRRIgJUs2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719832; c=relaxed/simple;
	bh=AQRK9JorHGccGY6Uz4ipS2eUcLhaUPkpT+wrRxYmcaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFHhtGSk2OLL698IhKoLOAa6Inh9AnAHfXllofzV9nLCoYjragABozQzevBY2Oh+r5AqCllUlWZRiyBBSp1QMaFEufgCpv6eYni9+rykMZXWzvmdTnyjy2VZOlH0V0iy+op05456s12fvtNFzbniaSJUEsRHWLWLm6EvRBSGSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tp0Zvpek; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VItdnO17; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bcgkBsQ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Hd4G4DE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC53B21AB3;
	Tue, 23 Jul 2024 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721719828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fG4EbjWGNqFXRR6ZQnIuAvzoJK16ltpj5WMaolGqCe8=;
	b=tp0ZvpekPuBQx0xah3rl6Eme61oaWDJ0sfC9n9j4fkq2u7gyIrSnPchrao6iUtAl6fpS2i
	VW2vYmKWYbvBeDrmRB0ktSjymSIOl8QvFWpCuvegYL4aXr5nh/8yzkDGjVCjK0Pl37Ngx8
	WCSpqWL3HgnLjzrKTBD/umL9e2E73ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721719828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fG4EbjWGNqFXRR6ZQnIuAvzoJK16ltpj5WMaolGqCe8=;
	b=VItdnO17LdABIMZ3ZPbJ81uFQi/g7vWX/nyvCl7z2HFMUZqRRWeO2aN1K8w4fC8q+h06L8
	whFYuNyX6dcAiVCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721719827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fG4EbjWGNqFXRR6ZQnIuAvzoJK16ltpj5WMaolGqCe8=;
	b=bcgkBsQ8DJTrLtQVisPsaX4tm7wkC9154CMg9wWh0sbw/zQeJ2jPPD6Fzyel9iBVmnmS2J
	NZ4rLO/cDCHGpEHRqPEWf1vYXFjakLGq0QuV/R3bBoPjNxgO4Z+IKh/EamEsjDWNtDwMlo
	y5eq17ncatR8x0pDbs9cT99JsR75TO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721719827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fG4EbjWGNqFXRR6ZQnIuAvzoJK16ltpj5WMaolGqCe8=;
	b=4Hd4G4DE9LfCBaaoJbxC7zXaTJLMNa1Qbta/DBQ7AsHpo84y+p1Im33hX7Av0PoAXzN++P
	p4Ep8KfUxKwFpSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CECDF13874;
	Tue, 23 Jul 2024 07:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVV7MRNcn2ZlVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jul 2024 07:30:27 +0000
Message-ID: <564ff8e4-42c9-4a00-8799-eaa1bef9c338@suse.cz>
Date: Tue, 23 Jul 2024 09:30:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jianxiong Gao <jxgao@google.com>, stable@vger.kernel.org
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
 <Zpez1rkIQzVWxi7q@tiehlicka>
 <brjw4kb3x4wohs4a6y5lqxr6a5zlz3m45hiyyyht5mgrqcryk7@m7mdyojo4h6a>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <brjw4kb3x4wohs4a6y5lqxr6a5zlz3m45hiyyyht5mgrqcryk7@m7mdyojo4h6a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.09
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 7/22/24 4:07 PM, Kirill A. Shutemov wrote:
> On Wed, Jul 17, 2024 at 02:06:46PM +0200, Michal Hocko wrote:
>> Please try to investigate this further. The patch as is looks rather
>> questionable to me TBH. Spilling unaccepted memory into the reclaim
>> seems like something we should avoid if possible as this is something
> 
> Okay, I believe I have a better understanding of the situation:
> 
> - __alloc_pages_bulk() takes pages from the free list without accepting
>   more memory. This can cause number of free pages to fall below the
>   watermark.
> 
>   This issue can be resolved by accepting more memory in
>   __alloc_pages_bulk() if the watermark check fails.
> 
>   The problem is not only related to unallocated memory. I think the
>   deferred page initialization mechanism could result in premature OOM if
>   __alloc_pages_bulk() allocates pages faster than deferred page
>   initialization can add them to the free lists. However, this scenario is
>   unlikely.
> 
> - There is nothing that compels the kernel to accept more memory after the
>   watermarks have been calculated in __setup_per_zone_wmarks(). This can
>   put us under the watermark.
> 
>   This issue can be resolved by accepting memory up to the watermark after
>   the watermarks have been initialized.
> 
> - Once kswapd is started, it will begin spinning if we are below the
>   watermark and there is no memory that can be reclaimed. Once the above
>   problems are fixed, the issue will be resolved.
> 
> - The kernel needs to accept memory up to the PROMO watermark. This will
>   prevent unaccepted memory from interfering with NUMA balancing.

So do we still assume all memory is eventually accepted and it's just a
initialization phase thing? And the only reason we don't do everything in a
kthread like the deferred struct page init, is to spread out some potential
contention on the host side?

If yes, do we need NUMA balancing even to be already active during that phase?

> The patch below addresses the issues I listed earlier. It is not yet ready
> for application. Please see the issues listed below.
> 
> Andrew, please drop the current patch.
> 
> There are a few more things I am worried about:
> 
> - The current get_page_from_freelist() and patched __alloc_pages_bulk()
>   only try to accept memory if the requested (alloc_flags & ALLOC_WMARK_MASK)
>   watermark check fails. For example, if a requested allocation with
>   ALLOC_WMARK_MIN is called, we will not try to accept more memory, which
>   could potentially put us under the high/promo watermark and cause the
>   following kswapd start to get us into an endless loop.
> 
>   Do we want to make memory acceptance in these paths independent of
>   alloc_flags?

Hm ALLOC_WMARK_MIN will proceed, but with a watermark below the low
watermark will still wake up kswapd, right? Isn't that another scenario
where kswapd can start spinning?

> - __isolate_free_page() removes a page from the free list without
>   accepting new memory. The function is called with the zone lock taken.
>   It is bad idea to accept memory while holding the zone lock, but
>   the alternative of pushing the accept to the caller is not much better.
> 
>   I have not observed any issues caused by __isolate_free_page() in
>   practice, but there is no reason why it couldn't potentially cause
>   problems.
>  
> - The function take_pages_off_buddy() also removes pages from the free
>   list without accepting new memory. Unlike the function
>   __isolate_free_page(), it is called without the zone lock being held, so
>   we can accept memory there. I believe we should do so.
> 
> I understand why adding unaccepted memory handling into the reclaim path
> is questionable. However, it may be the best way to handle cases like
> __isolate_free_page() and possibly others in the future that directly take
> memory from free lists.

Yes seems it might be not that bad solution, otherwise it could be hopeless
whack-a-mole to prevent all corner cases where reclaim can be triggered
without accepting memory first.

Although just removing the lazy accept mode would be much more appealing
solution than this :)

> Any thoughts?

Wonder if deferred struct page init has many of the same problems, i.e. with
__isolate_free_page() and take_pages_off_buddy(), and if not, why?

> I am still new to reclaim code and may be overlooking something
> significant. Please correct any misconceptions you see.
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c11b7cde81ef..5e0bdfbe2f1f 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -667,6 +667,7 @@ enum zone_watermarks {
>  #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
>  #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
>  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
> +#define promo_wmark_pages(z) (z->_watermark[WMARK_PROMO] + z->watermark_boost)
>  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
>  
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c62805dbd608..d537c633c6e9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1748,7 +1748,7 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>  			continue;
>  
>  		if (zone_watermark_ok(zone, 0,
> -				      wmark_pages(zone, WMARK_PROMO) + enough_wmark,
> +				      promo_wmark_pages(zone) + enough_wmark,
>  				      ZONE_MOVABLE, 0))
>  			return true;
>  	}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 14d39f34d336..b744743d14a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4462,6 +4462,22 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  				alloc_flags, gfp)) {
>  			break;
>  		}
> +
> +		if (has_unaccepted_memory()) {
> +			if (try_to_accept_memory(zone, 0))
> +				break;
> +		}
> +
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		/*
> +		 * Watermark failed for this zone, but see if we can
> +		 * grow this zone if it contains deferred pages.
> +		 */
> +		if (deferred_pages_enabled()) {
> +			if (_deferred_grow_zone(zone, 0))
> +				break;
> +		}
> +#endif
>  	}
>  
>  	/*
> @@ -5899,6 +5915,9 @@ static void __setup_per_zone_wmarks(void)
>  		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
>  
>  		spin_unlock_irqrestore(&zone->lock, flags);
> +
> +		if (managed_zone(zone))
> +			try_to_accept_memory(zone, 0);
>  	}
>  
>  	/* update totalreserve_pages */
> @@ -6866,8 +6885,8 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
>  	long to_accept;
>  	int ret = false;
>  
> -	/* How much to accept to get to high watermark? */
> -	to_accept = high_wmark_pages(zone) -
> +	/* How much to accept to get to promo watermark? */
> +	to_accept = wmark_pages(zone, WMARK_PROMO) -
>  		    (zone_page_state(zone, NR_FREE_PAGES) -
>  		    __zone_watermark_unusable_free(zone, order, 0));
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3ef654addd44..d20242e36904 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6607,7 +6607,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>  			continue;
>  
>  		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> -			mark = wmark_pages(zone, WMARK_PROMO);
> +			mark = promo_wmark_pages(zone);
>  		else
>  			mark = high_wmark_pages(zone);
>  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))


