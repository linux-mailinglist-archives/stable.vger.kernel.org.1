Return-Path: <stable+bounces-169393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433AEB24ADB
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E03B3F8F
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514912EBBB9;
	Wed, 13 Aug 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvkvDwn6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA422EA739
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092480; cv=none; b=WCnd2IAXvDPnvtb8OMS8fDjFwpzVfLwyDHBsGYwDMmAkYHdtpBoum5QxYo3AAsMHIxM01PMS/4ZboMlvw/HDmr++qGOaMoY6LBJyR3hqO9LYjNRmYao2P3N3OpTeIYmZmKJakx1pv5dFN/v+JmJqMzxcNvFR67VDwxUThoR5XMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092480; c=relaxed/simple;
	bh=cAR2FPV/ROme89E5VHNey3/dlly2/gqFm0nN2kQt4sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QrSHTcreGWt/LzS34JDXP6dp6sZ3jSNRonIDv5YtihiqnpsVkPm7xx0MWCzOhjCoUQ7MfZdqexrRdizsbeRb+93vSd50uMxeasdFt2+vxTO8dYIxBs56iZdm4+vPI0Rm7f6fLa0MdBPgLhmYRuKcfdL2X8QgVqqZcxQmftBUnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvkvDwn6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b422863dda0so4665260a12.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092477; x=1755697277; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
        b=dvkvDwn6Q69ZDEiOFDSsL7Dop7VF90MGADW9JBQw1QJNXOGwlo+PvbBIYBWQhsi+Hf
         rpIVh5RNYa+/exggyh3FUfaMidQ/OpITp9OFptcW1tIWt8j2nB3zqe9s+gVbo00HE3dy
         9m6STNrujQ5Ax8vh7NLrqyMZwC0GRHbE8GlfgZ2gsJsjHhP/7zGmSv1QY/QzafrG1UsH
         va/iMAC4DFLx2M6+biC8spPoN9lU2JJGP3DSYFxCH5ersoq2EyzJ4/csS4vPtU4a7jSB
         piZoeAj61M+nZ3NAAcZ2frN65DEP2NtiWNGOVogxl7gftDuUfyn+A0j19IHcEIwNSFv2
         oryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092477; x=1755697277;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
        b=AG0jmMt1uAHkBrhl6G17zCkpEZgKkAxDUIksf4hfer4DjxE9Er7o2YLw9lKa0Qv9l/
         RY6XSRq3Z1OZb48Ox7W5b+0RSVq3YDkaX3IlFEWsA0kEE0m6dyspA1r4ZwPLBcmp4i8E
         JOQWTHvPXYG7+NMTHgkiATT5goY/Qt7YKSudhFhL0zev3GYjFBsCfZu+90Vg0jUKrc7M
         sGpnrG81pdvS4ViYXQfEkS1ya0g2cWeVLskNp8xUQq1qExi/O1GhC9LOXksA0mdeR3da
         zT8fOpl7PrR3g3BB44z1KrXAfVEuWBji07VU6ZoIU1evdHd8Ol6r6jvWYjwMSzhM8HNZ
         YONA==
X-Forwarded-Encrypted: i=1; AJvYcCV3d/SwFK16ABbFSqUcHdGwE8fAE+i5f6VjASxMV+dHABMn/zJXUIwFfziZmlgOVBLJ6wtwHA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqvG0k32Bh9k2XvQnuaS7ms2DbZ49q1RzI8xoSJPnmvbIWJmN
	lcDcmGPg+5cdlRuJoVS/f7JYDoumY/AWWqacsG1qHi+adxUFyKqAwbI8LCFARyJmNqcWjoW53zW
	idnj2kv1/uDbmYLu28Mw6bJSagkMUAKJ0Tc9JVFJlCQ==
X-Gm-Gg: ASbGncvPqDAJIZpBrQyITLDsPhkckNY2MGnZ18txuPm7P4RkC4J0jTtxlGH7kYoYMw8
	l00tE0e1Jt/u/OsuPEppuOCw4oG6hrPX3Ut6jdUiCV3c2Q70PtLFjFgMQeN1tvngvdjNC2RGKP0
	GDhPnVADCdcvVL0HxNyCD0FDCBYFkPebyf/551FvTk7uS0/oQX0kWogdbCWy3jzD7DfDa1fOXTE
	i1Uuj8ddG7LKk1MAcD8hEIw7zdW7omikcoaJA5r
X-Google-Smtp-Source: AGHT+IHJ5NorMBOk/mMmvjq4NxC90d+IjwHZjpyxn70pQloc6AgGTp1y/wa+zMeluJYPNCBvRdh21gvKSjV030UR2Pk=
X-Received: by 2002:a17:902:f785:b0:23f:e51b:2189 with SMTP id
 d9443c01a7336-2430d0f9a4bmr54705775ad.17.1755092476818; Wed, 13 Aug 2025
 06:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org> <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
In-Reply-To: <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 19:11:05 +0530
X-Gm-Features: Ac12FXxKeYVh06szquTrecWrS7rqGYyi8ckXtXfcapehmWdAEuqul8ZUWvjf2tw
Message-ID: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, achill@achill.org, 
	qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
>
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01

These test failures are not seen on Linus tree v6.16 or v6.15.

>
> I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> still running but I suspect given the error message:

Right !
LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
with this error on LKFT CI system on several platforms.

>
> epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
>
> that it might be:
>
> # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
>
> which already got tested, or something adjacent.

A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos

-https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

- Naresh

