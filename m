Return-Path: <stable+bounces-39405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E08A4C2F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDE8B2358E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1347F50;
	Mon, 15 Apr 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsbq8u9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060F4AEEC;
	Mon, 15 Apr 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175663; cv=none; b=LIjY9yD9Yk2Z6IYW3e2OeYw16xWX5/59Xcaswf9mfJaBJl8OHLrldnnp10oFHZKvEu4FVWgD3mvX4jpVK5np42KCYEtg8Bf4Od3KbbThWsnwD5xffV6J/+ysbiwZU8rT6xDNdBWF4uuiSCKuFLVXvysB/NUShCbipKS09CamiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175663; c=relaxed/simple;
	bh=03f7VbouU387vjoW0wj96jqJJh6UjUueYF4S1jdpf6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3jiw8HBwBjFr8P5AZM94az2gOkcOarBt1t0ze6QLzOtRxJLTCByd/hPC4UTxJ1ACRukEVXEI3m3t7ZzoY6VXlwYYEQGgSY3V2AS28eNozWxofmNjW448kxvJKNemELhga0aDNlw4Wrpc6GZn2NqzsXN7XLz2/RWj05UbDMrQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsbq8u9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4499BC113CC;
	Mon, 15 Apr 2024 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713175663;
	bh=03f7VbouU387vjoW0wj96jqJJh6UjUueYF4S1jdpf6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsbq8u9f2zYzIV/JB+hrxYVrwrx5R5pbYJoZyKWNOA8RVc/eqon5Ru1fKJ8beI90g
	 xFgS1UXYEpNFGezARNpDQK1k1j3EgkmtU5Cyq6pDclHnK9wkkhFruGsBdLP+Ifav/I
	 UYNvlWfBmAd1uclBLgOR8xnC1ZATGBwVGhgiAszpsi8Mh54uETeEo7rw0klHddERZ8
	 KY6cIfsZELblHweOHpFFxtLk6FKKlnGoICjqjo2FtiNuhpw7TwDiF+Pfk7ZCAWgKX9
	 lP4QZzhCNtvSY9ZQTDTvZzrzumTmW8OtWixQM+ekA5nbyNAuiA1iRG4N0jS6ePvKT9
	 0GkqM1WbTc7FQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwJFV-000000002YX-06S7;
	Mon, 15 Apr 2024 12:07:41 +0200
Date: Mon, 15 Apr 2024 12:07:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Sasha Levin <sashal@kernel.org>, Greg KH <greg@kroah.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, buddyjojo06@outlook.com,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
Message-ID: <Zhz8bYXUCEmLoDiW@hovoldconsulting.com>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
 <2024041016-scope-unfair-2b6a@gregkh>
 <addf37ca-f495-4531-86af-6baf1f3709c3@linaro.org>
 <2024041132-heaviness-jasmine-d2d5@gregkh>
 <641eb906-4539-4487-9ea4-4f93a9b7e3cc@linaro.org>
 <2024041112-shank-winking-0b54@gregkh>
 <ZheX3KdUA76wTYMF@sashalap>
 <20240411-expectant-daylight-398929f2733b@wendy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Exvap2Z3ey/ZT/8"
Content-Disposition: inline
In-Reply-To: <20240411-expectant-daylight-398929f2733b@wendy>


--4Exvap2Z3ey/ZT/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:23:20AM +0100, Conor Dooley wrote:
> On Thu, Apr 11, 2024 at 03:57:16AM -0400, Sasha Levin wrote:
> > On Thu, Apr 11, 2024 at 09:34:39AM +0200, Greg KH wrote:
> > > On Thu, Apr 11, 2024 at 09:27:28AM +0200, Krzysztof Kozlowski wrote:

> > > > I vote for dropping. Also, I think such DTS patches should not be p=
icked
> > > > automatically via AUTOSEL. Manual backports or targetted Cc-stable,
> > > > assuming that backporter investigated it, seem ok.

> > > Sasha, want to add dts changes to the AUTOSEL "deny-list"?
> >=20
> > Sure, this makes sense.
>=20
> Does it? Seems like a rather big hammer to me. I totally understand
> blocking the addition of new dts files to stable, but there's a whole
> load of different people maintaining dts files with differing levels of
> remembering to cc stable explicitly.
>=20
> That said, often a dts backport depends on a driver (or binding) change
> too, so backporting one without the other may have no effect. I have no
> idea whether or not AUTOSEL is capable of picking out those sort of
> dependencies.

In the best case backporting a dts change as no effect, but it can also
break the driver completely unless the corresponding driver changes are
also backported.=20

And such breaking dts changes are currently being pulled in as
dependencies:

	https://lore.kernel.org/all/ZgEpI31-OJkNchPF@hovoldconsulting.com/

I'm all for not backporting any dts changes that lack an explicit CC
stable tag.

(And people will never learn to add the CC stable tag when everything
with just a Fixes tag is being pulled in anyway.)

Johan

--4Exvap2Z3ey/ZT/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZhz8aAAKCRALxc3C7H1l
CIPeAQCyRi1o2QNyzYXcQLJl+jBvhDV+4gR8EKeVRIGn0B4UmwEAsMx8a0IwyvFV
yxaBKcTCS8gL2kgw78RsHP675Z09ZgE=
=+o+A
-----END PGP SIGNATURE-----

--4Exvap2Z3ey/ZT/8--

