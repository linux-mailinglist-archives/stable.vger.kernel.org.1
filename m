Return-Path: <stable+bounces-89709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBE59BB8AC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AAA1F2232B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861481BE238;
	Mon,  4 Nov 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOh5D6sV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD34A08;
	Mon,  4 Nov 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733159; cv=none; b=WpYSfalhvHyqJUzJHZeQlAW/K7+wtGumtZJ2+RRsW10Tt7fCe2QJT72erRd+/hjKEh33sQHXBUQGEyTkodZK1YN2C5nThg0A7SXtbbPdacutkFLYRJCEXxen+Gob6wVqWG8R31qNmvkIWkQhXySj71BPMlTujDOEXLD5YaVe53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733159; c=relaxed/simple;
	bh=QcNuwWfbczk+E+5MT8TaTZWOIKC6RH2KHUsuZhOYL6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZtmmb+RhVmw5Z8XNWm/bFI1kbPqWZ72cFhjcGR+Af997sFPsUlbDT6gDwhj9Az5DYLNe3pNJ+nt6jLKb0b6alEpzYSGKyJvK1rGVutINIcGNIcfF2Jx38u6WwZPecYlrXcxvppww6RFftS4RNv6afoh0KUHQNZTdgI/LU9Cp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOh5D6sV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso755641a91.2;
        Mon, 04 Nov 2024 07:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730733156; x=1731337956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KviHfL3GhPgk1194ewkZ7Elw3O84xMVSBocbCkmPTLs=;
        b=gOh5D6sV3UwJ/nahfiLOz2Z21AaNZU3wL+MIkVedxBw09X6Y+VnNXy8hKDrjan4v6x
         lXJppJBSXSnQ8gEA/r2hkR/DToCroFCn/hStqCoH4+KyAK/D2ZLCnyU0dAixvm9bV4Xa
         N0rU2Ig9jgv4FgDBk3XE8FGmuYBh05BHInQY9cTIDDZ2AaL01b9kCMCv4I4CH3NYfmlg
         XRa+JzUANbQxtYAuPRjVKkPXLynaWc8j0spxXJdUi4HpMnta73sXSriB0fAU8aDTbJqR
         jKfxuRR3M7eiCp5ejMIWdmbVkTLpwGhynyNxWx/kFYveW9zzei7OutiDRavyI5Fq1Otx
         KLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733156; x=1731337956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KviHfL3GhPgk1194ewkZ7Elw3O84xMVSBocbCkmPTLs=;
        b=riSklfJG3yfw+3iJ4t6pPKHRu3oBm0CvA00m6YiFvkQciTW7pHpOC58MGiu+H6s26X
         4w6yLObyIOyOPvBO4DDMAZVTbelB2JH1pqUm3ylJGl6sm9IK+LlAS6PeYNYjN+zajHTH
         vr1Yw0l/emyOYPbTjUoirCUJW14HqJgwX6z1Ib80l8Aaeo1QmJBr23HmWsf0p4UoViM5
         cfoE4SQTq9zUoMoKrcOrzNeex9kqC3pFhUrRdwOxDRys10dQJeZwqtv4yWT6wMqcdIX2
         TZ4AZM0+6NjyjzA22S/ZkyA7KLDmuVSon6Thy6p2O550iuMCrA7Nr3iOw06JlV+mM8v5
         3fkg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0+M6mlKvS1TmYoS8HI0giIjxP09Y5sypIKK1K6FZr+Rac6uTAKdAnK84olH5y3fi4XfEnuXJ@vger.kernel.org, AJvYcCVAXeibTObmicbQ9qnJgyUALr7CmW3pPHFxqb2e+X7QXXeuq0IPyc4qrrWk77m2qlfXadFJP4RQB0LTqlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KxwpO2NnduCtmdAv8jaepLL1Qq8jDbsz00FoTBMJDjFCzzUS
	/o7v3CQ6VdZbO/PS8CnSgaPyqFWnSYSQ4iSc2CeKZeLlcYwzmlKmFGeCmj5I04b0Sjip1LmnSEL
	rtnp0bvF4rHRe/yiXipbxKwvHo9Y=
X-Google-Smtp-Source: AGHT+IH6q+c/r/8XZVBV6BuFehgtpcxWK806Z2lT5bLMqawbzEthFokNLqHNCackCtMD0b/aN73UxVUip01R2w8zoec=
X-Received: by 2002:a17:90b:3b48:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e8f0f4ccbdmr16257661a91.1.1730733155852; Mon, 04 Nov 2024
 07:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029133141.45335-1-pchelkin@ispras.ru> <ZyDvOdEuxYh7jK5l@sashalap>
 <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru> <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>
In-Reply-To: <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Nov 2024 10:12:24 -0500
Message-ID: <CADnq5_OR9T5Ocxu6pRu38uzdmcV7_um_6aK4vYefhMiZ0gJJSA@mail.gmail.com>
Subject: Re: [PATCH 0/1] On DRM -> stable process
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	Mario Limonciello <mario.limonciello@amd.com>, Jonathan Gray <jsg@jsg.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:55=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru> =
wrote:
>
> On Tue, 29. Oct 18:12, Fedor Pchelkin wrote:
> > On Tue, 29. Oct 10:20, Sasha Levin wrote:
> > > On Tue, Oct 29, 2024 at 04:31:40PM +0300, Fedor Pchelkin wrote:
> > > > BTW, a question to the stable-team: what Git magic (3-way-merge?) l=
et the
> > > > duplicate patch be applied successfully? The patch context in stabl=
e trees
> > > > was different to that moment so should the duplicate have been expe=
cted to
> > > > fail to be applied?
> > >
> > > Just plain git... Try it yourself :)
> > >
> > > $ git checkout 282f0a482ee6
> > > HEAD is now at 282f0a482ee61 drm/amd/display: Skip Recompute DSC Para=
ms if no Stream on Link
> > >
> > > $ git cherry-pick 7c887efda1
> >
> > 7c887efda1 is the commit backported to linux-6.1.y. Of course it will a=
pply
> > there.
> >
> > What I mean is that the upstream commit for 7c887efda1 is 8151a6c13111b=
465dbabe07c19f572f7cbd16fef.
> >
> > And cherry-picking 8151a6c13111b465dbabe07c19f572f7cbd16fef to linux-6.=
1.y
> > on top of 282f0a482ee6 will not result in duplicating the change, at le=
ast
> > with my git configuration.
> >
> > I just don't understand how a duplicating if-statement could be produce=
d in
> > result of those cherry-pick'ings and how the content of 7c887efda1 was
> > generated.
> >
> > $ git checkout 282f0a482ee6
> > HEAD is now at 282f0a482ee6 drm/amd/display: Skip Recompute DSC Params =
if no Stream on Link
> >
> > $ git cherry-pick 8151a6c13111b465dbabe07c19f572f7cbd16fef
> > Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.=
c
> > HEAD detached at 282f0a482ee6
> > You are currently cherry-picking commit 8151a6c13111.
> >   (all conflicts fixed: run "git cherry-pick --continue")
> >   (use "git cherry-pick --skip" to skip this patch)
> >   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
> > The previous cherry-pick is now empty, possibly due to conflict resolut=
ion.
> > If you wish to commit it anyway, use:
> >
> >     git commit --allow-empty
> >
> > Otherwise, please use 'git cherry-pick --skip'
>
> Sasha,
>
> my concern is that maybe there is some issue with the scripts used for th=
e
> preparation of backport patches.
>
> There are two different upstream commits performing the exact same change=
:
> - 50e376f1fe3bf571d0645ddf48ad37eb58323919
> - 8151a6c13111b465dbabe07c19f572f7cbd16fef

There were cases where I needed to cherry-pick fixes from -next to
-fixes.  In the past I had not used -x when cherry-picking because I
got warnings about references to commits that were not yet in
mainline.  I have since started using -x when cherry-picking things
from -next to -fixes.

Alex

>
> 50e376f1fe3bf571d0645ddf48ad37eb58323919 was backported to stable kernels
> at first. After that, attempts to backport 8151a6c13111b465dbabe07c19f572=
f7cbd16fef
> to those stables should be expected to fail, no? Git would have complaine=
d
> about this - the patch was already applied.
>
> It is just strange that the (exact same) change made by the commits is
> duplicated by backporting tools. As it is not the first case where DRM
> patches are involved per Greg's statement [1], I wonder if something can =
be
> done on stable-team's side to avoid such odd behavior in future.
>
> [1]: https://lore.kernel.org/stable/20241007035711.46624-1-jsg@jsg.id.au/=
T/#u
>
> --
> Thanks,
> Fedor

