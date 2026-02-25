Return-Path: <stable+bounces-219659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KEBANUgn2lcZAQAu9opvQ
	(envelope-from <stable+bounces-219659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:18:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2119A6A9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9060030A5B25
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768783D6664;
	Wed, 25 Feb 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dj9Dk53q"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1C38F94F;
	Wed, 25 Feb 2026 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035443; cv=none; b=dlrpbcCod4k9PVOoIjR1cc1lTkcWi8m9Zx1V1wKkKzJL7c3RT7hmlREUyS6uvqEeSJKNQV2JwyQSnGLcnIvPfTyUv2sIibsRATKiBNmDiAyL827bgwNg1SZLnpIvaTgmaeOQjuvWwNKOkSIX2EsMkOuVzvE3s2TKZMG2CcQlOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035443; c=relaxed/simple;
	bh=rFT2UsvGLAUGUVK5ZLvPz+k6h+sdXuLVoLa/dlc4oCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrsV/aUkxVI8NULJgJNppqSmOVcJhnbKQTqXExM/5c3N0JvSBAR8keCTa6eA1cfKg8fzHfoX4WgiblUcbYtNvvtH2iOR7dvbInxMptdoxPK4d0VSAw+QDZSDcs+yeHWP902g0V47JjDSBc0vnQGU4rNNS4gSbv4qE5fDyVb47Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dj9Dk53q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0J9g8glZ+C9CG7kUr9i2GkA6jzB/Q/+QP9Ox+/ZoIEo=; b=dj9Dk53qD1T3gEZZjGN45q0fZD
	rQKifH55s16xa+rDffcwJr9feocDEB0brkJJxpJwJgJQ9uv9xFTbIPNpSTgDz+lEWJHXEPyVJC7nD
	Y2DD3D+KwdFRDllP8yehqZYVfq2nIVjT4R9wLmXdivXqDf6olo23/DmmW42AVwx//Bs4pk3iPQ4qq
	vhk+23SLbevluYXNxnWvXg/TVqyScR8gOXssjFU/rG3rP8QtQtriv5rst9CbUvCK2I7r8MrLvYWHH
	bqsXwasdupeD2FfwhB3yeJ9LKc9Prz2LUsLCTRSa40+Ui9Q7jx+fTtBLfAUpPN1moyrGTMpNyeoZH
	N4lDa15w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHMg-00000001Icb-2aQy;
	Wed, 25 Feb 2026 16:03:54 +0000
Date: Wed, 25 Feb 2026 16:03:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
Message-ID: <aZ8dasxUYuuWF9M1@casper.infradead.org>
References: <20260225002434.2953895-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225002434.2953895-1-axelrasmussen@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219659-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 78E2119A6A9
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> But, these two APIs are not interchangeable: the lruvec version also
> increments memcg stats, in addition to "global" pgdat stats.
> 
> So after this change, the "pagetables" memcg stat in memory.stat always
> yields "0", which is a userspace visible regression.
> 
> I tried to look for a refactor where we add a variant of
> lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> folio, to try to adhere to the spirit of the original patch. But at the
> end of the day this just means we have to call
> folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> accomplish much.

Thank you!  I hadn't been able to get a straight answer on this before.

You're right that there's no good function to call, but that just means
we need to make one.  The principle here is that (eventually) different
memdescs don't need to know about each other.  Obviously we're not there
yet, but we can start disentangling them by not casting ptdescs back to
folios (even though they're created that way).

Here's three patches smooshed together; I have them separately and I'll
post them soon.

