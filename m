Return-Path: <stable+bounces-273466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M/U5HY1UU2qBZwMAu9opvQ
	(envelope-from <stable+bounces-273466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 10:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B174430A
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 10:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iKyVeFHG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273466-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273466-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BF7300F9EF
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41339656D;
	Sun, 12 Jul 2026 08:47:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4203955F8;
	Sun, 12 Jul 2026 08:47:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846022; cv=none; b=ZwcKE6puBxG2sIlo02SroPc4Po+gs28x2t5f72vJzoVYJfrzO0AxBk+As7YI/3WfVJsQJsJmxy/DdFQhvhhIvjZhYfRmTEE9949VdlbW+jH3tpwpqxO+NM/cal56QaQfYZTwQZsQLzPJI9kAkl6QpfyzMhu12Pax+0d0B0aUZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846022; c=relaxed/simple;
	bh=gc4Rmw/43qJCUFGZ6Ihb5AJTh7/DrcNwPguKJZusrl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuFhjo15qwDrxlYv4DTpgXKVJMo1xeWRZp7xUij2vposZHWJIaSQyvgLXxZ7O9hDaM2WYDMhpzUmRUDkkYZmxVEVb8h12cBdJvhkNTvoveo8gLnJ7eQm2iGJm3AeYyy9wjRoQELwuoBtZJ7TOKM9AYCwG4fyxVMtIXh4z5hpWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKyVeFHG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1A11F000E9;
	Sun, 12 Jul 2026 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783846020;
	bh=a1MWMA2QpYLFA5dD8C1zSTBdj0Wi20F5ZHok0IusreE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iKyVeFHGvqpi5tvmPTHPGcreoOC16jFVlSlDQXyYi1SCf5+0SfRuCjhBLrtFM2O2E
	 Sa0v5LZE7DyioTyLKUVTV5xpuHU12CrnsE8VkvmroSCZVXbH7nHLSyvjrCtxKPnv/z
	 Y0MomN8W5qRajdgD75Nm5Y0y+SDxuZ7BhuHzfh+iIKASoU1MpzDx6Ji2cOS8GsP3B7
	 kWCzpq8KN5YDpVRLQCgeW365JEGzXC1Ug07LOuiykc8/M4NK86NnLflZTf2py2PjGJ
	 CE/CA22uUsHHViqNcQniCekI4IYsZsZKMcbCc316PdzRyI5MLnEKNyvWJ09tVCbrw9
	 MYXy2UhrgakUQ==
Date: Sun, 12 Jul 2026 09:46:46 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Message-ID: <alNQccqtx5-QApup@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dev.jain@arm.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:devnexen@gmail.com,m:ryan.roberts@arm.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273466-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA3B174430A

On Sun, Jul 12, 2026 at 12:50:08PM +0530, Dev Jain wrote:
> Will Deacon had pushed back on a similar approach:
> https://lore.kernel.org/all/20250530123527.GA30463@willie-the-truck/
>
> Although now when I read back that thread, it feels more so like my
> incompetency to convince :) because:

No haha not so, I think more like this stuff is fiddly.

>
> 1. I don't think this pmd_free_pte_page() path is a hot path at all

Right, and we don't actually alter that path anyway

>
> 2. We are doing a try lock which is almost guaranteed to succeed,
>    so it's not like we are losing out on block mappings

Also it's specifically only on when vmap tries to make a mapping huge, and
this path is being inconsistent with a convention that already existed - if
you manipulate kernel page table mappings that can interact with other page
table walkers, you have to take the init_mm mmap lock.

>
> 3. Any overhead from the try lock will get dominated by the pgtable
>    page free/TLB flush

Yup.

>
> I guess you did not take the RCU approach because that would put code
> into the generic kernel pgtable freeing path.

Well a number of reasons:

* firstly yes it makes the code path always RCU only to suit a specific
  debug user as you say :)

* Importantly - we risk genuine RCU stall issues, because the ptdump then
  has to be RCU too over vast ranges.

  To work around that you have to shard the ptdump walk, make an assumption
  all callbacks are RCU-safe, and that the sharding suffices to avoid these
  stalls.

  It's a ton of complexity and assumptions to account for... vmalloc doing
  the wrong thing.

* It is an established precedent that we mmap lock init_mm for kernel page
  table walking as per mm/pagewalk.c. It'd require significant rework there
  and would disallow any future walkers like this if we were to require
  RCU.

* The mmap lock approach is simple, safe, and as you say is only actually
  required in code paths that manipulate page tables and thus are already
  not hotpaths.

* If there's future work to free vmalloc page tables upon vunmap()
  (currently it does not), we have a stable, established basis for doing so
  that again puts the weight of the work on the operation being performed
  rather than anything else.

>
> I liked the RCU approach because I hate the fact that ptdump takes
> an mmap_write_lock when it is literally only reading the pgtables.

Well you have to do that for the userland side, because there could be a
concurrent downgraded mmap read lock during an munmap, and the same goes
for non-VMA kernel ranges too, so it would have to keep doing that
regardless.

> But your approach is simpler and fixes the problem at the particular spot
> and not hammers the fix into a generic path. So overall, ACK.

Thanks!

>
>
> > Lorenzo Stoakes (2):
> >       mm/vmalloc: acquire init_mm read lock on huge vmap promotion
> >       Revert "arm64: Enable vmalloc-huge with ptdump"
> >
> >  arch/arm64/include/asm/ptdump.h |  2 --
> >  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
> >  arch/arm64/mm/ptdump.c          | 11 ++---------
> >  include/linux/mmap_lock.h       |  1 +
> >  mm/pagewalk.c                   | 22 +++++++++++----------
> >  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
> >  6 files changed, 51 insertions(+), 69 deletions(-)
> > ---
> > base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> > change-id: 20260710-series-vmap-race-fix-2a4cac988938
> >
> > Cheers,
>

Cheers, Lorenzo

