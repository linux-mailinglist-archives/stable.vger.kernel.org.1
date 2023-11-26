Return-Path: <stable+bounces-2675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF457F9177
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 06:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A11428118B
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 05:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C7A3C35;
	Sun, 26 Nov 2023 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfwqpLFP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1EDF0
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 21:41:15 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fa235f8026so603296fac.3
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 21:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700977274; x=1701582074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S36piAfzQvna+N9L6mM9OEWRABXZuCTabjbt1X/ibi8=;
        b=BfwqpLFPxzwGWqj1N//eBSwnbxBXJoekE+n9UA4NWXMdFpQgiNWr+xTGifjY64fUx4
         U0KH6N8JQl+IMq1qicueB1xL7nR+P2I1efS6ilh48JeDSNFpldJN7cXu9IbEE0kt7BXb
         Ws89mu+DiK1Y/dMx8/LL7p3ENt2aykdrUBgjnuQOf38JFmQ+gG8NDEULwPUJ/eh09uJ7
         nIDyXGzOO6L1KLTjYQn4XIOwbKAoBPvLSl9TkigamClijV8NO+11qCJve2nv8VIiNSvR
         TnTXdFDxt0AZfJYL4yi7FKKockcZS8r7QF1G0tu1xAF5wr0eexj0Zzg4Jg6S8dbVtEHO
         xuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700977274; x=1701582074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S36piAfzQvna+N9L6mM9OEWRABXZuCTabjbt1X/ibi8=;
        b=pOWeU6CVcHegFjUYAKxxkQbtzjGDF4pHKNJSyaGibUT2+cdNdOyePdXLD6zAi9+VqN
         /8GZ90Jex/2/43302rUoUnh/zqNkFRxKTDnFN78+7zBg3CYPjSSmgS4Uet9wXQbmu1Nf
         /1AlQB14mA5YI2J/JnlscUhFaaFuk3X+Dzgwyi6D8lZNBIteyquRTLGpxxfSJSJLZriQ
         SmMDc9YO5J8CtLlsVB1eR+Nc0tcdJXBdHY0P9eYcrSonj4KbEpC3rM9U+zrlH5UlVZTK
         KRe+gVhNRyTwIvaPbzacCvRk5z4xhIINCOHQgx5CwQc5HQBpAhiGTPn9KYqXSyLs1gou
         x9gg==
X-Gm-Message-State: AOJu0YwZ+nMeXFr+mdJac3LzexRhxsPo/29oQ5q13ine7d7sw7/XWHyw
	kOgn+helKjqW8f2VoT8xhHnP0A==
X-Google-Smtp-Source: AGHT+IEwHyJDJRMTkV7S100rGnvfONxHA5hf52RO0SaB0m0JAbk6ujmtCuS5LfT6Gb03rCZFYCmWdQ==
X-Received: by 2002:a05:6871:88d:b0:1fa:2ddf:d5c4 with SMTP id r13-20020a056871088d00b001fa2ddfd5c4mr3178526oaq.25.1700977274651;
        Sat, 25 Nov 2023 21:41:14 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id bn18-20020a0568300c9200b006ce2c31dd9bsm1012164otb.20.2023.11.25.21.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 21:41:14 -0800 (PST)
Message-ID: <a853e6f3-f658-4049-9c36-66835d144eac@linaro.org>
Date: Sat, 25 Nov 2023 23:41:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/368] 6.1.64-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, hca@linux.ibm.com,
 gbatra@linux.vnet.ibm.com
References: <20231125194359.201910779@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231125194359.201910779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/11/23 1:45 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 368 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

The following configurations are failing for System/390:
* gcc-8-allmodconfig
* gcc-8-allnoconfig
* gcc-8-defconfig (+CONFIG_DEBUG_INFO_BTF=n)
* gcc-8-tinyconfig
* gcc-13-allmodconfig
* gcc-13-allnoconfig
* gcc-13-defconfig
* gcc-13-tinyconfig
* clang-17-allmodconfig
* clang-17-allnoconfig
* clang-17-defconfig
* clang-17-tinyconfig
* clang-nightly-allmodconfig
* clang-nightly-allnoconfig
* clang-nightly-defconfig
* clang-nightly-tinyconfig

