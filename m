Return-Path: <stable+bounces-108676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C56A11A27
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 07:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F1B3A3717
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615F22F848;
	Wed, 15 Jan 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FdeTVWe6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Iu71vKgi"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BFD22F3B6;
	Wed, 15 Jan 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924059; cv=none; b=MuKBXVKv1nZNzldTunDVHai2UeEiYB0/9Abk54efWIw+NMRaZXvjLpq155lLdT86j40mpBL7PBygzNVfEVE3mYp+O2tzfMDIyHiunhrZ4/glx3BFkabOlQxjjFPkrbCZ5OGcva5ZhQBjZzKsIaaoqwCEvrZ4lH5BQcMym/CPgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924059; c=relaxed/simple;
	bh=AIdt5J2QY2ymLP95Tot7Ibz3viEBLiYD1oOe2/lYDBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLXh88rCWM8N2ABLJcJoqQwvll9sjI2C7ba2mirlYRsCPDQLC0m3Pt/hpGr4+Akvj4vkCxrmJMBbI3PNxlgO1IFaR3DO/xFg+NYm4ni1Xj4KonWB32lYGjD/pYRGiaBxfQsOprkqGiB0a2j8bAVzHXkxetgO0SeF09LvZ5Rbh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FdeTVWe6; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Iu71vKgi reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1736924055; x=1768460055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cUh82Ypecrl42cm19wZgKhQaors0qjkO/giiuR2KOqk=;
  b=FdeTVWe6R6t/pMAa5UogJDpO7sgH4G9RBrEFunXP7I5yCgaWzquHX8pZ
   hBDdiUyjrLsJyvpTp6CW+NkKqIaLghpNAGi6xqooigXc9JzhOIDLWlAhE
   SR8oncFWrlK+gCHUfDIeZ1TcfgPm2Kfr8xXO347QST+EmZ4JPe76faJi2
   L21orGa1EoejIovcKxBE8hxqp8VjluLY+2v4AN2zCXZTtYdBXWqVwoDxI
   MWNbNdWE9+24t4QlLc9uZMkPzx2/LUSME8hOC4jzAP8+AELFsdeLdZBsp
   AJ1H1ToAg/Px6coUrZRBRX4qvpVCJhvF6kx3T0S8swgbZ37PoyTGE9Rhf
   A==;
X-CSE-ConnectionGUID: 1WshnoaVT36nA8K3g80jsA==
X-CSE-MsgGUID: aTM2Kga9RAil/liCSJl1gw==
X-IronPort-AV: E=Sophos;i="6.12,316,1728943200"; 
   d="scan'208";a="41055585"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Jan 2025 07:54:11 +0100
X-CheckPoint: {67875B93-18-31397509-E321C4C4}
X-MAIL-CPID: C9F704F06C0285F836D8E8AB81EE47DB_0
X-Control-Analysis: str=0001.0A682F1F.67875B93.00A3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFC8516A91B;
	Wed, 15 Jan 2025 07:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1736924047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUh82Ypecrl42cm19wZgKhQaors0qjkO/giiuR2KOqk=;
	b=Iu71vKgiqzPeJH2V5TD89VCu81IqxFpUJh0ZjRuZMm1udrUNMOetIU98aqDmll81DBdoGj
	syCmskQyC6VZxt/UVaY2g8G+rvolsJ3UnjYjHporp7F9oqHOltc35GHIM4heGM5h/bdhXG
	ERZNuN1rnGKePM5VDgQeJLy2yjN5MuuOOa1p1QYMcdT+qECWzfkkGgMVh7EayTBhAIFtTh
	QaKJmGKSUyXbSNG/bEBXRe+UzXF/z7fxxNxElcfYGU/7jMU6XWh9MhoU0U0zsZb5VJU/hy
	0bfVwKZVHQ1ElN/0W5b2ukQA3SAkq4AfVf4NBHAMx2Y3wYsWtD4392vPt9zVFw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: tudor.ambarus@linaro.org, pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org, Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Wed, 15 Jan 2025 07:54:05 +0100
Message-ID: <9397238.CDJkKcVGEf@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <mafs0zfjt5q3n.fsf@kernel.org>
References: <20241112075242.174010-1-linchengming884@gmail.com> <3342163.44csPzL39Z@steina-w> <mafs0zfjt5q3n.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Pratyush,

Am Dienstag, 14. Januar 2025, 17:15:24 CET schrieb Pratyush Yadav:
> On Tue, Jan 14 2025, Alexander Stein wrote:
>=20
> > Hello everyone,
> >
> > Am Dienstag, 12. November 2024, 08:52:42 CET schrieb Cheng Ming Lin:
> >> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >>=20
> >> The default dummy cycle for Macronix SPI NOR flash in Octal Output
> >> Read Mode(1-1-8) is 20.
> >>=20
> >> Currently, the dummy buswidth is set according to the address bus widt=
h.
> >> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
> >> dummy cycles to bytes, this results in 20 x 1 / 8 =3D 2 bytes, causing=
 the
