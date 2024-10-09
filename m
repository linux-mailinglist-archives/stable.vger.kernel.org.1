Return-Path: <stable+bounces-83230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C8996E91
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7E8B232B7
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74919B3D3;
	Wed,  9 Oct 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GN3QVd8v"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DED199FAF
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485283; cv=none; b=pjC6Tn/XCgwxVhOUaOmcZuPRsWNLerbeCI7fZRLGzha0t4nSyjs3EvlVeTousX8m4hHntSayaUMOhbXOLj4mf60RDKKMsA9nLWJdND0i+VtVAYxi+4B6gRHbygp3EL71i+ChotjcXEnZjXv0kMiXCzNGO0uhd2OgrrjRodyMf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485283; c=relaxed/simple;
	bh=Uk0KPCtVm1MKB9yeaaWwBQIEavfH89OFn7myYjG6PVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dO8/Pz3AL4ii47gexuZ+v79cz+fJQcNVK+FWvKYKeVc3Y2o4szofGt8WLfFG8WCsyWsYjIsOLbA1Iu5VN9sMjo9o2F3D5blxC10EA05HsiYVnk4EMkOgJqEKLodFgS5f0gieOfwrHdf5vl+g1UbNa5vHfTc16VT2WhgQH9asMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GN3QVd8v; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E81131C000A;
	Wed,  9 Oct 2024 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728485279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk0KPCtVm1MKB9yeaaWwBQIEavfH89OFn7myYjG6PVc=;
	b=GN3QVd8vooavbeQJM+8xQxNXCaS6ufJA89s1aJ5pznYI/d9rODUASXTo6A1fhLCdmG0UOq
	TBVDSuD59Z9K2Yk5m6dYdUcncz3SrPkpsUn+2uu/1EmuMAxNZeaLrjUoy7Kkl2Hfyn8a0E
	uVexEHTaCNSVwHhN1y3rwQdmIp9dA59jofbwf8DMVE6VotDQPmUnEwM8XMvJo0OATbOnuq
	72qKnUuVzu5sjJjPEYpBDygh8W/Sr7tMX3UIXpTbAhQtZ3erd+fDDY6QAPxbQOFvwIi/go
	S0oEx3l/42HkVZJfScvSL/+fWjkfXMTgkXZUbcB7GWrNn3P6Y+BM6cGPlfxauw==
Date: Wed, 9 Oct 2024 16:47:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, Steam Lin <stlin2@winbond.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, Sridharan S N <quic_sridsn@quicinc.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mtd: spi-nand: winbond: Fix 512GW, 01GW, 01JW and
 02JW ECC information
Message-ID: <20241009164757.049d702c@xps-13>
In-Reply-To: <3345c66e-6f18-4bc7-8e52-4af7de6ff401@kontron.de>
References: <20241009125002.191109-1-miquel.raynal@bootlin.com>
	<20241009125002.191109-3-miquel.raynal@bootlin.com>
	<3345c66e-6f18-4bc7-8e52-4af7de6ff401@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frieder,

frieder.schrempf@kontron.de wrote on Wed, 9 Oct 2024 15:33:11 +0200:

> On 09.10.24 2:50 PM, Miquel Raynal wrote:
> > These four chips:
> > * W25N512GW
> > * W25N01GW
> > * W25N01JW
> > * W25N02JW
> > all require a single bit of ECC strength and thus feature an on-die
> > Hamming-like ECC engine. There is no point in filling a ->get_status()
> > callback for them because the main ECC status bytes are located in
> > standard places, and retrieving the number of bitflips in case of
> > corrected chunk is both useless and unsupported (if there are bitflips,
> > then there is 1 at most, so no need to query the chip for that).
> >=20
> > Without this change, a kernel warning triggers every time a bit flips.
> >=20
> > Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAN=
D flash")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> I had a quick look at the datasheets and this seems correct to me.

Thanks a lot for the rapid review!

> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks,
Miqu=C3=A8l

