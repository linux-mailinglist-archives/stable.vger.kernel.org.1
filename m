Return-Path: <stable+bounces-16391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91A83FE0C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 07:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C0D2846D6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8B45958;
	Mon, 29 Jan 2024 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjZddeXY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D364C604
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508899; cv=none; b=FRgEEuNtzif2TouiV6GUQajnJfDnzPngUMnCWB1eY1a/QhEgNJObymh/7TKveQ7ltre4N69bIk9KOBvHpYNBaP0/nfV2bwbTUVcomHa210wMgHgJfgjPuKJNk46D7AAlJWNpQfQoRXVksQIIFNkI5Q4ilqWzVMgZVVrjjNVEQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508899; c=relaxed/simple;
	bh=xX+LIGepxK6xSRcjOyfGak0oKlW1pOYiQt6yo1ldrZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+vxGuvSAH5zZETpobuZyAeeUqRBrefmE3khsmOXCjlHRXANUuOqykimBuxG7xGJr5qaduvZiYKTrHY7Fis+eWqjwxgCVeegX6jCHXId0GZUoJOqhiYMnV9RpUD4pTpz6u7mBx82ikmVn2c/gccGWfE8blTkl8DsTyoRMNS37xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjZddeXY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ff821b9acfso21155137b3.1
        for <stable@vger.kernel.org>; Sun, 28 Jan 2024 22:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706508897; x=1707113697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hkOiY/3QbBmTUNSReLGcCZn4qq02vBlEI21lRC3p+mY=;
        b=CjZddeXYHcSCDK5gCO9iwusFrnZFEGwRJECJbMWE2MO4GcKCQ9Tvi6L6LrhHG7uT2X
         Kk5NrIPzgd8KU6uO95bamijgI2vA5lY3fHR/FwLoCJ14MWkyqmoOavHFt4o+C2BzlIdA
         aju2LPWfg/sv/E7fz/dSWuITK/EVshCJOlCfbxQf+AXYqNJ6v78xpY8EN/E1ghq5axuG
         HwrNQDPDDFffuesegXyUrsW/opjsGt62HIArCuxUKS9TAwsHNccDRYK6OyFU/SL6EaFq
         NU3mTK+h096um8HuMvb96srRFLyTV1UN6xxmDNSgYuIpuL8f5Em1/2HT739rczQiuI0+
         i2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706508897; x=1707113697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkOiY/3QbBmTUNSReLGcCZn4qq02vBlEI21lRC3p+mY=;
        b=esUo7IKCbp9sjXmzNpUqlt/wx/vt6zRy7n50o5Q9lfDgkchwtL/9UvFEtNfBpv026o
         JsZi9jOtxnGHxWyT25lkH7xD9K44h9jBgHvI3oSWVM+ybRtPEFdncO2w6fAIw4ZYWhyV
         CXqBTexjHR8Mmy/JI4zxXYV+ZFXCkEUZ4eTIkRQvCrb8hjJ4Ck/qEMVUi/FtQpnnF/1K
         xux6o0RFAq7BCKuXbjQ1QVm5BXHnCs2wgBg/U21KKPuTDpQQQSfu++H/binKpiwiPH7G
         JDdLe6+CTS3obvbxcmyPFzzrdan4QksBqRHqowvhsx0c5CIXV6xGWwICEcZqr20CBcW5
         f+GA==
X-Gm-Message-State: AOJu0YxeQCgoMDJR8UZOxj724WMz8VwSObU0dF9XWzXt1MltB5wVsSft
	hVORLTFejo+0pVotRd1M91zHbEqCanUkSiywjUlL/SCm0Kc+ke+tRCyhclb3Q9l4xDlWCq0ohPI
	pKXLAoIfJ3xwIVGT9PBrHnGbYq39kburKto8X4A==
X-Google-Smtp-Source: AGHT+IE0zSc1ga+/W4EU57HXgykLfpOp6nMhtBnbS1XcrqmXd204LZENPPP6DEMgSAqZmpxzFoaqcCP12ezTOgybc20=
X-Received: by 2002:a81:441d:0:b0:602:9bdb:8fc1 with SMTP id
 r29-20020a81441d000000b006029bdb8fc1mr2721314ywa.97.1706508897116; Sun, 28
 Jan 2024 22:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054623.3169507-1-amit.pundir@linaro.org>
In-Reply-To: <20240129054623.3169507-1-amit.pundir@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 08:14:46 +0200
Message-ID: <CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com>
Subject: Re: [PATCH for-5.4.y] drm/msm/dsi: Enable runtime PM
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Stable <stable@vger.kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 07:46, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> [ Upstream commit 6ab502bc1cf3147ea1d8540d04b83a7a4cb6d1f1 ]
>
> Some devices power the DSI PHY/PLL through a power rail that we model
> as a GENPD. Enable runtime PM to make it suspendable.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Patchwork: https://patchwork.freedesktop.org/patch/543352/
> Link: https://lore.kernel.org/r/20230620-topic-dsiphy_rpm-v2-2-a11a751f34f0@linaro.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> Rebased to v5.4.y: s/devm_pm_runtime_enable/pm_runtime_enable

This leaks pm runtime enablement past the DSI PHY probe/remove cycle.
Either the devm_pm_runtime_enable() API should be included into the
backport, or ite emulation via devm_add_action_or_reset().

>
> Alternate solution maybe to revert the problematic commit 31b169a8bed7
> ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
> from v5.4.y which broke display on DB845c.
>
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 1582386fe162..30f07b8a5421 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -606,6 +606,8 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
>                         goto fail;
>         }
>
> +       pm_runtime_enable(&pdev->dev);
> +
>         /* PLL init will call into clk_register which requires
>          * register access, so we need to enable power and ahb clock.
>          */
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

