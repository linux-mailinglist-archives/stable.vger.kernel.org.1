Return-Path: <stable+bounces-132885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E2CA90F14
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 01:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AB65A1582
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 23:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B34235BFF;
	Wed, 16 Apr 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+YR9tV9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF391B0F23;
	Wed, 16 Apr 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844536; cv=none; b=UCkIsms25Uyp2hh1N3nFhn/LmGylLwclghldgLBoXxF1wbkJuPi0/QzyBraRCopIIGKt7rP0pkiCN0tgTj15CUzter6IRsfw1rHvNVG1oWxMkrmgFMmdhfsmvSr41hDceiDvhW/AT/OcOluN3ymsCBF1QbjSuWAxx8Hv7f+eDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844536; c=relaxed/simple;
	bh=PdUn8Yv/0aDVdO/SHheuTUSKUiJe6pNb4Q72uhUYI48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh4oyswWGZJKcSWjaxtCBBueyYvvbeT1OUY7AyqZW8gAKK8J0G4idHD9K59TwPFir0D9Zk/wGg1GwEUeD5TzZE3Nm9NxwBEJZgdF6pmOKhX0FyblKxTr7GVJCf7671+dfzLOUfEzSn+wZuJVzd391WzSWJ/tdtc02sWNQ87C9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+YR9tV9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736ac19918cso20508b3a.2;
        Wed, 16 Apr 2025 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744844534; x=1745449334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqTe+Ty3z3+ddmQAyRlIGIeZpUBjytRKMYY9HBbylrw=;
        b=Q+YR9tV9KDerqPuSpb+xPgqG1EZ4hZBDckNZfVKPtSaQbwfpyYDKnLmWtFSZI5mTld
         r2ertPabLYGkXQzk6Hw3dCvRAl1USo3zyW+LeIxN6m56f0nM70Yv9BN6KQCYppaV7uue
         9jbsJcJMPHdaOHBx6KDILUOG5BWm1wvql2mMssJc1O5vLNAqPeNcLEUs2YqSlDaH6Fox
         /cWlmNxBaAKmo9zo09do7Wkn30IR0Rafwetv4n8GEs08ONznf6gTSoStsFgQqAK9wrB4
         wcR+jy5gvdlcQBspqYf+XnbGq0V+1A4isI0pX6v4TIRLXs0dEb3aMHFmrlRrIOxnIH5z
         hNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744844534; x=1745449334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqTe+Ty3z3+ddmQAyRlIGIeZpUBjytRKMYY9HBbylrw=;
        b=qzj5cJtX7mso5HsZama6c1v/V+OJQrR4oYKGb/3oK4IOrY+KUVmJ3Q7LkIs+K79+GH
         x9fSJYuDehjN2rqC2m9TgvAcmjvps3iT+7IyF9gcORehA2eXMha8OPVczgdV64g6Id+a
         w3ZOfYpcmdsen0/1FItnykrY2/Kj0mJaFuJZyXcD9BvjmBVfC66NUwgPEcVg/551qMZb
         odBZD/xzwX7zj1TQ6Masoq6RO4dPa68k2YO7CUaA5u85nvODQ0mUiOr1VFFEcjxsRav2
         CLyfUyiQl2ymMcmO2WBh6dbBmXRoSi52srosBbpdQRFqJyjqf7Tw+6zykrQo9edAAu5Z
         8AIg==
X-Forwarded-Encrypted: i=1; AJvYcCWG8uCxI3X1zFq45MQNn5awVXNDk56GF0mS4LhzCmFUuZMD3tnxHIAUVchFFiFY4xaHFZCJh/sf/GtaMac=@vger.kernel.org, AJvYcCWNmRAg7Z4bxTBIoqDyv2wW+kNQ+sALdmu6wE+lGDPsJv8ziW2J5mtwgITyO00neEXr5zCfge8b@vger.kernel.org
X-Gm-Message-State: AOJu0YzZe+SF65PiX48q6NwiAIBb1dtBrqihsTQdA7/VyE0jQbZRLtyN
	T0k86lcE3Tvug/5kkcNoijo4nApKGXXFbCIluzAn2DI8AuSkmVxPYpF1vy/t9TtBXSuBQn/y7hb
	GrQTmN/nfGZ/J8hcb8MEOE2eH6kg=
