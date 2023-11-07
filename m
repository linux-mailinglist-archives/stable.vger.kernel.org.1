Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9847E47ED
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjKGSL6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjKGR40 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 12:56:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F18F
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 09:56:23 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9df8d0c556eso416692066b.2
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699379781; x=1699984581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8StncZh/iw8rVTbFpbMeIoiTuJSwCnvKTl9QP94ClOw=;
        b=X8swh9l6UiEyclAGFZwhvbLe4wkWcO9/d7EkqZkSi2d3wWkFbBIjIufsG2TNOSnx1E
         WxRFf7AHoIV9y5VAMPFoE0rRKQnHkz2OWxiYP+J+kUF3UpJEGMCdVAHDNOTDyB9nZcOV
         Hl2d8nbtZx1OgIqI0AkFqTXlBdNZWSMRzmveI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379781; x=1699984581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8StncZh/iw8rVTbFpbMeIoiTuJSwCnvKTl9QP94ClOw=;
        b=Mugd0EoiCHbM+PwRN18Eu5HEvFbUXot/M1YAcN1LPJOAbFwEQArIHdov++NoS/08VG
         2Gx4S8cXXT2zy/zb2n0hDMJ0sxi30+77N6nMD/a1HPs8AAyafm0Yic94jWALTifgMc//
         vF3Pre6I6PHIxnaYTKhqzvK5Zn2FRJGMC5dsF1NexkhHb6d1KV84T+wZc+56f7FMr3WJ
         jtMOR8vxLBvrfCJhSpa04TV2SIbVmE/kKOFC1bOft2liHaHbYXyAhxzMOAe5enqPaDq1
         i54uA1Q+eJt4+7dHe+lHLXiuPLcjeBKoUhbfUCoe2GiIBfQVH+LjPW8tKAPGCH9WF6US
         B4Fg==
X-Gm-Message-State: AOJu0Ywq5SqpMnJuXIWUQUfYdI2zhusCtvLv8hZwDbYFvXqkLdBPDs14
        9xHRlAAuZzDQ/FVz/xhVuhsid5KSHCBQR3PJvKsQUun/
X-Google-Smtp-Source: AGHT+IG2MH1cvj0SfLYn/cqYKAEV2zDQXUZSf2mOqr8wJBYlOsPwatk5YsPZc6euVZlWv0CrVojoWQ==
X-Received: by 2002:a17:906:d554:b0:9ae:5db5:13d with SMTP id cr20-20020a170906d55400b009ae5db5013dmr19481664ejc.72.1699379781072;
        Tue, 07 Nov 2023 09:56:21 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709062dd900b00988f168811bsm1295309eji.135.2023.11.07.09.56.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:56:20 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so320a12.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 09:56:20 -0800 (PST)
X-Received: by 2002:a50:d68b:0:b0:543:fb17:1a8 with SMTP id
 r11-20020a50d68b000000b00543fb1701a8mr120839edi.3.1699379780027; Tue, 07 Nov
 2023 09:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20231107000023.2928195-1-hsinyi@chromium.org> <20231107000023.2928195-2-hsinyi@chromium.org>
In-Reply-To: <20231107000023.2928195-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Nov 2023 09:56:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XdVnFqbF9UZ-W1OWMVWSxk=CxP9WAb3q4rT7S+ryxXWA@mail.gmail.com>
Message-ID: <CAD=FV=XdVnFqbF9UZ-W1OWMVWSxk=CxP9WAb3q4rT7S+ryxXWA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02,
 B116XAK01 name and timing
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
> According to decoding edid and datahseet:
> - Rename AUO 0x235c B116XTN02 to B116XTN02.3
> - Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
> auo_b116xak01: T3=3D200, T12=3D500, T7_max =3D 50.
>
> Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,=
836X2, NV116WHM-N49 V8.0")
> Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v4->v5: separate fixes patch.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I hate to be a hassle since I don't think this will have any
meaningful impact on anyone, but given that it's now split out as a
fix it should probably be split into two separate patches (one for
each fix). That will save time for anyone dealing with the stable
channel.

-Doug
