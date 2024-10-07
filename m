Return-Path: <stable+bounces-81445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC79934CD
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85BD1F25480
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4B1DD54F;
	Mon,  7 Oct 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="aaUHNTWb"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1A18BBB2;
	Mon,  7 Oct 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321686; cv=none; b=SuMKk0N2yyYLLy/3Kd7k4elIgWnzEMgtzxKJxxaZPeKgzcxm6hhIY9RyEHOCOlyUcWzWBnY1m4h/GYSkM8i2FxgIK4gxEQhJuwx6NP4ZypsUoqYcN3WzXnmlJ45oGx1LVYlUBWnSjMzIrM8Fm5Q1yfuTdYKazpFxL49rinZmLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321686; c=relaxed/simple;
	bh=Ql7rfhjHQYE3CtDJKF+F06fcUr6BoEpGuLHyuRkpqBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWk5ZG/yN/QpCO6pAU3sBC9q/7xiGif8bX23hA56G7KC4bzGRcSE+35S195mNWYsJzl3ewN8IxrarY06d2wXEMBGcG3a/RqKadl6iD40x46Wl2lqhhh9U9P42dUY5vNFqlB40txL86X3mNoPLqO9bGrV9/U5Jy0xbui7/YlCqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=aaUHNTWb; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1728321669; x=1728926469; i=christian@heusel.eu;
	bh=FWaHKimhEwFDTZ2TU07T11/SON+VT88p4S+W/ovLTPk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aaUHNTWb2JaTjgy9c+fpD2jDdTnUE+KscPczrQHAXiATsGhUeL7swkpfNzFwxZBB
	 Yog/yLLl4lWwPI4xGhIEbSENgJwhyF01gryNcNppZKNYBU/KNX3niZFtD1a3QwEI3
	 OYsuxpCpDrnF0ARfEfDztDqgsABqtm8NC8FhUfdd5+f2BuYN2ApHEtG7Ve+LUohvw
	 2ZG1E9FWe8EDe3QbondPS99Flc0e99UxsGlY0sQnxRlpo0WLaGptaljsNgjnl3oB0
	 KohU873XoO4AKbeRpeG6Ndgxj/zjtb7S6G31NAr6bW5zKgBg0bG8X8+DQ4xx/X+aS
	 3HukftMS4rz8NeoCvQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MXXdn-1tUfWs3Fp1-00Rjwd; Mon, 07
 Oct 2024 19:21:09 +0200
Date: Mon, 7 Oct 2024 19:21:08 +0200
From: Christian Heusel <christian@heusel.eu>
To: Fabian =?utf-8?Q?St=C3=A4ber?= <fabian@fstab.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-usb@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Sanath S <Sanath.S@amd.com>
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <1c354887-c2a5-4df5-978c-94a410341554@heusel.eu>
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
 <2024092318-pregnancy-handwoven-3458@gregkh>
 <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
 <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r2g5hm2ymbewdnd7"
Content-Disposition: inline
In-Reply-To: <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
X-Provags-ID: V03:K1:BjPWvExzBigPv2vqwI5gbQg2ztku8FsBxVkBPesQ+DjRjYGYudd
 jSBz7eJhclJO4C5lvz/Nbu8jNYMaNt8E8/KKvotSsQexSO+3e0D6LWSkV+gcDbtL+k6cEI1
 TsRsDIkRXM4uw7X6XCCU1Dx+kSBcEkANbJHTP+4bQEnRM0n7Xf4kOJoPQ90iiTtyzjSHPux
 wtI7C424MeQntInG0kIQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0gjPRFdoEVo=;MjhYOUkZBTlxjunj4ajPFCMLqlM
 50EmvNfDLXFJBbAYnxwidd3gf9GviSWVQo5fyC7pCyuhmv5sTKIUjWmq310y3bdVTbtWHF1FU
 4rYXHrUWXdTvo76NAEZIbfNvKS/TiWlLPUFBl3NWdoJGm4IzlTTac8hX2qfqb5fpNChNmbAz4
 S/3GCnihuuidxo3YlRSnsL8TvD9FYAbvmqwDRbZOrGrDE4lyTddxkW7M3sGSN/rrqsbQxU2qU
 TgCvcj5BXwToxM2GtQ8vuZp5xqNKSmTSuj3wH08rVraF8IkyjLJzpn177Vn2Fkg5ohWP9uC/X
 CesMuQseuTpwmlO2hcVE6H4BVASXhXkT6CktzP9MMFbCsTiLKAiXQsPUSAWaxyrwvZRw64nYE
 I0EbP+D7VFp2Nsaf6mI3zIETXrzF24YwM8yTEVMQs/mBV3rSPK4ZzXH/kpXJ4XKmkcFQDg4E5
 zJo1Btk+OWLB5ZqYbRfnSUGaZK144E0N4JltCJnmIt6gNzV8qd9RriIFINmjmZYkETJVCYhE4
 hmgbvukODRtz3c5GZIOxek3I1kLMCEyQl2UfCNobeFauPm1C5E+8v8VW4xf6ctCSbqpVsHIt/
 3+AsZMIEh7qaBvogtur6owANK+mxWueaz3aXORxWfhHBwqklCbm/3CoIK0WoGekcWb81N1JEK
 0vq6HBKJ3VtuAHb6ynHOzKKvK9yuwGc0Ll8K78wonQrTtwMibM4Or9oKKWFWQ8vtERufE42eM
 bH6twKHFeaY1G9bFOuB0RA3onrprYuKcw==


