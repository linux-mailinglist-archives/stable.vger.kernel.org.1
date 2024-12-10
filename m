Return-Path: <stable+bounces-100388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4349EAD1F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E9B28CAC7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC5223320;
	Tue, 10 Dec 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UilE0GZ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YfXDDCwB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UilE0GZ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YfXDDCwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370E210F4F;
	Tue, 10 Dec 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824103; cv=none; b=E/nSTWLugMPa57pqIa+DIW0XFe0nvDCf26UA6N/pmYdzXWMTCVgVgOE3qDx5VZYcr0kKQtmD9QZ+Dc3GGkL2TLkl6IxswDYbLJb1QbrNqeR0uDoM54kKGKSDgis+m+Q8Q0PT2hgrnkvsJnhI9Pf1jwF76HSDl9ORc/fL0EN0pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824103; c=relaxed/simple;
	bh=fVy5esvV9BSosUTvXR/q0XhhrqNclabAFPZObccFWMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6t+jqkTImgEUOZjszYX/i8N/Ed2wS9yx0GJ+W9wmB+zfJR0qBUj+h3ZRdwFXRbg5oIiMATRinJ5J0020F1Umo1GRDV/oq5w2DWHspNtvMTVCs2O0hvioP/RbVHsYFFGHic/oWOIxs2cdkNf+qXzoVx46bB1xdxg6N20RCBL5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UilE0GZ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YfXDDCwB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UilE0GZ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YfXDDCwB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B64E021160;
	Tue, 10 Dec 2024 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733824095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SeSHlqH8vcO5XpyT7gztV9qNQkgwbz3uC1Ryr71Q4yA=;
	b=UilE0GZ31kvq3G/OesvFrWwd/TeE4fQ+eovvH7N8InZLigZVQq1zmyHLopnhscrl1Yr2vt
	sKS7Nsw1BfpiTAT2GpWY1m6fKgCBLrNnNgv27shENUIXtqL6phnyv9vYUxnrqL8FRDvpTa
	ccHgyaODnl3UYnXB6wSqgdZWUcMo/OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733824095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SeSHlqH8vcO5XpyT7gztV9qNQkgwbz3uC1Ryr71Q4yA=;
	b=YfXDDCwBLXun5Mdbd4HXhPezB4xZiLJ6ztanzpj3jVBAhDDEejUlFUqUKjknWNC2yPE6M7
	tIIW/P1WCCYEkUDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UilE0GZ3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YfXDDCwB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733824095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SeSHlqH8vcO5XpyT7gztV9qNQkgwbz3uC1Ryr71Q4yA=;
	b=UilE0GZ31kvq3G/OesvFrWwd/TeE4fQ+eovvH7N8InZLigZVQq1zmyHLopnhscrl1Yr2vt
	sKS7Nsw1BfpiTAT2GpWY1m6fKgCBLrNnNgv27shENUIXtqL6phnyv9vYUxnrqL8FRDvpTa
	ccHgyaODnl3UYnXB6wSqgdZWUcMo/OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733824095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SeSHlqH8vcO5XpyT7gztV9qNQkgwbz3uC1Ryr71Q4yA=;
	b=YfXDDCwBLXun5Mdbd4HXhPezB4xZiLJ6ztanzpj3jVBAhDDEejUlFUqUKjknWNC2yPE6M7
	tIIW/P1WCCYEkUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B92E13A15;
	Tue, 10 Dec 2024 09:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytilJV8OWGdROAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 10 Dec 2024 09:48:15 +0000
Message-ID: <c06e7552-bcce-49b9-8d77-72de48014a56@suse.cz>
Date: Tue, 10 Dec 2024 10:48:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly
 non-existent PFN in split_large_buddy()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
References: <20241210093437.174413-1-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241210093437.174413-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B64E021160
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/10/24 10:34, David Hildenbrand wrote:
> In split_large_buddy(), we might call pfn_to_page() on a PFN that might
> not exist. In corner cases, such as when freeing the highest pageblock in
> the last memory section, this could result with CONFIG_SPARSEMEM &&
> !CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
> and __section_mem_map_addr() dereferencing that NULL pointer.
> 
> Let's fix it, and avoid doing a pfn_to_page() call for the first
> iteration, where we already have the page.
> 
> So far this was found by code inspection, but let's just CC stable as
> the fix is easy.
> 
> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48a291c485df4..a52c6022c65cb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1238,13 +1238,15 @@ static void split_large_buddy(struct zone *zone, struct page *page,
>  	if (order > pageblock_order)
>  		order = pageblock_order;
>  
> -	while (pfn != end) {
> +	do {
>  		int mt = get_pfnblock_migratetype(page, pfn);
>  
>  		__free_one_page(page, pfn, zone, order, mt, fpi);
>  		pfn += 1 << order;
> +		if (pfn == end)
> +			break;
>  		page = pfn_to_page(pfn);
> -	}
> +	} while (1);
>  }
>  
>  static void free_one_page(struct zone *zone, struct page *page,


