Return-Path: <stable+bounces-108632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A133A10E36
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6991678E5
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2301FA16E;
	Tue, 14 Jan 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JJo/2yeB"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC141F9F52;
	Tue, 14 Jan 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877105; cv=none; b=AlPwX0aUlv6QCcL21SzZPfApneWXsqpwsJy6vpXIzONIm6IQKYnwxvlp1qBp7xRyWhUNHuY8FYq8hOoYtRMJtNYdg4/8hxxc0uL1fOrtoD8xlhsVEPS5bvqX8k7Eg01/JDZ5SFqnoSPDDs9DcqsqZPiYkHt03kPWZhf0M6cuQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877105; c=relaxed/simple;
	bh=RIgH5xlGEh7zpAcM8UkufQeUQXGJ+YhTQW/JrMqOT38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Amoq2C3I2Dg+TNg5TQLlNXdjj0o2WTtffU1PPgKxxLcE5mTUBXVqDuyuzotF2G7qqq13KJZ25gh1VFfDwJT5+MhqQWMmQXKpiAQWcn3M5lV5PztXpQDckTLYu42Lh5QbIjZreBvtzgwf39gkjgg4iAbAklEC3ZHBWYnCldetF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JJo/2yeB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0794C1C0007;
	Tue, 14 Jan 2025 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736877100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXrbWWwouiOx3yRkqgUv0mzdSo2ohjgt018nIlxC86g=;
	b=JJo/2yeBbPQkrJ9gqV9ju4t/cLDYVYnOg9ZE3ot05ZGuDn93A6XG6+PpnqtnP5lcSobEeW
	YWtguohSqHUIvWyaT4MHj2gSFw1Cn9zAQ21HwVleOoc+u2FP21fPMWh0v9mnBLs6sa0Mz8
	Q/Bc4YSEQOqXk9ngZgbe3eTNwwmje//SyZWpBp90KBCfof4s49Q7mypzaxA1OGv99j/qL9
	iS63HUOrmV5aFNT63wZBVfQYymuikqIRiIG4OeW+/C+F/a8Bbqb87B+7w4W35f62W7tRBj
	aW0Yv7ICpBmfrb4djndmcO1zgx8+qzZN53d9+LXtGBDbzxdSQBPvsEfE+ZaB5w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
  tudor.ambarus@linaro.org,  mwalle@kernel.org,  richard@nod.at,
  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,
  Cheng Ming Lin <chengminglin@mxic.com.tw>,  stable@vger.kernel.org,
  Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
In-Reply-To: <mafs0zfjt5q3n.fsf@kernel.org> (Pratyush Yadav's message of "Tue,
	14 Jan 2025 16:15:24 +0000")
References: <20241112075242.174010-1-linchengming884@gmail.com>
	<20241112075242.174010-2-linchengming884@gmail.com>
	<3342163.44csPzL39Z@steina-w> <mafs0zfjt5q3n.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 14 Jan 2025 18:51:38 +0100
Message-ID: <87wmexp9lh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Pratyush,

On 14/01/2025 at 16:15:24 GMT, Pratyush Yadav <pratyush@kernel.org> wrote:

>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *no=
r,
>>>  		op->addr.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
>>>=20=20
>>>  	if (op->dummy.nbytes)
>>> -		op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
>>> +		op->dummy.buswidth =3D spi_nor_get_protocol_data_nbits(proto);

Facing recently a similar issue myself in the SPI NAND world, I believe
we should get rid of the notion of bits when it comes to the dummy
phase. I would appreciate a clarification like "dummy.cycles" which
would typically not require any bus width implications.

...

> Most controller's supports_op hook call spi_mem_default_supports_op(),
> including nxp_fspi_supports_op(). In spi_mem_default_supports_op(),
> spi_mem_check_buswidth() is called to check if the buswidths for the op
> can actually be supported by the board's wiring. This wiring information
> comes from (among other things) the spi-{tx,rx}-bus-width DT properties.
> Based on these properties, SPI_TX_* or SPI_RX_* flags are set by
> of_spi_parse_dt(). spi_mem_check_buswidth() then uses these flags to
> make the decision whether an op can be supported by the board's wiring
> (in a way, indirectly checking against spi-{rx,tx}-bus-width).

Thanks for the whole explanation, it's pretty clear.

> In arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi we have:
>
> 	flash0: flash@0 {
> 		reg =3D <0>;
> 		compatible =3D "jedec,spi-nor";
> 		spi-max-frequency =3D <80000000>;
> 		spi-tx-bus-width =3D <1>;
> 		spi-rx-bus-width =3D <4>;
>
> Now the tricky bit here is we do the below in spi_mem_check_buswidth():
>
> 	if (op->dummy.nbytes &&
> 	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
> 		return false;

May I challenge this entire section? Is there *any* reason to check
anything against dummy cycles wrt the width? Maybe a "can handle x
cycles" check would be interesting though, but I'd go for a different
helper, that is specific to the dummy cycles.

> The "true" parameter here means to "treat the op as TX". Since the
> board only supports 1-bit TX, the 4-bit dummy TX is considered as
> unsupported, and the op gets rejected. In reality, a dummy phase is
> neither a RX nor a TX. We should ideally treat it differently, and
> only check if it is one of 1, 2, 4, or 8, and not test it against the
> board capabilities at all.

...

> Since we are quite late in the cycle, and that changing
> spi_mem_check_buswidth() might cause all sorts of breakages, I think the
> best idea currently would be to revert this patch, and resend it with
> the other changes later.
>
> Tudor, Michael, Miquel, what do you think about this? We are at rc7 but
> I think we should send out a fixes PR with a revert. If you agree, I
> will send out a patch and a PR.

Either way I am fine. the -rc cycles are also available for us to
settle. But it's true we can bikeshed a little bit, so feel free to
revert this patch before sending the MR.

Thanks,
Miqu=C3=A8l

