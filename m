Return-Path: <stable+bounces-83398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D5499950A
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 00:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82CE1F23607
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85B1C6888;
	Thu, 10 Oct 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZPrhQC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D05148301;
	Thu, 10 Oct 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598908; cv=none; b=VRpXtD7w+65hZkQb65abis5Bk9HvhHiOD4+Ben9xQuAe16HyluM7qvOEIyHzSdE9xEPJyZ3wa5zG86prIqi2EV3Ri5lob7skcluVQEr8pr9LcA/7ACsas/BKwh8UwZKGAUatrAAv19VOj5N3FQFmx9rv8rJMhPlCUxU2vxOX1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598908; c=relaxed/simple;
	bh=oBDNpYeXUb77o/FNxNq8pnU5gAz9EMoLLWFXUk5bfy0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ReFPVEWkIFlbnyS3oxpc/taRvuGTgseqRwNsU5qh3v0GtuQPEfhKbF1qIeGcC4F2Jw4l4e0aByZcwmtHrgF4A3NMt2XGCOPRCul78hpZJD0rh4jaLdPq/DBnBkqyyHyTEF/Q+6SPPoitzAxeXCdMPBzOSanO6i5yr8F0TmxYrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZPrhQC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E95AC4CEC5;
	Thu, 10 Oct 2024 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728598907;
	bh=oBDNpYeXUb77o/FNxNq8pnU5gAz9EMoLLWFXUk5bfy0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GZPrhQC28VWzXwSBj/v7nkqdYJ/5RaOhwlNuIdUPmqtovSNJAzaDOg4FHyMBwEYpV
	 WK+v0bYwfJD0FELKbJy37A7rCThPC1Yn2JbFxSZowJuAdk5Hc/dBhU2YxmpYQJ9wXy
	 14dA0iJmVopOUba810unxjINPWkgw6Dc8a6UoIG2tlhdgYRiq9v+ORjYyNKG3j9crE
	 3iVZzWFtpFG+nnf2yN04LieDzxJK+PwSxLWDcMrPiESNs4gEizDThm0X5AILaYGaOP
	 TbqnuDdxXf/ea1xK9shNT+bYmPppk11f3vecIFFY5u6ajs7RTeGaPhTKoehceujFjK
	 8oTtXpIj89SZg==
Message-ID: <eeb311ff8cbfff0166286d1363c8b7d5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240910130640.20631-1-abelova@astralinux.ru>
References: <20240910130640.20631-1-abelova@astralinux.ru>
Subject: Re: [PATCH] clk: actions: prevent overflow in owl_pll_recalc_rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: Anastasia Belova <abelova@astralinux.ru>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
To: Anastasia Belova <abelova@astralinux.ru>, Michael Turquette <mturquette@baylibre.com>
Date: Thu, 10 Oct 2024 15:21:45 -0700
User-Agent: alot/0.10

Quoting Anastasia Belova (2024-09-10 06:06:40)
> In case of OWL S900 SoC clock driver there are cases
> where bfreq =3D 24000000, shift =3D 0. If value read from
> CMU_COREPLL or CMU_DDRPLL to val is big enough, an
> overflow may occur.
>=20
> Add explicit casting to prevent it.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 2792c37e94c8 ("clk: actions: Add pll clock support")
> Cc: <stable@vger.kernel.org>=20

Seems like we don't need these tags because it can't overflow.

> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/clk/actions/owl-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
> index 155f313986b4..fa17567665ec 100644
> --- a/drivers/clk/actions/owl-pll.c
> +++ b/drivers/clk/actions/owl-pll.c
> @@ -104,7 +104,7 @@ static unsigned long owl_pll_recalc_rate(struct clk_h=
w *hw,
>         val =3D val >> pll_hw->shift;
>         val &=3D mul_mask(pll_hw);
> =20
> -       return pll_hw->bfreq * val;
> +       return (unsigned long)pll_hw->bfreq * val;

I'm lost. Did you intend to cast this to a u64?

