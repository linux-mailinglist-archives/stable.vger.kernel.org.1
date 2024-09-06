Return-Path: <stable+bounces-73798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCE96F7A2
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2847A2843D1
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53D1D27B7;
	Fri,  6 Sep 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/5avGSw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF31D1F73;
	Fri,  6 Sep 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634966; cv=none; b=jCePzC2UAZBjKq7d3OpQWAqaTUu/1k2hoUWqf9kL9t+I+8q09FEJd+Wcf6FBm2ZcLlE5GvjmoyfxlLBDmJkDjD6WPcf6e5dk82pXYaYDYdBwWPL+ev/EHbi5zHv2UX+A6ZUNlXE88Sn9hjCnICzfJ7Tlr38cm//S5Pnwcp8ZJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634966; c=relaxed/simple;
	bh=/jyOlJRohx+VGTSbr4Y6Q1/ZaLB+Z6DoeNxKscVVJiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suN/DL5Eh3lvBrhnL3u0qXNZP3IizZEQZLeFcDebVbe+hCtyxMdGZPXX0vIJ5ubruwXFX0mdcdCYqtMwcIoqmLVTphjjbgaT5NP2jfX/Fh8GvZX3GpZrWTSxm1YGeovGHQl6HzRRReBiecv63Hs9CCAG5XAnGaHGZz7J3XHKgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/5avGSw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-78f86e56b4cso214362a12.3;
        Fri, 06 Sep 2024 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725634964; x=1726239764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF/y2A4EOD7AN3/RYLZIn961CP/eFEWOruxjVecjTmw=;
        b=N/5avGSwPKnreZEQS+Ju8vmc599HYSUKhI6RCCVQG09fmkzsSlCuzZwhx60cW1Stl+
         MrrFDSUlsiyAU5AKfWdyjh25PUE+uzVeUVd94ICMspHHekrdwamm0Tokzb7DlQit8AN6
         gbWQViQOhdaWBDX0awB+tvCS8D22BmeMuulemJHnI98nyNbcXjOshF7ZxU+eoCHOZmPg
         uw7m2GXqV8ZlpOnrrjx/0B0ePbJ5YFOlF+HB/nZPf19EKdpmN4mXgfi9s5VUygWXjxAG
         n9ufUhsFNoum2QuTKV8XIH7Arshq0KordRZtqXVcswL8DZfAUxQtzqGHur+BBw/EZp38
         Q2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634964; x=1726239764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF/y2A4EOD7AN3/RYLZIn961CP/eFEWOruxjVecjTmw=;
        b=ap73Pj3B19fjfuyBeTqw49wTSkcNLCAdPFXanwLZOIWRx2YGvt59pKbjohYoNhdh0X
         gJuyoa9ajRUsUeHirBVls65LEh3hXEjddcjL7sINgayMLLNeaBFvO1aXpHhfqgyPv4oY
         XtEvy2iAjAU/MtgCg3Evv4Uc3Vb8oamPWi5p9ht6GxFE6xTySQF5z/JRc2VXzImzL8Wa
         2j2jg9CzEH8Wd9RB2BGnza66KGisBtTUYOx4rJNG3dVce5igjjJCW/kRKaCpyoAXfCAd
         wvEjFHZRgFbxzltDRqR6RlDZKP35bYI+E2n4gsru1gAUsbfxL2gTassD+rvNlehPS+rk
         DKaw==
X-Forwarded-Encrypted: i=1; AJvYcCWwrVz0HpulLty/Imxf9umgRyINhLojGYFOuSIybWUtjHngFzGTw/pAvHhCBwKOcnZKssE5Um6Wkw7jiBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1j4Gro9pAivYij9BE93ZfuV3pAeRpnf91g+DwkhM+5zYk4fyI
	+gK+QDZgzEYrZKV0sk3yABUhah3ESSo8W1SG2LmWbha7ZPgQRDLiYqJeAeLjPNOtqept757Aiwe
	MP1BS/3QrI3JwDQA6m7lFOUVhNU6wcA==
X-Google-Smtp-Source: AGHT+IFUyTc2msw9pBuDinPebsrgH2WgTVb3aopL/b6zxirXk5TlrlJwgcDG34rx6p5wEwYoay4kl+oDdVtZtxl+tQk=
X-Received: by 2002:a17:902:f0cb:b0:205:60f5:4c0 with SMTP id
 d9443c01a7336-206f0669d0emr15345825ad.9.1725634964083; Fri, 06 Sep 2024
 08:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903045809.5025-1-mukul.sikka@broadcom.com>
 <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com> <CAG99D9Jss=h5aVLDq0tkDjfZgGUbrNV1gqwcw631RbwCiPVqNg@mail.gmail.com>
In-Reply-To: <CAG99D9Jss=h5aVLDq0tkDjfZgGUbrNV1gqwcw631RbwCiPVqNg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 11:02:32 -0400
Message-ID: <CADnq5_NWX7u=S+jrC8YA6fJxN7GXpSN+kqsQieqphdOz2HT6EA@mail.gmail.com>
Subject: Re: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference
 for vega10_hwmgr
To: Mukul Sikka <mukul.sikka@broadcom.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, evan.quan@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, 
	daniel@ffwll.ch, Jun.Ma2@amd.com, kevinyang.wang@amd.com, sashal@kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	Bob Zhou <bob.zhou@amd.com>, Tim Huang <Tim.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:50=E2=80=AFAM Mukul Sikka <mukul.sikka@broadcom.co=
