Return-Path: <stable+bounces-192631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3137C3C3C1
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3E604EDA44
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87AD34887C;
	Thu,  6 Nov 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQYtabMx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DA32C92B;
	Thu,  6 Nov 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444801; cv=none; b=jGWpN8TVwit0sZEQClRIu70Bq9O93SOxRiYQ47RvTrZsgSB+1W3r5Z6RqQP1Ekcv44lJsqmKaOGU7Yx1fxudaHfElI9Sd/wlaVX2j2v4y6k1KyBvpEN4gyhYgXdrdtOUP2Dwpbm8SCrkW4LIGMBaZZDWjz1qkZJPFb/bYn5mBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444801; c=relaxed/simple;
	bh=kMevgBC3784Ru3EW9QJAXWDvODDi8xcAADr0sE14jHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MN1Lprqt2lOFNBKdy6b0Ee1cbjFXDaGy4LWR987xBDAWx+17xT8CLBm8oxU0PL83h860yEMXuEzLm2+NDzFVJAHVxUg+Bl8UbHTE50joCv5SP0leu3ylKIr10lPJ5u2vR1fORZfOykheX/eq7EClDNqjuL3tB2Iw7v8OyJeZrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQYtabMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64129C116B1;
	Thu,  6 Nov 2025 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762444799;
	bh=kMevgBC3784Ru3EW9QJAXWDvODDi8xcAADr0sE14jHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FQYtabMxQzNGwYpM1TktPaQ1EAJDPPduPQ2aWZqE/uG8noq7yWaBvbyTV2QIiDySb
	 jmOgs9AOzFCBVLnzpMS8E0OaNRDRY7pj8Ju4kNh0wcmvWmhH3lyGpS3jvMgzgICo4N
	 rzMuaWseYumZ+dMId44VqDVFGidHBM85erlClvmHC4kGSt5tY300GOzhKzzeqoKZDo
	 91ie2XrHhy+OHzWl8ImmccbeCDu+Z1FFArrN3r9iOFkh8OmGRzr0ImYHEn2GKeYK9U
	 z95X92OQw+Ujq2FATT+HOAR9qkHVlHnuxSAc3RLJN+7zI35PHHYIdnkldqLfxU37y2
	 w0zVc/JsJT8ZQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin
 <STLin2@winbond.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH 0/6] Hello,
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
 (Miquel
	Raynal's message of "Wed, 05 Nov 2025 18:26:59 +0100")
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
Date: Thu, 06 Nov 2025 16:59:56 +0100
Message-ID: <mafs0h5v7b18j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05 2025, Miquel Raynal wrote:

> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
> these chips is needed otherwise the block protection feature is not
> available. Everything else looks fine otherwise.
>
> In practice I am only adding 6 very similar IDs but I split the commits
> because the amount of meta data to show proof that all the chips have
> been tested and work is pretty big.
>
> As the commits simply add an ID, I am Cc'ing stable with the hope to
> get these backported to LTS kernels as allowed by the stable rules (see
> link below, but I hope I am doing this right).
>
> Link: https://elixir.bootlin.com/linux/v6.17.7/source/Documentation/proce=
ss/stable-kernel-rules.rst#L15
>
> Thanks,
> Miqu=C3=A8l
>
> ---
> Miquel Raynal (6):
>       mtd: spi-nor: winbond: Add support for W25Q01NWxxIQ chips
>       mtd: spi-nor: winbond: Add support for W25Q01NWxxIM chips
>       mtd: spi-nor: winbond: Add support for W25Q02NWxxIM chips
>       mtd: spi-nor: winbond: Add support for W25H512NWxxAM chips
>       mtd: spi-nor: winbond: Add support for W25H01NWxxAM chips
>       mtd: spi-nor: winbond: Add support for W25H02NWxxAM chips
>
>  drivers/mtd/spi-nor/winbond.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> ---
> base-commit: 479ba7fc704936b74a91ee352fe113d6391d562f
> change-id: 20251105-winbond-v6-18-rc1-spi-nor-7f78cb2785d6
>
> Best regards,

Applied to spi-nor/next. Thanks!

--=20
Regards,
Pratyush Yadav

