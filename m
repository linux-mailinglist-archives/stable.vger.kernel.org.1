Return-Path: <stable+bounces-67621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5BA951871
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63832839ED
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995F1AD9CF;
	Wed, 14 Aug 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="zQ7eWnJE"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8C60B96;
	Wed, 14 Aug 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630309; cv=none; b=cSZKOU4aiS2BotOF8aTfGVKSZQwC0XPC7gd1zuZVVTd7sJwOJ47P8cql58UsozMElI6bfV/7E6TN0iRXamyt9fQYNcuVic+LQ4VjFm0Pnt2SQC4UMTKMTj7M5IMXsVOIwXvn7aX1YoHZ1uP9xbIZATptP1eLVQL3RC1RaiRddl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630309; c=relaxed/simple;
	bh=gSCIJAjvmTgIynjqWMZZVI/qzc8vdXECxlDegaa88sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldCXRqNunH2EHYzSRSK/fdf5QlVszL4Y9qd+gQ/hBoSk97XddSCSUdRO6coftvUjWUstMVXAlxLcxMsBrJ96p0YEaxUdKokGk3W0D08Mv33NKDHm6YpWH8stjhkhEO+KzA8xYumeM3CyYLsphUbQu1iUaS/DNSceoeaJeCaZBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=zQ7eWnJE; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723630288; x=1724235088; i=christian@heusel.eu;
	bh=CDLABFtqCikjyatU7UNWwTnvi6lYTc5e87Rh5YmROqA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=zQ7eWnJEe1bFX0SD+B2OkXuEb4gYWgb8Ldc4ifrwgcy5sRZ6ApB0Vgv958c9jRAE
	 l44FJxJ9sAwh2cn8GhacNYIwHPhb1MSfhgtTfig2jGgrdduGEaB6OBMQ+SFmJMK9b
	 /XnTD5FT5ROxjlr0uJUfsO2+LAhaoK779SpkLejIq8oHZi7RpKMuOl7mmzAMNTNlL
	 u5joeThG5dvNka3fSpjUSsg06+4HiRtTOh8xbS4daJYbj7KKDz/fbMku++WsKiwso
	 177V1eF2SEZyq1S/nF9MkSGV30XhNznCVZO6M4tcd3onEPRqh8kNO2Yoibb8jUAYa
	 aIebMJJcmD8FsEXfuw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.132.14]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MulVd-1sNKit1sWp-00vm6B; Wed, 14 Aug 2024 12:05:40 +0200
Date: Wed, 14 Aug 2024 12:05:38 +0200
From: Christian Heusel <christian@heusel.eu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, avladu@cloudbasesolutions.com, 
	willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com, arefev@swemel.ru, davem@davemloft.net, 
	edumazet@google.com, jasowang@redhat.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org, willemb@google.com, 
	regressions@lists.linux.dev
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v54pu6pztjzufuzm"
Content-Disposition: inline
In-Reply-To: <20240814055408-mutt-send-email-mst@kernel.org>
X-Provags-ID: V03:K1:3r0TRlbShhcdW6ddM6y4IrMqeSpfYyd8s5n+jwIKsQ1tlraaJPI
 wZlxrgUd7jLrgRLwMPFIvBoWKxqtzlIGz6eZLoDhsey12com7sOTAf8tQvP3Tq3cC5cOciy
 B39zD6HC6QeLj7EjF9N3AQ3BHXIqPCECL31AsAv+x2n79I0eIn8Irq2FEnWWHS7WtFxFQBx
 a77zNM5ctniJZINgzT6DQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C8Qw8if6FsA=;SNJ+gQKzZvB/VY7i+ZXiUMXn+ux
 IJCRX3iUe7f02xtRqxoYcWROE5lB//YLJCGpFtVi4NzI0A4GnbgsOQ2wT+YGJnLVM1eeTGVfX
 /wMXuafuM3AF422zNyVz8SraSwUgXddcOffMPLk+syBszJ1uJkePGla8oQ54AsiPXHoXjb2Da
 Pi7rIabC/Quo9EPjfi8y72MS7Tj+E6geuqlm0v7OVn+gGYd4WEWlnPavXP3tnNZhj/EnBtfOZ
 tsupbLx0MHHAr20Gebsiik5pnVTqctiWkNst1IlLsLgoH8dCOTZFNO1ESdtM+QnQB2vXqcq98
 LZUjVGysqNliIlxRfPT0Xd39VCjWRVoo7FSU34/xpuNGERuzbKJsUlfFvYCJsqVbrMO1rOU8y
 UDTGmTzlnMkySki6BckK5sfpfLipgCqV03hWzH+raGJubtsu7vJBu+xZIWO6GJ5docHK7jU33
 uD3UzwQvtdPefbq/ba+EBg6S1G96NNcVSqzyIX9ki93UWh10h1ylaG+Oqu+Ykscfwn8zuhu4H
 Fx5YxMo35XISTr+7exjSSbrjhPDCui7vKi3xMgmIsIr2o/SGfKkOtn5AnZ0YQsJF8xdv/XpDR
 Ht1Zj9zhhSTX6l6dTyJ86asNINMhxg3z/bhWfeV+u0Rgr1DSjS5ZD7I+WAkK8rdumk6HPKtdM
 L0tlP4rpu6s8obbZoxOWDGcG6/VpFoCeXorCnxePFq4X1zkRSpKHBaG2JqFpEYmm+tDrkwZYL
 nwXirEX3pbpwsIO6gHZThB+h5BN1ZMs1g==


