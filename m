Return-Path: <stable+bounces-199965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72217CA2AE0
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7000E305F30F
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA252586E8;
	Thu,  4 Dec 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8WkcjwA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9673009D8
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834341; cv=none; b=MtUoLlhxdn2JvqhjQb4RLW55AwVe9nOGRLHohdtPvt7mwd7BXkF+W6Dv2f6PTe8waOvZ/3z08TAC8RQtTKYXF1sjlY6jWnAKGyFSogh1vUX3aIYwTc56Qt4Tv4Dd5apv0w7x/qoYtgXeQlLjR43DHtEP0RJKTC3roNdak/s+5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834341; c=relaxed/simple;
	bh=iDT/wqiSBYCQxt8e6q52hcETrlYBLMBYoLMfyuViCxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvUJLQ+NeDyAlCR5ad0fI/RGzWFI4TnhpqXoJd9Rf2V8aZ8AaH6u9jr1ye/TObrpbVT+JPf5mRbITxYU1Pus9a+XCPno2p/9zVq8MUtXTXZK0/uV38xvbx/9/MeAa3pEcDVH4I4kkxOiJ4HUlsbSgi6+0XOwJdk3TdeOlK/r6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8WkcjwA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bddba676613so392550a12.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 23:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764834338; x=1765439138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/VdY4XrCiq9JGv1YtacLcQEMzqQV5BY2qbeU5UNUUY=;
        b=J8WkcjwA9miv/Fd90jpZpE2EAf0kLfbY9WbAzT9UOwnw39X0Kh36tgEOlHmQ1JsnJv
         M6lDZku0TK2kq0LxCiD0fM93jbi1NLuT0ffdHt6KBBR0GSNiVGkwC1oOXkXIqLIxox+G
         z3vGm/+H2kKZBOzthq7bJRUZdbLIFIgPpfyMpGPcLrTP1PXC3dtFO2Ai7GRH3/t2sIxm
         7BFSq6CJfctu/Y1l1vIsXrw/JRyqbhppp5c9LQsKWwZuGUuZ/+j9GWVqQdc2S1j5fqyz
         oO4bJv1Rb6Mg+LJuO20UvAHAph1lwsAlz9pU4GCcDSVN6v+HREOACupES2B90gWI1zm2
         +Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834338; x=1765439138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/VdY4XrCiq9JGv1YtacLcQEMzqQV5BY2qbeU5UNUUY=;
        b=FjAOKZQ76a/dL0ZjitdutDZppWDX872Nj8E20Et6C63OA3vkpZ78zdbFnpx1Jy53wk
         UTR3ju7gLoTIOTMhl5AIb1dJUE4mNjmgP67LjNVoxNYbTAKqyqko+DqucucpVIZE86iW
         d9LLQEClj8mVEHeRlUXVSO9GthrWMPhoOl4YscT1atAo6widUa4SsksheZ83YINXqWdB
         KPP2F5GHXGhUfSzMJ7g0K6XDtBE6FlH5gAQSZStuISnHySxMzgvPdGn3+UXU+YK7fCHu
         69wlCEWTWmbK8idQrAADwMbugqqiehu3wUma/x75t1MnIyRtiYs/eozUr0ZGDRYZsMYX
         0KEA==
X-Gm-Message-State: AOJu0YxbDIixK8N8vEf5JaK/JDqxBJbvI2kFczKQG6Z8uTD3XwjRnYc8
	pk8sxVpdkmxpAXLZsZdcO62JARG5i69rxb/YEFyShmUsNxZNCtbus5FXHIGFq4js6F6UxBxiF8U
	bqq4TGG5t1/NGA56ozxslYrquh6TREDLja+Pqll9zxw==
X-Gm-Gg: ASbGncsO4GaP+dWhvV+nRAtKhCMrWGahf5OlazNBU/Q7F8PLlC1a1Jh8IlcXXiMhAZp
	PE3FiBgAOolkD/MbNibHhhNUyJkuBexAYQ/xFzjHAgwi2ztdB8Q88Rg7/+lnMZDxDoppRVTbU46
	e/2hoh/PBc/aLUFmSUiXUv3EKWc/JmodN3hR4ZLzJ/RU88dLvJQjT79bVc0EhHDzZGkdnl7lS3o
	fZMhYPVd8RpvI6Y6sp7F6aDnS8wkqZeUcK+fhSJZ1KnVk2BV7EXJI+rglmiV6HHV6RHH+fSBNcr
	/FBMMFCf3dZTsuVlP14QyqxPvecx
