Return-Path: <stable+bounces-164988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19280B14076
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3103017F96F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4D218ABD;
	Mon, 28 Jul 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrfNDu73"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0B1F9F73;
	Mon, 28 Jul 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720742; cv=none; b=MZu7NfcxYKlKka10GArlhO04W72C7miF6dxraGi6Enf2wQqBThzx06SHCTYSCKvDcKQi9MQqaVb3+4oKfXx4DHuOvQPdsCDltwahbGhz+iqZAZHzzI6+sn3mA8tB+n3/2BFhGRt3w/J/FulGZjyqU7DHls/7deRHWpB/BWXmNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720742; c=relaxed/simple;
	bh=TuPLuBVm/PzA2HIsRgzqKIlUBo47ufCCsVjFZHi41Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEyhZ5B0H5Lm+0wHo7NAghKXaIcoi2a7/lwrGzbj3H6IsQSO9tcyXQPnG3eVT/BLRTOZHCyuBV6msJUL7ntS0Q124WHRWafTbnv2eY3TaqjKXh5+3xkIinvR4S265TTxVgPFewfjELs+ULme3hXxP2a2Acy5ECEDBaum4DYwl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrfNDu73; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23fdc775489so1050695ad.1;
        Mon, 28 Jul 2025 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753720740; x=1754325540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOICoi7S+RmHvt1B5Vpu4zl7Gq/1pJQJd2IAfflrwDs=;
        b=HrfNDu73XoZmEd3TxL11gqZKEBMJZ/ciZndIAmiiyDNr4wBzGb+Jf/p7+bCr1umCv0
         w+aNY4IfFDIF+Fcq8az+7/UmXW98fOlBbDBhH0NsTTQOGUy3gb/TqqfwnYzU7rQlI0Bc
         nZ66zGK8Zur9u6IBsV2kqfbXiZS0zI8s59pHfIdz7GBodMW0jHkoBxVVIxr7HFjxmeF/
         ObkCzpMaZCA22P6maDl3SutzTwXbpZZ2BwkV1clX5f5y6zMRpPo5w43UswcGw86z+g/o
         mqw6MhnFD/g1UkyR96wOgpIvedozq+fHFf6ZT49SgVroshYs+5pQtRjjU5B6BuQnwLzm
         Yg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720740; x=1754325540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOICoi7S+RmHvt1B5Vpu4zl7Gq/1pJQJd2IAfflrwDs=;
        b=iPxD9w6leQw+rKbFlPPwknMPtWs2fUruGT/0kuix1dtYImS4VJO3E/EZaKTV7/Te2I
         uQHfS3PVHv2WhZhGXyMdLhNvv95bF3oEE/VpQGB12WGT9NCusKnMXxUIgVGREvdQvm9V
         B+cm6yXqS3ERyTWYwTYT1HVGyVGrIWV/8S4StGHfnrLh2S4OLG3H0l6u3biZxybQgaOn
         eDFi8MYoeRNmZkWKBicrrRfZ17LVCovFqzLgrE2sIgWzQLDJGPjkUEvKwA3GOwtW+Yuj
         Vyhq6jVBGyLs+WPWBBLQ4YYV/WlWfHfjqg6fuXtE29kXWm8GAxGZ217AP19WGw/drCoY
         4HbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUESFj/DYNjUPmNGjecgLo/z/Azl72619Pwd4lLHvblDkF0xD/7mVKdN2vaKw0o3xGt5n7UV73m@vger.kernel.org, AJvYcCX5BudL6NVoI5qXRXdhXXP/cfAy35padAKe6FD4x5chI9zRrQjS8NRnR/1ZnojlnlbNYGfBBBEOeDXf9l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCcgXPeJczbPh66g5d4ynyXZ6G3fmgCocuPvT5bsNIyfi/cNO
	JTgxXaD0wCcIPwnvQkmkI2ChH1HVfKArp5zwkjKpqUnY3U3u/zcsdXNQPm9QF6NrjwjuCY92Ov3
	SjTwhK3/RqzI6nnGJ1rqhuYhIuSG2IaY=
X-Gm-Gg: ASbGncsdGnfYM2iZQAzaZpm5vXlIxWE4Pl/S2q8XqYAJVBys93h34jf46rHvIbVqM2/
	eyG6jZ5AI7oHSNSOI+WYrcSgadxd1ediYsXCMpNUUdEwaOTfO9LVGz644VSwvBK8NHTVDzwC2p6
	yKWzDtheOoxc734FK99jcblxsZi+VvymyVDBQoAcT72lZZt1yjR+qjAgPpPSZMw+ZPab/exMy4G
	OUsCDrf
