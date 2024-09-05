Return-Path: <stable+bounces-73658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A196E21E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3FB1F228CF
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E27186608;
	Thu,  5 Sep 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3fyykbH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAA183CDB;
	Thu,  5 Sep 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561358; cv=none; b=muO0VC+w9D0m6L9URcixDMDL8XD8kzeYMpHrJJkaRIm9k/k2uzLOdCqxJwTTer9G7nFCnPqZF82wxmvbvZ9Vg9Acv4DlGl7/mZI5rglmnQIRgX8LIQUntRM5y96hdJDts58D8R31cFriR9hizRx48nvZD3jBKmVDoSAXHCVQcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561358; c=relaxed/simple;
	bh=SS7e2WhP5CYCBXgPFLeDS11yETlLoMDf+52jCqNWtV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzPk6FmRn8zwljafkYXJui3TZIjNy1RXz2iAdja03uRw+ZZRbM/H+2N0gjfRE1zXsQO/qnaMQzX6X0Vq266jqdVtqXHYSerb9XlDs6KT2RIlA2W0osQ9LjV777L+5XnnZmGFoJyD4exJfJCuIhdpPH2/wgBFF3/AZ83qbNZbAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3fyykbH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20212f701c9so603305ad.1;
        Thu, 05 Sep 2024 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725561356; x=1726166156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAtDj4jgFho2b/8hV7Bo6K1tm3khS3fSEDAFzXGf8h0=;
        b=Q3fyykbHPaO8HGXA1MPsffye/gFzyzLB0ufER8cWh5zuDbpwuOGs2p9MriD9Rxe7J4
         N5X3NgTXx43/qYlx5NlBn8t5SaRe1owPtIDM9ARJsu7D4wdybDZ0niScc4hFb+mj/55R
         E71T0Osqc56MSBmHj6oa7r8m5cXHa1vMMVbSEovJuOQQ9TB/l1gB2uPRwKUH5HPOhyh1
         BaG9wCO00fP8/LOEe5bUODM5M+iLapCU1ATX5G9MMH87JCojh9xNeQP/sqHIAxdiLYfY
         XJxcDe2VyY0yXC9n/i27YtH7qtsUe3LXcmaClE3fiBMGXU+uX3XvK0Pn72435SR5OnuK
         lo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725561356; x=1726166156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAtDj4jgFho2b/8hV7Bo6K1tm3khS3fSEDAFzXGf8h0=;
        b=VCNtb3R8OopjFgySzr+ZcfCVdF3BDz6PZX5FO5wTYKSXy8KpVqhADSvqn23y3/YMGp
         AcJvj+BJztZwnbrwSyGdZZQxcOmsD73SCHWJvkK4yovyTABZIl5zwzk0L6/4DIdtOaKo
         83IehQTD5eLlGs6TWb8g6whfAYUoNm72BTGYazq8P43i9pM6pUIIOEu2ZTQbDNCSb4eG
         26Cg92NLnIaAGA2o6tHqvgffvmM/tsyXXiWk7va69fRdDUw/+CG/48g/KgZzumysZuPV
         w8dznlQv9HBCmf58trmCXxyjapH7tRLP4h62chxKsbmK78fjzUEe7FNWlRPW4OLhMuL3
         sPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXonU4+ZB+n54eFVbSOamFMjukbAnvlAOaBXeMXSb7DejfFwoawYLWaB50OUANQUgbfVIDHn1gkN4wOOPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cYorgcfjhwQssLSalVrMv8fAXCCeAoox3xpjuLW6FdD0kg2y
	8jOaJRRTdEvvUShbPQhtmpg4PnF/H4rx6rmVv/Lh9NuqPrdihSa26mQx1tIpfD1YLGKD+OprirC
	izto/3p94N1d22rKUnBVfX94jtbA=
X-Google-Smtp-Source: AGHT+IHM5V1REwdJI3eVT3T6Wdm5s+xxUU+LN3v/BUr9HdnK+Dg6FB4m7fzcSNKHejJ3hHksejbzQbzD8bSPE3UC2eY=
X-Received: by 2002:a17:903:1cc:b0:206:aa07:b54 with SMTP id
 d9443c01a7336-206f0357b83mr705ad.0.1725561356205; Thu, 05 Sep 2024 11:35:56
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903045809.5025-1-mukul.sikka@broadcom.com>
In-Reply-To: <20240903045809.5025-1-mukul.sikka@broadcom.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Sep 2024 14:35:44 -0400
Message-ID: <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com>
Subject: Re: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference
 for vega10_hwmgr
To: sikkamukul <mukul.sikka@broadcom.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, evan.quan@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, 
	daniel@ffwll.ch, Jun.Ma2@amd.com, kevinyang.wang@amd.com, sashal@kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	Bob Zhou <bob.zhou@amd.com>, Tim Huang <Tim.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:53=E2=80=AFAM sikkamukul <mukul.sikka@broadcom.com=
