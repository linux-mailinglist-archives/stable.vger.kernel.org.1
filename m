Return-Path: <stable+bounces-267141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cySrGOn4M2rfJwYAu9opvQ
	(envelope-from <stable+bounces-267141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD996A0BCE
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:55:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MMekl4mC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267141-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267141-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E9D3070F31
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCA3B42E5;
	Thu, 18 Jun 2026 13:51:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BD31E848;
	Thu, 18 Jun 2026 13:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790664; cv=none; b=J6II0eI1ZRRNvb2/8dZexRMaWp2JabJFgFWeh3wr5OA9TPQ31fCfj7riKjGPcey6Vfic/36Vks9VCTbUpmW/EZh2ZSyq5zcFnQm+f+CHk3vZpRQ31UiZ5u8IqrI601FJsO65WxH4Nijni8avxVDjKkv+rPWBAybJW8j+/pnfw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790664; c=relaxed/simple;
	bh=pKc6SS8uAML39Ppryw70MR5Sdxt0EKip0fAphJGYqkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA9yAEdkiJEWY+aZhGVJ4I3d2mvX3AbseZHKfiqjT0KBCs3yRhxfw0vO3oTSfej+AsGoZn/dHO5ubjFeFttJzR6qJb4DpK8MjZVsUUkFeYundUPRbsZx91YmzrxQ90/TS4rlIJ7pxjAVkCGBoeoA0uV+IYBaReUYT/FG7My9f5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMekl4mC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD321F000E9;
	Thu, 18 Jun 2026 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781790662;
	bh=x2xVP5fN8sggM5zWCK8BYn27nm4LN3XasYt1gta5ioA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMekl4mCDwd1ZP5MduDsQ+HPBE9bgxpj+rsYWwUijGYCTmCZtQF0JQaavtmjzw0zl
	 hNYSYWMOTfDLD4g4ZTJ9+nxAbPqwtqtHUI9z0wUUtXW9ZiciaQLdZjchkCvwuOfmV6
	 jcKl3h/bLQv7BV0awzjniuDU9EH++GtyV4vve4bRvZQMajZPM7DS/VwPGV5vzJchBp
	 Dopsxzc0XLOdUH9uAWLEjP3ZyFfeSibd3IZCtd5lbCPUfo6xTTy9l8+yy5WVnqpT5+
	 L0PXSfYa2nTYZqmhQmJjFz2B+EUFq7WLaeVEJBGgeka6kcbsZycRbTfozTSBzQPsXu
	 l+6ZJC0YKwSXw==
Date: Thu, 18 Jun 2026 07:51:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev,
	axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] block: validate user space vectors during extraction
Message-ID: <ajP3xZOlaMVz3VUr@kbusch-mbp>
References: <20260617233235.1016063-1-kbusch@meta.com>
 <20260617233235.1016063-2-kbusch@meta.com>
 <20260618102627.GA23200@lst.de>
 <ajPv7yOoYsR5O6kf@kbusch-mbp>
 <20260618134346.GA2752@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618134346.GA2752@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:kbusch@meta.com,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:axboe@kernel.dk,m:brauner@kernel.org,m:djwong@kernel.org,m:viro@zeniv.linux.org.uk,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267141-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kbusch-mbp:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECD996A0BCE

On Thu, Jun 18, 2026 at 03:43:46PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 18, 2026 at 07:17:35AM -0600, Keith Busch wrote:
> > > >  	if (iov_iter_is_bvec(iter)) {
> > > >  		bio_iov_bvec_set(bio, iter);
> > > > +
> > > > +		if (mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> > > > +							vec_align_mask)
> > > > +			return -EINVAL;
> > > 
> > > Can you add a comment here?  Especially as the bvec iter doesn't actually
> > > require all individual bvecs to be aligned and I'm not entirely sure this
> > > handles all case - writing down the rules might help a bit with that.
> > 
> > The rationale is that the only iter_bvec users come from io_uring
> > registered buffers, which are virtually contiguous.
> 
> There's plenty of iov_iter_bdev users, and even without poking deep I
> know that two directly passed on bvecs from block-layer generated bios to
> the underlying file system's direct I/O code: loop and zloop.

Oh, I meant only users that go through this direct-io path, but you're
right, I was wrong about that too. The nvme target file backend can also
get here in addition to what you pointed out.
 
> So we need rules on what can be passed, and preferably some way to
> enforce that at least for debug builds.

Yeah.

