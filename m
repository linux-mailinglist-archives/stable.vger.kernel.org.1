Return-Path: <stable+bounces-163183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6CB07B58
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507FDA408CF
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA22F3C3E;
	Wed, 16 Jul 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMT+OiY4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63825C810
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684054; cv=none; b=IZmAxmSO2sVTtzlbmGucbDMP5Ph7ayJjccpUb8R2AwrdqJR91KUVRk1m3cpnFcWHo4sy8Uu4BPPptye9vK2+ckJWCAw5/gdO2ge6p9GJgh8ZXcGL3i/AgwYASzmDhIb1rgS0vrDnvoNMPcYY9rA3YTUFNzNSIt9LG94wo7xLD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684054; c=relaxed/simple;
	bh=CbvY90bhc3awJD+x7JLrq/FPlnYJA1NgO71SEWJ9yPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjutWFz8ojiVZtY9y8++UPOm+qqJGDUrV/Ktsb2EwRiP8hxLSf7LylAHiiLC6/rUlX9nanfJmu4YPOeT4/pJ9/GQkau5iyNEUO7kUvGeeLIFp2/xvvkUOVIRtRI0YiaS9fPeD5YuIZ4cHfJHrMYV04IWBdHtyfolrXHiyp59/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMT+OiY4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dd9ae5aacso192775ad.1
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752684052; x=1753288852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBVaXc10A4jRruPriSxBpOpyudYSZuIpQyGPNMCEI5A=;
        b=bMT+OiY4ZwKwOHoKbo6HNa4WOL2HxC51sx2NAM4dPC3xfpjzPFWtWPYTs8JqWeCdwn
         eosotO4KyvDAuXznqasHWWOSTcOxpXXvK5alYhVpLRoSELt/CEDhuVdwwJ72DFtpq0yj
         209xp2R01numQsatcTu6geXnCAlGKa/bZDgEPcRvmzSMfiDKVpQ6iwv/kq0gj6Zm6XwK
         pWzci5PZJ5G4rJYAG2BpiIdnKhIMNMJvNOIOa999IxVWh6l8tLzjc/fo5AZvNRI01Vy4
         5qTJqt1aYAdVTywwrNFXoY0VOnKDy+7EvQZIJ56G/HN8f4ejX4+ofVZ7sn+9hqY7iMQU
         IAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684052; x=1753288852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBVaXc10A4jRruPriSxBpOpyudYSZuIpQyGPNMCEI5A=;
        b=nn9x7DdPlZEdwhUhqxzd42ttl0eXtgg4hPaZZ9WJl6QBXBCojBg6B1fppwsBXmFN0o
         TdZSaCot7OxS5OePEpKojOpZxGDBzXjz/Hs1/k9bx2fz/VUFb/AOn2KOI2XippJtTAW/
         qV7O7jMFaWgY8RbtPirHr+PGKssgV3EczXW3og2GB8ZjCOSb7G7Kz8hWX/CU6flJ9mJK
         +a0x5G3FgBn1Xl33LXAJCG15aL/+HuTfWAfF+4Kna2KUOfGyWaPrSwumsGAKVI6pLDo9
         70QQkRLZl9WDNMngttx/h9EZVsK0r1mUOTOKRNroBhLYTkr38fwmdViFP2gRC4rLKsDb
         rrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6kzmSAJaqjZppNp5RfIHDxo5JavxVbKgubF/uDOVnzLN3F1kOztH8Aa+kKwLDatDEuH96uG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/WeO/nV8Fsh1F1+8XSmodEgfR74mhuDSas8eobzFB6/gLQvr
	2rpPGe3g7wpuW4LkrIdTzoVuDLlsRQsJfcufFY4XZpQyAjjM4c5MegZGMfo+6MH1zqKPsNhrMmR
	Saj9FBS04WiUyLTaaShdDdDKOUjyxW5i4bcmnTJt+
X-Gm-Gg: ASbGncuFqQlTezhOGHdkLnaPSvFn2DVYf7GPy3pQzFT3k4/rPqbw18NuN7s3thz0ksD
	/tnymbrUpfc+LXM2zOfDV5tVuaH8+3RhhkAQAVmeDINm/tV+1tE/VWjaYrERUOsLBagDUIc5swp
	LPgTs1UJp9soGGLOt6xYdppHZS5N4KBMI/kquQhnRMI5sJs+kD3sgWcnRtRXNhTm+C9xKTkgAw+
	/Fx/FKa8JurPvUj
X-Google-Smtp-Source: AGHT+IHYQT5VXdCLT8hxrmg+0yfaXwrBL7UyuNaYscaOfd+9wb7KNDQaQqvXeihVJ+Iuuagh7P0Alzo8AVqhcyLotSs=
X-Received: by 2002:a17:902:e5c2:b0:235:f298:cbbb with SMTP id
 d9443c01a7336-23e2644036cmr3043915ad.26.1752684051728; Wed, 16 Jul 2025
 09:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com> <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
In-Reply-To: <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 16 Jul 2025 12:40:15 -0400
X-Gm-Features: Ac12FXyULN47EIoDp4OeB3JlE-FJDnHi4sIL1ptSRWoQg8L9yjUdgo_BV4vPoWI
Message-ID: <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@google.com=
> wrote:
> >
> > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v=
2)")
> > allowed for newer ASICs to mix GTT and VRAM, this change also noted tha=
t
> > some older boards, such as Stoney and Carrizo do not support this.
> > It appears that at least one additional ASIC does not support this whic=
h
> > is Raven.
> >
> > We observed this issue when migrating a device from a 5.4 to 6.6 kernel
> > and have confirmed that Raven also needs to be excluded from mixing GTT
> > and VRAM.
>
> Can you elaborate a bit on what the problem is?  For carrizo and
> stoney this is a hardware limitation (all display buffers need to be
> in GTT or VRAM, but not both).  Raven and newer don't have this
> limitation and we tested raven pretty extensively at the time.

Thanks for taking the time to look. We have automated testing and a
few igt gpu tools tests failed and after debugging we found that
commit 81d0bcf99009 is what introduced the failures on this hardware
on 6.1+ kernels. The specific tests that fail are kms_async_flips and
kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
VRAM buffers resolves the issue.

Brian

>
>
> Alex
>
> >
> > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v=
2)")
> > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org # 6.1+
> > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 73403744331a..5d7f13e25b7c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct am=
dgpu_device *adev,
> >                                             uint32_t domain)
> >  {
> >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_=
GTT)) &&
> > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D CHIP_STONEY))) {
> > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D CHIP_STONEY) ||
> > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
> >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >

