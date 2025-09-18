Return-Path: <stable+bounces-180512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765EFB8461D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC4518890E1
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED4303A05;
	Thu, 18 Sep 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIw+E+Mf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD0302740
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195597; cv=none; b=k5lOFcrS60CEDHoB1ruxTV95Zuito/71/gmDm7kYhe1cLQN9kelMzL6U63+aPk38ZZkjDg8yDitmNe195379cT8mCGLq0GqoBw6rHrJUzkLInBIq7XeA4pVHzIV+j5jjZHhnfWUvIXoaNJy4xlqo0F43ybaBbREZ2Fh+fgqwarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195597; c=relaxed/simple;
	bh=uFxlB2R+ZAYSRcEYlTPVQyhSU7uzPWXjKHbWDaZJTTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqBFRJCA+pjq0TL1F2vjVISmJfATd5lzHb7gK5QhAlT2ufbCAQXynr2P2omkHr9osF6poy1XfJjT63OMFVGOtiaiEjZCWObANqN8lwbDQT0VcgJIuUYsx1+kzAMn3e5ne/J4IRh0KcT3MP9U3aaa3TKcRxiG5dSWzFFhM5zReGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIw+E+Mf; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-726fbc53376so100216d6.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758195595; x=1758800395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vUxrIL/IBc7jEhkf1uGzLd2PnG5mi3zNkUmu0ufRfg=;
        b=CIw+E+MfZv9AAWjCRMSzSjiEDMZmCH7ycLG1LPqV04zKeo3q/6aj4WjpwtSE3Rhcc5
         7frgDoJ/kvWNO1qcuos9asElyqMHaiyi27mXPLoPSWp7o3lWUeEDEd8AqXoM3WwhFRkL
         gRajcgArYRwtSWYbLrVyj5xLlb77PLnmWt5Qum94+RGnr7VvXHNMg1HbhCrPXLVzz6m6
         7eFsAhGS8AChjdoLqCIe59TyqeYC0d2I9SlKv1jM9YkEjaruT1io/2wxpBygCzRG5b6X
         cbTf8uMDv2PKPRUMIDdyRRU1I+71H5QSKxkfCsSNrRaQTi6xo0zHLOFpdJwTHynCsr2x
         nvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195595; x=1758800395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vUxrIL/IBc7jEhkf1uGzLd2PnG5mi3zNkUmu0ufRfg=;
        b=B/88weS4LydSXhXMhJS7eO9IUMwBbNKqobJfgBWHGgVzXwQqxqFfatveK7Iuv+Mk/k
         lQDCa+BBqFfpS/a2lpG/Vmb7Qhat9pfgn3HuJP1SgKJGSmiybDWzVqUY0q77dr3REQlI
         NjWfMMl09K+aEi8f8ie+U1SzIGCqvD3p0g33TZeuwac0vMkdLuXK/fjidnJfGQ1DFSph
         Zp7RU2amJcvlY8t5aBsYpsxqVd5gDk9sJGHkYYXLAMfD/0eYHqsoFIIj9hr0PAQJV3sM
         /D3bOQQhd5dnYyz/nab78hlcS6iaimUlzsnyT5jPCkBg8Fn+i0/Xsmk/P0nogmQxENX8
         uCDQ==
X-Gm-Message-State: AOJu0Yzh8JvK5cUN7Eap9/XmZP5/8f2Aylc3WF2gtjMgHzkAQ8oxmHOx
	HXQYH76oJP/L14+X3u0vU/Z5q+bVcZ9wCgZvzpnyyk+6dE3FrxIAKdaHfeYGklpXk0HVbVuQq/a
	g8m/EtgY5/7e5pHcYBpDG1yKpeNvQ4PmJw6mLIPZV6A==
X-Gm-Gg: ASbGnctd3HG9nurNoElnzIrETYem1xqfL38hRsPB77gu5T9dlzyTtp6+8j+7DjnYxHe
	G7gAup2WqfzjqRXltcE9nlAiHifVdHz06hSkBEaaxAcpPnmAG2YiN3d1Gt42H+LmtMxjxP3xo8W
	5UnAOD2/HPbsMCkp3LZ1GHZEVIV5t5053jmsjc6lickxScpl50TDMskZcFKmvktqnGA26n6E6rx
	qleOM97A1FZcQ4yydjgu+eQ
X-Google-Smtp-Source: AGHT+IH48ivQXtWG6C+0ln0hXjbS+q797BMP5NkKk70x0e10WLGtjHZ+0cOJrQylQsmByXrESmf6BwG/gWAUyqH0+oU=
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id
 6a1803df08f44-795c55c8cffmr5136256d6.5.1758195594483; Thu, 18 Sep 2025
 04:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123344.315037637@linuxfoundation.org>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 18 Sep 2025 13:39:43 +0200
X-Gm-Features: AS18NWBNNFTT46ohA_9aWzCCmFKj0hhU1Nz5FCTOq6VyCT2bqNOYD0vIURq0WvA
Message-ID: <CADYN=9+vrKOAkyqp69eG785TXoqbw2QdORoFOJWz=fXeEmGz1g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 14:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While building Linux stable-rc 6.12.48-rc1 the powerpc allmodconfig and x86_64
allyesconfig build fails.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: powerpc clang-20-allmodconfig

Powerpc allmodconfig build error  :
/builds/linux/drivers/net/ethernet/ibm/ibmvnic.c:6134:13: error: stack
frame size (2080) exceeds limit (2048) in 'ibmvnic_tasklet'
[-Werror,-Wframe-larger-than]
 6134 | static void ibmvnic_tasklet(struct tasklet_struct *t)
       |             ^

Build log: https://qa-reports.linaro.org/api/testruns/29918282/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.46-149-g6281f90c1450/log-parser-build-clang/clang-compiler-drivers_net_ethernet_ibm_ibmvnic_c-error-stack-frame-size-exceeds-limit-in-ibmvnic_tasklet/

Bisection in progress.


Build regression: x86_64 gcc-13-allyesconfig

2025/09/17 13:43:43 socat-external[1252] W waitpid(-1, {}, WNOHANG):
no child has exited
x86_64-linux-gnu-ld: kernel image bigger than KERNEL_IMAGE_SIZE

Build log: https://qa-reports.linaro.org/api/testruns/29919415/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.46-149-g6281f90c1450/build/gcc-13-allyesconfig/

Bisection in progress.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.48-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 6281f90c1450c5ee21a0f42e3dff4654f395d963
* git describe: v6.12.46-149-g6281f90c1450
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.46-149-g6281f90c1450

--
Linaro LKFT
https://lkft.linaro.org

