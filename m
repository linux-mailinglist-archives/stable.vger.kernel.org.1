Return-Path: <stable+bounces-16407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359558402DE
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6755D1C21E4C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6C56B98;
	Mon, 29 Jan 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqUDzXV0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F507537E2
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524539; cv=none; b=RVFDfZosoB07IJ0xHU77bu9ScGEKtN341e4sOBePrlLFJr2CSEesTlIBzvw7z7MgtN9MB/XqsVKwfWwOUbwSTTkiN4Gy5Zl3oaKC8+eq5xNvVFn90XuOSM7Hd+zvKwqC6pHlmRF9n62hamWufyDRdkiXDoj4gLXeHyb81q9YS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524539; c=relaxed/simple;
	bh=XE13giKjkVnV82iRJVMO8cptj9Q9FRVBnELsiXjVfQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKw/o6TLNwsRh5meey7pbEuUBCq7IFVkEPI3AV0Y25+dIJaoAd2vzv9DF/rhck0zAWqx8GfuyOlzthgJHVzWpogudoBIM6tDJl3XeVSnskxs2zpSnEJXHhsWIWe1tpLkZgE8BbQtFa3+65wb6SPdbDo8duWxtS+NQTQlF7XJLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqUDzXV0; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7ce55932330so715090241.0
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524536; x=1707129336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7s/qvc6Ah1UcJ/8IgXhI7ljA3zFpQr6+tidoPE1SgI=;
        b=kqUDzXV0ASSjkNVJeVipBQE0XCU+HoF3BWZ1bQ1VK3+eUPbN8aiBaiF/2p2HPtahyy
         GdxxNfHgHLtP+52J+E82iazZW8RzM9HvD5aTSWx3I1PhpnJHxNoGxMmQfhJOTDaxzs+a
         ATKt6lXtozDD1QqMkqYnAjNcXzOcUzRF918Mq04Rzz0WEloMrvXEkGPfb6VO9dYNMHAs
         CnWVJPvfWg7fd6RSP2b4x4V5UAp7xu6x9iXIkxFlvXRdsNyrug82+8KH2lsOWjt+065r
         lJofHw5BpRVlnDUvlf/M7mTZOKWRV7mOa1dRPUnwa76UajUO4Qx2zieOiRgfdC6MEDRd
         9GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524536; x=1707129336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7s/qvc6Ah1UcJ/8IgXhI7ljA3zFpQr6+tidoPE1SgI=;
        b=t6HhJ2n+FgkZxU9bwiQ7fo5rF+V+snSwshfJUjyvOco41TL6oeqNOPNJ7e20Qvd8M3
         azRTA/pZ17bh3k5/HErd9yulyGp5YeaT5RENymQ5ngT9FTCG+bfPSZ33aZZr22/iiona
         0ETwQI7VqVCyVKjnhUkU6LKUlno1DFShUiaABG/00hACTlzhvO/kYQVIg2hbB7p6bBFa
         kyC8Aa8Km8yD3aqAG8v9kIECsy0aaysoXDN/XphdcXl6pxoA+bA1BuPLcEpaUTd+kyYH
         r504dw6iQR65CeZqxujx6/SbwVVHZ5EDdHFpASD6vrk0W7aTOcAGCm137GT/mNTyg7sz
         p3mQ==
X-Gm-Message-State: AOJu0YwtxBTGI/lNgQzG8sDOXcxSoTBBT3RsnfuiXqmLcxmv1vqfyL3c
	7rGJViVqil9qB2UUw6DjrmiEYsiJLG/WWuXWbR8e4BkdzfsrlY0THzgC3VJPUzrfJKvZVLp03xA
	QdenVK4GV1Hz7/MJFRaj5Ol4bwOtuJrGSxXU/fA==
X-Google-Smtp-Source: AGHT+IFKjefixx71rKos4nYg8JCLE/ni4UbXS6hcwGRMOvpU5I5ZOTpjW6KSH9FcujFsvxpEjx1WXowxvfNYH10wLRs=
X-Received: by 2002:a05:6122:986:b0:4b6:bf49:ea3b with SMTP id
 g6-20020a056122098600b004b6bf49ea3bmr937153vkd.26.1706524535914; Mon, 29 Jan
 2024 02:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054623.3169507-1-amit.pundir@linaro.org> <CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com>
In-Reply-To: <CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 29 Jan 2024 16:04:59 +0530
Message-ID: <CAMi1Hd33PQJs8PaqXn1QE=rrQ03S_50NSOoW8fC0Zm+UgpabQg@mail.gmail.com>
Subject: Re: [PATCH for-5.4.y] drm/msm/dsi: Enable runtime PM
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Stable <stable@vger.kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 11:44, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 29 Jan 2024 at 07:46, Amit Pundir <amit.pundir@linaro.org> wrote:
> >
> > From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >
> > [ Upstream commit 6ab502bc1cf3147ea1d8540d04b83a7a4cb6d1f1 ]
> >
> > Some devices power the DSI PHY/PLL through a power rail that we model
> > as a GENPD. Enable runtime PM to make it suspendable.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Patchwork: https://patchwork.freedesktop.org/patch/543352/
> > Link: https://lore.kernel.org/r/20230620-topic-dsiphy_rpm-v2-2-a11a751f34f0@linaro.org
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Stable-dep-of: 3d07a411b4fa ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> > Rebased to v5.4.y: s/devm_pm_runtime_enable/pm_runtime_enable
>
> This leaks pm runtime enablement past the DSI PHY probe/remove cycle.
> Either the devm_pm_runtime_enable() API should be included into the
> backport, or ite emulation via devm_add_action_or_reset().

Ack. Re-sending.

>
> >
> > Alternate solution maybe to revert the problematic commit 31b169a8bed7
> > ("drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks")
> > from v5.4.y which broke display on DB845c.
> >
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > index 1582386fe162..30f07b8a5421 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > @@ -606,6 +606,8 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
> >                         goto fail;
> >         }
> >
> > +       pm_runtime_enable(&pdev->dev);
> > +
> >         /* PLL init will call into clk_register which requires
> >          * register access, so we need to enable power and ahb clock.
> >          */
> > --
> > 2.25.1
> >
>
>
> --
> With best wishes
> Dmitry

