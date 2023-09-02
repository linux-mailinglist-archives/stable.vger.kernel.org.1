Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA879066C
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 10:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351889AbjIBIrK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbjIBIrJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 04:47:09 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9110FD
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 01:47:06 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bd0a0a6766so2255454a34.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693644425; x=1694249225; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8LqnRgYllm+EN9yBq0j0DtdKeY4tEPSvgG9f1tTsvQM=;
        b=nUFbuvWKubGII1lqxoxQI4+apunzt/zt2BbIPwf2y8z0wVEOcqqIEnqY2uVLk1sHSg
         jNsXlxeCZcghv7emcc3byrPLyqsIiUK+fI/qPv1atDc05Yt/e9SurVqDdIA0biJbxB9P
         RIqDpxa8xMamDULkg6ChXB1wHbLeOtS3JKe9Pr2A2rKCAUeIcGC60e5/1tXwUHbHOFdi
         SLSN/bpkH557VwBJZ6W203qOKIKoBNjJbW7Yvi/8J+Fokify1a++KPc7VKwsO2MJGcu7
         8WAOyqcVy636aYEfl2xtQiY3Zu6suDIju0fdJCTtNcsbAZrlVuhWnxJV6OCGEY5si01/
         8grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693644425; x=1694249225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LqnRgYllm+EN9yBq0j0DtdKeY4tEPSvgG9f1tTsvQM=;
        b=Bk5e0LdEiptOGEvbY8ul7g0HD5WyHvKaU2BBfrw3+wzDXLAEcRR5QNNpaM82hAFRLT
         TRfsw/bHVRViCyI3NYZTwC13L0q3c47StaZuqQhl9/N/tU42uFFvELQ/PHyMEIFhvr5V
         e2RZoHIT5V4OOtFeXWiznsguFBu2yhSNYnUvOSvM1OsOm+MseNF2/VP9i2SrDTFdjW1g
         Dh8ZkV1Cb/rlqrxu7NjttSOgi8ECsPbpdHhc16Alnfjz+fKvJGRifQg/nVlo64lnu3a9
         nfkvAWzt23hc4V7eYzCZiW1+W350FXEvAcopkRpceU4XD+FUzKHrFh+XhGjjOUHfKghb
         eE0A==
X-Gm-Message-State: AOJu0YyljNJ60jga/Q8eltWH1NgHyARBBW5dwLdd06D8eXGug/6kc8zX
        z2JqDVe7RK+TjrBfnIQxoI4/LsgpMzubcMGg1mY=
X-Google-Smtp-Source: AGHT+IHnVzCzBm3OrP1NIuyryrMwQKevkEe+XT0G56N8UWDabaplsVRGDvAz38qLjnbVQRx/mIW57w==
X-Received: by 2002:a05:6830:4799:b0:6b9:72be:671f with SMTP id df25-20020a056830479900b006b972be671fmr4549449otb.16.1693644424937;
        Sat, 02 Sep 2023 01:47:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm4110740pfi.38.2023.09.02.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 01:47:04 -0700 (PDT)
Message-ID: <64f2f688.620a0220.414c.902f@mx.google.com>
Date:   Sat, 02 Sep 2023 01:47:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.194
Subject: stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.194)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v5.1=
0.194)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.10.y/k=
ernel/v5.10.194/

Tree: stable
Branch: linux-5.10.y
Git Describe: v5.10.194
Git Commit: 006d5847646be8d430ae201c445afa93f08c8e52
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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


Warnings summary:

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
