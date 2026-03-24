Return-Path: <stable+bounces-230157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBuEFFyOwmnDewQAu9opvQ
	(envelope-from <stable+bounces-230157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:15:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196243091E1
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B43FC307FB2A
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021273E0C41;
	Tue, 24 Mar 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNYKshda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D83C65E8;
	Tue, 24 Mar 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357570; cv=none; b=FbG/WQSUGhOQZslqa4INy3zm8fV5EukxTfZGh2rSWiNpCR4hHj685202J8R1wkcJwP8/cCBYe1yh0YYiTsOLlAp+p3EgQiyKr5atVjSyg+cWsKmUQRtzAFdeIFcIIZQC0nP9ja22FGhdx9ILRiRIiSOW88GZ3aFp1c/QpIs3oK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357570; c=relaxed/simple;
	bh=8rcDyIN+xZZA1K+s4yT22XlRva6FHC9pay+S/RPhlFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXGVncOVGaMNFhxnQ7+9QeSvJF8gMUzxbBS8sxaSrT1MmZkWHN6bGoP5nKuh+8PG2Dtw+30gncrJocQ1PAhI5g9jMgNCHv7y6eYww+tJc4DRKX/QrYXPh42usp10S/H/KnW5q5g1YEGO3GfML642yy4pWV6vc0D7R7R1pUpV+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNYKshda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A834C19424;
	Tue, 24 Mar 2026 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774357570;
	bh=8rcDyIN+xZZA1K+s4yT22XlRva6FHC9pay+S/RPhlFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNYKshdaujlpEtGHRAtBqhXsY7aOrmrWGQYTcL9os8Ursdw25aQt3PQ/eI4LMIexF
	 4Wi2AXrlo8oRqIuqMb6uNLDS65KMGaWBSi9Miqcwxj0EtouNnxEm3qCnhA8oqc0DX8
	 WP84lR5B7GbjdP/VkDuT63LwSYH3VLKkyPK/ILUz9x9QmyaCSnqbXKnU1R3KUIsbha
	 t0crLSoIAScUivK/IGeRMM3eYJzH+/uLJyb2BTDPvXJ8SsA+Fk6wcaExXFT5djpue6
	 134Chwad+ilrXP3ZG0WH2lfW45g+wL+FtsrAwIqpkLZzZXHNuIRCJjXdE9LfMJmaTL
	 8vW+Of+IUlRLw==
Date: Tue, 24 Mar 2026 13:06:04 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	linux-mm@kvack.org, Alex Williamson <alex@shazbot.org>, 
	Max Boone <mboone@akamai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
Message-ID: <132009fb-70d4-4e3e-98a9-fcc230dd282e@lucifer.local>
References: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
 <b3b78722-c265-484b-acde-3aa4bee0aac7@lucifer.local>
 <43cc2290-10b6-4db3-bfc0-169adb8201b7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43cc2290-10b6-4db3-bfc0-169adb8201b7@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230157-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 196243091E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 01:46:20PM +0100, David Hildenbrand (Arm) wrote:
> On 3/24/26 12:04, Lorenzo Stoakes (Oracle) wrote:
> > On Mon, Mar 23, 2026 at 09:20:18PM +0100, David Hildenbrand (Arm) wrote:
> >> follow_pfnmap_start() suffers from two problems:
> >>
> >> (1) We are not re-fetching the pmd/pud after taking the PTL
> >>
> >> Therefore, we are not properly stabilizing what the lock lock actually
> >> protects. If there is concurrent zapping, we would indicate to the
> >> caller that we found an entry, however, that entry might already have
> >> been invalidated, or contain a different PFN after taking the lock.
> >>
> >> Properly use pmdp_get() / pudp_get() after taking the lock.
> >>
> >> (2) pmd_leaf() / pud_leaf() are not well defined on non-present entries
> >>
> >> pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.
> >>
> >> There is no real guarantee that pmd_leaf()/pud_leaf() returns something
> >> reasonable on non-present entries. Most architectures indeed either
> >> perform a present check or make it work by smart use of flags.
> >
> > It seems huge page split is the main user via pmd_invalidate() ->
> > pmd_mkinvalid().
> >
> > And I guess this is the kind of thing you mean by smart use of flags, for
> > x86-64:
>
> Exactly.
>
> [...]
>
> >
> >>
> >> However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
> >> and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd(). Whereby
> >> pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not
> >> do that.
> >
> > But pmd_present() checks for _PAGE_HUGE in pmd_present(), and if set checks
> > whether one of _PAGE_PRESENT, _PAGE_PROTNONE, _PAGE_PRESENT_INVALID is set,
> > and pmd_mkinvalid() sets _PAGE_PRESENT_INVALID (clearing _PAGE_PRESENT,
> > _VALID, _DIRTY, _PROTNONE) so it'd return true.
>
> pmd_present() will correctly indicate "not present" for, say, a softleaf
> migration entry.
>
> However, pmd_leaf() will indicate "leaf" for a softleaf migration entry.

Right yeah that's true. By definition softleaves are non-present. But as they
are leaves, you'd expect pXX_leaf() to return true.

>
> So not checking pmd_present() will actually treat non-present migration
> entries as present leafs in this function, which is wrong in the context
> of this function.
>
> We're walking present entries where things like pmd_pfn(pmd) etc make sense.

Ack, makes sense, thanks!

>
> >
> > pmd_leaf() simply checks to see if _PAGE_HUGE is set which should be
> > retained on split so should all still have worked?
> >
> > But anyway this is still worthwhile I think.
> >
> >>
> >> Let's check pmd_present()/pud_present() before assuming "the is a
> >> present PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page
> >> table handling code that traverses user page tables does.
> >>
> >> Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP,
> >> (1) is likely more relevant than (2). It is questionable how often (1)
> >> would actually trigger, but let's CC stable to be sure.
> >>
> >> This was found by code inspection.
> >>
> >> Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > This looks correct to me, so:
> >
> > Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> Thanks!
>
> >
> >> ---
> >> Gave it a quick test in a VM with MM selftests etc, but I am not sure if
> >> I actually trigger the follow_pfnmap machinery.
> >> ---
> >>  mm/memory.c | 18 +++++++++++++++---
> >>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 219b9bf6cae0..2921d35c50ae 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -6868,11 +6868,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
> >>
> >>  	pudp = pud_offset(p4dp, address);
> >>  	pud = pudp_get(pudp);
> >> -	if (pud_none(pud))
> >> +	if (!pud_present(pud))
> >>  		goto out;
> >>  	if (pud_leaf(pud)) {
> >>  		lock = pud_lock(mm, pudp);
> >> -		if (!unlikely(pud_leaf(pud))) {
> >> +		pud = pudp_get(pudp);
> >> +
> >> +		if (unlikely(!pud_present(pud))) {
> >> +			spin_unlock(lock);
> >> +			goto out;
> >> +		} else if (unlikely(!pud_leaf(pud))) {
> >
> > Tiny nit, but no need for else here. Sometimes compilers complain about
> > this but not sure if it such pedantry is enabled in default kernel compiler
> > flags :)
>
> You mean
>
> if (unlikely(!pud_present(pud))) {
> 	spin_unlock(lock);
> 	goto out;
> }
> if (...) {
>
> ?
>
> That just creates an additional LOC without any benefit IMHO. And we use
> it all over the place :)

Yeah I think the argument is you don't want to imply that it could somehow _not_
be else. But I think it's the compiler being a wee bit pendatic... :)

>
> In fact, I will beat any C compiler with the C standard that complains
> about that ;)

Haha, I'd like to see that!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

