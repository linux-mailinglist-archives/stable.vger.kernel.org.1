Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D47E47AF
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 18:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjKGR6O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjKGR6N (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 12:58:13 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5EAC6
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 09:58:09 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9db6cf8309cso883818866b.0
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699379885; x=1699984685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGXr30B7ae9S2k+FMAtadT8oxyML17udu5CvmGuW3q4=;
        b=aTdk1Y4kT+szYNQ4jfd1n7qzWbf/BYLqwbm31essGfJs2WtzaG0d5MtWStYPXnHgMm
         5YF3chh9ZtqLVDBJUyHR2ZoJ50c2gArnI6c9DbWfNVQUEKPc0WXh2GDvuDdVlhq9Z7Xt
         caVrVFMbzzNGzdInGnxsyEQe/GuYGmma2NCo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379885; x=1699984685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGXr30B7ae9S2k+FMAtadT8oxyML17udu5CvmGuW3q4=;
        b=gT5soS6tTqwpdpsp96nxUkyFPtMlDCxeYHZ46oQtQylxiENzEmdRIN6swzqBHWHCwI
         wN/jlYw2yB40n/RpHm4wy1ajYYRMC3CkXqXAFgAERp1OZltsf9RUC6KdJubUEPxHFBFv
         GXozwJGXZv0jULkT0qioeqXnhQieOr+qgP9lGSFwPcYfAtpCL8Yln3yNjYon6vPd4e9u
         +bYfJV7btFsliPPvHiysD08f3XbKl1FP2eTMDiMoniN2XuRwtN97mZaygXrkLHw+HOuJ
         IzuBhV+YdkCxlyinZXxC5xZHSgbjcVf8gbqx1OU7Kh2nfOIgovw+RIxdxCIX6MeiVDk5
         +rAw==
X-Gm-Message-State: AOJu0YyvuJjrZO9kjkMX5og8PcHzkAyys2q13flT0KLx3NlnZ90JdGwS
        pDZHHkcgsg+le9BsxPXSpXj1Bl2BH5LJtm/uRz7cWNL/
X-Google-Smtp-Source: AGHT+IGg/Rb0aPMi8sBH415gYu1TH0P4G/rSPJeN574J68219BdnrvSkU7WljHS7V+nLx0EWHIKN7w==
X-Received: by 2002:a17:907:36c5:b0:9d2:bf19:88aa with SMTP id bj5-20020a17090736c500b009d2bf1988aamr17171839ejc.59.1699379885215;
        Tue, 07 Nov 2023 09:58:05 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b009dd678d7d3fsm1293845ejq.211.2023.11.07.09.58.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:58:04 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so366a12.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 09:58:04 -0800 (PST)
X-Received: by 2002:a05:6402:5410:b0:545:2e6:cf63 with SMTP id
 ev16-20020a056402541000b0054502e6cf63mr60142edb.6.1699379884098; Tue, 07 Nov
 2023 09:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20231107000023.2928195-1-hsinyi@chromium.org> <20231107000023.2928195-5-hsinyi@chromium.org>
In-Reply-To: <20231107000023.2928195-5-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Nov 2023 09:57:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WpZt0MsQ3Yi01+hMmBgL7Z-S_+sjUipopM6qTQkgOY8g@mail.gmail.com>
Message-ID: <CAD=FV=WpZt0MsQ3Yi01+hMmBgL7Z-S_+sjUipopM6qTQkgOY8g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] drm/panel-edp: Avoid adding multiple preferred modes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 4:00=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> If a non generic edp-panel is under aux-bus, the mode read from edid woul=
d
> still be selected as preferred and results in multiple preferred modes,
> which is ambiguous.
>
> If both hard-coded mode and edid exists, only add mode from hard-coded.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v4->v5: remove inapplicable comments.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
