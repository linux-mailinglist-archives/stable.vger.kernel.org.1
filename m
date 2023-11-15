Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A97ED565
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjKOVFc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjKOVFN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:05:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CB819AA
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:04:39 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c320a821c4so64425b3a.2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700082278; x=1700687078; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rPUVaCnh3bNX12akaGzttzRNBIV6zTkyo0X6g0QvCwQ=;
        b=rCiUIiadAIb1DUGgbnmCKt+wWpiCxg16jvPwGUM+wEy/7MMTiDJWYm49ByfFpuYNyp
         TSzL1iRxkNDgUYzM2OalQ/jpcFBaFp1OG9pQFIMfVksw3+CfVXZTMkwYLid5d+kx31jV
         O4ZCJomUQ8ROB24vW0VIQGZGLmXn8weeWWNNyS1geW8PHnakaD97SXUxYiyaDL5YJx3c
         jHGNihxx+DYi7A98heLyEB8K78dzLU+LCHmhvJIU4Ldf2vH45HnfYg9e3LdeqQLh1huL
         +yOQP8T9f+cxuunky7Y3AYE3slvIhaLyaZxDYvBPhWnW7cUfkyPCiteapMD7NgYQIXr1
         iHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082278; x=1700687078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPUVaCnh3bNX12akaGzttzRNBIV6zTkyo0X6g0QvCwQ=;
        b=j0lZH1zPh5/sYWGUSIkOgFspRzTm7YBEphhh6D/5IDUPEFswou7oVAxx1WOjud3SQD
         Wqzua/nnKmXN7kZ/jYM/xPhZgE8lMt8eFGfPgxIaCz7tMt+ygTCPbbKa0eewbxujx061
         Ygbw5KTM2kcxBvswdxkPBWwR/Zze3qtBju8i6J3LO3eXZOrB+AUzLyUJ0DzVJSGJxBY2
         wS3H80c9kAMxJgXS/29rgqUEnYShShXrOt2lwTVDdi98aZRHo8G5pFljrE8ToeNEQ9Yv
         tUlXgKZ6Le9oT5oAJ5TKB8aviaYXX4L3ln04s9DDjewOhARPvCPPGgkwK0F29OWGwygb
         lqeA==
X-Gm-Message-State: AOJu0YxIMCA3hJeT6CGwEAEr9Bg775e2Erh/EJ/VcUKPU4ssy3/WkUEd
        NiAkckk4hAJUz6Pv6WidYYDq6aB/BA/D4VPml0KNww==
X-Google-Smtp-Source: AGHT+IH42dvGKVPMBWdE0FfriGu8BixOwiv44fF+soQmfl9z3DedxtBmbAULOfPWFsszNuqxKNExQw==
X-Received: by 2002:a05:6a20:4420:b0:13a:e955:d958 with SMTP id ce32-20020a056a20442000b0013ae955d958mr12533279pzb.7.1700082278333;
        Wed, 15 Nov 2023 13:04:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h21-20020a056a00219500b006c046a60580sm3171294pfi.21.2023.11.15.13.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:04:37 -0800 (PST)
Message-ID: <65553265.050a0220.3b3a.adb6@mx.google.com>
Date:   Wed, 15 Nov 2023 13:04:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.62-380-g505b91175bcf
Subject: stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed,
 1 warning (v6.1.62-380-g505b91175bcf)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 20 builds: 2 failed, 18 passed, 1 warning (v6.=
1.62-380-g505b91175bcf)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.62-380-g505b91175bcf/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.62-380-g505b91175bcf
Git Commit: 505b91175bcfcf16c4adc437901109bee0ab649f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
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
nommu_k210_sdcard_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
