Return-Path: <stable+bounces-199491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC90CA080B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB423260C86
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4632E69E;
	Wed,  3 Dec 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSrWNmta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C731A077
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779973; cv=none; b=sZkvpUsLbQCklpzlSW4nm65jJ0Vr78BLcJNjHiu/TAV0+SOsDP3t9J+1L9U29VZ1yhWiHQ7lfd17WTVuCU7AFKiek7yhKdQ3hE+Fz1KxJrEa0XD3+rWYQAwiDP3Bxo9leysQVrPx1LagqWjZyvP82hTka9ZL9aqZwAYX58H2Sy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779973; c=relaxed/simple;
	bh=nGI+90G+qxZwST01C3YjM07YV9L/HeblzgbrJvTyowU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuyzUMBrzHlkA0DvDCfnI2NjOxeH72NOhobabnj4VI1lLh073qiw/nK4klSwujtkTDtjnSfADvbzfYnleLD0aFF1gGptYbVDp7OMxL4wwPNeT6Y+3BmaDP00VuIWRBu0QfxTRlnr6+OO3aEll+6ZJyQdYJyQEzIUhxDYgFglkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSrWNmta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46766C16AAE
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764779973;
	bh=nGI+90G+qxZwST01C3YjM07YV9L/HeblzgbrJvTyowU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=fSrWNmta3l0wExlZVRKdQ9KfqWL60/01T5rx8+OoQW6BBfncYA/gDaYIPe4fO2K5p
	 iucicAETFNAHvjubHZH6mMIrrtBI3yG12q3TEz4NbPQCVgb9NLI8g2vr5zCQ4V6i3T
	 pI1UKYcdO28XdkUk1edpeBJF7jSFKW6SNiM5M/qemdciQJVV1nB+a8Y4JfbZ3Q+bnq
	 uCV1kSoOlnnOuU5sDyMqxX5Yq21zgbyFktY+8AwIqWclnlqYzzSCVG8HnLavKaLazF
	 Ql/bIB6pGZft8Zl7OxaZKSjCpR92O0jIbCx6bUNHLrfFqZ+8PrZWAnBAS66u6B/nmo
	 8OSsA2fNpUpEA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37b999d0c81so57796531fa.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 08:39:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxrbNQxS/sD0nWE+WtfBq0Xi+mvbgmf0YlHbzRYqarighEDF7D+
	RpOT9t58Ev0KaktaoJkHJmgushp5iRuSg7NmCMhGLI8ioSNrQFJEWZ+ozruk4Y1W0UsJk9kwlm/
	7FubA/2clyGH1PVvsW98s54v3anoEV/I=
X-Google-Smtp-Source: AGHT+IGm0vXbsh0XtG/ynlgazAvS1H3eYlsF8Yd6HuqsVLDuqeCsn1/RkJZdvB9GVzU2RpR3/w9+a/1QbTwcQAS8Wik=
X-Received: by 2002:a05:651c:23c3:20b0:375:ffc2:1b40 with SMTP id
 38308e7fff4ca-37e6391d3a8mr8131711fa.35.1764779971589; Wed, 03 Dec 2025
 08:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152440.645416925@linuxfoundation.org> <20251203152451.071218150@linuxfoundation.org>
In-Reply-To: <20251203152451.071218150@linuxfoundation.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 4 Dec 2025 00:39:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v66AhhbEdXJVOZbUiUa2yJ-XAroSvHi3Xqyot6dUkfj7iQ@mail.gmail.com>
X-Gm-Features: AWmQ_blg5NpXOz2PHei0zlzpGhp0VIiFBZDw-a0IBHQLiuOvXj79j_NVDBClfdw
Message-ID: <CAGb2v66AhhbEdXJVOZbUiUa2yJ-XAroSvHi3Xqyot6dUkfj7iQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 283/568] clk: sunxi-ng: sun6i-rtc: Add A523 specifics
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> [ Upstream commit 7aa8781f379c32c31bd78f1408a31765b2297c43 ]
>
> The A523's RTC block is backward compatible with the R329's, but it also
> has a calibration function for its internal oscillator, which would
> allow it to provide a clock rate closer to the desired 32.768 KHz. This
> is useful on the Radxa Cubie A5E, which does not have an external 32.768
> KHz crystal.
>
> Add new compatible-specific data for it.

Support for the A523 SoC was added in v6.16. I don't think we need to
backport A523 specific stuff any further back.


ChenYu


> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Link: https://patch.msgid.link/20250909170947.2221611-1-wens@kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/=
ccu-sun6i-rtc.c
> index d65398497d5f6..e42348bda20f8 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -323,6 +323,13 @@ static const struct sun6i_rtc_match_data sun50i_r329=
_rtc_ccu_data =3D {
>         .osc32k_fanout_nparents =3D ARRAY_SIZE(sun50i_r329_osc32k_fanout_=
parents),
>  };
>
> +static const struct sun6i_rtc_match_data sun55i_a523_rtc_ccu_data =3D {
> +       .have_ext_osc32k        =3D true,
> +       .have_iosc_calibration  =3D true,
> +       .osc32k_fanout_parents  =3D sun50i_r329_osc32k_fanout_parents,
> +       .osc32k_fanout_nparents =3D ARRAY_SIZE(sun50i_r329_osc32k_fanout_=
parents),
> +};
> +
>  static const struct of_device_id sun6i_rtc_ccu_match[] =3D {
>         {
>                 .compatible     =3D "allwinner,sun50i-h616-rtc",
> @@ -332,6 +339,10 @@ static const struct of_device_id sun6i_rtc_ccu_match=
[] =3D {
>                 .compatible     =3D "allwinner,sun50i-r329-rtc",
>                 .data           =3D &sun50i_r329_rtc_ccu_data,
>         },
> +       {
> +               .compatible     =3D "allwinner,sun55i-a523-rtc",
> +               .data           =3D &sun55i_a523_rtc_ccu_data,
> +       },
>         {},
>  };
>
> --
> 2.51.0
>
>
>

