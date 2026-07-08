Return-Path: <stable+bounces-272711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UTxvOZ2PTmrHPQIAu9opvQ
	(envelope-from <stable+bounces-272711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 19:57:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF172959E
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 19:57:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cGLSeddA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272711-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272711-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B4AE3034B67
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4193BAD9B;
	Wed,  8 Jul 2026 17:57:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3B2459EA;
	Wed,  8 Jul 2026 17:57:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533465; cv=none; b=r8dD7YX5Eri5K/e0/stKE4h5kUdHA6y4kB+3Fe2jeQ/le2C7pNJFHQ+LioW47UlH0nwhj2HvlYqLr9tkzFYuk5wa0erHTBiY/gYGTo/mFUDOWfP8Un4FAowIhxHIjfci1W3Ts4siWg5t2A/0feUiHkawHFpRXRidkGboilE1fr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533465; c=relaxed/simple;
	bh=W9m83feI2MN3NakV4AI5z98Wxj8EM++dFgxKsLp7dRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG01l7Z7yVoyX1BYIej01p0eP24OLfeoupyNoUWUU2yh4Qytcip4p3s21E4WPSUlb8HZw82xnKTIoppZyQfEjHH/AcqcV/boUV4P8hAgdLwEVI6VVMY+zTujpE1YWtJaI7HzgD9QORyUcEG0PHtjF7IfoyOlS2py/dx2bJ9kcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGLSeddA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CAD761F000E9;
	Wed,  8 Jul 2026 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783533463;
	bh=MbX21ZndWDGPuQwpsJkukVtQmhmNbCxepuwSUPCB+kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGLSeddAdopBC6pKZwA7ZL8ydsZFEujFX+Gz5+7uYMZP3Ab41Taaykgx4kz/AIyUZ
	 KH0fxzv+FTAyAZgvd6dnOINBi/av8PcTrw3vsbtbKbYex5nooeKL+Lo8iGS+0dI3Sc
	 bfnSL+eRZ1vsIhbLpk9KWlJL+infnUqWKgQpyWpH115TeO2X37UoFOCj0LKrSPsPoN
	 g7SLll7eTEY7nxkbWMLDnXU6nzPnTwTK13qamvaI81N2aAEvM091Iu9AGNeqtBe7Ui
	 PzUlK0lVlVaJ6OhRz57+EQ3so/9zn8CIi9F0LOeHWW4ZoefCwAATqjQQwp0pZd1xj6
	 mw0m7G1gsD2cw==
Date: Wed, 8 Jul 2026 10:57:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, stable@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/6] xfs: don't replace the wrong part of the cow fork
Message-ID: <20260708175743.GI9392@frogsfrogsfrogs>
References: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs>
 <178346726108.1271589.7681324440256265003.stgit@frogsfrogsfrogs>
 <20260708091220.GA5902@lst.de>
 <20260708152516.GG9392@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708152516.GG9392@frogsfrogsfrogs>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272711-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EDF172959E

On Wed, Jul 08, 2026 at 08:25:16AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 08, 2026 at 11:12:20AM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 07, 2026 at 10:03:24PM -0700, Darrick J. Wong wrote:
> > >  static inline void
> > >  xrep_cow_replace_mapping(
> > > +	struct xfs_inode	*ip,
> > > +	struct xfs_iext_cursor	*icur,
> > > +	struct xfs_bmbt_irec	*got,
> > > +	struct xfs_bmbt_irec	*rep)
> > 
> > This looks like something that should sit in xfs_bmap.c (or at
> > least xfs_bmap_util.c) and not in random scrub code.

To push back on this: there's only one user of this, why not keep it
local to the scrub code?  AFAICT there's nowhere else in xfs that needs
to replace a subset of an existing cow fork mapping with another
mapping.

--D

> > And I really wonder how we can get good test coverage for this, including
> > for the original bug that this tries to address.
> 
> I'll post the debug patch I made that hijacks the errortag knob to make
> it randomly shrink the range passed to mark_cow_range instead of the
> entire iext record.
> 
> The original bug that this tries to address was a pile of bug fixes to
> the xfs cow code that you posted for 5.1 that we neglected to backport
> to 4.14, resulting in corruption of the cow fork mappings.
> 
> --D
> 

