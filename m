Return-Path: <stable+bounces-166701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E3B1C77F
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B712C7B0600
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526E26B749;
	Wed,  6 Aug 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwA2KtcQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1F23CB
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489875; cv=none; b=GW2hyYAu+VwBYS6x5MYtZyk/1JhixEFVYy7FfJMSMFP6z01BX0mLQw6Q1gpkh7kFDPWaAURDRcDrIRY8T2TxRulUSQcIqmAK4pVCi1Y30aqp5JZYDY7DN+rLLBFGkO2n8J2YwoEu3E+g/RrNhfK8u/OCBdHsfyl5BI+eqx4wFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489875; c=relaxed/simple;
	bh=49o6N+sop0ffCg85NSxyiNYdc9sCxq9IlDR/lqO0i0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHmigrSHWzBuHJJmDriI+a7wP1jFN11z6WDqMmspDIX0zX4wfQwNsk0HyvMMygooYVxTu+dRHUJJOi16qVJzgBsnhnwAsKRp3jsr3w1t6C5fg2hTBnWcvzX3Y2X8vjxYgzYOZKyrnyohEbSCKOY8yuvCLNcbAXirOm1/mnmLgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwA2KtcQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24049e42f37so6160945ad.2
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754489873; x=1755094673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3LPY/81KXieUVYiFG3PY1qu1vLcGv0lEqSbz8J5vLI=;
        b=ZwA2KtcQx49JC2CgBm/7ovLqWRl3Us/LwWuiofNZmFuKMlonNi/4xofbGqYfIRgb8d
         wa4LoJFJ1f9GH81/EPSu+EOFceu4aXkw9YKXUvhyztLfC1yLsgxiy39bkYXYsThnGSIf
         SuMltCpdAiGwt6RMl8j1mvPmqNk63bHw1FPr6Z4RRtr9F/tgJYQJHW4XtlfEwb2Y2GxK
         NUBViqmvmIi0rgCWq05qxDalnNaPzB9+FxvdkiBSjXxmvQtau69VhuU59+kr6Ao8LSrM
         KGlC0VykThDH1wFSUr1eI2j87iWLY/KHu3Y+OJci1byJeeGigSlhabJXNyT42eSvyhk4
         2fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489873; x=1755094673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3LPY/81KXieUVYiFG3PY1qu1vLcGv0lEqSbz8J5vLI=;
        b=LjchGNgXYtiCajVx5LWi0/rvobrAPO05oXd3EDzdwwPI+6g+XW3JNCs+fvZUNd5iJf
         5XFDNBzBt66jmR8ZzuemNFwKTOjGOG1Qau0IVHY6kxqopBKrk6By1zD5c9gHB1chF3/V
         39NpB61JB7CHsIK1fiFRtEm2xEMKCJEjyD+hi8vHU4OsZPmoWvl7xT90jJFPVzbh/pD6
         yXRND/MfWv2KGgv6KL4PEm8gWA0fvAAhhth7J6W3g2ibTW7VXTHew0dPLiCt9S1BNf33
         jJfcEJ79EevOC6R9NNMCxerImR5VQbzFwtBgMe1awF0SREgTYlkpwuUhM1mechmLVFjo
         HPlA==
X-Forwarded-Encrypted: i=1; AJvYcCXup/YrFpDdNm3AmkkuTpGCLHUJp2HxjC41Qrrdze0lgOX+cDTECMGy2JtjiXEaHBTWcFr549c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQcgV0FIeudA5SS4wjWdK0TTPXCBh7IyOiTKqYP0gKry3D80w
	TP/Q2wcB+2CNbAizc8fH26p/B5f1iXD5qrhtpZ4M+3R0mKneh+kTEtMJ+Ji+rLTw4+14lLz33YD
	cVNIY043Wzg8BM7hqE7CRBe5hGudfoi0=
X-Gm-Gg: ASbGnctPMIB1G+p0BEVwqroXcvuTJNNyeo/G908Uq8H/U3q/Igfk8SzqSoTgAe9rvJx
	Ty7tTyuAU5xYAaWM9sOLFMWrBz27tDh3NSWpl3gZHxMnq0nzat+rhm/t7XrvFKNzcwB9CyacgnA
	Z4b369sNUcA1VB6OF5GqkGBUXK2BFOx9iqXJZUx0xV5osJjh4P7RorLLbkMzqpEM7o6tHk9pXvx
	QDKxXZE
X-Google-Smtp-Source: AGHT+IEN8SEaZvlVUbHBJqpO/+smtaHmp/81y33jQCaqZcY6BwNdZq6aCdw91kNZLRtdwnkm5npEeUOoLN8Pt1Xl3AU=
X-Received: by 2002:a17:902:d484:b0:240:b417:e197 with SMTP id
 d9443c01a7336-2429f2e1570mr25178115ad.2.1754489872659; Wed, 06 Aug 2025
 07:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730155900.22657-1-alexander.deucher@amd.com> <CADnq5_NtBWyQozzv2wih6cp7Ado+nBf7hd_N+oGXsd0H_JadKg@mail.gmail.com>
