Return-Path: <stable+bounces-121241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1BA54CFC
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3C1896A10
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA98155757;
	Thu,  6 Mar 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZimUz2u"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30953154430
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269989; cv=none; b=OaGp4+HoZfWWWrzaxW/c6lGHxLgKhepTYyM5DJPlkENXNVUbywxBrrzgb5uBOjJBswlciA8tqC7nl8NSpqe2pN3gxAVZbfykekQNyRS42nZuOIoc5jCbKOrur+xfebXu8OlbOFjAleP4fYaLbfVKbr//4zYfjrHHy0gD4r57dJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269989; c=relaxed/simple;
	bh=8vWkfwZ9uoFTAqFoovaPX7Bjye6a8c5yTgefFSZ3pCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rII0DXGvkssKDstL9cNKzWWIKu7KgmFeTEMqeiWRj9hNsdlc0lybLbkqi1osH5Yuffsx/69Fdc7Q2kbyD7FS+bpi8OjYnAIkj26AEPdX6kDGPsB9pt7WGXYVzZ2A3vEH+AMJPWRCaTjPbt9920WlEYpfO7ujJkou5lgzCG/UZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZimUz2u; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d36e41070so201174241.3
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741269987; x=1741874787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnDdSUGNxHZHOtmoWx7c7YzOTo1FiWV3Vqxq9lxjEQc=;
        b=jZimUz2u+EsC5z1+bCdpdbXbq3rLfEKxwAb6lp36SSyn4GQihR7udWM5lKFhJmyybi
         5jj8IgYXpKxCAVARFYXi3AqwdQe+vDlEobZstK1rfMUdAauZidsN7zOb5TejnFshJbCt
         880cXjqjCf9kdmDAx0UD+rJHqdezwmzXy8jwaY9W3cYIb4VkgotqINql5w1gU/PuJzgH
         z+P8bXQcYuuP+I9ovhbJMnpSxEmCcuwXu99/zptLJsdkkeefBtmjooShvdgG+BQCFpb9
         aBmMMS0Ba/lOvreVCt2L1+TYuUSwDIb7rDm80DIIlA1VHAPN3i/TCQoqK38b/wfZZOkH
         0/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269987; x=1741874787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnDdSUGNxHZHOtmoWx7c7YzOTo1FiWV3Vqxq9lxjEQc=;
        b=Ol4K3yYfVeRoWh5issypduOLF7HfQ0cxgsagv/syWIbZzvn2EFNZCcyIux+hmI7LD1
         1EUkFPVIpXZA4kEEpy5ndRfd2sW52YHVyHtWNr3tgdt/H9jN91+mWKMGg57kywDHt206
         EtLBxjBAqKgx6EU/C+fN1mrN+lP5UJf1+/+jJIfIOwNxDcczHHlbwBKXEuS3hyI6wM60
         y96P7deeZ+QRWbrGYzeod7tXYbmso8Y+/T7rKc8Z82Aldab+8IV/oB/ViZhsgXDQMmC5
         tXNuNfaakXENIFpp6rWwqJ9ALC8es0FJPvozvFm2jBxlJndgaTLTQz1SKvr+fNAGveJP
         E62w==
X-Gm-Message-State: AOJu0Ywz9NXWdsyso2CZuX63C4Ix9iPAFskZ0SSsNbwQzoRv0qFZtZE0
	ioH2UqoKhnMrvMptI9jFW/4zfdQ9PYjHR6RZ0cpnakU5dYjWPysl35qjkKdfRGccnRAsscuQwSd
	rjNmxadsU4q/WGq8He+WmGD/xVAAHGYB1eVoYMQ==
X-Gm-Gg: ASbGncscg1R6wKV3kNdqdotzY5FVoW4v/tivbkD/tNALaFo+VPXAKWq+VNbqXlkbTH9
	eha92sjbGalwCtmLT4fM7r98O3YoGSB7OfoPJBqzO5mVA3O5VDGaaP7CJxVP6gwmbECclPvtLhY
	DKd0vj0MerEmSChJkfrY4rLvmXPiwyq3UZPMdV4phlQNsB1GVdSKpXBDYHyjk=
X-Google-Smtp-Source: AGHT+IFYYVIMAXWvuGMo7KhLWndEUFvJgOqbF7iDEk1iAt4N1mORmaJKT3kVe35xC4vstbek2/qR99nsdifAiR58JMA=
X-Received: by 2002:a05:6122:658d:b0:520:4539:4b4c with SMTP id
 71dfb90a1353d-523c6289f5bmr4380467e0c.9.1741269986969; Thu, 06 Mar 2025
 06:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174500.327985489@linuxfoundation.org>
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 19:36:15 +0530
X-Gm-Features: AQ5f1Jrk2nyka3XPmEIXPsBdkX75IZVBh9HDyYyhUqxg9qoZ6sVv7JRLz0R3L_c
Message-ID: <CA+G9fYufChZpBjB_WG6Qy-L8Gmj-zBbs+PyydaADcsrB42ec0Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/142] 6.6.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, clang-built-linux <llvm@lists.linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	nik.borisov@suse.com, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on x86_64 and i386 the defconfig builds failed with clang-20
and gcc-13 the stable-rc v6.6.78-437-g9f243f9dd268

First seen on the v6.6.78-437-g9f243f9dd268
 Good: v6.6.78
 Bad: v6.6.78-437-g9f243f9dd268

* x86_64 and i386, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: x86_64 i386  microcode amd.c 'equiv_id' is used uninitialized
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/x86/kernel/cpu/microcode/amd.c:820:6: error: variable 'equiv_id'
is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
  820 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


## Source
* Kernel version: 6.6.81-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 9f243f9dd2684b4b27f8be0cbed639052bc9b22e
* Git describe: v6.6.78-437-g9f243f9dd268
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268/testrun/27508291/suite/build/test/clang-20-lkftconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268/testrun/27508300/suite/build/test/clang-20-lkftconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268/testrun/27508291/suite/build/test/clang-20-lkftconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuO7pCGJaGnX0ygcbTOaEDzr9M/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuO7pCGJaGnX0ygcbTOaEDzr9M/config

## Steps to reproduce
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

