Return-Path: <stable+bounces-273297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kBegBQY0UWrsAgMAu9opvQ
	(envelope-from <stable+bounces-273297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:03:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E9773D2E0
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:03:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=vrVhH6CZ;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273297-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273297-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B9853020E92
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100D37B025;
	Fri, 10 Jul 2026 18:03:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED83376BFB;
	Fri, 10 Jul 2026 18:03:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706600; cv=none; b=RfOntIWhwNC15co8bw7YHuqRYYjU/V0GpZsc/mYGentNtpd9YRG2oilUQYIh7lHHw71PgpquRaetCs8DhRuWQgxOx/4ClJAQJ+Kyao/xC6ThyuvxfBX7BGOfmrFWz2sl4/gFZytbCUsNU4HhhruVmZWX/T/wNfgjfk+ZI0BzkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706600; c=relaxed/simple;
	bh=jQ2ENi7efQIv9R2EbZKSeryq1m1JjIZToHHAmccFRis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOljFmmquBzBSPffiC7GdzzlwQ9D4QdfFzxqSFc/cqHYpNZmAIf9fTiJ68oiVzemZJFbJOAOvEjUgzxfEpbdYUzDmPjC5n9yeNvys1WT/55fuEgRa6BYhK62/vHqeb3Qt0mtuYGzS+R5uSeHSqgR42ZI3LcFKKpaTBEcHLfawXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vrVhH6CZ; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aavlYHK65oZ9/GvkqG4vhVx7lYGAHZXQDwnk4WMg/dU=; b=vrVhH6CZ43iMT+yYcxyiUFLLu7
	6n+lRXruBnU93GSLongig8SFlKm3AgZwxoDzqo0wCFEhLVi87OcdBvy8aEyLkK6uObGGpp63VQwi0
	hSuIpfQAUdKbz4EsnK6t5wjQvkQ/25WKWlk+JecIt/nOtDbO71fPl9LF/Y/NWdanurlhHNyyBxsjK
	XSgbg9xirVLA2JFSb6mTgsgwyUUGEvEy/Tq4u2cqbUgu7cHfzICrLfyLQIGbF4vEvE/JodppgC3p9
	nGpQPd0upaeQCTcahdsyxydddO8e2FVnQstNr/bwE9fIu3MRbNdbcIipOiQ0Iglr3voabEDxdG1xk
	h5/yoyDA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiFZA-00000007b0h-2b7J;
	Fri, 10 Jul 2026 18:03:12 +0000
Date: Fri, 10 Jul 2026 19:03:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-mm@kvack.org, hch@infradead.org, ritesh.list@gmail.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	dgc@kernel.org, vbabka@suse.cz, djwong@kernel.org,
	brauner@kernel.org, alisaidi@amazon.com, blakgeof@amazon.com,
	abuehaze@amazon.com, dipietro.salvatore@gmail.com,
	stable@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v3] mm/page_alloc: avoid direct compaction for costly
 __GFP_NORETRY allocations
Message-ID: <alEz4Chf7Ibyg-ZG@casper.infradead.org>
References: <20260710143437.12379-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710143437.12379-1-dipiets@amazon.it>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273297-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dipiets@amazon.it,m:linux-mm@kvack.org,m:hch@infradead.org,m:ritesh.list@gmail.com,m:akpm@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:dgc@kernel.org,m:vbabka@suse.cz,m:djwong@kernel.org,m:brauner@kernel.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:abuehaze@amazon.com,m:dipietro.salvatore@gmail.com,m:stable@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:riteshlist@gmail.com,m:dipietrosalvatore@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[willy@infradead.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,infradead.org,gmail.com,linux-foundation.org,vger.kernel.org,kernel.org,suse.cz,amazon.com,google.com,suse.com,cmpxchg.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:from_mime,infradead.org:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1E9773D2E0

On Fri, Jul 10, 2026 at 02:34:37PM +0000, Salvatore Dipietro wrote:
> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the iomap buffered write
> path.

https://lore.kernel.org/linux-mm/aeZzP6iQel-tkZOu@casper.infradead.org/

I just had a go at implementing what I thought might be the right design
(having a folio_alloc_orders(min, max, gfp)), but that's not really what
__filemap_get_folio_mpol() wants because it needs to integrate the actual
adding of folios to the page cache into the retry loop.

So instead, let's try this.  The idea is that we want to try direct reclaim
_twice_.  Once gently (ie with NORETRY specified) when we're trying to
allocate the maximum order folio.  But now that we've tried that once,
there's no point trying direct reclaim for other sizes, we just want to
ask the page allocator if it can give us memory of any subsequent size.

Until we come to the minimum order.  Then we want to try exactly as hard
as we were originally asked to try.  So revert to the original gfp flags
and don't set the NOWARN or NORETRY flags.

diff --git a/mm/filemap.c b/mm/filemap.c
index 58eb9d240643..23eecaf9b328 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1983,6 +1983,7 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 	if (!folio && (fgp_flags & FGP_CREAT)) {
 		unsigned int min_order = mapping_min_folio_order(mapping);
 		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
+		gfp_t alloc_gfp = gfp | __GFP_NORETRY | __GFP_NOWARN;
 		int err;
 		index = mapping_align_index(mapping, index);
 
@@ -2004,12 +2005,11 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			order = __ffs(index);
 
 		do {
-			gfp_t alloc_gfp = gfp;
-
 			err = -ENOMEM;
-			if (order > min_order)
-				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
+			if (order == min_order)
+				alloc_gfp = gfp;
 			folio = filemap_alloc_folio(alloc_gfp, order, policy);
+			alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
 			if (!folio)
 				continue;
 

