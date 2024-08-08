Return-Path: <stable+bounces-66017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE59894BA19
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E1D282A45
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388A181328;
	Thu,  8 Aug 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="JvS9cP1p"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E886146A93;
	Thu,  8 Aug 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110777; cv=none; b=kUVeoNbgTjw8GeKpeF9mshzyUhWdb0vJ2CYr4iX0VUyHavHPAqqWQsKq3Lkk/xhOgHCRF1HC7sAFKS9fN2v6nLpiTGfYvU8C5OtOl6K9c9jGO8lBfg2lAJnKgjpgr61a1IMWJvga4AGLzzCYKXIMTDbOT7Zys80HnHWMYG8gDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110777; c=relaxed/simple;
	bh=JiG27XlHhofTe1mChVK0BV8ffCfklqbLPln0145Kfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3MixEO2BqcU8CjQMUk0Ree+6kdZpC2750ic0Ru8ijCKySseGtyv7+3l2eeIYtiY6OIm8ImU/pl6g9VNP3KNmzQANNsU7+bkRQrdtLL5rkqGEeNGfJVLFsZcfkJvyca9BSU/8vvwyOBpPfNP/jXYmD6X0kuV865byjuW9obVdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=JvS9cP1p; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723110754; x=1723715554; i=christian@heusel.eu;
	bh=famyl8XJTqAPO5pOt5QF1mBAP+X4U/NUWSH5Nk/ZfMA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JvS9cP1pTqVQP+8mHzsXKU4pQQv2jhH42/qZR+N2uvOUZYsc0Jpz8rSy5L+6GEqV
	 UqjRKfY/o1TmuqJBEqtCLOHUqgJZ2H7KY8a+AdcUOisBgIAscuHQWq0/2zS/lZZxM
	 7FdL4qtAVrPy/ysf+P8ndSNqs8kSSVqfnjTKLLzdB55vvqY1n1TmC/ih7T0lYDkmi
	 VDiFhf0K2XCS3+e/Bxgd0EZ5Q6Sm18KCaNO3L/rliawTpzvWkDKWgulHZqYnc1HAu
	 MpfC6WJoQHBPazhKl3/IKSN9ZnyMxHvcDPwgEdKXw6AuNhpYAcPkqf1Vfc9XylfpO
	 ItSwyljUsSEX+BsIbA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([78.42.228.106]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbj3e-1s4JlU1V4Y-00oYv7; Thu, 08 Aug 2024 11:52:34 +0200
Date: Thu, 8 Aug 2024 11:52:32 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: avladu@cloudbasesolutions.com, willemdebruijn.kernel@gmail.com, 
	alexander.duyck@gmail.com, arefev@swemel.ru, davem@davemloft.net, edumazet@google.com, 
	jasowang@redhat.com, kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="li54u4dkbh7bt352"
Content-Disposition: inline
In-Reply-To: <2024080857-contusion-womb-aae1@gregkh>
X-Provags-ID: V03:K1:iUYuPJNFKfM0gewmfK3BqdpWZEFF/3Ye0k36aNf1vDRrKGAJWlc
 r3j9OK0OK3gcotmvOhun2bQeUwQdKRlYSgMDiiMCvHXR7FDQLeouwxzDP3KrTdZvWaayWEr
 6r8yqdgyEFQ0wjLugoMAwpky2Le2cRZwAWALrU7YnoM4uKbXYqcHRAZVSVrZFA1GyeLjqfP
 X0XExmjQTP6Iuao3a/UXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LF+M/Z0/zlA=;WgICxuFbvmeVNbQ8jTiRbqwFFyH
 7ZVq6adl12Vv5fct1YPoNYDehop+yrWz8UvsBKftSPwj3CVQkAdf7FKnyY8XXbBKSIR31yoiW
 6Ha/XAylU289m+RIsaxEI5OvyblgUOD5n7WWnEiAErtL26J4qCalbaozXfQN60Yt7+pR0FvW2
 gvS4/CWTk6Zg/MF2/j+fAVtz5Qp17QXA6tsiKCLgfuu5lRt5zH4XWn1tON+EoRLbWYYI2VrOj
 pd5TJPgWf9C/ipWusf8k94HJeddK2iaZO1sZoGCE3SvwuHFv04khnACVNB6C4iIuS727GYPgu
 A1iDz40MpC7rdzYNqDEvsitEZdA+iJUEjbRtHCUZn3ADJIsSf8M49OGZUA6iPU1xXdY7EE18d
 MrrG+739A9hlDTJ7j3kaMLQvmuxGEW0ULMoHLlkRu+SQEra8oTDAWu1Lg2b8XJSo845jpe0Qu
 Xc7LGcwdSKSg1m+tENeFX9o+EXzUU+TqxNc7OHyA2bdGX0AG41RALBeYGUbGiwBcx257cfFOY
 4UDquNXnGPnfqqckzVKXdpAZBLZm3kKQ8ldmV4+Aie0kYcuoH2zfGZm8tUM/39cQzKoq022GO
 pf/ZLwpmSK6X6cLt3+XDG34HWtTAN5DPcElVg5etOmAcuZNKrQd5k8NKVSzdaEtwuO3YKtVZH
 5TpOkDnwOt6WrxCUjnL/bODqdd9m6LY4f0cFV+LL3zdZWgv0HBZ+elJ1QP9OCzoVIhxOjQFiR
 mng6pKru1MmiSbSPGrw2KlomNbIwoRpNg==


--li54u4dkbh7bt352
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/08 08:38AM, Greg KH wrote:
> On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:
> > On 24/08/07 04:12PM, Greg KH wrote:
> > > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.c=
om wrote:
> > > > Hello,
> > > >=20
> > > > This patch needs to be backported to the stable 6.1.x and 6.64.x br=
anches, as the initial patch https://github.com/torvalds/linux/commit/e269d=
79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https://=
git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/lin=
ux/virtio_net.h?h=3D3Dv6.1.103&id=3D3D5b1997487a3f3373b0f580c8a20b56c1b64b0=
775
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmit/include/linux/virtio_net.h?h=3D3Dv6.6.44&id=3D3D90d41ebe0cd4635f641047=
1efc1dd71b33e894cf
> > >=20
> > > Please provide a working backport, the change does not properly
> > > cherry-pick.
> > >=20
> > > greg k-h
> >=20
> > Hey Greg, hey Sasha,
> >=20
> > this patch also needs backporting to the 6.6.y and 6.10.y series as the
> > buggy commit was backported to to all three series.
>=20
> What buggy commit?

The issue is that commit e269d79c7d35 ("net: missing check virtio")
introduces a bug which is fixed by 89add40066f9 ("net: drop bad gso
csum_start and offset in virtio_net_hdr") which it also carries a
"Fixes:" tag for.

Therefore it would be good to also get 89add40066f9 backported.

> And how was this tested, it does not apply cleanly to the trees for me
> at all.

I have tested this with the procedure as described in [0]:

    $ git switch linux-6.10.y
    $ git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0c50e
    Auto-merging net/ipv4/udp_offload.c
    [linux-6.10.y fbc0d2bea065] net: drop bad gso csum_start and offset in =
virtio_net_hdr
     Author: Willem de Bruijn <willemb@google.com>
     Date: Mon Jul 29 16:10:12 2024 -0400
     3 files changed, 12 insertions(+), 11 deletions(-)

This also works for linux-6.6.y, but not for linux-6.1.y, as it fails
with a merge error there.

The relevant commit is confirmed to fix the issue in the relevant Githu
issue here[1]:

    @marek22k commented
    > They both fix the problem for me.

> confused,

Sorry for the confusion! I hope the above clears things up a little :)

> greg k-h

Cheers,
Christian

[0]: https://lore.kernel.org/all/2024060624-platinum-ladies-9214@gregkh/
[1]: https://github.com/tailscale/tailscale/issues/13041#issuecomment-22723=
26491

--li54u4dkbh7bt352
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma0lWAACgkQwEfU8yi1
JYWAaw/+NFVovq+13ZhwFjXLmxlznD100ws6d9Py76NezO3nzoOkuYXsHyVZdCZc
eEGSrwleqBOr1anPUC4Vds6F9gZ9GcqnIf5ZFv6atLehLuWwLEiLyuquVOIoABJB
wEjvR1TdnHfFE5WWcKUjw865ianJ4/5n3HkYYgBSimPZuk3L6x37wvqmmnsQwC1E
ek9bouXkbHxmRTVO8lMWDEDPJXgizBzWbjMNY5SzcPoKeza4fVF440KTbLVnuZA6
7Ejeny7Bn63JFe538rIiV3tL1CazetcdxlbtBmYPMifpbifgmtbsNTjRaACRUorc
oApan9rY5s19803CIG6UB/XJjBIrZNfNFkOhWQNAsgsIyz0VP1sNJpGWQzhZ8dEF
2szbXZg/x2TSE0cBIBVuCbpQRf4muokx67ol5GfauoAt4kFi3YEC8Bo72AsIkPih
PmY7//VZhtywYQiy84tBxXk6dFOQafJ56EcqhDTArPUFl0FySVO4cx0yLuscinMg
Yxa9zanNBQ85nQZrhMBtaKkuV0xZUS6giYP+VcLh60FEXqGG/cTrvdHj9N6jn7MM
YE92wkc5mZq8+VmSRKtcj/dBnuYBO/fB+7C/YxVFgntNsWBISb8X+iKU+dEQepPx
NYJSWsrEH/TEO91S8H7QsCRhfuP2egUg/691c5toDy1t9K/Vid4=
=8CVi
-----END PGP SIGNATURE-----

--li54u4dkbh7bt352--

