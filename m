Return-Path: <stable+bounces-188350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B019BF6E87
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 415D7354C1A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34C12CDBE;
	Tue, 21 Oct 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7MiLYc9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8B33893E
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054894; cv=none; b=qezYuYBg+wQkRkzuHS4GAUC/Fbhn3gZXm9y6kapy5H0vN1KvK2hAWOq8e0AnH14BmktmQUVvK43p0xidmOxm9H08u/JT+drO6H1JRLA5c9ebDqkzNIlOKZuGq4ryEcwGTZATBORIN0MsXf9ZTVBEZvk2iXtaYAjh8L8+2EgsyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054894; c=relaxed/simple;
	bh=WjXVc6EHp/g4iSC0dgl+mBlijG+pJ2E1MMjbyg07e+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3A0E8cxYd7/1fu/FRrXR49/xXJ3i7/4V8QXuRqhlkarIZO91OLZbFuMujESeKqOaJEl9Egw7O9YwOzZA1EkCRpYRxcmOVoMWoCsD+n4cRmeURZemg8UGS1QnTvT7rUT1MKn+Q++0IIJAbww/KWQ55q29JsdlB5Gwp+BvABPyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7MiLYc9; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7815092cd22so74532697b3.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054892; x=1761659692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7l2S0fTu5SAF3VSsMCSsLrp+bmdGs9v0RGyTD+mw5o=;
        b=Z7MiLYc94MoWtpRRdN94cauHSrYJHA2B/Y6/IEgd5CgGX96YFHY3fVWOtro0a4Gaaa
         41wtWTBU/Aeo13JTK860LTl8Is3s5pnxRuIa5yayhMDPjkCjVD1UFfBo+pNaqQAx+Di7
         +zM1UpZBKht2heAxtX4OZ1oeIdb5SfzogJ0pfrbcwaz0thc4EOWL4K1OgpnajXudnKR9
         K0qVRXO3gytM2LZRHcib8v/LBLYc97EjKP/schY7KPeJ3AvK81cCBI1zccA7cceTIMal
         K+zRA1QAe7rCu1HNMXgi05P9J9exSmXwqQ7eMoVWBygUVXRVmwsmX0J+qkBDIhITDbTj
         3HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054892; x=1761659692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7l2S0fTu5SAF3VSsMCSsLrp+bmdGs9v0RGyTD+mw5o=;
        b=wn7XQ2ckcTROfmgYNKKHlCs+NA1hEH5XUR31AnWou80Lt8gCHg8n2j2gQZWq4JEhf7
         WhGY7v/FmMYI9tVyDjeLjuza4xmSggNPTi26kIhIb0Qe/NGvA0pQPCLeFplHS9ZtMTuF
         rMgHLWbHNY+HbPENiQBYbuAdI+AlHkSg/DuElOsP7+g8bdkvfYGtEhQghXgm2dKa4mZf
         vhtBQiNsRROBFS+vC+qqb7a+TRi6QtMNhy1BZv2ADdpvgkP9+m0CcNTEOnUMcPJq6uNs
         VbMS5pd7xq4Ivi2WIwSCUZnGC7Jg9Xfrz34A4fXKotP5fHUSiYllqOb+miajz3PypgVG
         eGhA==
X-Forwarded-Encrypted: i=1; AJvYcCXR1DLa61RZyxUdbKWifGH3P0SfpDavBXg1f+Oa7saF+a4ISTCPlzEhqb1a0YVVJMDW7xDXDxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqE0WDcZn53iYwpZfMU67PGr3faZ27PauJOqSye0ShfspJsl8U
	O8EkfGS84rtFG6fnQ8L7cci+E9z/YnLXk9gNm84h7NPceBOacRDmZOsiRKlqspoYoZst/Ezsszg
	RsCHqj5o3ffEItsd5X8cTUHbuxnfVPAOqqAImmDgTiw==
X-Gm-Gg: ASbGncu95rJ7dD7hW4kvVsctrioiNxqhbjPwfKTH58AKvX7LFHcG+rEGdHZoHAIpvKH
	sGmAA+oOXP2pI8+I9avKyNaj0eoJf7nNwSUwmcC2hbfLHgPj9N1NGgM256CJhlNLeeJPsDmhkMb
	7nqk0RS059XkCOs9VRmVFYXlL86ZmdJpg+2/xyFFcI5hO90Tb2c92SO2IHEVscV01F8jP5ehuVc
	Q7Y3rBNu+pWjgqTEumZXDO0IOIAVnk6WOY65llNo263k0q6JIDLVabo/Up5tONWV90ubIdE
X-Google-Smtp-Source: AGHT+IHBbKVNcuM7l9dFMzW3m4txAHgl/oBl0HllzJAJ6dzOGjsTsg6Juv5F+fWERMC7Ma504B1opcnGXEPDICN6WPQ=
X-Received: by 2002:a05:690e:134a:b0:63e:34ed:a131 with SMTP id
 956f58d0204a3-63e34eda971mr6291641d50.31.1761054891971; Tue, 21 Oct 2025
 06:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org> <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 15:54:16 +0200
X-Gm-Features: AS18NWDpF262ybo6_Emnnj0aCX8cQdB1lik5qoOWoSB0z0MgCBOGMTnmDv5nouE
Message-ID: <CAPDyKFpH2p=JhkuXOxL4V3QMH8GObh0qSphPCK=OM9cNe+QmJg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] pmdomain: samsung: plug potential memleak during probe
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> of_genpd_add_provider_simple() could fail, in which case this code
> leaks the domain name, pd->pd.name.
>
> Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
> simplify existing error handling.
>
> Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platfo=
rm driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
> mark as fix, as this isn't a pure simplification
> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 5d478bb37ad68afc7aed7c6ae19b5fefc94a9035..f53e1bd2479807988f969774b=
4b7b4c5739c1aba 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_=
match[] =3D {
>         { },
>  };
>
> -static const char *exynos_get_domain_name(struct device_node *node)
> +static const char *exynos_get_domain_name(struct device *dev,
> +                                         struct device_node *node)
>  {
>         const char *name;
>
>         if (of_property_read_string(node, "label", &name) < 0)
>                 name =3D kbasename(node->full_name);
> -       return kstrdup_const(name, GFP_KERNEL);
> +       return devm_kstrdup_const(dev, name, GFP_KERNEL);
>  }
>
>  static int exynos_pd_probe(struct platform_device *pdev)
> @@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *=
pdev)
>         if (!pd)
>                 return -ENOMEM;
>
> -       pd->pd.name =3D exynos_get_domain_name(np);
> +       pd->pd.name =3D exynos_get_domain_name(dev, np);
>         if (!pd->pd.name)
>                 return -ENOMEM;
>
>         pd->base =3D of_iomap(np, 0);
> -       if (!pd->base) {
> -               kfree_const(pd->pd.name);
> +       if (!pd->base)
>                 return -ENODEV;
> -       }
>
>         pd->pd.power_off =3D exynos_pd_power_off;
>         pd->pd.power_on =3D exynos_pd_power_on;
>
> --
> 2.51.0.788.g6d19910ace-goog
>

