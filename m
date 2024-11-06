Return-Path: <stable+bounces-90074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB699BDF64
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53090B21C1C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCFE1CC894;
	Wed,  6 Nov 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qJyNgN8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C138192580;
	Wed,  6 Nov 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877984; cv=none; b=GuJdu9sPtrK0y/xlKdLFa9oNMp/HNQ9mYsjyPSKtrz57REEgm9/AeY7gEobZocrSS7FGvB0BlQj9EXjLu/GaELmyhGakRyfjpNo+/1tZry6Ktm03KFjcSM6sq74Z7A1I1WY31gzEi0S0gBgWFBw8CBHoq5kuyJoue5cXx+Sp5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877984; c=relaxed/simple;
	bh=T/zpViMUVPQxJyrMKg/1IlU8jjVtE0X9HMEuHdkY5mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBT7y7wNo8eiz4Y08CZxipu+bdY1Pmx/sp6wzARSA08EN3Ap850wnFf/xfdE7vZ69hiIW48gC5f3pPf8wHHuTiI08bdmt/oL9i100GQJbcDjv3V/FQz6W72Ecp9yKH7mBTw1XHNfeVHi/WR5qPru6KMAKpNB7e8SV1KEG1I5/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qJyNgN8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781BDC4CECD;
	Wed,  6 Nov 2024 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730877984;
	bh=T/zpViMUVPQxJyrMKg/1IlU8jjVtE0X9HMEuHdkY5mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJyNgN8wUgxRML5AZQwZgG6G2u4a6WXZGbVgbSSaxgL1m+bY9Wi1FPEriRVBCXEVe
	 xgCdgIOZjjevRNAqcOtDZHMr860UXr0tKf1TjzdH/97PjTM+0vXEcaOowbyFc2ge1p
	 O0xLWIntwwlP9l9FCsc6IVtnJFoFkFV2m68Tain8=
Date: Wed, 6 Nov 2024 08:26:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Mike <user.service2016@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy =?iso-8859-1?Q?Lain=E9?= <jeremy.laine@m4x.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Message-ID: <2024110652-blooming-deck-f0d9@gregkh>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
 <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
 <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
 <Zypwz65wRM-FMXte@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zypwz65wRM-FMXte@eldamar.lan>

On Tue, Nov 05, 2024 at 08:23:59PM +0100, Salvatore Bonaccorso wrote:
> Hi Luiz,
> 
> On Tue, Nov 05, 2024 at 12:53:50PM -0500, Luiz Augusto von Dentz wrote:
> > Hi,
> > 
> > On Tue, Nov 5, 2024 at 12:29 PM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> > >
> > > On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> > > > On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
> > > >> On 12.06.24 14:04, Greg KH wrote:
> > > >>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> > > >>>> On 03.06.24 22:03, Mike wrote:
> > > >>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> > > >>>>> [...]
> > > >>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> > > >>>>> time to be
> > > >>>>> included in Debian stable, so having a patch for 6.1.x will be much
> > > >>>>> appreciated.
> > > >>>>> I do not have the time to follow the vanilla (latest) release as is
> > > >>>>> likely the case for
> > > >>>>> many other Linux users.
> > > >>>>>
> > > >>>> Still no reaction from the bluetooth developers. Guess they are busy
> > > >>>> and/or do not care about 6.1.y. In that case:
> > > >>>>
> > > >>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> > > >>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
> > > >>>> cause this or if it's missing some per-requisite? If not I wonder if
> > > >>>> reverting that patch from 6.1.y might be the best move to resolve this
> > > >>>> regression. Mike earlier in
> > > >>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
> > > >>>> confirmed that this fixed the problem in tests. Jeremy (who started the
> > > >>>> thread and afaics has the same problem) did not reply.
> > > >>>
> > > >>> How was this reverted?  I get a bunch of conflicts as this commit was
> > > >>> added as a dependency of a patch later in the series.
> > > >>>
> > > >>> So if this wants to be reverted from 6.1.y, can someone send me the
> > > >>> revert that has been tested to work?
> > > >>
> > > >> Mike, can you help out here, as you apparently managed a revert earlier?
> > > >> Without you or someone else submitting a revert I fear this won't be
> > > >> resolved...
> > > >
> > > > Trying to reboostrap this, as people running 6.1.112 based kernel
> > > > seems still hitting the issue, but have not asked yet if it happens as
> > > > well for 6.114.
> > > >
> > > > https://bugs.debian.org/1086447
> > > >
> > > > Mike, since I guess you are still as well affected as well, does the
> > > > issue trigger on 6.1.114 for you and does reverting changes from
> > > > a13f316e90fdb1 still fix the issue? Can you send your
> > > > backport/changes?
> > >
> > > Hmmm, no reply. Is there maybe someone in that bug that could create and
> > > test a new revert to finally get this resolved upstream? Seem we
> > > otherwise are kinda stuck here.
> > 
> > Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
> > hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
> > ("Bluetooth: hci_sync: always check if connection is alive before
> > deleting") that are actually fixes to a13f316e90fdb1.
> 
> Ah good I see :). None of those were yet applied to the 6.1.y series
> were the issue is still presend. Would you be up to provide the needed
> changes to the stable team?  That would be very much appreciated for
> those affected running the 6.1.y series. 

We would need backports for these as they do not apply cleanly :(

thanks,

greg k-h

