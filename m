Return-Path: <stable+bounces-163407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D2B0AC69
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 01:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86057AA721
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 22:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3488221275;
	Fri, 18 Jul 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LstKRQYB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2C1DE4E1;
	Fri, 18 Jul 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879654; cv=none; b=WUCYFYvW7jBoXRS/BzxlTwl06vcn3k/PFAjum7+NHFjPYrQcsof7+FZkGdIPyb7WyHSS6NkLVPslZgJfNSNYs5XTFrhwqvzVVNT8HAMZc8f+QQW1LHkw3QUsnrh/hiLD6GjODc63Z8EN104rZnRpycK5pIcZXaLP7LGpQSA+jZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879654; c=relaxed/simple;
	bh=C+KrsCwgUyqF65pH2bHl9UIlbdknLDnIVZN+nZL2tGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+mh0YMfvtuxK9cb7JcosCdr0XYOBbBEc0O9AdBcx+1NCVhYT3cyDk4xg8E4YJZDOOsuC69Kb/Q0wBah02GTgwI6EREH9HzIzlCx8NzXaUG2M9jVNPRpk7WvPYpjxiw20UO8IHvnc/yrFvJM+ZR6JAkt5Hf4lP7LT4Qi/04NHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LstKRQYB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31308f52248so400225a91.2;
        Fri, 18 Jul 2025 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752879652; x=1753484452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sXnSFrZQu6iHu8Vl2fFaximoXMxICZGZWhV/y8jBr6I=;
        b=LstKRQYB2r6kB09nZAfFGXyoIfI1GVzlfavSYeygpogOaRu+17YvwxWKHp4OmOUfaT
         gCICRWo9U34i4ufDZKaMBDsD/Se35eMXU0Xj3hkIpQoTcMz1p1NOG78Y9a8CqDYpZTIq
         tYkOP4OVoQyU306hSehqBoiAbLKuac8JKKjxEKAFPAnUzEfV/Wz/K6p/RvCb5V9ND0ze
         D6bq35XeL271diGTAQ32SI1VqLR2MiCFczd9nlXDBZRSPssYbGPrCq5ucQAhtE1UJLBv
         FmunLDnlLNZ4aFzz5IFL7bWzs1fY/JzlbT/vk9Si/wPcL9ca2nG5x2retTBcZH0pSXdO
         KaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879652; x=1753484452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXnSFrZQu6iHu8Vl2fFaximoXMxICZGZWhV/y8jBr6I=;
        b=qW2RvKdzA3PBovtsc8sYQJpuZ/vqPQTZGKlOpk+8Vu1i+bgi/zGJinVWeWE3MxSspn
         A6WlPhDiRaYhcaH3jiqfbrbvwwM679RREMk3+w9Nq+2VLAoltu9/pYki+LKwX9RXZOS+
         p03ZlYM8XY4FOq2zxOFhcj2/u1ZWmClg35ruMKN0zqdcHyfWT02d7JzA9Ppa8mpJbaU3
         08XAe8B6H4BpOc4dEjgD6m1Fv4DbjycPNmyIho9TD/39IZ1jkr2cegiYEnyEguIe7IyB
         HDP8PTYRJOZXRBKXsnZsNvRLAVekN3RY62hT/09p/tzbWnzNfVhrWl7ezfUXFimFK/cQ
         5jKw==
X-Forwarded-Encrypted: i=1; AJvYcCUENry2Vw2E+L9uMCWLtxqdP+kjrYzdkIlESTmUQF3ZgoH56FwwwcKxqW7IM80tG6AiOZecYT+s@vger.kernel.org, AJvYcCVlwyau/dMzeCPq9B05uQkn0ehhB5N7mStpFbWpJd3hj816/ykAUzoIR10HWSPJLUJme7eDQfcKmADnId8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnXIzZRQ4IPzhftPzewz4mN4Aj5yWD4bS61FI5PNRyzwt8Ldx
	MBg56VfgnHMKN5p/Ti2v+agqPx0FZK20RRjlUIPgDb+/hO8VAEJ1jQJYHY65B0YmI9tw4BjpNOM
	RNOINFBMR0e7g78t6qbQFRMFFTmc8zBI=
