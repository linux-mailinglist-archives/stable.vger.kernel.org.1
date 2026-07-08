Return-Path: <stable+bounces-272699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 06m7IrB+Tmp0NwIAu9opvQ
	(envelope-from <stable+bounces-272699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:45:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD0728D92
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:45:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x1n+a7GN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+8ufZLru;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x1n+a7GN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+8ufZLru;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272699-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272699-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47DBA312405F
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830384307BF;
	Wed,  8 Jul 2026 16:28:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240442DA4F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528120; cv=none; b=WhI0mb4DMg6hSXrhLKfYMmQtYmPMmDs00cjf5VkKw3KQb19ZlWO+b97srVWSP7i+Zh2l85vAR+XB30lVkauQI+8pk5d+KDaV4E0z7k9HjMtWsLw0dq9Un35NZIBAsYyGb46T0vifT3VvLaXyn20Zxse+xtaEw7hWTrsxy9SWiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528120; c=relaxed/simple;
	bh=Vg5GgXyW7br+LNfM471fecWQemdUCDzWkMLuhj4Weds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5/X3U0HYbXKehJpSPR++PWNx/CaZ6t3YoXspX+vTLbtBjP5ta1MfeFUEgUIcV47SPpTQ9Vjfts2XxkK9pNHgBv7x95XI5lxd8sM9ZTm7Ih+oDiSDCtmx+Xd6du3a6eZAeVB4SqpX/qtS83CQJsfG/YUV08pGBdB5sAgdY4poCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x1n+a7GN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+8ufZLru; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x1n+a7GN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+8ufZLru; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8404E75BE7;
	Wed,  8 Jul 2026 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783528115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGW9x4QlPkotlXfqozxVSbIvsuCm8d/ta5MfhZyK9WI=;
	b=x1n+a7GNyFG9huMkWZEqD9+zC8J/OnSTaPj6X5zWEpRAy8q6y9BrEqJ1+YNFLqDtlsxYLF
	JaWEREIaXymEtxN1+gytrGefMIuJwTO+1LkdCzSp9L0heOIPA6IWSg/4PbRq8RdDOhIt5n
	UOzVuB62wYyQd4p7/vQxJXUqUsxrUig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783528115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGW9x4QlPkotlXfqozxVSbIvsuCm8d/ta5MfhZyK9WI=;
	b=+8ufZLruUQ6whIPPqFGtQq77EcaLjvp7kROJBvdwVwlsN494++jhWf4pad5pOOxk99BVO2
	GrTFDyI8VIUTUCDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783528115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGW9x4QlPkotlXfqozxVSbIvsuCm8d/ta5MfhZyK9WI=;
	b=x1n+a7GNyFG9huMkWZEqD9+zC8J/OnSTaPj6X5zWEpRAy8q6y9BrEqJ1+YNFLqDtlsxYLF
	JaWEREIaXymEtxN1+gytrGefMIuJwTO+1LkdCzSp9L0heOIPA6IWSg/4PbRq8RdDOhIt5n
	UOzVuB62wYyQd4p7/vQxJXUqUsxrUig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783528115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGW9x4QlPkotlXfqozxVSbIvsuCm8d/ta5MfhZyK9WI=;
	b=+8ufZLruUQ6whIPPqFGtQq77EcaLjvp7kROJBvdwVwlsN494++jhWf4pad5pOOxk99BVO2
	GrTFDyI8VIUTUCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D4FF779AE;
	Wed,  8 Jul 2026 16:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SRj0FrJ6TmpndgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 16:28:34 +0000
Date: Wed, 8 Jul 2026 17:28:32 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>, 
	Gregg Leventhal <gleventhal@janestreet.com>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios
 when collapsing
Message-ID: <ak556WxAZCyqQqbf@pedro-suse.lan>
References: <20260708151357.353173-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708151357.353173-1-pfalcato@suse.de>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272699-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:willy@infradead.org,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,m:lance.yang@linux.dev,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFCD0728D92

Seems that I accidentally dropped linked list Cc's here, see
https://lore.kernel.org/stable/20260708151357.353173-1-pfalcato@suse.de/

On Wed, Jul 08, 2026 at 04:13:57PM +0100, Pedro Falcato wrote:
> [There is no upstream commit, as this code was removed by upstream
>  commit 044925f9b565 ("mm: fs: remove filemap_nr_thps*() functions and their users")]
> 
> As-is, khugepaged and writable-file opening exclude each other. A file
> cannot be open writeable and have THPs (because the filesystem is not aware
> of them). khugepaged will never collapse file pages for files that are
> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
> particular file is dropped. This is fine because nothing could've been
> dirtied.
> 
> However, there is an edge-case: collapse_file() might not be able to
> coexist with concurrent writers, but it can coexist with dirty folios
> (from previous writers). Therefore, the following can happen:
> 
> open(file, O_RDWR)
> write(file)
> close(file)
> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
> open(file, O_RDWR)
>  nr_thps > 0
>   truncate_inode_pages()
>     /* THPs are cleared out, but so are the dirty folios */
> 
> When this edge-case happens, there is data loss, as the dirty folios are
> fully discarded.
> 
> Fix it by fully writing back the page cache (and waiting) when collapsing
> file THPs. Doing so provides the guarantee that no dirty folio will be
> observed while there are active THPs. To fully ensure this is safe, the
> invalidate_lock needs to be held while doing the writeout, so that
> do_dentry_open()'s page cache truncation excludes this write-and-wait.
> 
> As a side effect, move the nr_thps counter bumping outside the i_pages
> lock. This is correct since the counter itself is an atomic_t and the
> producer <-> consumer correctness is provided by a full memory barrier:
> smp_mb() in collapse_file()/memory barrier implied by full ordering in
> get_write_access() -> atomic_inc_unless_negative().
> 
> Cc: stable@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> Tested-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> v2:
>  - condition this logic on !mapping_large_folio_support(mapping) (Baolin, Lance, Matthew)
>  - explain why moving the nr_thps bumping outside the i_pages lock is safe (Matthew)
>  - pick up Tested-by from Lance (thank you!)
> 
>  mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8452dbdb043..d6e04041f5dc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  		goto xa_unlocked;
>  	}
>  
> -	if (!is_shmem) {
> +xa_locked:
> +	xas_unlock_irq(&xas);
> +xa_unlocked:
> +
> +	/*
> +	 * If collapse is successful, flush must be done now before copying.
> +	 * If collapse is unsuccessful, does flush actually need to be done?
> +	 * Do it anyway, to clear the state.
> +	 */
> +	try_to_unmap_flush();
> +
> +	if (result == SCAN_SUCCEED && !is_shmem && !mapping_large_folio_support(mapping)) {
> +		/*
> +		 * invalidate_lock as shared excludes against concurrent opens
> +		 * in do_dentry_open() truncating the page cache. This is
> +		 * particularly important if there are dirty folios in transit.
> +		 */
> +		filemap_invalidate_lock_shared(mapping);
>  		filemap_nr_thps_inc(mapping);
>  		/*
>  		 * Paired with the fence in do_dentry_open() -> get_write_access()
>  		 * to ensure i_writecount is up to date and the update to nr_thps
>  		 * is visible. Ensures the page cache will be truncated if the
> -		 * file is opened writable.
> +		 * file is opened writable. If collapse looks to be successful,
> +		 * flush any dirty pages out the page cache. With the nr_thps
> +		 * incremented, there won't be any new writers (nor new dirties).
>  		 */
>  		smp_mb();
> -		if (inode_is_open_for_write(mapping->host)) {
> +		if (inode_is_open_for_write(mapping->host) || filemap_write_and_wait(mapping)) {
>  			result = SCAN_FAIL;
>  			filemap_nr_thps_dec(mapping);
> +			filemap_invalidate_unlock_shared(mapping);
> +			goto rollback;
>  		}
> +		filemap_invalidate_unlock_shared(mapping);
>  	}
>  
> -xa_locked:
> -	xas_unlock_irq(&xas);
> -xa_unlocked:
> -
> -	/*
> -	 * If collapse is successful, flush must be done now before copying.
> -	 * If collapse is unsuccessful, does flush actually need to be done?
> -	 * Do it anyway, to clear the state.
> -	 */
> -	try_to_unmap_flush();
> -
>  	if (result == SCAN_SUCCEED && nr_none &&
>  	    !shmem_charge(mapping->host, nr_none))
>  		result = SCAN_FAIL;
> -- 
> 2.54.0
> 

-- 
Pedro

