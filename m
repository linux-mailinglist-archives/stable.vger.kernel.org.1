Return-Path: <stable+bounces-158468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E9AE7464
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 03:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F90179E3D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8A513AD3F;
	Wed, 25 Jun 2025 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6h6W/T6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6F3D76
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750815939; cv=none; b=uths32pYo7q2QToWbcFFXXp8xqD+m+f1ji43D9UfPE/6yGhLYAu6cLsGBCzpugVfAW5cAsxT+BMRdR0+WX2A0fWxcMSsfY6u/Tazcs59/+ab1JQxPRNFmTwsKdKoeWQ1DINw9WtLM8PkP7ffQ3E2Mh7MkjvFaXe0vR9q6YevH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750815939; c=relaxed/simple;
	bh=2zBoULgm03Dwl2J+U7HJ4pssYFLjwhSqOKEIgLREwF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cinBn38ChvpSsU5iQ2odh+6mEsVCNfauUqz7FibTpmzUXNyRDdPKK+y1fI0yLs++BOtBvJA/a3nG0WvoIPeCG5NSN4hlEwkeo7k9w1Um2b5U67xpP8WGBM83djuTXpCH/dnHL8n5haLVpENytCQbtJqZ1M4xE3O+s7ccNzxkE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6h6W/T6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso4702432a91.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750815937; x=1751420737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n32Ce14vCqr9g7FIDP6NZp2SFABeqo2yehV//w/3vO8=;
        b=P6h6W/T69DXyWlzD+7eCOysWcfED/TU3007xxBtLjeTcC/bW99eQzhpNXuGkUu3yq7
         o5kV3PmxP07lZGZJMoBTyNsMwdMovDcq7GKq7EpehZDb6dskhBXKq+zB62MK5n76dPtb
         5x1SAz4xbGKD1owKgHgCOG7fdTnCF2OfTjscLly4t8OR1XI1+1zKAnQ1zAjeFZFsUibw
         CDgxzfH7y0hzwwVeLbxf7H0cqAEc9On/PZRqNy+cQQJCwBZ2FfRo7kDyKcJYpGnVMuF6
         le8gkbyEdpzFNz3NSs3h+GFmahEkv4Kvw5yNIpfvANAoLo1lgxPayhBaJ+G2Co4/pLqy
         ak6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815937; x=1751420737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n32Ce14vCqr9g7FIDP6NZp2SFABeqo2yehV//w/3vO8=;
        b=KEhfqBaAD4sKsYuhmmr0hBWckKx6fX5JGZj/EsBxBKWn4Dduj11ZitKanhqpmBLwWn
         DUHiKvBq7OTTe4224lqhVpA7nGXKz79j/kjLvoU2HpGe/luja20r+tPxkP2erCN8MgfA
         kfumnc6uR0UEo21Jl00jBxRIfrKR0JrTetqe0BUecw7Hc3K96QW9u28cUqOgs722EcSe
         k3SexpmwbWTG7LpLQWtInrR40J25PDkBWsNLHEpvM72rfcR8MhnHdPG+UMthlq3aUcYE
         Xzoopo3Hp/1/RHuZuitQL3Rm8Z3oCBemQdN/WtDoZWL932dF+mVAcm39wFIaZmpRlOrB
         nYiw==
X-Gm-Message-State: AOJu0YyY55ofdmOx9JK4DBzM7exQlSuOqKlnyucRCsuD1GYxbEIL9d3T
	LETDi7KptdLb0jolhhvd3pWf/JulQC4kVryza4zxxwLbCS7gza/LJJc+PCpa1GxQiKhGyDwDnlz
	zURPRCA/oVyKq30vDI8nTpcsSAQDXWChk2MDokryQQg==
X-Gm-Gg: ASbGncvPpRJYlNPXeDw+td2ixntda22exGn3PbN9C3z/2/tGYjRd8r4sVsDSp1R2nrS
	p4BHDxWYDE7WuSgLrEX9YbqHVUfy5ihT9CHjRcjxV5tI4sGtPpe2VcV8y+cN2MsDaL4F6YViLAR
	Yt4l36ymp6JMgppOLAq9qdrOebVeFMrhMWKX+lk0w++6kXKsOnlonWeI1stEeSncsxGJo0EK8uN
	trf
X-Google-Smtp-Source: AGHT+IEZZrjLJfPFgFgffQ9aiYWL3xtkwNj6XtyL+U8CZwF0zuyVUsKj+smjdUpouvDzUZibEu7iucvZo4MMreOA8eU=
X-Received: by 2002:a17:90b:4a0e:b0:313:287c:74bd with SMTP id
 98e67ed59e1d1-315f26b8a00mr1754310a91.33.1750815936613; Tue, 24 Jun 2025
 18:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130632.993849527@linuxfoundation.org> <CA+G9fYuU5uSG1MKdYPoaC6O=-w5z6BtLtwd=+QBzrtZ1uQ8VXg@mail.gmail.com>
 <2025062439-tamer-diner-68e9@gregkh>
In-Reply-To: <2025062439-tamer-diner-68e9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 07:15:24 +0530
X-Gm-Features: Ac12FXwfYJX4c32g79VHYXDiATL5pbXpMHEnfwCL6cyaQQoQ60FwmMr-U4O_s64
Message-ID: <CA+G9fYvUG9=yGCp1W9-9+dhA6xLRo7mrL=7x9kBNJmzg7TCn7w@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 15:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 24, 2025 at 02:12:05AM +0530, Naresh Kamboju wrote:
> > On Mon, 23 Jun 2025 at 18:39, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.15.186 release.
> > > There are 411 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.186-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Regressions on arm64 allyesconfig builds with gcc-12 and clang failed on
> > the Linux stable-rc 5.15.186-rc1.
> >
> > Regressions found on arm64
> > * arm64, build
> >   - gcc-12-allyesconfig
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >
> > Build regression: stable-rc 5.15.186-rc1 arm64
> > drivers/scsi/qedf/qedf_main.c:702:9: error: positional initialization
> > of field in 'struct' declared with 'designated_init' attribute
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build errors
> > drivers/scsi/qedf/qedf_main.c:702:9: error: positional initialization
> > of field in 'struct' declared with 'designated_init' attribute
> > [-Werror=designated-init]
> >   702 |         {
> >       |         ^
> > drivers/scsi/qedf/qedf_main.c:702:9: note: (near initialization for
> > 'qedf_cb_ops')
> > cc1: all warnings being treated as errors
>
> I saw this locally, at times, it's random, not always showing up.  Turn
> off the gcc randconfig build option and it goes away, which explains the
> randomness I guess.
>
> If you can bisect this to a real change that causes it, please let me
> know, I couldn't figure it out and so just gave up as I doubt anyone is
> really using that gcc plugin for that kernel version.

You are right !
The reported arm64 allyesconfig build failures are due to,

  randstruct: gcc-plugin: Remove bogus void member
  [ Upstream commit e136a4062174a9a8d1c1447ca040ea81accfa6a8 ]

- Naresh

>
> thanks,
>
> greg k-h