> >> host to read data 4 cycles too early.
> >>=20
> >> Since the protocol data buswidth is always greater than or equal to the
> >> address buswidth. Setting the dummy buswidth to match the data buswidth
> >> increases the likelihood that the dummy cycle-to-byte conversion will =
be
> >> divisible, preventing the host from reading data prematurely.
> >>=20
> >> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
> >> Cc: stable@vger.kernel.org
> >> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
> >> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >> ---
> >>  drivers/mtd/spi-nor/core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >> index f9c189ed7353..c7aceaa8a43f 100644
> >> --- a/drivers/mtd/spi-nor/core.c
> >> +++ b/drivers/mtd/spi-nor/core.c
> >> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *n=
or,
> >>  		op->addr.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
> >> =20
> >>  	if (op->dummy.nbytes)
> >> -		op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
> >> +		op->dummy.buswidth =3D spi_nor_get_protocol_data_nbits(proto);
> >> =20
> >>  	if (op->data.nbytes)
> >>  		op->data.buswidth =3D spi_nor_get_protocol_data_nbits(proto);
> >>=20
> >
> > I just noticed this commit caused a regression on my i.MX8M Plus based =
board,
> > detected using git bisect.
> > DT: arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> > Starting with this patch read is only 1S-1S-1S, before it was
> > 1S-1S-4S.
> >
> > before:
> >> cat /sys/kernel/debug/spi-nor/spi0.0/params
> >> name            mt25qu512a
> >> id              20 bb 20 10 44 00
> >> size            64.0 MiB
> >> write size      1
> >> page size       256
> >> address nbytes  4
> >> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4B=
IT_BP
> >> | HAS_SR_BP3_BIT6 | SOFT_RESET
> >>=20
> >> opcodes
> >>=20
> >>  read           0x6c
> >> =20
> >>   dummy cycles  8
> >> =20
> >>  erase          0xdc
> >>  program        0x12
> >>  8D extension   none
> >>=20
> >> protocols
> >>=20
> >>  read           1S-1S-4S
> >>  write          1S-1S-1S
> >>  register       1S-1S-1S
> >>=20
> >> erase commands
> >>=20
> >>  21 (4.00 KiB) [1]
> >>  dc (64.0 KiB) [3]
> >>  c7 (64.0 MiB)
> >>=20
> >> sector map
> >>=20
> >>  region (in hex)   | erase mask | overlaid
> >>  ------------------+------------+----------
> >>  00000000-03ffffff |     [   3] | no
> >
> > after:
> >> cat /sys/kernel/debug/spi-nor/spi0.0/params
> >> name            mt25qu512a
> >> id              20 bb 20 10 44 00
> >> size            64.0 MiB
> >> write size      1
> >> page size       256
> >> address nbytes  4
> >> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4B=
IT_BP
> >> | HAS_SR_BP3_BIT6 | SOFT_RESET
> >>=20
> >> opcodes
> >>=20
> >>  read           0x13
> >> =20
> >>   dummy cycles  0
> >> =20
> >>  erase          0xdc
> >>  program        0x12
> >>  8D extension   none
> >>=20
> >> protocols
> >>=20
> >>  read           1S-1S-1S
> >>  write          1S-1S-1S
> >>  register       1S-1S-1S
> >>=20
> >> erase commands
> >>=20
> >>  21 (4.00 KiB) [1]
> >>  dc (64.0 KiB) [3]
> >>  c7 (64.0 MiB)
> >>=20
> >> sector map
> >>=20
> >>  region (in hex)   | erase mask | overlaid
> >>  ------------------+------------+----------
> >>  00000000-03ffffff |     [   3] | no
> >
> > AFAICT the patch seems sane, so it probably just uncovered another
> > problem already lurking somewhere deeper.
> > Given the HW similarity I expect imx8mn and imx8mm based platforms to be
> > affected as well.
> > Reverting this commit make the read to be 1S-1S-4S again.
> > Any ideas ow to tackling down this problem?
>=20
> Thanks for reporting this. I spent some time digging through this, and I
> think I know what is going on.
>=20
> Most controller's supports_op hook call spi_mem_default_supports_op(),
> including nxp_fspi_supports_op(). In spi_mem_default_supports_op(),
> spi_mem_check_buswidth() is called to check if the buswidths for the op
> can actually be supported by the board's wiring. This wiring information
> comes from (among other things) the spi-{tx,rx}-bus-width DT properties.
> Based on these properties, SPI_TX_* or SPI_RX_* flags are set by
> of_spi_parse_dt(). spi_mem_check_buswidth() then uses these flags to
> make the decision whether an op can be supported by the board's wiring
> (in a way, indirectly checking against spi-{rx,tx}-bus-width).
>=20
> In arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi we have:
>=20
> 	flash0: flash@0 {
> 		reg =3D <0>;
> 		compatible =3D "jedec,spi-nor";
> 		spi-max-frequency =3D <80000000>;
> 		spi-tx-bus-width =3D <1>;
> 		spi-rx-bus-width =3D <4>;
>=20
> Now the tricky bit here is we do the below in spi_mem_check_buswidth():
>=20
> 	if (op->dummy.nbytes &&
> 	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
> 		return false;
>=20
> The "true" parameter here means to "treat the op as TX". Since the board
> only supports 1-bit TX, the 4-bit dummy TX is considered as unsupported,
> and the op gets rejected. In reality, a dummy phase is neither a RX nor
> a TX. We should ideally treat it differently, and only check if it is
> one of 1, 2, 4, or 8, and not test it against the board capabilities at
> all.
>=20
> Alexander, can you test my theory by making sure it is indeed the dummy
> check in spi_mem_check_buswidth() that fails, and either removing it or
> passing "false" instead of "true" to spi_check_buswidth_req() fixes the
> bug for you?

Thanks for the explanation, this matches my observation. I'm using the
following diff
=2D--8<---
=2D-- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -150,7 +150,7 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
                return false;
=20
        if (op->dummy.nbytes &&
=2D           spi_check_buswidth_req(mem, op->dummy.buswidth, true))
+           spi_check_buswidth_req(mem, op->dummy.buswidth, false))
                return false;
=20
        if (op->data.dir !=3D SPI_MEM_NO_DATA &&
=2D--8<---
and I'm back at read 1S-1S-4S. So your theory is correct.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