The error looks like this:
-----8<-----
   In file included from /builds/linux/arch/s390/include/asm/page.h:208,
                    from /builds/linux/arch/s390/include/asm/thread_info.h:26,
                    from /builds/linux/include/linux/thread_info.h:60,
                    from /builds/linux/arch/s390/include/asm/preempt.h:6,
                    from /builds/linux/include/linux/preempt.h:78,
                    from /builds/linux/include/linux/spinlock.h:56,
                    from /builds/linux/include/linux/mmzone.h:8,
                    from /builds/linux/include/linux/gfp.h:7,
                    from /builds/linux/include/linux/mm.h:7,
                    from /builds/linux/arch/s390/mm/page-states.c:13:
   /builds/linux/arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
   /builds/linux/arch/s390/mm/page-states.c:198:30: error: 'invalid_pg_dir' undeclared (first use in this function)
     198 |         page = virt_to_page(&invalid_pg_dir);
         |                              ^~~~~~~~~~~~~~
   /builds/linux/include/asm-generic/memory_model.h:25:45: note: in definition of macro '__pfn_to_page'
      25 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
         |                                             ^~~
   /builds/linux/arch/s390/include/asm/page.h:198:34: note: in expansion of macro 'phys_to_pfn'
     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
         |                                  ^~~~~~~~~~~
   /builds/linux/arch/s390/include/asm/page.h:198:46: note: in expansion of macro '__pa'
     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
         |                                              ^~~~
   /builds/linux/arch/s390/include/asm/page.h:201:45: note: in expansion of macro 'virt_to_pfn'
     201 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                             ^~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:198:16: note: in expansion of macro 'virt_to_page'
     198 |         page = virt_to_page(&invalid_pg_dir);
         |                ^~~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:198:30: note: each undeclared identifier is reported only once for each function it appears in
     198 |         page = virt_to_page(&invalid_pg_dir);
         |                              ^~~~~~~~~~~~~~
   /builds/linux/include/asm-generic/memory_model.h:25:45: note: in definition of macro '__pfn_to_page'
      25 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
         |                                             ^~~
   /builds/linux/arch/s390/include/asm/page.h:198:34: note: in expansion of macro 'phys_to_pfn'
     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
         |                                  ^~~~~~~~~~~
   /builds/linux/arch/s390/include/asm/page.h:198:46: note: in expansion of macro '__pa'
     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
         |                                              ^~~~
   /builds/linux/arch/s390/include/asm/page.h:201:45: note: in expansion of macro 'virt_to_pfn'
     201 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                             ^~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:198:16: note: in expansion of macro 'virt_to_page'
     198 |         page = virt_to_page(&invalid_pg_dir);
         |                ^~~~~~~~~~~~
   make[4]: *** [/builds/linux/scripts/Makefile.build:250: arch/s390/mm/page-states.o] Error 1
----->8-----

Bisection points to:

   commit 1a5dd59623dc206de30df2d13316a3ce9be6821a
   Author: Heiko Carstens <hca@linux.ibm.com>
   Date:   Tue Oct 24 10:15:20 2023 +0200

       s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
       
       commit 84bb41d5df48868055d159d9247b80927f1f70f9 upstream.


Reverting that commit made the build pass.

Reproducer:
   tuxmake --runtime podman --target-arch s390 --toolchain gcc-13 --kconfig tinyconfig


Then, there's a PowerPC failure too on the following configurations:
* gcc-8-allmodconfig
* gcc-8-defconfig
* gcc-13-allmodconfig
* gcc-13-defconfig
* clang-17-defconfig
* clang-nightly-defconfig

That looks like this:
-----8<-----
   /builds/linux/arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
   /builds/linux/arch/powerpc/platforms/pseries/iommu.c:926:49: error: 'struct dma_win' has no member named 'direct'
     926 |                         *direct_mapping = window->direct;
         |                                                 ^~
   make[5]: *** [/builds/linux/scripts/Makefile.build:250: arch/powerpc/platforms/pseries/iommu.o] Error 1
----->8-----

I guess it might be due to this:

   commit fd018dfa8f0b963d65700d518596f9d834844fca
   Author: Gaurav Batra <gbatra@linux.vnet.ibm.com>
   Date:   Mon Oct 2 22:08:02 2023 -0500

       powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device
       
       commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e upstream.


Reverting that commit does make the build pass again.

Reproducer:
   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13 --kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


