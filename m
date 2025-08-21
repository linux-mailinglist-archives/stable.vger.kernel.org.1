Return-Path: <stable+bounces-172077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A41B2FA71
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3375E5ACB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3601A3375A1;
	Thu, 21 Aug 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3cFh7q0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F311334717;
	Thu, 21 Aug 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782789; cv=none; b=M9MZKfrsh10hrVqGZSfMRJgmXf2/WEXT6+iyKfF+nKihLPvod/y/jN0djgtDAS1WsGcFy7RDRO6mNJla7vnjb33KgcHUmcoDdq7kK2BOUM7CBbPYmbPeV9TUW2cdWJa3szG/d/bPkGgJLerCpllgKFsaqJkWToe+oKVo9qDzypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782789; c=relaxed/simple;
	bh=sE0NdjV5ow7kWL8cx7KhkkdaNnoHYm7alillK647B4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVrxaELD7KFztx3tMNPQjq8KSx2VbJkJ5bOtAXjRtGLaU4yC1jKAAJv5dooroHhSnyMa/Oss4iNCuKIxv96mplWuaUfXKJtQiVJh/5hEIvB6DfnWrtAu2V5U/6Ob8wcTf0AcikUmMr5C3kT++Ps1Zcwqb88LZ7QKXw5LkdERMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3cFh7q0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244581eab34so1987475ad.2;
        Thu, 21 Aug 2025 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755782787; x=1756387587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9dWZgSSt8ISrV45OhIH6KV6b2TkNENPxFwpEI1fMF8=;
        b=c3cFh7q0c/DEnNb2TzZoKrKRajPNKD6lXZtXgqhsFcUTrniAqatFQynJ5GdcD5PgFs
         0t2MgEa1C0vRRcnIKJAGJc+uOtAYNgzjiXFSqQ0kPGUgGJUSo+93SO6ORteuXngGP/Jc
         eOh/ca4Wu1JLZgFSbFBj5Yl7DPmquFRRhT+LP2j8wrsj0RerP6T7jL4Hm/BPXMiqTCh2
         Y+TofJ3f/UXg5HNNL/FrHNt1EuahXmfRNymz59F2+gRxHClHQWb4RVUg5QXXes3t0u0k
         tNFO0GiQEOujEuDFnBQRQOkxm6LS6IUvEgxVQSeA6EIStjORJniojHpvYt1OH6023a+E
         OAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782787; x=1756387587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9dWZgSSt8ISrV45OhIH6KV6b2TkNENPxFwpEI1fMF8=;
        b=NnBgiF4D/o7SlsfdFTrWPdQZf3KfdSL/H7uDkqttCQSPMd9JDuNse8aVCO4wMJ46ww
         FEPx1cTym8dwEhpFEDzYAR352H6hO6zOa7Oe84afruuUUckN72scgu9mflyFVGlmXazS
         RBw9KUoc9HqFVrR+bpG5YPGg9r5iXTNHDHXb/3DF9+Dy2FBZzBMKlg2oBBe23GfeToEY
         51rsjfsq3zsa6C+H3q+nFok1heVn7eoVQ9lG79r79atqHUnBex9StySVlFqpHgH4/CV/
         MycfsiwpuLlloJd9hKvvLGpIM0TsTeBCUAcPbqch0mkgCkaxjtv5yMz6Byd+5z7H4Bfz
         TiEA==
X-Forwarded-Encrypted: i=1; AJvYcCVjXl6fUqY8uHuieE1tyIE9iK8T+3Aovf+0L9tgK7LZoOuD8pWsl736BgGU0tCg5nJzWH+1fvZH1N71VT8=@vger.kernel.org, AJvYcCW/CoaePUaDFqyLXSwnKj2J5g0JYv8WBLaXG/M7Psx1Cp29wyQAO56IvJaSFTgQ77q2+DrqN3+s@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJ+QY80qbs1Y5xuIBozPJ6isY5ar9QRxrW3xwb+R1cCK05Ftk
	yqh13586tKj3CDCSy32Bdy6Se3v689ShTqzs/57ZgHg3ffsyYUYXySmGLezoEDcaLvEy/jr7S87
	nCL5kHKD1dOw1FU01pnClSKu6+mv9pCQ=
X-Gm-Gg: ASbGncvvDV9Bw6j6UDj/EFRmLfBcR4Ic9fBWArL4Aj+ruqt8591XhAuD5vFiX0FFEcZ
	1N2l1LvsLKAifHuEE/7PwAZ/D6pI0/RIqKCu/jnrlxb8BAIivVQp4qLXYC3sGn465u/DglHZYpY
	WgPB4WupgoyNr43iFI0beHCUfOXMPTA3onnHx9JvwP7SSneDs4SjGwATbGbojimXfSBwI4KvUy5
	Ou7QPw=
