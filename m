Return-Path: <stable+bounces-65950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA0794AFFD
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F2FB21415
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6087785654;
	Wed,  7 Aug 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="k8/eayfk"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF3B646;
	Wed,  7 Aug 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056555; cv=none; b=gOLr0V1MF9aFbaepYyzRyTmPQdjC5y1tQ0AgiDpyAhg3dbpjDAclDazBt95km8R3bVCoM0qVn0dCkKv3qpnYx5RkKoPJH3/T1A4XBdq8nBebTsPWZTIZN8ao4LD3N6jEgYU9NO3270SiXV93aJNTH7hZQ6X54tivEusd8wvsFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056555; c=relaxed/simple;
	bh=9HOAv6VuH3cb5sD8DD5RBRP8nLdpXZgvCihMX0QS4DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFJG6xk32wuM4uqz4t4ANtmDzf4me/lI556nEXszHEQXVxM3C/9o4eX8EijrKqDjUK8Nb1b3HBubQKtpiDKEG3xVKI2YNEiJD8y9k/8QPJ7bOjD2lbIO1/EOF0Zjav2mXM3n1qXW/7DhXuduX7oDqFC2wYMG5PN7J+G3gn+V5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=k8/eayfk; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723056545; x=1723661345; i=christian@heusel.eu;
	bh=9HOAv6VuH3cb5sD8DD5RBRP8nLdpXZgvCihMX0QS4DM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k8/eayfkJhk2hB/oQXlP6TRiecPMy0khBq/tUm8IJ+6o9ewgrQMBzWM8CF5lGmax
	 XV2CUEfzwIv+CzbOzYlttjBZfVsmU8bCuqy7BvKg5cEXq/0Urd89CkG//7934KiE6
	 aCGxtaI5RgG11EYGSkc+D/NINW8o0yZWJN0XUbNvLNre6M1QD4oTmo4a3eJp7p0Wh
	 XL4yKMJI7GGq0lFwcjkLgndd1do2dvTY5/Kr9wfYN3VZ+KFTPgRtLyhearxogoCnw
	 FQ4A7awErRiCFepijzyYFzihyTvn/Is9i7dDshcP6pOStAuMJ4xV5FNdiq3YDILNm
	 61UJL8U8UpQUMBQFsQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.64.180]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQdtO-1spYj73gFa-00LuZZ; Wed, 07 Aug 2024 20:34:52 +0200
Date: Wed, 7 Aug 2024 20:34:48 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: avladu@cloudbasesolutions.com, willemdebruijn.kernel@gmail.com, 
	alexander.duyck@gmail.com, arefev@swemel.ru, davem@davemloft.net, edumazet@google.com, 
	jasowang@redhat.com, kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kikuexp3eyipzu4s"
Content-Disposition: inline
In-Reply-To: <2024080703-unafraid-chastise-acf0@gregkh>
X-Provags-ID: V03:K1:3LzPpijhS8I8kEe8NEk9gccv7iZuiRPAyJkndIEjAZJM/5fWul0
 PyO3yXrBl6EkaAeoc2B3VQH+afnpRolfk+sFY2S2W8NwzYsePtG4Y1nwrLh8NAXsdvLu77V
 jbosQXowocJPa1IykyEECnbYYn/NZx4dtMhQIeDpdbYPZFZNSofuDWZ8usHKM2vFdi0xqGK
 9//d/ZHFF4BOH9ZzTBUWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JuDVVyQwiE8=;+Jbf3OtI3ORHgTy0F6Fr0EoCroZ
 RHsNnHBJHyA9SZ3lUUv7/iaEU687LVjDNb3M6+L3J/k2hg7kPK0de2pLJIaSwDktJlyTesc9P
 0Pf7dk4B2897kaJcUlRdog6P5YT7NiY7YjVEvNLoJ4Fbki+oDXoYolxg+pQVLHKdqm92NaQcK
 h7j4X87g54SoH7t0LsUv9RodQL6Sc+4nYwWLMI/8vF7hWMijTCiykiYKCoEiu0eV4RjvSAt4t
 700RJq2cWdBL39xoY3JzILuqe7svpLKbxOa/iceNgA8JgvPhYmoQbJAJ1pzFHHeNQQMYWASD3
 wJVFDJQlHGuQraVEpi6VT8owSsnXCJ+rsqz75xQCGoGBOuo69a1uEBc3xBKCNnYSzmQbgrMU5
 mS7/tkz2PZ7mYyI8dGieIC/zYIuAqzRb4KOv+69eIxHMqyhBLzp69N0lsfSo+J6qfFNx6MOhS
 4+cvqljPRlqq8fem3+6u5yMzVNVEf+1cn1BFvti94ZSzaGykG9yT3X91LsgI6rQKecqj3x6Dq
 5vcsEKIaRHz3z4OcRU4YeAWq9O+TnCjdgKYuhYn1mwL95HVDljwkuvAGYl4zlBV5iRdvPXHuZ
 xIKTF5bq0FgXBk2pv3wEl7duiMKfbjyz4cH2ExNdrqDweZPdPjoH32Hex1hw7v4q+FGSRDcE7
 6yYMY9Isz3W4ZLAXbfD4zo66/hFSZUxIEUVSM+ES5H5HxMex8ankmxzh7rNJPsxnuh/vJZbJx
 g98fOA4J5FdB/rHhwGIBsdWsuNFUHJNLg==


