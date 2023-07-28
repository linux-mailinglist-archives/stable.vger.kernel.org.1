Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A0767779
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjG1VOi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjG1VOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 17:14:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE31C449E
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 14:14:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2682e33509bso1850364a91.1
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690578875; x=1691183675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihhjQ015ULBeLHlsfdra97mpsg2Vdyuop1Qw9sUpXRo=;
        b=YKTfrAu5cda6Hprzk5VLtLJ9seMWwKUBsHuPfS7QeYveEDsRT9YbfTenV2POOX+u/A
         i3EZqODzxV9KJ6lMlGl6sUb8CMArJTYDnZrnA+2mo823uyRd9e4u4CMTBOolSQwMh27j
         ok9XnpsU0iH7kLzkuObcvcpn7braC14x8ORgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690578875; x=1691183675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihhjQ015ULBeLHlsfdra97mpsg2Vdyuop1Qw9sUpXRo=;
        b=RHvtvUjoAdJZmsutGeW1bw+VfiwLcc967c3bn9FwissqVxB5QSBQUUehBvmdDEo6yU
         DUwD7sEC7QQgHCQWmztMcLQnxnmWXLULXmtG6dyzDG6mae++9q05qAz+vIbdWAjXiIeI
         YlPvSnEhbA/lfBHd7yoaPS2MDi4U+e+0pmhI5I0ln3w8T6U2a2fyPf7dQ8SQm/wDony5
         BA8eksCe4uNNKJQIcD5CnWcrAUU0AS+mpUc1ZdxXziZsRlEQf/FaSDG3sOJRgWSBjqr0
         L/21rPZP12hQRPEpA8A5A4fbNxVcyrI9W4aqcQ8o1i4+S3ph7uKwRDHtdd31IH3d5t8W
         o2oA==
X-Gm-Message-State: ABy/qLbiVKFUFJz+wdiQAJ1TZpaSpbpnly0ToS/BSGi4txmgqDCcDvbY
        JoDZSttzBwM5IiVt4DsLJLGlZ2kI/UTjV68+kWrw9w==
X-Google-Smtp-Source: APBJJlFcl3YqaMIBj+CnnYODhnukpUqOI9hBHtsgGI2hOks0pyAdr/xfVsUBA+2Ff6uXmcdr1p3gsf/OiHaBif/tUVU=
X-Received: by 2002:a17:90a:a109:b0:268:5c3b:6f37 with SMTP id
 s9-20020a17090aa10900b002685c3b6f37mr2814972pjp.0.1690578875380; Fri, 28 Jul
 2023 14:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com> <1690432469-14803-4-git-send-email-quic_vgarodia@quicinc.com>
In-Reply-To: <1690432469-14803-4-git-send-email-quic_vgarodia@quicinc.com>
From:   Nathan Hebert <nhebert@chromium.org>
Date:   Fri, 28 Jul 2023 14:14:24 -0700
Message-ID: <CANHAJhGpdHLnU0d5H2xKJtE-F8fj7ge9+OkKG6Q=h_WtSRa1qQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] venus: hfi: add checks to handle capabilities from firmware
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     stanimir.k.varbanov@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hans.verkuil@cisco.com, tfiga@chromium.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 26, 2023 at 9:35=E2=80=AFPM Vikash Garodia
<quic_vgarodia@quicinc.com> wrote:
>
> The hfi parser, parses the capabilities received from venus firmware and
> copies them to core capabilities. Consider below api, for example,
> fill_caps - In this api, caps in core structure gets updated with the
> number of capabilities received in firmware data payload. If the same api
> is called multiple times, there is a possibility of copying beyond the ma=
x
> allocated size in core caps.
> Similar possibilities in fill_raw_fmts and fill_profile_level functions.
>
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability par=
ser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/med=
ia/platform/qcom/venus/hfi_parser.c
> index 6cf74b2..ec73cac 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -86,6 +86,9 @@ static void fill_profile_level(struct hfi_plat_caps *ca=
p, const void *data,
>  {
>         const struct hfi_profile_level *pl =3D data;
>
> +       if (cap->num_pl > HFI_MAX_PROFILE_COUNT)
> +               return;
> +
This check does not fully prevent out of bounds writes. Should the
return condition be on |cap->num_pl + num > HFI_MAX_PROFILE_COUNT|, so
the last byte won't be written past the end of the array?

Similarly for the patches to |fill_caps| and |fill_raw_fmts|.
>         memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
>         cap->num_pl +=3D num;
>  }
> @@ -111,6 +114,9 @@ fill_caps(struct hfi_plat_caps *cap, const void *data=
, unsigned int num)
>  {
>         const struct hfi_capability *caps =3D data;
>
> +       if (cap->num_caps > MAX_CAP_ENTRIES)
> +               return;
> +
>         memcpy(&cap->caps[cap->num_caps], caps, num * sizeof(*caps));
>         cap->num_caps +=3D num;
>  }
> @@ -137,6 +143,9 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, =
const void *fmts,
>  {
>         const struct raw_formats *formats =3D fmts;
>
> +       if (cap->num_fmts > MAX_FMT_ENTRIES)
> +               return;
> +
>         memcpy(&cap->fmts[cap->num_fmts], formats, num_fmts * sizeof(*for=
mats));
>         cap->num_fmts +=3D num_fmts;
>  }
> @@ -159,6 +168,9 @@ parse_raw_formats(struct venus_core *core, u32 codecs=
, u32 domain, void *data)
>                 rawfmts[i].buftype =3D fmt->buffer_type;
>                 i++;
>
> +               if (i >=3D MAX_FMT_ENTRIES)
> +                       return;
> +
>                 if (pinfo->num_planes > MAX_PLANES)
>                         break;
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,
> a Linux Foundation Collaborative Project
>

Best regards,
Nathan Hebert
