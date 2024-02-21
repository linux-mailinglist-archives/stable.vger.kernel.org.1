Return-Path: <stable+bounces-23204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5085E3C6
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 550F6B22EAB
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBEA82D99;
	Wed, 21 Feb 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NifKBHox"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6782D6B
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534414; cv=none; b=ZfKgTOT6/aBXUvdsmDEYNNLnEK9DvAOIhZcQeG+9QJ5U2BHzljztEdQx7rx5o2XiyYN9QVylvCVIkrChyY0H/3MyjYGoauJzzTB08j/zxaZJhRhHaWyatoakcaf6AObb+ACS359uPboS+6Km1gZ+hYnKRBzbh7fQNtzSQUXWbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534414; c=relaxed/simple;
	bh=5u2SEUNdFenZeGcQm8hYpGPJL/jYMT0G5fxaeeTX7lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGNKHpidSOTRNaiOd2whjLM5T/b6piyhxLak1ZCWbaBeELxr3lfGAozcLXdnqUPnGxmlYY/WN556uyIZF2ioqqt/YJvlx0UHMGGwSD1gspe2IJLDtSaph1S7jFgX/5ueiU7mZG1ltcXtCdc+cg27cxGvtKRMEU7GlHX2E6HmYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NifKBHox; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84DFF40003;
	Wed, 21 Feb 2024 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708534410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1hdeVQ8w9ifKc+NIqRjOz0AGu74hIuMo8Gh+iy8sYE=;
	b=NifKBHoxcCIbXNFVEgVxBedop3PzRKuZdy0TkqyKpyjnApja9oltJ4EcQqhrQwx6FO2r1F
	vfz3r3jI+XySvxXA8FixN0HFMTz/cN3Qy4+uX0N+h4rfPIVgdYX2Usy4LQuitzYSAWt2qX
	hWTcr/EAybYn5tBkW/KW1SLJukGGDckgT00gEGrPbHI4EWhq/Qh2sDXr4bQnomWzAygeGM
	VAHx7Q1UzYvLDIVIuEXv7kZPklFwbQ6L7HzFHDJXI6FkrK7Ks3/nBbMcxg87lfI0EKuizJ
	obxUiLpIOljXalriynsRYvFWd6gF/w1DlWWLXsjp0mMpM4fkEkPIodbMhfshZw==
Date: Wed, 21 Feb 2024 17:53:27 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 <linux-mtd@lists.infradead.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Julien Su <juliensu@mxic.com.tw>, Jaime
 Liao <jaimeliao@mxic.com.tw>, Jaime Liao <jaimeliao.tw@gmail.com>, Alvin
 Zhou <alvinzhou@mxic.com.tw>, <eagle.alexander923@gmail.com>,
 <mans@mansr.com>, <martin@geanix.com>, Sean =?UTF-8?B?Tnlla2rDpnI=?=
 <sean@geanix.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4/4] mtd: rawnand: Clarify conditions to enable
 continuous reads
Message-ID: <20240221175327.42f7076d@xps-13>
In-Reply-To: <8ed32443-1343-4970-9f5a-34285850b372@foss.st.com>
References: <20231222113730.786693-1-miquel.raynal@bootlin.com>
	<cce57281-4149-459f-b741-0f3c08af7d20@foss.st.com>
	<20240221122032.502fbf3f@xps-13>
	<8ed32443-1343-4970-9f5a-34285850b372@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Christophe,

christophe.kerello@foss.st.com wrote on Wed, 21 Feb 2024 17:29:45 +0100:

