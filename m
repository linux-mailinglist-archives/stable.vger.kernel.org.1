Return-Path: <stable+bounces-66291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C143B94D7F0
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 22:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028B8B214D5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C2166314;
	Fri,  9 Aug 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="ZDofpxn4"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECC15A851;
	Fri,  9 Aug 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234445; cv=none; b=SH49O5jDefBwfIMwag49xmORMFdlcjF3637rKaaKaRf5O+aQSckHv/9cIot5eO62ET5X/kXLN9TPadQ72QfGvGSu9b07B8L+gnyBYmBBgNaY6TzJ6l7AcqBKtIg70jE2y4bFQrGcznHiGPfaR/yuLgyjKpcIXYcHLMiqzLPNIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234445; c=relaxed/simple;
	bh=rAaTOsEZyBIidGt3u8+poh/HpKMUVRCdrnIZubwjrbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdi6N+9nnbtxhHdgXJFixg3nKHoeMa31AoS+zW0brD6FxrKB2AWUTd3DWSlMTMy3U5MVGE14y14yX2XQV99sMuk9681suqpabnp1HAhkpb6k5Bp/IUPgZZuKUdv6D2E8MRypllWr0FaBRXVqN7rpuLJDSRaGknTtEIg3dbidQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=ZDofpxn4; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723234417; x=1723839217; i=christian@heusel.eu;
	bh=Rr0cE1AX/G6CHk6zloZYkc8fGZORp5fJxWrjwjxTpEs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZDofpxn4AsXYmQEedpXo8Wbv0yPOxUuf1SawocPnDH+J2BZxwzHlycchBJP1TtkI
	 vTNjaHoG7SWmUcphxDY9t6EOzJKcp/Nc+ZEJqIAFWzLTob9jBKiWflM8eo3wixtAx
	 aJDV5TCATo9+VR3ux7EATuzJV3pJF5Bt1PjrFLr0MMEbOX9t0yXnHRAJj9HyYSSt2
	 BaRxF9znZT1Rsdv0n2OBbqH86g8BpW+Yq/swLyvDyI8o9IpthBVivKHZeBQICIAIe
	 D0jDdXEV5M21LM3a1MjytPgqrpYMTXrRNpoaHLp+ktGEwSTRm+E9/+UhuUKTff9Yu
	 Kt6RX158pjiosvpSiQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([84.170.92.222]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFL8J-1sRjPV3wE5-00BZon; Fri, 09 Aug 2024 22:13:37 +0200
Date: Fri, 9 Aug 2024 22:13:35 +0200
From: Christian Heusel <christian@heusel.eu>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>, 
	linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
Message-ID: <e206181e-d9d7-421b-af14-2a70a7f83006@heusel.eu>
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
 <1376f541-bc8a-4162-a814-a9146ebaf4eb@kernel.org>
 <df43ed14-9762-4193-990a-daec1a320288@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="te3aqarnzpml35sn"
Content-Disposition: inline
In-Reply-To: <df43ed14-9762-4193-990a-daec1a320288@heusel.eu>
X-Provags-ID: V03:K1:qwkQAVyWBWMk7kfWe1di1DS9Pj2CIKjSb2EKDuQSrBlpCC1hEql
 /SlyBsCoWYaUDVbjI40D8FEeLfCT9c/x3QrAqqL/NQVOloaAF2xtZ+w4DQW6R6+PkKqaDx2
 H0tVv2bzNLIsALRVm0c2xFWiVdAKDBE49N8sjw/xILAXn9Q5bsv54cGSyqrbiMf2+fd3XaL
 L6FCL8Bqc2GVZPHKoIHPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mT4CzMfywZ0=;/jk0/eKgF2Cy15yjAnfscsaXncf
 mWDwoZ/aA3zR6A9tcY4kEU9WEEfTFX9uAEwDkc9kb6VNEvyNzjqSp58lWqC5zM3FxBae3ANyN
 PPRyiPY0SEoyBJzIXphQr1LPTHtTA7OBsbYZc6uSUHQElzr+yknFXBpi8mW/h7uLAEHL2yBus
 JFLIHqivw/h6Wv0c7cScri/WzPIC3jBw2GYmMBEnWIqX69p+XpnHQ0Vj+40vGbIG3qjTZfh24
 hJsheSs7AIL82Ai8+F+65mOvs9qoNKXcsHY30HAUzjnboUALkzSWgJzgx8IhxFk3xdkKztsBG
 DRjJbbf6iWUq1LDzdFOa5BdZc6Vypf7/BfW81sp4M5FVZ/tF9eBrIcA6OWgHjjCZa9890ooYa
 mZ96i8gWNQQqgffee8dxhlqqAYlzxX8cV80HtZ3Qf2/nvXTXzBXtOHAPpkOi5ajSSee/iv+gC
 7RfS3ML8ZOhMmA/Qx9m3ZV953iyHTfmDQKEpAZSGqovBSp7BpN0v0QaRNBbym2IERedXGxduO
 TL4+4bpv/rCogEFF6zMhwvjC2zJJ0ZahKhVub1/rFZ2jDJTWJw+eTPMatlNaG6AO6Wb5jjNHd
 5pILM32C3KG+MUn+zR2aF7s6OKnrKUbPLKz37SCLiRBVAK4eUOK6RFRJ3ADgkJ666Kt2oUz6l
 97EY9mpMTKDAWtCUHvlqxbxqHBrELq3XDGMPQCt3sgv3paFgJuRqYtkVqd0Q/lrpE7ZV/pB6a
 GUjBK/DldF2H4bs1HmapKCAAxKIbvWhLQ==


--te3aqarnzpml35sn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/09 08:42PM, Christian Heusel wrote:
> On 24/08/09 08:34AM, Damien Le Moal wrote:
> > On 2024/08/07 15:10, Niklas Cassel wrote:
> > > On Wed, Aug 07, 2024 at 11:26:46AM -0700, Damien Le Moal wrote:
> > >> On 2024/08/07 10:23, Christian Heusel wrote:
> > >>> Hello Igor, hello Niklas,
> > >>>
> > >>> on my NAS I am encountering the following issue since v6.6.44 (LTS),
> > >>> when executing the hdparm command for my WD-WCC7K4NLX884 drives to =
get
> > >>> the active or standby state:
> > >>>
> > >>>     $ hdparm -C /dev/sda
> > >>>     /dev/sda:
> > >>>     SG_IO: bad/missing sense data, sb[]:  f0 00 01 00 50 40 ff 0a 0=
0 00 78 00 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >>>      drive state is:  unknown
> > >>>
> > >>>
> > >>> While the expected output is the following:
> > >>>
> > >>>     $ hdparm -C /dev/sda
> > >>>     /dev/sda:
> > >>>      drive state is:  active/idle
> > >>>
> >=20
> > Yes, indeed. I do not want to revert any of these recent patches, becau=
se as you
> > rightly summarize here, these fix something that has been broken for a =
long
> > time. We were just lucky that we did not see more application failures =
until
> > now, or rather unlucky that we did not as that would have revealed these
> > problems earlier.
> >=20
> > So I think we will have some patching to do to hdparm at least to fix t=
he
> > problems there.
>=20
> It seems like this does not only break hdparm but also hddtemp, which
> does not use hdparm as dep as far as I can tell:
>=20
>     # on bad kernel for the above issue
>     $ hddtemp /dev/sda
>     /dev/sda: WDC WD40EFRX-68N32N0                    : drive is sleeping
>=20
>     # on good kernel for the above issue
>     $ hddtemp /dev/sda
>     /dev/sda: WDC WD40EFRX-68N32N0: 31=B0C
>=20
> I didn't take the time to actually verify that this is the same issue,
> but it seems very likely from what we have gathered in this thread
> already.
>=20
> So while I agree that it might have previously just worked by chance it
> seems like there is quite some stuff depending on the previous behavior.
>=20
> This was first discovered in [this thread in the Arch Linux Forums][0]
> by user @GerBra.
>=20
>  ~Chris
>=20
> [0]: https://bbs.archlinux.org/viewtopic.php?id=3D298407

As someone on the same thread has pointed out, this also seems to affect
udiskd:

https://github.com/storaged-project/udisks/issues/732

--te3aqarnzpml35sn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma2eG8ACgkQwEfU8yi1
JYULHQ//eHCaJ6BQEbYvhcVZSn+jkune2gBSgbeIKPXQdBWhlsHhrbU0hUTBDcy2
Hx0bD4SAkLS2DDqLjVCJzinlbiYK0SVmgB37MoBeUY0gXYjLfcNh/nItRUg6/aTR
qNnB0TluKH6NHouGAaz+5rAW+QrfVpiHNDU7wWT4HC6rFx3LNkIe7okTa8of12Dk
7WctvvsJD7DYwx774a3nw6N2z09oLcJ8XDr5h3EkufZz514w+elmUBwKlfdDuXXp
htRPZ0+0Lvccs0uNofaFZ7KVrjKG7q4B1WsHqJ9v9RTLHzTaTzFoBIfSCjHi36J3
wHVCu13TuyWpnFNHEzoDQ+R5zedNlsqABKHT2YipWEOFNXQHENO1fCQ1Ygho1o1Y
iXf+lX47HZqmXcKTz09jIFAZmbZMpGPT6+dU8GmT0nvvXIgd0KU+RnJ/PV7zxoL5
f5UT0WwJowhe1JK6PpvVPQ3sTiakLFJdMOrnPmnqOO0Uc0ROQ2WwyMGH2lHAP/K/
Yg569V4sz7UswmgGFcaeJh51CV6INfansOVhQ6WicHn8+M3PCRy4sYHgclD6ML7U
6UEls80nuc7sGSYqKXRV1nXr6+tO3frRc5kAHBKi1W5l6VGAOv53t5CyA49KpqTR
I9n82nm95sPqlGzUq5fxnLcfdubld2z9WswHKWMLEAN/a9ahAJE=
=Oprj
-----END PGP SIGNATURE-----

--te3aqarnzpml35sn--

