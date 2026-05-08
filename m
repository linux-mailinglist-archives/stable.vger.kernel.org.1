Return-Path: <stable+bounces-244705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMI9Bxqi/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:43:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF54F3D82
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A183301070C
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45C38424F;
	Fri,  8 May 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UACTJc3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793E374185;
	Fri,  8 May 2026 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229780; cv=none; b=k4a7IXNstyUlC50f+AX9NhDW0AxSOmvgeXcxCCaNV+fovTDSsowcFQH52LSbz2Rm3H5J9flQWGjpMUNaTIS7Zz8qoi4gk/H9a8tDZwctf8Zs6dV5VVOeu6iCS8kgtkfRLPAvUcnZTslWquOQSmrCc4m4hi3ta8aC5AGca1HODIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229780; c=relaxed/simple;
	bh=4Q703J0t1zhUS2ZbiQdLXuuK5zZdkCEIXPZQsA41fGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CegusWniLYfz+SmHjTPMmTRU47R2NnYUCcm5Ge9DWusfiDtva80+4Y7rKRvjFqFg5BYPRuOr6woCtIYQjtRYreNfIKzw12Plk4lyV1cTkSgkfYiqDAvIEgnfhHg0W+VRHheDRrLn7lC66H5EoroIsHmUEhyD2DpY7hLID48hgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UACTJc3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042EBC2BCB0;
	Fri,  8 May 2026 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778229780;
	bh=4Q703J0t1zhUS2ZbiQdLXuuK5zZdkCEIXPZQsA41fGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UACTJc3i9+S5VW0xpHJC3uXzdPkGfYfdZYcTozB+9qzMp9UDyjl1BZUrv+6y6ObkN
	 6iRlQ2s+07AQzbqyBecgSCmAdikcHHb/CB1K6e4WtjzqLmI8EXih/fLsducWZYNSI4
	 wjD6r9kLFwChpJ0/Wfhokc/UOtE7s6Iy8DK5d6Ow=
Date: Fri, 8 May 2026 10:42:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Jung <ptr1337@cachyos.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 7.0.5
Message-ID: <2026050832-unstuffed-grant-4d32@gregkh>
References: <2026050851-iron-hurdle-6421@gregkh>
 <c4934dad-1bc3-4fd8-86a3-5073ad47e041@cachyos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4934dad-1bc3-4fd8-86a3-5073ad47e041@cachyos.org>
X-Rspamd-Queue-Id: 20DF54F3D82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244705-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[almalinux.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 10:15:15AM +0200, Peter Jung wrote:
> On 5/8/26 09:24, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 7.0.5 kernel.
> > 
> > All users of the 7.0 kernel series must upgrade.
> > 
> > The updated 7.0.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> > 
> >   Makefile              |    2 +-
> >   net/ipv4/esp4.c       |    3 ++-
> >   net/ipv4/ip_output.c  |    2 ++
> >   net/ipv6/esp6.c       |    3 ++-
> >   net/ipv6/ip6_output.c |    2 ++
> >   5 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > Greg Kroah-Hartman (1):
> >        Linux 7.0.5
> > 
> > Kuan-Ting Chen (1):
> >        xfrm: esp: avoid in-place decrypt on shared skb frags
> > 
> 
> Hi Gregh,
> 
> Thank you for pushing so fat out a release.
> In the Alma Linux post its mentioned a second, not merged commit is also
> needed: https://almalinux.org/blog/2026-05-07-dirty-frag/
> 
> https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
> 
> Is this one not included yet, because it was not merged into mainline yet?

That is correct, it is not merged anywhere yet as a v2 was just posted,
as you can see from that thread.

thanks,

greg k-h

