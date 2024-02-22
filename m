Return-Path: <stable+bounces-23398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E2860478
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 22:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204A61C213DC
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE73137916;
	Thu, 22 Feb 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pep7f0Zl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417012D21E
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636240; cv=none; b=Up3yt5f6yzJaqULi+gNHkZEepiRMgKU17GfQSNwdmpYzdYPKoBvfEHsRz2qBcaugl1aHfHC8MzvchCLvUmzT0nQ30uF3Blb2dyZVLicE4ZHN/H1AeOed1qQCRuxSIkoqPr5fAv8CciHIncWcHjgHHChCAIrcUzGSsSYvVeah4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636240; c=relaxed/simple;
	bh=Y7aa4EPdQeDb/k5BX8LnNG73kjPd5qiN00vjE6nM2RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5AMXT3mgSPV+rhYCYO3hlpsdLNyjz56luez27TjrqXPxPprZtSCyS3EIfsyNSRA/c5g5Sb+UibT9YrEMZrMkT9L7qcMh2cqLoFGDTu9TixGV27uJNO09e92aIg5Po0joY06o7QLNjWz7Z0Etx5yibF9AhDFOyBEbLkMY7ZRA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pep7f0Zl; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so157274276.3
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708636222; x=1709241022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KISjjhinzIu3kIcQRpPQsw9fHAQrHUvQiIbfDFbxHeA=;
        b=Pep7f0ZlR80pDJXadhbCse5Qn0egw+++lgbATNgSL6evXNjeaqMctvxpkr3t0JbVDX
         XddISI1lj6IxtqS3Wl09G5HLRhbiFsDWAIEJ/xbiaZ2dfnu/ZfB9vjXZKmGgI909rZM6
         m+AyAXcZo8cxDeyKJd6LUJzs08XAMwlUG5gBjaE+jLhycUxGYs7n1+PnXsoGZMm2itGh
         4sOg+hm2ew7n9q8FKnhV3LzbKszZe0ZnJgxlebUO17I8qGDYT3dZF7pbNteialiFkXpS
         Oy166qxxbyrTz8d0APfzThbM7y3l8EHCSaNUnFjPsGkzb8qSM8AGIFuPppwyeDZCWSSR
         uZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636222; x=1709241022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KISjjhinzIu3kIcQRpPQsw9fHAQrHUvQiIbfDFbxHeA=;
        b=O0rgV3ONc6Ut3eHGlOYRHnlObeSN/Lxe45B27NF7nxvuW5ewZo9pWor3J8x0LFFdo+
         wjcoQWyNUYG5JvgFfF0/lTvZWl1wJVIAFY6PgMWRX7yulbJnLLbjVUNTDvkhWZbAjHnK
         A8j26pGa8/BuaBM7JFYZjb72hOcvztKy0eow4CbJv2SoOtNEtVkqNEETfyXEPlFOMJ+j
         TK+dHliPjIWas3OmPHyBY3Ilirx6l/SStYPNMhuep9vifRo/HwRHOj5eiSJ7Mfz47gzB
         U7VjLdW9Tqqgiygu/6QqZSyHgANZLTwAMn+5PYa4dwZrslD3pZpNj0y+hdgWMMMOzP2I
         2lKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuuX5BSeQ6IYYZU+uAHHBb+6FlAsPaQUfTNLFoQvEM7v1tfsYLsDtZ6ZD5mCP0Zl43lH05A0HM9lqKJ1sy/MulBiI/4LdN
X-Gm-Message-State: AOJu0YwnOOqWdjShMe2WJu8vDb7pgB/8P04/R5KfdpsgsGeVC2TJcMC6
	0G/aiQTqvtKxmU+7otIwOjYb0JkXbi/qEN+K6EdKXC9j15uKVDYDO1O4l2tgnKJM5++qEpsTZ3H
	bMaYReHJkc9Fji7AkzsRcBuaK2bl2VCG73AjDXg==
X-Google-Smtp-Source: AGHT+IEBy/FkALInxvThzqnKOPLYZgoL5uV+k6buUGcPqG2FwQZGtnq6q8rWdEVgVmBapKjqMXBdOJ9HXitiHUCL6FU=
X-Received: by 2002:a25:888f:0:b0:dcc:aa1f:af3c with SMTP id
 d15-20020a25888f000000b00dccaa1faf3cmr366027ybl.40.1708636222326; Thu, 22 Feb
 2024 13:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org> <20240217150228.5788-4-johan+linaro@kernel.org>
In-Reply-To: <20240217150228.5788-4-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 23:10:11 +0200
Message-ID: <CAA8EJpoPaknqPUEg8p37Nh1MV62Cr8fH+MxE-1b+T-8h3BmO9Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
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
	linux-phy@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 17:03, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> A recent DRM series purporting to simplify support for "transparent
> bridges" and handling of probe deferrals ironically exposed a
> use-after-free issue on pmic_glink_altmode probe deferral.
>
> This has manifested itself as the display subsystem occasionally failing
> to initialise and NULL-pointer dereferences during boot of machines like
> the Lenovo ThinkPad X13s.
>
> Specifically, the dp-hpd bridge is currently registered before all
> resources have been acquired which means that it can also be
> deregistered on probe deferrals.
>
> In the meantime there is a race window where the new aux bridge driver
> (or PHY driver previously) may have looked up the dp-hpd bridge and
> stored a (non-reference-counted) pointer to the bridge which is about to
> be deallocated.
>
> When the display controller is later initialised, this triggers a
> use-after-free when attaching the bridges:
>
>         dp -> aux -> dp-hpd (freed)
>
> which may, for example, result in the freed bridge failing to attach:
>
>         [drm:drm_bridge_attach [drm]] *ERROR* failed to attach bridge /soc@0/phy@88eb000 to encoder TMDS-31: -16
>
> or a NULL-pointer dereference:
>
>         Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>         ...
>         Call trace:
>           drm_bridge_attach+0x70/0x1a8 [drm]
>           drm_aux_bridge_attach+0x24/0x38 [aux_bridge]
>           drm_bridge_attach+0x80/0x1a8 [drm]
>           dp_bridge_init+0xa8/0x15c [msm]
>           msm_dp_modeset_init+0x28/0xc4 [msm]
>
> The DRM bridge implementation is clearly fragile and implicitly built on
> the assumption that bridges may never go away. In this case, the fix is
> to move the bridge registration in the pmic_glink_altmode driver to
> after all resources have been looked up.
>
> Incidentally, with the new dp-hpd bridge implementation, which registers
> child devices, this is also a requirement due to a long-standing issue
> in driver core that can otherwise lead to a probe deferral loop (see
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).
>
> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> Fixes: 2bcca96abfbf ("soc: qcom: pmic-glink: switch to DRM_AUX_HPD_BRIDGE")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

