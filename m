Return-Path: <stable+bounces-139544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2324AA837B
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 03:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6531B3BEC6C
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614F25776;
	Sun,  4 May 2025 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ewOq8mW8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F00EEC0;
	Sun,  4 May 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746322139; cv=none; b=d9Re2CIhriwQhpTjwx3FcY/PnctsO8YwtQ5m3e+xXskK30j5dUVO4dFB57VMxy5bH+ikBGzPRDnLVi1MXJyx8nqFACtra2LZ978BYLu3ENzJQt7VT0vt+HK16WJ5uWHBGI98r7Q/nAdrFaTRSpiZe1oZDrpznhrrMWaaNnATh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746322139; c=relaxed/simple;
	bh=7n/RkZelCee7HZb0JLnBTglCg0DQoVwRlQDp8IWWaHQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FKiohRN4DMXtaYcDJv2VDCcu43gWwOF9crLXbCvbLb1qn7fPxOx7uuId+Dsfz8iZReoqTXc3dS0/dWq9caxh63rqET/mjKXfizGslKRaN02T1xDOMZyBLJ7uf74i8TCaHzauEbjO/MNVQ4gPMI7a7jaoim3FT9Q/WS6C9ZHwDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ewOq8mW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA00C4CEE3;
	Sun,  4 May 2025 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746322139;
	bh=7n/RkZelCee7HZb0JLnBTglCg0DQoVwRlQDp8IWWaHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewOq8mW8UDxL9+9ECv8Qfuakg+agxPoz8hWNSJQFDuvfrugw0npvbJUQxMy9Ahtg+
	 JM0F3+pCCGGpUGYUttE8oLGguaoQalZDqWc1OPU4/Xo3x4IPlVww/z628p+JTtuzL0
	 tuggwHoPh9Wt9A8kV+dO1nYp+gzyXcg1Mw2jHHRc=
Date: Sat, 3 May 2025 18:28:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr =?UTF-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, David Hildenbrand
 <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 xen-devel@lists.xenproject.org, x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: fix folio_pte_batch() on XEN PV
Message-Id: <20250503182858.5a02729fcffd6d4723afcfc2@linux-foundation.org>
In-Reply-To: <20250502215019.822-2-arkamar@atlas.cz>
References: <20250502215019.822-1-arkamar@atlas.cz>
	<20250502215019.822-2-arkamar@atlas.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri,  2 May 2025 23:50:19 +0200 Petr Vaněk <arkamar@atlas.cz> wrote:

> On XEN PV, folio_pte_batch() can incorrectly batch beyond the end of a
> folio due to a corner case in pte_advance_pfn(). Specifically, when the
> PFN following the folio maps to an invalidated MFN,
> 
> 	expected_pte = pte_advance_pfn(expected_pte, nr);
> 
> produces a pte_none(). If the actual next PTE in memory is also
> pte_none(), the pte_same() succeeds,
> 
> 	if (!pte_same(pte, expected_pte))
> 		break;
> 
> the loop is not broken, and batching continues into unrelated memory.
> 
> ...

Looks OK for now I guess but it looks like we should pay some attention
to what types we're using.

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -248,11 +248,9 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>  		bool *any_writable, bool *any_young, bool *any_dirty)
>  {
> -	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> -	const pte_t *end_ptep = start_ptep + max_nr;
>  	pte_t expected_pte, *ptep;
>  	bool writable, young, dirty;
> -	int nr;
> +	int nr, cur_nr;
>  
>  	if (any_writable)
>  		*any_writable = false;
> @@ -265,11 +263,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
>  	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
>  
> +	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
> +	max_nr = min_t(unsigned long, max_nr,
> +		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
> +

Methinks max_nr really wants to be unsigned long.  That will permit the
cleanup of quite a bit of truncation, extension, signedness conversion
and general type chaos in folio_pte_batch()'s various callers.

And...

Why does folio_nr_pages() return a signed quantity?  It's a count.

And why the heck is folio_pte_batch() inlined?  It's larger then my
first hard disk and it has five callsites!


