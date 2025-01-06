Return-Path: <stable+bounces-106776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829FA01E87
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 05:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37DC3A031E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 04:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD4198A2F;
	Mon,  6 Jan 2025 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="Fi2UU51g"
X-Original-To: stable@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5971925AE;
	Mon,  6 Jan 2025 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736137897; cv=none; b=YttDGhnVMxHNkZ1ELywyBoze2z716bCoZil7xMmQS5RC+FUhKnabzrI9TxRMyzZoXyvZ15hUASR8qMvaJ5941PDjDVolo6dGSSDq6lUTap68CL2bNy0doeSVigbT/3IsUPBTB8I2SluFosB4IuyC8eVooPnoMwk8qOB5cYY1+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736137897; c=relaxed/simple;
	bh=6qHr8IEARPNhqSU1wZBWFqlZVqZ63jCI8dv0qaCgp3c=;
	h=Date:To:Cc:Subject:References:In-Reply-To:MIME-Version:
	 Content-Type:Message-Id:From; b=MYSuz0e9GdfAvJ2Ug1dY10WVnk/OVmwMSOG1kHD156NPAfu6MUXYCZUqIs6A5yjDNjOsbo6Xz8d+2VlMGU6Z/VjD3KCf/nOsUhu/jmA1WF0mWSPk80KFsOrvVEEZxP5ZqH871SgBJVL53FOsMmARHHTgtUgE/oFI2z6ebK4hIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=Fi2UU51g; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from panix2.panix.com (panix2.panix.com [166.84.1.2])
	by mailbackend.panix.com (Postfix) with ESMTP id 4YRLq93lF6z45Hg;
	Sun,  5 Jan 2025 23:31:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1736137893; bh=6qHr8IEARPNhqSU1wZBWFqlZVqZ63jCI8dv0qaCgp3c=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From;
	b=Fi2UU51g5Rf4hWPRSEi2OcfjSIJJ9bIAyiL9QpQoJiVrrlnCzaAqE5TRGYkn4R8Zg
	 yf08mo2eTtmmTbzFyDSI/KOcY/5rz5KnLo3SqtAj7WZa26+Z8jkjlgsIjCalGr2FP+
	 bWHBbFdwT5Tcs3EiJdpG0PMuIaeshIXSsjeF1jdE=
Received: by panix2.panix.com (Postfix, from userid 19171)
	id 4YRLq93qSpz1ZSy; Sun,  5 Jan 2025 23:31:33 -0500 (EST)
Date: Mon, 06 Jan 2025 04:31:33 +0000
To: me@svmhdvn.name, alexdeucher@gmail.com
Cc: pa@panix.com, Xinhui.Pan@amd.com, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: Re: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
References: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
 <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
In-Reply-To: <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
User-Agent: nail 11.25 7/29/05
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <4YRLq93qSpz1ZSy@panix2.panix.com>
From: Pierre Asselin <pa@panix.com>

Alex Deucher <alexdeucher@gmail.com> wrote:

> On Mon, Dec 23, 2024 at 4:08 AM Siva Mahadevan <me@svmhdvn.name> wrote:
> >
> > #regzbot introduced: 99a02eab8
> >
> > Observed behaviour:
> > linux-stable v6.12.5 has a regression on my thinkpad e495 where
> > suspend/resume of the laptop results in my backlight brightness settings
> > to be reset to some very high value. After resume, I'm able to increase
> > brightness further until max brightness, but I'm not able to decrease it
> > anymore.
> >
> > Behaviour prior to regression:
> > linux-stable v6.12.4 correctly maintains the same brightness setting on
> > the backlight that was set prior to suspend/resume.
> >
> > Notes:
> > I bisected this issue between v6.12.4 and v6.12.5 to commit 99a02eab8
> > titled "drm/amdgpu: rework resume handling for display (v2)".
>
> Odd.  That commit shouldn't affect the backlight per se.
>
> >
> > Hardware:
> > * lenovo thinkpad e495
> > * AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
> > * VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >   Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series]
> >   (rev c2)
>
> Please file a ticket here:
> https://gitlab.freedesktop.org/drm/amd/-/issues
> and attach your full dmesg output and we'll take a look.
>
> Thanks,
>
> Alex

Alex, Siva: I see the same thing on 6.6.69 .
Hardware:
  HP EliteBook 745 G6
  VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
  Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1)

It bisects to 2daba7d857e48035d71cdd95964350b6d0d51545 .
Upstream commit is 73dae652dcac776296890da215ee7dec357a1032 ,
same as in Siva's case.

I'll see if I can create an account at gitlab and file an issue.

I can test patches, preferably off a mainline kernel.
Otherwise, I'll need hand holding with git.

--Pierre Asselin <pa@panix.com>


