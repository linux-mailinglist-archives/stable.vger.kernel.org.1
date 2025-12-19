Return-Path: <stable+bounces-203113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BDCD16A4
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243FC3043055
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 18:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E70382573;
	Fri, 19 Dec 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U17pHvF3"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BC38256A;
	Fri, 19 Dec 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168328; cv=none; b=pFQI3HQkI2YU3LJqrydvy+X3s65tu7sz6JsTB6Eyk86NBrg4iwZ0tRLXxVLjHcq7FCMyVYxrRyzQeeWEt1B0upzti/a1EQPRKYkxXad+jeix9cSXDp8Z0RRVoxpGmhW47awmiwVwzvbALPVIPa43pJCmfUq9EKM0WFHzg+YyEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168328; c=relaxed/simple;
	bh=jRQd5KvLkrYXA23zAqpek439MvlCDTXX/FkT2D9/7Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgVKwRilfDtvS5lVtjEkmOqpLi4byuP0+JtD1D+jmmqjtmC2pbE4XkFTL7DFUSnVSg7w9GZ4IRuiV7AYwcMaT+vwTsA3W1KnQbpRdXWbwNKSjVtw/sXFQlZjBCT3yOkrNNSW31qqHXO2WLqIE9u585/4W4Iw2eTEbgeJ4nbON8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U17pHvF3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y4gt0/vKfnYmYBnHrbbkqhkPm5dR97qK0YpD9UaChCw=; b=U17pHvF393kTtYtWU0SYCDXYtx
	CgCzp4g2y9oP6AeHn1cLDGd2jBBTf7LHfIY+iOoewouYenAEkkZcA+fz8lchh+CYyiRCdYivQheoG
	8H8AGyaxiNxDtIvPwuSXbL4KiQ9sKDwZMuYKGwPnwVI2/oLgtKr9fNxTJj+phG+IzV8qky1Sae27t
	D89em6BGeFqB+VdsyC3mW4Nf11Y9EU2GY0X07V8YyfD/A0EP0oql8SQ4HMSw8nWMfTyUCQnNMPJBu
	G5l7JfdpR0LwyMTkolUhmISt23E2sUnNfsd4Mdtt26Y3xbnGURuKciTatiTwM9nh6ETQ7GOOTr23s
	Ijr+4z3g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWf3o-00000007w0R-2ao1;
	Fri, 19 Dec 2025 18:18:40 +0000
Date: Fri, 19 Dec 2025 18:18:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org, muchun.song@linux.dev, osalvador@suse.de,
	david@kernel.org, linmiaohe@huawei.com, jiaqiyan@google.com,
	william.roche@oracle.com, rientjes@google.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com
Subject: Re: [PATCH v2] mm/memory-failure: teach kill_accessing_process to
 accept hugetlb tail page pfn
Message-ID: <aUWXAGC1028jRKEY@casper.infradead.org>
References: <20251219175516.2656093-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219175516.2656093-1-jane.chu@oracle.com>

On Fri, Dec 19, 2025 at 10:55:16AM -0700, Jane Chu wrote:
>  static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
> -				unsigned long poisoned_pfn, struct to_kill *tk)
> +				unsigned long poisoned_pfn, struct to_kill *tk,
> +				int pte_nr)

if we pass in huge_page_mask() instead ...

>  {
>  	unsigned long pfn = 0;
> +	unsigned long hwpoison_vaddr;
>  
>  	if (pte_present(pte)) {
>  		pfn = pte_pfn(pte);
> @@ -694,10 +696,11 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>  			pfn = swp_offset_pfn(swp);
>  	}
>  
> -	if (!pfn || pfn != poisoned_pfn)
> +	if (!pfn || (pfn > poisoned_pfn || (pfn + pte_nr - 1) < poisoned_pfn))

... then we can simplify this to:

	if (!pfn || ((pfn | mask) != (poisoned_pfn | mask))

>  		return 0;
> @@ -2037,6 +2038,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>  	}
>  
> +
>  	folio = page_folio(p);
>  	folio_lock(folio);

unnecessary whitespace change

