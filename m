Return-Path: <stable+bounces-249250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PcxHQ/2CmpZ+QQAu9opvQ
	(envelope-from <stable+bounces-249250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:20:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D984B56B6D5
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B514930573F8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718C3F2112;
	Mon, 18 May 2026 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaLD3APz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831435E1C7;
	Mon, 18 May 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102151; cv=none; b=hYZ/gkyPNRhek3LDN8G8XSmR7Ua+Z5wt44FBAqiyruGVFMiyJXGToZykiH00SNiJAC6LszyY0Gj1o0xC/jmdg4cDtp6hq5nNPF22SF1wXl8Fi9v0zUD7uvtQ4XjmEK66b8noWMYrGCYf2E/9N9kmygaTeqWYxQGwo9TSpmC3xt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102151; c=relaxed/simple;
	bh=g70XtJJPevCExq/iyrCHebLHBlkYshrO5L8eyIGBMHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ+3hMe3FLu/Wi7brahVrbHar9vrgfr54i/SWN7qDkyzdrFhAWQBV3oih1sUqgGx+DKdnLo0ZRrWDxTFNMzh/opEtPvQ1HttSfD0QC/nnJenmBO005KDtxyAfNK2gpOoupJd3lgwX9RTwLnS1HWdPMR6sxhXa1T7eTTeLuojE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaLD3APz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DCBC2BCB8;
	Mon, 18 May 2026 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102150;
	bh=g70XtJJPevCExq/iyrCHebLHBlkYshrO5L8eyIGBMHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaLD3APzLMg+QPrqeyqzAfh40yOr6tTNQBxRQyVAIYUzckafcMwfi4HqIU/dalg2M
	 sQVyXYFPEG0w4acY7ctzh/yZUDI0pmJNXMHF9I0YbaTwKk6k75D5PK8zwijx1cYHF6
	 uHIIsPh5HuGZP8uubWu6hXyIVj05zZQtu7QSTDghVK5jsswENRrGg/y+6CYYg/WaZy
	 iN1ou2ZJf5tDKaiEdux88NoD6iYYFoi00gymofc7mJe//yf0QQF45ng57D2YvL8O75
	 cQfV6LcwIipWNV0TOnFGt3oKK6D8ugtGKa16K8g55cL7FvtoKLO2gA0UDJSH1LPnJ7
	 1a058Sm28VaIQ==
Date: Mon, 18 May 2026 12:02:24 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com, 
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com, 
	baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: initialize nr_pages to 1 at loop start in
 try_to_unmap_one
Message-ID: <agrxiWhWb-yHT9Bk@lucifer>
References: <20260518063656.3721056-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518063656.3721056-1-dev.jain@arm.com>
X-Rspamd-Queue-Id: D984B56B6D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249250-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 12:06:56PM +0530, Dev Jain wrote:
> Initialize nr_pages to 1 at the start of each loop iteration, like
> folio_referenced_one() does.
>
> Without this, nr_pages computed by a previous folio_unmap_pte_batch() call
> can be reused on a later iteration that does not run
> folio_unmap_pte_batch() again.

Yikes!

>
> mmap a 64K large folio with MAP_ANONYMOUS | MAP_DROPPABLE, then call
> madvise(MADV_FREE), then make the last page device-exclusive via
> HMM_DMIRROR_EXCLUSIVE.
>
> Trigger node reclaim through sysfs. Now, in try_to_unmap_one(), we will
> first clear the first 15 out of 16 entries mapping the lazyfree folio.
> This will set nr_pages to 15. In the next pvmw walk, this nr_pages gets
> reused on a device-exclusive pte, thus potentially corrupting folio
> refcount/mapcount.
>
> At the moment, I have a userspace program which can make the kernel spit
> out a trace, but the blow up is in folio_referenced_one(), because there
> are existing bugs in the interaction between device-private and rmap
> (which too I am investigating). I did a one liner kernel change to avoid
> going into folio_referenced_one(), and the kernel blows up at
> folio_remove_rmap_ptes in try_to_unmap_one which is what I wanted.
>
> Note that the bug is there not since file folio batching but lazyfree folio
> batching, since device-exclusive only works for anonymous folios.
>
> Userspace visible effect is simply kernel crashing somewhere due to
> refcount/mapcount corruption.

Also yikes!

Thanks for the detailed commit message :)

>
> Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Thanks, LGTM so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> Acked-by: Barry Song <baohua@kernel.org>
> ---
> Applies on mm-unstable. This patch was part of
> https://lore.kernel.org/all/20260506094504.2588857-2-dev.jain@arm.com/
>
>  mm/rmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index fb3c351f8c45..1c77d5dc06e9 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2030,6 +2030,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	mmu_notifier_invalidate_range_start(&range);
>
>  	while (page_vma_mapped_walk(&pvmw)) {
> +		nr_pages = 1;
> +
>  		/*
>  		 * If the folio is in an mlock()d vma, we must not swap it out.
>  		 */
> --
> 2.43.0
>

Cheers, Lorenzo

