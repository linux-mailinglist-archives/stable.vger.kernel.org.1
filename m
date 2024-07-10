Return-Path: <stable+bounces-59019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B792D364
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53E11F23A96
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686A7193090;
	Wed, 10 Jul 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/YRcBEf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A781723
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619536; cv=none; b=hSVLgepKgjEGFZoaDJBir9Vsp+7wfXsyg1e5ew66458SRp4h6qTLQkaPukz8V5sUhhaAuGyU2zXFbeqv28SsBX9bw34jxwD6B9RwfrztaotUpgjlvu25m9KjAL8iAIXRZ7VPdqNvxOXCq+it/lFaJ386oec2dhFPIzMvOOam+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619536; c=relaxed/simple;
	bh=3WiWOBn7pHdmhx9iPoez08ScqRj7WvY9UsQuBoxjbvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEI2u6xky1sdeocnMBDchNxk9EMjEt/ZbDFm7rhvsStXu7/tb1AbNWnOZG140mXEVt6mVgHwC8/F7rpA34mvQyBJW2FVXa4v3TVL/9F/FM0GTA0gA6jU/9PxVc38i32Y3v6n8x32rWyAbtrcjKpj7x6qIkRsP7JkBJ4ash5P3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/YRcBEf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef5980a69so6665667276.3
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619532; x=1721224332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s6ihtFgMXol2238V4wCVG6CHvKqmNcnW+Q3HHUXDtbg=;
        b=I/YRcBEff5PrvIhr8gqO5kZjyjr1Cb4kNaAidhFvpiOXYlphQF2XBfcEnxEeEo2a2a
         fVPYFO9VaKoanXiEB8wFOSRK8lzhUFSXn1h/08HFQEULyVj7CVH2ZQfJbuT4RJ4kNleX
         Wuf6pV2vbCBd+OQFoVtY4TrCQ0e7q3l8+Bk1x9UA4KxuyOcRAsnO4h9KFiXrADD8s6Fl
         izhrQRn3XhMhCMscVDvootI8LWke5iGTYCOI543vCh9OTV+E0IbDS/Mcc0+zyb9F0xG7
         Rr7MkHzUiTr724g9b4O+tGn97C9QdqSitWoiV3TNVUNE5bBSO1vOkEel6BqrahftsjC6
         NquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619532; x=1721224332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6ihtFgMXol2238V4wCVG6CHvKqmNcnW+Q3HHUXDtbg=;
        b=J7/kH6zk+iUjuweiFecy08q8ZYD5PvFhF9laYl47pizRw13xTvBjkupCGuWZf0jxvW
         ZqUzyg1jN7jOvy4XR4yGCRWr8GPNao1bqXQhK/HmvCsu4o4BRABlVxoG29BHSw4m/jv6
         yK2izoP1ngmFcspDduEZWJgvY5RA8h+KLb51MQh3rEsBjj1xWAcz8Z9MnX6IHuut1KZ0
         2QkRCo9BIY8Usspo0ACf8XK0tXudnX/8kBH6RiANq3yaGZTL3P1FRnNapHKSnRE9qwl/
         uN2dhYaT7FOwIHZmeAidUgceydIjgLM+qM8O3TIOJRzmQUC3Xou8jsUDKNmLoOnqaT5Z
         Z7SA==
X-Forwarded-Encrypted: i=1; AJvYcCUVi9dMlRgvqYZFv1eC3eT1oGfyJLWqYAoDjgGyQTnvroaalnwaMi6sf2Rto9K0+N1uU6380t0Et6SIAZQ6JSfhXIeitEk4
X-Gm-Message-State: AOJu0YzxsaFfGyyiOfIgKkQefKKgNUCYmN4GLwScFr1VFr1mai6+OFno
	r0InLOdvyhDFQulO1gUwVjAglgrvzHHtbKV2LphIHkvLAT+cIaBPyUwbOZjb/7XrBEc1f4yAnAE
	NEx12D1/h4V9njZGzZdj4eFdktiV3rmsL/QlNFw==
X-Google-Smtp-Source: AGHT+IEgGhImB1CZ9V2zyPwOjbF7xu90LRXOFMyWlUsr33fZ9RPD7FcjB6nD790/e/8piCgrefZcj52pseUw7tQZ7qs=
X-Received: by 2002:a25:bc8a:0:b0:e03:4ddd:49f0 with SMTP id
 3f1490d57ef6-e041b22a2c7mr6248368276.57.1720619532289; Wed, 10 Jul 2024
 06:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7> <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
In-Reply-To: <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 10 Jul 2024 15:51:35 +0200
Message-ID: <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 07:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-07-24, 17:17, Viresh Kumar wrote:
> > What about this patch instead ?
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 5f4598246a87..2086292f8355 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1091,7 +1091,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> >               if (devs[index]) {
> >                       required_opp = opp ? opp->required_opps[index] : NULL;
> >
> > -                     ret = dev_pm_opp_set_opp(devs[index], required_opp);
> > +                     /* Set required OPPs forcefully */
> > +                     ret = dev_pm_opp_set_opp_forced(devs[index], required_opp, true);
>
> Maybe better to do just this instead:
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 5f4598246a87..9484acbeaa66 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1386,7 +1386,12 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
>                 return PTR_ERR(opp_table);
>         }
>
> -       ret = _set_opp(dev, opp_table, opp, NULL, false);
> +       /*
> +        * For a genpd's OPP table, we always want to set the OPP (and
> +        * performance level) and let the genpd core take care of aggregating
> +        * the votes. Set `forced` to true for a genpd here.
> +        */
> +       ret = _set_opp(dev, opp_table, opp, NULL, opp_table->is_genpd);
>         dev_pm_opp_put_opp_table(opp_table);

I think this should work, but in this case we seem to need a similar
thing for dev_pm_opp_set_rate().

Another option is to let _set_opp() check "opp_table->is_genpd" and
enforce the opp to be set in that case. Whatever you prefer, I can
re-spin the patch.

Kind regards
Uffe

