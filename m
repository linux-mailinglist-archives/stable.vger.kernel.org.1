Return-Path: <stable+bounces-67625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B317C95189D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689301F204E2
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969EE1AE029;
	Wed, 14 Aug 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="DXUUFQgK"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859213D8AC;
	Wed, 14 Aug 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631077; cv=none; b=HSmKseh9IAG+d2pPmDVwEJ4D6BiNkaQMT58QB4MFN3IFxVzRHHVzq7qku7sudKAOrnXoqaifWjOefT/agOzt8JWeHSxTM+o8dwsKGcUEd1VNGfMIU2nD3eHDnUHSNB2BsvPQuAfYsoK+WSm8/YhyjjTjUWHRuLH0U9+GJ2rmEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631077; c=relaxed/simple;
	bh=RWVcbCNlHx8lGMYK5gifzzGb7Dttynafxk1chvCUirw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJQ47ZEKeKyGoONm8Sgis4SkQ7H34T40KTxCk/s5uYiwTYnAIlpeHJ6bbRNDleBv++d1SFGi14VnTEGhgQY8UwmVPerJ7+nD4CP8NqhetgOHceEnmDZY7VOarbmQaMH1kCG7u4ZFMsiOmqBRmPoSc6YRjVw7a/Ca35v14Qs2Fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=DXUUFQgK; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723631055; x=1724235855; i=christian@heusel.eu;
	bh=RWVcbCNlHx8lGMYK5gifzzGb7Dttynafxk1chvCUirw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DXUUFQgKtY6yx+ehm/AXrEclPMeZk1vwQznH1tU+JNxX+eY0v6m8KcWvcW+M1UdW
	 H2NCBn1HtFdwJhpwbMYY0r5903QoZXtABiDjAxs3HyAyfZoZiSQ7FwLhZzVAJb+3c
	 UGe7MQVA94/iKwkgfu9KexOOelvBh+rIGd0V+N35V/VZhe81Hnd4fatQ0WYk1reh1
	 25CaK1QoEakCmLaPSHz9JKN56d5W2o2LN1rqgI7kujnPscuK0LbyioZ4Tmn7ofTA/
	 DSjmcrq/PovRSg4gvpmNtQzj0Q7NKMUMO9awBk/Lt4dr1LP3LFcJ+H4STGgXUerGo
	 geEbHnqxwPDi14XpyA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.132.14]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N79Ey-1s64Gp2dcy-0114XL; Wed, 14 Aug 2024 12:24:15 +0200
Date: Wed, 14 Aug 2024 12:24:13 +0200
From: Christian Heusel <christian@heusel.eu>
To: Adrian Vladu <avladu@cloudbasesolutions.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, 
	"arefev@swemel.ru" <arefev@swemel.ru>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"willemb@google.com" <willemb@google.com>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fupy5ioaujgzhzoh"
