Return-Path: <stable+bounces-45301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1F8C7897
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0151C21C70
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307014B953;
	Thu, 16 May 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="px1o2/fB"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC01487DD
	for <stable@vger.kernel.org>; Thu, 16 May 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870722; cv=none; b=eyfL3RK/9+6rGn7kV61by9g1lCRLFdXOXIDdavhf/WqXmLIGCne3vXWhRiyvMTC67h/IaBQvbUnOTa5tdFx2Uj+DQ6ItIntTD68++B4evgyKFTPDunqdFvRaKknuPHYTnVLnFiAoB/ZBdhcgunpJV5MxG4Da4yMi8qPLfm4CX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870722; c=relaxed/simple;
	bh=oOs7/bHKgR222SIQmU7FD9JdgLv1BgNw+gxLOsxdL6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sthV0Qcqaxzx19Mz7DodfKHJNZJwxLoC6un1TwIgeHTFutfa9BWv/GMgC+Syama/eXeEYPzl9XKUMJfy/IuyBeD3NfuKNpsASlZynUC51WONPHddpigc8WGsysfUNjBPtIx4dQy3CrhUQlRL4cMVYHswhwax8jvsbTkw5Twff1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=px1o2/fB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0017C40007;
	Thu, 16 May 2024 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715870717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOs7/bHKgR222SIQmU7FD9JdgLv1BgNw+gxLOsxdL6Q=;
	b=px1o2/fBTXGA0HZ8ztj5KZTH6f4cco/C/bfjn0P0/rwHCinhOqsPFe8G00Dd0V4GszYr46
	O7kAzC30lwNjzVYN8VyIA8gtfxZ1VcuTM1zT/8kWZgWPFSeUtYFTcOxH6FV9mxz22xiryP
	1lVQo1ZzYEGRPiKXAVvuOZrUx1jVbb8xnjbzLD2nDEJSFQ8ylI4JAjWGhVjjGkDYwicr6b
	EMhsWF6RG2VGOFaBCkNEB4VL0nLhMq2ZHw+sC1aBh3QXSBHW9j744Isnn/MDvvJWVyKcb3
	VgisAhh6PIM08QFo/YyDQbAAeOfIqkNTT+LDSrlonyrun9ozXP5u6LI3YWvlwg==
Date: Thu, 16 May 2024 16:45:16 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, Alexander Dahl <ada@thorsis.com>, Steven
 Seeger <steven.seeger@flightsystems.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: rawnand: Bypass a couple of sanity checks
 during NAND identification
Message-ID: <20240516164516.4e5ad1cb@xps-13>
In-Reply-To: <ZkYPdbspX5tc0WRf@pengutronix.de>
References: <20240516131320.579822-1-miquel.raynal@bootlin.com>
	<20240516131320.579822-3-miquel.raynal@bootlin.com>
	<ZkYPdbspX5tc0WRf@pengutronix.de>
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

Hi Sascha,

s.hauer@pengutronix.de wrote on Thu, 16 May 2024 15:51:49 +0200:

> On Thu, May 16, 2024 at 03:13:20PM +0200, Miquel Raynal wrote:
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
> > As nand_change_read_column_op() uses nand_fill_column_cycles() the logic
> > explaind above also applies in this secondary helper.
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
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> With the attached debug patch applied I can confirm that I can now read
> all three ONFI parameter pages successfully using
> nand_change_read_column_op(), so:
>=20
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Excellent!

Thanks,
Miqu=C3=A8l

