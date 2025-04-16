Return-Path: <stable+bounces-132886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B3A90F1C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913351900BDF
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 23:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2932459CD;
	Wed, 16 Apr 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i00SQ7R0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2E235BFF;
	Wed, 16 Apr 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744844624; cv=none; b=KA4ZMFMLN8pplOiMH7y+WsYRrwIRblvAbkF+xhlUmRIyHppIBo550/LmNdnmqXYBQL8Qw3hfCfab/TGBreVMf3XGBvXV3C2zyXa4QSLMkO0DtS837vR6DDj4TMrtV5WDNl2yYUMXL1wyyPXweYDs75eIC9LWUcA7MN6k6AN2ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744844624; c=relaxed/simple;
	bh=VNFvhKhXN0Qvn+A8bsvpYKT3FduSF9/QTAv5zTXfLcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXklZ8hTcljHl7LKjEYu+79t28AChCZ8ezYon4UozxEBBbzkHNGIkAPqUiBZpawVv1Zn/6ewB4h+lpE9sORpSR8WzIrR39IxgFXqnVS8Of/7RQk63g+wqPdYunuFGBELG+uLBRvdYfXq8tZbLXfcrqchPiW8M8L3rpjTQwlaWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i00SQ7R0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7366d0f3231so23286b3a.1;
        Wed, 16 Apr 2025 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744844621; x=1745449421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ostym3POn+tDwNxEX6WFaI9UEXuL1OpvkJqy+12mMU=;
        b=i00SQ7R0Z3K1JDwwgXmrhNxoAN2JyXK24VuCAYLBu1OrkQ0xMMW30wNG9GCg8+95lq
         utKbUGvZvI7XfibYEKNggkf/u6lwO8i6oaVwqPRZ3U86geNqnjR+cFU3YaOnXiwN+IK/
         how9i00Kx9zcETYO4d7hoe3ziytj1BwFcEe/i1mxI4odpna7gy98zgWle975MMjjjXwv
         kSfKDwx9zrcGyTKQO26N2602pbnOrrsfbeMxlmG2zDrxJrgVtzUhr2FeMF3eanhaDwqz
         x+NrnVb0IsP2rAMdaermLpoIa11ufL26VYL49216ZOlXMmJ/mXzw7sVWZZp1A6yVpLuT
         kW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744844621; x=1745449421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ostym3POn+tDwNxEX6WFaI9UEXuL1OpvkJqy+12mMU=;
        b=oqX6ZzLcNQP/fC5ldqOv4SsPVvBas5O3rtGjoUlz5eJBn7osDrEqXFWYBHPdAYerIq
         /8XQ0yMlhhZAmeRS0XpdcwKrO/PfGb7HB56anlk/nkm0wCmP1lw9/AEDhLsukktGZL2k
         uxNOjcKclZ6/luc77CRXxWRX4e8okHUuix6mkXH31iSsuKPKJq5zMrjmRc/2XJubpnMX
         HqeU1QKPrLV25h9rgMjuWJgG6NsbTmvjD7bgsrtdJodxgqv+lUh7I1kxtbJ5JswAz/J7
         Mus+98zFhoCre7bTUVCn7D6MNy9G6plpoPjFZ24BTL7mjEinSJDx/oWbqy3u6MYTnjXG
         Yi3g==
X-Forwarded-Encrypted: i=1; AJvYcCWUbgFuTxhGw9vgqCcwPQ8dr54w17OxxrZ7I3YjyqOVmvtlr7bouHwQV12dKKSGwn03GNicm56w@vger.kernel.org, AJvYcCXLs8b/mxbNYMWVWw6K5Zn0rLSS0VG4K+4NaRXzrAve9wvcIBHJaPHnPAN90EyfwaUemROe7fp4VOHME6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0aTc+gImihmKVLffULvNaSIdGjxjA4BgBLUFRbftxeYdcSWx
	qq1XW2CPCYpaKixtEJVjQJrP/NOxt9yxcPG0kbg4v0WuQPGGk66M8IokLrXWjn6Adc0p9tEWj2b
	8dd55eRYGwnhjce+Gx6uSa3+2O1E=
