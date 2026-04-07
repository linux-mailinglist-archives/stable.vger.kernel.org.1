Return-Path: <stable+bounces-233496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMp1I3+Z1GmkvgcAu9opvQ
	(envelope-from <stable+bounces-233496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:43:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8253AA0BE
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 07:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EACC30730B9
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 05:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32832246BBA;
	Tue,  7 Apr 2026 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQeQy3U4"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4016198A17;
	Tue,  7 Apr 2026 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540446; cv=none; b=KxUKzn99RvgRAu79SS1WKjblR0ihvKN1Wqhp0gZRR+Hm3pGpv7we7On22nCMPKILgQVzRbZBEiYRNoy+cX3Ucd7WVt8yHk7K2dryxUiQ0kTJYk1tcJuf9KVfQ1H8W0gRnS85H3GJ35QvS2/VLvuoI7BMCAYNwAwy+bRtGYvUAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540446; c=relaxed/simple;
	bh=dQ5p/GhAuR9Qm6lIAeEyiHk0ywqwlTMhrOX6wfIjf54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrbMnduhFmXTxUrAuzjqBVjawMdlS2LKTk3gVcclMTtWXI8/h4+PWWZZlWTOW8GJGA/OZUPJJ6J1brY50enh4EGxv9FxqNq6AEe0AwXMBHIGCpJuIEMbCt+uOojRpYuy5UH5mZGacFI1N6LJCX/VVGJw9Adg5cF/Gb2dRItmru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hQeQy3U4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m80H6dY3qNDlrrXnKrojcQcKdyXEUOwyxynVcA0KsLQ=; b=hQeQy3U4QFZwP5kLHMILjls95d
	EwHzuGjnEMYy+nVWaKUxli6eO0h6+7uIxDxoM4+X51Nh8xca8dKnGux3ySavAQZQInIbSTDLjy+6C
	6Mvji+ElhAFWMMqgDxTj7DZ4dj1LB1EY8oFw6Pd+e26gkpTNtDWpu4lMEDx7FHUATmWQbYhv6AyUX
	ex4zqjXFkQQ9joM5P/sUazqSTjfgbfxJdg1wJ668ZBiOEgJF+4G7MhC+1aAwym9cjZyDyBsT4sWxv
	/rOaorE3Dk/Kt0qrm8dIg3M49KeZq2yUz0MxsiWHDlqGkji1Co2XJ/aeVAFKFw3mALR6ish2GGYJ4
	hqCTxEHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zB6-00000005w6E-1FHw;
	Tue, 07 Apr 2026 05:40:44 +0000
Date: Mon, 6 Apr 2026 22:40:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <dgc@kernel.org>
Cc: Salvatore Dipietro <dipiets@amazon.it>, linux-kernel@vger.kernel.org,
	alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de,
	dipietro.salvatore@gmail.com, willy@infradead.org,
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <adSY3GnLHyQatigQ@infradead.org>
References: <20260403193535.9970-1-dipiets@amazon.it>
 <20260403193535.9970-2-dipiets@amazon.it>
 <adLlrSZ5oRAa_Hfd@dread>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adLlrSZ5oRAa_Hfd@dread>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233496-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amazon.it,vger.kernel.org,amazon.com,amazon.de,gmail.com,infradead.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB8253AA0BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 08:43:57AM +1000, Dave Chinner wrote:
> > +	if (FGF_GET_ORDER(fgp) > PAGE_ALLOC_COSTLY_ORDER)
> > +		gfp &= ~__GFP_DIRECT_RECLAIM;
> 
> Adding these "gfp &= ~__GFP_DIRECT_RECLAIM" hacks everywhere
> we need to do high order folio allocation is getting out of hand.

That's what I thought.

> Compaction improves long term system performance, so we don't really
> just want to turn it off whenever we have demand for high order
> folios.

Yes.  Also if we want to make block size > PAGE_SIZE a real option,
just giving up on allocating large folios is not an option.

> Instead, memory reclaim should kick background compaction and let it
> do the work. If the allocation path really, really needs high order
> allocation to succeed, then it can direct the allocation to retry
> until it succeeds and the allocator itself can wait for background
> compaction to make progress.
> 
> For code that has fallbacks to smaller allocations, then there is no
> need to wait for compaction - we can attempt fast smaller allocations
> and continue that way until an allocation succeeds....

Yes.


