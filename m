Return-Path: <stable+bounces-219573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKVMBBS7nmnwWwQAu9opvQ
	(envelope-from <stable+bounces-219573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 10:04:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0619496B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981AB3155CC8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF932E727;
	Wed, 25 Feb 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1HwktCW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6C32AADC;
	Wed, 25 Feb 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009920; cv=none; b=H1X/i0GS907VeD11LZ4/WPnP890KrL34WeSHe8Zz4EMbMeOuD1jTrVgwlEz+ZnFjwiYTClvtdmyLdj33yHRDXTFfe0Hb2hRIOvVX95TGSbRrlhTDYhLHXoG60IEQ51TdX8hhOIeg+xhsVRyEs+iO3ataKTfuHxiO8JQDDVeZ7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009920; c=relaxed/simple;
	bh=++lJa34FIQd0srk6H91XdQrYCvf1kKADzH8XRl7vWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUWBHiewFqeK3lRKMhhN5MYL1JbiWUv5LFY2/XaBcJX1OeX2m/DOmDFYN2UsJS9K/b2yyjOLHxy/3jigBRtEnPHBAYBDZzb9lYYHLiq+NqYgLR+NRLDZDpT1lXe7SbNlR6R3kXz8l2L4VxSEGpUJWsBcwUKZXjdpkidOA3L4av4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1HwktCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C4AC116D0;
	Wed, 25 Feb 2026 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772009920;
	bh=++lJa34FIQd0srk6H91XdQrYCvf1kKADzH8XRl7vWR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1HwktCWBfBnn+mWoG4xVpdg937txzThq5+AUBBINYW1g0lW/MV/s+4VwR7J4yHqG
	 A4ipDqQa/TBbV4j/DbbFZDZTpIwEqxWq1T0C5kN/SyiT8qmNjXFt4vIDwgtj+cg7gQ
	 h7qjztYt9jQmo5oRNpqm/nNJzH9Nldlizjw7NSZq0kwlkcpvcGkZsp4gsDzQsukMS9
	 8kl/P5Yd29AW583M1C7kJT+meOcy/shZy9SVmdMoOGxb13CiO4FqBJv2sOFjUTy+Ns
	 +c8ESgT0u+cQ3Al1BLMS4UxeLYcNwq7DxJbftIJBOqBx6ahnt3Kl+p+Ht/mz5yR7xA
	 uDKVrFXDj4seg==
Date: Wed, 25 Feb 2026 10:58:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: always dirty all folios
Message-ID: <aZ65uvOrTDndpic6@kernel.org>
References: <20260223173931.2221759-1-pratyush@kernel.org>
 <20260223173931.2221759-3-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223173931.2221759-3-pratyush@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219573-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FD0619496B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:39:29PM +0100, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> A dirty folio is one which has been written to. A clean folio is its
> opposite. Since a clean folio has no user data, it can be freed under
> memory pressure.
> 
> memfd preservation with LUO saves the flag at preserve(). This is
> problematic. The folio might get dirtied later. Saving it at freeze()
> also doesn't work, since the dirty bit from PTE is normally synced at
> unmap and there might still be mappings of the file at freeze().
> 
> To see why this is a problem, say a folio is clean at preserve, but gets
> dirtied later. The serialized state of the folio will mark it as clean.
> After retrieve, the next kernel will see the folio as clean and might
> try to reclaim it under memory pressure. This will result in losing user
> data.
> 
> Mark all folios of the file as dirty, and always set the
> MEMFD_LUO_FOLIO_DIRTY flag. This comes with the side effect of making
> all clean folios un-reclaimable. This is a cost that has to be paid for
> participants of live update. It is not expected to be a common use case
> to preserve a lot of clean folios anyway.
> 
> Since the value of pfolio->flags is a constant now, drop the flags
> variable and set it directly.
> 
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memfd_luo.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index ccbf1337f650..9eac02d06b5a 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -146,7 +146,6 @@ static int memfd_luo_preserve_folios(struct file *file,
>  	for (i = 0; i < nr_folios; i++) {
>  		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
>  		struct folio *folio = folios[i];
> -		unsigned int flags = 0;
>  
>  		err = kho_preserve_folio(folio);
>  		if (err)
> @@ -154,8 +153,26 @@ static int memfd_luo_preserve_folios(struct file *file,
>  
>  		folio_lock(folio);
>  
> -		if (folio_test_dirty(folio))
> -			flags |= MEMFD_LUO_FOLIO_DIRTY;
> +		/*
> +		 * A dirty folio is one which has been written to. A clean folio
> +		 * is its opposite. Since a clean folio does not carry user
> +		 * data, it can be freed by page reclaim under memory pressure.
> +		 *
> +		 * Saving the dirty flag at prepare() time doesn't work since it
> +		 * can change later. Saving it at freeze() also won't work
> +		 * because the dirty bit is normally synced at unmap and there
> +		 * might still be a mapping of the file at freeze().
> +		 *
> +		 * To see why this is a problem, say a folio is clean at
> +		 * preserve, but gets dirtied later. The pfolio flags will mark
> +		 * it as clean. After retrieve, the next kernel might try to
> +		 * reclaim this folio under memory pressure, losing user data.
> +		 *
> +		 * Unconditionally mark it dirty to avoid this problem. This
> +		 * comes at the cost of making clean folios un-reclaimable after
> +		 * live update.
> +		 */

Can we make the comment here shorter to only contain the gist of the issue?

> +		folio_mark_dirty(folio);
>  
>  		/*
>  		 * If the folio is not uptodate, it was fallocated but never
> @@ -174,12 +191,11 @@ static int memfd_luo_preserve_folios(struct file *file,
>  			flush_dcache_folio(folio);
>  			folio_mark_uptodate(folio);
>  		}
> -		flags |= MEMFD_LUO_FOLIO_UPTODATE;
>  
>  		folio_unlock(folio);
>  
>  		pfolio->pfn = folio_pfn(folio);
> -		pfolio->flags = flags;
> +		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
>  		pfolio->index = folio->index;
>  	}
>  
> -- 
> 2.53.0.371.g1d285c8824-goog
> 

-- 
Sincerely yours,
Mike.

