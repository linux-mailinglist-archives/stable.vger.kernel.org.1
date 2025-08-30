Return-Path: <stable+bounces-176743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6EB3CEE4
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A972A560404
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B52DCF5B;
	Sat, 30 Aug 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OzSy2vZw"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7592DCF43;
	Sat, 30 Aug 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580601; cv=none; b=clMcUWCsaKGxi+ht0HuXih+eV/G9MMSdxMALPVuRAMLtjjSPP9IlJJCEbGeJkUV5cXAwPwaqVwbd9qcqWubG+FqOjDyCuOlTEKRtXqs/B1Es6iIOm4/+rcSZblgAz+uTHmeUQ0aIvpiTOVg88dmazW4fDE0CIzv68CsJE60p2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580601; c=relaxed/simple;
	bh=VIWxAub9v9Nc15TVtanbA94IbdHFmist+z2EzFE2cR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsQaV2jY1OYIwPjeCeBW2UFgENLtJ0Fr6a1XKPnDsMMkS2cStKCJre3F47FGx2y8k//ym3zzqYCRZJFHb00xMdHbW/sEaBhyGYyYUXIoSfoSBxL9IvFHC8npslNa1oU4+UTxlikcoQFbWYKTXJIp7AuGMRyXMmswV/ti970gleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OzSy2vZw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2zEd97eD2ST6z8QE5V+sbWWx834UK4nRASIGlcRaKT4=; b=OzSy2vZwcRjSz3EGgWN0bKaGEX
	iEFlOxiyyqSCr9dXuigwYYK6xHuBmRZ/2kEV0aT2l3hiutPjbcs3iPxgMplsb353tascvVME9BbYD
	21d/OA0gyGKQhzAucWVP5mFXLtjf31KMmpQ4sCcH84jxe3lK70aOsqkTcO2AVumVDXsu6xq2xu/Dk
	8YaJcFjXNGwE4qahpWBFL/tpk9JB5tN/oTZOctWW5YruufJmdADvMERFvxU7zFWRJRZuJcuKEemez
	0wmJZzqENEZEXaFyT/VCyzMpVsAl1ViM5qUBvOA+qBP7lrko20+IPExyS494Z4K2C2y2uK3DAC7wV
	C6HdrysA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1usQqs-00H2TD-9s; Sat, 30 Aug 2025 19:03:02 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2D2FDBE2EE7; Sat, 30 Aug 2025 21:03:01 +0200 (CEST)
Date: Sat, 30 Aug 2025 21:03:01 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Aaron Conole <aconole@redhat.com>, 1108860@bugs.debian.org,
	Charles Bordet <rough.rock3059@datachamp.fr>
Cc: Guillaume Nault <gnault@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Charles Bordet <rough.rock3059@datachamp.fr>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Bug#1108860: [regression] Wireguard fragmentation fails with
 VXLAN since 8930424777e4 ("tunnels: Accept PACKET_HOST
 skb_tunnel_check_pmtu().") causing network timeouts
Message-ID: <aLNK5WOmkgzNrh8P@eldamar.lan>
References: <aHVhQLPJIhq-SYPM@eldamar.lan>
 <aHYiwvElalXstQVa@debian>
 <e585ae4c.AMcAAHLjGYQAAAAAAAAABAFNqZcAAYCsWIwAAAAAAA3mswBoanLG@mailjet.com>
 <f7tjz485mpk.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7tjz485mpk.fsf@redhat.com>
X-Debian-User: carnil

Hi,

On Wed, Jul 16, 2025 at 08:44:55AM -0400, Aaron Conole wrote:
> Guillaume Nault <gnault@redhat.com> writes:
> 
> > On Mon, Jul 14, 2025 at 09:57:52PM +0200, Salvatore Bonaccorso wrote:
> >> Hi,
> >> 
> >> Charles Bordet reported the following issue (full context in
> >> https://bugs.debian.org/1108860)
> >> 
> >> > Dear Maintainer,
> >> > 
> >> > What led up to the situation?
> >> > We run a production environment using Debian 12 VMs, with a network
> >> > topology involving VXLAN tunnels encapsulated inside Wireguard
> >> > interfaces. This setup has worked reliably for over a year, with MTU set
> >> > to 1500 on all interfaces except the Wireguard interface (set to 1420).
> >> > Wireguard kernel fragmentation allowed this configuration to function
> >> > without issues, even though the effective path MTU is lower than 1500.
> >> > 
> >> > What exactly did you do (or not do) that was effective (or ineffective)?
> >> > We performed a routine system upgrade, updating all packages include the
> >> > kernel. After the upgrade, we observed severe network issues (timeouts,
> >> > very slow HTTP/HTTPS, and apt update failures) on all VMs behind the
> >> > router. SSH and small-packet traffic continued to work.
> >> > 
> >> > To diagnose, we:
> >> > 
> >> > * Restored a backup (with the previous kernel): the problem disappeared.
> >> > * Repeated the upgrade, confirming the issue reappeared.
> >> > * Systematically tested each kernel version from 6.1.124-1 up to
> >> > 6.1.140-1. The problem first appears with kernel 6.1.135-1; all earlier
> >> > versions work as expected.
> >> > * Kernel version from the backports (6.12.32-1) did not resolve the
> >> > problem.
> >> > 
> >> > What was the outcome of this action?
> >> > 
> >> > * With kernel 6.1.135-1 or later, network timeouts occur for
> >> > large-packet protocols (HTTP, apt, etc.), while SSH and small-packet
> >> > protocols work.
> >> > * With kernel 6.1.133-1 or earlier, everything works as expected.
> >> > 
> >> > What outcome did you expect instead?
> >> > We expected the network to function as before, with Wireguard handling
> >> > fragmentation transparently and no application-level timeouts,
> >> > regardless of the kernel version.
> >> 
> >> While triaging the issue we found that the commit 8930424777e4
> >> ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu()." introduces
> >> the issue and Charles confirmed that the issue was present as well in
> >> 6.12.35 and 6.15.4 (other version up could potentially still be
> >> affected, but we wanted to check it is not a 6.1.y specific
> >> regression).
> >> 
> >> Reverthing the commit fixes Charles' issue.
> >> 
> >> Does that ring a bell?
> >
> > It doesn't ring a bell. Do you have more details on the setup that has
> > the problem? Or, ideally, a self-contained reproducer?
> 
> +1 - I tested this patch with an OVS setup using vxlan and geneve
> tunnels.  A reproducer or more details would help.

Charles, any news here, did you found a way to provide a
self-contained reproducer for your issue?

Does the issue still reproeduce for you on the most current version of
each of the affected dstable series?

Regards,
Salvatore

