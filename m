Return-Path: <stable+bounces-181829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D13EBA67D1
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 06:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54AC3C071A
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 04:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF66288538;
	Sun, 28 Sep 2025 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwvKqMGT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D0269CE1
	for <stable@vger.kernel.org>; Sun, 28 Sep 2025 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034294; cv=none; b=cRVqVV0bpNMYAKeAh07WipCz6OkJDKTDUHVYbxjz6Jco41sd83VlUnkbC5vDhkpagRFDxhPEL+eOsGF4WYZENrPUfbsZZUXS1kWBWTjUslhd1CRpi7tw7OpaWlSqB/F7GikLku2C1DYW5g3Bl0xN/d8HKf4EH4eFzLoVavuXF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034294; c=relaxed/simple;
	bh=yPUCQARO/E1b/PpKhkuynrSeBmbzRpj/2AlmBYWvBEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ih7X7oSHZNWy2HJ+q5B1f3iWucgBJZr1lgfVco22nENirLZew1tQRpIA15ZdW5Q5HfIxaxBMFUR4O3lqdKrxTBKvcRaaU8Ug6SUx/Hi/rf4c1JEP5/mnsW8hy+3G+ZFPZYBxjrzOzLeQUatPLwQRiBoxuxXYBcvGZJgZiKlPXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwvKqMGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC1C116B1
	for <stable@vger.kernel.org>; Sun, 28 Sep 2025 04:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759034294;
	bh=yPUCQARO/E1b/PpKhkuynrSeBmbzRpj/2AlmBYWvBEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uwvKqMGTr7gvSwWcF7i0B3Gyiq5dOWXVEHss0z7q9tzNvJaiQxw4QAWxZhtYtQpr/
	 k3yBIbcuyc/zNYe83bgBx/qFKixs7X9raANbbB5WjgdKFSfYdlkOl9MnJIoWRjOfRA
	 FTluEPI3nC4nYQGhO6XW0O6S2pqAqcH4b0HdCXqS2LwmanyGYdQLcke7FpmQtxBsDE
	 r1qsBXPYBmCeY1TMREmAmoTc1nD8FbY7d5dzfrr7ZgM0TncP/A8+XzVhxuekf02VLl
	 FSqRi0y82hfn2SZ41dqt38VVwjVZlAYOS0sPjBiE3KuLsrJMLlGj6WDJh3RhW2AXTg
	 LNgaPLPVOd+LQ==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28832ad6f64so619095ad.1
        for <stable@vger.kernel.org>; Sat, 27 Sep 2025 21:38:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXN9iq18lQA1anb3mvLRLpRmp2koux9n1kk+i5lnW4BEvG4LY2TIjn+m9ngwu5mHPVNmdWIHew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdKYNqsv4wRSTwb+mYUdsEP2cNRXwQ6n25d0yOFnj6lYArqvz
	pKATc2OLArUZpkacM3FzoDg+wTqwNg40sg4tHUBWNiia+E3orCOqid9nVTrF7hvUuehI4wEFOew
	Qdr3xTnm+IyKDxxOrRbS2MCpq3zC77ZI=
X-Google-Smtp-Source: AGHT+IFovBFKctggukgqFj3XIJcZWk9fg1TefA/Wwh6SK14YTc4CRxw9XITK+mpUG2jv5RfWSvlF4YsBkFYpkeUNa/0=
X-Received: by 2002:a17:902:f64f:b0:273:7d52:e510 with SMTP id
 d9443c01a7336-27ed4ab37admr146753645ad.58.1759034293913; Sat, 27 Sep 2025
 21:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928035108.10432-1-make24@iscas.ac.cn>
In-Reply-To: <20250928035108.10432-1-make24@iscas.ac.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 28 Sep 2025 13:38:02 +0900
X-Gmail-Original-Message-ID: <CAJKOXPcNnzTw7_bE4J8G91n=+fz==xAg4D6GXzRqJKhZhpAw4g@mail.gmail.com>
X-Gm-Features: AS18NWD0KSDsFXZFUEVjn0bzNBGXma2W0otpCGVfLYk-XWgTFtTO54OEwfjhbIA
Message-ID: <CAJKOXPcNnzTw7_bE4J8G91n=+fz==xAg4D6GXzRqJKhZhpAw4g@mail.gmail.com>
Subject: Re: [PATCH] soc: samsung: exynos-pmu: fix reference leak in exynos_get_pmu_regmap_by_phandle()
To: Ma Ke <make24@iscas.ac.cn>
Cc: alim.akhtar@samsung.com, semen.protsenko@linaro.org, 
	peter.griffin@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Sept 2025 at 12:51, Ma Ke <make24@iscas.ac.cn> wrote:
>
> In exynos_get_pmu_regmap_by_phandle(), driver_find_device_by_of_node()
> utilizes driver_find_device_by_fwnode() which internally calls
> driver_find_device() to locate the matching device.
> driver_find_device() increments the reference count of the found
> device by calling get_device(), but exynos_get_pmu_regmap_by_phandle()
> fails to call put_device() to decrement the reference count before
> returning. This results in a reference count leak of the device each
> time exynos_get_pmu_regmap_by_phandle() is executed, which may prevent
> the device from being properly released and cause a memory leak.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index a77288f49d24..ed903a2dd416 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -302,6 +302,7 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
>  {
>         struct device_node *pmu_np;
>         struct device *dev;
> +       struct regmap *regmap;
>
>         if (propname)
>                 pmu_np = of_parse_phandle(np, propname, 0);
> @@ -325,7 +326,10 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
>         if (!dev)
>                 return ERR_PTR(-EPROBE_DEFER);
>
> -       return syscon_node_to_regmap(pmu_np);
> +       regmap = syscon_node_to_regmap(pmu_np);
> +       put_device(regmap);

Are you sure this code actually compiles?


> +
> +       return regmap;

So is regmap valid now, if you drop the reference? I think no. I also
think you should check the purpose of this function. I don't see a
leak here, not at callers place. Anyway build failures are my main
concern.