m> wrote:
>
> On Fri, Sep 6, 2024 at 12:05=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Tue, Sep 3, 2024 at 5:53=E2=80=AFAM sikkamukul <mukul.sikka@broadcom=
.com> wrote:
> > >
> > > From: Bob Zhou <bob.zhou@amd.com>
> > >
> > > [ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]
> > >
> > > Check return value and conduct null pointer handling to avoid null po=
inter dereference.
> > >
> > > Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> > > Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
> >
> > Just out of curiosity, are you actually seeing an issue?  This and a
> > lot of the other recent NULL check patches are just static checker
> > fixes.  They don't actually fix a known issue.
> >
> No, according to the description of this patch and CVE-2024-43905.
> It seems to be applicable to LTS.

I don't know that this is really CVE material, but oh well.  I'm not
sure if it's actually possible to hit this in practice.

Alex

>
> - Mukul
>
> > > ---
> > >  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 ++++++++++++++++-=
--
> > >  1 file changed, 26 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/=
drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > > index 10678b519..304874cba 100644
> > > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> > > @@ -3391,13 +3391,17 @@ static int vega10_find_dpm_states_clocks_in_d=
pm_table(struct pp_hwmgr *hwmgr, co
> > >         const struct vega10_power_state *vega10_ps =3D
> > >                         cast_const_phw_vega10_power_state(states->pne=
w_state);
> > >         struct vega10_single_dpm_table *sclk_table =3D &(data->dpm_ta=
ble.gfx_table);
> > > -       uint32_t sclk =3D vega10_ps->performance_levels
> > > -                       [vega10_ps->performance_level_count - 1].gfx_=
clock;
> > >         struct vega10_single_dpm_table *mclk_table =3D &(data->dpm_ta=
ble.mem_table);
> > > -       uint32_t mclk =3D vega10_ps->performance_levels
> > > -                       [vega10_ps->performance_level_count - 1].mem_=
clock;
> > > +       uint32_t sclk, mclk;
> > >         uint32_t i;
> > >
> > > +       if (vega10_ps =3D=3D NULL)
> > > +               return -EINVAL;
> > > +       sclk =3D vega10_ps->performance_levels
> > > +                       [vega10_ps->performance_level_count - 1].gfx_=
clock;
> > > +       mclk =3D vega10_ps->performance_levels
> > > +                       [vega10_ps->performance_level_count - 1].mem_=
clock;
> > > +
> > >         for (i =3D 0; i < sclk_table->count; i++) {
> > >                 if (sclk =3D=3D sclk_table->dpm_levels[i].value)
> > >                         break;
> > > @@ -3704,6 +3708,9 @@ static int vega10_generate_dpm_level_enable_mas=
k(
> > >                         cast_const_phw_vega10_power_state(states->pne=
w_state);
> > >         int i;
> > >
> > > +       if (vega10_ps =3D=3D NULL)
> > > +               return -EINVAL;
> > > +
> > >         PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps)=
,
> > >                         "Attempt to Trim DPM States Failed!",
> > >                         return -1);
> > > @@ -4828,6 +4835,9 @@ static int vega10_check_states_equal(struct pp_=
hwmgr *hwmgr,
> > >
> > >         psa =3D cast_const_phw_vega10_power_state(pstate1);
> > >         psb =3D cast_const_phw_vega10_power_state(pstate2);
> > > +       if (psa =3D=3D NULL || psb =3D=3D NULL)
> > > +               return -EINVAL;
> > > +
> > >         /* If the two states don't even have the same number of perfo=
rmance levels they cannot be the same state. */
> > >         if (psa->performance_level_count !=3D psb->performance_level_=
count) {
> > >                 *equal =3D false;
> > > @@ -4953,6 +4963,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr *=
hwmgr, uint32_t value)
> > >                 return -EINVAL;
> > >
> > >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > > +       if (vega10_ps =3D=3D NULL)
> > > +               return -EINVAL;
> > >
> > >         vega10_ps->performance_levels
> > >         [vega10_ps->performance_level_count - 1].gfx_clock =3D
> > > @@ -5004,6 +5016,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *=
hwmgr, uint32_t value)
> > >                 return -EINVAL;
> > >
> > >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > > +       if (vega10_ps =3D=3D NULL)
> > > +               return -EINVAL;
> > >
> > >         vega10_ps->performance_levels
> > >         [vega10_ps->performance_level_count - 1].mem_clock =3D
> > > @@ -5239,6 +5253,9 @@ static void vega10_odn_update_power_state(struc=
t pp_hwmgr *hwmgr)
> > >                 return;
> > >
> > >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > > +       if (vega10_ps =3D=3D NULL)
> > > +               return;
> > > +
> > >         max_level =3D vega10_ps->performance_level_count - 1;
> > >
> > >         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> > > @@ -5261,6 +5278,9 @@ static void vega10_odn_update_power_state(struc=
t pp_hwmgr *hwmgr)
> > >
> > >         ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) +=
 hwmgr->ps_size * (hwmgr->num_ps - 1));
> > >         vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> > > +       if (vega10_ps =3D=3D NULL)
> > > +               return;
> > > +
> > >         max_level =3D vega10_ps->performance_level_count - 1;
> > >
> > >         if (vega10_ps->performance_levels[max_level].gfx_clock !=3D
> > > @@ -5451,6 +5471,8 @@ static int vega10_get_performance_level(struct =
pp_hwmgr *hwmgr, const struct pp_
> > >                 return -EINVAL;
> > >
> > >         ps =3D cast_const_phw_vega10_power_state(state);
> > > +       if (ps =3D=3D NULL)
> > > +               return -EINVAL;
> > >
> > >         i =3D index > ps->performance_level_count - 1 ?
> > >                         ps->performance_level_count - 1 : index;
> > > --
> > > 2.39.4
> > >

