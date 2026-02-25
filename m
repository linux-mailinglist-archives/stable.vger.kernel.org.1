Return-Path: <stable+bounces-219571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGgnOTe5nmnwWwQAu9opvQ
	(envelope-from <stable+bounces-219571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 09:56:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A16F194769
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF931303132D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B993246E1;
	Wed, 25 Feb 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icycVHHB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16A213254;
	Wed, 25 Feb 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009616; cv=none; b=LA2gbJ2l46vOcwEdWIxxEuL9PJojEixLNqMrTogro7GbIIc2/4RGfcd5an+PL/zXQDEL2af67Q75f/6usRneAZbpvoLjYoS4zrShmQGEBPie5lWiGsLaXdhMbCrcxBrataSoVvILzLx08dthRgdShqoea61mScbRmvFkQ1OBh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009616; c=relaxed/simple;
	bh=5e/H/4vB41n/5YYIxm5Oxq/j6NJu0Yg2mNzLELZkuFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIevuGC3BtkSDAs38/DYaxKyJXpsvuSYsTYk9pjwBObW9AKg6P2w9h5yMTYVZlcFN/ihxmN8A3i/MK9jnsOZRfqRpgjsQF8/9t+Jo2eA4NLBD0mJMGmIPPz7IxPbjGtqfpTIcFMOEpW6vE0mGKp2PGcIzFj4z6+DJ3Z8sEA7tHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icycVHHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C336C116D0;
	Wed, 25 Feb 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772009616;
	bh=5e/H/4vB41n/5YYIxm5Oxq/j6NJu0Yg2mNzLELZkuFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icycVHHB8aMnMr/HwvRS/5ti/Jab+BYAMwEV3W4YW/JwDDKygA/4G1zIpiU/zdqh/
	 pQ7Xip/pq3u+x7rjAl7i/S3E/3ZSNOQKXGEV9NgfuaJ+D3HUkIihdWhgIyDg6bN5ht
	 HqhSg6WlJAKjdsWe6lAA2U4WsEtHWp5zVemkHEmvAmYp67O1/KSzNXEaYR/Ec3US2P
	 uGPM0KVkVxvWDxFrlBZtdJlycNbIja8f+956maAm76K18ObYnocpCuqHuP+HbV/uDo
	 lipm7jFRE11l4MMwin9dc0+BRQHtDiWZZg7QZrTArizGs2dwxP3l9HeJL8FJMGVlRN
	 EhE6W74fQEhBg==
Date: Wed, 25 Feb 2026 10:53:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memfd_luo: always make all folios uptodate
Message-ID: <aZ64ikDtz8tF_rFU@kernel.org>
References: <20260223173931.2221759-1-pratyush@kernel.org>
 <20260223173931.2221759-2-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223173931.2221759-2-pratyush@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219571-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A16F194769
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:39:28PM +0100, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> When a folio is added to a shmem file via fallocate, it is not zeroed on
> allocation. This is done as a performance optimization since it is
> possible the folio will never end up being used at all. When the folio
> is used, shmem checks for the uptodate flag, and if absent, zeroes the
> folio (and sets the flag) before returning to user.
> 
> With LUO, the flags of each folio are saved at preserve time. It is
> possible to have a memfd with some folios fallocated but not uptodate.
> For those, the uptodate flag doesn't get saved. The folios might later
> end up being used and become uptodate. They would get passed to the next
> kernel via KHO correctly since they did get preserved. But they won't
> have the MEMFD_LUO_FOLIO_UPTODATE flag.
> 
> This means that when the memfd is retrieved, the folios will be added to
> the shmem file without the uptodate flag. They will be zeroed before
> first use, losing the data in those folios.
> 
> Since we take a big performance hit in allocating, zeroing, and pinning
> all folios at prepare time anyway, take some more and zero all
> non-uptodate ones too.
> 
> Later when there is a stronger need to make prepare faster, this can be
> optimized.
> 
> To avoid racing with another uptodate operation, take the folio lock.
> 
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memfd_luo.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index a34fccc23b6a..ccbf1337f650 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -152,10 +152,31 @@ static int memfd_luo_preserve_folios(struct file *file,
>  		if (err)
>  			goto err_unpreserve;
>  
> +		folio_lock(folio);
> +
>  		if (folio_test_dirty(folio))
>  			flags |= MEMFD_LUO_FOLIO_DIRTY;
> -		if (folio_test_uptodate(folio))
> -			flags |= MEMFD_LUO_FOLIO_UPTODATE;
> +
> +		/*
> +		 * If the folio is not uptodate, it was fallocated but never
> +		 * used. Saving this flag at prepare() doesn't work since it
> +		 * might change later when someone uses the folio.
> +		 *
> +		 * Since we have taken the performance penalty of allocating,
> +		 * zeroing, and pinning all the folios in the holes, take a bit
> +		 * more and zero all non-uptodate folios too.
> +		 *
> +		 * NOTE: For someone looking to improve preserve performance,
> +		 * this is a good place to look.

I'd add a larger comment above memfd_luo_preserve_folios() that says that
it allocates, pins etc and fold the last two paragraphs of this comment
there.

> +		 */
> +		if (!folio_test_uptodate(folio)) {
> +			folio_zero_range(folio, 0, folio_size(folio));
> +			flush_dcache_folio(folio);
> +			folio_mark_uptodate(folio);
> +		}
> +		flags |= MEMFD_LUO_FOLIO_UPTODATE;
> +
> +		folio_unlock(folio);
>  
>  		pfolio->pfn = folio_pfn(folio);
>  		pfolio->flags = flags;
> -- 
> 2.53.0.371.g1d285c8824-goog
> 

-- 
Sincerely yours,
Mike.

