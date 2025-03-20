Return-Path: <stable+bounces-125626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B152AA6A345
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2248517E909
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9ED221DBD;
	Thu, 20 Mar 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="FXJTdbBH"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7E8F6D
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465118; cv=none; b=MzX4JLUg09AxeBQUKQYRRJDCO1pFyMGIKFahfp5c0dU/DDcJBe/HPt9KR2UZ3zPgOkrGoLb3MKpYEDur9RCXVbTl6DrbmMNb3dN6Mk85/uZ5krhiNO+rD4OpTpF2jjbhmBXAfQOOGtJdKJiqEBIxpVUm1WCxxc0jkSmH7pUXBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465118; c=relaxed/simple;
	bh=9i4rid+B0a9M1As4dYtLsRM2QicGrXaJS0sxCKnzXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCA6Dg+Q+NN3FenXKlVHZikdXJBDwKA/97nIb3O8g2Kj7/Mx0AxoA3rFFYa8GFAclGBox07mvwifapxvT96bUw/y+xMTD1ZJcHxP4n7yLuwjaULQG7yQs5ywgHo3FiqPuRodSZ0z1v497UelybIOIoxHfJ/3/mYdlkTfgYmB5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=FXJTdbBH; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1742465104; x=1743069904; i=christian@heusel.eu;
	bh=O259WitRMnPNf9M/mfci2FGhbtrEcN/0vuq9437Gs1s=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FXJTdbBHxNt6FP6LuAeslBXBwCs3iEvDlvAb29907ZHo7uJ31RdflIJBEKzo2/62
	 H7pYPRPBdEIiIVC0+fV+kSLkhYA1NMOxVJ7RskHoIiFYJnie7PdlnI+Glqm88lyaT
	 pIRQ5LQMl2/ZIrhYkQc6/3ubAK2QMdqtJ5O51VXlnZ36vk4Jyd7YXY/fx1GOXMyvB
	 JLP6GLQ8iqaNjvPUwgnPQWvubiBYxUHw9wOf6nliCl80XaGzsRYsv5quDIFuFkPw0
	 I2syysSVlFmJEyPDEsnvehFjZAwPrNyWfTesOsXSQfJSejUvWArLoZj4gMDUqfSUF
	 zp/xakD2fIZ+tMqnvw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MGhi0-1tz2XF401K-0060yv; Thu, 20
 Mar 2025 11:05:04 +0100
Date: Thu, 20 Mar 2025 11:05:03 +0100
From: Christian Heusel <christian@heusel.eu>
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Regression: mt7921e unable to change power state from d3cold to
 d0 - 6.12.x broken, past LTS 6.6.x works
Message-ID: <38658f1a-216b-470d-99a2-13d66f075c77@heusel.eu>
References: <415e7c31-1e8d-499b-911e-33569c29ebe0@gmail.com>
 <2025031923-rocklike-unbitten-9e90@gregkh>
 <5e260035-1f1b-4444-b3b8-1b5757e5ed08@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uxkrpkjabcczwb7k"
Content-Disposition: inline
In-Reply-To: <5e260035-1f1b-4444-b3b8-1b5757e5ed08@gmail.com>
X-Provags-ID: V03:K1:gOaDmC79hKQhWdK0xwi3mecG6DIwVzHNHUKXV/828rbHLlLDhwk
 2C9O3l/3vA7hScsrZKQV/QOD6IAYwZ6s/8KFCPd81QL0lS84+k7tpTRkl2WMyTZV0m5t2Do
 SxW2oZy8MqT9BzCMSLtaXojK20sXtQxOoylS19TOGqSwuOwiBvVjtmp2LNKTwblrk+v/QUN
 cta7XB/kJYNA682mKC2Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tmp2XAJDBnM=;wE5BafzQWipxDJ4lwBcUui4vIdt
 Cy8ZiWYcKcwaL/YqTXQfUPcUJMzdCxAJlZCcOqXOuOwNvTO/RaHhn8KCCukRzCJ80IOV7sg8P
 Lx+71BjF55xG7KKd0vxxqJcyDZhb7tTjsN3UqEonLWWRNWap5uOo9GLvoOCaBGHdgiSiuJwkC
 5kQWMEHHgIYE9+sM3+RiEBTdQgfunFP/pyTsyTvxDW3DI2cF5ayS+WGbTmg+VKIwv1ntklfTq
 bcvTOUr1UT8IOL/2nRSyecuQXgTjR5MAjahUOdNfBAK2bJaLzMgaB+piwVnVeu4uthKL+C7Jh
 fDaWNCgPUKxueXh0vasIdjimml79LjRDEcluOk2FsUH0uiPiXZ/p5Vze07QPAsPAvVl57FysG
 QgPHYuj0JpZFyuArG/JgFETI2x2MRxyD3LGayE+tMNCKDZ9utWjSt/0UqEIzyxKRKi7JBVIaM
 nGiDPNDGkg5Adli16yGu9xun75Qmtl/55zXrsTxbz8PzqeXSOdkQxRUhIZSzS/P2D4OChJtDr
 BQL4upykE+5nFpO0IznHehtxS3RoZNluVMrQIb8L5pZ3BZ7n9EuIqj+9mu+qEaEJlCdcozesq
 2Ut3UAiBwOTjTmTnAqcLvNOmucuiKgRBF5p90NKJPI1RB5+ta6lA+h5rHqQyO3Yiq1/IMKC3y
 a3IQeO1PKbBInhEV2FFtYlZ2IRy+ItGf/AKL3EiD9XBY5tfTaAA2lX07ZWXb50eUG09/x9cci
 KA4FD0I06R7qjMc84pzqJgj/GdbveA7F0CSIoNJ91mlaDxVhmR7ZC9URgvdQMeqxzhri9IbTp
 Jg8rpFGtxSxRak2TB/lnCR1IV3juPIqB+73Q4Jraqbl4iY91U46Rd2OBLY/l83QTf3FYiMJmM
 78+ZcPf5xo7b5DzlqfWc1fOyPfuoMhErU1GAfBzuc101dD7qWZO6knjlhAyxhpf1hJhS9hbTJ
 LSO0DpAr+GedE3mJwfuoOBotdhCkO4QlGbubYcudGR7UQl9/TPxZzUhwqMsktQqHPL+jeeUCu
 TnNn4za0ilGJU8hZyYT2PVyagYc94k7xTj9YOXkw8DBxa0tvAtIODjpGgjDPP31sMw+UDzPgm
 VKW/qNRX3GGQ5xNGFWZVpCmiJewj2RMdSstygg9vL6yUsQM2Nic0DXjiW0Cn30Mp/23aZqjue
 BN0NFzUvFs8/niQfltfIygJGBbtdRCCOuYyOb1h+X0Yc2J6MS9FqGVXexqVI5sHlS1JlzAFbQ
 +5lcivdVvetqazTv/UcFjOrl2Au3pyhTAFvOg/diFxxl4JhCAquNSSMIPIc2l8Sll+XHFCeT3
 k/VNCNQ+BfxPCC85+SV0/N59VozPMiyZxvwdaFeg01BbXxG38wz3enjGw7vhL2yQQkBTCOpeH
 rMtpLH9/iPOVPbBsS4V8GfCyAwRE+v7j0sDz4=


