Return-Path: <stable+bounces-108621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98DA10C34
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333701888D76
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7EF189B8F;
	Tue, 14 Jan 2025 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YFxXolk8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UgGDKLwZ"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9C13BAEE;
	Tue, 14 Jan 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871886; cv=none; b=OXHZoHEA5/tbEmb6gDBt2V5XOLurKBrFmAkFbxZq8mTr6L9C4xkqxFfFGIf9AiTgiGXxHkE3ejEAVRIo6hdEvus8iz3JZKW/Fm72HEFTL+Mh590VZKoi/LjfTBl7IYce+WL3hV3MM29NWs++BfUQvaKdZHNrNDBr0fJw7htEzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871886; c=relaxed/simple;
	bh=SuwsoYXiDZ1MHrWojiZH+LqdP7OVMzraPxLdy8klUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di4OPfAhakRduP31KrA7TMFQ7IDGrRHw0EnylBarShUl8yoXG2eRX60dWfBgjWSs5WF7ry3c3CHoFsyq/xQRWL7DsiIT6EA2JdIp1GQl2RkVgJVIC97ikj1VEyLaZZRDr4y7uAbS4QGd5ysIsVvE9DELnRE7UZR/mRZFR7Tgvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YFxXolk8; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UgGDKLwZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1736871883; x=1768407883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=39dVf0Tb0fckv4UPirWil96f+ziUJtDlcOjzF/ZAKhQ=;
  b=YFxXolk8jMvyMCkhNupXZ+t+PM79Cxjk17pyjlFowQ3DZKtQOm5mnCGM
   Sz2zMLrktCLm2UlhVakdtruPFM9rIgMdsN28LkT8kY9f7sb6u2ow5psbY
   KMP6d5x+nLebSmx+yHnB5Atw7NCTncO+QzaLBlMnDVySe/QUb8ikKEmfl
   e6aBBL65zk4gkvD+Z1GXNLom+4nNMe3b4I+z9eogDkr8L6gm8lBpRxyBp
   KdgWn4GgsEgI9cTlIMUMzcue1vqbBmBbL4SZj3AU4AHEPvGpqigvQ5aMK
   53wjyEddqc14RVscH+q+so5JJ4VUqhWTs2urPA6ZWnFbyIziM3kf4voKG
   g==;
X-CSE-ConnectionGUID: OXSJm04TSmWgqkeplEc0ew==
X-CSE-MsgGUID: Td7csQGBQomFzwXILfKdfQ==
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="41047167"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Jan 2025 17:24:38 +0100
X-CheckPoint: {67868FC6-12-1CE016C0-E589DA3E}
X-MAIL-CPID: A189C402A519FB2DCE8FDD4064935AF3_1
X-Control-Analysis: str=0001.0A682F1C.67868FC7.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EE681691A5;
	Tue, 14 Jan 2025 17:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1736871874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39dVf0Tb0fckv4UPirWil96f+ziUJtDlcOjzF/ZAKhQ=;
	b=UgGDKLwZHj6xCzHqavdmXYZqlqxeU64reflfx/mGDvC8UVNdojAGjaweJYhmoG1lVHf31A
	6/EiyWhCFrrll20Tc+LkPBJJ/4mBa434wYUxsfuZEcTqEq1SsyDF976aVtteY6n/tJdQwm
	22Dmc0w1vrDRQsaeEKxrGSED8c4bBleQllsfk4UhQUAMtfP7MofNjfZhvEH9oEfxqFQOUu
	I9imW0UJibd4M7fQv1UcCfOpaxbmthY+bNT78FPZ4qNuK6TRhoygyLWyvUTIz+i4iv19MT
	p83bhr6fkzYX8VqPiLAOtFDUEMSTDNebiDBj1pnTxB95ShAeKjCAGDlvAnj/Rw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org, Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Tue, 14 Jan 2025 17:24:32 +0100
Message-ID: <7762352.EvYhyI6sBW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <a6a9dfce-6cac-4831-9c96-45471f5ee13a@linaro.org>
References: <20241112075242.174010-1-linchengming884@gmail.com> <3342163.44csPzL39Z@steina-w> <a6a9dfce-6cac-4831-9c96-45471f5ee13a@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Tudor,

