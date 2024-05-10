Return-Path: <stable+bounces-43528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23ED8C2106
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E9A281A02
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4D161B6A;
	Fri, 10 May 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfo5KVau"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96C161337
	for <stable@vger.kernel.org>; Fri, 10 May 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333725; cv=none; b=DyhenB/Ja57UKy8h2sK4aXZhpLbU0dE3BNcgytHens3yoZWHlSSmTlibLQFUnb2M+n4Wp8zatkE7FRzNzzH/MvjszYLJDFAvHewd4IkU1gWp4faFLxy+ChJZdYqP81dwv/DrUne+P+q5PPxDbFlDbqw4jgtDE4/4+vdz30zrZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333725; c=relaxed/simple;
	bh=74mWvHLl9kkJWCjJ9c/58+OLihHsC5x2Bv4lj2v1YJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWopl1xVo+uDEBmTD7dUoXjHqVPfGBrNiN8g+dJZxKwx4MAGBlSuV0kIBOfKh//tGy1QSU8y45gyuVqFjHYcVtQZ/jlt+b9Qbq7G890RtIqYcOdjTSL6z1dl9XhnsD0lxW53xyOyfilT8QOZK1XmL+E7cwiGcwF8ia4yg8E0HV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfo5KVau; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1541194276.0
        for <stable@vger.kernel.org>; Fri, 10 May 2024 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715333722; x=1715938522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddAlHrV+azsymE+SBA7AG/w8GBAmFQuP9eNGcQBlcU4=;
        b=dfo5KVaubq5BNK8KxOFO6OpXSqVEzSSNKPTtJJv3fFzCERqmY76eqwz9L3BfWmebDr
         I9iy13RfJq8ACb+U2WT6fN9L4cyoBKYeRZnjZlYwlYWNlYWt0oDFbedAbT0xu/Tbvh78
         lBuIEgnodFKPijQ+YjNWqFAOeB69WeV8hgy/2BE8JDqDNkkUaX+NDsu5F/mkdcsotnKb
         3izG1hFNFy/e0HtBgMYX+leWCAtNzXyqGDUXXzimBQBvzXXhbyD7TqCtCpApXqdyyp9n
         IWFTu936lXj7BHTlQZBCIvhemrRyNEonNoidkA0YBsOijVetEOoa0cjRleqvRsLeXb35
         EM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715333722; x=1715938522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddAlHrV+azsymE+SBA7AG/w8GBAmFQuP9eNGcQBlcU4=;
        b=mOCVXxbRgaOk+QZQXArqDe+tWcckliOsr/DIWL+BNpUWncnNKA9vAdFKBtcXWTh4Gv
         1xXiQBL9GCpW/v5x9RVVlwN9EgEdMs/eHqU5jhUO7kiZn7Q3j+c1Lo2OS81Gizxz9unt
         GrrSAAFX/0GQofeXhrsZH6SvFtJnAZTjfVGKH1K7NOEqzY4vpG9MomgK+v/WoKRc+t4g
         oHX6DEggQ36bcKBy31cvJie1F4B55sDB5hnvtT5PMYy+ANrcZ3ZEzqB5q9ojs0ShJobh
         LMZq541X8aDgbqHT+6JMPdsddwC+VbkhUxM0JL5RhwhD8qSAEyW6OWN+YbS0Kmrh8y58
         RZdg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9LBjvStu+QN238h2Ct3J2LXXAf0oOgDZjLNbUqI9lLRAGvf8K1FfkkZh5eWSUbFJM8+WBCOdEPcc56kEo9NR14tO/6VA
X-Gm-Message-State: AOJu0YzLvqftOjKoF9S4XtA0jOZvzDsd60Z9Lf7ojWZK+B2x6DhdeMlv
	rmKIi13PgUgUSoXjkR+daTyv/6WEK55stQ8ZCc6ssxkYSb+Zp3Qdajczf0/8SRm6QU03HaJ5C4v
	uYHeNAOqFyM0CNyMdSLauPd/6JiqL4NqqcHsuUQ==
