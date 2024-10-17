Return-Path: <stable+bounces-86671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5849A2B63
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FFACB21379
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B61DFD92;
	Thu, 17 Oct 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Az3lyt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D031D95BE;
	Thu, 17 Oct 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187529; cv=none; b=jAxIG09y17Paf12XZV8azHmyKEGHZluzmPGhEUY9Ec32bhcCHv2P4hZcD5rBd8vMeztW+WkBLpq2Q6j73XA5xRDVzh6PF0gT8U7I4kzvSugyZ80IgPwdbPratdlynNyG4ObdH1T1vUP/Ua8r93rQ7MkuJmOW1cJqUMMLSmyktec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187529; c=relaxed/simple;
	bh=gmOt13pVPmIXcY0OIAOohx40/5JMQplh61ctXWIWaUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHBRFn72T+3tHJUoSRBKh/ayCwm9JkD13WJWshH0lw2E4c0Vomdrp71MHJDtenH6+qechxvu4CEMmfusk3hHYPEYZ3wQlhUCNyO12CQyDEBpRM6TIlSHoVNQhEAjHiw5Oo93EmgNxIM4rahnnBmz+eP5u4OPh929Mwd/ZtnMbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Az3lyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDF8C4CEC3;
	Thu, 17 Oct 2024 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187528;
	bh=gmOt13pVPmIXcY0OIAOohx40/5JMQplh61ctXWIWaUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2Az3lytMc3zjIDcqG16DuKCCGrBrOYDPGEDE39DOPaF2+SEcc8x39uCb8POps19L
	 HjODyGTdz+Hb11q/lPG0+qeKi5OEb1lIWNl3cndhmy8kJW3x00D3NyjI7Cztxkhj5n
	 BI5d62MLCV99uCGYtjovS+0cVhuLAeNtLE3HrQXcFXhcdW9Lx1ucSPsOl28k/guwpj
	 1a04lOMGGoCLygH1zWJUke7N1ryVFka/McFNlQy8kPRv9Ftmj0NIKRVQGyBMaYWG94
	 UjqqwdhXuX3g20yVPiO6HNo9/5jmUejo+TSSWKon+TPLTpYYTYMCuQdnVLriZtP/uC
	 +4/8NN5GBBD2A==
Date: Thu, 17 Oct 2024 18:52:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v1] riscv: dts:
 starfive: disable unused csi/camss nodes
Message-ID: <20241017-condone-angelic-9d4936f1fd37@spud>
References: <ZQ0PR01MB130298186E09DA19CC1F7736F2472@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VgIo2QEZSi5NGsOb"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB130298186E09DA19CC1F7736F2472@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>


--VgIo2QEZSi5NGsOb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:49:56AM +0000, Changhuang Liang wrote:
> Hi, Conor,
>=20
> > Hi, Conor
> >=20
> > Thanks for your patch.
> >=20
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Aurelien reported probe failures due to the csi node being enabled
> > > without having a camera attached to it. A camera was in the initial
> > > submissions, but was removed from the dts, as it had not actually been
> > > present on the board, but was from an addon board used by the develop=
er
> > of the relevant drivers.
> > > The non-camera pipeline nodes were not disabled when this happened and
> > > the probe failures are problematic for Debian. Disable them.
> > >
> > > CC: stable@vger.kernel.org
> > > Fixes: 28ecaaa5af192 ("riscv: dts: starfive: jh7110: Add camera
> > > subsystem
> > > nodes")
> >=20
> > Here you write it in 13 characters, should be "Fixes: 28ecaaa5af19 ..."
> >=20
>=20
> After fixing this:
> Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Ye, I know it was 13 not 12. I don't think that's a problem though.

--VgIo2QEZSi5NGsOb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxFOxAAKCRB4tDGHoIJi
0r24AQCKINQVQ9g7jUqAtlal7Z82+REbGOsv+I+oqRMQduOLKgD+K/ZCmiECTEgx
z4CTuvZPyZwHRwjzkEUY9OmWxrRT2Ac=
=nBzS
-----END PGP SIGNATURE-----

--VgIo2QEZSi5NGsOb--

