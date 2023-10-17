Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD47CCF46
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjJQV3C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 17:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjJQV2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 17:28:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132A4780
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 14:26:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c64a3c4912so4291316a34.3
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697578002; x=1698182802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7oRudJTZNQ63tfH/j3jOwQZOr/oDmGpk2QUzgSFYa8=;
        b=jfEg1FUw5PiC69O3dipAAwfM+xKjFca/dNHffT+aV8jItI8TpoJhoTOjYu/efeOVIS
         9eIj5tFf00LzaXpECi/sceoFEoyJHOv3EFFXPz50UNtPCdhcWIXVq7yU8oWUt4xuPAl+
         4le9nuoPzzVD9Sho5fmW/bvm5e1rcAWYYDhRaLVOR3Ednm5j98SZbBe3vg57wXFeHqF5
         BpgAnmYBVBkleAAzk2pkIzl2NYQT2mesqdVLWduEt8u3bvwFDNwqWcsrfX5WRbN+avYF
         5+5mpsAzBFYHQ5W46zErBdd+ua/7sVu2lseS0Y/W2CzxdSXncnxpzKTJ459SCRoE1UxH
         6EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578002; x=1698182802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7oRudJTZNQ63tfH/j3jOwQZOr/oDmGpk2QUzgSFYa8=;
        b=j6Wk4QPk15/HStdsJPrsNXHZTlwqt5OcHv1uKZ52bsnbbyJNMMetSvoQ6sMd78SXcH
         /+bjbHgSoaubM6pqbhng5GHGLy+iHmKjVy0JhAG9O17nKAoe75+SCcucvAmXULVu/R36
         aM086T6REkVw1ugSqzJ9MTTJbBuClhT0KO/3mypktfQtPdegdTfW8kHwiG+NGeLwNuyq
         sDqpEzMUOWVYlPQ/8r4v44L0MSMyoozdjWghHvVCUI0qtpuSDvjFZcul7k4FWxkFvk0I
         Mp/1vLj+TYDZSVjQVcS7H0pia6l0WFMc2q97ICC4Pv44JZZT0UW4ppQ4iwrVNGrVx7Jy
         ZDhQ==
X-Gm-Message-State: AOJu0YwKujhQMIKUMEXWalVr82ZBaOwJBOkZ/cGfmPG+cmrUMosCQtPM
        80QJH43jv2oW5z4toA4evGydvlDVGIGR4fW7pGkfNc+U
X-Google-Smtp-Source: AGHT+IFHP3DC+vFE1ZAYUASSi1nwdTzgbABfTYwexiMCgpOeTNU5eenzTLo8MmvJE5ZGboVQ1DHYQ9vTtJLksnkDmLE=
X-Received: by 2002:a05:6870:212:b0:1e9:a770:61eb with SMTP id
 j18-20020a056870021200b001e9a77061ebmr4182248oad.29.1697578001683; Tue, 17
 Oct 2023 14:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231017140135.1122153-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20231017140135.1122153-1-bas@basnieuwenhuizen.nl>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Oct 2023 17:26:30 -0400
Message-ID: <CADnq5_Mcrd3czO4jxqUCryn-gNCCM_1+8J5vwT=CTJLJys9B6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Handle non-terminated overdrive commands.
To:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc:     amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        Rex.Zhu@amd.com, stable@vger.kernel.org
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

On Tue, Oct 17, 2023 at 10:01=E2=80=AFAM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> The incoming strings might not be terminated by a newline
> or a 0.
>
> (found while testing a program that just wrote the string
>  itself, causing a crash)
>
> Cc: stable@vger.kernel.org
> Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage s=
upport in sysfs")
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index da0da03569e8..f9c9eba1a815 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       if (count > 127)
> +       if (count > 127 || count =3D=3D 0)
>                 return -EINVAL;
>
>         if (*buf =3D=3D 's')
> @@ -780,7 +780,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>         else
>                 return -EINVAL;
>
> -       memcpy(buf_cpy, buf, count+1);
> +       memcpy(buf_cpy, buf, count);
> +       buf_cpy[count] =3D 0;
>
>         tmp_str =3D buf_cpy;
>
> @@ -797,6 +798,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>                         return -EINVAL;
>                 parameter_size++;
>
> +               if (!tmp_str)
> +                       break;
> +
>                 while (isspace(*tmp_str))
>                         tmp_str++;
>         }
> --
> 2.42.0
>
