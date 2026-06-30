Return-Path: <stable+bounces-269855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N/H4C54kQ2pXSAoAu9opvQ
	(envelope-from <stable+bounces-269855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:06:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A4B6DFB39
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:06:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=QCs3NAS2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269855-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269855-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78F963019FE0
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D4C303A04;
	Tue, 30 Jun 2026 02:06:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57481218821;
	Tue, 30 Jun 2026 02:06:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785179; cv=none; b=ijCY1PRDeBgIclDFmj2sSh9F16WvSpHP4rhb9Lq00OFWZX1BoT05EqkszE8NbyK3XzYVthizXLoAyXcVNCHtI8bTA/H32QsoqEgE/bzUISGzq95bdHgF+KZFfYZvrMMfcCcIUG+l1T8o9z4OK79lmX5Qs2dqzyX4D+JzROWR+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785179; c=relaxed/simple;
	bh=v9/BAYih3Drr1o2fYRCPRqwbMri6e2ChBA/SDr9ows8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aKxvqoZgXMaw1ErtBPhuh2vEDyj536Dzqe+NoVDpFAzHBi/ttXwUHOZalv00fkn4wUrXcLKfiqd5D1MQb2gs3IyjqUqxOfKqH1I8B6N7aFtsVz5ZlO16rVkm7xVDLuM6Vmf5ZLeccOO0wcBRPChcBWpcWsgO6B4tb7EFikI0rPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QCs3NAS2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F871F000E9;
	Tue, 30 Jun 2026 02:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782785177;
	bh=rD5wn3y6pfZZI/1rm2gg6/ulrbyEbDKCWoG+zNkRuQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QCs3NAS2bA36DHr0nJ7QLNItTku3uO9C2kdjRRHdNMz8p7dUw5DWqvjLaZO7k8hfF
	 lt5K7s3uKMQrFCIhHs5DMnGLWqJZnlhUr/HgOKeKT1FNx7WxP4pM3X6jpq11G56JVC
	 hIgiODJRmll5gGyK9GZ+Vi4EHPnoEDImyXs0XkGw=
Date: Mon, 29 Jun 2026 19:06:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Yu
 Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does
 not match
Message-Id: <20260629190616.050ab4e309669fae250c6c37@linux-foundation.org>
In-Reply-To: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
References: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ziy@nvidia.com,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:yuzhao@google.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269855-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82A4B6DFB39

On Mon, 29 Jun 2026 21:35:33 -0400 Zi Yan <ziy@nvidia.com> wrote:

> When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
> range does not match the requested one, the code errors out with EINVAL
> without freeing the allocated PFNs and causes free page leaks. Fix it by
> calling release_free_list() in the error path.
> 
> The issue is reported by Sashiko[1].
> 
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -88,7 +88,7 @@ static struct page *mark_allocated_noprof(struct page *page, unsigned int order,
>  }
>  #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
>  
> -static unsigned long release_free_list(struct list_head *freepages)
> +unsigned long release_free_list(struct list_head *freepages)
>  {
>  	int order;
>  	unsigned long high_pfn = 0;
>
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7235,9 +7235,11 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>  		check_new_pages(head, order);
>  		prep_new_page(head, order, gfp_mask, 0);
>  	} else {
> +		release_free_list(cc.freepages);

I wonder if there's a Kconfig combination which results in this being
undefined.

I couldn't immediately find such a combination.  No doubt we'll be told
if there is one ;)




