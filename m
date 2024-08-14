Return-Path: <stable+bounces-67617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E278B95182C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58046B237AF
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D51AE030;
	Wed, 14 Aug 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="OhECLRBr"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A01AD9EE;
	Wed, 14 Aug 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629640; cv=none; b=YFXh914WbC3s/qauBUDXjZSTqHI5SXHBvtYN1BvKkAkZG8VDUKOxHAbdxBpel5LRsnt4ypl+K7M1swhGjvghucsIseDBSmZs4UdJz2fxcvHeak9VX/qPqPWjFiwBvv676HXs4AbMe9vvnJRdc7G8x1U727iNDFgXX9oTWUH6x5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629640; c=relaxed/simple;
	bh=sqT577nAbUsMEOsuMnHzpa0wXYIYsj5igcWcJy972GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiWZdJ7gYAMRBxbVGyZl2jc8fHbo+AOhiO5MiS0+OU0BXVYPmrAAAwMMKRjR1z23izwbQIILyeTiwTDi+JLqTqNkr1vCJSErXBskrV/N4GveS50NmVFp0gexbBJc6g4Gx2o2Nd2h8hmJ55X56r6XjmovynnTs+XXw0/ItS3OVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=OhECLRBr; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723629635; x=1724234435; i=christian@heusel.eu;
	bh=aXUAzAt/Xa4BzWb4o8KVaXMXRWHP/DGLw4/QNcQNPaw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OhECLRBrC93XkMjzBeg5JdFNbPy6Ldyu8yWkwMH0ZlzaB6QpQTKG1B1btfN4jRGK
	 8vmB2rvxUF8wCsowG/lJ70srzgduEo3o6+oYw63Uuddnw0H7pQ/ncu8b7NfaevKwv
	 TbZ6qdJKGKxyaVthS5+wrRCx2SD32BqwVEIr7xfd5YduOEkNqejAPcjfACxYowzCr
	 RuM6mA1nYUsOoMUgjRVJGyvWpPx7yQSaTUn5fJUBACpU+30u8qbyn5CIa+KLGjFLg
	 NQQaKnDWFWQkxkK0JNsdiJdVtsRiGKNbBULa4kY3kQ9V8ugc4+bx5SheN6tygle3A
	 pkWunsT01QHSizwueA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.132.14]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTzve-1snPxq1HsI-00XzbY; Wed, 14 Aug 2024 11:46:32 +0200
Date: Wed, 14 Aug 2024 11:46:30 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: avladu@cloudbasesolutions.com, willemdebruijn.kernel@gmail.com, 
	alexander.duyck@gmail.com, arefev@swemel.ru, davem@davemloft.net, edumazet@google.com, 
	jasowang@redhat.com, kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org, willemb@google.com, 
	regressions@lists.linux.dev
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2mzl5l6sgb6uplk5"
Content-Disposition: inline
In-Reply-To: <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
X-Provags-ID: V03:K1:OQn6Lp+6oyiAbiERKIBwzgLEG9lNFwdubjCxGrBhmRrEjKKAovD
 M9eUn+t+LAuoOPUAuuz9wn7/UI2tUpX+i+slh4ccpmk1rvHmXJPSfHngX2JfhewZmmTcIag
 nuZDiokyFTQLQL+UwwjkobY73VrhjvzXtPylOsmyMp1i8YR975A2QurdFzLngCcsVjc0os2
 ilJUIkyy1lI57wePjeW5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HIUIR4bgoXE=;lVNke9+rOe0wp8jGamQzkFrNwo6
 Vw2GwhKHNtFhzcVKrKFsYsZ2NAoHL+j4L9LHwUY2fUq8M5jJe11foiHDuHmuYTI2Vg6fPTEs6
 0Ec68DUQU7JCtWzKV5U2sohJPFTZIJuPi1K5WkXAZGgI7DCEsotQLRa21lLOFFyeYbdLiSZVh
 9GrC8+8xuL0p0b11QbvF4lQuFAt+/KPbk91vSe9AudxNoi3zFvaEhcjP93PiGSFS92FTwwEJl
 0ABDCZWoIuHeZ3XSCBuocz5MDJrhwxlpYZ4wr0saWLgShR7gH8cCKaOeVOboFDhf76b193q+B
 vpUgjkkWe1ybOAx+U5As4AZZnbMXV0dHiYqh1iXk1zSN5K0R+e+9ccof1bVW6uVfsH84YnxKZ
 bhvUxCG8S0aISSFKB6+r1CmmrQA6ObsGj8SDRE7NlaUlS+MrnFQeuXiNpX4sLPFkTSsFTv5jf
 r+bROymu8VTaTD95pyYiBjFwnUnS88Fv4Tj/UyP8SXQFa+KgiEPNj2sfjAVROXzzq3dfw79ga
 EDkSWSFW3N8l55TpAba0Flgjkv7FyKjttUYQk6GoUW3tW0tkeK1pmV4k5oY11SxxbjjCtuu0y
 h85nthA9kC5MLi5ZsekFUquvsCJ8TxAhAKgK2McxPGE6+3E2yAWCs9pzOUBtFCXdXupOPAPGy
 hfA2RR8aZR4uQ7VhL2WRrrfp2TrF4C5MH1Uv0uOMobi4l1CaiMxa3wboAoI074efEKvs90B7e
 zWZPSajggpnzC1DfBygTA1uDYc8R4lDIw==