X-Gm-Gg: ASbGncsP3MkiDDirxz/tUujzQfzHhMzG44bLbkzcZ5sVRHa7ZwKfM/lNTWq8WXLtV1x
	YVgyWvviVPrL2adFmEYF0usmIFNn361fdkRKn2k2TrQCTQuykw3rwPYbKPVIdZ7weIRvgI7X98s
	4BYxg2G9Zp27widjwOmAxXa8cSMs6JcemoRswUp/Uc+5dCC3boxItjZ2fKf9OZDgXlvrb0/MiYb
	NU8Qegm
X-Google-Smtp-Source: AGHT+IHee7URO5AdAIetWQOqWSNF+tiB8BcaFoilq0xjITd/WfrQ4fVADkrn9hF8q620zqo7hJHNja1AQMJNZ6dfziQ=
X-Received: by 2002:a17:90a:e18c:b0:311:a314:c2dd with SMTP id
 98e67ed59e1d1-31c9e77394emr6978695a91.4.1752879651725; Fri, 18 Jul 2025
 16:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com> <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
 <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
 <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
 <CADnq5_PnktmP+0Hw0T04VkrkKoF_TGz5HOzRd1UZq6XOE0Rm1g@mail.gmail.com>
 <CADyq12x1f0VLjHKWEmfmis8oLncqSWxeTGs5wL0Xj2hua+onOQ@mail.gmail.com>
 <CADnq5_OhHpZDmV5J_5kA+avOdLrexnoRVCCCRddLQ=PPVAJsPQ@mail.gmail.com>
 <46bdb101-11c6-46d4-8224-b17d1d356504@amd.com> <CADnq5_PwyUwqdv1QG_O2XgvNnax+FNskuppBaKx8d0Kp582wXg@mail.gmail.com>
 <eff0ef03-d054-487e-b3bf-96bf394a3bf5@amd.com>
In-Reply-To: <eff0ef03-d054-487e-b3bf-96bf394a3bf5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 19:00:39 -0400
X-Gm-Features: Ac12FXxsQb-K5hPEFVe-vUn9sPWELbN3hUPlB9ioULbkI7TQ40Q9TxxIpU6AUMA
Message-ID: <CADnq5_NvPsxmm8j0URD_B8a5gg9NQNX8VY0d93AqUDis46cdXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Leo Li <sunpeng.li@amd.com>
Cc: Brian Geffon <bgeffon@google.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f9bb55063a3c187b"

