Return-Path: <stable+bounces-268088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OyDKLf6JO2rRZQgAu9opvQ
	(envelope-from <stable+bounces-268088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:40:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5256BC418
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268088-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268088-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7F03025D39
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 07:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F4322A2E;
	Wed, 24 Jun 2026 07:39:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FF25B091;
	Wed, 24 Jun 2026 07:39:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286747; cv=none; b=iRO6TA0PDw4MxvDSkaB1+fLNWHiSM2tq8rhqUj+jyoDSKZcn+VgA/PBpjwT1883EpJeHy6400NGLXGkc0BdFFuo+kpb20dDhzZgEq+0fU+uRDAQVj3CXQCHWBwej3wLI5iibIYg5baLT8/ERqSp/xuy2z7AFJ7VA5E9FMdaL/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286747; c=relaxed/simple;
	bh=Z4vHZNdWfmXhY08NWu9SAVKC9IY+kynM7MA+zCAUIZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOSNl0lS/c9dSqBc879RQFTjqoqOjXIy9liWQytAchmiTG/V8t4/B3R/1q0boOD4LMqzQPs7vjWwBk3B2Y1HJkSawnUrhvBF5+1qReWkop5HGD+2PRMnWDxRFq4ysyjkVv6J4Dc4uPlcQeood/rSBrJ18Vegm8wOISzZTRubJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 300DA68BEB; Wed, 24 Jun 2026 09:39:02 +0200 (CEST)
Date: Wed, 24 Jun 2026 09:39:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev, axboe@kernel.dk, brauner@kernel.org,
	djwong@kernel.org, viro@zeniv.linux.org.uk, stable@vger.kernel.org
Subject: Re: [PATCHv2 6/6] block: validate user space vectors during
 extraction
Message-ID: <20260624073901.GA12649@lst.de>
References: <20260622174241.2299563-1-kbusch@meta.com> <20260622174241.2299563-7-kbusch@meta.com> <20260623151021.GA14919@lst.de> <ajqxoeZ0R_RwqEKe@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqxoeZ0R_RwqEKe@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268088-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kbusch@kernel.org,m:hch@lst.de,m:kbusch@meta.com,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:axboe@kernel.dk,m:brauner@kernel.org,m:djwong@kernel.org,m:viro@zeniv.linux.org.uk,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F5256BC418

On Tue, Jun 23, 2026 at 10:17:37AM -0600, Keith Busch wrote:
> Exactly, the in-kernel users of ITER_BVEC that allocate their own
> buffers are, as far as I know, aligned already. Fabric storage targets
> like nvme allocate their own SGLs on page boundaries so the bio is
> aligned at the point it was constructed.
> 
> The ones that forward user buffers like loop and zloop are addressed in
> the previous two patches. They generally should have been fine for most
> hardware without those updates, but they're included in case a backing
> device has more restrictive constraints than 512b "sector_t" aligned.
> 
> The only other user space provided alignment that I think may trip this
> up is the io_uring registered buffer, so that's what I'm trying to call
> out here.

Sounds reasonable, but it would be really helpful to have this in
the API documentation somewhere..

Talking about documented APIs and related bits:  do you still plan
to get back to exposing our pre-vector alignment requirements and
add tests to blktests/xfstests based on that?

