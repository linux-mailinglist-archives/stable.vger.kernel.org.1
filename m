Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374687D4A54
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJXIew (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjJXIe3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 04:34:29 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A910C6
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 01:34:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce291b5df9so2609229a34.2
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698136462; x=1698741262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDTsgqY5CgCJtGIHbt13mkSoTHTopvrjP0Xbs63E/kI=;
        b=Ap6Hj1zejyVwpHBiYpfKNdYWGv/uwsPh0h9kxJQdKWLRMqsJVBYJ/z8tZ6duRclk+Q
         ct9bim5tOSH+GClnlDOqRr9tBGPDmnQpN7pYD6px6jIvGKkJNl208OdfDm8KI0K0G/iO
         BUFkive09fT3j9mttNkYTBiTLFo1ervxTeHOkGVPEtpt/8bLiaBGUHCN7qWiopX6Hef6
         1TvCOCqTQyfA8Fjp+ZvMwgwwDRRgDZ5LhmbiTbBJE/EEIHasrIE1VEbMyJdi7H/cqG4Y
         /R/jAGyd00gOIsGLNh869x4RhJRpt6FurCD4kxw88uyhV1MwrQfoB5yBaaRZ/bYoTsOA
         XG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136462; x=1698741262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDTsgqY5CgCJtGIHbt13mkSoTHTopvrjP0Xbs63E/kI=;
        b=u7Qh5YhuDYevt5s6JWKrEuKMD0BlJCbp3tQbdJLV1LcCSZL0eCdHFHSLh/7ZeWLwgz
         ZQbUWmL64jI3NUtxpXzQ1HIe6CsH/qPn3tIPenJcJVj2ceTPw1hvyn9/hpOw04euRKSk
         Xi7DJ2LDfFDw/PSmkbRo9vWI4ujncuqd9u2SMrFKeO+UTwHRXlKjbWDNNv6g/pGIa/ca
         Ecw8gb4BA5/9wKNBV33uMJGgY9nP9kbsrt++fceaijZSMoJkOMU1+UUzjMafPXiBee0m
         BkBc4cgWM26THgbH4CW3hkbiIV887BfS3SBdOQ7F9Psqm5QvmjCD2b0KdJM/ZycYAzn+
         Q2SA==
X-Gm-Message-State: AOJu0YxvYA2t3FfFriu0cQNB5gEQLgOBjp95keozpwsSXlkMj2549U6J
        WLDGEsg/uDVhi75DWkJFm+gvNg==
X-Google-Smtp-Source: AGHT+IEW7sI0oHCUsnHs9+KSFkzlgkRcy+wQYt/479OJAFhaxUD9jCpwlHEtfCkfxlhA+jaO8kpnlg==
X-Received: by 2002:a05:6871:89f:b0:1ea:2162:a898 with SMTP id r31-20020a056871089f00b001ea2162a898mr13096151oaq.16.1698136462161;
        Tue, 24 Oct 2023 01:34:22 -0700 (PDT)
Received: from [192.168.17.16] ([138.84.45.126])
        by smtp.gmail.com with ESMTPSA id kz8-20020a05687c320800b001eb7196de06sm753739oac.54.2023.10.24.01.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:34:21 -0700 (PDT)
Message-ID: <3d00d797-8924-4688-bdb4-73a55cea19a9@linaro.org>
Date:   Tue, 24 Oct 2023 02:34:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/98] 4.19.297-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104813.580375891@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.297 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.297-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.297-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 33864da1a6f6659bbf20a96027f771d5f430baa7
* git describe: v4.19.296-99-g33864da1a6f6
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.296-99-g33864da1a6f6

## No test regressions (compared to v4.19.296)

## No metric regressions (compared to v4.19.296)

## No test fixes (compared to v4.19.296)

## No metric fixes (compared to v4.19.296)

## Test result summary
total: 57308, pass: 49017, fail: 1540, skip: 6718, xfail: 33

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 214 total, 202 passed, 12 failed
* arm64: 64 total, 54 passed, 10 failed
* i386: 36 total, 30 passed, 6 failed
* mips: 43 total, 43 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 47 total, 47 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 54 total, 44 passed, 10 failed

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
* kselftest-user
* kselftest-vm
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