--000000000000f9bb55063a3c187b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:01=E2=80=AFPM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2025-07-18 17:33, Alex Deucher wrote:
> > On Fri, Jul 18, 2025 at 5:02=E2=80=AFPM Leo Li <sunpeng.li@amd.com> wro=
te:
> >>
> >>
> >>
> >> On 2025-07-18 16:07, Alex Deucher wrote:
> >>> On Fri, Jul 18, 2025 at 1:57=E2=80=AFPM Brian Geffon <bgeffon@google.=
com> wrote:
> >>>>
> >>>> On Thu, Jul 17, 2025 at 10:59=E2=80=AFAM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> >>>>>
> >>>>> On Wed, Jul 16, 2025 at 8:13=E2=80=AFPM Brian Geffon <bgeffon@googl=
e.com> wrote:
> >>>>>>
> >>>>>> On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@=
gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@go=
ogle.com> wrote:
> >>>>>>>>
> >>>>>>>> On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeuch=
er@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@=
google.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more fl=
exible (v2)")
> >>>>>>>>>> allowed for newer ASICs to mix GTT and VRAM, this change also =
noted that
> >>>>>>>>>> some older boards, such as Stoney and Carrizo do not support t=
his.
> >>>>>>>>>> It appears that at least one additional ASIC does not support =
this which
> >>>>>>>>>> is Raven.
> >>>>>>>>>>
> >>>>>>>>>> We observed this issue when migrating a device from a 5.4 to 6=
.6 kernel
> >>>>>>>>>> and have confirmed that Raven also needs to be excluded from m=
ixing GTT
> >>>>>>>>>> and VRAM.
> >>>>>>>>>
> >>>>>>>>> Can you elaborate a bit on what the problem is?  For carrizo an=
d
> >>>>>>>>> stoney this is a hardware limitation (all display buffers need =
to be
> >>>>>>>>> in GTT or VRAM, but not both).  Raven and newer don't have this
> >>>>>>>>> limitation and we tested raven pretty extensively at the time.s
> >>>>>>>>
> >>>>>>>> Thanks for taking the time to look. We have automated testing an=
d a
> >>>>>>>> few igt gpu tools tests failed and after debugging we found that
> >>>>>>>> commit 81d0bcf99009 is what introduced the failures on this hard=
ware
> >>>>>>>> on 6.1+ kernels. The specific tests that fail are kms_async_flip=
s and
> >>>>>>>> kms_plane_alpha_blend, excluding Raven from this sharing of GTT =
and
> >>>>>>>> VRAM buffers resolves the issue.
> >>>>>>>
> >>>>>>> + Harry and Leo
> >>>>>>>
> >>>>>>> This sounds like the memory placement issue we discussed last wee=
k.
> >>>>>>> In that case, the issue is related to where the buffer ends up wh=
en we
> >>>>>>> try to do an async flip.  In that case, we can't do an async flip
> >>>>>>> without a full modeset if the buffers locations are different tha=
n the
> >>>>>>> last modeset because we need to update more than just the buffer =
base
> >>>>>>> addresses.  This change works around that limitation by always fo=
rcing
> >>>>>>> display buffers into VRAM or GTT.  Adding raven to this case may =
fix
> >>>>>>> those tests but will make the overall experience worse because we=
'll
> >>>>>>> end up effectively not being able to not fully utilize both gtt a=
nd
> >>>>>>> vram for display which would reintroduce all of the problems fixe=
d by
> >>>>>>> 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2=
)").
> >>>>>>
> >>>>>> Thanks Alex, the thing is, we only observe this on Raven boards, w=
hy
> >>>>>> would Raven only be impacted by this? It would seem that all devic=
es
> >>>>>> would have this issue, no? Also, I'm not familiar with how
> >>>>>
> >>>>> It depends on memory pressure and available memory in each pool.
> >>>>> E.g., initially the display buffer is in VRAM when the initial mode
> >>>>> set happens.  The watermarks, etc. are set for that scenario.  One =
of
> >>>>> the next frames ends up in a pool different than the original.  Now
> >>>>> the buffer is in GTT.  The async flip interface does a fast validat=
ion
> >>>>> to try and flip as soon as possible, but that validation fails beca=
use
> >>>>> the watermarks need to be updated which requires a full modeset.
> >>
> >> Huh, I'm not sure if this actually is an issue for APUs. The fix that =
introduced
> >> a check for same memory placement on async flips was on a system with =
a DGPU,
> >> for which VRAM placement does matter:
> >> https://github.com/torvalds/linux/commit/a7c0cad0dc060bb77e9c9d235d684=
41b0fc69507
> >>
> >> Looking around in DM/DML, for APUs, I don't see any logic that changes=
 DCN
