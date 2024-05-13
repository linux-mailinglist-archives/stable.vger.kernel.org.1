Return-Path: <stable+bounces-43597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAB8C3BB2
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80481C20FB0
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E481146A61;
	Mon, 13 May 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I/Wsb2GW"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1E1FA1
	for <stable@vger.kernel.org>; Mon, 13 May 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583931; cv=none; b=ZGLPJq14EA2b00NHCspiJs4yvJlzRl3nbUdCbxpPw0XVYn63Swd2ZWAP6kASqQ6XevLvdyS99slL/pN/h1+grJTmaSNfIxVPSGgneasdXRx6+ACGMcJhnHexOdJziYyVTSHxmzfESqftmCdNLagA4B2lZmeDVrgLuGtQx8T+Qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583931; c=relaxed/simple;
	bh=hLe9t6L9RmIOeK3PAtEKlDVP+GKSvBz2Z2/alF2xSBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdCNuLLyyGCpN8WT0ScgTJrlMLLiv62CnGhori+4YhA0DuACzpezOcOD+2ChhiexfqdmYez0Jcl1BcytGd6O1t5Axq6wwoh9ccLhAUOlgPAIVw7usIPHyt2z2Z/w+fmUZT92Col9LJ40X6iZ1z8ESx8vW7OFWcpBlUPrWieyazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I/Wsb2GW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59D0F1BF206;
	Mon, 13 May 2024 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715583925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hKAuHOrxtaW6B++O9Akco8z16LZrZFOupClPDMqqQE=;
	b=I/Wsb2GWCsVeCGeCaO7LSprRYioI+PVBXrCI0H+8i5OuGD35Dto8wVEt1PSthxd35VbqMT
	iGO9QHKnml4oeBX4BGlWTLzsQFidPe4E+XkRstYGjUqujt/8NrNuZSE8Ry7ofXt+ckoXUx
	vDXJOmOEi2Z/yh1Npr9Trm5peea3swHfozRG8kwSVGycmp0bZIRa+q3v12lhdjzj4RAH0b
	Q6nLQk9jPfjnLQhL2m5uSOkkAeEDajTCMBUcKaVBbTu/Ypk8VJ/84DUVHVAr5wB4obFSIK
	m9lcRXTB94QXVAJrdKPC5JBKCeHVXIcnLA0FrJ4hdXzs8nvm+9h9jQf49kcRuw==
Date: Mon, 13 May 2024 09:05:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, Steven Seeger
 <steven.seeger@flightsystems.net>
Subject: Re: [PATCH 2/2] mtd: rawnand: Bypass a couple of sanity checks
 during NAND identification
Message-ID: <20240513090523.687ad7f4@xps-13>
In-Reply-To: <20240508-patient-cover-54085f1981d8@thorsis.com>
References: <20240507160546.130255-1-miquel.raynal@bootlin.com>
	<20240507160546.130255-3-miquel.raynal@bootlin.com>
	<20240508-patient-cover-54085f1981d8@thorsis.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Alexander,

ada@thorsis.com wrote on Wed, 8 May 2024 08:41:44 +0200:

> Hello Miquel,
>=20
> Am Tue, May 07, 2024 at 06:05:46PM +0200 schrieb Miquel Raynal:
> > Early during NAND identification, mtd_info fields have not yet been
> > initialized (namely, writesize and oobsize) and thus cannot be used for
> > sanity checks yet. Of course if there is a misuse of
> > nand_change_read_column_op() so early we won't be warned, but there is
> > anyway no actual check to perform at this stage as we do not yet know
> > the NAND geometry.
> >=20
> > So, if the fields are empty, especially mtd->writesize which is *always*
> > set quite rapidly after identification, let's skip the sanity checks.
> >=20
> > nand_change_read_column_op() is subject to be used early for ONFI/JEDEC
> > identification in the very unlikely case of:
> > - bitflips appearing in the parameter page,
> > - the controller driver not supporting simple DATA_IN cycles.
> >=20
> > Fixes: c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page read=
 to constraint controllers")
> > Fixes: daca31765e8b ("mtd: rawnand: jedec: Adapt the parameter page rea=
d to constraint controllers")
> > Cc: stable@vger.kernel.org
> > Reported-by: Alexander Dahl <ada@thorsis.com>
> > Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65e=
a97d7@thorsis.com/
> > Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
> > Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A67=
0BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index 248e654ecefd..a66e73cd68cb 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -1440,12 +1440,14 @@ int nand_change_read_column_op(struct nand_chip=
 *chip,
> >  	if (len && !buf)
> >  		return -EINVAL;
> > =20
> > -	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
> > -		return -EINVAL;
> > +	if (mtd->writesize) {
> > +		if ((offset_in_page + len > mtd->writesize + mtd->oobsize))
> > +			return -EINVAL; =20
>=20
> These doubled (( )) are new and I think not necessary?

Oops, true.

Any chances you'll be able to test the patchset?

Same question for Steven!

Cheers,
Miqu=C3=A8l

