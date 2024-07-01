Return-Path: <stable+bounces-56264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF0991E476
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C011F24F31
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70116D4F0;
	Mon,  1 Jul 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=wendler.lars@web.de header.b="cOrD/Wd/"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93616D327;
	Mon,  1 Jul 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848759; cv=none; b=S2xXx7BkTUmd47D277Qcll2WdWcwFXxvu1BrPBAw0b4O4s2seIibytw+NZOoVyIH5iChoVrKSZADM3vQ/VVecoTMkg8E9dvPl+boCWDnL2ssWxNjyCx6jwNblv2x2EfaFN1fbgJWN9sJ+sb9tHxsS1uRni0SRnokr2UT3hPxRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848759; c=relaxed/simple;
	bh=k6z2PkKSTYn2SXsOUU2zrj5otlmWIomb3VX8Gw3FQTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/IHAJ3E5WlHtYbByF3U2DXRGmDSoiuIF1PBfWQjieqOFJWxMFDOmMTvzKIxHKqLrYonco5arMpEBHaEtGH5H6pAeTvHWb9XpY2ZPwUltI8Lm8t7h9KHSbD2WaSwq8ImnI6dJdXDExZ1ysK5xhlXqycLzj/e2Z5ChIUkfEiqf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=wendler.lars@web.de header.b=cOrD/Wd/; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719848744; x=1720453544; i=wendler.lars@web.de;
	bh=qyYJyIEErg05vDkq0CU4vpBUzf19VZH3CjaC48g91Zg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cOrD/Wd/XciviGWpB11U7WJQSEyqM3ik9SC87DqfmxUUa3bnoK735FM1SYZgeIyE
	 xH58X454A4YbWMY/4Ebm82HYAlG3xdgJZ378QEgBHr5bpwIDAeNdSuQtI6M0gLeRJ
	 3mpDkE2nWNOrJeb0VwzfUFaheECTZVMeO1c77sVEzlb3SPC938uQoHStILwntxiol
	 CHhG9ymp653nyBC37BqpQuwR5homRTnYqVigN3tXOMLfOlETSAkCLEfkO2sbBOnYe
	 hN5S76J6t2hFQdm8rzGjWLv+GinsncL3RHHrmyPM/FzAyQfd3sSe61NBVWPVtbMVm
	 2fs+J1SGgAKqUFq6hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from chagall.paradoxon.rec ([79.234.218.152]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mr7am-1s2liA1nzq-00d622; Mon, 01 Jul 2024 17:45:44 +0200
Date: Mon, 1 Jul 2024 17:45:39 +0200
From: Lars Wendler <wendler.lars@web.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Du, Xiaojian"
 <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since
 6.6.34
Message-ID: <20240701174539.4d479d56@chagall.paradoxon.rec>
In-Reply-To: <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
	<SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
	<7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
Organization: privat
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yq.20eIUyhhJ7O4LRZyJt5Z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Zth2jTe2Mrj0i2/LA3J6GFqHraRoPoB7BfTd1Qq9I6at7/KSRwf
 VVH+xaktMMlxL5/BvhCF6RYR25HPkzb9fHqe3gfplzqjx2RSPkIfLfJ3j21/YGxyWdvi8h9
 rkPnDt/GLX/NF+R8ub5/NShauSw6E8h3xfKh5OdXRPsXK3rr9zf6CbUL1TzHE+irkb2FpUD
 cT8KrSwTjkmhBIdSNZxzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JCLIDsT1Wyg=;JkQjzEvpDZE3o3zozByYRDLkEe5
 7A1MPGBRvvrIO78bNaighplWfCAU/tX+z/4733CP919fjbiCqb1RZQncrkt3lB9h9zT5Bw4wV
 B4M2K3yadjVKftv+PSvqHFJkAaivBNZQ6YJFIMuK8dVUHw22XdV6/G8+mC2S+CTZw2fSZyHiy
 CUzgdxJ/Ky1uPDibPk3UQsY1Y3eYr31uUhLxEDdGiP/vJ72M1hkSfPIZ4yDetl4RksR/CAd+8
 nv7UCwm3BH3/Y00JheOE1mZ98ZSEqFOqITaBZYUN3zzyT0A/OveV1XzXaUJ11evtsXVujxGGP
 veeeeyz+gsLTSDBHuvQr9SXjZcIo0g20atKRLhitOshVPwkL2lL2Dg2FLNEb+yOBcaq5tKMQ6
 BdrE1VEHrgXqSyPpntvOeCREBzElqpE+yfb9c7MASiLFp8LOQJ6BWE+MH01scp45qhuOntr7o
 TL+lhlHE/yO40vA6E8DR1Yl62xgcbE10+CHnqLmiiKZukbG52HZKJaTkbSA0zcgJTuhBqdp10
 5VC8W2dDY7taKTiBActzqVaQ/q+0HyUhoeoS2TMU6aPazbMOaBXS44ct52f0Hqh2viaXXbThz
 Opp2oj36oPoKtgocZdSxgROSo/NyeFSC4zVbdkYYpCC2EiWjktS145q0aaruduNrNT0w5IxSb
 oKQ384PzNXs63e1tdtjHGnxmsmlMG0/pW9NuEKQicoIlWabyZ6b/2Q/ko1mkwvSWU0SPcOnMo
 pTpETe9Ih4gdwxFnmK72Np8IPGd7AqQwxf5iSb5nMjqkhY8BVWbOxuP+cSBBHQLnJ/0udZpRp
 FtO7BLQviR2vWiFPlgC5Vmaveq6SLz0QtMaWp+b8fBGRE=

--Sig_/Yq.20eIUyhhJ7O4LRZyJt5Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Mario,

Am Mon, 1 Jul 2024 10:07:59 -0500
schrieb Mario Limonciello <mario.limonciello@amd.com>:

> In the future, please send this to the regressions M/L and CC people=20
> instead of just sending a private message.
>=20
> For now, I've added the @regressions and @stable mailing lists as
> this is an issue you find exposed specifically in the LTS series.
>=20
> Hi Lars,
>=20
> Can you please test 6.9.7?  If this is still failing, can you please=20
> check 6.10-rc6?

I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
issue. I can disable CPU boost with both kernel versions.

> I'd like to understand if we just have a missing commit to backport
> or it's a problem in the mainline kernel as well.
>=20
>  From the below description it's specifically with boost in passive=20
> mode, right?=20

I have only tested the passive mode on all my Ryzen systems and only my
Zen4 machine shows this regression.
=20
> If 6.10-rc6 is still affected, can you please see if this commit
> helps? https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/=
commit/?h=3Dlinux-next&id=3De8f555daacd3377bf691fdda2490c0b164e00085
>=20
> This is going into 6.11-rc1.
>=20
> Perry, Jassmine,
>=20
> Can you try to repro this using bleeding-edge or linux-next branches?
>=20
> Thanks,
>=20
> On 7/1/2024 4:33, Huang, Ray wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >=20
> > Hi all,
> >=20
> > Could you please help for a quick fix?
> >=20
> > -----Original Message-----
> > From: Lars Wendler <wendler.lars@web.de>
> > Sent: Monday, July 1, 2024 5:30 PM
> > To: Huang, Ray <Ray.Huang@amd.com>
> > Cc: gregkh@linuxfoundation.org
> > Subject: linux-6.6.y: Regression in amd-pstate cpufreq driver since
> > 6.6.34
> >=20
> > Hello dear kernel developers,
> >=20
> > I might have found a regression in the amd-pstate driver of
> > linux-6.6 stable series. I haven't checked linux-master nor any
> > other LTS branch.
> >=20
> >=20
> > Now here's what I have found:
> >=20
> > Since linux-6.6.34 the following command fails:
> >=20
> >    # echo 0 > /sys/devices/system/cpu/cpufreq/boost
> >      -bash: echo: write error: Invalid argument
> >=20
> > and indeed, disabling CPU boost seems to not work:
> >=20
> >    # cat /sys/devices/system/cpu/cpufreq/boost
> >    1
> >=20
> > I have bisected the issue to commit
> > 8f893e52b9e030a25ea62e31271bf930b01f2f07:
> >=20
> >    cpufreq: amd-pstate: Fix the inconsistency in max frequency units
> >=20
> >    commit e4731baaf29438508197d3a8a6d4f5a8c51663f8 upstream.
> >=20
> > Reverting that commit (even on latest linux-6.6 release) gives me
> > back the ability to disable CPU boost again.
> >=20
> > I can only reproduce this bug on my Zen4 machine:
> >=20
> >    # lscpu | grep "^Model name:" | sed 's@[[:space:]][[:space:]]\+@
> > @' Model name: AMD Ryzen 7 7745HX with Radeon Graphics
> >=20
> > My older Zen3 machines seem not to be affected by this issue. All
> > my Ryzen systems run on latest linux-6.6 kernels and have the
> > following configuration regarding amd-pstate:
> >=20
> >    # zgrep -F AMD_PSTATE /proc/config.gz
> >    CONFIG_X86_AMD_PSTATE=3Dy
> >    CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D2
> >    # CONFIG_X86_AMD_PSTATE_UT is not set
> >=20
> >=20
> > If you need more information, please don't hesitate to ask.
> >=20
> > Kind regards
> > Lars Wendler =20
>=20


--Sig_/Yq.20eIUyhhJ7O4LRZyJt5Z
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWCOBmo8i7LhvVmNAVx3S0DQ8YDkFAmaCzyMACgkQVx3S0DQ8
YDkQGw/8CtzLCQtAFmdj1qvAy6D8ZmwI07rraK9u8VMqCKLG43JqpwDhCBCJp00w
yiF+n82XhsGbbOVMHvqWWdgFWf2Cg6JJ4vxgbJBk2pbfFH6zocb8UoYA0mzUa+zB
xIM7yD2uAAVOsvEQZ6uq624Zcb+GBzQFHMd7GJVc96m5Bk2Ghusdjxay9t1g8SEw
OI5pevgrKKOEX60ibEOi13kQ0K6ZSo2srRxRtiZWkRyQ1ZDppL++hEOcCcSblkxx
BVzr2h/lvMYcxGOAj7d55lt+WuugyaEj1QmQBu+hil05QugC50rdwU1Chck+S+t/
GMcUv5iwmnEPKtsvBdOH9nCIudYv67RSSw1+XqyOX7NzWjftB7Tx927XZ4VnUMrF
5RpQzW0vi3MDDFjnfGRzKSjpQW3G74MNVgTwea2E/sgJ1VvyGUDRjjp/AU3r9H5U
3pJJ4NQ+g5Y3BwNzRq24uwL5HAY8V97lffOYo9AXWGYVPyob9WRZZSaMWJfdEHzL
5Yo0l60RMolP0w/sX2J6b1QOyEp1ietVK+uCJuIM0BPcZBoIZFMLtjFKVm3L6Sx1
ENNbGZGoK1liDirGL1IgW3HlolwZ2Yikta8g0DoXCSKRyoyKCfAGkHPqilcKTb9X
hJs3nFWs2YEClzCd31nDusS0ipVlFDgY7yY/BCfPYpMw/VC3wtk=
=Gcmu
-----END PGP SIGNATURE-----

--Sig_/Yq.20eIUyhhJ7O4LRZyJt5Z--

