Return-Path: <stable+bounces-237856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNtiMAwz3mlWpAkAu9opvQ
	(envelope-from <stable+bounces-237856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:29:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2D3F9FBE
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F4E301B919
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564C3A4502;
	Tue, 14 Apr 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c9TbBTi2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XdoxE3nX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pIm8/heN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgs93AZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3253361658
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169737; cv=none; b=Sazi2Mm4gwhk2BFo6zjBgDpHuxR46OHQwRMViY+k0rrAPNFbJWI52Wopd/lsdUjbaqWAv4fqxERYYwdL8qQYg8nzBw1uxEOCwGrcZ7HG7pcfzHdqX06ZoIUNMvI2pyu7EdtxDj7HjGSumPqR9923jFLJnfdgCT0UEmG0iEceR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169737; c=relaxed/simple;
	bh=2xkmw3WEp1qR4K/8d5dr1luYxm0idJbMG5NQN56ZnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW8IkJGm9Sod2SHSOP0ii9NNeKXxRnS/2MBvNo6ShZ99ssH2Ji/B1I4bSsudTYSOtzOfntVWnAauY3ShpGLbDgBSRp0OdB0eB7862s2XmQrC2JtVzn+CtW5EOC+tevJcTlffi55tRDoes+dP58Gr7gVeh6/dL/g27QrMnQp2tRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c9TbBTi2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XdoxE3nX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pIm8/heN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rgs93AZz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFF635BDD9;
	Tue, 14 Apr 2026 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776169734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVEho8Ms8/HIAqhCfZUSO6x6cxhfOdq33qNwNAiuoY8=;
	b=c9TbBTi2jtPBz6EtoIsm01SjEfB3q8Hb42bfB34dS1snFyE1Kzv+iPka9RQBqK5K/2Rf7R
	NZ5XKH0N1lv9b977bkp0/z1pIThuJkxoJDGSIAcSndq0xHpQH6cs2g5eCYL7lmPYi8feTf
	RfHD/fX62X1ZBuJcFjN1vZIYUYNgmPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776169734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVEho8Ms8/HIAqhCfZUSO6x6cxhfOdq33qNwNAiuoY8=;
	b=XdoxE3nXlVDeacrd+lACcZEaNLgGXbMs8GXhRaY/F3Hr6v9eybjLN6cX5sS/5HXZAVxws/
	ee0FjOuqjVKaLSBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776169732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVEho8Ms8/HIAqhCfZUSO6x6cxhfOdq33qNwNAiuoY8=;
	b=pIm8/heN6PFnq62uVwa7anogYZWLnhLGiqhyWeNZKl7X3Y8zf3qYurXHIRy+pt7ekFjpSh
	z7hvw5+gzSQCs9jJFtCT2kjCUTXnj74bknrxbDndVjKkOk0gBgpszQst+vwpC3aeWRiX/v
	Kw7cY0ilqNORIecZxmqv7+xCJXqYxU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776169732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVEho8Ms8/HIAqhCfZUSO6x6cxhfOdq33qNwNAiuoY8=;
	b=rgs93AZzIRp1LtGRVrlwZVZu/w239QWqdbbJJCOwkae6tOk5dPVIPLhfy0UPnq5sLST4gL
	ujk4nsMCc3Bs+NAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5CD94B443;
	Tue, 14 Apr 2026 12:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HScVOAQz3mlDBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Apr 2026 12:28:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5146A0B66; Tue, 14 Apr 2026 14:28:52 +0200 (CEST)
Date: Tue, 14 Apr 2026 14:28:52 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>, 
	stable@vger.kernel.org, 
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
Subject: Re: [PATCH] mm: Call ->free_folio() directly in
 folio_unmap_invalidate()
Message-ID: <ima4xpxokjy6yxkpdewjnzzrh3gqwurtf4bhuic5fbitkvltie@33zwpb7rniut>
References: <20260413184314.3419945-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413184314.3419945-1-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237856-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim,infradead.org:email,kernel.dk:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C7F2D3F9FBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 13-04-26 19:43:11, Matthew Wilcox (Oracle) wrote:
> We can only call filemap_free_folio() if we have a reference to (or hold a
> lock on) the mapping.  Otherwise, we've already removed the folio from the
> mapping so it no longer pins the mapping and the mapping can be removed,
> causing a use-after-free when accessing mapping->a_ops.
> 
> Follow the same pattern as __remove_mapping() and load the free_folio
> function pointer before dropping the lock on the mapping.  That lets
> us make filemap_free_folio() static as this was the only caller outside
> filemap.c.
> 
> Fixes: 4a9e23159fd3 (mm/truncate: add folio_unmap_invalidate() helper)
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: stable@vger.kernel.org
> Reported-by: Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The fix looks good to me. Regarding the Fixes tag, Christoph is right that
at that point and even for some time after that folio_unmap_invalidate()
was fine as it was only called when holding inode reference. It was more
like fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when
writeback completes") when the problem started.

								Honza

> ---
>  mm/filemap.c  | 3 ++-
>  mm/internal.h | 1 -
>  mm/truncate.c | 6 +++++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 406cef06b684..5a4fecb24257 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -228,7 +228,8 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
>  	page_cache_delete(mapping, folio, shadow);
>  }
>  
> -void filemap_free_folio(struct address_space *mapping, struct folio *folio)
> +static void filemap_free_folio(const struct address_space *mapping,
> +		struct folio *folio)
>  {
>  	void (*free_folio)(struct folio *);
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index cb0af847d7d9..546114d3ee44 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -540,7 +540,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
> -void filemap_free_folio(struct address_space *mapping, struct folio *folio);
>  int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
>  		loff_t end);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 12467c1bd711..8617a12cb169 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -622,6 +622,7 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
>  int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  			   gfp_t gfp)
>  {
> +	void (*free_folio)(struct folio *);
>  	int ret;
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> @@ -648,9 +649,12 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  	xa_unlock_irq(&mapping->i_pages);
>  	if (mapping_shrinkable(mapping))
>  		inode_lru_list_add(mapping->host);
> +	free_folio = mapping->a_ops->free_folio;
>  	spin_unlock(&mapping->host->i_lock);
>  
> -	filemap_free_folio(mapping, folio);
> +	if (free_folio)
> +		free_folio(folio);
> +	folio_put_refs(folio, folio_nr_pages(folio));
>  	return 1;
>  failed:
>  	xa_unlock_irq(&mapping->i_pages);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

