Return-Path: <stable+bounces-100169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCC9E96CA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474F416A16C
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8E233136;
	Mon,  9 Dec 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+U0MZlX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4923312B;
	Mon,  9 Dec 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750674; cv=none; b=sxhhz0Yl6VR/VgXZoexFh67cUT2wCxWxp71/z9Tw68WaWyP3xMujEAHPYRh+yAWockEmL7FHPscz0dx6OfglE7c2+gUsgOhXw/NRbyjqmHwPcJMCyLyF2P+LQm5PW3ZO8zSgmjlmPuFiwvDzGKyiZUth7obXKXyvV/Z6MHjcwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750674; c=relaxed/simple;
	bh=tIjsY5za2Jlf4kKilwQOlSjddec7kKrcZ9gWvcVoaEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzwtOvj415vHlVtYpD2r2swAv5/88A5ELeD4HuMhq0EGzwHXq1xvastJrt1eibppqullsyPKy1ZTixOUwLgXi7GjDyJruHwFCBxvIPpASZa3aZFDRbD4BinexL08aXQOG+cFlu/e13vU57yMdQ5OOVDjQYF8L7RU0PJnIdN6/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+U0MZlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF8C4CEDD;
	Mon,  9 Dec 2024 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733750673;
	bh=tIjsY5za2Jlf4kKilwQOlSjddec7kKrcZ9gWvcVoaEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y+U0MZlXnMPJ/YkjwHlY8vc4pCW+UstnKf1T26MnsVz0SwoLHWss8OHorOpTK9ndh
	 sFTRXbPrsapqShctjYGFLs0Fk3FB4Yo8mv1wPSyO6G0DDtJow8W/hUWbL+y2i1aqZt
	 40D1aZ3BWpzQethUQzMhP+NirsYiUWnPQiLGlz/uRT3qh9GG9rco6Z+n3GGmkgvL2S
	 qBx8FKHBP84umzobVfcWaZ/GLAHnWAzOYDT/bmsRHSQ4TWQ0KPRSc42ZFPCvHB68rm
	 tEtMTaJofJTtm7A3Ge6a1xdnAhqFmJ8qOwyJwSpHHAnML25PPbByxC526li4QAovmE
	 DKvLpTMZyMG4A==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e388503c0d7so3607716276.0;
        Mon, 09 Dec 2024 05:24:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqcWLwC2jg01Ab9xjLqGENJkq2853mPH1EOC7BTSaIB0DZomF2t7MV6ZlPgBw6IZLBl8KAFnUp@vger.kernel.org, AJvYcCX2xN3X47vN/S4r/wBBEnKTfK1w8qwO0IYNCETSXQIOJ+w1lH8vmvfgeNASPzPJXqYGFdVlPU3ihVBQezvN@vger.kernel.org, AJvYcCX5xqKYmQk6InUzkiiNmZSO/R0ml8K7Fb1Gr+ddkTpO+Yx/2EPGUkAmaU87mVaC0hd4u34OdjVf8gLE@vger.kernel.org
X-Gm-Message-State: AOJu0YxrycJI6Iq4Wrqj8M1CuuYAwjZkgx1KsjNOEcCdal7rf/tIXnaz
	q0tS1JGX3PlzneYaif8SZDyj1IDl87JqtSOxXOJwmU+OAI3UUPP8xli4ZDphGkRTApH93S1FzN9
	UA/Y7MNmqQVxQisA0QbNa0aqqIQ==
X-Google-Smtp-Source: AGHT+IHTtAaLacoSDyYlgvTFYfHtgFO7Eq42ii8VWVKdodPb9rW9jMC4W4JhRjkH55B8Szv983O1c0YYGpvO0FkkI9Y=
X-Received: by 2002:a05:6902:cc4:b0:e39:84da:95f1 with SMTP id
 3f1490d57ef6-e3a0b4d114fmr11040045276.48.1733750672812; Mon, 09 Dec 2024
 05:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com> <20241206-of_core_fix-v1-1-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-1-dc28ed56bec3@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 07:24:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1gsVeCG29RzWMFycbASAGAsds34Utuoq+Egw3-Afi7g@mail.gmail.com>
Message-ID: <CAL_JsqK1gsVeCG29RzWMFycbASAGAsds34Utuoq+Egw3-Afi7g@mail.gmail.com>
Subject: Re: [PATCH 01/10] of: Fix alias name length calculating error in API of_find_node_opts_by_path()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Leif Lindholm <leif.lindholm@linaro.org>, 
	Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:53=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> Alias name length calculated by of_find_node_opts_by_path() is wrong as
> explained below:
>
> Take "alias/serial@llc500:115200n8" as its @patch argument for an example
>       ^    ^             ^
>       0    5             19
>
> The right length of alias 'alias' is 5, but the API results in 19 which i=
s
> obvious wrong.
>
> The wrong length will cause finding device node failure for such paths.
> Fix by using index of either '/' or ':' as the length who comes earlier.

Can you add a test case in the unittest for this.

>
> Fixes: 106937e8ccdc ("of: fix handling of '/' in options for of_find_node=
_by_path()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 7dc394255a0a14cd1aed02ec79c2f787a222b44c..9a9313183d1f1b61918fe7e6f=
a80c2726b099a1c 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -893,10 +893,10 @@ struct device_node *of_find_node_opts_by_path(const=
 char *path, const char **opt
>         /* The path could begin with an alias */
>         if (*path !=3D '/') {
>                 int len;
> -               const char *p =3D separator;
> +               const char *p =3D strchrnul(path, '/');
>
> -               if (!p)
> -                       p =3D strchrnul(path, '/');
> +               if (separator && separator < p)
> +                       p =3D separator;
>                 len =3D p - path;
>
>                 /* of_aliases must not be NULL */
>
> --
> 2.34.1
>

