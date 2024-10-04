Return-Path: <stable+bounces-81131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEBE9910F8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA4AB222BB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D644155C98;
	Fri,  4 Oct 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWHCqexX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AB1339B1
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075146; cv=none; b=D/TsJjqcIS6zCuiNcpwjmU+fBQ1jCbbBCFOfSKVI2zLdMWtEFJYsdZINAewUqobtRvgggOen1e6CXQ90bSb9lgjCIUwM3FOV6+0Ap8b6cVDO/7yBhQir9Fnp/1gUo/LO3lOZzPOrnOHj3GX/x/FMzCymMMIL3M+mNXBn8r5c7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075146; c=relaxed/simple;
	bh=NxWbd0iMoFp+rsar3BfP2jSSxE/kVAP47pnd7MwPpjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3IUO8H07nb59LfcBgXEH2Y9isBUl5/SczIvg2bcr7I3uZOT4ws2y5yRnv90h/dwk7ZdS8++X+pzmsdlAZ9hH7RyOD893iDuVoMeFYRsAAgHoL/YvpzICy80W2C4gp40P7qVLXbxSlryXZDoHXcdvHKgRsjNGn2Gr3QjVK3Fv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWHCqexX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71dec222033so125129b3a.0
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728075144; x=1728679944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcGB3qPTIyAq2lyv3gVDHDXN+w1J2sfilEkLN6A+gPs=;
        b=iWHCqexX/m+JkRKPBV0hexFLqRHs0iH6Gf3ifVich3Vsy/uXkY6owiM0f6UtBop8F6
         9apCafGdNjv6y8pd5MYJ0o526sUxajbXuIACuy6+UUXkl4/I+k0HQ98SaHXmAtHItwto
         MHUlLeM51HRfyvE5Naa9l3qeaQg69YZzkXrwmZ3aK37bCDI1D3ys+x/J8jS2NgoH/n9v
         dAgKJENYFYAYOxIM249weGUd7rxYtZp9C+oNppXxDc0tRPPs6wk9LIaziffYjM8Hcy+g
         n7z0Ws7qGchXYNBaHsEr7tNw/i6jFHZxK1921gXqSSgSpzUdSDKtZnfHsM4u3lz5dM0Y
         AKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075144; x=1728679944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcGB3qPTIyAq2lyv3gVDHDXN+w1J2sfilEkLN6A+gPs=;
        b=K4tMeVyYWsv3Nn7UWEfUwS3bApdi1cteA72DERWrNX43mD2pkYRbzfiqkJ00WQxsiF
         srD8khIcs+FeAxkj39XODwxUj+6R1wY/MdhgQOSaxeKWNPT92xSemfqwOA3Ppstg0KYC
         QYDTdANMRbm+eIaKkCmp2ONKkjICm9D19VQrNs9pa0zNabUzZ7zVQP7owjOpNPRMu3u0
         Ud6muZ9slHLa59joEe392KaGMdPd6JQRh/VQJpBYsvTCA1mARbJ1eR14gp855XF7VmNF
         7pozRNtO1PgpPdBLA/SiSQWIvzpv+4nYzJNVssMw3fmiMJHi2xzfdlyRvDqmiMMQg5IX
         Zk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpchWalYmHDKMEdU3086mTA1/JpPIE6dO4fztv7Nk7PBCyZcIxsFbwzeGirOjv0UX9yzn7mIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TIqX71wUtGpj2vXx5w5LZLbkeChJ0Nl/rkvZe59O0I0nZmuX
	sVhdR/H7fYyfJ2g4DE/kXgp3Rx9HMLIIPSI4Tl3mS4CB57z++1sBrU1qB2Aq8so6lmdclZVi5B/
	WIugML3c3yeOvuDqUExFhtBE8+3c=
X-Google-Smtp-Source: AGHT+IEyLbDaJotxu0JWabK3Z8khe4QKbWO5nRb0owghJNfcN0DktBUWWEuulBBkDzLF0tmx3UYSBoxyCnSADqsKdPg=
X-Received: by 2002:a17:902:f54f:b0:20b:7a43:3693 with SMTP id
 d9443c01a7336-20bfde64ef8mr26491735ad.1.1728075143741; Fri, 04 Oct 2024
 13:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004203350.201294-1-hamza.mahfooz@amd.com>
 <CADnq5_M5ripf041=G2u+vkf-WS0_dFtLqtqwS16fOQTB3O6cBg@mail.gmail.com> <7efda303-f813-4da8-988c-110a90f49964@amd.com>
In-Reply-To: <7efda303-f813-4da8-988c-110a90f49964@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 16:52:12 -0400
Message-ID: <CADnq5_O0WDiFYCZbkSov37gv-QhaORKbHpUYPguFimQXdRd01Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hibernate entry for DCN35+
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Roman Li <roman.li@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:49=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> On 10/4/24 16:44, Alex Deucher wrote:
> > On Fri, Oct 4, 2024 at 4:43=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd=
.com> wrote:
> >>
> >> Since, two suspend-resume cycles are required to enter hibernate and,
> >> since we only need to enable idle optimizations in the first cycle
> >> (which is pretty much equivalent to s2idle). We can check in_s0ix, to
> >> prevent the system from entering idle optimizations before it actually
> >> enters hibernate (from display's perspective).
> >>
> >> Cc: stable@vger.kernel.org # 6.10+
> >> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 4651b884d8d9..546a168a2fbf 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -2996,10 +2996,11 @@ static int dm_suspend(struct amdgpu_ip_block *=
ip_block)
> >>
> >>          hpd_rx_irq_work_suspend(dm);
> >>
> >> -       if (adev->dm.dc->caps.ips_support)
> >> -               dc_allow_idle_optimizations(adev->dm.dc, true);
> >> -
> >>          dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> >> +
> >> +       if (dm->dc->caps.ips_support && adev->in_s0ix)
> >> +               dc_allow_idle_optimizations(dm->dc, true);
> >> +
> >
> > Is the ordering change with respect to dc_set_power_state() intended?
>
> Yup, it's safer to set idle opts after dc_set_power_state(), since it
> involves a write to DMUB.

Might want to mention that in the commit message.  With that:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> >
> > Alex
> >
> >>          dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM=
_POWER_STATE_D3);
> >>
> >>          return 0;
> >> --
> >> 2.46.0
> >>
> --
> Hamza
>