X-Gm-Gg: ASbGncuS3cE0UfPFzbbZwg2mUOOpLHG48qNlRUO13m4t/mkOJtcVDYmd3YYCyOy7CZ8
	FqoGwCqHzxJD0fyycwRCdilTnxYE5cEsXcPFDH4kmNXEEEVTtRYrnhqWVS8K7yu3bCHMIRC6s5e
	gBiVc+Wih2B6PmEoTuG5KQvQXX3MdFGXOf
X-Google-Smtp-Source: AGHT+IHaS1bY31CQcgrxhxR+ofsJjVnuVFQYhCiG9dkrzbmwmtfrPhBROuBFGksgadbGj5vQeORbSzp7QnfZYRRVwDc=
X-Received: by 2002:a17:902:d2cb:b0:22c:336f:cb5c with SMTP id
 d9443c01a7336-22c41200358mr5210055ad.6.1744844533623; Wed, 16 Apr 2025
 16:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415115601.3238-1-vulab@iscas.ac.cn>
In-Reply-To: <20250415115601.3238-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Apr 2025 19:02:02 -0400
X-Gm-Features: ATxdqUE6UyN97V93fs49qKRwAvpsbbW-l0GWDGUMvi0e8zP-zEuL0dwIz0J5DKo
Message-ID: <CADnq5_N05vb5awWxfGzHJ4yBCE-89feKfmkOY96+6b38=R4Daw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/powerplay/smumgr/vegam_smumgr: Fix error
 handling in vegam_populate_smc_boot_level()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 8:33=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> In vegam_populate_smc_boot_level(), the return value of
> phm_find_boot_level() is 0 or negative error code and the
> "if (result)" branch statement will never run into the true
> branch. Besides, this will skip setting the voltages later
> below. Returning early may break working devices.
>
> Add an error handling to phm_find_boot_level() to reset the
> boot level when the function fails. A proper implementation
> can be found in tonga_populate_smc_boot_level().
>
> Fixes: 4a1132782200 ("drm/amd/powerplay: return errno code to caller when=
 error occur")
> Cc: stable@vger.kernel.org # v5.6+

I don't know that this is a fix per se so I don't think stable is appropria=
te.

This is probably ok, but TBH, I don't really remember how the pptables
were set up on these old chips and whether changing the current
behavior would actually fix or break anything.  I'd be more inclined
to just leave the logic as is lest something break.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../drm/amd/pm/powerplay/smumgr/vegam_smumgr.c    | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> index 34c9f59b889a..c68dd12b858a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> @@ -1374,15 +1374,20 @@ static int vegam_populate_smc_boot_level(struct p=
p_hwmgr *hwmgr,
>         result =3D phm_find_boot_level(&(data->dpm_table.sclk_table),
>                         data->vbios_boot_state.sclk_bootup_value,
>                         (uint32_t *)&(table->GraphicsBootLevel));
> -       if (result)
> -               return result;
> +       if (result !=3D 0) {
> +               table->GraphicsBootLevel =3D 0;
> +               pr_err("VBIOS did not find boot engine clock value in dep=
endency table. Using Graphics DPM level 0!\n");
> +               result =3D 0;
> +       }
>
>         result =3D phm_find_boot_level(&(data->dpm_table.mclk_table),
>                         data->vbios_boot_state.mclk_bootup_value,
>                         (uint32_t *)&(table->MemoryBootLevel));
> -
> -       if (result)
> -               return result;
> +       if (result !=3D 0) {
> +               table->MemoryBootLevel =3D 0;
> +               pr_err("VBIOS did not find boot engine clock value in dep=
endency table. Using Memory DPM level 0!\n");
> +               result =3D 0;
> +       }
>
>         table->BootVddc  =3D data->vbios_boot_state.vddc_bootup_value *
>                         VOLTAGE_SCALE;
> --
> 2.42.0.windows.2
>

