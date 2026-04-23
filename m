Return-Path: <stable+bounces-240444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK5NBZrg6WmTmQIAu9opvQ
	(envelope-from <stable+bounces-240444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:04:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7019B44EFA7
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C8C303DD6F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2983DE438;
	Thu, 23 Apr 2026 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="klWRZF8D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E73DF012
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934792; cv=none; b=cTomtXWd76hn/5yAp9+CZ8N9+YA04hYHPKSHTYWt3M49bcGTmqx0OcexQ6E3Sc3r3Ao4l8w1zdm0Hj4RidBqmmCxB3qdFizkwi4/WkDtlFbIlFfv08Y5Yyct4ViC+V0LgOP6XjQovNRzazPN1Ffgr9CaBYV1/CRUK1rcT8JReXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934792; c=relaxed/simple;
	bh=tE6hP1ENRaZQlDswdTNz2zgNU1icDwVe0drqFgsQcyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjSko8WqIbrE65XVMAFVYOj/C27RRfDoDkTi96d063OtL2DHz2a/xmjGsuvJRqqBk+VAYzEW/hwGXPOyqfn95krqGzqSvbrViXsViCDKZlHFT0DBLuokuv1sXdKl2Pu56jZFNFkQoYwLrGD1ASMrlbajyO2Pfhf9HYZLj7bKDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=klWRZF8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6AAC2BCAF;
	Thu, 23 Apr 2026 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776934791;
	bh=tE6hP1ENRaZQlDswdTNz2zgNU1icDwVe0drqFgsQcyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klWRZF8Dv4zjMq6aKgV2pnU+1DxvJpNysA3RxQnJSnp7eThOBzHTNvsYnden+AG/P
	 q+8WY6q7cg9FHxEXkeI233dwd4sdKhOZ4Ehns9MyOKEn3pz/j+Bda8ml3d400HG9gq
	 U1A0oHZQ5RoUBsIOWcxdHbvO0IX/1hHj9N7exlQs=
Date: Thu, 23 Apr 2026 10:59:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: stable@vger.kernel.org,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm: call ->free_folio() directly in
 folio_unmap_invalidate()
Message-ID: <2026042310-buffoon-wool-f299@gregkh>
References: <2026042002-idealness-evade-7213@gregkh>
 <20260420145343.2046992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420145343.2046992-1-willy@infradead.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240444-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,infradead.org:email,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 7019B44EFA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 03:53:43PM +0100, Matthew Wilcox (Oracle) wrote:
> We can only call filemap_free_folio() if we have a reference to (or hold a
> lock on) the mapping.  Otherwise, we've already removed the folio from the
> mapping so it no longer pins the mapping and the mapping can be removed,
> causing a use-after-free when accessing mapping->a_ops.
> 
> Follow the same pattern as __remove_mapping() and load the free_folio
> function pointer before dropping the lock on the mapping.  That lets us
> make filemap_free_folio() static as this was the only caller outside
> filemap.c.
> 
> Link: https://lore.kernel.org/20260413184314.3419945-1-willy@infradead.org
> Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 615d9bb2ccad42f9e21d837431e401db2e471195)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c  | 3 ++-
>  mm/internal.h | 1 -
>  mm/truncate.c | 6 +++++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d8d9c0f0beb6..76bbfa69aca0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -233,7 +233,8 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
>  	page_cache_delete(mapping, folio, shadow);
>  }
>  
> -void filemap_free_folio(struct address_space *mapping, struct folio *folio)
> +static void filemap_free_folio(const struct address_space *mapping,
> +		struct folio *folio)
>  {
>  	void (*free_folio)(struct folio *);
>  	int refs = 1;
> diff --git a/mm/internal.h b/mm/internal.h
> index 9e0577413087..f046099d8eff 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -401,7 +401,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
> -void filemap_free_folio(struct address_space *mapping, struct folio *folio);
>  int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
>  		loff_t end);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index fb5c20b57bd4..6bbe22ae3ab8 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -574,6 +574,7 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
>  static int invalidate_complete_folio2(struct address_space *mapping,
>  					struct folio *folio)
>  {
> +	void (*free_folio)(struct folio *);
>  	if (folio->mapping != mapping)
>  		return 0;
>  
> @@ -590,9 +591,12 @@ static int invalidate_complete_folio2(struct address_space *mapping,
>  	xa_unlock_irq(&mapping->i_pages);
>  	if (mapping_shrinkable(mapping))
>  		inode_add_lru(mapping->host);
> +	free_folio = mapping->a_ops->free_folio;

Wait, I see what's wrong, this function isn't even in 6.18.y, which is
why when I apply this it has fuzz and blows up.

So this isn't going to work at all here, did you send the wrong
backport?

thanks,

greg k-h

