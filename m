Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05F17D5BA5
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJXTkZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjJXTkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 15:40:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955F0111
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 12:40:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af609c5736so2858298b6e.3
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698176422; x=1698781222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcWM7D8z9+N/77Wmulmo8mnYRJT4imdJt9aViCXwiOM=;
        b=cctQ+oDY64MaGH+4BJsEVwvSxNY21A5EyY9tULOAxSfyo8oORXxPa2t7Sr7xFXYBiJ
         FY6ByF44PDxnTzzUqD8eevbO05r7rd3eAoP1Ggkn/ru6iJr0zgp0fNkTgXWnPFx786sY
         haaLibeuypIG3cu93sSUCs57bW2BMCO1gxinFaSU61nOYuDpJjCPM5r2GE1K8WGk1lhR
         un7inO4FITeqhVvSSq1sMo3uEPNNXeadbKjjTpBGaZ9GYkMDp3AmNFGMBAE60jCOBxQb
         ELfaZaAjBqIJ8BaDsuRZH79mJqh257/1AaVVl+1tP5IPtW6XSjSYA/NyUFZOm+F7yYkR
         Se3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176422; x=1698781222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcWM7D8z9+N/77Wmulmo8mnYRJT4imdJt9aViCXwiOM=;
        b=lsIZm6pusPkmqaM/YunncQRrp5XxZnK4U0n8lBHS91nL0QblD48rXeHv4ib822xNIP
         iYoVufyCJRjuU0wXzDfS411OFbAG0+tcEtx8poMVhKvzgozelBiGQTKGWP08hjMzZWmC
         NwGRJwIyDTZ3Z4pfmRUQ8jz3Czq0fziVZTmDhb2ST3wWv0a9BP7jPDZ3rQgMnwrySH+G
         JQ3jWw8uTLOUU7ecVLQDRmXw4U1+T8gXJAfmDanqmzcwxUdugQIrrOdbt5a4C340hcNh
         02Cf3LEQv+ZykjGSOq8gsygPlqEKeBuADB2ZdSSQsQS2+35YC5j864WutbanstN7xIBD
         05hg==
X-Gm-Message-State: AOJu0YxRtDAXKJOLrRYNKjopt026uWg2X8E2weSoV3pK1QAag7O+suo9
        SFWE5/TT9kRdIm+eHLi5t+W85Q==
X-Google-Smtp-Source: AGHT+IFIM6P6WEAmTPtH86jyNO9uaaVfNyp5lzemtIXZPEsSe5/5zyFLpzzYkCtHVLdHdIzl4g57fQ==
X-Received: by 2002:a05:6808:311:b0:3af:b6ea:2e2 with SMTP id i17-20020a056808031100b003afb6ea02e2mr9660195oie.59.1698176421872;
        Tue, 24 Oct 2023 12:40:21 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id d9-20020a0568301b6900b006ce2c31dd9bsm1993535ote.20.2023.10.24.12.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:40:21 -0700 (PDT)
Message-ID: <731ccc1e-2491-4b4c-92ed-d32b611fbbf8@linaro.org>
Date:   Tue, 24 Oct 2023 13:40:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/65] 4.14.328-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231024083251.452724764@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231024083251.452724764@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On 24/10/23 2:36 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.328 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.328-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.328-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 403b3799ab3ff03ad5d7d7b7bbe40dd35e8bfec3
* git describe: v4.14.327-66-g403b3799ab3f
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.327-66-g403b3799ab3f

## No test regressions (compared to v4.14.327)

## No metric regressions (compared to v4.14.327)

## No test fixes (compared to v4.14.327)

## No metric fixes (compared to v4.14.327)

## Test result summary
total: 52637, pass: 44228, fail: 1533, skip: 6837, xfail: 39

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 103 passed, 5 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* rcutorture


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org

