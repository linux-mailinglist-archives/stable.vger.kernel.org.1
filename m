Return-Path: <stable+bounces-23400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9986047D
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 22:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93401C22279
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392E73F2D;
	Thu, 22 Feb 2024 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXs5O9Eh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DC73F21
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636291; cv=none; b=I2ZlhNKycFgKVd7d7vYN8uEk/yWiU1UBbDmnAjbLP4Mgui5k1jrI9anvByksjK3ZMMGtDqtVNMvGQBP2BStJkWQPPq1evsoo5HSMRZghRn69ENPGrtqjQzmhcKvszKPYT21uwWAMoqENLVaEEI9QOeG3ry1Qq8URKvAyXzNFoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636291; c=relaxed/simple;
	bh=4lvUACcF/m/1OgHfKrNiwXVgw0JcCGJNrv4rn/OYioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2A+CM3MRmOCNPky7CnAV/DXrVrOThkhvAj3TIYuVIO3cGnN+aVaxmAGsy577TQE9C3TUN2fovShGrgGd02LZMx0mQ31K92zxGDe4ygmZuUg2CukhsRB3K7zUHekuqHmH/FRFUq5z7fnsRgrqVywyNlwaG8FTr6K7e2mdP3WsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXs5O9Eh; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6087396e405so11631577b3.0
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708636289; x=1709241089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6LQ9AKd6x9Ppr8V8DrGvzfthJpW9UNBDUhPwgck2Wa8=;
        b=bXs5O9Eh4G1d2kyqAL75Bt/VkAD2I/r8E3zDy4JqWZF/nLvZxK1RL8Y8OStNn/N28r
         mx6PplzOjmTqMqr/1cLRnlRkYR8mS1fTWg9DqO22Q+2nqWjuHL1ApHPRfkIV3k09c+Rz
         0P7jFSLywAJJuXEzmDRMsmMVpjJ67EqMdeFahj0fxw+pGeG73/Wrb8H8IifwVudwOtbc
         aPRYdSxb86SRla7o8n/Lxorl3ZxbVYJjrrxZCG8Ob+pBjwYyddlGsHlcE42GZ1oamG2J
         o6wtfBfYg/weenJu3yACGn84ZiUBD4qQgfuxaaXlnUu2rkvWaRv9myGnhJ47z1Ua8/Nb
         QmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636289; x=1709241089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LQ9AKd6x9Ppr8V8DrGvzfthJpW9UNBDUhPwgck2Wa8=;
        b=APxxuEnwqjK3xdK3yFk+KeioZby3+Vk7+544GvPzsDl5+kwlAGfYNwNO7+Mv+O0WBM
         uNKqMxN8L4d+dm/kK/aSU/KTnJSca1bbM0qK8XCkWoB05ECbN4PWHGUieY/RzRUkMOX5
         r+3sVlFFRa9kDpi2K8NHQpNQQD78KJdXvuml+dwn7tUZLUemxZwG5DIR7eXY8x6l+M+S
         feiRw7Tm0zHTWXmRlkrZKIaO+jW0dAexfDxCiOibUWCBTcicEZx9R4unDmpWgsKkM+B+
         LX0mAoBoj9ui1TNp/TjUwB7T9aanO6pB50Tt55WftJ5IaywBVx17ZLXY8pjoHhOp3wWl
         BT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAmp6AHtMKjB/ybSnu0JzJBVZNCzUZkbV9yztLsUwCmlHpNA0UFLNLg3Jsq0WhW+umskaG8+9Zgin/aYpSLICUA7Ml0jm7
X-Gm-Message-State: AOJu0Yy7C7cDP0jVe5Kj8SrYPcmibi967/dDzpNyLQQ+uwf26vUiYH4R
	0nBGKKDxNWZoT9lRss8P/f9g9XMYGF5QBPsHf1iMg7PNpvWOw3FuCTQI9E8lvL/EWZLzZziQVJk
	aW+Kbf03Fye2bIQRFGxmp0Gcqnlj0UoS2HGD3tQ==
X-Google-Smtp-Source: AGHT+IGr40bVHUaWXhi2S3xmL6UJgO5Qya3+KW1Y3uj1TASqY4EfBpznUda1BUrj++1QaDRzC2B4Zta0+WKsL88FVd8=
X-Received: by 2002:a81:451a:0:b0:608:821a:15e1 with SMTP id
 s26-20020a81451a000000b00608821a15e1mr146315ywa.9.1708636289156; Thu, 22 Feb
 2024 13:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org> <20240217150228.5788-6-johan+linaro@kernel.org>
In-Reply-To: <20240217150228.5788-6-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 23:11:17 +0200
Message-ID: <CAA8EJppnHY=jDYjgTn+2dF_zmGwM9+KsUS6vOyPB_wa9W0v-UA@mail.gmail.com>
Subject: Re: [PATCH 5/6] phy: qcom-qmp-combo: fix drm bridge registration
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
> This could potentially also trigger a bug in the DRM bridge
> implementation which does not expect bridges to go away even if device
> links may avoid triggering this (when enabled).
>
> Move registration of the DRM aux bridge to after looking up clocks and
> other resources.
>
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).
>
> Fixes: 35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")
> Fixes: 1904c3f578dc ("phy: qcom-qmp-combo: Introduce drm_bridge")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

