Return-Path: <stable+bounces-241411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fauUJhmV72leDAEAu9opvQ
	(envelope-from <stable+bounces-241411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F55476B28
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3FF6301384F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179B3DA7C7;
	Mon, 27 Apr 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXaef73M"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F925A2A2
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308949; cv=none; b=rurpsXNblRof0ksY/K7EgJWjS0QU7dhGX+qwKtXMTp4plSjnB/XkPdQ3nDMesY1/y5H592OYaVM6GztmlbcJQdb8CO0sQYK0Po9UdvsuI8OK5M/VnAhHBgJ5R2k9C/NgtRwsr7F+852yIi6JEYguYAEGNk1jx+CVrPgsq1l2MkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308949; c=relaxed/simple;
	bh=9NLAnZyvkPxdTiPXgetlc4R2iyg3gn4b0+yqy+0wL68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhSuU0MkZhzJh+OBJiGiNaOTPaQFqwIpzX+ITmp5S2+XXLsMbmOrAskjGw/npXNeYrgRdGnAd87OVfJgNh44PJQo+5DR2xeuabrM7eqO9SiCtCwSORD5plX3u7YgP8c3m1uxR4ql1a7EJmwWYrI2nENTW1AIpQZw7w3/Ns1478I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iXaef73M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e2PbKND2xsOure1JHyNw9mIl9kMp8mBAQlrrVVreNgY=; b=iXaef73MAVRIW6giM+n0p2tFpF
	k/Gk1psGXRKSUIUP3utYxPLzjdyJ6zgqj8CKiKJsxElWYA+cF44dBInC4sdyhm+5lz8BECGMl/bza
	NGgho4G5ksjo0IpTkb8Eru/cQAmKN6xSd84pxxxhNovFq9xWnDG2byx+4HpRhqqHhusa/zJhYFy/n
	Q0qQY/UwPMyDECnrg/rMyEvEMWBTuv/ZVpdB5WAZkKCOkJeZdUb5JyLIWSrrQtGDV2dLytzMxm1QL
	x64F3KxD2YnfGILlkw0bA7XrdtbZPZGtMFa52n0b1sk3HkqkW+RZ0l17910e00y0v5jPvvGPzBpec
	SBrawWAw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPFI-00000002Nnz-1RiC;
	Mon, 27 Apr 2026 16:55:44 +0000
Date: Mon, 27 Apr 2026 17:55:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm: call ->free_folio() directly in
 folio_unmap_invalidate()
Message-ID: <ae-VEGhzCff5Cx9C@casper.infradead.org>
References: <2026042002-idealness-evade-7213@gregkh>
 <20260420145343.2046992-1-willy@infradead.org>
 <2026042310-buffoon-wool-f299@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042310-buffoon-wool-f299@gregkh>
X-Rspamd-Queue-Id: 03F55476B28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241411-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:email]

On Thu, Apr 23, 2026 at 10:59:49AM +0200, Greg KH wrote:
> On Mon, Apr 20, 2026 at 03:53:43PM +0100, Matthew Wilcox (Oracle) wrote:
> > We can only call filemap_free_folio() if we have a reference to (or hold a
> > lock on) the mapping.  Otherwise, we've already removed the folio from the
> > mapping so it no longer pins the mapping and the mapping can be removed,
> > causing a use-after-free when accessing mapping->a_ops.
> > 
> > Follow the same pattern as __remove_mapping() and load the free_folio
> > function pointer before dropping the lock on the mapping.  That lets us
> > make filemap_free_folio() static as this was the only caller outside
> > filemap.c.
> > 
> > Link: https://lore.kernel.org/20260413184314.3419945-1-willy@infradead.org
> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Wait, I see what's wrong, this function isn't even in 6.18.y, which is
> why when I apply this it has fuzz and blows up.
> 
> So this isn't going to work at all here, did you send the wrong
> backport?

Oh blimey.  Somehow I did the backport to 6.12.y.  Sorry about that;
I'll do 6.18 now.

