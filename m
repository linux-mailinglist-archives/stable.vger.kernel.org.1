Return-Path: <stable+bounces-116535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702DAA37C62
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 08:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E23AD88D
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA01991A1;
	Mon, 17 Feb 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLHQ1/+o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1317B506
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777936; cv=none; b=odCKIygK1idxZyqzbPVE9/3DbmuYYjuJw9d1vDL0vH7NOF8pNSDUaW0VX0hdQf4v+CFkfF9hnPGiW3ZICnkFGTE1lozyJOeTfC6Fe5JI6Q3CMKC4WUvimmaVHUoHj7GaNlV/cdh0apQMD5wI5XO7hQu2ON9cNI+LY5b/Vl0b6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777936; c=relaxed/simple;
	bh=o3q5Mohf7PVZHZun6xxeIiXGynUtqsaAjaH9JUJndfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is4bF506S4jEoehLYfzbTknGFhi6O3LglBPdAdsOPYaqb0m3XVxOirkL41za8//q7FACvgxxo3UWKWAds8KK2Ts5esDBxC5u7pLTuSIS7CbiEEdy0qjwqwVjASRfgdKFM6xMxuW2D+JqdiqgRHY6rhQ043n8MWfyoaE28ZNlSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qLHQ1/+o; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-868ec803d83so973866241.3
        for <stable@vger.kernel.org>; Sun, 16 Feb 2025 23:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777932; x=1740382732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwI8anyOyQtHe3taV6VbhpulS2/ZTxMEIIPtJmg1WRE=;
        b=qLHQ1/+oeN2N0gC3qAtjhJ0i79rtl4/GdTofOtEhAf5aDetBBKpteFFRVKFFdZfFil
         oNLaVUg7hf+t1BOO2K7qhX6U2Vkx+7XWBqlU5Jam/wwKTubxL0jObRHMT493nS3MyKW+
         iURWZ7kg9TikICtoMEI6kXqiJdvh/d/5zKowGe37F22oFAZfa4Zl3P8y3cqdPnSUhphT
         29YViY9dnPo6DNeniUKVlN+UerP7xnDCeH5Nb7mtGoFidw3k6RGIh2VoPXTxyUABSGDB
         WfVvMRCUSw+5ahHKKgr2lrezcT+ffhGEq1m+2pniknWnQvs6zzso+JPfwBExIIrCFI4D
         92Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777932; x=1740382732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwI8anyOyQtHe3taV6VbhpulS2/ZTxMEIIPtJmg1WRE=;
        b=NasdPIDqkZDN+/bP6S8Ql5/u1wmVO3vwTQEc/Pi46czlCAXhi86POprHP+FmA8Tg/k
         ffe6uV45zNFjVY0I9XAzexnZJ+FZV6S7HHkzsN1lVvAh4Q0AEyqsxPSmiFC8YWXMHB1N
         JCfpsqs7npnYBmEKc0Z/NPMs0fSTwwFqeXfOfCp8D0wI8UnVOAsN1gNvFXMjCYkrKRJF
         EJa8nueb9xQTfR1FlkhZt1OfaXVUl/mcXdT240D/T5rtNv1ObSSl5mc22vM228MC7Yxm
         TvnxUMR+iCcUi2Sqo7qXd7OSF/SpMRz7Mic7KXoJcGdqPrYwYTL7F/90sev3Sxx+IGZR
         jRdQ==
X-Gm-Message-State: AOJu0YwRh92v1LpMvKT2BVfkyVV+gSBnOwKHziUydskKdj9aeDkx2njJ
	xWLOM4hWNkAcwDqTwY7Mn3iu0W+bZQ1LuWS4qSBC85lDtuBLB5teGzkUOYRQKLqfdzsa8nYzJWq
	lo2tv1zueb5+HZgfx4TYuYRF6OARuHdH/mIm41Q==
X-Gm-Gg: ASbGncsOt/cSElSYvdyjoGsFnYO+meb+sai29zvyf53gFMz8biZf2yiA4uihtJOFSxI
	U/9TzEnCAn9xPt+k/GWwnSY+dO/AFTWnzI+1SRAqy9HrwvN4+H5nF3jD3G5W8yjX6glTwXV0R6F
	A=
X-Google-Smtp-Source: AGHT+IHIomYH6wLpOpghSdaUEjkhzRp96SGuOIHHvKJUtJWgnW6RIgsw2Dtyn2AYg0W3RUIxf7Otmyq5pkxRDQ0M5Ic=
X-Received: by 2002:a05:6102:150f:b0:4bb:dba6:99b7 with SMTP id
 ada2fe7eead31-4bd3fd83d64mr4375684137.13.1739777932222; Sun, 16 Feb 2025
 23:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075701.840225877@linuxfoundation.org>
In-Reply-To: <20250215075701.840225877@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 17 Feb 2025 13:08:40 +0530
X-Gm-Features: AWEUYZkqyonr9_UF2TlkWkSaWReRRBluM-paFS4RwfOE78zPBN5yQ0U5Y3-pXdo
Message-ID: <CA+G9fYsBu8DOLEDQoGrdZmjwZKvz72tMmrVPnQSJLNMbefYymw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/418] 6.12.14-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 13:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 418 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:52:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression on qemu-arm64, qemu-armv7 and qemu-x86-64 on 6.12.14-rc3
We will investigate this and get back to you.

Test regression: arm64, arm, x86 selftests: memfd: run_fuse_test.sh

* fvp-aemva, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-armv7, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-arm64, kselftest-memfd
  - memfd_run_fuse_test_sh
* qemu-x86_64, kselftest-memfd
  - memfd_run_fuse_test_sh

# Test log
selftests: memfd: run_fuse_test.sh
./fuse_mnt: error while loading shared libraries: libfuse.so.2: cannot
open shared object file: No such file or directory
not ok 2 selftests: memfd: run_fuse_test.sh  exit=127

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Source
* Kernel version: 6.12.14-rc3
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: aa95ced31609f49f9342be3c04e538ccf5b2ba18
* Git tescribe: v6.12.13-419-gaa95ced31609
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-419-gaa95ced31609

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-419-gaa95ced31609/testrun/27310664/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-419-gaa95ced31609/testrun/27310664/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.13-419-gaa95ced31609/testrun/27310664/suite/kselftest-memfd/test/memfd_run_fuse_test_sh/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2t4Mt9eXLqMfhglIHy5AoPdnTUz/config
* Architecures: arm64, arm, x86_64
* Toolchain version: gcc-13

--
Linaro LKFT
https://lkft.linaro.org

