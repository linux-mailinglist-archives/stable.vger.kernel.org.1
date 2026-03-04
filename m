Return-Path: <stable+bounces-223079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJHSNBFQqGmztAAAu9opvQ
	(envelope-from <stable+bounces-223079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:30:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF09202B31
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB8330D31B1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738DB332ED3;
	Wed,  4 Mar 2026 15:01:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B0333439
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636519; cv=none; b=cj/13m2S3hm4xbyL0pv4WVAL8AvbKACK6WjwyGbYFbucbnRl56mxylHdg2BxNxQ2dHJLc20EEwA4hT4NNKSinnjkEktwNE6YuF+OYOsYJ7+f27JI/KHOkuEkyIlNYligCsX/fWKAmbi7HjUFO3TAmkCQsivT2Tmc8JS9lbvNEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636519; c=relaxed/simple;
	bh=EWH1i6SWOemPf7qJ7JY1ziADWqrTOUp3/y5W3Ur0MTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUIjuEGroKbH8PvxeAUcdICLTVlbcAyNuHHTZLtoIbqUfVspnXHHAzUIVO3qYu2B7fCrgXgbMk2dstXUX9URHDdiPMcXC6NFD18Ep44nUCow1vsdcBDrlD4qcetQsjwgJZ8gAbS00sTLIKvu8u/F45H/b2s2JJYRegQpKozQffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25B47339;
	Wed,  4 Mar 2026 07:01:50 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EB233F836;
	Wed,  4 Mar 2026 07:01:54 -0800 (PST)
Date: Wed, 4 Mar 2026 15:01:51 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <aahJX0NwtYHy1ILe@arm.com>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <aagUtDTca5d0le2Y@arm.com>
 <20260304134313.GM972761@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134313.GM972761@nvidia.com>
X-Rspamd-Queue-Id: 4EF09202B31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223079-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:43:13AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 11:17:08AM +0000, Catalin Marinas wrote:
> > > @@ -399,13 +416,35 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> > >  	int i;
> > >  
> > >  	/*
> > > -	 * Gather the access/dirty bits for the contiguous range. If nothing has
> > > -	 * changed, its a noop.
> > > +	 * Check whether all sub-PTEs in the CONT block already have the
> > > +	 * requested access flags, using raw per-PTE values rather than the
> > > +	 * gathered ptep_get() view.
> > > +	 *
> > > +	 * ptep_get() gathers AF/dirty state across the whole CONT block,
> > > +	 * which is correct for CPU TLB semantics: with FEAT_HAFDBS the
> > > +	 * hardware may set AF/dirty on any sub-PTE and the CPU TLB treats
> > > +	 * the gathered result as authoritative for the entire range. But an
> > > +	 * SMMU without HTTU (or with HA/HD disabled in CD.TCR) evaluates
> > > +	 * each descriptor individually and will keep faulting on the target
> > > +	 * sub-PTE if its flags haven't actually been updated. Gathering can
> > > +	 * therefore cause false no-ops when only a sibling has been updated:
> > > +	 *  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
> > > +	 *  - read faults:  target still lacks PTE_AF
> > > +	 *
> > > +	 * Per Arm ARM (DDI 0487) D8.7.1, any sub-PTE in a CONT range may
> > > +	 * become the effective cached translation, so all entries must have
> > > +	 * consistent attributes. Check the full CONT block before returning
> > > +	 * no-op, and when any sub-PTE mismatches, proceed to update the whole
> > > +	 * range.
> > >  	 */
> > > -	orig_pte = pte_mknoncont(ptep_get(ptep));
> > > -	if (pte_val(orig_pte) == pte_val(entry))
> > > +	if (contpte_all_subptes_match_access_flags(ptep, entry))
> > >  		return 0;
> > 
> > Actually, do we need to loop over all the ptes? I think it sufficient to
> > only check the one at ptep since it is the one that triggered the
> > fault.
> 
> With CONT we should not be thinking "the one that triggered the
> fault".
> 
> The PTE that triggered the fault is the PTE that the HW happened to
> load into the TLB, we cannot assume it is the sub PTE we are faulting
> at. For instance it could be a sub PTE for a completely unrelated
> access at a different VA that got cached.

Good point. For the AF bit, the hardware is not allowed to cache it in
the TLB, so we can't get an AF fault for an unrelated VA nearby. We can,
however, for the dirty bit since PTE_RDONLY is allowed to be cached in
the TLB.

> Again, the requirement here is that a fault on a CONT PTE must fix all
> the access flags to be consistent or fail. It cannot resume the fault
> and leave the sub PTEs inconsistent as the HW is always allowed to
> load the RDONLY one for any access to the CONT.

It should fix all of them to be consistent if it got a fault. I was
wondering whether we can simplify this with a single pte read (but still
setting all in the range). It only works for the AF bit, not dirty. We
could add a check if it makes things slightly faster on this path.

Now I also wonder if the `pte_write(orig_pte) == pte_write(entry)` check
to elide BBM is still valid if we have hardware that does not support
DBM. I need to dig some more into the Arm ARM.

-- 
Catalin

