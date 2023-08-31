Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B978F37B
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHaTmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 15:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjHaTmN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 15:42:13 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A71BF
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 12:42:11 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bcac140aaaso1001509a34.2
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693510930; x=1694115730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEe1IaLH3Ycd9RB7YwbM8pbf+9g4srWsZCIhmgdINf8=;
        b=qcps9BXCIyVlMcU0Tt5Wzrntkjh6NvDVk6Z5VKz3dFcsYksfe6/1o76mepRrMHNBWk
         Y8pmloDgd6vrE3h62+/25sNCmfAFyc6sM8bNkKO8wByu+9g7CIGSVWbN6pltbcTX8Cx9
         YLc4df+8/Gc531WVnMBkt9rhFxEe9n1S5NJcWmL4VnDKcEzQh+tFd0SAV26B0z2N5xGo
         GOXHFybiSStjqkIAGmaHKARX7QUFs0btckZ+STnUk/A6UDxIKEyNtTbYDpwZsIf4rSWB
         kjdyx+naleIU9VQRR3ckECvRf9YrRTthx6oVUKVUs/9oaqEM0jzQ/+5FUHauRSZOLVKN
         ID3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510930; x=1694115730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEe1IaLH3Ycd9RB7YwbM8pbf+9g4srWsZCIhmgdINf8=;
        b=WY962zJ1cTEBy2rEJqCM4XE0QihWcVeLuiQC8FahShUSh0V6JrTJVm8B0yaGIdp9ia
         FGEegrlJ6Mj1uGWzEK2VB12UQcAZFe2sNE/epdtZ4qYV+JwNrIDSjO2ZI/9hMkJ7gG+z
         O+G2u8ppWJ8bML6dOSCMnCu3VwQOq1D6rH1hilyhQZ6cDCYPpuQ0ialWwPINS0Kn8I38
         26MRRE+sJouTUJdEKv2mCSwlP+s9bmRyW384+vFj2UsnuJcNYQcnzl9aMLmtqaj8uoUO
         Nf8ueJho1rgXUW2SyMQN4dgUGNYymEc33hrLNOENl0LlSkfa54CqLLygpBC2weuVQVyE
         0J3A==
X-Gm-Message-State: AOJu0Yxkq7qZmpZRvh+zBINQ8kBGVKS+Rouh78Wl6TTLfg6ynOjY1rVF
        qjrv96hMcrH0ZqO1UPwi2/f7Zy4zifgu7btne4Y=
X-Google-Smtp-Source: AGHT+IHdBOdD/yy+CaDsyJrVO8eCM9GPyDLarT64nF7L/zvhJX9Nngj1E3+pSE9v42PbWKZ6bKa/lF651aKTdwpczGo=
X-Received: by 2002:a05:6870:3921:b0:1bf:61e3:df1 with SMTP id
 b33-20020a056870392100b001bf61e30df1mr464502oap.50.1693510930588; Thu, 31 Aug
 2023 12:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230831161228.206735-1-mwen@igalia.com>
In-Reply-To: <20230831161228.206735-1-mwen@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 31 Aug 2023 15:41:59 -0400
Message-ID: <CADnq5_McUzYqt1RWox5VpCSxPkeD7Z9oFvxU9kd+dGdN+NahMA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: enable cursor degamma for DCN3+ DRM
 legacy gamma
To:     Melissa Wen <mwen@igalia.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        stable@vger.kernel.org, Krunoslav Kovac <krunoslav.kovac@amd.com>,
        Xaver Hugl <xaver.hugl@gmail.com>, kernel-dev@igalia.com,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 31, 2023 at 12:12=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrot=
e:
>
> For DRM legacy gamma, AMD display manager applies implicit sRGB degamma
> using a pre-defined sRGB transfer function. It works fine for DCN2
> family where degamma ROM and custom curves go to the same color block.
> But, on DCN3+, degamma is split into two blocks: degamma ROM for
> pre-defined TFs and `gamma correction` for user/custom curves and
> degamma ROM settings doesn't apply to cursor plane. To get DRM legacy
> gamma working as expected, enable cursor degamma ROM for implict sRGB
> degamma on HW with this configuration.
>
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2803
> Fixes: 96b020e2163f ("drm/amd/display: check attr flag before set cursor =
degamma on DCN3+")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
> v2: cc'ing stable
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index df568a7cd005..b97cbc4e5477 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1270,6 +1270,13 @@ void amdgpu_dm_plane_handle_cursor_update(struct d=
rm_plane *plane,
>         attributes.rotation_angle    =3D 0;
>         attributes.attribute_flags.value =3D 0;
>
> +       /* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma i=
n DRM
> +        * legacy gamma setup.
> +        */
> +       if (crtc_state->cm_is_degamma_srgb &&
> +           adev->dm.dc->caps.color.dpp.gamma_corr)
> +               attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA =3D=
 1;
> +
>         attributes.pitch =3D afb->base.pitches[0] / afb->base.format->cpp=
[0];
>
>         if (crtc_state->stream) {
> --
> 2.40.1
>
