Return-Path: <stable+bounces-177634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B23B423FF
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42323BC911
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC7D2D6604;
	Wed,  3 Sep 2025 14:48:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FD4D8D1
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910905; cv=none; b=MhgpHmaTbrYJCe7yZJ0jmWn7GSRfZMvF0aIcqrPR3LVjoFTi9MiCAo4rLj9fj3y7iqy7Y1QugBq+1b/Tf6SHrkM0ldKx2AyViKGL01uPJ9hDp3EAXjYrObCCRgf3f29w7EzF2tM46CCNBpMlveGARzTU/NybKJgEOl0+9IM3SIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910905; c=relaxed/simple;
	bh=SWFaV+9gbf6BWqyn3Tobr6JX3e9DOM/M6mzmMLmNiGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFq5DF0FRx9HhLc0TTWfP29zODh3p68idYTqyc6V3sZyGW9TXF5rpk/gMJFA1q4I8VewgStCYASVh9vzPY3wApX2k/fOiIAp0vsXsmCagBWFzmYVcXuyz1iY7CEEdPA11iIvEB1indK3v3UiS5vgibOd7BSCX8teke4lxq6hmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Wed, 3 Sep 2025 16:47:56 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Oscar Maes <oscmaes92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [stable-6.16|lts-6.12] net: ipv4: fix regression in
 local-broadcast routes
Message-ID: <aLhVHLbqFCB6BoB2@karahi.gladserv.com>
References: <CA+icZUWXiz1kqR6omufFwByQ9dD9m=-UYY9JghVQnbGD2NMy1w@mail.gmail.com>
 <aLH1M-F001Nfzs7m@eldamar.lan>
 <CA+icZUXo-C9sSvqZ9nmZhyZvPtJmE8wgzTm2y+k0P6=mynWZcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUXo-C9sSvqZ9nmZhyZvPtJmE8wgzTm2y+k0P6=mynWZcg@mail.gmail.com>

On 2025-09-03 16:42, Sedat Dilek wrote:
> On Fri, Aug 29, 2025 at 8:45 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
> >
> > On Fri, Aug 29, 2025 at 06:56:52PM +0200, Sedat Dilek wrote:
> > > Hi Sasha and Greg,
> > >
> > > Salvatore Bonaccorso <carnil@debian.org> from Debian Kernel Team
> > > included this regression-fix already.
> > >
> > > Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd
> > > "net: ipv4: fix regression in local-broadcast routes"
> > >
> > > As far as I have seen this should be included in stable-6.16 and
> > > LTS-6.12 (for other stable branches I simply have no interest - please
> > > double-check).
> > >
> > > I am sure Sasha's new kernel-patch-AI tool has catched this - just
> > > kindly inform you.
> >
> > As 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> > has been backported to all stable series in  v5.4.297, v5.10.241,
> > v5.15.190, v6.1.149, v6.6.103, v6.12.43, v6.15.11 and v6.16.2 the fix
> > fixiing commit 5189446ba995 ("net: ipv4: fix regression in
> > local-broadcast routes") would need to go as well to all of those
> > series IMHO.
> >
> 
> Looks like next stable releases will include this bugfix - checked
> stable-6.x only.

Yes, the patch has been backported to all stable RCs.


Brett