> >> bandwidth validation depending on memory placement. There's a gpuvm_en=
able flag
> >> for SG, but it's statically set to 1 on APU DCN versions. It sounds li=
ke for
> >> APUs specifically, we *should* be able to ignore the mem placement che=
ck. I can
> >> spin up a patch to test this out.
> >
> > Is the gpu_vm_support flag ever set for dGPUs?  The allowed domains
> > for display buffers are determined by
> > amdgpu_display_supported_domains() and we only allow GTT as a domain
> > if gpu_vm_support is set, which I think is just for APUs.  In that
> > case, we could probably only need the checks specifically for
> > CHIP_CARRIZO and CHIP_STONEY since IIRC, they don't support mixed VRAM
> > and GTT (only one or the other?).  dGPUs and really old APUs will
> > always get VRAM, and newer APUs will get VRAM | GTT.
>
> It doesn't look like gpu_vm_support is set for DGPUs
> https://elixir.bootlin.com/linux/v6.15.6/source/drivers/gpu/drm/amd/displ=
ay/amdgpu_dm/amdgpu_dm.c#L1866
>
> Though interestingly, further up at #L1858, Raven has gpu_vm_support =3D =
0. Maybe it had stability issues?
> https://github.com/torvalds/linux/commit/098c13079c6fdd44f10586b69132c392=
ebf87450

We need to be a little careful here asic_type =3D=3D CHIP_RAVEN covers
several variants:
apu_flags & AMD_APU_IS_RAVEN - raven1 (gpu_vm_support =3D false)
apu_flags & AMD_APU_IS_RAVEN2 - raven2 (gpu_vm_support =3D true)
apu_flags & AMD_APU_IS_PICASSO - picasso (gpu_vm_support =3D true)

amdgpu_display_supported_domains() only sets AMDGPU_GEM_DOMAIN_GTT if
gpu_vm_support is true.  so we'd never get into the check in
amdgpu_bo_get_preferred_domain() for raven1.

Anyway, back to your suggestion, I think we can probably drop the
checks as you should always get a compatible memory buffer due to
amdgpu_bo_get_preferred_domain(). Pinning should fail if we can't pin
in the required domain.  amdgpu_display_supported_domains() will
ensure you always get VRAM or GTT or VRAM | GTT depending on what the
chip supports.  Then amdgpu_bo_get_preferred_domain() will either
leave that as is, or force VRAM or GTT for the STONEY/CARRIZO case.
On the off chance we do get incompatible memory, something like the
attached patch should do the trick.

Alex


