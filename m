Return-Path: <stable+bounces-242804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOKxIUmD92kwigIAu9opvQ
	(envelope-from <stable+bounces-242804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:18:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7814B6C33
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88C9E3006799
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ACD3A9D8D;
	Sun,  3 May 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfUWqIal";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIdPwBQw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfUWqIal";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIdPwBQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B62E8B81
	for <stable@vger.kernel.org>; Sun,  3 May 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828658; cv=none; b=dbAiW3XuOdu/lbO2NoSntQyK0rqk0mMu1CBekyhgkAYPz7UyYjBykBNT+GHJZbc4jTKz46OYn8VyteqyZKxkYVM1N6xuOedTnyP9ndD27C8bkWrWagGLQ7Lh5REsaclHOc6SLUE/q+9Zq22DnMneMX39GP+Bb4Zgbsb/arili9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828658; c=relaxed/simple;
	bh=tWy3b354jgGnUyZugL0H2GLcXEO+LTKjZr2rotVj1Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChhV6lbBK2v0gtFzAFtQFIdOLT6vav4IYi8fjqFh/fkof24HexzHZbm/X2AuqnqzLAmK/NZcAyDm9grbjTpNJ6HLVFtkFTdyQ6xRHQsDf1OWRWJ3Ddvwf80qXBOXTLOpqg3M3LBUlELdmVFNtJLwWTD1grmuemm9eVaZ+SqGn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfUWqIal; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIdPwBQw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfUWqIal; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIdPwBQw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C1805BF55;
	Sun,  3 May 2026 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777828655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDlKlMHbVinipLNw9LrA+knbIJA6L8a+g0vJK+dN85M=;
	b=VfUWqIal8zUZxua+OX+zlAT8qGOtxWgZdFmCWJFangvLdJYL62hKCI7XhV7FZv0uk6ydwp
	ZcwJW4rKvy9juzaKbjBCG5mUTcjC4u9xmuVR7RgLboZFwk97HFw1oRiNgP7NeruIQJCVlH
	bC0giDhlkn/KbypGsq3Roay3pH/34po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777828655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDlKlMHbVinipLNw9LrA+knbIJA6L8a+g0vJK+dN85M=;
	b=EIdPwBQwsxRtZUGDu6VTg/ER7tZhcSskFKrnHwwAHQwD+uvSGM4Sh3N5dqNBMyDMGa9q7Y
	oSbGt8aOozQoKsAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777828655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDlKlMHbVinipLNw9LrA+knbIJA6L8a+g0vJK+dN85M=;
	b=VfUWqIal8zUZxua+OX+zlAT8qGOtxWgZdFmCWJFangvLdJYL62hKCI7XhV7FZv0uk6ydwp
	ZcwJW4rKvy9juzaKbjBCG5mUTcjC4u9xmuVR7RgLboZFwk97HFw1oRiNgP7NeruIQJCVlH
	bC0giDhlkn/KbypGsq3Roay3pH/34po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777828655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDlKlMHbVinipLNw9LrA+knbIJA6L8a+g0vJK+dN85M=;
	b=EIdPwBQwsxRtZUGDu6VTg/ER7tZhcSskFKrnHwwAHQwD+uvSGM4Sh3N5dqNBMyDMGa9q7Y
	oSbGt8aOozQoKsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9553593A6;
	Sun,  3 May 2026 17:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id stqeNC6D92kPXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sun, 03 May 2026 17:17:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3CEC3A0799; Sun, 03 May 2026 19:11:42 +0200 (CEST)
Date: Sun, 3 May 2026 19:11:42 +0200
From: Jan Kara <jack@suse.cz>
To: Souvik Banerjee <souvik@amlalabs.com>
Cc: dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz, 
	apopple@nvidia.com, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/dax: check for empty/zero entries before calling
 pfn_to_page()
Message-ID: <wxna5633rfnyte56h77bezw4duqlbdyxpt6wejywebatfutgh6@w2czfecq5zhr>
References: <20260501233933.2614302-1-souvik@amlalabs.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501233933.2614302-1-souvik@amlalabs.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Queue-Id: EA7814B6C33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-242804-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email,nvidia.com:email,amlalabs.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On Fri 01-05-26 23:39:33, Souvik Banerjee wrote:
> Commit 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
> added zero/empty-entry early returns to dax_associate_entry() and
> dax_disassociate_entry(), but placed them *after* the
> `struct folio *folio = dax_to_folio(entry);` line.  dax_to_folio()
> expands to page_folio(pfn_to_page(dax_to_pfn(entry))), and page_folio()
> performs READ_ONCE(page->compound_head) -- a real dereference of the
> struct page pointer derived from a bogus PFN extracted from the
> empty/zero XA value.
> 
> On systems where vmemmap covers all of RAM that dereference reads
> garbage and is harmless: the early return then discards the result.
> On virtio-pmem with altmap (vmemmap stored inside the device), only
> the real device PFN range is mapped, so the dereference triggers a
> kernel paging fault from the truncate / invalidate path and from the
> PMD-downgrade branch of dax_iomap_pte_fault when an entry is being
> freed:
> 
>   Unable to handle kernel paging request at
>   virtual address ffff_fdff_bf00_0008 (vmemmap region)
>   Call trace:
>    dax_disassociate_entry.isra.0+0x20/0x50
>    dax_iomap_pte_fault
>    dax_iomap_fault
>    erofs_dax_fault
> 
> Close the residual gap by moving the dax_to_folio() call after the
> zero/empty guard in dax_disassociate_entry().  Apply the same
> treatment to dax_busy_page(), which has the identical pattern but
> was not touched by the prior fix.
> 
> Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
> Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
> Cc: stable@vger.kernel.org # v6.15+
> Cc: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>

Yeah, good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 6d175cd47a99..6878473265bb 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -505,21 +505,23 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  				bool trunc)
>  {
> -	struct folio *folio = dax_to_folio(entry);
> +	struct folio *folio;
>  
>  	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
>  		return;
>  
> +	folio = dax_to_folio(entry);
>  	dax_folio_put(folio);
>  }
>  
>  static struct page *dax_busy_page(void *entry)
>  {
> -	struct folio *folio = dax_to_folio(entry);
> +	struct folio *folio;
>  
>  	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
>  		return NULL;
>  
> +	folio = dax_to_folio(entry);
>  	if (folio_ref_count(folio) - folio_mapcount(folio))
>  		return &folio->page;
>  	else
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

