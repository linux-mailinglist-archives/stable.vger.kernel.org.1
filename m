Return-Path: <stable+bounces-96308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C2E9E1D27
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4764281B39
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673F1E5721;
	Tue,  3 Dec 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJPWjFqU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4741EBA1C
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231442; cv=none; b=aMH7iEO70N+0q+Gji1QhB/JSywPy+mAFwtqgmK2sMwpCn5dqNSvn+Cigu8gUCSpXrkPT8ySun2ik9loY+04kN1XQTzUHFpxdDl4jmWHlq5UcnFBjuvXGWgz7EQMQZEzavtF8AHdB14TXT7ptVyqh4VAc7u+t7FxUFNA6x9tiWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231442; c=relaxed/simple;
	bh=E9wjGXkxZXo6et0AHWDrNIJNLH9shVHbKvVG/BUzYXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBd9i/RO6RBDaWQcttwRKIm1dwaofxW4a5ZyoLHfq5TZ04kMwLnP5N4xyNBJIiz2xAYkCiYRUgA3Tf7k7QXhpG5/8VVDSNXk9mLLEOYOPQaaAHPDPJieroRGD+uagG3XtCL6FooQVziXv+axn28tkkq8rnO053bVu6Jjhq8oVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZJPWjFqU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b66d08d529so475772685a.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733231439; x=1733836239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9DpOBXLLjyiG+N3LVHSh4lonGnoLSvX4rvZN0nDjDN0=;
        b=ZJPWjFqUBf5JJSv0ct59Z8DTJFMMTTXC8F0T26eD0HYdZzBgoXGXIEudntjj/3ydtt
         ONO7FV43fNZbzvaa8DsDx+h7Qs/iHOa/85wNU8/gAHgVr8kv0fgiv9MFNeH+VLgfP0N4
         ZpNf798eLxct6kAbELnr7BN9dHCc1oUH++RXs+D75FO3HrQX3UO8UqfbjclHRz7qKt3R
         MLadNW8GLQKJx/t6zPadVPHZw918v9LxAjC75ogp8LZl1a120NkDYkxSFLBpoiGouLHC
         5HSme/H3bnUcKqBVJzbB/oUZp4lXpZDTqAuQ19NTfvtc5Iyf7gRzO+7BhQhUzT5xMfpG
         8N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231439; x=1733836239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DpOBXLLjyiG+N3LVHSh4lonGnoLSvX4rvZN0nDjDN0=;
        b=ZIO/MFnBBa3VJWPHqLf3TP+DvHhsXNwMosde655r55hs0/2DyJbCog0BgtDeGCw9QH
         BnZaoPhqexk/D20g0bIQXxKAO8di5beEwno3NfLxrjjtEyKkJxKqCi3M7lzzQrzHFpUy
         M96UWAWJ7e5fk+IhdSqBTNJiaIAxUiDqxDxAhOBiT2sEUB3E9JpVbdF3Lmt0iOacEkmV
         k/eKTpLDlQ957/JaUssjzOGi7wxNjTsRkUBmG9YFxCl3GQggC/9daJjcaOz15VuxsmEb
         V3Me4HLODBLuolq4+8yvwEV0s1w3kLQeicgHRWk217ux3Rjc/guMONOPDxTeOVE+GNH6
         sG8w==
X-Gm-Message-State: AOJu0YyKAaRX3rOqXgMeGvpuQ9HMQ8VwVF0wPoajpJJQEyKd8hnnb9gO
	wle+HfqDlw7TmTzOksbDm0VzM4sCNCdNNGjL5JqWLujjNPBY9bOsWbHu1oYzpqcoBBUuVjsIxhK
	FFpS34J97iTJ/1jmhvCgGiPU2F0Kc+cHkUA3o9w==
X-Gm-Gg: ASbGnctADD2bgd0DWa+d2UhBsodSqTmmBRZF4HCs/Z53+sYersQFTKiqrdToABxSz2F
	xFmDxqXFKms59yrOZiPRfW9k29kFUXFcY
X-Google-Smtp-Source: AGHT+IHDdU+9VCqufyt3SzpXC2DAP0G4i5+riHGBhVvX00dwFRQDOUu4q0kbXbYL0xF/WekUeH65LcXOP02DnOppu3U=
X-Received: by 2002:a05:620a:1729:b0:7ac:e8bf:894a with SMTP id
 af79cd13be357-7b683a2cff9mr3767847985a.20.1733231439209; Tue, 03 Dec 2024
 05:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYu95a2Dy-R-duaieHVOM9E+zeKu1EF+YJydnaD7nxnhQg@mail.gmail.com>
 <2024120306-sniff-labored-f6fa@gregkh>
In-Reply-To: <2024120306-sniff-labored-f6fa@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Dec 2024 18:40:27 +0530
Message-ID: <CA+G9fYvhOH4iGf597VK61g_LuSU0dtohDObNzOu23H0SLP-CZw@mail.gmail.com>
Subject: Re: stable-rc: queues: 5.15: arch/arm64/kvm/vgic/vgic-its.c:870:24:
 error: implicit declaration of function 'vgic_its_write_entry_lock' [-Werror=implicit-function-declaration]
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkft-triage@lists.linaro.org
Cc: linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, kvmarm@lists.linux.dev, 
	Kunkun Jiang <jiangkunkun@huawei.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 14:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 03, 2024 at 12:00:46AM +0530, Naresh Kamboju wrote:
> > The arm64 queues build gcc-12 defconfig-lkftconfig failed on the
> > Linux stable-rc queue 5.15 for the arm64 architectures.
> >
> > arm64
> > * arm64, build
> >  - build/gcc-12-defconfig-lkftconfig
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build errors:
> > ------
> > arch/arm64/kvm/vgic/vgic-its.c:870:24: error: implicit declaration of
> > function 'vgic_its_write_entry_lock'
> > [-Werror=implicit-function-declaration]
> >   870 |                 return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> >
> > Links:
> > ---
> > - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166362/suite/build/test/gcc-12-defconfig-lkftconfig/log
> > - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166362/suite/build/test/gcc-12-defconfig-lkftconfig/history/
> > - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166362/suite/build/test/gcc-12-defconfig-lkftconfig/details/
> >
> > Steps to reproduce:
> > ------------
> > - tuxmake \
> >         --runtime podman \
> >         --target-arch arm64 \
> >         --toolchain gcc-12 \
> >         --kconfig
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrGeL0phpW3aHlpr5cjEzz3r/config
> >
> > metadata:
> > ----
> >   git describe: v5.15.173-312-gc83ccef4e8ee
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >   git sha: c83ccef4e8ee73e988561f85f18d2d73c7626ad0
> >   kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrGeL0phpW3aHlpr5cjEzz3r/config
> >   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrGeL0phpW3aHlpr5cjEzz3r/
> >   toolchain: gcc-12
> >   config: gcc-12-defconfig-lkftconfig
> >   arch: arm64
> >
> > --
>
> Conflicting commit now dropped, thanks.

Thank you.
I see the reported issues on 6.1 branch also.

/arch/arm64/kvm/vgic/vgic-its.c:870:24: error: implicit declaration of
function 'vgic_its_write_entry_lock'
[-Werror=implicit-function-declaration]
  870 |                 return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


Links:
---
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2phryzHX4rmjhKAc2d5Wtq7QijV/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.1/build/v6.1.119-434-g5bbf9d2a0ecf/testrun/26175571/suite/build/test/gcc-13-defconfig-lkftconfig/history/

- Naresh

