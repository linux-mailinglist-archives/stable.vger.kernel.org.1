Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51853775F89
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHIMqP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHIMqO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 08:46:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3C19A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 05:46:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bb7a1c2fe5so5143692fac.2
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691585172; x=1692189972;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y00dp6QJ4g5u69/rrwlBopOO8kAGq1s2NlH42DcsrYU=;
        b=DufbvmZHS51mb2iadTMF9semGIDdwLqncQEpVauhYa2EtcbrHw+/ZYU8PSQsf5Ho/Z
         O7EReZl9KTFr0arSaBv4gFqjltM5c79NyTvkscv+QIibK7+fBBesLZg50gqmdTaKkZbB
         X3tOp65hWnlIZZFFzUzr9gNp2pNo78eLtsDGu0jZuF5UMyGcail5JKNt6DICnEJs2v5X
         RBU6N0Ek/fMR7bBfTHDgPyh7NT36JUfJBwiWKZrHew1YO3raN7sdgzFcypX+0w3xKKgL
         uoFDVacS8QoB6bwDXxXJb7a2Bg7oUSwi8YDCGIgqMJAuycifrjoh8gFNx/tCsiLEroB+
         jFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585172; x=1692189972;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y00dp6QJ4g5u69/rrwlBopOO8kAGq1s2NlH42DcsrYU=;
        b=VXiRIwAnx3EfTTL2nM60b3KOrWcL7jJudcA+JiTd4zGphBKeSB0q4nHDbLjTQ8YkRO
         zpCxCvqN7r0KPwPMhikJs4zaqf4mq/FmB0ArMPYq8DXbsxGgIH7MHrJobQuOTXexZaWK
         S0Z8bI0wcKJ4IM1Qy2i0iIEVfZfRb5nwG7B8BzazIk85Nz19mAHAp6c3/Sy2ctCeu9an
         zdE57Z+lwRCf0GRgPeRSj3lrzhxgeChXP9I9/3erNFVryNR26YcMWSWLxUJC+Oirv3a7
         8oBoGWtE/HyO+K1ijZlQ0oRv02VELDshtaunftynC1axCitqyWtkdH1S1VO7YpYt+SAX
         ibTQ==
X-Gm-Message-State: AOJu0YyDZ/gICBckMumVre5f6ivf1vabbZn7pzLftHeCUKtG+ChSQ8fb
        wQ+xoHjd211nmoUK8q/0cqfZjtCbyU3t9oxvDuQjrQ==
X-Google-Smtp-Source: AGHT+IE26PF4RAaYalJc/lS+Daq5cS08ceiFKHjV9AcinvI7SS2urCLq98jCGHwcyXi+yPSvyOCw0A==
X-Received: by 2002:a05:6870:1482:b0:1bf:174b:a17e with SMTP id k2-20020a056870148200b001bf174ba17emr3126918oab.22.1691585172635;
        Wed, 09 Aug 2023 05:46:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w9-20020a63af09000000b00564670fea62sm7920525pge.21.2023.08.09.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:46:11 -0700 (PDT)
Message-ID: <64d38a93.630a0220.29800.e8a6@mx.google.com>
Date:   Wed, 09 Aug 2023 05:46:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.189-202-g0195dc1d1da1c
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 7 warnings (v5.10.189-202-g0195dc1d1da1c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 7 warnings (v=
5.10.189-202-g0195dc1d1da1c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.189-202-g0195dc1d1da1c/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.189-202-g0195dc1d1da1c
Git Commit: 0195dc1d1da1c3ea5afb2a07e66d1446ae278243
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    rv32_defconfig (gcc-10): 4 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:=
 unexpected end of section
    2    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [=
-Wcpp]
    2    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemente=
d [-Wcpp]
    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sect=
ion mismatches

Warnings:
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]
    <stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp]
    <stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---
For more info write to <info@kernelci.org>