X-Google-Smtp-Source: AGHT+IFbnEkN4r3gcvVFaLSYUoforWTVYyBqtZ6tLhVbntqm/AKTQSG30IfM1xqlQPfTbgq6WbOAAGMKFKeeHf2XP9w=
X-Received: by 2002:a17:90b:33cd:b0:31e:e880:8b83 with SMTP id
 98e67ed59e1d1-31ee88093a3mr2500943a91.3.1753720739931; Mon, 28 Jul 2025
 09:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
 <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
 <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
 <CADnq5_PnktmP+0Hw0T04VkrkKoF_TGz5HOzRd1UZq6XOE0Rm1g@mail.gmail.com>
 <CADyq12x1f0VLjHKWEmfmis8oLncqSWxeTGs5wL0Xj2hua+onOQ@mail.gmail.com>
 <CADnq5_OhHpZDmV5J_5kA+avOdLrexnoRVCCCRddLQ=PPVAJsPQ@mail.gmail.com>
 <46bdb101-11c6-46d4-8224-b17d1d356504@amd.com> <CADnq5_PwyUwqdv1QG_O2XgvNnax+FNskuppBaKx8d0Kp582wXg@mail.gmail.com>
 <eff0ef03-d054-487e-b3bf-96bf394a3bf5@amd.com> <CADnq5_NvPsxmm8j0URD_B8a5gg9NQNX8VY0d93AqUDis46cdXA@mail.gmail.com>
 <aH90O93xJhD8PXWL@quatroqueijos.cascardo.eti.br> <c4f9dbe8-d224-478f-a91f-03a420333fde@amd.com>
In-Reply-To: <c4f9dbe8-d224-478f-a91f-03a420333fde@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 12:38:48 -0400
X-Gm-Features: Ac12FXyFwFc-78zoVaKBccykUvLP9mu9_gTtlG1-Z3x9hlWNNxrzXPYSW1CXW7k
Message-ID: <CADnq5_PFLuoe2fqn1YL984YPy2FU8SdJ0yWS5nmKFfsNwc324Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Leo Li <sunpeng.li@amd.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, Brian Geffon <bgeffon@google.com>, 
	"Wentland, Harry" <Harry.Wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	christian.koenig@amd.com, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	Yunxiang Li <Yunxiang.Li@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	Prike Liang <Prike.Liang@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>, 
	Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Garrick Evans <garrick@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:54=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2025-07-22 07:21, Thadeu Lima de Souza Cascardo wrote:
> > On Fri, Jul 18, 2025 at 07:00:39PM -0400, Alex Deucher wrote:
> >> On Fri, Jul 18, 2025 at 6:01=E2=80=AFPM Leo Li <sunpeng.li@amd.com> wr=
ote:
> >>>
> >>>
> >>>
> >>> On 2025-07-18 17:33, Alex Deucher wrote:
> >>>> On Fri, Jul 18, 2025 at 5:02=E2=80=AFPM Leo Li <sunpeng.li@amd.com> =
wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2025-07-18 16:07, Alex Deucher wrote:
> >>>>>> On Fri, Jul 18, 2025 at 1:57=E2=80=AFPM Brian Geffon <bgeffon@goog=
le.com> wrote:
> >>>>>>>
> >>>>>>> On Thu, Jul 17, 2025 at 10:59=E2=80=AFAM Alex Deucher <alexdeuche=
r@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Wed, Jul 16, 2025 at 8:13=E2=80=AFPM Brian Geffon <bgeffon@go=
ogle.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeuch=
er@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon=
@google.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexde=
ucher@gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeff=
on@google.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more=
 flexible (v2)")
> >>>>>>>>>>>>> allowed for newer ASICs to mix GTT and VRAM, this change al=
so noted that
> >>>>>>>>>>>>> some older boards, such as Stoney and Carrizo do not suppor=
t this.
> >>>>>>>>>>>>> It appears that at least one additional ASIC does not suppo=
rt this which
> >>>>>>>>>>>>> is Raven.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> We observed this issue when migrating a device from a 5.4 t=
o 6.6 kernel
> >>>>>>>>>>>>> and have confirmed that Raven also needs to be excluded fro=
m mixing GTT
> >>>>>>>>>>>>> and VRAM.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Can you elaborate a bit on what the problem is?  For carrizo=
 and