X-Gm-Gg: ASbGnctsDYFlOP6xgFt2MjySv4JVKCqVRtu0tSqBMGmWszSeNC71tVCMsYUfiBF1vg5
	iCgsNo6UdA3u9FGxJlgzLugYJrb0pOepMdSfQdY3XF677+Q0utVan2o5j5rGL6CcDDAEvHvCxc2
	PJkylZVyh2RGPu1/nji45u5w==
X-Google-Smtp-Source: AGHT+IGOa4ocvRVCkDGhjbMq5SnR6XGbXrF8fWNqy1Gcvl7Bod2DV/rnRUCjS0bbLl2ieDH4Z8PBfpXOigf0ACktqxw=
X-Received: by 2002:a17:90b:4d10:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-3086eff2e34mr352727a91.7.1744844620624; Wed, 16 Apr 2025
 16:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415100813.3071-1-vulab@iscas.ac.cn>
In-Reply-To: <20250415100813.3071-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Apr 2025 19:03:28 -0400
X-Gm-Features: ATxdqUEd4OqKI8joWPatylhXv_zR-usWlc3-Ve2lxUTvKTVa6YjnRqrkdZVOOlE
Message-ID: <CADnq5_NiW9EmhEDCC1R=g7Q+DjjRxQGmQv6rLPk_9RZo3O=pfw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Add error
 check in fiji_populate_smc_boot_level()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:23=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> The return value of fiji_populate_smc_boot_level() is needs to be checked=
.
> An error handling is also needed to phm_find_boot_level() to reset the
> boot level when the function fails. A proper implementation can be found
> in tonga_populate_smc_boot_level().
>
> Fixes: dcaf3483ae46 ("drm/amd/pm/powerplay/smumgr/fiji_smumgr: Remove unu=
sed variable 'result'")
> Cc: stable@vger.kernel.org # v5.11+

I don't know that this is a fix per se so I don't think stable is appropria=
te.

This is probably ok, but TBH, I don't really remember how the pptables
were set up on these old chips and whether changing the current
behavior would actually fix or break anything.  I'd be more inclined
to just leave the logic as is lest something break.


> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Fix error code.
>
>  .../drm/amd/pm/powerplay/smumgr/fiji_smumgr.c | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> index 5e43ad2b2956..78ba22f249b2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> @@ -1600,19 +1600,30 @@ static int fiji_populate_smc_uvd_level(struct pp_=
hwmgr *hwmgr,
>  static int fiji_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
>                 struct SMU73_Discrete_DpmTable *table)
>  {
> +       int result =3D 0;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
>
>         table->GraphicsBootLevel =3D 0;
>         table->MemoryBootLevel =3D 0;
>
>         /* find boot level from dpm table */
> -       phm_find_boot_level(&(data->dpm_table.sclk_table),
> -                           data->vbios_boot_state.sclk_bootup_value,
> -                           (uint32_t *)&(table->GraphicsBootLevel));
> +       result =3D phm_find_boot_level(&(data->dpm_table.sclk_table),
> +                                    data->vbios_boot_state.sclk_bootup_v=
alue,
> +                                    (uint32_t *)&(table->GraphicsBootLev=
el));
> +       if (result !=3D 0) {
> +               table->GraphicsBootLevel =3D 0;
> +               pr_err("VBIOS did not find boot engine clock value in dep=
endency table. Using Graphics DPM level 0!\n");
> +               result =3D 0;
> +       }
>
> -       phm_find_boot_level(&(data->dpm_table.mclk_table),
> -                           data->vbios_boot_state.mclk_bootup_value,
> -                           (uint32_t *)&(table->MemoryBootLevel));
> +       result =3D phm_find_boot_level(&(data->dpm_table.mclk_table),
> +                                    data->vbios_boot_state.mclk_bootup_v=
alue,
> +                                    (uint32_t *)&(table->MemoryBootLevel=
));
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

