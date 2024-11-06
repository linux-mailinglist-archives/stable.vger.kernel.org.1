Return-Path: <stable+bounces-90072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01179BDF4E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DEC284E6E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A271CC14B;
	Wed,  6 Nov 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="a7eD+yFS"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D701C1AD2;
	Wed,  6 Nov 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877811; cv=none; b=s4HTrnMTCyaHQn6EqlU8P09UC2EDXF9ibuyvXV0CGBZhjwyl084cgjZmjdmfHUOQrq3/mrNeZAOvqFnkmT+YpxWCuiFTIKLyuc87oCPMH5A12Cuyex6NLpfKjdXaoHaN0nVy5G0AUwFPxsnTnuefr2zwktC84GckHDTHfV353z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877811; c=relaxed/simple;
	bh=ASAoilxWckc5MdLsdk/Gt9RrC2fpKKq3cQAY2tADBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPBOTRtOmqMH7gGcWmasxzbPPBS0sgH8PLYVaS1zcfsmpVBesuvapoqMqBL7wSAYZv5uIgzhiYexwYfifFTNsXBlok2Sk6MdIo2j0mXBN/fNEb2muZUSxDNyqIV6CV2RassXfZmBmPjXFWsX74HKk5ePAJcPn6IMY5e5Ahp2elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=a7eD+yFS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=iw2rQVrHpSXDXT1BJhDIQjcX6rB+tehBnAF7Pn72/uM=; b=a7eD+yFS9smWNw5yfNxn+XkIL5
	zXHU7pv/mNF4EvT3kkLKZGpuKfBy5CWj8Oi1EBXKuBuqfVMwzPzRqHwE9vUmZFxLxqUnUVgllPB6p
	haEt5SeWYShbOGs7CTi1U5Y547w9k7b3+8e9Bh+Ig/e4b60sxNTkGDphibSFj5WQn72MiskcJJOJW
	uhm7XI/p+qOI6n01NeF34WPvwoEAvp2PlzD8jLUCslFLWYhPdtASysVxsHD7gr0E7QRaGqxYo21Ed
	kp4qXrukBC5MCm5fE7+m5ACTTY0c2h7HKFvi5V+b+PC94h05ivzMey6l5l+SLXmO1T44E2nW8TnJM
	FSazKoaQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1t8aNq-00DlTP-89; Wed, 06 Nov 2024 07:23:18 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 00FA4BE2DE0; Wed, 06 Nov 2024 08:23:16 +0100 (CET)
Date: Wed, 6 Nov 2024 08:23:16 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Mike <user.service2016@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy =?iso-8859-1?Q?Lain=E9?= <jeremy.laine@m4x.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Message-ID: <ZysZZK8udCI1hNLs@eldamar.lan>
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
X-Debian-User: carnil

Hi Luiz,

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
> 
> Thanks a lot for pointing out the fixes!

Tried to apply those fixes on top of 6.1.115, but they do not apply
clearnly. Could you help to get those backported?

Regards,
Salvatore