Content-Disposition: inline
In-Reply-To: <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
X-Provags-ID: V03:K1:4LsNBPKGSnKaAahV+kC9ffd/uvKcATEsJ6TpVO9NzBj0gyzllPp
 XaCZBYi9pTlC7pAxI2xIw7hAymOApW4HoC9FHD256ZxqUi2zb2MrwwgrgziB3zc55Sn5+VE
 onIH2ZYis+vylAgxys6bM4qlKHWD1WjzbRRLS/Qzo4SLMuAlOFHDx2LltNAJPjn5Qq+ztfl
 cRFVO0CtPamPx/x4ojAPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Swh0577sYtM=;i4mr60u07hEUuF/IcxtkbPL6zn0
 LB4zdQZYZlBRXiMXnPGUvkYwornnELug71UPfaJkCCsSyrOL+lxx+jj4Dlk9I362dO1ZeUX+R
 p59E+A8V5tKQX4Wqqd+4uj+nHgp4oMIgjavRLnDeNZpQ0ADPfuMtpQA2QWNw9HfXfcQvNZcEW
 UPVNvvnUVoYrC7gIsap/YYmIp3p7NC0iawOkuPz6T7K4FjB1d8D8KclsMnPfmBKfhKdHBjoB9
 4D40K9VWnDL7MCYiiVAuRH49ADiZSjeCnbTB7tQvroRDWMr1NxQnldL05UGmJ0wciB8SkmUXu
 ku1/nsFlkSrFuJBiJc4YsFpAJb7slWuC0FX4J3TtYvWfSZdEs5i+EdJGYmG/nlRzRX5MV2U9y
 8aIZObfYISouhIDmMjnjX7gpNaCg+bWDVuC/XrM2jrcorcbZdbBHQQNTVyu/9nkZP7mYfd4Ee
 7yofj5S/e33l6PtjpWV4zu+IgOOpMJXvZpicad2vPNeeUD2z/Cqm0PZ1GCSL1RmYgTFdRLu/t
 6SjunKw6Ib6avTvDR3EhDqDSrZU88ErxQLQadQZvkk6QSL6MYuEaRDCMke3AtD3iET/1LZrpI
 FEl35QvI6PgROHdpqmHtTyHVPf2xXV3q9tIY8/LNoZm53RH4MHZTXPKKRr4E74xFRAdP2Nacg
 t1rp1Mmzd2WPTQn1NQlLRAoztb1MNAbqRzAOEkrWOjozNNXYDkXXRmcG8NGYm3ia5QVPqduws
 3XQHdynm77k80BRlmtiGQg+neJNMiueTQ==


--fupy5ioaujgzhzoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/14 10:10AM, Adrian Vladu wrote:
> Hello,
>=20
> The 6.6.y branch has the patch already in the stable queue -> https://git=
=2Ekernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=
=3D3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in =
the 6.6.46 upcoming minor.
>=20
> Thanks, Adrian.

Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
If I'm able to properly backport the patch for 6.1 I'll send that one,
but my hopes are not too high that this will work ..

Have a nice day everybody :)
Cheers,
Chris

--fupy5ioaujgzhzoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma8hc0ACgkQwEfU8yi1
JYX/Rw//dc3Z21CFqjdEjiKPqsv2W/NbMF0S7mtARSQKZYQV0ENEMNmeuLEoh0Xf
yzkQuIETOTiSuTEN2UqnG6VTX13w7+9MNZYYV/lv87/8wQkbwsOsE1y8/lstCSc4
wPhY+xYpvLTTRcp41sv1OSpoMgRpa8uFZcaKz7b8UyWW570UH61deEJa79chF5k/
iMRHGA9BzrIT2Fp2NpAWLcJ6nR5uA5JvcnzGznnOoByiBtP8lW2vyIkv5UKBXxHX
uh151Q46CA6p9tZTlRUhn6KurnaPovVY1GoHCDzrby1BzKWHt9T0PcQYc8dMaIUC
6+CJEgz+GANAtllA9XDmN+9MtC7b9656FXbtPukvxM2cFhbDDuAh83AEHU5Mhacc
ufA72bIg94B8StX5iqH/u1A+NGtN7CsBqy13827cXYB28wQopdvYrqmqBeJZ2at8
qDchFajnChAjgG/UsNgxvcMd6VRYZk/LIQQ6UXpPFC7KeuWjLhnBgqqUApqCpXBJ
vOVqnmI5NNpgzAYg3IAd8PDpKoiyMeJsWPEyaICQ4sPRsK0S/ZoFnk3DI3UEMxTz
BO9w3nZ+7cw9ulJ9Z6zA6TuWQQuWVUJ27622hF43DhpKhCgG0jMWZmhPBaO+JU5m
jiHp7/xTI/aXG7k1vOQJeDroTQBK9gCbFIniRlBGbObN1vO67no=
=6DM2
-----END PGP SIGNATURE-----

--fupy5ioaujgzhzoh--

