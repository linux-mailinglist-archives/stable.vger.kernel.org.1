Return-Path: <stable+bounces-4710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8928059E1
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EB8281F66
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170160BB8;
	Tue,  5 Dec 2023 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQ6JbyMV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139E122
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 08:21:15 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c461a8684fso1353351241.2
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701793275; x=1702398075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmAkQb/1MroERVIyIw0Fp7+C3+mpW6FbekfkXqQHOdM=;
        b=pQ6JbyMViiQbya7DJlcbzP+MxXkqlRZm+Xqrc1//HKmCJNpiRDs94SUgfCYzT2e4T+
         XB5ODBO42EMj7l03RPJoNsZHBpIqTT7LbHpUq0D4HFqFYv5I3r9KP+Z98ami8Zj240Dq
         8acqoMwvvwBh6NnEc26GR7EusUxq6iBwr2GsCrHjkeVB1EBy27oJOEfVYM2m10OcDYWB
         dtUfkqXDmdUIhGCHOg7La8Vx3V2wjqRocz1h41G5dbXkJKlU4pUWYACHZZk25/mXVJgS
         iOe73OZI0tmIx0l26Xxl7DxAaxKmoxyXZ0s8h7woMJTxeDsPLgv2V+MC2aZhNHCl2IvP
         kqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793275; x=1702398075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmAkQb/1MroERVIyIw0Fp7+C3+mpW6FbekfkXqQHOdM=;
        b=n62qtqdl/R7ggroME38i7fhVYnpUSaYa5/Py2NtnyrolqsqIu7ks9pHsWjODWDkBuD
         dXlYLyJxw7UwhdIvdKpdAH9hSiB2phFeoDuP+fi7CyH600YaYiLXZY8O96d/jJkRxqoL
         xAoZjc7vehTvKElwBhvPiW8C6JvKBldFGYWHUCdRhA4uRiu7JVwGXkMIqqRnCuCtA/5M
         2uTO03jgj2RrmE9nGBqYXt+BBnSa1qCygfh7cF9WO3XtR/aohs1QiXG4ZdqFQqWXZOFh
         zqvMI6tmX4nvLc1Opar4al35Yu9MWbG0DHmKVqVGivR6peA4JQflQFhE0HEWlwtoOqvi
         frPQ==
X-Gm-Message-State: AOJu0YyMTXcCaXKfaY9Yn3nqiLSU5J/ouiU07zOuk3vZ7vLtoeCodCOj
	eAr0Tm3m0g4B7iDBDKiosFrX6OTTZ/6ntx4RoOUHdw==
X-Google-Smtp-Source: AGHT+IFKdDeq0ZdVTclJaBsMXkTDIpAHb7IkgfNh+LabXJK2B4KIqFMn7aJn4bBqzsCyBRaPx1Kd+vEDBP9x2g3onY0=
X-Received: by 2002:a05:6122:90e:b0:4ac:2316:5afa with SMTP id
 j14-20020a056122090e00b004ac23165afamr4338177vka.12.1701793275028; Tue, 05
 Dec 2023 08:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031531.426872356@linuxfoundation.org>
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Dec 2023 21:51:03 +0530
Message-ID: <CA+G9fYt4DSUQA-zcuZUxVnoSx+DUo0ZB1sX=d2SSwBaD0s_a+w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 08:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Powerpc, s390 and riscv allmodconfig failed on stable-rc linux-6.1.y

 - s390: gcc-13-allmodconfig: FAILED
 - Powerpc: gcc-13-allmodconfig: FAILED
 - riscv: gcc-13-allmodconfig: FAILED

S390 build error:
arch/s390/mm/page-states.c:198:23: error: 'invalid_pg_dir' undeclared
(first use in this function); did you mean 'is_valid_bugaddr'?
  page = virt_to_page(&invalid_pg_dir);
                       ^~~~~~~~~~~~~~

s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
 [ Upstream commit 84bb41d5df48868055d159d9247b80927f1f70f9 ]


Powerpc build error:
arch/powerpc/platforms/pseries/iommu.c:926:28: error: 'struct dma_win'
has no member named 'direct'
    *direct_mapping = window->direct;
                            ^~

powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping
for SR-IOV device
 [ Upstream commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e ]


riscv: gcc-13-allmodconfig: FAILED

drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_ovf_handler':
drivers/perf/riscv_pmu_sbi.c:582:40: error: 'riscv_pmu_irq_num'
undeclared (first use in this function); did you mean 'riscv_pmu_irq'?
  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
      |                                        ^~~~~~~~~~~~~~~~~

drivers: perf: Check find_first_bit() return value
 [ Upstream commit c6e316ac05532febb0c966fa9b55f5258ed037be ]


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Z6hXBQ5SQY07zKJyG6c3B1W9M0/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2Z6hXGJFTdSPKZSutAt0vOOcDd1
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-108-gc1e513337d8b/testrun/21509082/suite/build/test/gcc-13-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-108-gc1e513337d8b/testrun/21509040/suite/build/test/gcc-13-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-108-gc1e513337d8b/testrun/21509172/suite/build/test/gcc-13-allmodconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