> wrote:
>
> From: Bob Zhou <bob.zhou@amd.com>
>
> [ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]
>
> Check return value and conduct null pointer handling to avoid null pointe=
r dereference.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>

Just out of curiosity, are you actually seeing an issue?  This and a
lot of the other recent NULL check patches are just static checker
fixes.  They don't actually fix a known issue.

Alex

> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 10678b519..304874cba 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3391,13 +3391,17 @@ static int vega10_find_dpm_states_clocks_in_dpm_t=
able(struct pp_hwmgr *hwmgr, co
>         const struct vega10_power_state *vega10_ps =3D
>                         cast_const_phw_vega10_power_state(states->pnew_st=
ate);
>         struct vega10_single_dpm_table *sclk_table =3D &(data->dpm_table.=
gfx_table);
> -       uint32_t sclk =3D vega10_ps->performance_levels
> -                       [vega10_ps->performance_level_count - 1].gfx_cloc=
k;
>         struct vega10_single_dpm_table *mclk_table =3D &(data->dpm_table.=
mem_table);
> -       uint32_t mclk =3D vega10_ps->performance_levels
> -                       [vega10_ps->performance_level_count - 1].mem_cloc=
k;
> +       uint32_t sclk, mclk;
>         uint32_t i;
>
> +       if (vega10_ps =3D=3D NULL)
> +               return -EINVAL;
> +       sclk =3D vega10_ps->performance_levels
> +                       [vega10_ps->performance_level_count - 1].gfx_cloc=
k;
> +       mclk =3D vega10_ps->performance_levels
> +                       [vega10_ps->performance_level_count - 1].mem_cloc=
k;
> +
>         for (i =3D 0; i < sclk_table->count; i++) {
>                 if (sclk =3D=3D sclk_table->dpm_levels[i].value)
>                         break;
> @@ -3704,6 +3708,9 @@ static int vega10_generate_dpm_level_enable_mask(
>                         cast_const_phw_vega10_power_state(states->pnew_st=
ate);
>         int i;
>
> +       if (vega10_ps =3D=3D NULL)
> +               return -EINVAL;
> +
>         PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
>                         "Attempt to Trim DPM States Failed!",
>                         return -1);
> @@ -4828,6 +4835,9 @@ static int vega10_check_states_equal(struct pp_hwmg=
r *hwmgr,
>
>         psa =3D cast_const_phw_vega10_power_state(pstate1);
>         psb =3D cast_const_phw_vega10_power_state(pstate2);
> +       if (psa =3D=3D NULL || psb =3D=3D NULL)
> +               return -EINVAL;
> +
>         /* If the two states don't even have the same number of performan=
ce levels they cannot be the same state. */
>         if (psa->performance_level_count !=3D psb->performance_level_coun=
t) {
>                 *equal =3D false;
> @@ -4953,6 +4963,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *hwmg=
r, uint32_t value)
>                 return -EINVAL;
>
>         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +       if (vega10_ps =3D=3D NULL)
> +               return -EINVAL;
>
>         vega10_ps->performance_levels
>         [vega10_ps->performance_level_count - 1].gfx_clock =3D
> @@ -5004,6 +5016,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmg=
r, uint32_t value)
>                 return -EINVAL;
>
>         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +       if (vega10_ps =3D=3D NULL)
> +               return -EINVAL;
>
>         vega10_ps->performance_levels
>         [vega10_ps->performance_level_count - 1].mem_clock =3D
> @@ -5239,6 +5253,9 @@ static void vega10_odn_update_power_state(struct pp=
_hwmgr *hwmgr)
>                 return;
>
>         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +       if (vega10_ps =3D=3D NULL)
> +               return;
> +
>         max_level =3D vega10_ps->performance_level_count - 1;
>
>         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> @@ -5261,6 +5278,9 @@ static void vega10_odn_update_power_state(struct pp=
_hwmgr *hwmgr)
>
>         ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) + hwm=
gr->ps_size * (hwmgr->num_ps - 1));
>         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +       if (vega10_ps =3D=3D NULL)
> +               return;
> +
>         max_level =3D vega10_ps->performance_level_count - 1;
>
>         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> @@ -5451,6 +5471,8 @@ static int vega10_get_performance_level(struct pp_h=
wmgr *hwmgr, const struct pp_
>                 return -EINVAL;
>
>         ps =3D cast_const_phw_vega10_power_state(state);
> +       if (ps =3D=3D NULL)
> +               return -EINVAL;
>
>         i =3D index > ps->performance_level_count - 1 ?
>                         ps->performance_level_count - 1 : index;
> --
> 2.39.4
>

