Return-Path: <stable+bounces-239988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCrcJp565mkHxAEAu9opvQ
	(envelope-from <stable+bounces-239988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:12:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC014332FA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7FB33018BF1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932203B6356;
	Mon, 20 Apr 2026 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgU6OGKK"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BB3822AE;
	Mon, 20 Apr 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712338; cv=none; b=tcWnBuTWjCMhXVB9j4VZsfD4FPTQp0rMUGR2AEnOBdMRAo5rMLpk3oKTA0SGmbPweYhgyufDGVLgvL0hz60dd01KVA3aa2rZaCpeqYTXKrfvumvcL45shf+VliLWR5m5RrinzilZVi9iSaZ4/HDvmt6rIcbouJI/pwxqu3VaQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712338; c=relaxed/simple;
	bh=ZhcM4Z6zSJMUteDVf4VCTHIMv9Csk1+zmy0thoEn6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ody2Q448VxvUu98Y8JNdgaDhfWdaE2xpPPaaQRaiNmjujSYZl4tAFunutgYc/xZKP/Qu+YXKy3HUMkarXVI79nRJ0M6A1f3CIHN+8X/7h+HpshScR8MqWw2/tT5Rj1xdRo4aiR1O7wHUKIYUNh4gBQnhUSGjjUNI8RayQQQSheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vgU6OGKK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VkzMuMQfcdnmbiI4D9AB8V2Ucb0IPvboF8F0c8KdAw8=; b=vgU6OGKKtV1z6cr8YCFIYl0jab
	svVav+9t3+DNXbKDQ3pXw4PLkD63DkQUz+4XXOKeb09ver8XDUQ5DQiynDb9FTYrP3pExGfIniDyo
	0nmQvm6+iVI5SO1A7SAnQvKtsUgGHDSXO9qvnLt9yEraGAMxKFvHhhA3Kke5V1Gc/Tbttq+v6GARY
	tPJic+KrlBKRpsAIKCDnnSnveEBGPhNSNDKhym213FZvY7Pj+QImPB9hy1VCIHfiSVk06yf3RssB6
	JmbhUiVexUbS1t19gHL2xkVGS8lxcUaqF50TKs6cY+vxOEkSyRgU4kvQTblwbeUE1v6qsenLGRsEd
	n6Yr4mBA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEu2Y-00000008uTB-05QR;
	Mon, 20 Apr 2026 19:12:14 +0000
Date: Mon, 20 Apr 2026 20:12:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
	abuehaze@amazon.com, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/filemap: avoid costly reclaim for high-order folio
 allocations
Message-ID: <aeZ6jQKL7zSCXNaP@casper.infradead.org>
References: <20260420161404.642-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420161404.642-1-dipiets@amazon.it>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239988-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,amazon.com,kernel.org,kvack.org,suse.cz,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 2FC014332FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 04:14:03PM +0000, Salvatore Dipietro wrote:
> v2: 
> - strip __GFP_DIRECT_RECLAIM to avoid costly reclaim for high-order
>   folio allocations
> - Moved fix from iomap to mm/filemap layer

I don't think filemap is the right place for this.  And neither does
Dave Chinner, nor Christoph Hellwig:

https://lore.kernel.org/all/adSY3GnLHyQatigQ@infradead.org/

I asked you for performance results with different patches, and you
didn't reply.  Now you're asking for this patch to be merged instead.
THIS IS NOT HOW IT WORKS.  You answer the damned questions being asked
of you by your fellow developers.

>  			err = -ENOMEM;
> -			if (order > min_order)
> -				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +			if (order > min_order) {
> +				alloc_gfp |= __GFP_NOWARN;
> +				if (order > PAGE_ALLOC_COSTLY_ORDER)
> +					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> +				else
> +					alloc_gfp |= __GFP_NORETRY;
> +			}
>  			folio = filemap_alloc_folio(alloc_gfp, order, policy);
>  			if (!folio)
>  				continue;
> 
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> -- 
> 2.47.3
> 
> 
> 
> 
> AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico
> 
> 
> 

