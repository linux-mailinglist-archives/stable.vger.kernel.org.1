Return-Path: <stable+bounces-223690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDIZKPLsrmkWKQIAu9opvQ
	(envelope-from <stable+bounces-223690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:53:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FE23C231
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C65973067622
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC53D9043;
	Mon,  9 Mar 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lf9DQgKh"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2E389455;
	Mon,  9 Mar 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070646; cv=none; b=TmVO3Kxiv9JtANZeGPLRBGd2isNkw/adyuyXklZ9p5e7yXeLsLZhaBQcY6zDSOYoRd1X8f8eyU5CrS7ahaz/REfm3Fw3CrVh3hbIrsbR9hQQdFPaKg0eFk0YCGqlO5u7FK7KJxCKdM78H56S0BjK11x+dqAE+2qULUAbJ3UFnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070646; c=relaxed/simple;
	bh=NfWFfNKXJds5BykHNPrLNjvC2jU8E1juvCqg2x1EFzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpadEedzGYQE0qk/m+98uZhJ2V22Lp+xMXbQSAfT7p6gSRw14W307oyPwLWbr65v/zKq+74CELeW0pIfr9D6fUn+gsvoyjg7rs6wZHZZcbLX08TlXompA2mS96zwXJBYidAyNWCdTxrHHXuq0aF8omcr7XgID7mA3gjafsx+FOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lf9DQgKh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wd+q3V3rXKK+6/4p69Oq5EEDf2sKUZ0QnX+sg+AiRq8=; b=lf9DQgKhdn6BV72IQveqjJZIeH
	WevS47lWtQC5+c1Ox9xQPilM4kD+A0tjDJz6wQKgo0KtaRFhxZe5I4J0oZNpp2i07FYzSme+iLVty
	HiPhliZWz13lPZ6pTrG1zo2gSzHX16N24ee4GsnjafA5Ryu+dXw74zw0xdwmYwikesYJHmAUMkPgo
	47IVglfI7bmi6+/sZfoG0jcHaNLilSW1DLDVsjRwKIDTcHhZ/crWx/ViliwgVsbiPl4afsh9lLJsE
	U8b3LTpG3HOPG9+GchqWqkyf021AJOPNSyRoyMbG3w/Tnke41DwlVVBFoBr4zxDPsQ6RHpxGb5K3G
	4pJDehyA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzcfW-00000006AKo-1J0L;
	Mon, 09 Mar 2026 15:37:18 +0000
Date: Mon, 9 Mar 2026 15:37:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johnny Hao <johnny_haocn@sina.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, slava@dubeyko.com,
	vishal.moola@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 2/3] highmem: add kernel-doc for memcpy_*_folio()
Message-ID: <aa7pLpU_-S6quLCR@casper.infradead.org>
References: <20260309050130.912344-1-johnny_haocn@sina.com>
 <20260309050130.912344-3-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309050130.912344-3-johnny_haocn@sina.com>
X-Rspamd-Queue-Id: 9C0FE23C231
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,dubeyko.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,casper.infradead.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sina.com:email,linux-foundation.org:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:01:29PM +0800, Johnny Hao wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> [ Upstream commit 9af47276ed83cc346263e56243756543a2a33c9d ]

what?  This patch isn't that commit.  That commit does indeed add
kernel-doc.  This patch adds the functions themselves.  Please be
more careful.