In-Reply-To: <CADnq5_NtBWyQozzv2wih6cp7Ado+nBf7hd_N+oGXsd0H_JadKg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Aug 2025 10:17:40 -0400
X-Gm-Features: Ac12FXzHrf7AS93DJl29_XDnXeiA8pOhM6VT7nJdi1YZ2A4BfrCtHMyxcEo3Lmk
Message-ID: <CADnq5_M-CoMUr6dQbOMQLa6Td0i1m6UoUayEWZz8qofCj3d4zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping again?  This fixes a regression.

Alex

On Mon, Aug 4, 2025 at 10:16=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> Alex
>
> On Wed, Jul 30, 2025 at 12:18=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >
> > We only need the fw based discovery table for sysfs.  No
> > need to parse it.  Additionally parsing some of the board
> > specific tables may result in incorrect data on some boards.
> > just load the binary and don't parse it on those boards.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
> > Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip =
discovery")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
> >  2 files changed, 41 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index efe98ffb679a4..b2538cff222ce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct=
 amdgpu_device *adev)
> >
> >         adev->firmware.gpu_info_fw =3D NULL;
> >
> > -       if (adev->mman.discovery_bin)
> > -               return 0;
> > -
> >         switch (adev->asic_type) {
> >         default:
> >                 return 0;
> > @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct=
 amdgpu_device *adev)
> >                 chip_name =3D "arcturus";
> >                 break;
> >         case CHIP_NAVI12:
> > +               if (adev->mman.discovery_bin)
> > +                       return 0;
> >                 chip_name =3D "navi12";
> >                 break;
> >         }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 81b3443c8d7f4..27bd7659961e8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgp=
u_device *adev)
> >
> >         switch (adev->asic_type) {
> >         case CHIP_VEGA10:
> > -       case CHIP_VEGA12:
> > -       case CHIP_RAVEN:
> > -       case CHIP_VEGA20:
> > -       case CHIP_ARCTURUS:
> > -       case CHIP_ALDEBARAN:
> > -               /* this is not fatal.  We have a fallback below
> > -                * if the new firmwares are not present. some of
> > -                * this will be overridden below to keep things
> > -                * consistent with the current behavior.
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> >                  */
> > -               r =3D amdgpu_discovery_reg_base_init(adev);
> > -               if (!r) {
> > -                       amdgpu_discovery_harvest_ip(adev);
> > -                       amdgpu_discovery_get_gfx_info(adev);
> > -                       amdgpu_discovery_get_mall_info(adev);
> > -                       amdgpu_discovery_get_vcn_info(adev);
> > -               }
> > -               break;
> > -       default:
> > -               r =3D amdgpu_discovery_reg_base_init(adev);
> > -               if (r) {
> > -                       drm_err(&adev->ddev, "discovery failed: %d\n", =
r);
> > -                       return r;
> > -               }
> > -
> > -               amdgpu_discovery_harvest_ip(adev);
> > -               amdgpu_discovery_get_gfx_info(adev);
> > -               amdgpu_discovery_get_mall_info(adev);
> > -               amdgpu_discovery_get_vcn_info(adev);
> > -               break;
> > -       }
> > -
> > -       switch (adev->asic_type) {
> > -       case CHIP_VEGA10:
> > +               amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> >                 adev->gmc.num_umc =3D 4;
> > @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 0)=
;
> >                 break;
> >         case CHIP_VEGA12:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> >                 adev->gmc.num_umc =3D 4;
> > @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 1)=
;
> >                 break;
> >         case CHIP_RAVEN:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 1;
> >                 adev->vcn.num_vcn_inst =3D 1;
> > @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 }
> >                 break;
> >         case CHIP_VEGA20:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 vega20_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> >                 adev->gmc.num_umc =3D 8;
> > @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 1, 0)=
;
> >                 break;
> >         case CHIP_ARCTURUS:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 arct_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 8;
> >                 adev->vcn.num_vcn_inst =3D 2;
> > @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[UVD_HWIP][1] =3D IP_VERSION(2, 5, 0);
> >                 break;
> >         case CHIP_ALDEBARAN:
> > +               /* This is not fatal.  We only need the discovery
> > +                * binary for sysfs.  We don't need it for a
> > +                * functional system.
> > +                */
> > +               amdgpu_discovery_init(adev);
> >                 aldebaran_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 5;
> >                 adev->vcn.num_vcn_inst =3D 2;
> > @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 1, 0)=
;
> >                 break;
> >         default:
> > +               r =3D amdgpu_discovery_reg_base_init(adev);
> > +               if (r) {
> > +                       drm_err(&adev->ddev, "discovery failed: %d\n", =
r);
> > +                       return r;
> > +               }
> > +
> > +               amdgpu_discovery_harvest_ip(adev);
> > +               amdgpu_discovery_get_gfx_info(adev);
> > +               amdgpu_discovery_get_mall_info(adev);
> > +               amdgpu_discovery_get_vcn_info(adev);
> >                 break;
> >         }
> >
> > --
> > 2.50.1
> >