X-Google-Smtp-Source: AGHT+IGkzEhWos4QUYblfEYxDYZWTU24EonAwoXWEJPD3CYAfFEpsYnY3g5hssFjVogU0QTSVNu3ZE8xuk0RjUB/1/E=
X-Received: by 2002:a17:902:c40d:b0:245:f904:8922 with SMTP id
 d9443c01a7336-245ff8ca9dfmr19297695ad.7.1755782786607; Thu, 21 Aug 2025
 06:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-107-sashal@kernel.org>
 <0e8a1005-baa6-493e-a514-cd5d806949e1@suse.de>
In-Reply-To: <0e8a1005-baa6-493e-a514-cd5d806949e1@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 09:26:13 -0400
X-Gm-Features: Ac12FXwT83z3FJkEquv0LVv6izQd9aD-KnfjvDGnoi9pyikuUotQPjIuIFaDo3I
Message-ID: <CADnq5_OzjCA2WaJi14PSc9-gFmeC=vp3pCQ0zJxXbNRQ=9ncLg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 107/642] drm/amdgpu: adjust
 drm_firmware_drivers_only() handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, Kent Russell <kent.russell@amd.com>, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	lijo.lazar@amd.com, mario.limonciello@amd.com, rajneesh.bhardwaj@amd.com, 
	kenneth.feng@amd.com, Ramesh.Errabolu@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 5:33=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 06.05.25 um 00:05 schrieb Sasha Levin:
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > [ Upstream commit e00e5c223878a60e391e5422d173c3382d378f87 ]
> >
> > Move to probe so we can check the PCI device type and
> > only apply the drm_firmware_drivers_only() check for
> > PCI DISPLAY classes.  Also add a module parameter to
> > override the nomodeset kernel parameter as a workaround
> > for platforms that have this hardcoded on their kernel
> > command lines.
>
> I just came across this patch because it got backported into various
> older releases. It was part of the series at [1]. From the cover letter:
>
>  >>>
>
> There are a number of systems and cloud providers out there
> that have nomodeset hardcoded in their kernel parameters
> to block nouveau for the nvidia driver.  This prevents the
> amdgpu driver from loading. Unfortunately the end user cannot
> easily change this.  The preferred way to block modules from
> loading is to use modprobe.blacklist=3D<driver>.  That is what
> providers should be using to block specific drivers.
>
> Drop the check to allow the driver to load even when nomodeset
> is specified on the kernel command line.
>
> <<<
>
> Why was that series never on dri-devel?

I guess I should have sent these to dri-devel as well.

>
> Why is this necessary in the upstream kernel? It works around a problem
> with the user's configuration. The series' cover letter already states
> the correct solution.

IIRC, the customers were not willing to change their kernel
configurations across their fleet, but required a way to load the
amdgpu driver, but keep nouveau blocked.  That said, doing this in the
core would also not solve the problem since the goal of nomodeset was
to block nouveau.

>
> Firmware-only parameters affect all drivers; why not try for a common
> solution? At least the test against the PCI class appears useful in the
> common case.

I can port the changes to the core if there is interest.

Alex

>
> Best regards
> Thomas
>
>
> >
> > Reviewed-by: Kent Russell <kent.russell@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index f2d77bc04e4a9..7246c54bd2bbf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -173,6 +173,7 @@ uint amdgpu_sdma_phase_quantum =3D 32;
> >   char *amdgpu_disable_cu;
> >   char *amdgpu_virtual_display;
> >   bool enforce_isolation;
> > +int amdgpu_modeset =3D -1;
> >
> >   /* Specifies the default granularity for SVM, used in buffer
> >    * migration and restoration of backing memory when handling
> > @@ -1033,6 +1034,13 @@ module_param_named(user_partt_mode, amdgpu_user_=
partt_mode, uint, 0444);
> >   module_param(enforce_isolation, bool, 0444);
> >   MODULE_PARM_DESC(enforce_isolation, "enforce process isolation betwee=
n graphics and compute . enforce_isolation =3D on");
> >
> > +/**
> > + * DOC: modeset (int)
> > + * Override nomodeset (1 =3D override, -1 =3D auto). The default is -1=
 (auto).
> > + */
> > +MODULE_PARM_DESC(modeset, "Override nomodeset (1 =3D enable, -1 =3D au=
to)");
> > +module_param_named(modeset, amdgpu_modeset, int, 0444);
> > +
> >   /**
> >    * DOC: seamless (int)
> >    * Seamless boot will keep the image on the screen during the boot pr=
ocess.
> > @@ -2244,6 +2252,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev=
,
> >       int ret, retry =3D 0, i;
> >       bool supports_atomic =3D false;
> >
> > +     if ((pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA ||
> > +         (pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_OTHER) {
> > +             if (drm_firmware_drivers_only() && amdgpu_modeset =3D=3D =
-1)
> > +                     return -EINVAL;
> > +     }
> > +
> >       /* skip devices which are owned by radeon */
> >       for (i =3D 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) =
{
> >               if (amdgpu_unsupported_pciidlist[i] =3D=3D pdev->device)
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>
>

