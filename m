Return-Path: <stable+bounces-61776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05993C765
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C112E1C22083
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA319DF8D;
	Thu, 25 Jul 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RylKNUxC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9419D085
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926145; cv=none; b=k627pbPddE7/z1/3yZdl3yWLQljJs+iVjQX12Net77/wwikU3SzAF6ziFiqI2kTagsnI1e3pO4nDyCjkDmHqwFEsluPCJAKRRAhfhf8HWvvhcoI00yAPUbZ6ma+I/db43sVRDq/StLqvI92ZtWqQpFNJoMzAEjCkF0CdCLD2cOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926145; c=relaxed/simple;
	bh=zl9tyaX3atF1FD6Oj4CMVfjVeFukwL1OauJx8MZgj8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4ia3vGVcwLTAize4tvbkh90IdcDN11KE/55g8ejBsGMLoCN0TibXqwSVQMYPP7UZNpa16OOAaag+2w6+ZGa8zzk4DE3184Pu/1LdQpFWFP3VHWSSgb6mAeO8vPO1SmC4FLepR9Scx/w+9nWua31QTD6IxbPNQCNQACgYrGxcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RylKNUxC; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso361553e0c.1
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721926141; x=1722530941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jKCeuZLzTZnQ+M0GtznLWK7b6OnFbkvquUnPvitUBac=;
        b=RylKNUxCOMpWmu5WLb1960ne3PH8OYw+ng7cLM+Dn3ELYqI+n9KR0WEa+PYsq2JjfJ
         vnrmzgrFewtZLoAbJmU0Gd6CITa066IGlhg4IQ8DkIXygAkCqtwnB3H5/6zkaZSGRuDP
         pfBhz3fsxzMJoHF6BEYKYFWVpypS05puQU3ZXvnVqWcvEHHo7wlu74s02LWkBOQMV4Y4
         I5XQOvAnfF+83uv2LR/BJs8jqyfkIhA+nScZe1g0+TYi70gCBfWn5huiESl5xkwphxkW
         Xkc4yaHjF04sLLHaj7eLWmdljWzz5GndhAcECILamY2phJickP8iwJtibuRaPoJnl/Fi
         fHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926141; x=1722530941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKCeuZLzTZnQ+M0GtznLWK7b6OnFbkvquUnPvitUBac=;
        b=LOy6N2yh0VjbkBd5iMbevQu9oRrvr5zOjCPI8G+a+Tq9faE0yCRL04avUGQ1NLbdw8
         6YA+KzkO6oIYCajOOQMSFL0Q8yF/LHj4NTniAeyLCTL7qrf8aeyPDgkMI6VkQdBWXHRz
         HwI668wSvWygUGe6lyOtDIBN3CiQsykaM4pi69sdEyvBmT5sF9bSyjNBLDy11yRFW3hD
         zs6E3IejqikJkKSbYnNEKyMKEzxpiB58qEiwCXeMG6zn8dDiW6NWp/WL99+on2gPODc0
         ARhJ3mXuwfsIEzZqnIT7Hs37X9Wji6U7JuQoq+G0BGBR0oOprSj38IhZJAx5d0UU1Djn
         kstA==
X-Gm-Message-State: AOJu0YyP3ZdE6xelUF6LOhOxdwnJYn0xQ1i3/1lRWhgLtGIvTPMg1B4F
	d1wijQZ2RD+N1cFtlgJjmq0eXQjmAeRucXWbeY1bnln+tcoc+cyEnG9EIZeomjxrJt+afZVArn3
	gnziAfOvNHKp3ENTZkC54ofF4nr6dZSXXMqhOYQ==
X-Google-Smtp-Source: AGHT+IH+sca/eScSSpr1hspS4ecSOGX3fro/SHs8Yt+aVmqnAYTWGrfofCR+92nWoCEokUgsHg1b91tdBPwJtE+Jp5c=
X-Received: by 2002:a05:6122:1d4a:b0:4f3:828:7a47 with SMTP id
 71dfb90a1353d-4f6ca2da2fbmr3128684e0c.6.1721926140905; Thu, 25 Jul 2024
 09:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142738.422724252@linuxfoundation.org>
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Jul 2024 22:18:49 +0530
Message-ID: <CA+G9fYvCyg1hXaci_j-RB4YgATb458ZqRjJSye4qub9zYrmL_A@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/87] 5.15.164-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.164-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors noticed while building arm configs with toolchains
gcc-12 and clang-18 on stable-rc linux-5.15.y

First seen on today builds 25-July-2024.

  GOOD: b84034c8f228 ("Linux 5.15.163-rc2")
  BAD:  1d0703aa8114 ("Linux 5.15.164-rc1")

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------
from drivers/net/wireless/ralink/rt2x00/rt2800lib.c:25:
drivers/net/wireless/ralink/rt2x00/rt2800lib.c: In function
'rt2800_txpower_to_dev':
include/linux/build_bug.h:78:41: error: static assertion failed:
"clamp() low limit (char)(-7) greater than high limit (char)(15)"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
   77 | #define static_assert(expr, ...) __static_assert(expr,
##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
include/linux/minmax.h:66:17: note: in expansion of macro 'static_assert'
   66 |
static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)),
 \
      |                 ^~~~~~~~~~~~~
include/linux/minmax.h:76:17: note: in expansion of macro '__clamp_once'
   76 |                 __clamp_once(val, lo, hi, __UNIQUE_ID(__val),
         \
      |                 ^~~~~~~~~~~~
include/linux/minmax.h:180:36: note: in expansion of macro '__careful_clamp'
  180 | #define clamp_t(type, val, lo, hi)
__careful_clamp((type)(val), (type)(lo), (type)(hi))
      |                                    ^~~~~~~~~~~~~~~
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3993:24: note: in
expansion of macro 'clamp_t'
 3993 |                 return clamp_t(char, txpower, MIN_A_TXPOWER,
MAX_A_TXPOWER);
      |                        ^~~~~~~


metadata:
----
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkA3TgHM4HJPklKlKvochTS6Sk/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jkA3TgHM4HJPklKlKvochTS6Sk/
  git_describe: v5.15.163-88-g1d0703aa8114
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 1d0703aa8114ca7fa386273d01ed8a7e1b66d335
  git_short_log: 1d0703aa8114 ("Linux 5.15.164-rc1")

--
Linaro LKFT
https://lkft.linaro.org