--uxkrpkjabcczwb7k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Regression: mt7921e unable to change power state from d3cold to
 d0 - 6.12.x broken, past LTS 6.6.x works
MIME-Version: 1.0

Hey Sergio,

On 25/03/20 08:49AM, Sergio Callegari wrote:
> Might be able to test on the distro built kernels that basically trace the
> releases and stable point releases. This should start helping bracketing =
the
> problem a bit better as a starter. But it is going to take a lot of time,
> since the issue happens when the machine fails to get out of hibernation,
> that is not always, and obvioulsy I need to try avoiding this situation as
> much as possible.

Which linux distro are you using? If you're on Arch Linux I can provide
you with prebuilt images for the bisection :)

>=20
> Incidentally, the machine seems to hibernate-resume just fine. It is when=
 I
> suspend-then-hibernate that I get the failures.
>=20
> Before contacting the network driver authors, I just wanted to query whet=
her
> the issue is likely in it or in the power-management or pcie subsystems.
>=20
> Thanks,
> Sergio

Cheers,
Chris

>=20
> On 20/03/2025 00:54, Greg KH wrote:
> > On Wed, Mar 19, 2025 at 08:38:52PM +0100, Sergio Callegari wrote:
> > > There is a nasty regression wrt mt7921e in the last LTS series (6.12)=
=2E If
> > > your computer crashes or fails to get out of hibernation, then at the=
 next
> > > boot the mt7921e wifi does not work, with dmesg reporting that it is =
unable
> > > to change power state from d3cold to d0.
> > >=20
> > > The issue is nasty, because rebooting won't help.
> >=20
> > Can you do a 'git bisect' to track down the issue?  Also, maybe letting
> > the network driver authors know about this would be good.
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
>=20

--uxkrpkjabcczwb7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfb6E8ACgkQwEfU8yi1
JYXsRhAAtiyY1Lg+xIe2aUbc6YNJoo+YiB+IMbohEVRcluzqaGiGhSWPvRv2JB6k
emHerCCLLSUd+uDuU0yE380AqquXKsb0jikzxkR2BNluCdmF0Q6zxS6PoLUqqh2g
oxp7XwOaJ5VEksLivM9tc/O0s4Tn+V4wfW790P3P0HwPi4lPGFXegrxxE5dykSzF
kPGgUYCE1hmI4nLDQ86jax0CprqfE5THkuiwONfrcQLfSY3Su8sb9Ez4nWFznt8M
cqiL3qBmOCVTGZ68LiRvbRPZ/7jVxNfeE2/fYeq5uxEs0u7eO83mbOv3nenTB6Ac
qH6Vta6mhy0Tp4K7qVfjx7o4nSzX7/GukoVjy4yIcJl0Wp1EqCjP1Y4skadOtKX7
/hopjQCHZbkWWQAi5ncuw0fZHrykqkhb45ZW6sdtn7wro7scYKyqkmJV9QyFj/s7
O1qAIRNd4IAdmtQN0XRTmD3h1vULKzbx7MfkthyPYTynpp4aipXWvewJLEboqkdR
hkU0YyLzlfXcFTNy2EvVJ2DNYYyenYoHLAANvr188od2qeO5L4il9a2eJskuzwlw
fxof4tkjkOj0c8aRGTHLGgF9ZgaFkFrG+uzkoGOWt1fAERIsWwznpIfo4ZJCJB+W
Kqz63UdS7cRPGV6d5mVL6bamGu4a/9VRVtQUI0RKr5hvbSKctec=
=bzAH
-----END PGP SIGNATURE-----

--uxkrpkjabcczwb7k--

