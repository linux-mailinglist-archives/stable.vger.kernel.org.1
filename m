Return-Path: <stable+bounces-121233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07BA54B62
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58167A28F2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C43481CD;
	Thu,  6 Mar 2025 13:01:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F90BA4A;
	Thu,  6 Mar 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266100; cv=none; b=BVmws5PmbkvF5t9g0iDTXcUSuwFnJSIZ/Hwhu/pwdo+zwd1/aIEDWKK31sm0URvFjhj/Zjeatw3/ndEa2pDovIA6unQmouwrAKnU7msztqzwiWxq6j/T+VW2C+guMdsym/m91hNVezg0JXTWiYUHyElhO9NLVvGWobmR7UEPujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266100; c=relaxed/simple;
	bh=dLXT6JgK+qdj3u+kFeWfpGsHXqYsW/SpRMez3XgHJlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/Gokka/kfsHjzN+PqnjTZOF0bZO/STmzh3/6wcpuvK/CWohfuxSrGSZn4n+ns1c5JeRud+zikjsS0D8hVDCca1OMu5T8MYAfHnKdGThfjbT5UPvXqXimKFw0eLAP9XienlKIOO93KWyJGrzDNlPZxJtiyDVBJioLi9wRCyPpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EACF1007;
	Thu,  6 Mar 2025 05:01:51 -0800 (PST)
Received: from [10.1.37.172] (XHFQ2J9959.cambridge.arm.com [10.1.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC8AF3F673;
	Thu,  6 Mar 2025 05:01:34 -0800 (PST)
Message-ID: <a20a3f80-9253-4c71-8533-7afb129678f9@arm.com>
Date: Thu, 6 Mar 2025 13:01:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/150] 6.12.18-rc1 review
Content-Language: en-GB
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Will Deacon <will@kernel.org>
References: <20250305174503.801402104@linuxfoundation.org>
 <CA+G9fYvwoYVG8wgz6Lu68EO1z3m4mbBWroGEXL2w5D7P_4SG-g@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CA+G9fYvwoYVG8wgz6Lu68EO1z3m4mbBWroGEXL2w5D7P_4SG-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 12:11, Naresh Kamboju wrote:
> On Wed, 5 Mar 2025 at 23:35, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.12.18 release.
>> There are 150 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.18-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Regressions on arm64 the defconfig builds failed with clang-20 and gcc-13
> the stable-rc 6.12.18-rc1 and 6.13.6-rc1.
> 
> First seen on the 6.12.18-rc1
>  Good: v6.12.14
>  Bad: 6.12.18-rc1
> 
> * arm64, build
>   - clang-20-defconfig
>   - clang-nightly-defconfig
>   - gcc-13-defconfig
>   - gcc-8-defconfig
> 
> Regression Analysis:
>  - New regression? yes
>  - Reproducibility? Yes
> 
> This commmit is causing build regressions,
>   arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
>   commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4 upstream.
> 
> Build regression: arm64 hugetlbpage.c undeclared identifier 'sz'
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> arch/arm64/mm/hugetlbpage.c:386:28: error: use of undeclared identifier 'sz'
>   386 |         ncontig = num_contig_ptes(sz, &pgsize);
>       |                                   ^
> 1 error generated.

This is the same problem we were discussing againt the 6.13 backport. This patch
depends on a patch that conflicted so wasn't auto-backported. I'll send out the
manual backports in due course.

> 
> 
> ## Source
> * Kernel version: 6.12.18-rc1
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * Git sha: 43639cc57b2273fce42874dd7f6e0b872f4984c5
> * Git describe: v6.12.15-531-g43639cc57b22
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22/testrun/27516239/suite/build/test/clang-20-defconfig/log
> * Build history:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22/testrun/27514393/suite/build/test/clang-20-defconfig/history/
> * Build details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.15-531-g43639cc57b22/testrun/27516239/suite/build/test/clang-20-defconfig/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuR9WQOit4WjRC1XVxLJKTcQia/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuR9WQOit4WjRC1XVxLJKTcQia/config
> 
> ## Steps to reproduce
>  - tuxmake --runtime podman --target-arch arm64 --toolchain clang-20
> --kconfig defconfig LLVM=1 LLVM_IAS=1
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org


