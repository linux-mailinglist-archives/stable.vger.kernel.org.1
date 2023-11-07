Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCF17E31FC
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjKGAHR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 19:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjKGAHQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 19:07:16 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB5B6
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 16:07:13 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d2efe8c43eso2903294a34.0
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 16:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315632; x=1699920432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cHGqwr/FHVu3p4GyALWjXSrLk+5zJSi7Gdv9HvbuNk=;
        b=bibxmAUiYbtreS8SAnZnwfDKsLd/kiHOLH7TLdVT29iyj/90IkibPtz9BpC++P5D2Y
         20tb8B5Z9Fg7MbitCHcC3rhu3T/2ee+xhX1AiyMuV3rsGcOI0jChuUSZDAF+N1x0a9e9
         UugYJQUttL8fvsbnC7NHBAgIsYWVTM0S0T+gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315632; x=1699920432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cHGqwr/FHVu3p4GyALWjXSrLk+5zJSi7Gdv9HvbuNk=;
        b=rtU7Tm3FkQ6rKnFUUHBpveooxShovM9OTO5aDUFA7QFX711U33GwW1vkc8yN4a3lG/
         753m3Oi+hgJA/WLtAypN3VIDkZE90ujJHfdKY8q5ToWsR2PndNGpoFLh3dMYP2+wfp3t
         Mn5ifBZVFJsO3GMIDU6a2FaOgVcm4zvwLMa1ZGVenmUPLmocjTtliUhf6IwWAvDPgHiq
         V8ERbTUXZIuEFaXpjr1/7Eqo5H/ats6gxpQ+1ZrhmcdrH3BEAd79gMpHXuQvT9NpH5KU
         PZO0MWL72hJaRNsj7SoP9MDF+6sixwG5YvMZSXZNgAtaf5bXPujM0TPvNEXlqu5dhLHg
         N/lA==
X-Gm-Message-State: AOJu0Ywlv9iDQyYMKHsOG0AnmLUgixfFKhqzFHf8tADBCJe5S8BM0hC9
        ae1RaGqvU0FIc7aMQ3kzPn+acWqJ6YMTLa2zL11kHA==
X-Google-Smtp-Source: AGHT+IENHrOhym+rA5phQNAQlQnTl0J1Yf0p/IXYFY/lzE41izBGs9kLX+KWkiFR8RZhF3D96REHcZDidQFi3eITnVQ=
X-Received: by 2002:a9d:6515:0:b0:6c7:b299:530c with SMTP id
 i21-20020a9d6515000000b006c7b299530cmr563485otl.3.1699315632648; Mon, 06 Nov
 2023 16:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20231107000023.2928195-1-hsinyi@chromium.org> <20231107000023.2928195-2-hsinyi@chromium.org>
In-Reply-To: <20231107000023.2928195-2-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Nov 2023 16:06:46 -0800
Message-ID: <CAJMQK-gF5VcXrkrX+Z4wcbf87tm-1fTkVUNdJjX648CBz2EGyg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02,
 B116XAK01 name and timing
To:     Douglas Anderson <dianders@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
Cc: stable@vger.kernel.org
> ---
> v4->v5: separate fixes patch.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 9dce4c702414..d41d205f7f5b 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -973,6 +973,8 @@ static const struct panel_desc auo_b116xak01 =3D {
>         },
>         .delay =3D {
>                 .hpd_absent =3D 200,
> +               .unprepare =3D 500,
> +               .enable =3D 50,
>         },
>  };
>
> @@ -1869,8 +1871,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116X=
AB01.4"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133U=
AN02.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116X=
AK01.6"),
> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116X=
TN02"),
> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAK01"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116X=
TN02.3"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAK01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133U=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116X=
AN06.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133U=
AN01.0"),
> --
> 2.42.0.869.gea05f2083d-goog
>
