Return-Path: <stable+bounces-156165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F478AE4E1F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DB3B97CD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CD2D5C79;
	Mon, 23 Jun 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E763Z9Ns"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504852D5432
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710432; cv=none; b=G+2mPhge/GIqhneDW7kcRMVOxIyW79adfAcWPLsbB7fyQEUNHwOV/d8ciSNbibDy4gt4l/1ZAKQP088Bv0Js0cqAz97Zy42Inb/xcbNNgGLCmkqxJnKpGbXreHEYT07C94hbPKPrKmFLLJYuA1HPXC1B4sMXlsonpso75MuGclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710432; c=relaxed/simple;
	bh=TDPcuBC+3194iIDORM/5M0k0GX6HQXVenukZhJrYlEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZkCR+Aj2YlKAvttLLBgV1CQIGSUdyF9v01AG4eMz7YRf7h85bdN+5EyYYRHLW/9W+copXDbkwLZkxo/ycHFxsGW9QSLlMcDW2x3sDPOBe6iY2LmXkDeoQuHDmmnnIVIkTzqaLKSzWa9dZ/dA3L6AR4PWoXYFjXnt5EiPPtc+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E763Z9Ns; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso3437035a91.2
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750710429; x=1751315229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TRUWTVvPr1yAn+DH33u9nddl4ICwL7m9XNyge0uZ0XA=;
        b=E763Z9NsKGKojnSRAPOcD/YbbKL43FvWyndS9aqvjBZvghZ/2iKS7jK9ELGkzQgjIb
         s8tvlcMCvMG6A3R8eDKmXAGzXfForHdJ3ErO3G6sWv3Q9Oifiq3oU4dKacHkjC/damN3
         vbSLc8Ox9jclmkUBwd6W7rKc/8cHPAo+A0Oy30oiwo/rtPoLNot7bxjHuY9oER+pKEjk
         6VxgBox2Ri9QWeytghnG9BbacXt3jn7ok0fB61X+2uLfSjnNsBLY7HiPz4VYgJJ8SI7x
         KUPldzXdUFmxcuQMNEI/LmlM1dwLlIurYdqj35MNcvfOu5bxsXB41QUoM7HOPmddg1qZ
         nx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710429; x=1751315229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRUWTVvPr1yAn+DH33u9nddl4ICwL7m9XNyge0uZ0XA=;
        b=KWmoS2Pyxnxb5kIC9rduVFYWMHtLJwrmDZhzQ3IIKhirs+fY6mIzg5k56OMn1tjabb
         T+2QTrieeN+IpYtyh6j4ZkCYj95wMjHzjE0g9sLuR7Wp1IzbfyqiLQA/VpqL5G5acpFh
         PC3xH5s+09TNfYC/udYCy1mXjNkuzQs98IsIyrYL7pAgyFHEUjSe84NGgKeSA4BvXOtn
         vkTcioG56AWtcsW3XIE//hAo0NHNtpRuPFqae6KIeLxwKp9jeJTXoyXiRvZtAMwtnN5A
         plZdu4YAgMqtjIRFhbyMSyJQAQIrJEZMhK40YQK+dUfO4A5ujfXp13j1CpTtedK3NB9c
         9b4g==
X-Gm-Message-State: AOJu0Yxjs6wLE9rQb9BQbnBeuqxkNKgZ9Fboa4oVKjrkZCZuBz/eoGHU
	/yVWo/jj6B54sKme32YdiKTuKVUixsnThQp7GR0gtn27qGC7utrLVp4VY8mgxZsMq/5a8xm18yz
	0ML9sYCQG8adtlGhchGe0kwP7P59kH4d4DC/xxBooKA==
X-Gm-Gg: ASbGncsC/5AflOwERT3xIHW5dzhpVp0ABJxIQqr1exSKLWxE63SmMUXrbPSFJ577jM4
	nxuvAi2IWW65WVvNSMOZpmD/fPIjZ+rF1XCpIPv8xmSh8PTLZXQeWvWJhREKmWh8JX/h+jcvi0W
	okkgKOADxV9of50Ptu1hQZxEdmkR8XbEHCGns/F4ZRoTxi5rm6mxUsNg+HevKrJQ/JTVZFP/S8n
	MT3
X-Google-Smtp-Source: AGHT+IH/jRTZELaiRlcOXYueghlWrSKvl+Er6wcSXSYeSJ4Ygh1TNzIY808loskXKKypj3EiWW7XbMMUZvUaCEZC52s=
X-Received: by 2002:a17:90a:c10f:b0:312:e91c:e340 with SMTP id
 98e67ed59e1d1-3159d8f92a0mr17862431a91.35.1750710428532; Mon, 23 Jun 2025
 13:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130626.716971725@linuxfoundation.org>
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Jun 2025 01:56:56 +0530
X-Gm-Features: Ac12FXzbqaWlyV-mY2jBAeAf_VzRigYao0-wWRbsMa_bGEBBFai-0Z6bbuS6vrY
Message-ID: <CA+G9fYt2e-ZGhU57oqWwC1_t2RPgxLCJFVC0Pa8-fYPkZcUvVQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/355] 5.10.239-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Julien Thierry <jthierry@redhat.com>, James Morse <james.morse@arm.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 18:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.239 release.
> There are 355 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.239-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 tinyconfig builds with gcc-12 and clang failed on
the Linux stable-rc 5.10.239-rc1.

Regressions found on arm
* arm64, build
  - clang-20-allnoconfig
  - clang-20-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-tinyconfig


Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 5.10.239-rc1 arm64 insn.h error use of
undeclared identifier 'FAULT_BRK_IMM'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build errors
arch/arm64/include/asm/insn.h:573:9: error: use of undeclared
identifier 'FAULT_BRK_IMM'
  573 |         return AARCH64_BREAK_FAULT;
      |                ^
arch/arm64/include/asm/insn.h:26:54: note: expanded from macro
'AARCH64_BREAK_FAULT'
   26 | #define AARCH64_BREAK_FAULT    (AARCH64_BREAK_MON |
(FAULT_BRK_IMM << 5))
      |                                                      ^
arch/arm64/include/asm/insn.h:583:9: error: use of undeclared
identifier 'FAULT_BRK_IMM'
  583 |         return AARCH64_BREAK_FAULT;
      |                ^
arch/arm64/include/asm/insn.h:26:54: note: expanded from macro
'AARCH64_BREAK_FAULT'
   26 | #define AARCH64_BREAK_FAULT    (AARCH64_BREAK_MON |
(FAULT_BRK_IMM << 5))
      |                                                      ^
2 errors generated.


## Source
* Kernel version: 5.10.239-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 7b5e3f5b0ebc00e3fd81739cee4390854bf954b5
* Git describe: v5.10.238-356-g7b5e3f5b0ebc
* Project details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.238-356-g7b5e3f5b0ebc/
* Architectures: arm64
* Toolchains: gcc-12, clang-20
* Kconfigs: tinyconfig, allnoconfig

## Build arm64
* Build log: https://qa-reports.linaro.org/api/testruns/28836206/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.238-356-g7b5e3f5b0ebc/build/clang-20-tinyconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYOGFXQjUoxSVcOdLsYPowznR/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYOGFXQjUoxSVcOdLsYPowznR/config

--
Linaro LKFT
https://lkft.linaro.org