> Hi Miquel,
>=20
> On 2/21/24 12:20, Miquel Raynal wrote:
> > Hi Christophe,
> >=20
> > christophe.kerello@foss.st.com wrote on Fri, 9 Feb 2024 14:35:44 +0100:
> >  =20
> >> Hi Miquel,
> >>
> >> I am testing last nand/next branch with the MP1 board, and i get an is=
sue since this patch was applied.
> >>
> >> When I read the SLC NAND using nandump tool (reading page 0 and page 1=
), the OOB is not displayed at expected. For page 1, oob is displayed when =
for page 0 the first data of the page are displayed.
> >>
> >> The nanddump command used is: nanddump -c -o -l 0x2000 /dev/mtd9 =20
> >=20
> > I believe the issue is not in the indexes but related to the OOB. I
> > currently test on a device on which I would prefer not to smash the
> > content, so this is just compile tested and not run time verified, but
> > could you tell me if this solves the issue:
> >=20
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -3577,7 +3577,8 @@ static int nand_do_read_ops(struct nand_chip *chi=
p, loff_t from,
> >          oob =3D ops->oobbuf;
> >          oob_required =3D oob ? 1 : 0; =20
> >   > -       rawnand_enable_cont_reads(chip, page, readlen, col); =20
> > +       if (!oob_required)
> > +               rawnand_enable_cont_reads(chip, page, readlen, col); =20
>=20
> I am still able to reproduce the problem with the patch applied.
> In fact, when nanddump reads the OOB, nand_do_read_ops is not called, but=
 nand_read_oob_op is called, and as cont_read.ongoing=3D1, we are not dumpi=
ng the oob but the first data of the page.
>=20
> page 0:
> [   57.642144] rawnand_enable_cont_reads: page=3D0, col=3D0, readlen=3D40=
96, mtd->writesize=3D4096
> [   57.650210] rawnand_enable_cont_reads: end_page=3D1
> [   57.654858] nand_do_read_ops: cont_read.ongoing=3D1
> [   59.352562] nand_read_oob_op
> page 1:
> [   59.355966] rawnand_enable_cont_reads: page=3D1, col=3D0, readlen=3D40=
96, mtd->writesize=3D4096
> [   59.364045] rawnand_enable_cont_reads: end_page=3D1
> [   59.368757] nand_do_read_ops: cont_read.ongoing=3D0
> [   61.390098] nand_read_oob_op
>=20
> I have not currently bandwidth to work on this topic and I need to unders=
tand how continuous read is working, but I have made a patch and I do not h=
ave issues with it when I am using nanddump or mtd_debug tools.

Actually since my previous answer I managed to reproduce the issue. I
was unable to do it because I was testing at the beginning of the
second partition, instead of the beginning of the device. I also
observe the same behavior.

> I have not tested it on a file system, so it is just a proposal.
>
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -3466,22 +3466,18 @@ static void rawnand_enable_cont_reads(struct nand=
_chip *chip, unsigned int page,
>   				      u32 readlen, int col)
>   {
>   	struct mtd_info *mtd =3D nand_to_mtd(chip);
> -	unsigned int end_page, end_col;
> +	unsigned int end_page;
>=20
>   	chip->cont_read.ongoing =3D false;
>=20
> -	if (!chip->controller->supported_op.cont_read)
> +	if (!chip->controller->supported_op.cont_read || col + readlen <=3D mtd=
->writesize)
>   		return;
>=20
> -	end_page =3D DIV_ROUND_UP(col + readlen, mtd->writesize);
> +	end_page =3D page + DIV_ROUND_UP(col + readlen, mtd->writesize) - 1;

I had a similar change on my side so I believe this is needed.

> -	end_col =3D (col + readlen) % mtd->writesize;

We shall ensure we only enable continuous reads on full pages, to avoid
conflicts with the core trying to optimize things out. So I believe
this change won't fly, but I get the idea, there is definitely
something to fix there.

>=20
>   	if (col)
>   		page++;
>=20
> -	if (end_col && end_page)
> -		end_page--;
> -
>   	if (page + 1 > end_page)
>   		return;
>=20
> Tell me if this patch is breaking the continuous read feature or if it ca=
n be pushed on the mailing list.

I'll have deeper look into this tomorrow and get back to you. Thanks a
lot for the proposal though, I will work on it.

>=20
> Regards,
> Christophe Kerello.
>=20
> >   >          while (1) { =20
> >                  struct mtd_ecc_stats ecc_stats =3D mtd->ecc_stats;
> >=20
> >=20
> > If that does not work, I'll destroy the content of the flash and
> > properly reproduce.
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l