>
> - Leo
>
> >
> > Alex
> >
> >>
> >> Thanks,
> >> Leo
> >>
> >>>>>
> >>>>> It's tricky to fix because you don't want to use the worst case
> >>>>> watermarks all the time because that will limit the number availabl=
e
> >>>>> display options and you don't want to force everything to a particu=
lar
> >>>>> memory pool because that will limit the amount of memory that can b=
e
> >>>>> used for display (which is what the patch in question fixed).  Idea=
lly
> >>>>> the caller would do a test commit before the page flip to determine
> >>>>> whether or not it would succeed before issuing it and then we'd hav=
e
> >>>>> some feedback mechanism to tell the caller that the commit would fa=
il
> >>>>> due to buffer placement so it would do a full modeset instead.  We
> >>>>> discussed this feedback mechanism last week at the display hackfest=
.
> >>>>>
> >>>>>
> >>>>>> kms_plane_alpha_blend works, but does this also support that test
> >>>>>> failing as the cause?
> >>>>>
> >>>>> That may be related.  I'm not too familiar with that test either, b=
ut
> >>>>> Leo or Harry can provide some guidance.
> >>>>>
> >>>>> Alex
> >>>>
> >>>> Thanks everyone for the input so far. I have a question for the
> >>>> maintainers, given that it seems that this is functionally broken fo=
r
> >>>> ASICs which are iGPUs, and there does not seem to be an easy fix, do=
es
> >>>> it make sense to extend this proposed patch to all iGPUs until a mor=
e
> >>>> permanent fix can be identified? At the end of the day I'll take
> >>>> functional correctness over performance.
> >>>
> >>> It's not functional correctness, it's usability.  All that is
> >>> potentially broken is async flips (which depend on memory pressure an=
d
> >>> buffer placement), while if you effectively revert the patch, you end
> >>> up  limiting all display buffers to either VRAM or GTT which may end
> >>> up causing the inability to display anything because there is not
> >>> enough memory in that pool for the next modeset.  We'll start getting
> >>> bug reports about blank screens and failure to set modes because of
> >>> memory pressure.  I think if we want a short term fix, it would be to
> >>> always set the worst case watermarks.  The downside to that is that i=
t
> >>> would possibly cause some working display setups to stop working if
> >>> they were on the margins to begin with.
> >>>
> >>> Alex
> >>>
> >>>>
> >>>> Brian
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks again,
> >>>>>> Brian
> >>>>>>
> >>>>>>>
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Brian
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Alex
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more fl=
exible (v2)")
> >>>>>>>>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
> >>>>>>>>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>> Cc: stable@vger.kernel.org # 6.1+
> >>>>>>>>>> Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >>>>>>>>>> Signed-off-by: Brian Geffon <bgeffon@google.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> >>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>>>> index 73403744331a..5d7f13e25b7c 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>>>> @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(=
struct amdgpu_device *adev,
> >>>>>>>>>>                                             uint32_t domain)
> >>>>>>>>>>  {
> >>>>>>>>>>         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GE=
M_DOMAIN_GTT)) &&
> >>>>>>>>>> -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->a=
sic_type =3D=3D CHIP_STONEY))) {
> >>>>>>>>>> +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->a=
sic_type =3D=3D CHIP_STONEY) ||
> >>>>>>>>>> +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> >>>>>>>>>>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >>>>>>>>>>                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_TH=
RESHOLD)
> >>>>>>>>>>                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >>>>>>>>>> --
> >>>>>>>>>> 2.50.0.727.gbf7dc18ff4-goog
> >>>>>>>>>>
> >>
>

--000000000000f9bb55063a3c187b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amd-display-refine-framebuffer-placement-checks.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amd-display-refine-framebuffer-placement-checks.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_md9f8jvm0>
X-Attachment-Id: f_md9f8jvm0