> >>>>>>>>>>>> stoney this is a hardware limitation (all display buffers ne=
ed to be
> >>>>>>>>>>>> in GTT or VRAM, but not both).  Raven and newer don't have t=
his
> >>>>>>>>>>>> limitation and we tested raven pretty extensively at the tim=
e.s
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks for taking the time to look. We have automated testing=
 and a
> >>>>>>>>>>> few igt gpu tools tests failed and after debugging we found t=
hat
> >>>>>>>>>>> commit 81d0bcf99009 is what introduced the failures on this h=
ardware
> >>>>>>>>>>> on 6.1+ kernels. The specific tests that fail are kms_async_f=
lips and
> >>>>>>>>>>> kms_plane_alpha_blend, excluding Raven from this sharing of G=
TT and
> >>>>>>>>>>> VRAM buffers resolves the issue.
> >>>>>>>>>>
> >>>>>>>>>> + Harry and Leo
> >>>>>>>>>>
> >>>>>>>>>> This sounds like the memory placement issue we discussed last =
week.
> >>>>>>>>>> In that case, the issue is related to where the buffer ends up=
 when we
> >>>>>>>>>> try to do an async flip.  In that case, we can't do an async f=
lip
> >>>>>>>>>> without a full modeset if the buffers locations are different =
than the
> >>>>>>>>>> last modeset because we need to update more than just the buff=
er base
> >>>>>>>>>> addresses.  This change works around that limitation by always=
 forcing
> >>>>>>>>>> display buffers into VRAM or GTT.  Adding raven to this case m=
ay fix
> >>>>>>>>>> those tests but will make the overall experience worse because=
 we'll
> >>>>>>>>>> end up effectively not being able to not fully utilize both gt=
t and
> >>>>>>>>>> vram for display which would reintroduce all of the problems f=
ixed by
> >>>>>>>>>> 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible =
(v2)").
> >>>>>>>>>
> >>>>>>>>> Thanks Alex, the thing is, we only observe this on Raven boards=
, why
> >>>>>>>>> would Raven only be impacted by this? It would seem that all de=
vices
> >>>>>>>>> would have this issue, no? Also, I'm not familiar with how
> >>>>>>>>
> >>>>>>>> It depends on memory pressure and available memory in each pool.
> >>>>>>>> E.g., initially the display buffer is in VRAM when the initial m=
ode
> >>>>>>>> set happens.  The watermarks, etc. are set for that scenario.  O=
ne of
> >>>>>>>> the next frames ends up in a pool different than the original.  =
Now
> >>>>>>>> the buffer is in GTT.  The async flip interface does a fast vali=
dation
> >>>>>>>> to try and flip as soon as possible, but that validation fails b=
ecause
> >>>>>>>> the watermarks need to be updated which requires a full modeset.
> >>>>>
> >>>>> Huh, I'm not sure if this actually is an issue for APUs. The fix th=
at introduced
> >>>>> a check for same memory placement on async flips was on a system wi=
th a DGPU,
> >>>>> for which VRAM placement does matter:
> >>>>> https://github.com/torvalds/linux/commit/a7c0cad0dc060bb77e9c9d235d=
68441b0fc69507
> >>>>>
> >>>>> Looking around in DM/DML, for APUs, I don't see any logic that chan=
ges DCN
> >>>>> bandwidth validation depending on memory placement. There's a gpuvm=
_enable flag
> >>>>> for SG, but it's statically set to 1 on APU DCN versions. It sounds=
 like for
