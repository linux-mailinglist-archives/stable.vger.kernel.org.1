Return-Path: <stable+bounces-139744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E1AA9D48
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458F3AA54D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB9204096;
	Mon,  5 May 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mbUxHVfa"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD21C861D;
	Mon,  5 May 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477383; cv=none; b=WtXXbSVnWTzU/MI6Fs9ByUBtsSRdAyrWQMtJu5Z0Yt9h0ND63+80cNGA5z0TDvaobvBBMhbpUIrAwyJ3bx26N3BcnNzTjUtY3ESB7kuzrPVKibVZPpI16fVeSW9SpRTTmjxXp60QM0IQb4zvA0Ax+u7771hF3nDVYSpi3AIjSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477383; c=relaxed/simple;
	bh=XWA92Y0qQOByIhIzugi60DxvQF6xeiCzTERQHsjZqxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+SlFv0pZhAhoN5jtVcrM1+hPDKdroW8wqxXQDgsgYyKorDXYqAlEuv6nWpsTcn07NXajIidMztfkZFCr0Iixdv6FDPf3aQ9nZ1Ucz3BXFkdUCz2nR5kwGggn2Dojx+DWwkV7tTRhqUH+IIdyGB+ZyveHyJwjY1NdQ/n6tWjgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mbUxHVfa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=MBa7W39yhbhN3u+1Mc/VNRMpk2660lmIIqqWzcOKj3Q=; b=mbUxHVfatbT46Q/yLFhMbhlXtU
	kW6k8X8s/3YF7FeebLL4tYiLd0IqZkbFHfFOysZTNPdxJsSysTK+HcF09eSwfVvtuhx3u4c1iJsD2
	2YEUh6ZqPQmuk1kwFqMqlwAIhcMD/G23dH5TIIhdshI4ChltXciwYSXlpsOvGOekujDXZML/ouUDp
	SzVjjl3XKIUAvfVDXSeuzvajsY22seIhfVkYLjWjUJ9vltopQn4ZTm2OTFVv899CCLQwkVcIpPTVC
	6mY6ygutuynCIxWRH0R7DLTbg1lffnp4YrCLT9P9FNwTB/xIG6ESiSK4dRpJjhSjUPOVilzdpODZQ
	CBxwEMbQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uC2Xo-0043qn-TM; Mon, 05 May 2025 20:36:09 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 048AFBE2DE0; Mon, 05 May 2025 22:36:07 +0200 (CEST)
Date: Mon, 5 May 2025 22:36:07 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
	1104460@bugs.debian.org
Cc: Moritz =?iso-8859-1?Q?M=FChlenhoff?= <jmm@inutil.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Melvin Vermeeren <vermeeren@vermwa.re>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Coly Li <colyli@kernel.org>, Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: Bug#1104460: [regression 6.1.y] discard/TRIM through RAID10
 blocking (was: Re: Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard
 broken) with RAID10: BUG: kernel tried to execute user page (0) - exploit
 attempt?
Message-ID: <aBkhNwVVs_KwgQ1a@eldamar.lan>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan>
 <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
 <aBjEf5R7X9GaJg2T@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBjhHUjtXRotZUVa@eldamar.lan>
 <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <875xiex56v.fsf@angela.anarc.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xiex56v.fsf@angela.anarc.at>
X-Debian-User: carnil

Hi Antoine,

On Mon, May 05, 2025 at 02:50:32PM -0400, Antoine Beaupré wrote:
> On 2025-05-05 18:02:37, Salvatore Bonaccorso wrote:
> > On Mon, May 05, 2025 at 04:00:31PM +0200, Salvatore Bonaccorso wrote:
> >> Hi Moritz,
> >> 
> >> On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz Mühlenhoff wrote:
> >> > Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
> >> > > Hi
> >> > > 
> >> > > We got a regression report in Debian after the update from 6.1.133 to
> >> > > 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
> >> > > stalls idefintively. The full report is inlined below and originates
> >> > > from https://bugs.debian.org/1104460 .
> >> > 
> >> > JFTR, we ran into the same problem with a few Wikimedia servers running
> >> > 6.1.135 and RAID 10: The servers started to lock up once fstrim.service
> >> > got started. Full oops messages are available at
> >> > https://phabricator.wikimedia.org/P75746
> >> 
> >> Thanks for this aditional datapoints. Assuming you wont be able to
> >> thest the other stable series where the commit d05af90d6218
> >> ("md/raid10: fix missing discard IO accounting") went in, might you at
> >> least be able to test the 6.1.y branch with the commit reverted again
> >> and manually trigger the issue?
> >> 
> >> If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
> >> with the patch reverted. 
> >
> > So one additional data point as several Debian users were reporting
> > back beeing affected: One user did upgrade to 6.12.25 (where the
> > commit was backported as well) and is not able to reproduce the issue
> > there.
> 
> That would be me.
> 
> I can reproduce the issue as outlined by Moritz above fairly reliably in
> 6.1.135 (debian package 6.1.0-34-amd64). The reproducer is simple, on a
> RAID-10 host:
> 
>  1. reboot
>  2. systemctl start fstrim.service
> 
> We're tracking the issue internally in:
> 
> https://gitlab.torproject.org/tpo/tpa/team/-/issues/42146
> 
> I've managed to workaround the issue by upgrading to the Debian package
> from testing/unstable (6.12.25), as Salvatore indicated above. There,
> fstrim doesn't cause any crash and completes successfully. In stable, it
> just hangs there forever. The kernel doesn't completely panic and the
> machine is otherwise somewhat still functional: my existing SSH
> connection keeps working, for example, but new ones fail. And an `apt
> install` of another kernel hangs forever.

So likely at least in 6.1.y there are missing pre-requisites causing
the behaviour.

If you can test 6.1.135-1 with the commit
4a05f7ae33716d996c5ce56478a36a3ede1d76f2 reverted then you can fetch
built packages at:

https://people.debian.org/~carnil/tmp/linux/1104460/

Regards,
Salvatore

