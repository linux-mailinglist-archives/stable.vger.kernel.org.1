Return-Path: <stable+bounces-271716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tW7PFxGMR2qbawAAu9opvQ
	(envelope-from <stable+bounces-271716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 12:16:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13499701178
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 12:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FX8knPJ1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271716-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271716-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A6F8306E665
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1873C9897;
	Fri,  3 Jul 2026 10:11:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0C3CA4A8;
	Fri,  3 Jul 2026 10:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073484; cv=none; b=DbffK7sCr0RRhQjtUjFXXUS2bDRmwUWdgzzvPfx7qkXnWVBYgo8A6wgcGMX22SzSG3B9rk8xP/5AdcSMMSmosGlofZIFBhNfPNN0M5FNDNQBH9h8bmfJu9axpiT6LJtwen+Sik7B6VFZa/+0sEswVgTFTvgI+Na19aEwyD2W4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073484; c=relaxed/simple;
	bh=b4hYj2h/GhcNDFdQP2e6SniBNHILfaXznTlR7gIGm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JON8smxSmymt1oyL3hIJuacbOANNg+h2z0q0JYMrON4t6yDz/e3XKS02Up3yUIruwQakGVHqCiEc3yJVpHPHebU5AJdKVnZL3T1uisHZfHXEwCJUxvtGtXn2uQY5v7VYNFZrRvsRz0PvACbG6uVjy1E7uXc8Z8zG+hcXcYpkBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX8knPJ1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF6C1F000E9;
	Fri,  3 Jul 2026 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783073481;
	bh=GJdBsz/cwfU4w/JyuRZpMKJIVMU41Xt4kzF57y9GFnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FX8knPJ1LaHX9Ho0qJKmvnxjo+Igu6cLNBzpWbLKrTEFe3vezWGNR1UM5VbpFrxW5
	 1e3cn7biJterKSZn1/Hui8CaIMJNtkh/ZvZf9PZxHVp0OKwDNTAYlCHjcrh+uRwsB7
	 dfeAb5PrdA6ukCZt968+3smf2GmBpDBbBCFkN9tQaIgI8x0h4RBxwPPkOUikGqwLTU
	 onL3GS4uIWzo8CU4MvhXzbPP/KCXvLPb+eDG1LpllpwI81W5whFjp8GzEAd9NeGS9P
	 GKshtCatVRRc0iWmQB76a4EUwxrXNw3bJ4GI3RPG0HXjMwg/q9mRMIJ8rrxSmc1Uhh
	 vIMQxnKU6vc7A==
Date: Fri, 3 Jul 2026 11:11:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>, 
	vova tokarev <vladimirelitokarev@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <akeJdxdZXAFb8XCr@lucifer>
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
 <ajOtfdGgFQYL-T6f@kernel.org>
 <ajOvwGs5xhnfBu-k@kernel.org>
 <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
 <ajO4sLq2UBciSgOn@kernel.org>
 <dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>
 <ajO7yI541hphWRb8@kernel.org>
 <11bae87d-73e6-4946-a41f-c5542fb40b75@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bae87d-73e6-4946-a41f-c5542fb40b75@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:rppt@kernel.org,m:akpm@linux-foundation.org,m:torvalds@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:oleg@redhat.com,m:peterx@redhat.com,m:vladimirelitokarev@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271716-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,redhat.com,gmail.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13499701178

On Thu, Jun 18, 2026 at 11:37:10AM +0200, David Hildenbrand (Arm) wrote:
> On 6/18/26 11:35, Mike Rapoport wrote:
> > On Thu, Jun 18, 2026 at 11:25:31AM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/18/26 11:21, Mike Rapoport wrote:
> >>>
> >>> Cleaner in what sense?
> >>> Will be uglier for sure, just take a look at vma_can_userfault().
> >>
> >> I was thinking of this:
> >>
> >> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >> index 180bad42fc79..8a6803618a91 100644
> >> --- a/mm/userfaultfd.c
> >> +++ b/mm/userfaultfd.c
> >> @@ -2029,7 +2029,10 @@ bool vma_can_userfault(struct vm_area_struct *vma,
> >> vm_flags_t vm_flags,
> >>  {
> >>         const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
> >>
> >> -       if (vma->vm_flags & VM_DROPPABLE)
> >> +       if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
> >> +               return false;
> >> +
> >> +       if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
> >>                 return false;

This is still pretty gross, and it's a bit odd to me that we will now enforce
userfaultfd on ranges that are somehow VMA_DONTEXPAND_BIT but not otherwise
'special'.

But I think that's because we even allow that to exist as a thing and have made
VMA_DONTEXPAND_BIT a little unclear in its behaviour.

But I'm fixing that, I'm working on a series that clears up the special flags,
and replaces the checks in general with vma_xxx() or vma_flags_xxx() predicated,
and which will ultimatately drop VM_SPECIAL/VMA_SPECIAL_FLAGS.

> >
> > In a way that's an extra check for hugetlb, but it will work.
>
> My point would be that we exclude all special VMAs, except hugetlb (which is
> special but supported ... in its special way).

Mike - you said you were respinning, it'd help my series if you respan the above
quickly so I could base my change on that :).

I can send a quick patch if you're tied up also!

>
> --
> Cheers,
>
> David
>

Thanks, Lorenzo