> >>>>> APUs specifically, we *should* be able to ignore the mem placement =
check. I can
> >>>>> spin up a patch to test this out.
> >>>>
> >>>> Is the gpu_vm_support flag ever set for dGPUs?  The allowed domains
> >>>> for display buffers are determined by
> >>>> amdgpu_display_supported_domains() and we only allow GTT as a domain
> >>>> if gpu_vm_support is set, which I think is just for APUs.  In that
> >>>> case, we could probably only need the checks specifically for
> >>>> CHIP_CARRIZO and CHIP_STONEY since IIRC, they don't support mixed VR=
AM
> >>>> and GTT (only one or the other?).  dGPUs and really old APUs will
> >>>> always get VRAM, and newer APUs will get VRAM | GTT.
> >>>
> >>> It doesn't look like gpu_vm_support is set for DGPUs
> >>> https://elixir.bootlin.com/linux/v6.15.6/source/drivers/gpu/drm/amd/d=
isplay/amdgpu_dm/amdgpu_dm.c#L1866
> >>>
> >>> Though interestingly, further up at #L1858, Raven has gpu_vm_support =
=3D 0. Maybe it had stability issues?
> >>> https://github.com/torvalds/linux/commit/098c13079c6fdd44f10586b69132=
c392ebf87450
> >>
> >> We need to be a little careful here asic_type =3D=3D CHIP_RAVEN covers
> >> several variants:
> >> apu_flags & AMD_APU_IS_RAVEN - raven1 (gpu_vm_support =3D false)
> >> apu_flags & AMD_APU_IS_RAVEN2 - raven2 (gpu_vm_support =3D true)
> >> apu_flags & AMD_APU_IS_PICASSO - picasso (gpu_vm_support =3D true)
> >>
> >> amdgpu_display_supported_domains() only sets AMDGPU_GEM_DOMAIN_GTT if
> >> gpu_vm_support is true.  so we'd never get into the check in
> >> amdgpu_bo_get_preferred_domain() for raven1.
> >>
> >> Anyway, back to your suggestion, I think we can probably drop the
> >> checks as you should always get a compatible memory buffer due to
> >> amdgpu_bo_get_preferred_domain(). Pinning should fail if we can't pin
> >> in the required domain.  amdgpu_display_supported_domains() will
> >> ensure you always get VRAM or GTT or VRAM | GTT depending on what the
> >> chip supports.  Then amdgpu_bo_get_preferred_domain() will either
> >> leave that as is, or force VRAM or GTT for the STONEY/CARRIZO case.
> >> On the off chance we do get incompatible memory, something like the
> >> attached patch should do the trick.
>
> Thanks for the patch, this makes sense to me.
>
> Somewhat unrelated: I wonder if setting AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS=
 is necessary before
> bo_pin(). FWIU from chatting with our DCN experts, DCN doesn't really car=
e if the fb is
> contiguous or not.

Is this a APU statement or dGPU statement?  At least on older dGPUs,
they required contiguous VRAM.  This may not be an issue on newer
chips with DCHUB. At the moment, we use the FB aperture to access VRAM
directly in the kernel driver, so we do not set up page tables for
VRAM.  We'd need to do that to support linear mappings of
non-contiguous VRAM buffers in the kernel driver.  We do support it on
some MI chips, so it's doable, but it adds overhead.

>
> Which begs the question -- what exactly does AMDGPU_GEM_CREATE_VRAM_CONTI=
GUOUS mean? From git
> history, it seems setting this flag doesn't necessarily move the bo to be=
 congiguous. But
> rather:
>
>     When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
>     - This means contiguous is not mandatory.
>     - we will try to allocate the contiguous buffer. Say if the
>       allocation fails, we fallback to allocate the individual pages.
>
> https://github.com/torvalds/linux/commit/e362b7c8f8c7af00d06f0ab609629101=
aebae993
>
> Does that mean -- if the buffer is already in the required domain -- that=
 bo_pin() will also
> attempt to make it contiguous? Or will it just pin it from being moved an=
d leave it at that?
>

It means that the VRAM backing for the buffer will be physically contiguous=
.

> I guess in any case, it sounds like VRAM_CONTIGUOUS is not necessary for =
DCN scanout.
> I can give dropping it a spin and see if IGT complains.

That won't work unless we change how we manage VRAM in vmid0.  Right
now we use the FB aperture to directly access it, if we wanted to use
non-contiguous pages, we'd need to use page tables for VRAM as well.

Alex


>
> Thanks,
> Leo
>
> >>
> >> Alex
> >>
> >
> > Thanks for the patch, Alex.
> >
> > I have tested it, and though kms_async_flips and kms_plane_alpha_blend
> > pass, kms_plane_cursor still fail.
> >
> > I am going to investigate a little more today and send more details fro=
m my
> > findings.
> >
> > Thanks.
> > Cascardo.
> >
> >>
> >>>
> >>> - Leo
> >>>
> >>>>
> >>>> Alex
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Leo
> >>>>>
> >>>>>>>>
> >>>>>>>> It's tricky to fix because you don't want to use the worst case
> >>>>>>>> watermarks all the time because that will limit the number avail=
able
> >>>>>>>> display options and you don't want to force everything to a part=
icular
> >>>>>>>> memory pool because that will limit the amount of memory that ca=
n be
> >>>>>>>> used for display (which is what the patch in question fixed).  I=
deally
> >>>>>>>> the caller would do a test commit before the page flip to determ=
ine
> >>>>>>>> whether or not it would succeed before issuing it and then we'd =
have
> >>>>>>>> some feedback mechanism to tell the caller that the commit would=
 fail
