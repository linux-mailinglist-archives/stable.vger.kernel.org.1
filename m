Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0877AEED
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 01:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjHMX1B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 19:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjHMX0r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 19:26:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA010C0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 16:26:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26b399c6a4aso474553a91.3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691969204; x=1692574004;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MsAjIWviH7ECW4r38R1i6XKQoGcvXYhpCC6XgT3FwsI=;
        b=dfQEhJUOXCp3AqfTFFRLagExh+bY+EHV0KXQQOjiAkJDjuyAAD/OADNk19rCYx3dsm
         hCtQzx7i03VB2axzfotTMZp6BbU6Dn9xOfUwJqiJTCjnY0YYAIMr+ip3cGhImsTxp58s
         +B4TtFaCRTO4M3MF+N3W4mUf3OOg8FVfjQk7AamfQGWs7EuAluinKheHmQvI8wWlhKGc
         rNV4uCLr2ARKJPEhUYT3/TXAbk+rGYMITRmS0kjHWjeD7kiOB9M/KlDvX5tc+EqgkDbe
         49QBJ2iKtKsegEuQvlSnRvzbizTejelwhOG3pJHCc9N6szgDz6LeKC0sb+FC2/QGIkDv
         0yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691969204; x=1692574004;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsAjIWviH7ECW4r38R1i6XKQoGcvXYhpCC6XgT3FwsI=;
        b=IlrXkkXfOnLRb9+skf1RoVUz/TxZtDyg0EIR0BbbvOCqQGb2ZvO8mPkTDvg0KH+R8K
         HhJN0OnrYL+6ZMsLHBMtPw+2AzhSbzIsTsIY/dhjMMR8khAtslsqff4UwsvtTreBDVgw
         QRiApdbmHeR/aq7XtA+LB3SDKcuOgxvWsUfmMiIztzJ8KLWZ64OyD6ckHiuRrxCGiU1L
         y0usS31CUeOrJArMiTSVggSO682f+yWMiPlyJWhwzNjOq2Se29UYbCJ1xE76tn3OgHXe
         /sE7Lfr+opj1br5V1Gb7bIt5xMki96hJnKehyQ2dGKwZjGtJk+wGJ+jDHksxKKImJMu3
         oXLw==
X-Gm-Message-State: AOJu0Yy0YmNqUUXz1vfwuFolnfGGKG9QGACPlW5cLuZtsQZJc7TtJK4l
        6nCiWOLupk4E6xZAeQT/pLwuwuMHeUbQ7+TNMfahzRTE
X-Google-Smtp-Source: AGHT+IEj0LQwANcQpp9Cyf17HfyUPci1YC+Dabf46POHAlUx4l1u7DVpRnEJKoyUzCxtIYSqBG6URA==
X-Received: by 2002:a17:90a:fd89:b0:267:7743:9857 with SMTP id cx9-20020a17090afd8900b0026777439857mr4896483pjb.17.1691969204496;
        Sun, 13 Aug 2023 16:26:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b002682523653asm6753350pjv.49.2023.08.13.16.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 16:26:43 -0700 (PDT)
Message-ID: <64d966b3.170a0220.58b9e.b0c3@mx.google.com>
Date:   Sun, 13 Aug 2023 16:26:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.190-69-g5b1776cc14bf8
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 7 warnings (v5.10.190-69-g5b1776cc14bf8)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 7 warnings (v=
5.10.190-69-g5b1776cc14bf8)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.190-69-g5b1776cc14bf8/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.190-69-g5b1776cc14bf8
Git Commit: 5b1776cc14bf85186ed45a8d68d33206f73c727e
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
