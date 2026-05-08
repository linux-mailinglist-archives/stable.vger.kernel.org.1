Return-Path: <stable+bounces-244706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMbRNMWj/Wl0ggAAu9opvQ
	(envelope-from <stable+bounces-244706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:50:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A16B4F3E42
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D8353015863
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1BD325494;
	Fri,  8 May 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uea97ttH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033B2F8EA9;
	Fri,  8 May 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230210; cv=none; b=Brc15mYGxmFNBrPEk9nH4K+keCiY+mbyAUqoieMxbCeKpmzbaA4tGLs/b1jNyRtutj3SxHmzhupRB85qm7E9DQPbc8houlDajCzyV2XuNMDHWKkEa9vpvqBPb+mt6Nt7gzuf9YRvlxEWBt7lV2zi7tVbYxVt6xdTjmeCTy3zChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230210; c=relaxed/simple;
	bh=J0HT+Bl8aoEr4FkbN2BrEe/mXnkMY3MlJSLpj1vnz88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGbEusfdSRGN5rlqs+H+Qvu5MjxHSC0f5s9nB9dUDxRsKlwMABZYs6HMOnEVcFwUur9FqCdbIhIeCAssGmsmkeoM33A6x4Xj63llpVbboYKwHOo7x6ZRxoDs8WvkSVI816ye0a3mdNGfit3EYHXfws092X+9jS1AyrZvsqgRs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uea97ttH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FEAC2BCB0;
	Fri,  8 May 2026 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778230209;
	bh=J0HT+Bl8aoEr4FkbN2BrEe/mXnkMY3MlJSLpj1vnz88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uea97ttHv5BDim8ldHMprGOubJmsH15z/hyyb4HQM4YZKZDU/qKQFiDv37Tf1S4FX
	 pm+5u/ejrqlkR88Ee9l+LmMuh0F6069K8aHcUViVFCnAduawAHvvqlQBFK0uiY1587
	 mrwVDyRC5WzoDU/TSXorNWnvPj24cAY0m75WoO7A=
Date: Fri, 8 May 2026 10:50:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Jung <ptr1337@cachyos.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 7.0.5
Message-ID: <2026050859-ahead-anchovy-05e2@gregkh>
References: <2026050851-iron-hurdle-6421@gregkh>
 <c4934dad-1bc3-4fd8-86a3-5073ad47e041@cachyos.org>
 <2026050832-unstuffed-grant-4d32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026050832-unstuffed-grant-4d32@gregkh>
X-Rspamd-Queue-Id: 7A16B4F3E42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,almalinux.org:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 10:42:57AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 08, 2026 at 10:15:15AM +0200, Peter Jung wrote:
> > On 5/8/26 09:24, Greg Kroah-Hartman wrote:
> > > I'm announcing the release of the 7.0.5 kernel.
> > > 
> > > All users of the 7.0 kernel series must upgrade.
> > > 
> > > The updated 7.0.y git tree can be found at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
> > > and can be browsed at the normal kernel.org git web browser:
> > > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > ------------
> > > 
> > >   Makefile              |    2 +-
> > >   net/ipv4/esp4.c       |    3 ++-
> > >   net/ipv4/ip_output.c  |    2 ++
> > >   net/ipv6/esp6.c       |    3 ++-
> > >   net/ipv6/ip6_output.c |    2 ++
> > >   5 files changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > Greg Kroah-Hartman (1):
> > >        Linux 7.0.5
> > > 
> > > Kuan-Ting Chen (1):
> > >        xfrm: esp: avoid in-place decrypt on shared skb frags
> > > 
> > 
> > Hi Gregh,
> > 
> > Thank you for pushing so fat out a release.
> > In the Alma Linux post its mentioned a second, not merged commit is also
> > needed: https://almalinux.org/blog/2026-05-07-dirty-frag/
> > 
> > https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
> > 
> > Is this one not included yet, because it was not merged into mainline yet?
> 
> That is correct, it is not merged anywhere yet as a v2 was just posted,
> as you can see from that thread.

And a v3 will be forthcoming...

