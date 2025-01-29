Return-Path: <stable+bounces-111105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB94A21AA9
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F62166ABD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3590B17C68;
	Wed, 29 Jan 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QrPl/MsO"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DB1AB52F;
	Wed, 29 Jan 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144982; cv=none; b=Q6UOYqFoYmWre2K56s1m880H0BnbJeBN7GmmLvf6eSTdA0rNB8o76hBN3eYooDhS2rgHuzKPr2mVWPDtwDIIkmxSqjuzIyYl8gfaD6pleNcSPF3QBEVEBAnv0PBYyqdwrZJFxVWo2Dc3eOufYRSFnI867TXaHobQ8VC6dZ7QbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144982; c=relaxed/simple;
	bh=rmw/ngwGytokGJWygd9jZtWWgkKqrn6/GiRUSFazeJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dcc4WUt7j1JuY01iPMeFBMHtB2vNkrtZq4AHnSp3EGVpCmy9hB6TEqPfFwC39F/rwv450QBCM/osz1O785UgXMq9A6SfhJ25qnpALUwH/aaKbLfyoTwO9BzWUPDmf+/NaLK3A4mrzHEbGDEf1eC1DfquFPxRzGu3L5uCRhc5gkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QrPl/MsO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66BE61BF20B;
	Wed, 29 Jan 2025 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738144971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcl0cPx8rZqpTFMCORA9hZrc9Kug1hp+prCqbj9pEgU=;
	b=QrPl/MsO/h9YF32cczxmsjuVZq58MJ+WfKoqouPOj+MI/ZxUOJBFcez4Oas31NeP8HsfzR
	nf+ahhv/KXSsl9g+3cqiwmYZzZC/b0OPOVD2bWthqPiqH5MnPJJVkuJQ73ndGmDn8K9gul
	5VWQ3ubZQFydw6vNn0BzZpPHSUz9lrY+369kTvK5D0VDBLc1EL5hKe7R13OA1yZuKeG6gI
	crXNgOiX1c8pXqF4tv5KEHNXbX0PoikB+hyg+y7Tw2vzQtC4EKRq8oDyxY9waEy35ose+2
	z3Pb+U7wqkyVF9kwl5DDbNsYG5qGqgt7qDHrYP5LImJH1OUueV+BwRknyANU/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  "linux@treblig.org" <linux@treblig.org>,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob
 when DMA is not ready
In-Reply-To: <BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
	(Niravkumar L. Rabara's message of "Wed, 29 Jan 2025 09:17:29 +0000")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 29 Jan 2025 11:02:49 +0100
Message-ID: <874j1i0wfq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> > --- a/drivers/mtd/nand/raw/cadence-nand-controller.c
>> > +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
>> > @@ -2908,7 +2908,7 @@ static int cadence_nand_init(struct cdns_nand_ct=
rl
>> *cdns_ctrl)
>> >  		if (!cdns_ctrl->dmac) {
>> >  			dev_err(cdns_ctrl->dev,
>> >  				"Unable to get a DMA channel\n");
>> > -			ret =3D -EBUSY;
>> > +			ret =3D -EPROBE_DEFER;
>>=20
>> Does it work if there is no DMA channel provided? The bindings do not me=
ntion
>> DMA channels as mandatory.
>>=20
>
> The way Cadence NAND controller driver is written in such a way that it u=
ses=20
> has_dma=3D1 as hardcoded value, indicating that slave DMA interface is co=
nnected
> to DMA engine. However, it does not utilize the dedicated DMA channel inf=
ormation
> from the device tree.

This is not ok.

> Driver works without external DMA interface i.e. has_dma=3D0.=20
> However current driver does not have a mechanism to configure it from
> device tree.

What? Why are you requesting a DMA channel from a dmaengine in this case?

Please make the distinction between the OS implementation (the driver)
and the DT binding which describe the HW and only the HW.

>> Also, wouldn't it be more pleasant to use another helper from the DMA co=
re
>> that returns a proper return code? So we now which one among -EBUSY, -
>> ENODEV or -EPROBE_DEFER we get?
>>=20
>
> Agree.
> I will change to "dma_request_chan_by_mask" instead of "dma_request_chann=
el "
> so it can return a proper error code.=20
>=20=20=20
> 		cdns_ctrl->dmac =3D dma_request_chan_by_mask(&mask);
> 		if (IS_ERR(cdns_ctrl->dmac)) {
> 			ret =3D PTR_ERR(cdns_ctrl->dmac);
> 			if (ret !=3D -EPROBE_DEFER)
> 				dev_err(cdns_ctrl->dev,
> 					"Failed to get a DMA channel:%d\n",ret);
> 			goto disable_irq;
> 		}
>
> Is this reasonable?

It is better, but maybe you can use dev_err_probe() instead to include
the EPROBE_DEFER error handling.

Thanks,
Miqu=C3=A8l

