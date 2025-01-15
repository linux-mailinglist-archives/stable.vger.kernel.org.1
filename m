Return-Path: <stable+bounces-108677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F96A11ADA
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 08:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9413A2FDC
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 07:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9F1DB130;
	Wed, 15 Jan 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti7jmkeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AE1DB129;
	Wed, 15 Jan 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925981; cv=none; b=sdAqb+CKMC4XuBbBdKFI+1/2k5ZMkrjkUvuw7JaVQuMXUD9oKxVEmzcPLLVcxwCtGXxpEfAnEKUhZAMXToyxhc8mx4maZReWSmyg0eq0RwQXA6IRBGe0gRc/tAt4NZAIdo4Fm1jo8TDxYzNewjtnX4hP1HZVR6LgstPM1YfSlNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925981; c=relaxed/simple;
	bh=s7ksFoD/PqRd2O9wRPOKsmEaBFHXMs0QFuIKBQdmC7I=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=oYqXHqQXd/3OV5MxmtVES2EdiWF2rttbDo86635uE2M4OElMj+WuvTKxqnSC2ckDJGU2iZLE1Mn8a/6Iz6LwvzKSL6kfOFfvTWvBCD3pJj4s49Qd/aDa4f3fJAbKq+yA7lnWDRaUfe1WDZ4cSXD6xVr+eL6a/Jy4u0UXlcUohzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti7jmkeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07D1C4CEDF;
	Wed, 15 Jan 2025 07:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736925981;
	bh=s7ksFoD/PqRd2O9wRPOKsmEaBFHXMs0QFuIKBQdmC7I=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=ti7jmkeK2s7uUVmgymsakoiQZssYQ7HivyLIgHp6+wpz7P4Atn5aL1KpAeFlp6YGq
	 DtY3DQcvHrfSAGhyFYWNhxq2/wIo/NOUjltxsm8D8KNpo1n95dxAv0Kc5ygT4d6KiD
	 SyEaNjtgKgN69HMViCOVl0Hf6oZI1Jn+LPOqKVzZB5AYrVX4Ckth4q7sd5ZF9E/qkc
	 E8WsED9Alpfd48G0j/LfwLlKWVDRO7Eh7jCLkHwiJ8WP/sTn4d1Ld2czSXTxWGV3jR
	 9+5BqszsQB9kC7bkB7xsnvoMHVdSUfcc8xFXLuq5+pXxgGF+K2qCZpcb5YDXRFb0Oc
	 Xt85+GDnmRzNA==
Content-Type: multipart/signed;
 boundary=8424e5f124607425b50bbb8b9c6837db20f9d6f50f7d8ea68da8b2a9e0fc;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 15 Jan 2025 08:26:11 +0100
Message-Id: <D72GVBSZNP5J.1NMQYXQ4SZLNF@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
Cc: "Alexander Stein" <alexander.stein@ew.tq-group.com>,
 <tudor.ambarus@linaro.org>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <alvinzhou@mxic.com.tw>, <leoyu@mxic.com.tw>, "Cheng Ming Lin"
 <chengminglin@mxic.com.tw>, <stable@vger.kernel.org>, "Cheng Ming Lin"
 <linchengming884@gmail.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20241112075242.174010-1-linchengming884@gmail.com>
 <20241112075242.174010-2-linchengming884@gmail.com>
 <3342163.44csPzL39Z@steina-w> <mafs0zfjt5q3n.fsf@kernel.org>
 <87wmexp9lh.fsf@bootlin.com> <mafs0ldvd5l2k.fsf@kernel.org>
In-Reply-To: <mafs0ldvd5l2k.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

--8424e5f124607425b50bbb8b9c6837db20f9d6f50f7d8ea68da8b2a9e0fc
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> >>>> --- a/drivers/mtd/spi-nor/core.c
> >>>> +++ b/drivers/mtd/spi-nor/core.c
> >>>> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor =
*nor,
> >>>>  		op->addr.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
> >>>> =20
> >>>>  	if (op->dummy.nbytes)
> >>>> -		op->dummy.buswidth =3D spi_nor_get_protocol_addr_nbits(proto);
> >>>> +		op->dummy.buswidth =3D spi_nor_get_protocol_data_nbits(proto);
> >
> > Facing recently a similar issue myself in the SPI NAND world, I believe
> > we should get rid of the notion of bits when it comes to the dummy
> > phase. I would appreciate a clarification like "dummy.cycles" which
> > would typically not require any bus width implications.
>
> I agree. All peripheral drivers convert cycles to bytes, and controller
> drivers convert them back to cycles. This whole thing should be avoided,
> especially since it contains some traps with division truncation.

Here is the relevant discussion:
https://lore.kernel.org/linux-mtd/f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc=
/

TLDR: yes, please use the notion of (clock) cycles. But there are
some problems to solve first.

> >> Since we are quite late in the cycle, and that changing
> >> spi_mem_check_buswidth() might cause all sorts of breakages, I think t=
he
> >> best idea currently would be to revert this patch, and resend it with
> >> the other changes later.
> >>
> >> Tudor, Michael, Miquel, what do you think about this? We are at rc7 bu=
t
> >> I think we should send out a fixes PR with a revert. If you agree, I
> >> will send out a patch and a PR.
> >
> > Either way I am fine. the -rc cycles are also available for us to
> > settle. But it's true we can bikeshed a little bit, so feel free to
> > revert this patch before sending the MR.
>
> To be clear, since the patch was added in v6.13-rc1 I want to revert it
> via a fixes pull request to Linus before he releases v6.13 this week. I
> want to fix it in v6.13, not in v6.14.

Since it's clearly a regression, I'd revert it.

-michael

--8424e5f124607425b50bbb8b9c6837db20f9d6f50f7d8ea68da8b2a9e0fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ4djFBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/g9WwF+KmWxaegQjOB76I7ox+ZlfZRBAxtBAqFI
KLSqgdy6UK7HbU1T9OFWXZHZCdqs4N2hAYD8QyeubcUT7mTp+a4TGMyH0ca6wbKd
yOHdmBPqoya1MS4yk1X8en3nMXSs8GIKp6k=
=K/Pe
-----END PGP SIGNATURE-----

--8424e5f124607425b50bbb8b9c6837db20f9d6f50f7d8ea68da8b2a9e0fc--

