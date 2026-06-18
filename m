Return-Path: <stable+bounces-267136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id goATBT/2M2psJwYAu9opvQ
	(envelope-from <stable+bounces-267136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:44:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A656A0AC7
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267136-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267136-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4AEB301CFEF
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F23E5A18;
	Thu, 18 Jun 2026 13:43:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35053D6CAA;
	Thu, 18 Jun 2026 13:43:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790232; cv=none; b=hmg8xMOtNmq2Ep51uIIaARSLtOoijk+0r3ORAvHpaQldv4hNx47cvroBu7oBJRzAlA5h6vkJhs+cIQZmEoUXRJHjw5NUgyXiEWfsHEZg1OrUtsOo4fDb2+t9imu2ICIM4btMNSgx5TZ84PYZJFR9vd3DKx7r/MKvm7U96N3rV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790232; c=relaxed/simple;
	bh=XKUehf4X8nwF3CflU///ls6TmM0Kev/2DLg5AaWT2N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG4yZ7f+Bczef3snwqHXEUi9U9PDYNp8Bc0v27Fx61PYgxNqJvsOfYd4+MWM0wMm3Unq03gUaueHN9R2Tr+ZgMQ3zoGh5I9YJVcgjJlALMMrJowJ0vzm9o+Ip4U8W5b+ka3506cFIbsxZ/dNMjTHurjY2+jWlK301heWgsiyU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 033C668BEB; Thu, 18 Jun 2026 15:43:46 +0200 (CEST)
Date: Thu, 18 Jun 2026 15:43:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev, axboe@kernel.dk, brauner@kernel.org,
	djwong@kernel.org, viro@zeniv.linux.org.uk, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] block: validate user space vectors during
 extraction
Message-ID: <20260618134346.GA2752@lst.de>
References: <20260617233235.1016063-1-kbusch@meta.com> <20260617233235.1016063-2-kbusch@meta.com> <20260618102627.GA23200@lst.de> <ajPv7yOoYsR5O6kf@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajPv7yOoYsR5O6kf@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267136-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kbusch@kernel.org,m:hch@lst.de,m:kbusch@meta.com,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:axboe@kernel.dk,m:brauner@kernel.org,m:djwong@kernel.org,m:viro@zeniv.linux.org.uk,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A656A0AC7

On Thu, Jun 18, 2026 at 07:17:35AM -0600, Keith Busch wrote:
> > >  	if (iov_iter_is_bvec(iter)) {
> > >  		bio_iov_bvec_set(bio, iter);
> > > +
> > > +		if (mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> > > +							vec_align_mask)
> > > +			return -EINVAL;
> > 
> > Can you add a comment here?  Especially as the bvec iter doesn't actually
> > require all individual bvecs to be aligned and I'm not entirely sure this
> > handles all case - writing down the rules might help a bit with that.
> 
> The rationale is that the only iter_bvec users come from io_uring
> registered buffers, which are virtually contiguous.

There's plenty of iov_iter_bdev users, and even without poking deep I
know that two directly passed on bvecs from block-layer generated bios to
the underlying file system's direct I/O code: loop and zloop.

So we need rules on what can be passed, and preferably some way to
enforce that at least for debug builds.


