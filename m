Return-Path: <stable+bounces-254320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMIfOjmFFWoSWQcAu9opvQ
	(envelope-from <stable+bounces-254320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:34:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A35D4EA4
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00F130136B0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F213E0C55;
	Tue, 26 May 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qsH856Jo"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FE2E7F25
	for <stable@vger.kernel.org>; Tue, 26 May 2026 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795017; cv=none; b=nelA78317Mq7Bz7t7tE6a4xaWtJOWBsIqP8NF8rT8qnANGiXsiZ1uzMyqakinhLMsT2Tmlwp0m5GtvNVzvAqggnDsXLDYjjmLhwadYr+93DPj3yT6NuYmae3L8DStsEbXei8+sMgEjXXbGJdTv6febqaGFp+T0GslC/quuGBgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795017; c=relaxed/simple;
	bh=4xLiVHFm1xyFeVBXVIRKOvD5LbSXHXkNlgw82b/43Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ4HZU+69VGHboiWbcsFl3UHDoA/pLLuusr880lXvnW3pPFXnImb8VaisCzvfrBy6XBsGcccsKI2rS9wNuQM8peEGahGQPKEobXSWvx0ZBQS8d8sHHdBPtFx4OlUdLAYeTgjmSpjc6YlN5fLrhxN36UfB03ycYQ3DLPynvTRimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qsH856Jo; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779795012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4V098L7V8l//JQho7wEgMgtyJ6Bly+yLWxZarD+Fak=;
	b=qsH856JoTqeGJbSH7PdfNWnqmQ0TuOwGLO8AVLU0qojv3tSxUWXuRjDTA/yruYxiNUK5aQ
	RIQk/lj2CJbDbhdQ139djiMXWxklKgAqxux8fBK0bYLvkqNIgWU381ymTlk4LfPG5rt4l1
	m8jgrNxASeSUNLpoqcSQqU83PJbbee4=
From: Usama Arif <usama.arif@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH] mm/cma: fix reserved page leak on activation failure
Date: Tue, 26 May 2026 04:30:03 -0700
Message-ID: <20260526113005.3610737-1-usama.arif@linux.dev>
In-Reply-To: <20260522062658.4095405-1-songmuchun@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254320-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 610A35D4EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 14:26:58 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> If cma_activate_area() fails after allocating only part of the range
> bitmaps, its cleanup path frees the bitmaps for the ranges below
> allocrange and then releases reserved pages using the same bound.
> 
> That bound is only correct for bitmap freeing. Pages in ranges that did
> not reach bitmap allocation are still reserved and should also be
> returned to the buddy when CMA_RESERVE_PAGES_ON_ERROR is clear. As a
> result, a partial bitmap allocation failure can permanently leak the
> reserved pages from the failed range and all later ranges.
> 
> Fix this by releasing reserved pages for all ranges. For ranges whose
> bitmap allocation succeeded, use the early_pfn[] snapshot saved before
> the bitmap pointer overwrote the union field. For later ranges, continue
> to use cmr->early_pfn directly.
> 
> Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/cma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index c7ca567f4c5c..a30075507d41 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -188,10 +188,13 @@ static void __init cma_activate_area(struct cma *cma)
>  
>  	/* Expose all pages to the buddy, they are useless for CMA. */
>  	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
> -		for (r = 0; r < allocrange; r++) {
> +		for (r = 0; r < cma->nranges; r++) {
> +			unsigned long start_pfn;
> +
>  			cmr = &cma->ranges[r];
> +			start_pfn = r < allocrange ? early_pfn[r] : cmr->early_pfn;

Should this be r <= allocrange?


For the failing range, the loop above did:

		early_pfn[allocrange] = cmr->early_pfn;
		cmr->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma, cmr),
					    GFP_KERNEL);
		if (!cmr->bitmap)
			goto cleanup;


Since cmr->bitmap and cmr->early_pfn share a union, that NULL store
clobbers cmr->early_pfn to 0 for index allocrange.  With r < allocrange
the failing range reads cmr->early_pfn (now 0) and free_reserved_page()
gets called starting from pfn 0

>  			end_pfn = cmr->base_pfn + cmr->count;
> -			for (pfn = early_pfn[r]; pfn < end_pfn; pfn++)
> +			for (pfn = start_pfn; pfn < end_pfn; pfn++)
>  				free_reserved_page(pfn_to_page(pfn));
>  		}
>  	}
> 
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> -- 
> 2.54.0
> 
> 