> This was inadvertently skipped when adding the new functions.
> 
> Link: https://lkml.kernel.org/r/20240124181217.1761674-1-willy@infradead.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
> ---
>  include/linux/highmem.h | 164 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 44242268f53b..a2a0cfbc19a0 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -415,6 +415,170 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
>  	kunmap_local(addr);
>  }
>  
> +/**
> + * memcpy_from_folio - Copy a range of bytes from a folio.
> + * @to: The memory to copy to.
> + * @folio: The folio to read from.
> + * @offset: The first byte in the folio to read.
> + * @len: The number of bytes to copy.
> + */
> +static inline void memcpy_from_folio(char *to, struct folio *folio,
> +		size_t offset, size_t len)
> +{
> +	VM_BUG_ON(offset + len > folio_size(folio));
> +
> +	do {
> +		const char *from = kmap_local_folio(folio, offset);
> +		size_t chunk = len;
> +
> +		if (folio_test_highmem(folio) &&
> +		    chunk > PAGE_SIZE - offset_in_page(offset))
> +			chunk = PAGE_SIZE - offset_in_page(offset);
> +		memcpy(to, from, chunk);
> +		kunmap_local(from);
> +
> +		to += chunk;
> +		offset += chunk;
> +		len -= chunk;
> +	} while (len > 0);
> +}
> +
> +/**
> + * memcpy_to_folio - Copy a range of bytes to a folio.
> + * @folio: The folio to write to.
> + * @offset: The first byte in the folio to store to.
> + * @from: The memory to copy from.
> + * @len: The number of bytes to copy.
> + */
> +static inline void memcpy_to_folio(struct folio *folio, size_t offset,
> +		const char *from, size_t len)
> +{
> +	VM_BUG_ON(offset + len > folio_size(folio));
> +
> +	do {
> +		char *to = kmap_local_folio(folio, offset);
> +		size_t chunk = len;
> +
> +		if (folio_test_highmem(folio) &&
> +		    chunk > PAGE_SIZE - offset_in_page(offset))
> +			chunk = PAGE_SIZE - offset_in_page(offset);
> +		memcpy(to, from, chunk);
> +		kunmap_local(to);
> +
> +		from += chunk;
> +		offset += chunk;
> +		len -= chunk;
> +	} while (len > 0);
> +
> +	flush_dcache_folio(folio);
> +}
> +
> +/**
> + * folio_zero_tail - Zero the tail of a folio.
> + * @folio: The folio to zero.
> + * @offset: The byte offset in the folio to start zeroing at.
> + * @kaddr: The address the folio is currently mapped to.
> + *
> + * If you have already used kmap_local_folio() to map a folio, written
> + * some data to it and now need to zero the end of the folio (and flush
> + * the dcache), you can use this function.  If you do not have the
> + * folio kmapped (eg the folio has been partially populated by DMA),
> + * use folio_zero_range() or folio_zero_segment() instead.
> + *
> + * Return: An address which can be passed to kunmap_local().
> + */
> +static inline __must_check void *folio_zero_tail(struct folio *folio,
> +		size_t offset, void *kaddr)
> +{
> +	size_t len = folio_size(folio) - offset;
> +
> +	if (folio_test_highmem(folio)) {
> +		size_t max = PAGE_SIZE - offset_in_page(offset);
> +
> +		while (len > max) {
> +			memset(kaddr, 0, max);
> +			kunmap_local(kaddr);
> +			len -= max;
> +			offset += max;
> +			max = PAGE_SIZE;
> +			kaddr = kmap_local_folio(folio, offset);
> +		}
> +	}
> +
> +	memset(kaddr, 0, len);
> +	flush_dcache_folio(folio);
> +
> +	return kaddr;
> +}
> +
> +/**
> + * folio_fill_tail - Copy some data to a folio and pad with zeroes.
> + * @folio: The destination folio.
> + * @offset: The offset into @folio at which to start copying.
> + * @from: The data to copy.
> + * @len: How many bytes of data to copy.
> + *
> + * This function is most useful for filesystems which support inline data.
> + * When they want to copy data from the inode into the page cache, this
> + * function does everything for them.  It supports large folios even on
> + * HIGHMEM configurations.
> + */
> +static inline void folio_fill_tail(struct folio *folio, size_t offset,
> +		const char *from, size_t len)
> +{
> +	char *to = kmap_local_folio(folio, offset);
> +
> +	VM_BUG_ON(offset + len > folio_size(folio));
> +
> +	if (folio_test_highmem(folio)) {
> +		size_t max = PAGE_SIZE - offset_in_page(offset);
> +
> +		while (len > max) {
> +			memcpy(to, from, max);
> +			kunmap_local(to);
> +			len -= max;
> +			from += max;
> +			offset += max;
> +			max = PAGE_SIZE;
> +			to = kmap_local_folio(folio, offset);
> +		}
> +	}
> +
> +	memcpy(to, from, len);
> +	to = folio_zero_tail(folio, offset + len, to + len);
> +	kunmap_local(to);
> +}
> +
> +/**
> + * memcpy_from_file_folio - Copy some bytes from a file folio.
> + * @to: The destination buffer.
> + * @folio: The folio to copy from.
> + * @pos: The position in the file.
> + * @len: The maximum number of bytes to copy.
> + *
> + * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE
> + * if the folio comes from HIGHMEM, and by the size of the folio.
> + *
> + * Return: The number of bytes copied from the folio.
> + */
> +static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
> +		loff_t pos, size_t len)
> +{
> +	size_t offset = offset_in_folio(folio, pos);
> +	char *from = kmap_local_folio(folio, offset);
> +
> +	if (folio_test_highmem(folio)) {
> +		offset = offset_in_page(offset);
> +		len = min_t(size_t, len, PAGE_SIZE - offset);
> +	} else
> +		len = min(len, folio_size(folio) - offset);
> +
> +	memcpy(to, from, len);
> +	kunmap_local(from);
> +
> +	return len;
> +}
> +
>  /**
>   * folio_zero_segments() - Zero two byte ranges in a folio.
>   * @folio: The folio to write to.
> -- 
> 2.34.1
> 

