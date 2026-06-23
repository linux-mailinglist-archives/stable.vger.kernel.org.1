Return-Path: <stable+bounces-267954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ezL7FX+XOmoKBAgAu9opvQ
	(envelope-from <stable+bounces-267954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:26:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF66B7DD9
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:26:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dEOl01gs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267954-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267954-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D00C3046E2A
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9173C0A12;
	Tue, 23 Jun 2026 14:25:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCA3C13E2;
	Tue, 23 Jun 2026 14:25:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224737; cv=none; b=fYLOwBbyFq1R+Fi0hRKY6T89NBqHNsUdv1As/HyhdlHIrpI2fb0F+5JpX1iXuGIN5ki22fV3IHVuFSirpZi3Sq+Oik+4lDgZhJp7wFUD8tKsZ8CzOyGwSLNGFOz2Q5h2lr+BpOjiS1A4xPNEgNhMhoS9ZGIs7hxRxTpj8glD6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224737; c=relaxed/simple;
	bh=n6scA6NsyBWDNp2lGGVaZv0cnwu9hylsD8KC/BNkTxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2STdUMQjfKKgRitT0YGC5GfhSjYWThTTLebYFWgGwR8a7PY1U7jBKKyRHayB9P5LTGuIydqjlqu+hqjbBfjcx2g2zdLSmWuVIB743fEQueavP2dowWpPLmKU0dOlQNJu3mc33P08xP9URKM6OGS4MKbqYnmG7GHPqb+Ozjb23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEOl01gs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B3C1F000E9;
	Tue, 23 Jun 2026 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782224735;
	bh=0QUJYWhSEioK+JAt/rckl71sDnr4lEuTQt7CEdx+e3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dEOl01gseLaYw5LEJsqiq7nPWzVvX7ahq/VzUohcNBiL8espLOdZ/6knQJdxJbIkJ
	 OvKmz/HE5v06KqCWRCD1DRbOHiGJwKAqirEZdHQuIh9ICzEHghsRVKSK8TOOEhe6OQ
	 UPKPeHfzw5fT+WucHX0EyyJ5pqHicns8ucgFmKaYH52dMIpTe6raxAIho/5EJyGJEc
	 QhaIZp/FOV3OkclPTANdLJFA9kY8KgVmhhXl2YggRUrKjFeXkKPx3O+4nsvhO8FeAr
	 0qmMSANtBpHNG86K2zv2P3AKPLFgrSnhXi/YoJUQBa9oxwZQ40Jo1y1ht2rTBFVc/B
	 Oqh3Zklq1bTHQ==
Date: Tue, 23 Jun 2026 15:25:30 +0100
From: Will Deacon <will@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@vger.kernel.org>, mark.rutland@arm.com
Subject: Re: [PATCH 6.1 337/522] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
Message-ID: <ajqXWqiAol6Shdd6@willie-the-truck>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145141.584613180@linuxfoundation.org>
 <b0d5836032ce3135bfc473f6bff791306d086925.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d5836032ce3135bfc473f6bff791306d086925.camel@decadent.org.uk>
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
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:david@kernel.org,m:ryan.roberts@arm.com,m:patches@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:mark.rutland@arm.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[will@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267954-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arm.com:email,willie-the-truck:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0CF66B7DD9

On Sun, Jun 21, 2026 at 05:02:27PM +0200, Ben Hutchings wrote:
> On Tue, 2026-06-16 at 20:28 +0530, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Anshuman Khandual <anshuman.khandual@arm.com>
> > 
> > [ Upstream commit 48478b9f791376b4b89018d7afdfd06865498f65 ]
> [...]
> > @@ -949,15 +953,14 @@ static void unmap_hotplug_pmd_range(pud_
> >  		WARN_ON(!pmd_present(pmd));
> >  		if (pmd_sect(pmd)) {
> >  			pmd_clear(pmdp);
> > -
> > -			/*
> > -			 * One TLBI should be sufficient here as the PMD_SIZE
> > -			 * range is mapped with a single block entry.
> > -			 */
> > -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > -			if (free_mapped)
> > +			if (free_mapped) {
> > +				/* CONT blocks are not supported in the vmemmap */
> > +				WARN_ON(pmd_cont(pmd));
> > +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> 
> It wasn't clear to me from the commit message why this now adds PMD_SIZE
> rather than PAGE_SIZE.  It seems like this change is fine for Linux
> 6.13+ with a CPU that supports TLB range flushing, but otherwise results
> in unnecessarily executing multiple TLB invalidations at intervals of
> the base page size.

Hmm, the commit message also makes very little sense to me and so I don't
understand why this patch has us doing multiple TLB invalidations when
we run into a !cont, block mapping at the PMD level. The old comment
(which this patch removes) should still apply afaict.

Anshuman, Ryan, any ideas what's going on here?

Will

