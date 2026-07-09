Return-Path: <stable+bounces-272802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LyjLwEoT2pqbQIAu9opvQ
	(envelope-from <stable+bounces-272802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 06:48:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4F72C96D
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 06:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272802-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272802-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF50302260D
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 04:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211B2701D9;
	Thu,  9 Jul 2026 04:47:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9B175A75;
	Thu,  9 Jul 2026 04:47:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572464; cv=none; b=gGYEMFNxy7WhvYnqejonctjqAKmx/VUTYdo4ZEcDO1AlCquJb/TEA/1s8lPLP8W6czt8mqCdb41V1uzy41NoZ1fh3e9CbAHobIiw46ZuhuAQXx25kQkhz489YVMeG4FVIPwQJUqiDJQ/k6HzNzj9EC1DkZVxDujbtYKz07qIJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572464; c=relaxed/simple;
	bh=iehbMDj1kl3rIu5tuHr0V0pAjxjo0VZR2OIUuAFWrLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt51Pe6iFoFnwOMhK7EkuAUHuqEgRl+0gOx8PSBsnUSvmLJCq6833O0Y7VW24MrtUcNw/m2hApG2hFasYPxHNPMlKjKzENMvcKvxytAnWMZV2A5Lypr3H3AAM3hdigsVQr5m0z5+JG5K8BLb8XVCZTbqo44ej4CthkiIQyJIswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACEE668BFE; Thu,  9 Jul 2026 06:47:38 +0200 (CEST)
Date: Thu, 9 Jul 2026 06:47:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org, stable@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/6] xfs: don't replace the wrong part of the cow fork
Message-ID: <20260709044738.GA15144@lst.de>
References: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs> <178346726108.1271589.7681324440256265003.stgit@frogsfrogsfrogs> <20260708091220.GA5902@lst.de> <20260708152516.GG9392@frogsfrogsfrogs> <20260708175743.GI9392@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708175743.GI9392@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272802-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41C4F72C96D

On Wed, Jul 08, 2026 at 10:57:43AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 08, 2026 at 08:25:16AM -0700, Darrick J. Wong wrote:
> > On Wed, Jul 08, 2026 at 11:12:20AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 07, 2026 at 10:03:24PM -0700, Darrick J. Wong wrote:
> > > >  static inline void
> > > >  xrep_cow_replace_mapping(
> > > > +	struct xfs_inode	*ip,
> > > > +	struct xfs_iext_cursor	*icur,
> > > > +	struct xfs_bmbt_irec	*got,
> > > > +	struct xfs_bmbt_irec	*rep)
> > > 
> > > This looks like something that should sit in xfs_bmap.c (or at
> > > least xfs_bmap_util.c) and not in random scrub code.
> 
> To push back on this: there's only one user of this, why not keep it
> local to the scrub code?  AFAICT there's nowhere else in xfs that needs
> to replace a subset of an existing cow fork mapping with another
> mapping.

Mostly so that all the code doing hairy operations on subsets of
bmbt_irecs is kept together...