--2mzl5l6sgb6uplk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/08 11:52AM, Christian Heusel wrote:
> On 24/08/08 08:38AM, Greg KH wrote:
> > On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:
> > > On 24/08/07 04:12PM, Greg KH wrote:
> > > > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions=
=2Ecom wrote:
> > > > > Hello,
> > > > >=20
> > > > > This patch needs to be backported to the stable 6.1.x and 6.64.x =
branches, as the initial patch https://github.com/torvalds/linux/commit/e26=
9d79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https:=
//git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/l=
inux/virtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b56c1b64=
b0775
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
commit/include/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f6410=
471efc1dd71b33e894cf
> > > >=20
> > > > Please provide a working backport, the change does not properly
> > > > cherry-pick.
> > > >=20
> > > > greg k-h
> > >=20
> > > Hey Greg, hey Sasha,
> > >=20
> > > this patch also needs backporting to the 6.6.y and 6.10.y series as t=
he
> > > buggy commit was backported to to all three series.
> >=20
> > What buggy commit?
>=20
> The issue is that commit e269d79c7d35 ("net: missing check virtio")
> introduces a bug which is fixed by 89add40066f9 ("net: drop bad gso
> csum_start and offset in virtio_net_hdr") which it also carries a
> "Fixes:" tag for.
>=20
> Therefore it would be good to also get 89add40066f9 backported.
>=20
> > And how was this tested, it does not apply cleanly to the trees for me
> > at all.
>=20
> I have tested this with the procedure as described in [0]:
>=20
>     $ git switch linux-6.10.y
>     $ git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0c50e
>     Auto-merging net/ipv4/udp_offload.c
>     [linux-6.10.y fbc0d2bea065] net: drop bad gso csum_start and offset i=
n virtio_net_hdr
>      Author: Willem de Bruijn <willemb@google.com>
>      Date: Mon Jul 29 16:10:12 2024 -0400
>      3 files changed, 12 insertions(+), 11 deletions(-)
>=20
> This also works for linux-6.6.y, but not for linux-6.1.y, as it fails
> with a merge error there.
>=20
> The relevant commit is confirmed to fix the issue in the relevant Githu
> issue here[1]:
>=20
>     @marek22k commented
>     > They both fix the problem for me.
>=20
> > confused,
>=20
> Sorry for the confusion! I hope the above clears things up a little :)
>=20
> > greg k-h
>=20
> Cheers,
> Christian
>=20
> [0]: https://lore.kernel.org/all/2024060624-platinum-ladies-9214@gregkh/
> [1]: https://github.com/tailscale/tailscale/issues/13041#issuecomment-227=
2326491

Since I didn't hear from anybody so far about the above issue it's a bit
unclear on how to proceed here. I still think that I would make sense to
go with my above suggestion about patching at least 2 out of the 3
stable series where the patch applies cleanly.

	~ Chris

--2mzl5l6sgb6uplk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma8fPYACgkQwEfU8yi1
JYVymBAAzP5fIg+bFUsU5LnKu5GXrSkr61UKgNv4C+2NVB7TigjYoQz30kXEWJPz
6Tx00F5cryBPPN3IuCn+5QBFnx+g62ZCFUay6nUC/gzlWcfFAPCPAXDrziYyc+eD
TCCZLyNSXwGaeXJwPCOIpW170Ep4yWK0ilaliUtEzSHGLfWzF9Jcl4xL6hhJ8xA8
q7KQ2WwrdD+7Q7jMiVXric0yMI6zyan3Lqg4PyLgsvVW6ZqfO3FMsY8LM1WI0peR
J/+w9PzQCbooi8WRsuHo2GcGzNNnjT8n6zILwObLOs37dcqAusHR22zyNozTXal2
ha1qs98ijwXnsm6wQq7e4eh7SI59xbO8WU3/bHLh3ip9Q/w3f6gO10/kIObq2Ctz
0rb8+SOv+mRfGiog1dofV8O6RHTYIV1bwkohP24lYdz2u8WnFfqpijuieaSwo4r4
RasMGBnkV00k2aBJwnG4VhUuHm1fEdnbM7iUD2pGmrXDOVbiB19n4KeXkXmO+Fp4
O22a6+/HFK1m0oJ8cX+H/YoiYkym/D5bHVriAsbDQfS1Br/Ex8eS4KFMo29Vlw9t
3/HSAkrj2IpxS1ZRIg8lTWK9HB6mxs7KUowo8qPI/HrglObSpJTewVciC++0FazZ
hwpeOOyOgJiggPBBhSVZft5RJFNH/v2IrJ0qrd4CnSrmr24TWeQ=
=U63T
-----END PGP SIGNATURE-----

--2mzl5l6sgb6uplk5--