--v54pu6pztjzufuzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/14 05:54AM, Michael S. Tsirkin wrote:
> On Wed, Aug 14, 2024 at 11:46:30AM +0200, Christian Heusel wrote:
> > On 24/08/08 11:52AM, Christian Heusel wrote:
> > > On 24/08/08 08:38AM, Greg KH wrote:
> > > > On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:
> > > > > On 24/08/07 04:12PM, Greg KH wrote:
> > > > > > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolut=
ions.com wrote:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > This patch needs to be backported to the stable 6.1.x and 6.6=
4.x branches, as the initial patch https://github.com/torvalds/linux/commit=
/e269d79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/inclu=
de/linux/virtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b56c=
1b64b0775
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/commit/include/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f=
6410471efc1dd71b33e894cf
> > > > > >=20
> > > > > > Please provide a working backport, the change does not properly
> > > > > > cherry-pick.
> > > > > >=20
> > > > > > greg k-h
> > > > >=20
> > > > > Hey Greg, hey Sasha,
> > > > >=20
> > > > > this patch also needs backporting to the 6.6.y and 6.10.y series =
as the
> > > > > buggy commit was backported to to all three series.
> > > >=20
> > > > What buggy commit?
> > >=20
> > > The issue is that commit e269d79c7d35 ("net: missing check virtio")
> > > introduces a bug which is fixed by 89add40066f9 ("net: drop bad gso
> > > csum_start and offset in virtio_net_hdr") which it also carries a
> > > "Fixes:" tag for.
> > >=20
> > > Therefore it would be good to also get 89add40066f9 backported.
> > >=20
> > > > And how was this tested, it does not apply cleanly to the trees for=
 me
> > > > at all.
> > >=20
> > > I have tested this with the procedure as described in [0]:
> > >=20
> > >     $ git switch linux-6.10.y
> > >     $ git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0c50e
> > >     Auto-merging net/ipv4/udp_offload.c
> > >     [linux-6.10.y fbc0d2bea065] net: drop bad gso csum_start and offs=
et in virtio_net_hdr
> > >      Author: Willem de Bruijn <willemb@google.com>
> > >      Date: Mon Jul 29 16:10:12 2024 -0400
> > >      3 files changed, 12 insertions(+), 11 deletions(-)
> > >=20
> > > This also works for linux-6.6.y, but not for linux-6.1.y, as it fails
> > > with a merge error there.
> > >=20
> > > The relevant commit is confirmed to fix the issue in the relevant Git=
hu
> > > issue here[1]:
> > >=20
> > >     @marek22k commented
> > >     > They both fix the problem for me.
> > >=20
> > > > confused,
> > >=20
> > > Sorry for the confusion! I hope the above clears things up a little :)
> > >=20
> > > > greg k-h
> > >=20
> > > Cheers,
> > > Christian
> > >=20
> > > [0]: https://lore.kernel.org/all/2024060624-platinum-ladies-9214@greg=
kh/
> > > [1]: https://github.com/tailscale/tailscale/issues/13041#issuecomment=
-2272326491
> >=20
> > Since I didn't hear from anybody so far about the above issue it's a bit
> > unclear on how to proceed here. I still think that I would make sense to
> > go with my above suggestion about patching at least 2 out of the 3
> > stable series where the patch applies cleanly.
> >=20
> > 	~ Chris
>=20
>=20
>=20
> Do what Greg said:
>=20
> 	Please provide a working backport, the change does not properly
> 	cherry-pick.
>=20
> that means, post backported patches to stable, copy list.

Alright, will do!

--v54pu6pztjzufuzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma8gXIACgkQwEfU8yi1
JYXqCxAAr38hvUiyFDyyNtXLHY+lWWJPTMSMUrF+g9eSdXEE3xiSNkvQzkaOqA1z
kEPk7WaVU8A2WWObLwRV3i5MU2+YQMBKx1SNyZN5QBkEbWSY4IpWo3G8AdMEvUjo
LA7L75dKeIcPRFq5ZFYb6Zox4cs8N2wY/pQ/e8t219SdRFkcHGIWXk4/IboZknXm
TNO5RdG5gtv/xnMAQgfum1NRnDkFaULR4gqOwBN6Gsx2iPXMYjdGl6PkT1JWXBdN
Ro680wL73Q02ney1aTHo1Xo2poavPWWWlXMGVWhd+5nhz9L3dnbh5wuOTENqA627
sdhNv29/lSGRf7HbD9fi+nbYpNiSLuuGQ5YrrSYnY7SHaf02OlEWh2PCWI3jHQ13
tBMY5uEAQ/IC8AZ9XIlWFnoJt7PqBhQzjcccKDcUsdi+zjKNdauxwwSfLmij6c2T
4EIkT50X39H99F7A3AwGnM3ODXsiPiVbFdD2RzpGLMP8XREUegtbMWucW4Kt3hes
/Z8thZZdx4DdLREXlFrXq6Imh0+tvKmztywcC+mu8qr+VaKVZC5hNwtRvlJUzU7n
fwWSQ8v0+JTFrlN/Q4smsWpLuSlG5Hfi9JXVeWjej67EKFRpfF9GFdb2QoCaJeux
LRpMMDFE4bQmGbBnU0zTLMy8JYitEmwS+Dj8ZtkZniLXAvWH2W4=
=ci4z
-----END PGP SIGNATURE-----

--v54pu6pztjzufuzm--

