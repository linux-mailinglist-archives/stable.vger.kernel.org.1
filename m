Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD574FABD
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 00:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGKWLQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGKWLM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 18:11:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DCA1992
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:10:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666edfc50deso70306b3a.0
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689113450; x=1691705450;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FnzO7ArljwtqG8ieuiQfIZxapMeUEehgGU1ho5nLQvA=;
        b=0f3us2E3lohefSsPdwxEABvYRf8nH0qEzCWmQd76CGX67ue52VhgERxXMm70WXtHk/
         UFPAd0WHAI+pNKLL44cC3x0Tapc5MLZKcN2C2BfAIz5hMsBNr/BJEpd83dOmMvKff/SN
         Rgmi9tZBRzpz4xA5HkQzkIyCeTUu7v2OGmS8HiWza5Byx8T/C+a81u2fHeJZFhwhrWAC
         Yz+9PTmPQ6Hn4pdR4qeunhEnM5Ij+KM2AImb4E8ckzCscmC4tz4167UT2QJVt4fKzRHn
         QLNviHGyNyIHGI+7JRmsGg1qwQ3BCuX3as9qOGLAHEsZOGcVyyG62ZN8FCayrUKY4LkY
         8Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689113450; x=1691705450;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnzO7ArljwtqG8ieuiQfIZxapMeUEehgGU1ho5nLQvA=;
        b=E/iqwNfVDHqFgEMtfqq2hhYg3hvzp9pOIBn8hLR7ktWM/Jpt65I1PuovBVKcxwnjZW
         /PTITvRwjm365uuCFSAcmAiCpLFVIaaLkiCEKuH97fEqC78tuw60h4w26ejtgcgkuWqX
         12fAuaggwSaXkYj8/gVHlF4ATxkgWkO3i0FsF900dyyuNtH05OOUlw/IninTzStatVXc
         0WsK1imCE0Dij8wXP4TrzRHSs58RDmg1JikmzAm5fohRxQfxcWlQGNV4ADh2/yGOw2fM
         8Fh+6ULCj+wUjluwI6HMKihy1m6lNZJ23KWB3D1CzUzdnVASF4g2D9kUyKRGgeiKCeTH
         KfUw==
X-Gm-Message-State: ABy/qLZjIDGSLDHv/hsgiaOXcbqXDnUZRkn9qKW8chjsPa8sexwWq9jM
        6NHkJnmSNr101n5COM0fSxBAMxqOjjNM5rZdJrCMKw==
X-Google-Smtp-Source: APBJJlFDsxorIH8nsq3zPJoclmZ6MEy1EaV25z2c2YICGp/22wlYN3gybM1lnsPElf8Qz867qr9OOQ==
X-Received: by 2002:a05:6a00:168f:b0:682:8505:1e4 with SMTP id k15-20020a056a00168f00b00682850501e4mr73518pfc.17.1689113450356;
        Tue, 11 Jul 2023 15:10:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k7-20020aa78207000000b00678cb337353sm2144180pfi.208.2023.07.11.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:10:49 -0700 (PDT)
Message-ID: <64add369.a70a0220.920b.4793@mx.google.com>
Date:   Tue, 11 Jul 2023 15:10:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.38-393-gb6386e7314b4
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y build: 18 builds: 0 failed, 18 passed,
 14 warnings (v6.1.38-393-gb6386e7314b4)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 18 builds: 0 failed, 18 passed, 14 warnings (v=
6.1.38-393-gb6386e7314b4)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.38-393-gb6386e7314b4/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.38-393-gb6386e7314b4
Git Commit: b6386e7314b41a0e90dc9c4b9f6db439c2a9a73d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:
    haps_hs_smp_defconfig (gcc-10): 1 warning

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 2 warnings

riscv:
    defconfig (gcc-10): 1 warning
    rv32_defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 1 warning


Warnings summary:

    13   include/linux/blktrace_api.h:88:33: warning: statement with no eff=
ect [-Wunused-value]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sec=
tion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section m=
ismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
nommu_k210_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, =
0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/blktrace_api.h:88:33: warning: statement with no effect [=
-Wunused-value]

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