X-Google-Smtp-Source: AGHT+IG10afET9T3Ub9wLlDT0qWDWZ0n9lazNt4M7TurqIzRg3RadMLVZ9tq2GeFZCxStuhq3jJ68oVlI95ztIydtSI=
X-Received: by 2002:a05:7300:e88c:b0:2a4:3593:c7c9 with SMTP id
 5a478bee46e88-2ab92dc244amr3941532eec.9.1764834338008; Wed, 03 Dec 2025
 23:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152400.447697997@linuxfoundation.org>
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Dec 2025 13:15:26 +0530
X-Gm-Features: AWmQ_bnjQnTC1TLDReG7C38DK19U5dV-pQyUzI5wF1BggqzI2YGjOyuV97pKrtA
Message-ID: <CA+G9fYsAqF2990v6FBqVcmcT+jRB-itHnz8EAnaVw5nJ_txFfw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/300] 5.10.247-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 21:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.247 release.
> There are 300 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.247-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The arm, mips and powerpc builds failed on the stable-rc 5.10.247-rc1

Build regressions: arm, fuse-tegra30.c:250:10: error: 'const struct
tegra_fuse_soc' has no member named 'cells'
Build regressions: arm, fuse-tegra30.c:250:18: error: initialization
of 'const struct attribute_group *' from incompatible pointer type
'const struct nvmem_cell_info *' [-Werror=incompatible-pointer-types]
Build regressions: arm, fuse-tegra30.c:251:10: error: 'const struct
tegra_fuse_soc' has no member named 'num_cells'

Build regressions: mips, mips/mm/tlb-r4k.c:591:31: error: passing
argument 1 of 'memblock_free' makes integer from pointer without a
cast [-Werror=int-conversion]

Build regressions: powerpc, mm/mempool.c:68:17: error: 'for' loop
initial declarations are only allowed in C99 or C11 mode
Build regressions: powerpc, mm/mempool.c:70:38: error: implicit
declaration of function 'kmap_local_page'; did you mean
'kmap_to_page'? [-Werror=implicit-function-declaration]
Build regressions: powerpc, mm/mempool.c:73:25: error: implicit
declaration of function 'kunmap_local'
[-Werror=implicit-function-declaration]
Build regressions: powerpc, mm/mempool.c:101:17: error: 'for' loop
initial declarations are only allowed in C99 or C11 mode

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Arm build regressions are due to,

  soc/tegra: fuse: Add Tegra114 nvmem cells and fuse lookups
  [ Upstream commit b9c01adedf38c69abb725a60a05305ef70dbce03 ]

MIPS build regressions are due to,

  MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow
  commit 841ecc979b18d3227fad5e2d6a1e6f92688776b5 upstream.

Powerpc build regressions are due to,

  mm/mempool: replace kmap_atomic() with kmap_local_page()
  [ Upstream commit f2bcc99a5e901a13b754648d1dbab60f4adf9375 ]


### arm build error
drivers/soc/tegra/fuse/fuse-tegra30.c:250:10: error: 'const struct
tegra_fuse_soc' has no member named 'cells'

  250 |         .cells = tegra114_fuse_cells,
      |          ^~~~~
drivers/soc/tegra/fuse/fuse-tegra30.c:250:18: error: initialization of
'const struct attribute_group *' from incompatible pointer type 'const
struct nvmem_cell_info *' [-Werror=incompatible-pointer-types]
  250 |         .cells = tegra114_fuse_cells,
      |                  ^~~~~~~~~~~~~~~~~~~
drivers/soc/tegra/fuse/fuse-tegra30.c:250:18: note: (near
initialization for 'tegra114_fuse_soc.soc_attr_group')
drivers/soc/tegra/fuse/fuse-tegra30.c:251:10: error: 'const struct
tegra_fuse_soc' has no member named 'num_cells'
  251 |         .num_cells = ARRAY_SIZE(tegra114_fuse_cells),
      |          ^~~~~~~~~


### mips Build error
arch/mips/mm/tlb-r4k.c: In function 'r4k_tlb_uniquify':
arch/mips/mm/tlb-r4k.c:591:31: error: passing argument 1 of
'memblock_free' makes integer from pointer without a cast
[-Werror=int-conversion]
  591 |                 memblock_free(tlb_vpns, tlb_vpn_size);
      |                               ^~~~~~~~
      |                               |
      |                               long unsigned int *
