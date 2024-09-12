Return-Path: <stable+bounces-75964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17229762BF
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 09:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB8D1C22267
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24B18E043;
	Thu, 12 Sep 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CWEpvclX"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063178C7B;
	Thu, 12 Sep 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126382; cv=none; b=MgbMIpY5CxfppGLhDp7HAltgOYXO3N1+n8TNqK7Y3pjFJ9y7CfFNBJ3i/JOXwVYvJMf0HKR3H2o7IYedYOm424Qz1tCwxmulpwOqRhyiwGZjyfX/x5enldf3iIpx1QgnAojL9tJEY7L5wz3Ie5Tz4Sd69ZCetVAh+wcrkpC6GBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126382; c=relaxed/simple;
	bh=A0OLi+CRloHyK/Ua4rHjaFAPFQYO8jOgh8kX9YifaN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQGSembQjBmyHcwvSp6ftGwrinx/Bbfwz0Rnnv6Q+PblYdNJSvV0f32wdudIoo9Bin3UEm9IK3Dltj8ZM3pSPNNMdDuYvQHQOnxgfKOaBTTAoD5SDadrEcM3BOY/+J+gEeVzsNheap7dJGM5RSOokYt5dbT6bz62MiVylIX5EBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CWEpvclX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726126380; x=1757662380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A0OLi+CRloHyK/Ua4rHjaFAPFQYO8jOgh8kX9YifaN0=;
  b=CWEpvclX97d2Yrq9XxSVEETrq4ydiUk4STBJlqts65R3soA9H7FCMvxl
   v4OkInI78IHyNMjW66LuKKJREh7gVkaDTerHhwXhLMdXGJvStPPIKpou3
   6KloXlGhdDHAcMsgN0Ss/1S4/hSaKmO8QIW7sEai9XordKoPbU1C0jr7p
   CKkCWn3zAOB1YCiMV6G9be8iiDyWGnC9dtZZG8+PD2Rj5GY3WLSBxbQq8
   2jND3WG4xF3up5uhkBMiGiqdLO+kseaNSgieHHssu/f5zJNHZ1xGUFFwy
   Q9/Wjb+UN+yz5kaZNLqulIw5hYbDOrRFh8Rv/QN5rBIKfnPoS6kBgj2y6
   A==;
X-CSE-ConnectionGUID: LpRQBBlMQkGueR9dw36uBA==
X-CSE-MsgGUID: f7yaRPOpS069i9Newcnl4A==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="asc'?scan'208";a="31577165"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 00:32:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 00:32:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 12 Sep 2024 00:32:20 -0700
Date: Thu, 12 Sep 2024 08:31:46 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: WangYuli <wangyuli@uniontech.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<william.qiu@starfivetech.com>, <emil.renner.berthing@canonical.com>,
	<xingyu.wu@starfivetech.com>, <walker.chen@starfivetech.com>,
	<robh@kernel.org>, <hal.feng@starfivetech.com>, <kernel@esmil.dk>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <20240912-sketch-research-ad02c157cbf3@wendy>
References: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>
 <20240909-fidgeting-baggage-e9ef9fab9ca4@wendy>
 <ac72665f-0138-4951-aa90-d1defebac9ca@linaro.org>
 <20240909-wrath-sway-0fe29ff06a22@wendy>
 <DBEFAD22C49AAFC6+58debc20-5281-4ae7-a418-a4b232be9458@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUrs2a+ddceNZFId"
Content-Disposition: inline
In-Reply-To: <DBEFAD22C49AAFC6+58debc20-5281-4ae7-a418-a4b232be9458@uniontech.com>

--dUrs2a+ddceNZFId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:38:20AM +0800, WangYuli wrote:
>=20
> On 2024/9/9 19:17, Conor Dooley wrote:
> > [6.6] in the subject and Sasha/Greg/stable list on CC, so I figure it is
> > for stable, yeah. Only one of these patches is a "fix", and not really a
> > functional one, so I would like to know why this stuff is being
> > backported. I think under some definition of "new device IDs and quirks"
> > it could be suitable, but it'd be a looser definition than I personally
> > agree with!
> These submissions will help to ensure a more stable behavior for the RISC=
-V
> devices involved on the Linux-6.6.y kernel,

I'll accept that argument for the first patch, but the three that are
adding support for audio devices on the platform cannot really be
described as making behaviour more stable. I don't hugely object to
these being backported, but I would like a more accurate justification
for it being done - even if that is just that "we are using this board
with 6.6 and would like audio to work, which these 3 simple patches
allow it to do".

> and as far as I can tell,they
> won't introduce any new issues (please correct me if I'm wrong).

I don't know. Does this first patch require a driver change for the
mmc driver to work correctly?

> > Oh, and also, the 4 patches aren't threaded - you should fix that
>=20
> I apologize for my ignorance about the correct procedure...
>=20
> For instance,for these four commits,I first used 'git format-patch -4' to
> create four consecutive .patch files,and then used 'git send-email
> --annotate --cover-letter --thread ./*.patch' to send them,but the result
> wasn't as expected...
>=20
> I'm not sure where the problem lies...

I'm not sure, I don't send patches using that method. Usually I output
my patches to a directory and call git send-email using the path to that
directory.

Cheers,
Conor.

--dUrs2a+ddceNZFId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuKY4gAKCRB4tDGHoIJi
0r2pAQDK9tw50M9/pd5jx1uyrtkDT/RUbd0s3qpnx1Z0YSYF9AEA+k8EKSF51lvO
hrrZQj9ToA2Lnoo4N8es473eQLiq+g8=
=6MvV
-----END PGP SIGNATURE-----

--dUrs2a+ddceNZFId--