--r2g5hm2ymbewdnd7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
MIME-Version: 1.0

On 24/10/07 06:49PM, Fabian St=C3=A4ber wrote:
> Hi,

Hey Fabian,

> sorry for the delay, I ran git bisect, here's the output. If you need
> any additional info please let me know.
>=20
> 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 is the first bad commit
> commit 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 (HEAD)
> Author: Sanath S <Sanath.S@amd.com>
> Date:   Sat Jan 13 10:52:48 2024
>=20
>     thunderbolt: Reset topology created by the boot firmware
>=20
>     commit 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c upstream.

So there is a commit c67f926ec870 ("thunderbolt: Reset only non-USB4
host routers in resume") that carries a fixes tag for the commit that
you have bisected to. The commits should both be in v6.6.29 and onwards,
so in the same release that's causing you problems. Maybe the fix is
incomplete or has a missing dependency =F0=9F=A4=94

>     [...]
>     Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Sanath S <Sanath.S@amd.com>
>     Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I have added Mika, Mario and Sanath to the recipients, maybe they have
inputs on what would be useful debugging output.

In the meantime maybe also test if the issue is present with the latest
stable kernel ("linux" in the Arch packages) and with the latest release
candidate (you can find a precompiled version [here][0].

Cheers,
Chris

[0]: https://pkgbuild.com/\~gromit/linux-bisection-kernels/linux-mainline-6=
=2E12rc2-1-x86_64.pkg.tar.zst

>=20
>  drivers/thunderbolt/domain.c |  5 +++--
>  drivers/thunderbolt/icm.c    |  2 +-
>  drivers/thunderbolt/nhi.c    | 19 +++++++++++++------
>  drivers/thunderbolt/tb.c     | 26 +++++++++++++++++++-------
>  drivers/thunderbolt/tb.h     |  4 ++--
>  5 files changed, 38 insertions(+), 18 deletions(-)
>=20
> On Tue, Sep 24, 2024 at 8:58=E2=80=AFAM Fabian St=C3=A4ber <fabian@fstab.=
de> wrote:
> >
> > Hi Greg,
> >
> > I can reproduce the issue with the upstream Linux kernel: I compiled
> > 6.6.28 and 6.6.29 from source: 6.6.28 works, 6.6.29 doesn't.
> >
> > I'll learn how to do 'git bisect' to narrow it down to the offending co=
mmit.
> >
> > The non-lts kernel is also broken.
> >
> > Fabian
> >
> > On Mon, Sep 23, 2024 at 8:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
=2Eorg> wrote:
> > >
> > > On Mon, Sep 23, 2024 at 08:34:23AM +0200, Fabian St=C3=A4ber wrote:
> > > > Hi,
> > >
> > > Adding the linux-usb list.
> > >
> > > > I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
> > > > Linux for years without issues. However, updating to
> > > > linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using =
the
> > > > latest non-LTS kernel doesn't help, it also breaks the USB ports.
> > > >
> > > > Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
> > > > working version.
> > > >
> > > > I opened a thread on the Arch Linux forum
> > > > https://bbs.archlinux.org/viewtopic.php?id=3D299604 with some dmesg
> > > > output. However, it sounds like this is a regression in the Linux
> > > > kernel, so I'm posting this here as well.
> > > >
> > > > Let me know if you need any more info.
> > >
> > > Is there any way you can use 'git bisect' to test inbetween kernel
> > > versions/commits to find the offending change?
> > >
> > > Does the non-lts arch kernel work properly?
> > >
> > > thanks,
> > >
> > > greg k-h
>=20

--r2g5hm2ymbewdnd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmcEGIQACgkQwEfU8yi1
JYWu6hAArkE10LOzLErzMqMzPtC71J+/FVscIbL6mm0ayNG5cqkqMH0z5Po3g3FR
K45RxDqRs+Sro7GvV5GEB/0B6qiW7STGtxiQTC53Oryfumu//8iWzURw8qU6+SH5
Oi2Nag53QOnUk6SFZsqRLocNAPp3DTsgmpdtkradMdXIfQOC+bcB3QMB2b3nmj99
w4QLZ4v7CZicHaoaK7uLUuC6skI8iG2Jb9pePB0llzkoXXV9oF5hQSUWsSL0kzKm
dVJJMO4/hWSK1oOAcBBn6h5kimA9Vr1cYYHdCos0l1358up5mhJIVE7E3drI4gAx
KKsAl5KTPnPQp6yJxh7M1/qidrRDuo7p0d8FON6QUQyjGQJP5/73BH+imxkKVPRe
0cjpRAta9EiGs7IK4ojTrW3uz77z2d3xNU1shW/1FEksOLny56zeFL1jZUyYeht5
+42w5DC0xyEcPRF1BdaExoQNUnS0/6Zug7bWaW6Cj9sPls3mXJqxm1473DfdDyfk
/oqtQPnU0B9pMnububD57vxckmJPxnoKk0OBrEr+31LNGJsqNgqAZ6AAsrb9KeTr
vADMlh23at9RqK5gGTNvkcMnHzOjPHo4QxrEs1x5FI2KyHLL0L9TPUAm00jinn8/
nZMGfv1TLRus9QqD1Ua4NG5PjKrSZtmH56SpfRm5Bt1pbIXqicI=
=4RDe
-----END PGP SIGNATURE-----

--r2g5hm2ymbewdnd7--

