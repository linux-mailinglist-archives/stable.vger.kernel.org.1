Return-Path: <stable+bounces-217319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOLCOO8XlmkSaAIAu9opvQ
	(envelope-from <stable+bounces-217319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:50:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48379159366
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E13E13046EB1
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274FD348896;
	Wed, 18 Feb 2026 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lLY65xXz"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEC21FF2E;
	Wed, 18 Feb 2026 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444157; cv=none; b=pg3DNoVcjjL3q8Vq+ZZLFb+PVkBkYLemlULZV77G+xJbgCPmBU+HOc0zzxa8wAIXpxiiVKX8UJMIMDNmoGZFu1o1uZ0XktBeQ6qD4QdiBk1ZTG7k8L/ZnvgSwoWoePgyD/soenL72vn8Ig3imSYWeSH0uXKDHbYZlYdsG0Nn2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444157; c=relaxed/simple;
	bh=eMRFdp9hs01023AFurRh2OWyQBNKj3qoYIOSVy87tAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/v5i17Y4i7p996Z66D2DjfIrM1y6Px2mfHik5FO36q4hQul1bju9+a5Mvx/qUmeXEc9YXpE760f/9m/kBE+y9NBOCx4ieD5tEeQ0EXIi3t//dkCPFAzO0WBP9pfHBoZWaiZR3Y63ckuyuVxO7J5wt2Z0Vm7jNWciSdaAKLSirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lLY65xXz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1224)
	id 8ACE220B6F00; Wed, 18 Feb 2026 11:49:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ACE220B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771444156;
	bh=yCczxXvs8QVrwjiAXfOUtxxkudkas2eVt5KXtsgLhPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLY65xXznW8Ri//2YhbS/0767eIWD4MA9PzgkubCtYa59cPkg3KIl1OFgLLgge4Qs
	 JWqyvdYedAZDBSaeJlvpozsz6zkzkwPsup/iqW9+Dhz8lt97pZyBbJH/w+7KLJPanV
	 a12bOr4TWqiGvPJ8ZGAvq0i/Pf1jX8aL5EJFo2m0=
Date: Wed, 18 Feb 2026 11:49:16 -0800
From: Noah Meyerhans <nmeyerhans@linux.microsoft.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>
Subject: Re: [PATCH 6.6 0/3] arm64: Speed up boot with faster linear map
 creation
Message-ID: <aZYXvMvGZfk0muht@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260217133411.2881311-1-ryan.roberts@arm.com>
 <2026021700-chafe-jurist-cb24@gregkh>
 <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
 <2026021718-citrus-parakeet-dc60@gregkh>
 <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
 <CAGb2v67_UQ9rAFPQ5mqTFdNdPxyAJj0WZ6PwOLbHxU_0XQM6CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67_UQ9rAFPQ5mqTFdNdPxyAJj0WZ6PwOLbHxU_0XQM6CA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217319-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nmeyerhans@linux.microsoft.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,arm.com:email,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 48379159366
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:27:53PM +0800, Chen-Yu Tsai wrote:
> 
> On Tue, Feb 17, 2026 at 10:21 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >
> > On 17/02/2026 14:10, Greg KH wrote:
> > > On Tue, Feb 17, 2026 at 01:58:36PM +0000, Ryan Roberts wrote:
> > >> On 17/02/2026 13:50, Greg KH wrote:
> > >>> On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
> > >>>> Hi All,
> > >>>>
> > >>>> This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
> > >>>> some speed ups to enable significantly faster booting on systems with a lot of
> > >>>> memory. The patches were originally posted at:
> > >>>>
> > >>>>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
> > >>>>
> > >>>> ... and were originally merged upstream in v6.10-rc1.
> > >>>>
> > >>>> I'm requesting this be merged to stable on behalf of a partner who wants to get
> > >>>> the benefit of this series in Debian 12.
> > >>>
> > >>> Why can't they just use a newer kernel version (i.e. 6.12)?  Surely they
> > >>> would be able to justify moving to a newer kernel for performance
> > >>> reasons, why enable them to stay on an older one, just delaying the
> > >>> inevitable upgrade they will have to do anyway in a year or so?
> > >>
> > >> I can't answer this presicely, but I did ask and push for that approach. As I
> > >> understand it, they are stuck with Debian 12, which is stuck with kernel 6.1.
> > >> The Debian maintainer apparently requested that these go through stable in order
> > >> to get them into Debian 12.
> > >
> > > I understand the position of Debian not wanting to take patches for new
> > > features that are not already upstream, but really, Debian offers a
> > > newer kernel for hardware that wants to use it for things like this,
> > > right?  Why not just use that instead?
> >
> > Let me go push a bit harder. But I expect we are in the grey zone between bug
> > and feature here; this is a performance bug fix, not a new feature. By
> > selectively backporting I'm guessing they are avoiding the risk of new features
> > that a new kernel brings introducing new bugs? I'm guessing there is a higher
> > qualification bar for that.
> 
> Why can't they use the kernel from bookworm-backports, which is 6.12?

Bookworm-backports will likely be our recommendation should this
patchset ultimately be rejected.  Debian 12 uses 6.1.y by default.
While 6.12.y is available for that release via the bookworm-backports
repository, bookworm-backports content is not generally recommended for
production usage. It's not necessarily updated on the same cadence as
the 6.1.y packages, and Debian does not publish security advisories for
it.

Debian does not want to maintain this change as a downstream patch, 
which is fair.  Microsoft would like to make this boot optimization
available by default to Debian 12 users (of which there are still many)
which is why we're pursuing this path.  Naturally, we'll manage if we
can't get the change applied to 6.1.y, but hopefully this explains where
we're coming from.

noah


