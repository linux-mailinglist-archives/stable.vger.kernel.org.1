Return-Path: <stable+bounces-233296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL6qNNJ40WmqKAcAu9opvQ
	(envelope-from <stable+bounces-233296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 22:47:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D73439C6E5
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2156F300EF5C
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B81311C15;
	Sat,  4 Apr 2026 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQ4CNywE"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048F2877CF;
	Sat,  4 Apr 2026 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775335615; cv=none; b=N94Tg3Gyx00Srse6dIpRvRyizpK2fUQmOL8Nt7Ibc1GuWgXPNfB40vjKEEtbc6pdghPtPMGMlx6oJcmeOxXf0sCh8lqTsABmA+0DM3+d484t3uR1AO9KUhCffae/V1Afbf+8gaHTNHpZvPtW18N2za94eFRlcKADv8I4heMmgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775335615; c=relaxed/simple;
	bh=mSTmkv4UXnOl0EgRCt2f8anxnf8qJMHtmD/Nirm1Cbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBIDGrXNQRudRACnJ61YLvu4T2WuJrbUsKbZAhN4qVZA2unxuWLKaRW+RwGxE6O3CzeHwhElaRs+94bWeaaIXqDg15uNYaEs1lQ1ZhPqnd4CAlSBCQHwbPyDMO5DsRPLIy4iBNzkt1r8+Pj1/2VJ6G+/2Q0ZjfPYbJAufMgOpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YQ4CNywE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hsCkEyNl1lnp1czfTsQmmel5+1299ohDP+2LAG1kJTw=; b=YQ4CNywEPe47yEr9rMZ/tGxSAf
	vBBrL5CLil1pMIQhxdubKnoQUdmUnLbS5NoUbezngMT/EaxGSGpOfBO7DCsgFWwVgDdrZcIYUbaqA
	FLqTDwGStPdCw3tiTutzFqbKKGUEpbPfuyBd3Xn7PVermVrMcgfEiXjddNQIY6xj+lq1CSIv89DaX
	GIiyGil5Lyvz3VmGEHgtbC1DuNsJJqTqLn5Tw0DPBl19vd6PZz0JiYoHj5RqCsiJaWWs1rbFBIXrO
	9FepSaecvQo5S1O5foXjHHOb9zOmfxt3EnvuGjNt8PYPl0xHNAo37D/HB2pS5kr4w2RkaXzwjV5E/
	AOyB2mtg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w97tJ-0000000GNZd-3hHD;
	Sat, 04 Apr 2026 20:46:49 +0000
Date: Sat, 4 Apr 2026 21:46:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Salvatore Dipietro <dipiets@amazon.it>, linux-kernel@vger.kernel.org,
	alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de,
	dipietro.salvatore@gmail.com, stable@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <adF4uWa0pikq9Vea@casper.infradead.org>
References: <20260403193535.9970-1-dipiets@amazon.it>
 <20260403193535.9970-2-dipiets@amazon.it>
 <adCQTF1PQnlbNMO8@casper.infradead.org>
 <5x66n04a.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5x66n04a.ritesh.list@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233296-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amazon.it,vger.kernel.org,amazon.com,amazon.de,gmail.com,kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D73439C6E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 10:17:33PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
> >> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> >> introduced high-order folio allocations in the buffered write
> >> path. When memory is fragmented, each failed allocation triggers
> >> compaction and drain_all_pages() via __alloc_pages_slowpath(),
> >> causing a 0.75x throughput drop on pgbench (simple-update) with 
> >> 1024 clients on a 96-vCPU arm64 system.
> >> 
> >> Strip __GFP_DIRECT_RECLAIM from folio allocations in
> >> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
> >> making them purely opportunistic.
> >
> > If you look at __filemap_get_folio_mpol(), that's kind of being tried
> > already:
> >
> >                         if (order > min_order)
> >                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> >
> >  * %__GFP_NORETRY: The VM implementation will try only very lightweight
> >  * memory direct reclaim to get some memory under memory pressure (thus
> >  * it can sleep). It will avoid disruptive actions like OOM killer. The
> >  * caller must handle the failure which is quite likely to happen under
> >  * heavy memory pressure. The flag is suitable when failure can easily be
> >  * handled at small cost, such as reduced throughput.
> >
> > which, from the description, seemed like the right approach.  So either
> > the description or the implementation should be updated, I suppose?
> >
> > Now, what happens if you change those two lines to:
> >
> > 			if (order > min_order) {
> > 				alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> > 				alloc_gfp |= __GFP_NOWARN;
> > 			}
> 
> Hi Matthew,
> 
> Shouldn't we try this instead? This would still allows us to keep
> __GFP_NORETRY and hence light weight direct reclaim/compaction for
> atleast the non-costly order allocations, right?
> 
>  			if (order > min_order) {
> 				alloc_gfp |= __GFP_NOWARN;
> 				if (order > PAGE_ALLOC_COSTLY_ORDER)
> 					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> 				else
> 					alloc_gfp |= __GFP_NORETRY;
> 			}

Uhh ... maybe?  I'd want someone more familiar with the page allocator
than I am to say whether that's the right approach.  If it is, that
seems too complex, and maybe we need a better approach to the page
allocator flags.

