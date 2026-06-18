Return-Path: <stable+bounces-267048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kyjfBNWtM2rxEwYAu9opvQ
	(envelope-from <stable+bounces-267048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:35:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 660E769E7CC
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:35:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YM57K2za;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267048-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267048-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EDBE3038163
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D413B1EC0;
	Thu, 18 Jun 2026 08:34:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706863B19AC;
	Thu, 18 Jun 2026 08:34:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771654; cv=none; b=WhTEXLifHoJ/7RsEZl304CX0ydt3ITab3E46JVtgbS2VWIaodbd8ZI/Qm2Ks11fpNamZJbSvwiAZD+FCqSQnwbCcHRrYl4nOW75aMAWK1m/jInFg+oeCiUqJRqmpHoOHmW7KmlJYsg/zSA1vs+E5eZN1R6r40R1nnSVred0KRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771654; c=relaxed/simple;
	bh=jezyeuQMv93oGNybyWc8x5xshbJ7G+UGosXMEBGPnNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkM9KFyEOPBlRsNLRLCnvluvkSEQcD0EVS3tkzode10d9Oy10KBBJTS2wqagYsA9hDZlITVkDFoXAYaAwfMVA8UHPPA2EKFW1GdQsWwHxo651tk31M4MV5nQQq59iRWxf6EUJWXwY72JNepl0zm1QDP8+zonbe70rVKbFWGiAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM57K2za; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96471F000E9;
	Thu, 18 Jun 2026 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771651;
	bh=SB6+ZWqOYOVD8J6Bm8SL4mIshI5oOydkw8DYdXdWOWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YM57K2za+CC6RytagmjmCqXnGQc+SkdnKMBuOZwnO2NqsfRcfFEpbGzEn72iCkPg7
	 Adu28iwlNOIklDbu/PZI1NjZFE2MY/VVPalsuFkVouPiL9IY8E7E0rGoOGeHei/Rnp
	 YA0W3poKHIA6DCrOmWDA37W/6mQ6Di08BvfNXJuagpMB9PVY0I2cIR9kKo0trJy20Z
	 2eHZLmiFXByxMoz2YPVv4mXkjmjCA35cnnAvKV8gxesoW/n2n1njTLodZfUhP9hZ96
	 uFJm7n0ajHBoYrRdjyJ3qv/dH65lDSVgOM16OoKUwWqjw2BVqsN/vSjy1h8PEK4v0m
	 /I3p8zP71uT4g==
Date: Thu, 18 Jun 2026 11:34:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <ajOtfdGgFQYL-T6f@kernel.org>
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267048-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:akpm@linux-foundation.org,m:torvalds@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:oleg@redhat.com,m:peterx@redhat.com,m:vladimirelitokarev@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,redhat.com,gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 660E769E7CC

On Thu, Jun 18, 2026 at 10:19:17AM +0200, David Hildenbrand (Arm) wrote:
> On 6/17/26 21:40, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Vova Tokarev says:
> > 
> >   userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
> >   access, you can register on the shadow stack, discard a page ... and
> >   inject a page with chosen return addresses via UFFDIO_COPY.
> > 
> > Update vma_can_userfault() to reject VM_SHADOW_STACK.
> > 
> > While on it, also reject VM_IO, VM_MIXEDMAP and VM_PFNMAP so that if a
> > driver would implement vm_uffd_ops, it wouldn't be possible to register
> > special VMAs with userfaultfd.
> > 
> > Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
> > Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  mm/userfaultfd.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 246af12bf801..b8d2d87ce8d7 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -2111,7 +2111,8 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
> >  {
> >  	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
> >  
> > -	if (vma->vm_flags & VM_DROPPABLE)
> > +	if (vma->vm_flags & (VM_DROPPABLE | VM_IO | VM_MIXEDMAP | VM_PFNMAP |
> > +			     VM_SHADOW_STACK))
> 
> I'm sure you considered VM_SPECIAL, which additionally includes VM_DONTEXPAND.
> 
> Would that be better, or what was the reason to allow VM_DONTEXPAND?

By itself VM_DONTEXPAND won't matter, as uffd can't resize a VMA.
But thinking more about it, it's better to make vma_can_userfault() more
restrictive and just use VM_SPECIAL.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.

