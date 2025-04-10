Return-Path: <stable+bounces-132070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9928A83C8C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2AE1B66FDF
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF7202F62;
	Thu, 10 Apr 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UsXoFCUJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AiYQtma9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UsXoFCUJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AiYQtma9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486381F1306
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273010; cv=none; b=TL4gr9eG1zS/OuOg9MawcE/EhQ2OXbVRNvf4moCjRbRYWevoPKPy2HV8XMS+oahhXsUtTgROYt8OpZDvHqPePzZNxuEpw81DUQ9V66pf0pDApsuIDfsMrREaBOciHMYQmLL0zdneedz7RFDQuAj27GOKJJ+jK29pUPWXjDD7hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273010; c=relaxed/simple;
	bh=onvVqvfxWWw9bTMyAQ2MWRqkSh8vFba5v4X2ve4LnDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6sQykcJgj1xKgGzUTL74k/aWndPTOo0Lsr+SisWo02lRU+BQgiAoSpLBbzIdk+JIB3ZYOiKdcWJKb5yW+Xa+DOFJ1575cSpqD5PwxzgmTbQ1K2oO2bK/HY641Kntkli/bYmzVvf8fr1bxb1PU/EWbCr05h8yA7n1NnKo+e41/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UsXoFCUJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AiYQtma9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UsXoFCUJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AiYQtma9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DE0B211B8;
	Thu, 10 Apr 2025 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744273007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeO8trQ+ylG1pNIV4/iVJDVcKDxWDQzcb2h2bPQiHN0=;
	b=UsXoFCUJdEBgJe9iqNIpBEPaj8Wfl1EZV6rZowH6EuovmucVhEijKv17hjsgQgBr0fzNdH
	XfRt7qLL+6YJoiJdqn4FoktzquN4TDbmw8O/rgy/RIvzfvFgF/O/8sFVxFV8on+KDy3sMS
	i8x1uYQVfMyVAXrKKz+yt3q/FfA0hww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744273007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeO8trQ+ylG1pNIV4/iVJDVcKDxWDQzcb2h2bPQiHN0=;
	b=AiYQtma9bQGr4MpMUQco6qvKp3RDiDCKYI/n0Om0gt5uAWEZk81x/I7xWpE3cbP+6oS+ci
	f8+GKUTUMJfMILDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UsXoFCUJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AiYQtma9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744273007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeO8trQ+ylG1pNIV4/iVJDVcKDxWDQzcb2h2bPQiHN0=;
	b=UsXoFCUJdEBgJe9iqNIpBEPaj8Wfl1EZV6rZowH6EuovmucVhEijKv17hjsgQgBr0fzNdH
	XfRt7qLL+6YJoiJdqn4FoktzquN4TDbmw8O/rgy/RIvzfvFgF/O/8sFVxFV8on+KDy3sMS
	i8x1uYQVfMyVAXrKKz+yt3q/FfA0hww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744273007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeO8trQ+ylG1pNIV4/iVJDVcKDxWDQzcb2h2bPQiHN0=;
	b=AiYQtma9bQGr4MpMUQco6qvKp3RDiDCKYI/n0Om0gt5uAWEZk81x/I7xWpE3cbP+6oS+ci
	f8+GKUTUMJfMILDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC68132D8;
	Thu, 10 Apr 2025 08:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N1NmOW5+92elBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Apr 2025 08:16:46 +0000
Message-ID: <e8404cc5-b731-43ae-ab3d-d4e4e862dd9f@suse.cz>
Date: Thu, 10 Apr 2025 10:16:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Carlos Song <carlos.song@nxp.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
References: <20250407180154.63348-1-hannes@cmpxchg.org>
 <D91FIQHR9GEK.3VMV7CAKW1BFO@google.com> <20250408185009.GF816@cmpxchg.org>
 <D92AC0P9594X.3BML64MUKTF8Z@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <D92AC0P9594X.3BML64MUKTF8Z@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0DE0B211B8
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/9/25 19:30, Brendan Jackman wrote:
> 
> From 8ff20dbb52770d082e182482d2b47e521de028d1 Mon Sep 17 00:00:00 2001                                                                                                                                                                                                                    
> From: Brendan Jackman <jackmanb@google.com>
> Date: Wed, 9 Apr 2025 17:22:14 +000
> Subject: [PATCH] page_alloc: speed up fallbacks in rmqueue_bulk() - comment updates
> 
> Tidy up some terminology and redistribute commentary.                                                                                                                                                                                                                                                                                            
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

LGTM (assuming folding)

> ---
>  mm/page_alloc.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dfb2b3f508af4..220bd0bcc38c3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2183,21 +2183,13 @@ try_to_claim_block(struct zone *zone, struct page *page,
>  }
>   
>  /*
> - * Try finding a free buddy page on the fallback list.
> - *
> - * This will attempt to claim a whole pageblock for the requested type
> - * to ensure grouping of such requests in the future.
> - *
> - * If a whole block cannot be claimed, steal an individual page, regressing to
> - * __rmqueue_smallest() logic to at least break up as little contiguity as
> - * possible.
> + * Try to allocate from some fallback migratetype by claiming the entire block,
> + * i.e. converting it to the allocation's start migratetype.
>   *
>   * The use of signed ints for order and current_order is a deliberate 
>   * deviation from the rest of this file, to make the for loop
>   * condition simpler.
>   */
> -
> -/* Try to claim a whole foreign block, take a page, expand the remainder */
>  static __always_inline struct page *
>  __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
>                                                 unsigned int alloc_flags)
> @@ -2247,7 +2239,10 @@ __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
>         return NULL;
>  }
>   
> -/* Try to steal a single page from a foreign block */
> +/*
> + * Try to steal a single page from some fallback migratetype. Leave the rest of
> + * the block as its current migratetype, potentially causing fragmentation.
> + */
>  static __always_inline struct page *
>  __rmqueue_steal(struct zone *zone, int order, int start_migratetype)
>  {
> @@ -2307,7 +2302,8 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>         }
>   
>         /*
> -        * Try the different freelists, native then foreign.
> +        * First try the freelists of the requested migratetype, then try
> +        * fallbacks modes with increasing levels of fragmentation risk.
>          *
>          * The fallback logic is expensive and rmqueue_bulk() calls in
>          * a loop with the zone->lock held, meaning the freelists are
> @@ -2332,7 +2328,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>         case RMQUEUE_CLAIM:
>                 page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
>                 if (page) {
> -                       /* Replenished native freelist, back to normal mode */
> +                       /* Replenished preferred freelist, back to normal mode. */
>                         *mode = RMQUEUE_NORMAL;
>                         return page;
>                 }
> 
> base-commit: aa42382db4e2a4ed1f4ba97ffc50e2ce45accb0c


