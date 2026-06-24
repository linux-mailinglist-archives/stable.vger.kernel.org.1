Return-Path: <stable+bounces-268193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wux2MigGPGogiwgAu9opvQ
	(envelope-from <stable+bounces-268193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D396BFFAC
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="od2yYyf/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268193-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268193-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97FA6300A26D
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E628B30596F;
	Wed, 24 Jun 2026 16:30:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534230ACEE;
	Wed, 24 Jun 2026 16:30:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318613; cv=none; b=SNoiFlB2FOLP+M1q49g9M7dlBKnlMbNuiCVYWcJMYHR6X/fGZTgLKB5Me8D5dL5P0GO4SaELwUQJNImJQfIZQKrQSlq5Ae7RFtjWqehSEdD4CYW0BcBtAK5/XgZtmfAc5jA5MUhxJI0WlW51zXiDSITMxqic4iad2filYTSgLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318613; c=relaxed/simple;
	bh=/To/JJJKIU3LIEbSv13kJAVPlpEl3xbd49hOg9zjcVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS/BHXnoKGI0O5ottBJ9zYSC0iSNzYKHfSQu5vhA6HFvdkhcI2ntN87vhSDIUIAXKrFPwyvp85M1EtsxkhjlaYSW9HyL5Z4WAO13YTvTr4GNFELCZ/fMpjABTN8uEAdYgvgHfiOzQaa7OAMj/7RGWaecs5n3rsMM1MMn2G95NFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=od2yYyf/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939161F00AC4;
	Wed, 24 Jun 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782318612;
	bh=mbyuAlSoRh47aaPkX7JF2oGMTEIdF1Zcr15uiIt8usA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=od2yYyf/sl8pz4IJPQDnQOrhYkXrpXNEKFtjPgBBO8QmuXmuUJUW1LX14FDxlYUHS
	 Kw2kXlsRYdoRkjieZwt375+G5/EYfc5MLvG0MXBfetqiJGWAU7reZ5yiJUSXhZyrRO
	 V9QwT7TTke2/Ucc705VGL2T6GpiWzVWpsj62SWyo=
Date: Wed, 24 Jun 2026 17:29:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>, mark.rutland@arm.com
Subject: Re: [PATCH 6.1 337/522] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
Message-ID: <2026062451-bluff-coherent-672d@gregkh>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145141.584613180@linuxfoundation.org>
 <b0d5836032ce3135bfc473f6bff791306d086925.camel@decadent.org.uk>
 <ajqXWqiAol6Shdd6@willie-the-truck>
 <d2a633c8-496e-48e1-bfa0-a0fc75bd0a08@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a633c8-496e-48e1-bfa0-a0fc75bd0a08@arm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268193-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:ryan.roberts@arm.com,m:will@kernel.org,m:ben@decadent.org.uk,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:david@kernel.org,m:patches@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:mark.rutland@arm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2D396BFFAC

On Wed, Jun 24, 2026 at 04:05:01PM +0100, Ryan Roberts wrote:
> On 23/06/2026 15:25, Will Deacon wrote:
> > On Sun, Jun 21, 2026 at 05:02:27PM +0200, Ben Hutchings wrote:
> >> On Tue, 2026-06-16 at 20:28 +0530, Greg Kroah-Hartman wrote:
> >>> 6.1-stable review patch.  If anyone has any objections, please let me know.
> >>>
> >>> ------------------
> >>>
> >>> From: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>
> >>> [ Upstream commit 48478b9f791376b4b89018d7afdfd06865498f65 ]
> >> [...]
> >>> @@ -949,15 +953,14 @@ static void unmap_hotplug_pmd_range(pud_
> >>>  		WARN_ON(!pmd_present(pmd));
> >>>  		if (pmd_sect(pmd)) {
> >>>  			pmd_clear(pmdp);
> >>> -
> >>> -			/*
> >>> -			 * One TLBI should be sufficient here as the PMD_SIZE
> >>> -			 * range is mapped with a single block entry.
> >>> -			 */
> >>> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >>> -			if (free_mapped)
> >>> +			if (free_mapped) {
> >>> +				/* CONT blocks are not supported in the vmemmap */
> >>> +				WARN_ON(pmd_cont(pmd));
> >>> +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> >>
> >> It wasn't clear to me from the commit message why this now adds PMD_SIZE
> >> rather than PAGE_SIZE.  It seems like this change is fine for Linux
> >> 6.13+ with a CPU that supports TLB range flushing, but otherwise results
> >> in unnecessarily executing multiple TLB invalidations at intervals of
> >> the base page size.
> > 
> > Hmm, the commit message also makes very little sense to me and so I don't
> > understand why this patch has us doing multiple TLB invalidations when
> > we run into a !cont, block mapping at the PMD level. The old comment
> > (which this patch removes) should still apply afaict.
> > 
> > Anshuman, Ryan, any ideas what's going on here?
> 
> I think this change was probably my fault; Given the API is called
> flush_tlb_kernel_range() it seemed like an abuse/hack to pretend we are only
> flushing the first PAGE_SIZE of the range. But as I understand it, even if the
> HW shatters a block mapping into multiple TLB entries, all of the entries
> relating to the block mapping will be invalidated if just one of them intersects
> the TLBI range/address. So it should be safe to reapply this hack.
> 
> Although ideally I think it would be better if this API took a stride argument;
> then intent is clear.
> 
> What's the best way to handle this? Submit a patch for mainline that reverts
> this part, then get it backported to stable (implying this current patch will
> have been applied to stable)?

yes, that's probably the best way.

thanks,

greg k-h

