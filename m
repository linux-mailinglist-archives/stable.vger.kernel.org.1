Return-Path: <stable+bounces-273470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +pz5AOFWU2rIZwMAu9opvQ
	(envelope-from <stable+bounces-273470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 10:57:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA774435B
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 10:57:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G8NirJNo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273470-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273470-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A6A301015B
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E23988EB;
	Sun, 12 Jul 2026 08:56:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90921CA13;
	Sun, 12 Jul 2026 08:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846617; cv=none; b=OBXVwcXKkP5DerkduDnJ2UEhSIFL1TNrUU/KMPbqPllsgAgUc+xHSnQvphbB+fmMSf9Xi5L/OLTTTWCaSqVSeYASR/0/alzINZe5AjwM1NBAjO+Bx1lnC/cjM0jJ4MYQbwoQi+XbT9slLrFXKYfxztqhez466VFlukGXHslRzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846617; c=relaxed/simple;
	bh=S9zZzrtXVx8sDeydTwaAPoD0ptxeVLh3tmyBEnIlufY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAn2W8GH982rWyxYEolgRVLma6piNaKbKepe9nL+23ZyPngsvmBzlkNslxearXixNp2OC/KlNLNzE7VJ1HTpkKhhRzts9pEzgd/1SdHJeA++b+Zf4T3iiTXEBnrwtOq1lAjeEzGIyB1Ac5sAyNhj8STrgqu24NwKJ/lrAWS40+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8NirJNo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D902B1F000E9;
	Sun, 12 Jul 2026 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783846616;
	bh=w1QX3hTGyK7nmH+TWYo3ib3paeMzWZv8UTRh9r0nU6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G8NirJNogPgfVQStzR93ILsQkLo2BuDodADXa7j2U2HKGcUuBSxHAB/1xQ+C4pNTA
	 tFEwuEv4Q1XThXD2hfBkx8dxi/kSJCSJgfW2xdKsng/Glkv5jgvOOpNhtEky7rU/RQ
	 Qyk1xWkUZA0v4Tjq2VGnVnOXyJ6949OgkXyNKWy5Qa0/y7HjI0v+H5l6qdabltTH9J
	 wYDS2P0HwwuRTqTMgjRTuCVahT40r/OGHgiJympxHvzIQeSPvCB4anE5PgHVcHSV8h
	 QzDfHUW1JHXMtkgYRtrD6a8AzCkEl7KqptGR6Q5EAvXKyucQvMHgmGY+zYhCVRxqss
	 9Uao4jecSE1Nw==
Date: Sun, 12 Jul 2026 09:56:41 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Carlier <devnexen@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Message-ID: <alNWRKkOTIwJx-x7@lucifer>
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
 <alIVXHrcjaHhaFQo@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alIVXHrcjaHhaFQo@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:kas@kernel.org,m:akpm@linux-foundation.org,m:devnexen@gmail.com,m:vbabka@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273470-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,infradead.org,redhat.com,alien8.de,zytor.com,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44CA774435B

On Sat, Jul 11, 2026 at 01:05:16PM +0300, Mike Rapoport wrote:
> On Fri, Jul 10, 2026 at 12:56:40PM +0100, Lorenzo Stoakes wrote:
> > x86 implements page attribute modification using its Change Page
> > Attributes (CPA) mechanism.
> >
> > This tracks properties of ranges such as cache mode through x86 page
> > attributes, and as part of that logic manipulates kernel page tables.
> >
> > Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> > fragmentation") ranges of kernel page table entries can be collapsed into
> > huge page table entries as part of this logic.
> >
> > As part of this collapse, it frees the page tables which the collapsed
> > entries previously pointed to, and it does so without any relevant locks
> > being held to preclude concurrent kernel page table walkers.
> >
> > The only way this code can be reached is if CPA_COLLAPSE is specified, and
> > this is only set in set_memory_rox() via:
> >
> > set_memory_rox()
> > -> change_page_attr_set_clr()
> > -> cpa_flush()
> > -> cpa_collapse_large_pages()
> >
> > Notable users of this are execmem and bpf when manipulating executable
> > mappings.
> >
> > However, this is problematic for ptdump, as it walks ranges it does not own
> > and thus runs the risk of a use-after-free on page tables freed underneath
> > it.
> >
> > This patch resolves the issue by acquiring the mmap read lock on init_mm to
> > provide mutual exclusion against ptdump, which acquires the init_mm write
> > lock.
> >
> > It is safe to acquire a sleeping lock as all the callers invoke
> > set_memory_rox() from process context and in any case,
> > change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> > mutex, disallowing atomic context here.
> >
> > We also include cleanup.h in order to use a scoped_guard() to implement
> > this cleanly.
>
> This is a part of another patch, isn't it?

Yeah, as discussed off-list, I think the easiest way now is for me to resend the
whole thing as a 4 patch series.

I was avoiding this, as it makes the stable stuff tricky and means we end up
with a series with different Fixes tags and some stuff requiring ordering
dependencies and some not, but hopefully Andrew will be forgiving :)

And likely I'll just handle the stable stuff manually, ultimately.

>
> > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo

