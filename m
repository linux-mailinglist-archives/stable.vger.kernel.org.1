Return-Path: <stable+bounces-70372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE93960D66
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6FBB21C05
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B65D1C4607;
	Tue, 27 Aug 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqau8kJw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB033E8
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768321; cv=none; b=sPaalscTEuxpXr1tuYVPMHEwzU0AJPjS1PXkCbl8kWbd7iu4z41t8iqPGJqFJk75STBzifSjI+89v+elGGfiVLrTqYuHeyTqLTOr6YYAR0TlaFWpElcfez8vLziTRm4tL2FpqsdiJac6G6DdU83p5GLSBpN+Z6iqQAmmSijXQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768321; c=relaxed/simple;
	bh=UKnl0EcKOYffxxpmbNckKPSMHac6VQM0xSV14iXeG6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thcuD3fQ6I8HC/zBdDNUk88gpK3Zxo8tthFLosP1jjxlrTas5ZRjpmJFYbG8HxIBrk8qQ3anSnWiYQp9NRhVsPfZe09RxNC4atTvIlPBrJ8CV/ebClzmirs4RCW3udoLsVdmVdTguCDVDcVxcjCPASwlzzQnEZsIt7BLJWNATGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqau8kJw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201f577d35aso3903475ad.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768319; x=1725373119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjBmWerqC6TUh045gIHyLYQ6+zsOtBpX2XwcFqpm9Rw=;
        b=Aqau8kJw4uM00R0f2aSZgdsE+yqGztMJU0iTqzDiXfUYh+M0hrxEzspo+twY+GH+GU
         wlpc1Zhr5bV0GLOPhxdPE2I5VovJqlqMgrWD3wjTv6Ipov5OU+CzKeVLtxxsFiZ+yLzJ
         jLK43Q7xPdTrUvN0KGeOLlhUqnCjmfcO4UKlY+zVYdV4IjMaQ6gjIWr3Xpb/5K05+e3u
         i/DAQLtBwUU5llA42qMl3I2tnGdon75eLeARuRrwCYcRL/bsDh2JOg1IQahLxPWRqyNA
         A2xfcza5pRCjpu0B+vINci3XBmtixD0/vsP1e+M53AQ7kxvTc/S/x11fLD9qIenry0zJ
         velA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768319; x=1725373119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjBmWerqC6TUh045gIHyLYQ6+zsOtBpX2XwcFqpm9Rw=;
        b=v74Ny5zbL7l2NosHfxBvLJhJZhP9n4aDM7wUg0dNciNIYi8UzlZTd1j0La0YR+0KBB
         J0mTgJLoKFx/tY9bxPrJQAHCCnMl6VCEa0tj/hU8iPg3cvw83PvAySZ+9uOdtjvJa8fW
         GiO15eIiblw+j1lg8asdgCfAbIj/WbOjAf+x4E3sLwv88oSPQva+twhtrNci/AhqYpIg
         wrzV+ZJptaM9D98TZMOw/ZO49eGIWKKxOLFDZISVKsBU6X3GYlg4RSVsJtMy9jS1yhci
         sydiFOc+jhEY/Q/zQEt4o5Od4ejE9VYo+uC2uN0DLhlLtVb5zFDyUNMdEYnQp1Kevu8h
         JMnw==
X-Forwarded-Encrypted: i=1; AJvYcCVNRtzQpVEoYDrbDzTNEcGk5Hr5vRJzLrQDsf50FEuVtRKFAZbDIkvFDYJn52zcCDI1Sj0vudA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uR3hFaui/t+RFWLTwxNGejkSBmv318N/vIsLfM/WhXcQMhxp
	wT2kPspJa+TUvzGxzefGAzzXG2xPxMtjxzgCrc2Krme+gSa8pSWDsadYGWmdUeWeJbXvrTwBp11
	wjfZTWF7GiEMAw+FllP/YeOGSRuTXofgT
X-Google-Smtp-Source: AGHT+IGAgkTOlcRp7zgYGJNflHX7StCIJ0sZFV05To4fRH2E6W++LasaeiKxJ4pOOL9eLGayn3aXBSXt7wJHqgRRQuo=
X-Received: by 2002:a17:903:32c1:b0:202:18d7:7ffb with SMTP id
 d9443c01a7336-2039e703c29mr91695645ad.11.1724768318865; Tue, 27 Aug 2024
 07:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh> <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh> <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
In-Reply-To: <2024082439-extending-dramatize-09ca@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Aug 2024 10:18:27 -0400
Message-ID: <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 1:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> > On Thu, Aug 15, 2024 at 1:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > > On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.kuehl=
ing@amd.com> wrote:
> > > > >
> > > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > As some of you have noticed, there's a TON of failure messages =
being
> > > > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > > > backports.  In short, you all are doing something really wrong =
with how
> > > > > > you are tagging these.
> > > > > Hi Greg,
> > > > >
> > > > > I got notifications about one KFD patch failing to apply on six b=
ranches
> > > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that yo=
u
> > > > > already applied this patch on two branches back in May. The email=
s had a
> > > > > suspicious looking date in the header (Sep 17, 2001). I wonder if=
 there
> > > > > was some date glitch that caused a whole bunch of patches to be r=
e-sent
> > > > > to stable somehow:
> > > >
> > > > I think the crux of the problem is that sometimes patches go into
> > > > -next with stable tags and they end getting taken into -fixes as we=
ll
> > > > so after the merge window they end up getting picked up for stable
> > > > again.  Going forward, if they land in -next, I'll cherry-pick -x t=
he
> > > > changes into -fixes so there is better traceability.
> > >
> > > Please do so, and also work to not have duplicate commits like this i=
n
> > > different branches.  Git can handle merges quite well, please use it.
> > >
> > > If this shows up again in the next -rc1 merge window without any
> > > changes, I'll have to just blackhole all amd drm patches going forwar=
d
> > > until you all tell me you have fixed your development process.
> >
> > Just a heads up, you will see some of these when the 6.12 merge window
> > due to what is currently in -next and the fixes that went into 6.11,
> > but going forward we have updated our process and it should be better.
>
> Can you give me a list of the git ids that I should be ignoring for
> 6.12-rc1?  Otherwise again, it's a huge waste of time on my side trying
> to sift through them and figure out if the rejection is real or not...

8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on Lin=
k
fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
math_ceil2
295d91cbc700 drm/amd/display: Check for NULL pointer
6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_common_=
modes

Thanks.

Alex

>
> thanks,
>
> greg k-h