X-Google-Smtp-Source: AGHT+IHe8KfUCxU0IUa3DtzKN6/EJhPBEHnlzpdRmt0ugkIOFNcugGXnt2P8F6W7CAtLpVfZDsqHHaqcjOrR3KSrOQ0=
X-Received: by 2002:a5b:2d1:0:b0:de5:bc2e:467e with SMTP id
 3f1490d57ef6-debcfb4e0b0mr3992499276.3.1715333722592; Fri, 10 May 2024
 02:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418155151.355133-1-ivitro@gmail.com>
In-Reply-To: <20240418155151.355133-1-ivitro@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 May 2024 11:34:46 +0200
Message-ID: <CAPDyKFr9Vzgm2C6Z57Bg5mUQxg5LK6goN2og3+RC3BkTZjiqJw@mail.gmail.com>
Subject: Re: [PATCH v1] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
To: Vitor Soares <ivitro@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 17:52, Vitor Soares <ivitro@gmail.com> wrote:
>
> From: Vitor Soares <vitor.soares@toradex.com>
>
> During the probe, the genpd power_dev is added to the dpm_list after
> blk_ctrl due to its parent/child relationship. Making the blk_ctrl
> suspend after and resume before the genpd power_dev.
>
> As a consequence, the system hangs when resuming the VPU due to the
> power domain dependency.
>
> To ensure the proper suspend/resume order, add a device link betweem
> blk_ctrl and genpd power_dev. It guarantees genpd power_dev is suspended
> after and resumed before blk-ctrl.

Before discussing $subject patch, would you mind explaining to me why
imx8m-blk-ctrl needs to use the ->suspend() callback at all?

Looking closer at that code (imx8m_blk_ctrl_suspend()), it calls
pm_runtime_get_sync() for devices to power on "everything". Why isn't
that managed by the consumer drivers (on a case by case basis) that
are managing the devices that are attached to the genpds instead?

Kind regards
Uffe

>
> Cc: <stable@vger.kernel.org>
> Closes: https://lore.kernel.org/all/fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com/
> Link: https://lore.kernel.org/all/20240409085802.290439-1-ivitro@gmail.com/
> Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>
> This is a new patch, but is a follow-up of:
> https://lore.kernel.org/all/20240409085802.290439-1-ivitro@gmail.com/
>
> As suggested by Lucas, we are addressing this PM issue in the imx8m-blk-ctrl
> driver instead of in the imx8mm.dtsi.
>
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index ca942d7929c2..cd0d2296080d 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -283,6 +283,20 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>                         goto cleanup_pds;
>                 }
>
> +               /*
> +                * Enforce suspend/resume ordering by making genpd power_dev a
> +                * provider of blk-ctrl. Genpd power_dev is suspended after and
> +                * resumed before blk-ctrl.
> +                */
> +               if (!device_link_add(dev, domain->power_dev, DL_FLAG_STATELESS)) {
> +                       ret = -EINVAL;
> +                       dev_err_probe(dev, ret,
> +                                     "failed to link to %s\n", data->name);
> +                       pm_genpd_remove(&domain->genpd);
> +                       dev_pm_domain_detach(domain->power_dev, true);
> +                       goto cleanup_pds;
> +               }
> +
>                 /*
>                  * We use runtime PM to trigger power on/off of the upstream GPC
>                  * domain, as a strict hierarchical parent/child power domain
> @@ -324,6 +338,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>         of_genpd_del_provider(dev->of_node);
>  cleanup_pds:
>         for (i--; i >= 0; i--) {
> +               device_link_remove(dev, bc->domains[i].power_dev);
>                 pm_genpd_remove(&bc->domains[i].genpd);
>                 dev_pm_domain_detach(bc->domains[i].power_dev, true);
>         }
> @@ -343,6 +358,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
>         for (i = 0; bc->onecell_data.num_domains; i++) {
>                 struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
>
> +               device_link_remove(&pdev->dev, domain->power_dev);
>                 pm_genpd_remove(&domain->genpd);
>                 dev_pm_domain_detach(domain->power_dev, true);
>         }
> --
> 2.34.1
>

