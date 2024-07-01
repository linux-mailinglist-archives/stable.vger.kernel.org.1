Return-Path: <stable+bounces-56202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBD91D95C
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9790F1C21A7C
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E0770F1;
	Mon,  1 Jul 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lartWDZO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E62C144
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820147; cv=none; b=B+BmF66S+Nt+hx+yCzx4YuOocaDvX1OmlZPbW70CprDWuXf59+AbLnd1psUPzEnVQVupdm4L+fuGKXWMJ8nFaGz/BRZq/5k/smv9n3WA6pMoUfpY8a+m6YDfzZQoEmz9X70sTSkWkteWPERiUB2QwVFLOXaPhnNflZkvvK/DjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820147; c=relaxed/simple;
	bh=pJBkp03od0t5cPwYoB01Uwt+nGAhI3y9ejXauMhaoh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+qdACKvD5VIR3/1utubxjQ0LjYrMkH3AKjtcFOOJ/yEkdIWSM6UWq6mGNoax3NXgGeLQBRH6mtoopmf5/wAUlGZN+vbr3E37JQ83TCzSxhGjvvLm5L2mE+z0yWwl5RoWbwYRGCAsufDZkkm4yMB+2F5Idz0ccUf4PxsnIzf0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lartWDZO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso33439171fa.0
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 00:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719820144; x=1720424944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNKIJU8OGmFNb74tPuLhxgiIWEwrxic6628/n7QE6U4=;
        b=lartWDZOOdNXRCYuFkBcm77MsDfOuDkVjk36XVepYTnhSM03otlhvN6WnF53XUTjF9
         vEwimAsi4THfYlK2WeFLHaCaEWvYvJRqq8I8pBddy5I3Vh5vGRH0ebjxytmvTSQT64Ty
         bTzgKMgEJ4nzztQYo0dezc/jZLaQGqyA2J84BytiRujopY9b5q7n9zKAOu/70gCMJ3Qv
         qfGINxsg2zzX0DLsl+LNIxG9hKrtjfS6ji1YAV5rZpQzabjxkeXqFlHQahKvktjslcJK
         jyV5FRzWkPe1VW/EW7Bw5Rgp6w3YgeAGD0GXwV7uI0tC56qFGm4A3U5UdJ0yz16SQSxP
         Tapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719820144; x=1720424944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNKIJU8OGmFNb74tPuLhxgiIWEwrxic6628/n7QE6U4=;
        b=vJXAGtJeCfjEPSL4Qxzi6lQoB8jfPtPtChA7tShIlbReCJ1cTsFkcGnNRV2YufvSlZ
         ALuLTAXqSbOxNQW06ocqwY4FiHscS1R2u+REt+LDbQUzXCnZ1ULJfwfONc4pqH1PFvSM
         vILYC/AvrTASvcb5hkxAoE6076QMLnwTTKl+yljMGOqoekmhjNkww7sy1ru/ZPQ5Pprl
         BRbBWyTSf7UqsVGjq5V7rbf3Tcn1yiWuR5AXJOIaGRMuR/HQTln1nW8RrYDB9W8yD+W5
         C9HS/u5ObpRiMXZh5UYdqk9Cj/5M5nxHGZuT8Cu99oYQwWn5+BdY2HeA6Na++bfNbtgt
         P94A==
X-Forwarded-Encrypted: i=1; AJvYcCWa/zUDsf4N4YyRdvzAEcptHFyEPUXhqU44Dspns22913TrS3HO6Ud0EyOCIT47kSTlW6v1SzEN2GgO69ibKybtTd5J8pUk
X-Gm-Message-State: AOJu0Yz3MYU2AOaYzIx1cRP7HxXXEPWOCghJUXaqSlj7beuT9kWEDkP0
	ng3bUo+LxhnK9i9ztdr3GQq2eQvnlIiulWi3HeIIMVDav7xyOhJwc3rHWjshciwEf0M2sEkO9VO
	4GA0k4xF50t6nFL6iVpXhFlZ/4h9WmARxZMWC1w==
X-Google-Smtp-Source: AGHT+IFK1vPadWMCRRGMINnXSF7M/bNV+Fi2LkdhgFy33X86BsH0xVeVtU0MOvER0+70M2Fn7FrxIaFHaLQVd/PZlHU=
X-Received: by 2002:a05:651c:88a:b0:2ee:6cda:637b with SMTP id
 38308e7fff4ca-2ee6cda6515mr8715861fa.35.1719820144133; Mon, 01 Jul 2024
 00:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701014720.2547856-1-quic_yijiyang@quicinc.com>
In-Reply-To: <20240701014720.2547856-1-quic_yijiyang@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 1 Jul 2024 09:48:53 +0200
Message-ID: <CAMRc=MdU6wPR722q=Ev0NCz=icHvbb4JAuiF+PjDFNLDoWTbKw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-qcom-ethqos: fix error array size
To: YijieYang <quic_yijiyang@quicinc.com>
Cc: vkoul@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bartosz.golaszewski@linaro.org, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com, quic_tengfan@quicinc.com, quic_aiquny@quicinc.com, 
	quic_jiegan@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:48=E2=80=AFAM YijieYang <quic_yijiyang@quicinc.com=
> wrote:
>
> From: Yijie Yang <quic_yijiyang@quicinc.com>
>
> Correct member @num_por with size of right array @emac_v4_0_0_por for
> struct ethqos_emac_driver_data @emac_v4_0_0_data.
>
> Cc: stable@vger.kernel.org
> Fixes: 8c4d92e82d50 ("net: stmmac: dwmac-qcom-ethqos: add support for ema=
c4 on sa8775p platforms")
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 80eb72bc6311..e8a1701cdb7c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -272,7 +272,7 @@ static const struct ethqos_emac_por emac_v4_0_0_por[]=
 =3D {
>
>  static const struct ethqos_emac_driver_data emac_v4_0_0_data =3D {
>         .por =3D emac_v4_0_0_por,
> -       .num_por =3D ARRAY_SIZE(emac_v3_0_0_por),
> +       .num_por =3D ARRAY_SIZE(emac_v4_0_0_por),
>         .rgmii_config_loopback_en =3D false,
>         .has_emac_ge_3 =3D true,
>         .link_clk_name =3D "phyaux",
>
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> --
> 2.34.1
>
>

Oops, that's on me. Thanks for catching it.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