> >>>>>>>> due to buffer placement so it would do a full modeset instead.  =
We
> >>>>>>>> discussed this feedback mechanism last week at the display hackf=
est.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> kms_plane_alpha_blend works, but does this also support that te=
st
> >>>>>>>>> failing as the cause?
> >>>>>>>>
> >>>>>>>> That may be related.  I'm not too familiar with that test either=
, but
> >>>>>>>> Leo or Harry can provide some guidance.
> >>>>>>>>
> >>>>>>>> Alex
> >>>>>>>
> >>>>>>> Thanks everyone for the input so far. I have a question for the
> >>>>>>> maintainers, given that it seems that this is functionally broken=
 for
> >>>>>>> ASICs which are iGPUs, and there does not seem to be an easy fix,=
 does
> >>>>>>> it make sense to extend this proposed patch to all iGPUs until a =
more
> >>>>>>> permanent fix can be identified? At the end of the day I'll take
> >>>>>>> functional correctness over performance.
> >>>>>>
> >>>>>> It's not functional correctness, it's usability.  All that is
> >>>>>> potentially broken is async flips (which depend on memory pressure=
 and
> >>>>>> buffer placement), while if you effectively revert the patch, you =
end
> >>>>>> up  limiting all display buffers to either VRAM or GTT which may e=
nd
> >>>>>> up causing the inability to display anything because there is not
> >>>>>> enough memory in that pool for the next modeset.  We'll start gett=
ing
> >>>>>> bug reports about blank screens and failure to set modes because o=
f
> >>>>>> memory pressure.  I think if we want a short term fix, it would be=
 to
> >>>>>> always set the worst case watermarks.  The downside to that is tha=
t it
> >>>>>> would possibly cause some working display setups to stop working i=
f
> >>>>>> they were on the margins to begin with.
> >>>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>>
> >>>>>>> Brian
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Thanks again,
> >>>>>>>>> Brian
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Alex
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Brian
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Alex
> >>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more=
 flexible (v2)")
