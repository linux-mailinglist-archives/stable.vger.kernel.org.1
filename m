Return-Path: <stable+bounces-219672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLJaAC8sn2lXZQQAu9opvQ
	(envelope-from <stable+bounces-219672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:06:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1919B3C9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CEF1300AD43
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279E3D9028;
	Wed, 25 Feb 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X035a8hT"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740C3D9029
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039209; cv=none; b=uRvMlNPWdyMYVyQhuhepPTPi1Rde2WCsekRoNh2incyaN2bRsw6oHuaNlOcxV7QdVZCAY/EnkNKvbIQl6AgT2dJkRIwVHgwndMtQzmNDyTswBTYTloH1yCDJUlUabnbXAcCT4OfAotfk7CPODJxOqXmxgZl6vVdWLpb2dndZdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039209; c=relaxed/simple;
	bh=pMK7KAEhwlOhE4+pvZvYFwy+6PAABVUiFILsUkr2fp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD35VyfG4RpnuC5YS/xIUawuWmYVl3qYcE8PICKsRD9egFmJtXdIMTGbZ6aTaqAQ6+EeCwIQl25DUzZhAhP7ybTjldHO/c7EhHoNb0tgsR4V3qkFxvUpQcNBii9KP48r+nmdDDvwDbzAos04ZibYo8zv6HkWYOYeTas0oxUjVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X035a8hT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 09:06:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772039203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zMK2L/UhVRAe7lEsp8URB6RkTXODu73U0cxlBFOHU6M=;
	b=X035a8hTxsKugHSn2WtvAHXbu/0JLbIYatHwUUcXmjkR62WusmyvkEmLYsEPHcoQSddz1x
	RiSQ+tGr/krV1c7bzXMRoSCmijUQ7S3OYAh9Pc4PrSwkRd6l18bg7dri1JltcPIv5LXRTd
	gMie22jGGtJFjgKcLpBAYBlF5kYBWTA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
Message-ID: <aZ8r15oUuF-3PN-u@linux.dev>
References: <20260225002434.2953895-1-axelrasmussen@google.com>
 <aZ8dasxUYuuWF9M1@casper.infradead.org>
 <6b5e14a9-751d-4a0d-9d53-b45a0ee5a4ed@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b5e14a9-751d-4a0d-9d53-b45a0ee5a4ed@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219672-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17A1919B3C9
X-Rspamd-Action: no action

+memcg maintainers

On Wed, Feb 25, 2026 at 05:08:28PM +0100, David Hildenbrand (Arm) wrote:
> On 2/25/26 17:03, Matthew Wilcox wrote:
> > On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> >> This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> >> But, these two APIs are not interchangeable: the lruvec version also
> >> increments memcg stats, in addition to "global" pgdat stats.
> >>
> >> So after this change, the "pagetables" memcg stat in memory.stat always
> >> yields "0", which is a userspace visible regression.
> >>
> >> I tried to look for a refactor where we add a variant of
> >> lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> >> folio, to try to adhere to the spirit of the original patch. But at the
> >> end of the day this just means we have to call
> >> folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> >> accomplish much.
> > 
> > Thank you!  I hadn't been able to get a straight answer on this before.
> > 
> > You're right that there's no good function to call, but that just means
> > we need to make one.  The principle here is that (eventually) different
> > memdescs don't need to know about each other.  Obviously we're not there
> > yet, but we can start disentangling them by not casting ptdescs back to
> > folios (even though they're created that way).
> > 
> > Here's three patches smooshed together; I have them separately and I'll
> > post them soon.
> 
> Should we just apply + backport the revert for now and re-do it based on
> the revert?

Yes please.