--kikuexp3eyipzu4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/07 04:12PM, Greg KH wrote:
> On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.com w=
rote:
> > Hello,
> >=20
> > This patch needs to be backported to the stable 6.1.x and 6.64.x branch=
es, as the initial patch https://github.com/torvalds/linux/commit/e269d79c7=
d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https://git.=
kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/v=
irtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b56c1b64b0775
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/include/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f6410471efc=
1dd71b33e894cf
>=20
> Please provide a working backport, the change does not properly
> cherry-pick.
>=20
> greg k-h

Hey Greg, hey Sasha,

this patch also needs backporting to the 6.6.y and 6.10.y series as the
buggy commit was backported to to all three series.

I have tested against my local trees and it seems to apply cleanly on
top of 6.6 and 6.10, yet if it helps I can also send out patches for
stable versions of those, so we can have the fix for two out of three
series while we wait for the backported version for 6.1.

I also saw that the patch didn't make it to 6.10.4rc1 and is not in
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.10

Cheers,
Chris

--kikuexp3eyipzu4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmazvkcACgkQwEfU8yi1
JYX2zQ//XKpc/W6V90uniwder3rjoXwILdn1u3qa4oyycptpaC02xy0l1r/wZLn7
8Y7DKxTDAlXo2jHjBnifXmxsif0wmQZ09N2SW7rJAlGzpdsb3GZx0Yit/Nc81eiF
jOf2JqcI/zYay7+g1wO+iqINEaNDcJtTqfpA7cWTL1yY4KUN630w53v8I34Yxb93
8rJF4B/6/UJ8uYm4UhCz3vyYhRRRlvB9xl/GFgTaIgKY1VmMWeDKoHIw6Z1q4mRD
EtebOhTtohAZj2RPSsNjMa1SWZ1NVhRy9oX0ILml94mFf7TGQ1JK9AdGsvCtgIxM
afbpY9iaKYKlcvG+tcLg/ZlJZ/+shSgtpp+3wx1D/fieFFYomLyVzyavVYbpmGI4
9p/jGANpa1KjImCNIeocTIyRxA0wc07pmO1ICfOPYBIUSgC1jqOZuMwjksw3JK0J
fnAXZyP3t0L/ngWY0X1VnyAgyqInAaWmV1m2OX9lKNh9dmGasswc+kTJ8XlBiXGR
MmDiAD6OfbulrWI0Pa6cJ85S0sKgReiNWOzPlBNTfJgXVwidvRzNhu4Vv8ffCp0u
edjcAigRt0ExNSbscYA5w79CbylgYOsnZPnMZB4GgkzDXz6SaPfTe7s1l2WrtQQf
w6QbMf0FH6Nfq3A/X17zB8H/+dmdOQ78CH9GfORyluZrVBN2/mo=
=jXKu
-----END PGP SIGNATURE-----

--kikuexp3eyipzu4s--

