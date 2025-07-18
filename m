Return-Path: <stable+bounces-163405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71334B0AB7C
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D535C1C823FD
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C1F1F1302;
	Fri, 18 Jul 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBdnZ2zU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA642AA4;
	Fri, 18 Jul 2025 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874418; cv=none; b=mpRWx1qhpI8EStQ/wI6alzF21KDT+VTu6jtUSrQ4iDV7tCMmA+JZPRFJ2BzAoYE33ER8yXr3U4gL6j2NmVskyFhY2a5oBiO06pTTGJ4cBxF1iecNpuqpm2oVsp2gKi2vO0vWj8s7/HCd2b3eqKFQd5Q7fSE0kBAxXAp2A7m8AE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874418; c=relaxed/simple;
	bh=VrEaJ/9ZactHC7hCI/EQfh2oD9MAyT93Od6m9zcQJHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkh9NKyyjHBgNUVZU9XQerMIzWsYK9T56C+zNqm0EXTRIpCZXRc+NnF6CWe4L63Ca7dX0bpoCaS768Vh3V40rSaKGFw2pecByIGWl1VHiTV4yCdX+RuDzcEtF7bxZ9lVNQNdwKHK5/73essHPsVSjp1BKAPy9Jiq4aI9kwZtQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBdnZ2zU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313290ea247so435968a91.3;
        Fri, 18 Jul 2025 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752874416; x=1753479216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoIYDGKLLqrTTBTd5BbrrJCdf1AKBXPDRxeJuKHonXI=;
        b=LBdnZ2zUAsCYpy4+nLYdWipGw2mgx17fPdze/h31yIVgt7sYlesvgBhTFs0wHt3dPF
         7mXmeOsA4pcELCcR4xpVL4+cpse2/0qxWRyIliFzuKepz6c40Gsdq/azunQ3mtq1SvU0
         ipUXEBiBLmWw8iT3BQE/f5G5AjDQwqa+nGTcZzbmDhLc8AHCTYI8z/2xqxKVOk/aJk4P
         ZKSPFK9fu/Fp0MMEMkE14NbP5pC9gAGmqT39QKZOYR0TemCgJpsaWzsCjdWlCsLShuih
         0YCNsErSO0E5F13I5eEHZzyq0PBUhyKsLt5RfHLBtRrXnHGy7irGnoMyaHrkNAxcwHgN
         sMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752874416; x=1753479216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoIYDGKLLqrTTBTd5BbrrJCdf1AKBXPDRxeJuKHonXI=;
        b=TdNYaQ3cRn2uTG1rD0L/ypkV31dguOziH0b9gGtHdH+Rllsv3bQysbqcY3Z1NfU1Ih
         uHTxoYvIiZ1NFV/hLtcm6KXJRViiDGt18PcPLdsrfnQoD6nb/S8rMlKUAoYQn8/Dpzdh
         w7Abyw/1L9APRhcSo5LKZQVXcNotezoXJHwrrs0MSP9LDeZqz1Y2WB6BtaVscSN2K1QQ
         d9ixhKq4B8t6lHZXSFe/Om5YtYfDHJasp/038cKbnOU880Y2EB70kllX/B8fSkAzsNv2
         wbMBGIiE0MTz5NpRU+AA6gYnhXJEsy/8ADz8rpS3aCbvu9kJ+0el9h9utWLZAxbKHyz0
         jatw==
X-Forwarded-Encrypted: i=1; AJvYcCUGIbvKt9Jl1bzguDmXw1SZysZvCmZVUF8knXmn1A30Hveho6rWiuv+GmGSUHE3Ta1drjeVnywx@vger.kernel.org, AJvYcCVPRU2NGcrrgKIpgpzvOnpxaLFyFRgTE9/IbRmp517PG/xLiEcm0FncbyHLJQ42QA6CFUELXDIjEj0D9EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5N4fwT7zOPtxeCEmBdzwc/ShPg3DIHdH5tb6VlqSV0SILzAi
	TDZNbJunnH14ZBayS4TPscs5asepkshaq/MbFpCM6kMUicaX1uo+Wi85gxS95i+Nmr1P3XBnS35
	IUhwNN3CSk2YHtRmS91hQbvfB9uMN+0k=
X-Gm-Gg: ASbGncuUcXApD0amcgO7tzGa/j8+0w5kdr5fOE5WhPIy4as6eow3ahnUzG14jokinl1
	L64Wtv87ygmiLm4tJgL8o7/yCcOPxqDdM2odSfenanDQtANArvapks3ZHg+9kih+jigTvDTERiK
	pgyy0vCIS7TPLD5jKkmHaRZzV8hEGXiZzLyAl5u/BEJqoXD5qIhR/4oIV4ecT2VN7/ZBTNC5orn
	to+W/iq
