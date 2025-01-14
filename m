Return-Path: <stable+bounces-108592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C0BA10731
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFB71886B1B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE508234CF4;
	Tue, 14 Jan 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mEFzLGUN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LBBrO/U0"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A43236A62;
	Tue, 14 Jan 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859497; cv=none; b=DRyTvKHjGmdIImPHhkNGVL31yezEKbsCo3lj68GY7pY/1RHtPujjJey+BLYMh0iRqTQBjU7IbuS9JhmT0JQTBD47Pxn0juANF43+IvbjbWD8f4FvQ5RZ4TKO52vHW7/6WkowZLzcDNeZTJm1vdGRa0YLsqRy5BYVdv+OeoClKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859497; c=relaxed/simple;
	bh=5LGFeP2Aalr2mkOUZOEX/C9MUNx7eyfCmx4D217fCfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgMvcC78+AUKdT5hmoxGqTt1y5QSEB7Fe7OgB7gz/LMSgwiRaXSyEvsLOyE5Ccb6l3cYM/ZgVtaBK7q7vszkf8BKgc83ntwdJovfK4WvGEe8aTgdnAXTwqxKwM2GeSTQ8yAfMLzLnFJefAz1EDDRUj1ABpwGG7eb5c8wriZb+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mEFzLGUN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LBBrO/U0 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1736859494; x=1768395494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxAoaj5aWo5znfnGjLu/P2YOXL+a99GY6jbbceTDTeQ=;
  b=mEFzLGUNt+jtwUkjlYsEIDxAWIaZ902KZZxUeqFpeGcfwrGjOwDoTocG
   EhbxtedT0NspLqzYdRAuZ0n/vfpbObVJlgTbA4UaENUMAcIYOhOMbDu3I
   v99Ghgo4gzotTjGXZnPNDL+R9ByzOyDbJ1Sm1vZMXIAZhohkroDQdkyWQ
   kFn/XP5jol8EhiDAIP6RahvO0pk2w9jlfLScZLKfpD3Lblpv5Z+qkbTsr
   FpUyOGxRsGcORFTgkr61TZ7rLNbXhvpsBStiI86fKkAfdbxFGYyoZf+Lt
   vXUFTYUnPD2VVDBZOdKmch+A8i+adbh+hLMmUIh3QPkvbY9fe0ljOROMK
   w==;
X-CSE-ConnectionGUID: TLLs8gtfR66rsUGSctIZHw==
X-CSE-MsgGUID: jWhkfVdtT5Oxt/gTGhyw0A==
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="41042266"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Jan 2025 13:58:06 +0100
X-CheckPoint: {67865F5E-3-31397509-E321C4C4}
X-MAIL-CPID: 2C366D73D57A7C6B648CB932145AEB1F_0
X-Control-Analysis: str=0001.0A682F24.67865F5E.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFC72160ABF;
	Tue, 14 Jan 2025 13:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1736859481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxAoaj5aWo5znfnGjLu/P2YOXL+a99GY6jbbceTDTeQ=;
	b=LBBrO/U00sR4FG7n06ALJwmNZ9H3rPMh97Ch7VTA/N6wS9gnjtLiHwD7ictcX3VPj2yXZQ
	J6MNIsavuTmB29XFlaILQw9OxumS23x9ByYn9fBRbkSOxRHJDJJgQF+c0TtNAhWJs/PahE
	/TlK9Q84Cf3vSgxRV9EUws9b85GMAxet0x1qCsq79vx+LHtsedk1SMpXUg6bI84ADatCcA
	NJVpOgDObqYQnITGN9KJZjE/AkdlNgoWCTGlEmOuFjrVgX+UhADIbwmWYLgmKulEYDRfIc
	tmkK6WGsQHiyJEXqahWOyCUYx1ebQLtLsYa8EDBupCd3FtF732BOJAAeyaNo5A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org, Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Tue, 14 Jan 2025 13:57:59 +0100
Message-ID: <3342163.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241112075242.174010-2-linchengming884@gmail.com>
References: <20241112075242.174010-1-linchengming884@gmail.com> <20241112075242.174010-2-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

Am Dienstag, 12. November 2024, 08:52:42 CET schrieb Cheng Ming Lin:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> The default dummy cycle for Macronix SPI NOR flash in Octal Output
> Read Mode(1-1-8) is 20.
>=20
> Currently, the dummy buswidth is set according to the address bus width.
> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
> dummy cycles to bytes, this results in 20 x 1 / 8 =3D 2 bytes, causing the
> host to read data 4 cycles too early.
>=20
> Since the protocol data buswidth is always greater than or equal to the
> address buswidth. Setting the dummy buswidth to match the data buswidth
> increases the likelihood that the dummy cycle-to-byte conversion will be
> divisible, preventing the host from reading data prematurely.
>=20
> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
> Cc: stable@vger.kernel.org
> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f9c189ed7353..c7aceaa8a43f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>  		op->addr.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
> =20
>  	if (op->dummy.nbytes)
> -		op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
> +		op->dummy.buswidth =3D spi_nor_get_protocol_data_nbits(proto);
> =20
>  	if (op->data.nbytes)
>  		op->data.buswidth =3D spi_nor_get_protocol_data_nbits(proto);
>=20

I just noticed this commit caused a regression on my i.MX8M Plus based boar=
d,
detected using git bisect.
DT: arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
Starting with this patch read is only 1S-1S-1S, before it was
1S-1S-4S.

before:
> cat /sys/kernel/debug/spi-nor/spi0.0/params
> name            mt25qu512a
> id              20 bb 20 10 44 00
> size            64.0 MiB
> write size      1
> page size       256
> address nbytes  4
> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_=
BP
> | HAS_SR_BP3_BIT6 | SOFT_RESET
>=20
> opcodes
>=20
>  read           0x6c
> =20
>   dummy cycles  8
> =20
>  erase          0xdc
>  program        0x12
>  8D extension   none
>=20
> protocols
>=20
>  read           1S-1S-4S
>  write          1S-1S-1S
>  register       1S-1S-1S
>=20
> erase commands
>=20
>  21 (4.00 KiB) [1]
>  dc (64.0 KiB) [3]
>  c7 (64.0 MiB)
>=20
> sector map
>=20
>  region (in hex)   | erase mask | overlaid
>  ------------------+------------+----------
>  00000000-03ffffff |     [   3] | no

after:
> cat /sys/kernel/debug/spi-nor/spi0.0/params
> name            mt25qu512a
> id              20 bb 20 10 44 00
> size            64.0 MiB
> write size      1
> page size       256
> address nbytes  4
> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_=
BP
> | HAS_SR_BP3_BIT6 | SOFT_RESET
>=20
> opcodes
>=20
>  read           0x13
> =20
>   dummy cycles  0
> =20
>  erase          0xdc
>  program        0x12
>  8D extension   none
>=20
> protocols
>=20
>  read           1S-1S-1S
>  write          1S-1S-1S
>  register       1S-1S-1S
>=20
> erase commands
>=20
>  21 (4.00 KiB) [1]
>  dc (64.0 KiB) [3]
>  c7 (64.0 MiB)
>=20
> sector map
>=20
>  region (in hex)   | erase mask | overlaid
>  ------------------+------------+----------
>  00000000-03ffffff |     [   3] | no

AFAICT the patch seems sane, so it probably just uncovered another
problem already lurking somewhere deeper.
Given the HW similarity I expect imx8mn and imx8mm based platforms to be
affected as well.
Reverting this commit make the read to be 1S-1S-4S again.
Any ideas ow to tackling down this problem?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