RnJvbSBjY2UxNjUyYzYyYzQyYzg1OGRlNjRjMzA2ZWEwZGRjN2FmM2JkMGIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMTggSnVsIDIwMjUgMTg6NDA6MjYgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kL2Rpc3BsYXk6IHJlZmluZSBmcmFtZWJ1ZmZlciBwbGFjZW1lbnQgY2hlY2tzCgpX
aGVuIHdlIGNvbW1pdCBwbGFuZXMsIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoZQpmcmFtZWJ1ZmZl
ciBtZW1vcnkgbG9jYXRpb25zIGFyZSBjb21wYXRpYmxlLiBWYXJpb3VzCmhhcmR3YXJlIGhhcyB0
aGUgZm9sbG93aW5nIHJlcXVpcmVtZW50cyBmb3IgZGlzcGxheSBidWZmZXJzOgpkR1BVcywgb2xk
IEFQVXMsIHJhdmVuMSAtIG11c3QgYmUgaW4gVlJBTQpjYXp6aXJvL3N0b25leSAtIG11c3QgYmUg
aW4gVlJBTSBvciBHVFQsIGJ1dCBub3QgYm90aApuZXdlciBBUFVzIChyYXZlbjIvcGljYXNzbyBh
bmQgbmV3ZXIpIC0gY2FuIGJlIGluIFZSQU0gb3IgR1RUCgpZb3Ugc2hvdWxkIGFsd2F5cyBnZXQg
YSBjb21wYXRpYmxlIG1lbW9yeSBidWZmZXIgZHVlIHRvCmFtZGdwdV9ib19nZXRfcHJlZmVycmVk
X2RvbWFpbigpLiBhbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucygpCndpbGwgZW5zdXJl
IHlvdSBhbHdheXMgZ2V0IFZSQU0gb3IgR1RUIG9yIFZSQU0gfCBHVFQgZGVwZW5kaW5nIG9uCndo
YXQgdGhlIGNoaXAgc3VwcG9ydHMuICBUaGVuIGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX2RvbWFp
bigpCndpbGwgZWl0aGVyIGxlYXZlIHRoYXQgYXMgaXMgd2hlbiBwaW5uaW5nLCBvciBmb3JjZSBW
UkFNIG9yIEdUVApmb3IgdGhlIFNUT05FWS9DQVJSSVpPIGNhc2UuCgpBcyBzdWNoIHRoZSBjaGVj
a3MgY291bGQgcHJvYmFibHkgYmUgcmVtb3ZlZCwgYnV0IG9uIHRoZSBvZmYgY2hhbmNlCndlIGRv
IGVuZCB1cCBnZXR0aW5nIGRpZmZlcmVudCBtZW1vcnkgcG9vbCBmb3IgdGhlIG9sZAphbmQgbmV3
IGZyYW1lYnVmZmVycywgcmVmaW5lIHRoZSBjaGVjayB0byB0YWtlIGludG8gYWNjb3VudCB0aGUK
aGFyZHdhcmUgY2FwYWJpbGl0aWVzLgoKRml4ZXM6IGE3YzBjYWQwZGMwNiAoImRybS9hbWQvZGlz
cGxheTogZW5zdXJlIGFzeW5jIGZsaXBzIGFyZSBvbmx5IGFjY2VwdGVkIGZvciBmYXN0IHVwZGF0
ZXMiKQpSZXBvcnRlZC1ieTogQnJpYW4gR2VmZm9uIDxiZ2VmZm9uQGdvb2dsZS5jb20+CkNjOiBM
ZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIwICsrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IDEyOTQ3NmI2ZDVm
YTkuLmRlMmJkNzg5ZWMxNWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtOTI4OCw2ICs5Mjg4LDE4IEBAIHN0YXRpYyB2b2lk
IGFtZGdwdV9kbV9lbmFibGVfc2VsZl9yZWZyZXNoKHN0cnVjdCBhbWRncHVfY3J0YyAqYWNydGNf
YXR0YWNoLAogCX0KIH0KIAorc3RhdGljIGJvb2wgYW1kZ3B1X2RtX21lbV90eXBlX2NvbXBhdGli
bGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJCSAgc3RydWN0IGRybV9mcmFtZWJ1
ZmZlciAqb2xkX2ZiLAorCQkJCQkgIHN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKm5ld19mYikKK3sK
KwlpZiAoIWFkZXYtPm1vZGVfaW5mby5ncHVfdm1fc3VwcG9ydCB8fAorCSAgICAoYWRldi0+YXNp
Y190eXBlID09IENISVBfQ0FSUklaTykgfHwKKwkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQ
X1NUT05FWSkpCisJCXJldHVybiBnZXRfbWVtX3R5cGUob2xkX2ZiKSA9PSBnZXRfbWVtX3R5cGUo
bmV3X2ZiKTsKKworCXJldHVybiB0cnVlOworfQorCiBzdGF0aWMgdm9pZCBhbWRncHVfZG1fY29t
bWl0X3BsYW5lcyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCiAJCQkJICAgIHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsCiAJCQkJICAgIHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2Vy
ICpkbSwKQEAgLTk0NjUsNyArOTQ3Nyw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9jb21taXRf
cGxhbmVzKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKIAkJICovCiAJCWlmIChjcnRj
LT5zdGF0ZS0+YXN5bmNfZmxpcCAmJgogCQkgICAgKGFjcnRjX3N0YXRlLT51cGRhdGVfdHlwZSAh
PSBVUERBVEVfVFlQRV9GQVNUIHx8Ci0JCSAgICAgZ2V0X21lbV90eXBlKG9sZF9wbGFuZV9zdGF0
ZS0+ZmIpICE9IGdldF9tZW1fdHlwZShmYikpKQorCQkgICAgICFhbWRncHVfZG1fbWVtX3R5cGVf
Y29tcGF0aWJsZShkbS0+YWRldiwgb2xkX3BsYW5lX3N0YXRlLT5mYiwgZmIpKSkKIAkJCWRybV93
YXJuX29uY2Uoc3RhdGUtPmRldiwKIAkJCQkgICAgICAiW1BMQU5FOiVkOiVzXSBhc3luYyBmbGlw
IHdpdGggbm9uLWZhc3QgdXBkYXRlXG4iLAogCQkJCSAgICAgIHBsYW5lLT5iYXNlLmlkLCBwbGFu
ZS0+bmFtZSk7CkBAIC05NDczLDcgKzk0ODUsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1fY29t
bWl0X3BsYW5lcyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCiAJCWJ1bmRsZS0+Zmxp
cF9hZGRyc1twbGFuZXNfY291bnRdLmZsaXBfaW1tZWRpYXRlID0KIAkJCWNydGMtPnN0YXRlLT5h
c3luY19mbGlwICYmCiAJCQlhY3J0Y19zdGF0ZS0+dXBkYXRlX3R5cGUgPT0gVVBEQVRFX1RZUEVf
RkFTVCAmJgotCQkJZ2V0X21lbV90eXBlKG9sZF9wbGFuZV9zdGF0ZS0+ZmIpID09IGdldF9tZW1f
dHlwZShmYik7CisJCQlhbWRncHVfZG1fbWVtX3R5cGVfY29tcGF0aWJsZShkbS0+YWRldiwgb2xk
X3BsYW5lX3N0YXRlLT5mYiwgZmIpOwogCiAJCXRpbWVzdGFtcF9ucyA9IGt0aW1lX2dldF9ucygp
OwogCQlidW5kbGUtPmZsaXBfYWRkcnNbcGxhbmVzX2NvdW50XS5mbGlwX3RpbWVzdGFtcF9pbl91
cyA9IGRpdl91NjQodGltZXN0YW1wX25zLCAxMDAwKTsKQEAgLTExNzYwLDYgKzExNzcyLDcgQEAg
c3RhdGljIGJvb2wgYW1kZ3B1X2RtX2NydGNfbWVtX3R5cGVfY2hhbmdlZChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2LAogCQkJCQkgICAgc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlLAogCQkJ
CQkgICAgc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQogeworCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYoZGV2KTsKIAlzdHJ1Y3QgZHJtX3BsYW5lICpw
bGFuZTsKIAlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpuZXdfcGxhbmVfc3RhdGUsICpvbGRfcGxh
bmVfc3RhdGU7CiAKQEAgLTExNzczLDcgKzExNzg2LDggQEAgc3RhdGljIGJvb2wgYW1kZ3B1X2Rt
X2NydGNfbWVtX3R5cGVfY2hhbmdlZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAogCQl9CiAKIAkJ
aWYgKG9sZF9wbGFuZV9zdGF0ZS0+ZmIgJiYgbmV3X3BsYW5lX3N0YXRlLT5mYiAmJgotCQkgICAg
Z2V0X21lbV90eXBlKG9sZF9wbGFuZV9zdGF0ZS0+ZmIpICE9IGdldF9tZW1fdHlwZShuZXdfcGxh
bmVfc3RhdGUtPmZiKSkKKwkJICAgICFhbWRncHVfZG1fbWVtX3R5cGVfY29tcGF0aWJsZShhZGV2
LCBvbGRfcGxhbmVfc3RhdGUtPmZiLAorCQkJCQkJICAgbmV3X3BsYW5lX3N0YXRlLT5mYikpCiAJ
CQlyZXR1cm4gdHJ1ZTsKIAl9CiAKLS0gCjIuNTAuMQoK
--000000000000f9bb55063a3c187b--