Am Dienstag, 14. Januar 2025, 14:26:47 CET schrieb Tudor Ambarus:
> On 1/14/25 12:57 PM, Alexander Stein wrote:
> > Hello everyone,
>=20
> Hi,
>=20
> >=20
> > Am Dienstag, 12. November 2024, 08:52:42 CET schrieb Cheng Ming Lin:
> >> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >>
> >> The default dummy cycle for Macronix SPI NOR flash in Octal Output
> >> Read Mode(1-1-8) is 20.
> >>
> >> Currently, the dummy buswidth is set according to the address bus widt=
h.
> >> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
> >> dummy cycles to bytes, this results in 20 x 1 / 8 =3D 2 bytes, causing=
 the
> >> host to read data 4 cycles too early.
> >>
> >> Since the protocol data buswidth is always greater than or equal to the
> >> address buswidth. Setting the dummy buswidth to match the data buswidth
> >> increases the likelihood that the dummy cycle-to-byte conversion will =
be
> >> divisible, preventing the host from reading data prematurely.
> >>
> >> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
> >> Cc: stable@vger.kernel.org
> >> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
> >> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >> ---
> >>  drivers/mtd/spi-nor/core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
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
> >>
> >=20
> > I just noticed this commit caused a regression on my i.MX8M Plus based =
board,
> > detected using git bisect.
> > DT: arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> > Starting with this patch read is only 1S-1S-1S, before it was
> > 1S-1S-4S.
> >=20
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
> >>
> >> opcodes
> >>
> >>  read           0x6c
> >> =20
> >>   dummy cycles  8
> >> =20
> >>  erase          0xdc
> >>  program        0x12
> >>  8D extension   none
> >>
> >> protocols
> >>
> >>  read           1S-1S-4S
> >>  write          1S-1S-1S
> >>  register       1S-1S-1S
> >>
> >> erase commands
> >>
> >>  21 (4.00 KiB) [1]
> >>  dc (64.0 KiB) [3]
> >>  c7 (64.0 MiB)
> >>
> >> sector map
> >>
> >>  region (in hex)   | erase mask | overlaid
> >>  ------------------+------------+----------
> >>  00000000-03ffffff |     [   3] | no
> >=20
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
> >>
> >> opcodes
> >>
> >>  read           0x13
> >> =20
> >>   dummy cycles  0
> >> =20
> >>  erase          0xdc
> >>  program        0x12
> >>  8D extension   none
> >>
> >> protocols
> >>
> >>  read           1S-1S-1S
> >>  write          1S-1S-1S
> >>  register       1S-1S-1S
> >>
> >> erase commands
> >>
> >>  21 (4.00 KiB) [1]
> >>  dc (64.0 KiB) [3]
> >>  c7 (64.0 MiB)
> >>
> >> sector map
> >>
> >>  region (in hex)   | erase mask | overlaid
> >>  ------------------+------------+----------
> >>  00000000-03ffffff |     [   3] | no
> >=20
> > AFAICT the patch seems sane, so it probably just uncovered another
> > problem already lurking somewhere deeper.
> > Given the HW similarity I expect imx8mn and imx8mm based platforms to be
> > affected as well.
> > Reverting this commit make the read to be 1S-1S-4S again.
> > Any ideas ow to tackling down this problem?
> >=20
>=20
> My guess is that 1S-1S-4S is stripped out in
> spi_nor_spimem_adjust_hwcaps(). Maybe the controller has some limitation
> in nxp_fspi_supports_op(). Would you add some prints, and check these
> chunks of code?

Thanks for the fast response. I was able to track it down.
Eventually the buswidth check in spi_check_buswidth_req fails.
=46or command 0x3c:
Before revert:
> mode: 0x800, buswidth: 2
After revert
> mode: 0x800, buswidth: 1

The mode is set to SPI_RX_QUAD. Thus the check for dummy buswidth fails
now that data_nbits are used now.

=46or command 0x6c it's similar but op->dummy.buswidth is 4 now.

It boils down that there are SPI controllers which have
> spi-tx-bus-width =3D <1>;
> spi-rx-bus-width =3D <4>;
set in their DT nodes.

So it seems this combination is not supported.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