In file included from arch/mips/mm/tlb-r4k.c:15:
include/linux/memblock.h:106:31: note: expected 'phys_addr_t' {aka
'unsigned int'} but argument is of type 'long unsigned int *'
  106 | int memblock_free(phys_addr_t base, phys_addr_t size);
      |                   ~~~~~~~~~~~~^~~~
cc1: all warnings being treated as errors


### powerpc build error
builds/linux/mm/mempool.c: In function 'check_element':
mm/mempool.c:68:17: error: 'for' loop initial declarations are only
allowed in C99 or C11 mode
   68 |                 for (int i = 0; i < (1 << order); i++) {
      |                 ^~~
mm/mempool.c:68:17: note: use option '-std=c99', '-std=gnu99',
'-std=c11' or '-std=gnu11' to compile your code
mm/mempool.c:70:38: error: implicit declaration of function
'kmap_local_page'; did you mean 'kmap_to_page'?
[-Werror=implicit-function-declaration]
   70 |                         void *addr = kmap_local_page(page + i);
      |                                      ^~~~~~~~~~~~~~~
      |                                      kmap_to_page
mm/mempool.c:70:38: warning: initialization of 'void *' from 'int'
makes pointer from integer without a cast [-Wint-conversion]
mm/mempool.c:73:25: error: implicit declaration of function
'kunmap_local' [-Werror=implicit-function-declaration]
   73 |                         kunmap_local(addr);
      |                         ^~~~~~~~~~~~
mm/mempool.c: In function 'poison_element':
mm/mempool.c:101:17: error: 'for' loop initial declarations are only
allowed in C99 or C11 mode
  101 |                 for (int i = 0; i < (1 << order); i++) {
      |                 ^~~
mm/mempool.c:103:38: warning: initialization of 'void *' from 'int'
makes pointer from integer without a cast [-Wint-conversion]
  103 |                         void *addr = kmap_local_page(page + i);
      |                                      ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


## Build
* kernel: 5.10.247-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: d50f2a03a87b402853207713f5e83c7f07c7ddab
* git describe: v5.10.246-301-gd50f2a03a87b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.246-301-gd50f2a03a87b

## Test Regressions (compared to v5.10.245-326-g98417fb6195f)
* arm, build
  - clang-21-defconfig
  - clang-21-lkftconfig
  - clang-21-lkftconfig-no-kselftest-frag
  - gcc-12-defconfig
  - gcc-12-lkftconfig
  - gcc-12-lkftconfig-debug
  - gcc-12-lkftconfig-kasan
  - gcc-12-lkftconfig-kunit
  - gcc-12-lkftconfig-libgpiod
  - gcc-12-lkftconfig-no-kselftest-frag
  - gcc-12-lkftconfig-perf
  - gcc-12-lkftconfig-rcutorture
  - gcc-8-defconfig

* mips, build
  - clang-21-allnoconfig
  - clang-21-defconfig
  - clang-21-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-ath79_defconfig
  - gcc-12-bcm47xx_defconfig
  - gcc-12-bcm63xx_defconfig
  - gcc-12-cavium_octeon_defconfig
  - gcc-12-defconfig
  - gcc-12-e55_defconfig
  - gcc-12-malta_defconfig
  - gcc-12-rt305x_defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-ath79_defconfig
  - gcc-8-bcm47xx_defconfig
  - gcc-8-bcm63xx_defconfig
  - gcc-8-cavium_octeon_defconfig
  - gcc-8-defconfig
  - gcc-8-malta_defconfig
  - gcc-8-rt305x_defconfig
  - gcc-8-tinyconfig

* powerpc, build
  - gcc-12-ppc6xx_defconfig
  - gcc-8-ppc6xx_defconfig

## Metric Regressions (compared to v5.10.245-326-g98417fb6195f)

## Test Fixes (compared to v5.10.245-326-g98417fb6195f)

## Metric Fixes (compared to v5.10.245-326-g98417fb6195f)

## Test result summary
total: 28943, pass: 21942, fail: 2265, skip: 4545, xfail: 191

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 100 total, 86 passed, 14 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 0 passed, 22 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 19 passed, 2 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

