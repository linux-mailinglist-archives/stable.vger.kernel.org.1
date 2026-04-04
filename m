Return-Path: <stable+bounces-233258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0a49N1qQ0Gll9AYAu9opvQ
	(envelope-from <stable+bounces-233258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 06:15:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F8399E12
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 06:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 661B3300833F
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 04:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53F334C20;
	Sat,  4 Apr 2026 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kv6MfH97"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFB332EDE;
	Sat,  4 Apr 2026 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775276116; cv=none; b=rkII2J4r7V1FZrtv/qH1GnMhiJ65dYHWloc77RKgKZqqjd7hVAAxLO3yn8Z+pJf9QVQAzFu48ZQzPL0oFnxw9YnXt3z8RQW9GHf2NOZ3n+88PGUZLZqBr7ikWNpzfH7pVan83UO5zfoG757O2TNa7Bz9DV2xMRS1x5qOWywhvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775276116; c=relaxed/simple;
	bh=L3BqPG7Rkb+GwjjVV/0ER1SVM/id0u09GjDsQYVrZxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGPLhZ5pUU6bgldPajHoG8L+KY8SuibyGTAyorzz8eISK6mgNQ5Ch8LKrFZ4qapQbOPXx3cxehrKQieoZZ9tn0aTygBljlOev6hgrNsiNUBFgwdrDtzFPexVsqoD6CbPTIwy11HlJUxd/owfVcbFPvwIeOybZEOvg8Q6uUH8C0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kv6MfH97; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=prgjruknzedrN/FySTUns/2cxrd1Ek5UwRzTS2GVwtQ=; b=kv6MfH97kDKvbWs8u/DfmlPLjB
	5VO90TEEKgWCAeJJxC9SIn1GUrL/irrN3MiSJPxvH11ki6Gl4DulTzSMKHfC7PsuL8Wjl7goHueEV
	sPCgxGOvoZFxpMbC1AbqJwQ6y0P4YjChWmmGbbXXCFKBx3UfqsuRboj6Dx1OeXjjeSvbMibkQbGli
	cTyM035nMVVDAk4pq/XHZAQGxPmh6Q1oFikGKjEF2JZ36/fUzqMvWJF7Ib2j+fb9+fpCPdFTn7+R+
	qZQSwsX5UgYG/q5pkUtH5iu2ijNCIT6xhDm186revhAwa5YMGW2ccgsRTj4FmC58HMqUZj8GgMyHY
	YI1lbzHg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8sPd-0000000FSmQ-0Veb;
	Sat, 04 Apr 2026 04:15:09 +0000
Date: Sat, 4 Apr 2026 05:15:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, alisaidi@amazon.com, blakgeof@amazon.com,
	abuehaze@amazon.de, dipietro.salvatore@gmail.com,
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <adCQTF1PQnlbNMO8@casper.infradead.org>
References: <20260403193535.9970-1-dipiets@amazon.it>
 <20260403193535.9970-2-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403193535.9970-2-dipiets@amazon.it>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233258-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.com,amazon.de,gmail.com,kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid]
X-Rspamd-Queue-Id: 4F2F8399E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the buffered write
> path. When memory is fragmented, each failed allocation triggers
> compaction and drain_all_pages() via __alloc_pages_slowpath(),
> causing a 0.75x throughput drop on pgbench (simple-update) with 
> 1024 clients on a 96-vCPU arm64 system.
> 
> Strip __GFP_DIRECT_RECLAIM from folio allocations in
> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
> making them purely opportunistic.

If you look at __filemap_get_folio_mpol(), that's kind of being tried
already:

                        if (order > min_order)
                                alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;

 * %__GFP_NORETRY: The VM implementation will try only very lightweight
 * memory direct reclaim to get some memory under memory pressure (thus
 * it can sleep). It will avoid disruptive actions like OOM killer. The
 * caller must handle the failure which is quite likely to happen under
 * heavy memory pressure. The flag is suitable when failure can easily be
 * handled at small cost, such as reduced throughput.

which, from the description, seemed like the right approach.  So either
the description or the implementation should be updated, I suppose?

Now, what happens if you change those two lines to:

			if (order > min_order) {
				alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
				alloc_gfp |= __GFP_NOWARN;
			}

Do you recover the performance?