> >>>>>>>>>>>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
> >>>>>>>>>>>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>>>>> Cc: stable@vger.kernel.org # 6.1+
> >>>>>>>>>>>>> Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.c=
om>
> >>>>>>>>>>>>> Signed-off-by: Brian Geffon <bgeffon@google.com>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> >>>>>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>>>>>>> index 73403744331a..5d7f13e25b7c 100644
> >>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>>>>>>> @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_doma=
in(struct amdgpu_device *adev,
> >>>>>>>>>>>>>                                             uint32_t domain=
)
> >>>>>>>>>>>>>  {
> >>>>>>>>>>>>>         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU=
_GEM_DOMAIN_GTT)) &&
> >>>>>>>>>>>>> -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev=
->asic_type =3D=3D CHIP_STONEY))) {
> >>>>>>>>>>>>> +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev=
->asic_type =3D=3D CHIP_STONEY) ||
> >>>>>>>>>>>>> +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> >>>>>>>>>>>>>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >>>>>>>>>>>>>                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG=
_THRESHOLD)
> >>>>>>>>>>>>>                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >>>>>>>>>>>>> --
> >>>>>>>>>>>>> 2.50.0.727.gbf7dc18ff4-goog
> >>>>>>>>>>>>>
> >>>>>
> >>>
> >
> >> From cce1652c62c42c858de64c306ea0ddc7af3bd0b1 Mon Sep 17 00:00:00 2001
> >> From: Alex Deucher <alexander.deucher@amd.com>
> >> Date: Fri, 18 Jul 2025 18:40:26 -0400
> >> Subject: [PATCH] drm/amd/display: refine framebuffer placement checks
> >>
> >> When we commit planes, we need to make sure the
> >> framebuffer memory locations are compatible. Various
> >> hardware has the following requirements for display buffers:
> >> dGPUs, old APUs, raven1 - must be in VRAM
> >> cazziro/stoney - must be in VRAM or GTT, but not both
> >> newer APUs (raven2/picasso and newer) - can be in VRAM or GTT
> >>
> >> You should always get a compatible memory buffer due to
> >> amdgpu_bo_get_preferred_domain(). amdgpu_display_supported_domains()
> >> will ensure you always get VRAM or GTT or VRAM | GTT depending on
> >> what the chip supports.  Then amdgpu_bo_get_preferred_domain()
> >> will either leave that as is when pinning, or force VRAM or GTT
> >> for the STONEY/CARRIZO case.
> >>
> >> As such the checks could probably be removed, but on the off chance
> >> we do end up getting different memory pool for the old
> >> and new framebuffers, refine the check to take into account the
> >> hardware capabilities.
> >>
> >> Fixes: a7c0cad0dc06 ("drm/amd/display: ensure async flips are only acc=
epted for fast updates")
> >> Reported-by: Brian Geffon <bgeffon@google.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++++++++--=
-
> >>  1 file changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 129476b6d5fa9..de2bd789ec15b 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -9288,6 +9288,18 @@ static void amdgpu_dm_enable_self_refresh(struc=
t amdgpu_crtc *acrtc_attach,
> >>      }
> >>  }
> >>
> >> +static bool amdgpu_dm_mem_type_compatible(struct amdgpu_device *adev,
> >> +                                      struct drm_framebuffer *old_fb,
> >> +                                      struct drm_framebuffer *new_fb)
> >> +{
> >> +    if (!adev->mode_info.gpu_vm_support ||
> >> +        (adev->asic_type =3D=3D CHIP_CARRIZO) ||
> >> +        (adev->asic_type =3D=3D CHIP_STONEY))
> >> +            return get_mem_type(old_fb) =3D=3D get_mem_type(new_fb);
> >> +
> >> +    return true;
> >> +}
> >> +
> >>  static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> >>                                  struct drm_device *dev,
> >>                                  struct amdgpu_display_manager *dm,
> >> @@ -9465,7 +9477,7 @@ static void amdgpu_dm_commit_planes(struct drm_a=
tomic_state *state,
> >>               */
> >>              if (crtc->state->async_flip &&
> >>                  (acrtc_state->update_type !=3D UPDATE_TYPE_FAST ||
> >> -                 get_mem_type(old_plane_state->fb) !=3D get_mem_type(=
fb)))
> >> +                 !amdgpu_dm_mem_type_compatible(dm->adev, old_plane_s=
tate->fb, fb)))
> >>                      drm_warn_once(state->dev,
> >>                                    "[PLANE:%d:%s] async flip with non-=
fast update\n",
> >>                                    plane->base.id, plane->name);
> >> @@ -9473,7 +9485,7 @@ static void amdgpu_dm_commit_planes(struct drm_a=
tomic_state *state,
> >>              bundle->flip_addrs[planes_count].flip_immediate =3D
> >>                      crtc->state->async_flip &&
> >>                      acrtc_state->update_type =3D=3D UPDATE_TYPE_FAST =
&&
> >> -                    get_mem_type(old_plane_state->fb) =3D=3D get_mem_=
type(fb);
> >> +                    amdgpu_dm_mem_type_compatible(dm->adev, old_plane=
_state->fb, fb);
> >>
> >>              timestamp_ns =3D ktime_get_ns();
> >>              bundle->flip_addrs[planes_count].flip_timestamp_in_us =3D=
 div_u64(timestamp_ns, 1000);
> >> @@ -11760,6 +11772,7 @@ static bool amdgpu_dm_crtc_mem_type_changed(st=
ruct drm_device *dev,
> >>                                          struct drm_atomic_state *stat=
e,
> >>                                          struct drm_crtc_state *crtc_s=
tate)
> >>  {
> >> +    struct amdgpu_device *adev =3D drm_to_adev(dev);
> >>      struct drm_plane *plane;
> >>      struct drm_plane_state *new_plane_state, *old_plane_state;
> >>
> >> @@ -11773,7 +11786,8 @@ static bool amdgpu_dm_crtc_mem_type_changed(st=
ruct drm_device *dev,
> >>              }
> >>
> >>              if (old_plane_state->fb && new_plane_state->fb &&
> >> -                get_mem_type(old_plane_state->fb) !=3D get_mem_type(n=
ew_plane_state->fb))
> >> +                !amdgpu_dm_mem_type_compatible(adev, old_plane_state-=
>fb,
> >> +                                               new_plane_state->fb))
> >>                      return true;
> >>      }
> >>
> >> --
> >> 2.50.1
> >>
> >
>
>

