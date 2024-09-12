Return-Path: <stable+bounces-76020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751369770E9
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F028142A
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25B1BF7F7;
	Thu, 12 Sep 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5pzdq97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AE126BED;
	Thu, 12 Sep 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166924; cv=none; b=G36eY2Mpk9lkVh06X2fNdMumARNRQxPYKVFXyqQtElDaVL3ZbSvJLvZuiWLbbkm6YFaLjWwMGe0DQwBY0HcMjaFN9uLBijiAtaaFvlP4S3Vt1QL197Zcd47rMFSIAHu0mhcajbC3exVv3/Gn72lcPTf3DpvHbzJifMSIekvIosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166924; c=relaxed/simple;
	bh=VsPoHKdTV/hmH6JHnw5e9LUwNZcjzv8WARUE6KL4R+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQl3PjHZ7toaEtOD59TI3jnZD5e4XPp8t7V8JDmcMdWK70a3utrv/T7NkYBJU1kI+2HThOg+2EacPhl4vX17Uds9No7331GSF3N18+UgdnIOIyAChXBzIJVPkSgJ9ah2ylOxzXYjZCi0j0tXO8LYXL07efDTWKR8cG8O9KAOMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5pzdq97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE08C4CEC3;
	Thu, 12 Sep 2024 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726166923;
	bh=VsPoHKdTV/hmH6JHnw5e9LUwNZcjzv8WARUE6KL4R+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5pzdq97xBYRWrUX9/mGz2HpiJrmpmeTvrOuap/dYSsMh+Bd9HU1egW7G37O2u4vO
	 MgiBoBKQC7n+qkGaUrAtRpCzfzhRgG9qEmoDnpB1xB8rYETW3Zdy+seJxwwXekhk3y
	 RxU7SRt2SYbgdXE8Vs9XW1+V1FMY+JlopI9v9cAhe0XMHBCc/7PMUHI1BQKfmRVYmG
	 YfEe4VKtRXiZNg2e2zwff7sL6KTwoItkEtqXCt4QlMIRwAtXzwy7JWFftM2j/7kmJn
	 5fVDxtAMepSqVRF22fANE2tOLxYhAqQfeGiZkapwHBRe/FDNYOoPP2o5BCoW/lQyPp
	 LMdr4kvVJ5q6A==
Date: Thu, 12 Sep 2024 19:48:37 +0100
From: Conor Dooley <conor@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	William Qiu <william.qiu@starfivetech.com>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"kernel@esmil.dk" <kernel@esmil.dk>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 6.6 v2 3/4] riscv: dts: starfive: Add the nodes and pins
 of I2Srx/I2Stx0/I2Stx1
Message-ID: <20240912-carnation-aspirate-9a8ef572da2f@spud>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
 <D2DCF9E2F70EDC93+20240912025539.1928223-3-wangyuli@uniontech.com>
 <ZQ2PR01MB13070BA638E892A5516DEA8CE6642@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <20240912-lividly-remover-6d71b985a803@wendy>
 <57B002D3A0A289D5+d784ecd6-ed84-4aa1-ae58-0c67d2de1989@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DUVkQka0vWnFdotT"
Content-Disposition: inline
In-Reply-To: <57B002D3A0A289D5+d784ecd6-ed84-4aa1-ae58-0c67d2de1989@uniontech.com>


--DUVkQka0vWnFdotT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 07:19:05PM +0800, WangYuli wrote:
> On 2024/9/12 18:40, Conor Dooley wrote:
>=20
> > On Thu, Sep 12, 2024 at 10:23:09AM +0000, Hal Feng wrote:
> > > > On 12.09.24 10:55, WangYuli wrote:
> > > > +	i2srx_pins: i2srx-0 {
> > > > +		clk-sd-pins {
> > > > +			pinmux =3D <GPIOMUX(38, GPOUT_LOW,
> > > > +					      GPOEN_DISABLE,
> > > > +					      GPI_SYS_I2SRX_BCLK)>,
> > > > +				 <GPIOMUX(63, GPOUT_LOW,
> > > > +					      GPOEN_DISABLE,
> > > > +					      GPI_SYS_I2SRX_LRCK)>,
> > > > +				 <GPIOMUX(38, GPOUT_LOW,
> > > > +					      GPOEN_DISABLE,
> > > > +					      GPI_SYS_I2STX1_BCLK)>,
> > > > +				 <GPIOMUX(63, GPOUT_LOW,
> > > > +					      GPOEN_DISABLE,
> > > > +					      GPI_SYS_I2STX1_LRCK)>,
> > > > +				 <GPIOMUX(61, GPOUT_LOW,
> > > > +					      GPOEN_DISABLE,
> > > > +					      GPI_SYS_I2SRX_SDIN0)>;
> > > > +			input-enable;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	i2stx1_pins: i2stx1-0 {
> > > > +		sd-pins {
> > > > +			pinmux =3D <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
> > > > +					      GPOEN_ENABLE,
> > > > +					      GPI_NONE)>;
> > > > +			bias-disable;
> > > > +			input-disable;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	mclk_ext_pins: mclk-ext-0 {
> > > > +		mclk-ext-pins {
> > > > +			pinmux =3D <GPIOMUX(4, GPOUT_LOW,
> > > > +					     GPOEN_DISABLE,
> > > > +					     GPI_SYS_MCLK_EXT)>;
> > > > +			input-enable;
> > > > +		};
> > > > +	};
> > > > +
> > > >   	mmc0_pins: mmc0-0 {
> > > >   		 rst-pins {
> > > >   			pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> > > The above changes had been reverted in commit e0503d47e93d in the mai=
nline.
> > > Is it appropriate to merge this patch into the stable branch?
> > >=20
> > > https://lore.kernel.org/all/20240415125033.86909-1-hannah.peuckmann@c=
anonical.com/
> > Hah, I had gone looking this morning because I had a hunch that there
> > was some missing fix this series didn't, but couldn't remember what it
> > was. I completely forgot that some of this was non-present overlay
> > related stuff that had had to be reverted.
> >=20
> > So yes, if it had to be reverted in mainline, it shouldn't get
> > backported. Thanks for spotting that Hal.
> >=20
> Got it. Thanks for pointing that out, and sorry for bothering you all...

Patch 1 still seems like it could be backported though, even if these
pwmdac patches are not suitble?


--DUVkQka0vWnFdotT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuM3hQAKCRB4tDGHoIJi
0tHdAP469+SvjkqO/rEKHfqhrnsk2nxKybDVYuHxJ0twOw+RjwD/YUruu5BbY7La
NBPyazL+MNe9sykkvgmWNvSNnwcfwQA=
=i+ZU
-----END PGP SIGNATURE-----

--DUVkQka0vWnFdotT--