X-Google-Smtp-Source: AGHT+IHU2JSE89KSCWIpL1y/r6ms7fHsS3K0doT7RmW43FYab/R6yrVVLWjf/Od5m6rrisBKH/bQrIiioOQ6VMvs8zU=
X-Received: by 2002:a17:90b:562c:b0:312:25dd:1c8a with SMTP id
 98e67ed59e1d1-31c9e6e8348mr6900316a91.2.1752874415748; Fri, 18 Jul 2025
 14:33:35 -0700 (PDT)
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
 <CADnq5_OhHpZDmV5J_5kA+avOdLrexnoRVCCCRddLQ=PPVAJsPQ@mail.gmail.com> <46bdb101-11c6-46d4-8224-b17d1d356504@amd.com>
In-Reply-To: <46bdb101-11c6-46d4-8224-b17d1d356504@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 17:33:23 -0400
X-Gm-Features: Ac12FXz-nxT-qipwHyJfrv-oShNo004MePvSSyOOpDWDZE0ppLe817Q9ewZxIsw
Message-ID: <CADnq5_PwyUwqdv1QG_O2XgvNnax+FNskuppBaKx8d0Kp582wXg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:02=E2=80=AFPM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2025-07-18 16:07, Alex Deucher wrote:
> > On Fri, Jul 18, 2025 at 1:57=E2=80=AFPM Brian Geffon <bgeffon@google.co=
m> wrote:
> >>
> >> On Thu, Jul 17, 2025 at 10:59=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> >>>
> >>> On Wed, Jul 16, 2025 at 8:13=E2=80=AFPM Brian Geffon <bgeffon@google.=
com> wrote:
> >>>>
> >>>> On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@gm=
ail.com> wrote:
> >>>>>
> >>>>> On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@goog=
le.com> wrote:
> >>>>>>
> >>>>>> On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher=
@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@go=
ogle.com> wrote:
> >>>>>>>>
> >>>>>>>> Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flex=
ible (v2)")
> >>>>>>>> allowed for newer ASICs to mix GTT and VRAM, this change also no=
ted that
> >>>>>>>> some older boards, such as Stoney and Carrizo do not support thi=
s.
> >>>>>>>> It appears that at least one additional ASIC does not support th=
is which
> >>>>>>>> is Raven.
> >>>>>>>>
> >>>>>>>> We observed this issue when migrating a device from a 5.4 to 6.6=
 kernel
> >>>>>>>> and have confirmed that Raven also needs to be excluded from mix=
ing GTT
> >>>>>>>> and VRAM.
> >>>>>>>
> >>>>>>> Can you elaborate a bit on what the problem is?  For carrizo and
> >>>>>>> stoney this is a hardware limitation (all display buffers need to=
 be
> >>>>>>> in GTT or VRAM, but not both).  Raven and newer don't have this
> >>>>>>> limitation and we tested raven pretty extensively at the time.
> >>>>>>
> >>>>>> Thanks for taking the time to look. We have automated testing and =
a
> >>>>>> few igt gpu tools tests failed and after debugging we found that
> >>>>>> commit 81d0bcf99009 is what introduced the failures on this hardwa=
re
> >>>>>> on 6.1+ kernels. The specific tests that fail are kms_async_flips =
and
> >>>>>> kms_plane_alpha_blend, excluding Raven from this sharing of GTT an=
d
> >>>>>> VRAM buffers resolves the issue.
> >>>>>
> >>>>> + Harry and Leo
> >>>>>
> >>>>> This sounds like the memory placement issue we discussed last week.
> >>>>> In that case, the issue is related to where the buffer ends up when=
 we
> >>>>> try to do an async flip.  In that case, we can't do an async flip
> >>>>> without a full modeset if the buffers locations are different than =
the
> >>>>> last modeset because we need to update more than just the buffer ba=
se
> >>>>> addresses.  This change works around that limitation by always forc=
ing
> >>>>> display buffers into VRAM or GTT.  Adding raven to this case may fi=
x
> >>>>> those tests but will make the overall experience worse because we'l=
l
> >>>>> end up effectively not being able to not fully utilize both gtt and
> >>>>> vram for display which would reintroduce all of the problems fixed =
by
> >>>>> 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)"=
).
> >>>>
> >>>> Thanks Alex, the thing is, we only observe this on Raven boards, why
> >>>> would Raven only be impacted by this? It would seem that all devices
> >>>> would have this issue, no? Also, I'm not familiar with how
> >>>
> >>> It depends on memory pressure and available memory in each pool.
> >>> E.g., initially the display buffer is in VRAM when the initial mode
> >>> set happens.  The watermarks, etc. are set for that scenario.  One of
> >>> the next frames ends up in a pool different than the original.  Now
> >>> the buffer is in GTT.  The async flip interface does a fast validatio=
n
> >>> to try and flip as soon as possible, but that validation fails becaus=
e
> >>> the watermarks need to be updated which requires a full modeset.
>
> Huh, I'm not sure if this actually is an issue for APUs. The fix that int=
roduced
> a check for same memory placement on async flips was on a system with a D=
GPU,
> for which VRAM placement does matter:
> https://github.com/torvalds/linux/commit/a7c0cad0dc060bb77e9c9d235d68441b=
0fc69507
>
> Looking around in DM/DML, for APUs, I don't see any logic that changes DC=
N
> bandwidth validation depending on memory placement. There's a gpuvm_enabl=
e flag
> for SG, but it's statically set to 1 on APU DCN versions. It sounds like =
for
> APUs specifically, we *should* be able to ignore the mem placement check.=
 I can
