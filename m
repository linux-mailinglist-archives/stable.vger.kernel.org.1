Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8927D5B90
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJXTf2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 15:35:27 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5F111
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 12:35:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ea82246069so3197690fac.3
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698176124; x=1698780924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehA1XcRSKytZRvPE2Xg2Y2Q4wNLjAC3JoeQ4eBMwi+4=;
        b=S6NTXu3NyOGbLNaES5Ea3NE4GULOfH1Rp3KsRwSxXUSejqty4CWyjhZ/PpYtOz0YmW
         PkcjCyDFZRRzix6/t9P7o3naR40PIZImEOCsLrrYrC9rXbhQk1zN1XA7QiJc9AROHEZO
         EZyrskF8/I7kRkBVU7MN+Eis5ReGW1eX1Ve//WkJM7Ch50rMEAetUJr7n5+RP63QvLEX
         PXMO9bnK50mtTpsBVKtuEEB6tL77fbV3ydRyAjfRpUhYSsIRxgu2U48VpNMEh/mfzj4J
         h5OQlSZqR6jmDoJ5gb+2JX/9pB+sBf916dKPNV2DvCwok7NiPBypgoKnWpQJOHDQT5Dd
         2XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176124; x=1698780924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehA1XcRSKytZRvPE2Xg2Y2Q4wNLjAC3JoeQ4eBMwi+4=;
        b=WAjOjh+l7QcjCyN/qt7RlyV079kySywQA5Mpcj5Kvuec5+xMopvxeeckO0yJCcKSU5
         tk1sJBOTv0cC3APL2km0ro/ian65APldiWTckX53etbO0QF/0wh7AKQA7ePbmGZxATaM
         SDW/6P3izq+T23Sae0pmkJiD4rC6c7PAv26yUw1zlhcmuB0MFGZfpUA2UqJyID59Uckk
         TRRbeweh4cNTMPYwIPE4Ek4OmO7K+dJ1MpXO7T+l+FquudJvgW4U2ZGlW4FK50bpn0/m
         vW/zEty6tcr0bXGc3nWy2uVF40e+EO46YEvtH0iIOoHcw9CnLK2vDtolUfa0niLz1obU
         beIA==
X-Gm-Message-State: AOJu0YzehofXyy5H2bmM8liObHxCw+FxRkg47cikQUjGsXcZOe5t8yuj
        5XPJ+QI3+1gUiLCgCvUKVFYJzA==
X-Google-Smtp-Source: AGHT+IE9aZLHfzH7tXX3IKOTFJS+ZasvFhDJUQ8Do+lJsRvSYCEQR8ZHDKqmAR8jqceYk84cEWmD/w==
X-Received: by 2002:a05:6871:5225:b0:1ea:2ed0:2978 with SMTP id ht37-20020a056871522500b001ea2ed02978mr15790291oac.22.1698176123750;
        Tue, 24 Oct 2023 12:35:23 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id n6-20020a05687104c600b001d6e9bb67d2sm2297818oai.7.2023.10.24.12.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:35:23 -0700 (PDT)
Message-ID: <add093f4-7d9b-40f8-9939-fc4a9c6804c1@linaro.org>
Date:   Tue, 24 Oct 2023 13:35:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231024083327.980887231@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On 24/10/23 2:36 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.137-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: bc0ffd9b5ee2ac6b8d9c4d3eba4b4facfb911ae1
* git describe: v5.15.135-237-gbc0ffd9b5ee2
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.135-237-gbc0ffd9b5ee2

## No test regressions (compared to v5.15.135-103-gf11fc66f963f)

## No metric regressions (compared to v5.15.135-103-gf11fc66f963f)

## No test fixes (compared to v5.15.135-103-gf11fc66f963f)

## No metric fixes (compared to v5.15.135-103-gf11fc66f963f)

## Test result summary
total: 87626, pass: 69916, fail: 2587, skip: 15056, xfail: 67

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 114 total, 114 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 32 total, 32 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

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
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
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
* kselftest-ptrace
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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
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
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
