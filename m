Return-Path: <stable+bounces-5500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5880CEA0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D78280ED7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F03495CE;
	Mon, 11 Dec 2023 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fflFKPq0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BBC2
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:47:03 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ef36a04931so3145664fac.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702306023; x=1702910823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k8oV1J6Mhmy7dAdrAizIOTZXTTC3FDSyWhhVoePaMM=;
        b=fflFKPq0WjwQo/2gi3tbkZQXvJHQ70gRWdRn+WauZtM4X7TA6IR/XdUJz+y/2gJhXR
         QAXtZ6eci4F+3lYI4eCp1nsXRu7mNPKgEJlFLTjBfTaQaxwKVeaqyE7UcSuKfrEOpohR
         w4GoI/dpA9BIktu7hzy0Nldb7ZnGpa+kBWqrPoVigPcA5ApkxBn0eHjeYaSKJQ8kjQqd
         lMbjytH6ktW/x4p9ukULuAFEwsyO6ZvBGxTrFNb7E01CyrarVTu9d7QCMdRptE9bEQSN
         ktniNRbxATBVlqL4x7U9E2p3jwAn2h+BgBl/DJ0zQ4ZhPWuQ7SMyLsJXrVN4+A8FEhsu
         H1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306023; x=1702910823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3k8oV1J6Mhmy7dAdrAizIOTZXTTC3FDSyWhhVoePaMM=;
        b=iA9F95ZpIGEcQFlmAD/KVYAXh5cDrooGK0p8MSg/fKyegNSFkuakjnixQ8/O2AJOJE
         oLyT4kF6YKF4VoTi7/vxF073hJOP9habIxqOpqtX1yktukKGXevIfqsHOvg+BlcbX55C
         5curqfKulbu/bNuUCxRN5trIP0TYYkmBihOkvlE9m6Q/i/zZKnM5ljlU1jtmJzRDcImW
         9JnKyCFQWUUO6QZ4OXl4RNObkEreifZBVjlSjaboKDdLB0kRd5s9vIh8iP0hM3W7iXAb
         wMXvx5AhmKD3JaF0gyCTNXOY4uxpK5pOOM3A4YlV6HTWhpt8VQTAPmxwAfguzCLw0bu0
         TONA==
X-Gm-Message-State: AOJu0YzcjWQFo5H38qKkIMY5V8QNJsEObORiKKXDq0suMfAYgLvbMb8U
	WyynUTlXr8gO0jCTEl0KtlpkoSsvJ2GBl95ib8M=
X-Google-Smtp-Source: AGHT+IED+ePBGYeLKfKIzKuttbd8qiyKR+6xN8NeN9YFn4jfD3doBb6c1ZDoKYA6Alu3jZ/3G8SQqp8avig6EPCGJsk=
X-Received: by 2002:a05:6870:8a21:b0:1ff:a07:d38c with SMTP id
 p33-20020a0568708a2100b001ff0a07d38cmr4797532oaq.85.1702306023058; Mon, 11
 Dec 2023 06:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209200830.379629-1-mario.limonciello@amd.com>
In-Reply-To: <20231209200830.379629-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Dec 2023 09:46:51 -0500
Message-ID: <CADnq5_PEff3EYs97vMj-m9ft6dGe7YgvQ2VcKFTOUJn_qKcdDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, binli@gnome.org, stable@vger.kernel.org, 
	Hamza Mahfooz <Hamza.Mahfooz@amd.com>, aaron.ma@canonical.com, 
	Marc Rossi <Marc.Rossi@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:22=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When screen brightness is rapidly changed and PSR-SU is enabled the
> display hangs on panels with this TCON even on the latest DCN 3.1.4
> microcode (0x8002a81 at this time).
>
> This was disabled previously as commit 072030b17830 ("drm/amd: Disable
> PSR-SU on Parade 0803 TCON") but reverted as commit 1e66a17ce546 ("Revert
> "drm/amd: Disable PSR-SU on Parade 0803 TCON"") in favor of testing for
> a new enough microcode (commit cd2e31a9ab93 ("drm/amd/display: Set minimu=
m
> requirement for using PSR-SU on Phoenix")).
>
> As hangs are still happening specifically with this TCON, disable PSR-SU
> again for it until it can be root caused.
>
> Cc: stable@vger.kernel.org
> Cc: aaron.ma@canonical.com
> Cc: binli@gnome.org
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/=
drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index a522a7c02911..1675314a3ff2 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>                                 ((dpcd_caps->sink_dev_id_str[1] =3D=3D 0x=
08 && dpcd_caps->sink_dev_id_str[0] =3D=3D 0x08) ||
>                                 (dpcd_caps->sink_dev_id_str[1] =3D=3D 0x0=
8 && dpcd_caps->sink_dev_id_str[0] =3D=3D 0x07)))
>                                 isPSRSUSupported =3D false;
> +                       else if (dpcd_caps->sink_dev_id_str[1] =3D=3D 0x0=
8 && dpcd_caps->sink_dev_id_str[0] =3D=3D 0x03)
> +                               isPSRSUSupported =3D false;
>                         else if (dpcd_caps->psr_info.force_psrsu_cap =3D=
=3D 0x1)
>                                 isPSRSUSupported =3D true;
>                 }
> --
> 2.34.1
>