> spin up a patch to test this out.

Is the gpu_vm_support flag ever set for dGPUs?  The allowed domains
for display buffers are determined by
amdgpu_display_supported_domains() and we only allow GTT as a domain
if gpu_vm_support is set, which I think is just for APUs.  In that
case, we could probably only need the checks specifically for
CHIP_CARRIZO and CHIP_STONEY since IIRC, they don't support mixed VRAM
and GTT (only one or the other?).  dGPUs and really old APUs will
always get VRAM, and newer APUs will get VRAM | GTT.

Alex

>
> Thanks,
> Leo
>
> >>>
> >>> It's tricky to fix because you don't want to use the worst case
> >>> watermarks all the time because that will limit the number available
> >>> display options and you don't want to force everything to a particula=
r
> >>> memory pool because that will limit the amount of memory that can be
> >>> used for display (which is what the patch in question fixed).  Ideall=
y
> >>> the caller would do a test commit before the page flip to determine
> >>> whether or not it would succeed before issuing it and then we'd have
> >>> some feedback mechanism to tell the caller that the commit would fail
> >>> due to buffer placement so it would do a full modeset instead.  We
> >>> discussed this feedback mechanism last week at the display hackfest.
> >>>
> >>>
> >>>> kms_plane_alpha_blend works, but does this also support that test
> >>>> failing as the cause?
> >>>
> >>> That may be related.  I'm not too familiar with that test either, but
> >>> Leo or Harry can provide some guidance.
> >>>
> >>> Alex
> >>
> >> Thanks everyone for the input so far. I have a question for the
> >> maintainers, given that it seems that this is functionally broken for
> >> ASICs which are iGPUs, and there does not seem to be an easy fix, does
> >> it make sense to extend this proposed patch to all iGPUs until a more
> >> permanent fix can be identified? At the end of the day I'll take
> >> functional correctness over performance.
> >
> > It's not functional correctness, it's usability.  All that is
> > potentially broken is async flips (which depend on memory pressure and
> > buffer placement), while if you effectively revert the patch, you end
> > up  limiting all display buffers to either VRAM or GTT which may end
> > up causing the inability to display anything because there is not
> > enough memory in that pool for the next modeset.  We'll start getting
> > bug reports about blank screens and failure to set modes because of
> > memory pressure.  I think if we want a short term fix, it would be to
> > always set the worst case watermarks.  The downside to that is that it
> > would possibly cause some working display setups to stop working if
> > they were on the margins to begin with.
> >
> > Alex
> >
> >>
> >> Brian
> >>
> >>>
> >>>>
> >>>> Thanks again,
> >>>> Brian
> >>>>
> >>>>>
> >>>>> Alex
> >>>>>
> >>>>>>
> >>>>>> Brian
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flex=
ible (v2)")
> >>>>>>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
> >>>>>>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>> Cc: stable@vger.kernel.org # 6.1+
> >>>>>>>> Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> >>>>>>>> Signed-off-by: Brian Geffon <bgeffon@google.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> >>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>> index 73403744331a..5d7f13e25b7c 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>>> @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(st=
ruct amdgpu_device *adev,
> >>>>>>>>                                             uint32_t domain)
> >>>>>>>>  {
> >>>>>>>>         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_=
DOMAIN_GTT)) &&
> >>>>>>>> -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asi=
c_type =3D=3D CHIP_STONEY))) {
> >>>>>>>> +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asi=
c_type =3D=3D CHIP_STONEY) ||
> >>>>>>>> +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> >>>>>>>>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >>>>>>>>                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRE=
SHOLD)
> >>>>>>>>                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >>>>>>>> --
> >>>>>>>> 2.50.0.727.gbf7dc18ff4-goog
> >>>>>>>>
>

