Return-Path: <stable+bounces-23401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE43860485
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 22:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D311C234A8
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C573F34;
	Thu, 22 Feb 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMxFcXbY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A26AF94
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636354; cv=none; b=mw8ARD6tpXAaY+6jHXNZpxZm0wvMAm8e8JmIeLGzHEO9HfEduEnI82/4+BQg5kM6CfHraJ35m0XB0Fzh7VJFyMlpu22SzhefI0LkzwSL90HcC/OCYJ7IitQbLlW1vpHulxinPodqwO2lMV40yFFwmvVpqr61HlX4toIoj7Gq+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636354; c=relaxed/simple;
	bh=lTdUa42NwYjJJpKBleL4FHR9ezbFYLTvE/pbZhVextI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSw0wCf4iU9BJrxEudAojbe1ted5+kNSt8GGrGq660E7pLUo7xgUlcIJP1a3iLhGT9w1izavEjfMQrM205xZ1OVfaLgDlVXFafvLLDZCkYUke6wBvwJfghqfvkS4nppyeGA9t5WsYt8QD+gl5llWoHVymkiVPgFtw+pqSDHf9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMxFcXbY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso167401276.2
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708636350; x=1709241150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fenjTlVOLcRdKZFsqaTFAV94+jNqh66pMdN4WeCK6m8=;
        b=qMxFcXbYiHN5obuw2sfrNhLiCCc6Vl50BSuLwGxNyd2AjOMoUGOeTGvwSXTOvXwfsV
         10X16X9OWDGu1hEsDmGo1pvLN6Ah7X7yyoM/r9LmbsetnpdbYHoKQrsBE8MRVWXZ3Skc
         Dh0yd6MhHe7wnoc3LhHb/J+GbVTOOaDsn57C+SVc4zD2eX3HrssMyAYnrKt+Zs2tDyRp
         9Z4RlDVUiIRrvsUyLrdXyDW+8d4lpzOEuDettsmn6Mc95ud1/LFoZoS+lYsBQQTgQYeG
         u5qc8Y/cdO6Ps/2ewDvx5KjByPnD/EpcaUEMcHCm4X727xDSjSJY/mCQgaZ725UHBhjX
         /pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636350; x=1709241150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fenjTlVOLcRdKZFsqaTFAV94+jNqh66pMdN4WeCK6m8=;
        b=Iw6aKbzxpXXqVr773yj5KWqh256kznhv5969orTR8P1MEdjzpTy5um/ohreyMTmjxa
         nDHx4QD7d4IgaoXGsWa/R+T+ebjSKJBRJiv9tSa89WXYtGvapIbpWSl76JRMK1mzQCrC
         gA+CE602kzw/tEnIktpFeqor4ZsHBWNQ2aym0AVbUa5ogIT+FSzo2nGdv20dnh5Uon4Z
         yhSEJgb0hTGGDq0oarU/zlOVQzRkKtTAvGIEU14gbfK2ZEnshw2mLTXcMO/AT0g2fOBl
         TY0bhYwQmZkl704WkJzVx2vfuTFX0lvkq93/hE/yiQAtTJLKFBVPc7nepSt6nYiQasXV
         ZRpw==
X-Forwarded-Encrypted: i=1; AJvYcCUGsNqwxTbf7TecNqNmQrJ/N0tVKmcG7YyBz0EIbHczyUF+hC6J326VIqBX5z+bM03xc2dD2AVB94NgvbOnj+aacOWJ+gDb
X-Gm-Message-State: AOJu0YzpYiIHtSzieSDrfkyhab5zsLhuPFJkD1PDiuCP4v495NljASz5
	avFy+HlNbhVuCN52CZyxyEZQ/77c7g+bive3yzrvSLqxXCD9poiIAtLYlqVdDucSsqb4xYl8t/D
	X2UapSxfdu1Mn2VHj9ExvOYTrkQUbGlvuRk0D+g==
X-Google-Smtp-Source: AGHT+IFh2TAl89Hutu4vqCYOc5+0AJ9qQayg9ScjNq2n3H/zD5V2O2sGDJBBs2zipfHmjaQpRtAUdHsgH00u4T387Jo=
X-Received: by 2002:a25:2747:0:b0:dcd:3338:a3c5 with SMTP id
 n68-20020a252747000000b00dcd3338a3c5mr382880ybn.33.1708636349969; Thu, 22 Feb
 2024 13:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org> <20240217150228.5788-7-johan+linaro@kernel.org>
In-Reply-To: <20240217150228.5788-7-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 23:12:18 +0200
Message-ID: <CAA8EJppPg7b-DsPJ4W=2G-_rRq+xTux9kJ3oJhD2ws+FoJvkKQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] phy: qcom-qmp-combo: fix type-c switch registration
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, stable@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 17:03, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Due to a long-standing issue in driver core, drivers may not probe defer
> after having registered child devices to avoid triggering a probe
> deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
> -EPROBE_DEFER")).
>
> Move registration of the typec switch to after looking up clocks and
> other resources.
>
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).
>
> Fixes: 2851117f8f42 ("phy: qcom-qmp-combo: Introduce orientation switching")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note to myself (or to anybody else, who has spare hands), we should
probably implement the same changes for phy-qcom-qmp-usbc.c

>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index e19d6a084f10..17c4ad7553a5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -3562,10 +3562,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       ret = qmp_combo_typec_switch_register(qmp);
> -       if (ret)
> -               return ret;
> -
>         /* Check for legacy binding with child nodes. */
>         usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>         if (usb_np) {
> @@ -3585,6 +3581,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_node_put;
>
> +       ret = qmp_combo_typec_switch_register(qmp);
> +       if (ret)
> +               goto err_node_put;
> +
>         ret = drm_aux_bridge_register(dev);
>         if (ret)
>                 goto err_node_put;
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

