Return-Path: <stable+bounces-118379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3FA3D190
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA3517AB2E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCD71E3DCF;
	Thu, 20 Feb 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fybWmLum"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191D1ADC6F;
	Thu, 20 Feb 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034358; cv=none; b=bY90uQuuSiuFnuSrcPaGkbYHl5yb3BFAGQtteDPHHrbcDzvaWABmMWE0SBh62HrYhO6xkE5KUr9LNUIcefFIkaWq6es3i/i1OEFrzzWE9vTK3MpOx5sU3wtI+9MiNL595Cdo4I+3WNWV4/d6vMm/P6gWb+gH4KMlGcGBY+JINyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034358; c=relaxed/simple;
	bh=CLw6zBsSsTnmlCQj0sWMWplnJ0ZrcCL2Ml/zvFulIgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMLTcu0HcSGEx0ZXzejXCwYncEZZA0mqDUni8iW7lrvKSfha1j1is4rP/XeG4YEf21GeqSKfPslFwvHLjwrhyuqME8q9DTBoZTpPCfM0i9or2EPsQjeGXL0bQFx77d8G4ctTGY01q092z2mMqKXpV5RCuLdt1l9rOhcfomKTarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fybWmLum; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb7f539c35so130746466b.1;
        Wed, 19 Feb 2025 22:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740034354; x=1740639154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZwJmuqge8q05o7ZYGvV/C+Qh4HzV3tp+xzKODDMrq4=;
        b=fybWmLumfe9e8bF8wobIyznZA/Y1i/P4N/C2yH1mUvDp6e8YI+yfGd3UGxwZdcTMZb
         +6wX5blMbDCS+JxYvxurL2jtbJc2mkkJg+N83sDYE56/RUXsUtijzuMEpyZwGou2p+en
         4waXAB3i34aY6aHOg4ySv5IUPW8MUi7JnCwQiHXKaxPUl4XYiUL63MoVu9tw6b2DV2hi
         EBSjEKbAnDucKpAAv+SybktN5fzEjL9t1i+uUJn7fyy1vDrVi6o3tMfzMakht6+EXk35
         lU5I8CExh8vXEl7d1r9KuR/Tl//u8zz3LwLXskANXbvvHABEFc0Xc00WNlV54z2wsszC
         WWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740034354; x=1740639154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZwJmuqge8q05o7ZYGvV/C+Qh4HzV3tp+xzKODDMrq4=;
        b=AM9+fBjYR139aNzHbyu2ihHC0t1a8bPcrq7CGvR9Kz8xpbd/sG2xdmWk3PuK1KjQPc
         HqRbhitigSpQQY7M7q9sP2X3ZlLlbeim6Yaza8yZptz3zk0o8Mx5QyV+qLuU6m2K+JS4
         XOn7+MOCNoGjmYh0+3XdP7LJ67Gibg4epV+psJ4aJB+sH5gL2rdHYrblb7PIAFAUrzLG
         fM3Jgu6WQPOihhK25CLwoYrvtuYMeV7sIn+7zzqE00kxzO+BdGBDKoQAX45qiPzHVDEO
         xhCiETwh+czTnowbNySb5pfjHf6qRa7K1H44DXRJDDhR18Qz635rivuwSchblb/DfW3w
         fK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7fGWleCDaMl/TkWjElFtZfvWJ/UaVX7B/NZ0+LAtKPbaftS1Mx7qPJeflqCMEy1+gJ61DWW2VZd3C/WA=@vger.kernel.org, AJvYcCXLkOioxAHoUsKN5ZpjjjazY2+pUo0LlVlK7+npOYB64jJ3qGcwVDqvyny/j7sZmukFr8KttOoo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kIikn+jeaA7hKvR7O7i57SWOAUoYv4OSrxTSETxOCeov+G9S
	tnPbUxKrTp6cD8RFr+t4J5de12JCTBN6r0LcIEtBC1y6hTgbH8HG1cfcv3/eZt73Y8Mei5eFoWk
	1VK/ZGaL5mWmLqwzZpqc3S4eR+pY=
X-Gm-Gg: ASbGncuQvlT67c1GfYVXm3IRie/sUri5w3lvSbOlFpVz0o61n/ceCdKxIPZ8/JCidG+
	e14QoLUghDsAoqLs7HciiLA+mAwQI7GNj2NGwPNrhnTmYFA7dU2hRTM+a6kj34xQ4CBavly+DQA
	==
X-Google-Smtp-Source: AGHT+IE9NhBPo/KgScXg5dw2GxEMSOt/KhtyUuf5u5RRA747mzK+lscMf3gNz3OsIbmq9pavaAsFw7HsqmLj/dNMSyY=
X-Received: by 2002:a17:907:9907:b0:abb:b0c0:5b6b with SMTP id
 a640c23a62f3a-abbb0c05e77mr1094505466b.7.1740034354063; Wed, 19 Feb 2025
 22:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219032251.2592699-1-haoxiang_li2024@163.com>
In-Reply-To: <20250219032251.2592699-1-haoxiang_li2024@163.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 20 Feb 2025 14:52:21 +0800
X-Gm-Features: AWEUYZnMB3F8S_mLX4zU1TuBvbYqy__x9km_wAN_Md86gzNwXF_7GfgipeOyrLg
Message-ID: <CAMpQs4K5Xw4_M1TXTkc_zGaeuD2K_R6pO1PKyhOOJG_XvQuF9A@mail.gmail.com>
Subject: Re: [PATCH] drivers: loongson: Add check for devm_kstrdup()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: zhuyinbo@loongson.cn, arnd@arndb.de, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haoxiang:

Please rewrite the patch title as "soc: loongson: loongson2_guts: Add
check for devm_kstrdup()",  and cc soc@kernel.org, because that is the
most appropriate list for this patch.

On Wed, Feb 19, 2025 at 11:23=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.c=
om> wrote:
>
> Add check for the return value of devm_kstrdup() in
> loongson2_guts_probe() to catch potential exception.
>
> Fixes: b82621ac8450 ("soc: loongson: add GUTS driver for loongson-2 platf=
orms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/soc/loongson/loongson2_guts.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson=
/loongson2_guts.c
> index ae42e3a9127f..26212cfcf6b0 100644
> --- a/drivers/soc/loongson/loongson2_guts.c
> +++ b/drivers/soc/loongson/loongson2_guts.c
> @@ -117,6 +117,8 @@ static int loongson2_guts_probe(struct platform_devic=
e *pdev)
>         if (machine)
>                 soc_dev_attr.machine =3D devm_kstrdup(dev, machine, GFP_K=
ERNEL);
>
> +       if (!soc_dev_attr.machine)
> +               return -ENOMEM;

I think this exception check should follow directly after devm_kstrdup().
Otherwise the whole driver exits here when the =E2=80=9Cmachine" is empty,
which is not what we expect.

You can refer to:
https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/soc/fsl/guts.c#L2=
24

>         svr =3D loongson2_guts_get_svr();
>         soc_die =3D loongson2_soc_die_match(svr, loongson2_soc_die);
>         if (soc_die) {
> --
> 2.25.1
>
>
--
Thanks.
Binbin

