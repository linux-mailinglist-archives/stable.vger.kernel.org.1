Return-Path: <stable+bounces-182935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D913FBB0500
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9474E2A22BE
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647C2BEC45;
	Wed,  1 Oct 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhAQPDxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD30227EA8
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321384; cv=none; b=q571FlHvv+03nSwTcc9pB4+8ksM8A6hikPK2SVajSmi0ZbSvbDAgoarpRGBqtuA55WAIYZZH5ZvbVWgoPwqN5oA0rRJhpDoq+HY2UBnbELwvaC5aHb3meULGGSooAA8hBh/6ULYhStO9vddssx+qKcHPhCx/u+miKn2cVNsqqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321384; c=relaxed/simple;
	bh=jm7QjsEYN3o9NREvDIVoGhoSvlRo/JHErcAuGoWOiRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFJR+OoFH//zTKeR/07Zb98h8nirreCnI6t5VUv5A5/WSnbk+zk88H4znW7lJJY+7xPppj5vox2NTOzOiovfa9oDUr36bUrOuIkjtTk+FOKoOwUQGIrIg4wAPGAERJd/9MXJPeXMv+BB8CyVwnFPDqEc0nJ3uFFk3+z3eVrOzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhAQPDxD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27a6c3f482dso56661005ad.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759321383; x=1759926183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ekdHDmWVv9FcHQZlrQj5iI/vOkg8zYvOska5GK10c=;
        b=dhAQPDxDfgnqpA2S01DC+hFkGDJRYz3maVwiXV/VKcI5p+YhACTvwHXZLyb5sCHB0I
         up1nksKL+rcClHSn+vb7AVgYcGHNcYgEI3/cBU959c7+XgA/+yCCoQSyYp/LAVTUExus
         NsitKrWlltZd/w8x/BnWkyd9a9O+0jgAdpcWeeBdt/lZilo4RZGic1umn6IsN6gnbB7W
         MWTKrA96PgPf3iSkUWbW8Hz5kNiahCigYvLlU0BTAduyrZXo9sNhPgXTKqhTAoAn6ESY
         iM/g38tSRaBgdii0dTbqux3RpNyFBQ1cOE0mNh3ki2DAVPS7mbBpVzY3YQNcPs9GTY63
         0Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321383; x=1759926183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6ekdHDmWVv9FcHQZlrQj5iI/vOkg8zYvOska5GK10c=;
        b=sShn7F1/eCrp77yrCzJOF5buISJP0LnWsVSRPiaGMf+KxYcR8NcixsNDDlf37dxKPU
         TuFF0q6CSpXRH+ccYLUWr6mvrHekXlKmjOMIRNLeos/bndX/N1FK9YcN/D1WPxJrUFYC
         oVMiKHJsT+3DF1bvP0IjxvfcdAjIAILHYYuBv1wHMyexKLafKwPs8NGpqIq86pZK4ddZ
         BAejGBEC8vQPhQKYOBhK+h9Hz/giwDsyul9Zd2qf/exzO+pDOWr06x+DzeXQJ3XJ/bdk
         l/ikWsaKkc3EOfLTXfTLSUQfM9vquAk/QiPXVRguWHxtRnpt84vWzCSXdmoezE7rIe4R
         OTQA==
X-Forwarded-Encrypted: i=1; AJvYcCWuNcTzEtE1g4qbGozA8EXji6jwGqeMsLUL3/b8lO7fp0+RP+mZYFxD3WfcsaEKtBLPeVoKR/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMuNLsLH6uItxiVBmZDwiphYeLG2iZrVtoVV5KKfi9rx7LwYI
	9EobCF6H2Fm2JfgkB9/+IxzchH538cPgQDw9S2GNgBmiOWzuyEciu1MQ1ixLvPESHwly+T0+3pD
	hqmPRSPZWy9SMC0EnEUWc+ocSA3iNaLITKSU5w8h0/w==
X-Gm-Gg: ASbGncveaGmsX4eoRpnjRHVagn+CteNy2h31JUxbvRXRCbr8cTTsmtf/RjuKKk46cEX
	9UVvh6aGCSqa2Lxr831XiIR7KfxLlvLqGU4deioAoZbAsbu7PbCNCRJykYpNZ1UKA1pbrGTonXJ
	8H3Oo2lvIz6hG+bS1H+zFlx00Fpk8fwb4tTbuTGVw/GEyNHWGzkfcAPfYIDyVxX6LAmhPOPQj7C
	wgHTs4kzNfDiMrIpYhi52N+gd2oyQJcNFgamah3FRAYtRvv3aOCvwQO068UJJuviC0Dm1wKsTXa
	0pfACaQeupC2oj6KoeA8
X-Google-Smtp-Source: AGHT+IG3y0LpyILSJk25wSg4EzJQnje8BCP0qYej1zbXdtuiF/6h3Ys2FwvbgoPmiH3pc5MHl/M3OJoRN2I5jM7mBd8=
X-Received: by 2002:a17:903:1b2c:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-28e7f27db93mr43354285ad.6.1759321382673; Wed, 01 Oct 2025
 05:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143822.939301999@linuxfoundation.org> <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
 <2025100105-strewn-waving-35de@gregkh> <aN0aMyU1D3N4WQy4@stanley.mountain>
In-Reply-To: <aN0aMyU1D3N4WQy4@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:52:51 +0530
X-Gm-Features: AS18NWA6cyT7LVY1PGpPsb3wxOlSJ03i0aRVQJ0RG446XB-O0skidiXBbZlceZU
Message-ID: <CA+G9fYsRCN8f5n4dsbQAq73t7f5pzbHVT5Hp1rxYQzpxqvLWXA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 17:40, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Oct 01, 2025 at 12:50:13PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> > > On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 5.10.245 release.
> > > > There are 122 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > The following LTP syscalls failed on stable-rc 5.10.
> > > Noticed on both 5.10.243-rc1 and 5.10.245-rc1
> > >
> > > First seen on 5.10.243-rc1.
> > >
> > >  ltp-syscalls
> > >   - fanotify13
> > >   - fanotify14
> > >   - fanotify15
> > >   - fanotify16
> > >   - fanotify21
> > >   - landlock04
> > >   - ioctl_ficlone02
> > >
> > > Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> > > failed with exit code 1

I have re-tested for 12 times and reported test failures are getting
passed 12 times.
However, I will keep monitoring test results.

 - Naresh

