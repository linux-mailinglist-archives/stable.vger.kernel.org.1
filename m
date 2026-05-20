Return-Path: <stable+bounces-249760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMk+D+VUDWr9wAUAu9opvQ
	(envelope-from <stable+bounces-249760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:29:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6B58825E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC2533005771
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009E372EFF;
	Wed, 20 May 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auirV4II"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC7366060;
	Wed, 20 May 2026 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258547; cv=none; b=psVItOb4WztZOWQ1ZNOL4mtflUSHWigwXx0J1d7DwefSL8jOQiaxYwCjidNU6nYnHvKtaIXUI7uEKLMhTMpe/Yb+mDkjeSOz9UaNFcfQzAdrIMZkEwYk9J9Lntibgr6gBh8X5usFP8KNcTXwAhnXCypmVTC2b8Te2TzZJlPjlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258547; c=relaxed/simple;
	bh=9hHme/3ffozLYVxVWdyX9r5WB2MCUCtjntGRTzlXLMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec7vOOFKwX5HifyrsMeW5HA9p3FGafa31DWV2y3x72qzJSoanoM5WW+K8K18HFzFqlGvrwXYRKsCLKsthuditywPzH7L9iPdRCydJ81bL4fiPPEOVcfVTg2czM1jYfF9skgw/TzWsQnA9azn/b499gxNuVa8FLiDiVygST/lmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auirV4II; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11EE1F000E9;
	Wed, 20 May 2026 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258546;
	bh=aSbRqEC5T6dYNXakSn7tDht38iosa1zNGD4+O+MXPHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=auirV4II3QbKxTX+d+7zpQtK5fY7rq65dsLBaigfVB0ntTaQwMIBOA7Ppq1DtEzOb
	 vRy+cVzT1PIr1CBRJlbJz6gJc6wTheqoKxbQRhH+1pgHoPGPbmBUHA/hfD6G2JHgNh
	 t4czeysIGvHeuqSc0+PeULvxGF+GuL3rEk62rFy2WLakuGMRO+Cd9oUZutcpLhtUmQ
	 AbQnZqj0wAB7m7ASUXqrgrvswCsLOrZOmxOc8ez0rQirTc2APtUcnnL34IogxfLqz+
	 SNY85ShVUxv5co6znRIV5maTD9GEkEDLS2Nh9lW8q7iQL32YHcUI6MYV1wLRTnhKvS
	 NVuBfpeptwpJg==
Date: Wed, 20 May 2026 09:28:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	Stefan Strogin <stefan.strogin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Michal Nazarewicz <mina86@mina86.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas
Message-ID: <ag1UqX7QVErB0oo8@kernel.org>
References: <20260520061025.3971821-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520061025.3971821-1-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249760-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,infradead.org,google.com,suse.com,gmail.com,mina86.com,vger.kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A1F6B58825E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 02:10:25PM +0800, Muchun Song wrote:
> cma_activate_area() can fail after allocating range bitmaps. Its cleanup
> path frees those bitmaps, but only clears cma->count and
> cma->available_count. It leaves cma->nranges and each range's count in
> place, so cma_debugfs_init() can still register debugfs files for an area
> that never activated successfully.
> 
> That exposes two problems. Reading the bitmap file can make debugfs walk a
> freed range bitmap and trigger an invalid memory access. Reading maxchunk
> can also take cma->lock even though that lock is initialized only on the
> successful activation path.
> 
> Fix this by creating debugfs entries only for CMA areas that reached
> CMA_ACTIVATED.
> 
> Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
> Fixes: 2e32b947606d ("mm: cma: add functions to get region pages counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/cma_debug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index 5ae38f5abbcc..523ba4a0f9f7 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -205,7 +205,8 @@ static int __init cma_debugfs_init(void)
>  	cma_debugfs_root = debugfs_create_dir("cma", NULL);
>  
>  	for (i = 0; i < cma_area_count; i++)
> -		cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
> +		if (test_bit(CMA_ACTIVATED, &cma_areas[i].flags))
> +			cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
>  
>  	return 0;
>  }
> 
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> -- 
> 2.54.0
> 
> 

-- 
Sincerely yours,
Mike.

