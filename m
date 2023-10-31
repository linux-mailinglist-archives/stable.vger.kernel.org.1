Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0086C7DD62D
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 19:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjJaSjJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJaSjI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 14:39:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FF98E
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 11:39:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b9377e71acso4085773a12.0
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698777545; x=1699382345; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1wezioDUTcrP74Y6M1RQaC6Yrv0AdUjH/k+y1U/09Z8=;
        b=fbd5HUG4WqKtsHcNMCQZlkQnYWtp0IQ38AwEyGIxHWfQwXAPECuYNZtu+fDt572hDF
         ay0VCloM8fMwkSdYXOKlA5BRMkwygERHHHr9ZgPYHtBEuRUORzmxAuHIraEuAwsTXI7h
         sHuQOYwsF/my/K64klzmiidSjCXBv3+W2sa27cWeayWDI4RvyszLmho5+vaOJFqq6VEU
         C05IBCXVbdpkmg2bUhF1u47Tsr7XYAq49mUUfXhe2k0IPNqyWuD2UCqDdMoyLW95avlP
         FnqDKsWE3aNzE7a7b5vD+y5KArpNxEJZVti8JDeqQdfVecnbA3phj3m/3jAEC/I9JdU7
         q3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698777545; x=1699382345;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wezioDUTcrP74Y6M1RQaC6Yrv0AdUjH/k+y1U/09Z8=;
        b=NTtELCAgejttJoI367ZND95Du0C/AXzdydgAG+rYuu04W7iT/4fxyrhy40mr+hx+aS
         PGVx6oBjMsrJWJy0zkFUOzxtdcZSLe0mKM/s13UcQeeU/eSdX6iOQQuEaTXV2lJCOYgF
         PjaJkzBYWdp+xsdHTt4AYnXEOec+VR9mo2YdUiP9eZYvX1b/AKFlo4eTNARQCYAoBTvB
         tRUsq+CHEKpg99t0Uyv0fBSruU9kc2JxA9tfVq86GpmgmqEhE98Gmrzhmin9/OS9PJeo
         J4W/HOBaz7IwfXElpCT5fvjZV7VcaZTwqMg73QMyS8t9UwX2oZ6vfWvxZRHYBtXQD6sX
         Ikmg==
X-Gm-Message-State: AOJu0Yw/UmdHLHmCcwBUqbZMiPTNsz92B6lbFdjcWLjUuINGjja0zg7P
        oN6lBFh7XsC8FINgaW2GgHtfLcwFCEImImd0IOyGHg==
X-Google-Smtp-Source: AGHT+IF5Libyjy0EUs+BSIx4//uREuksRI7QFhkSbqZmoChb/uFnczcQGnJm5DxnsUmSEZw9ucxZcg==
X-Received: by 2002:a17:90b:f83:b0:27d:2108:af18 with SMTP id ft3-20020a17090b0f8300b0027d2108af18mr12752459pjb.25.1698777544913;
        Tue, 31 Oct 2023 11:39:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001cc50146b43sm1628035pld.202.2023.10.31.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:39:04 -0700 (PDT)
Message-ID: <654149c8.170a0220.d6ce5.42fa@mx.google.com>
Date:   Tue, 31 Oct 2023 11:39:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.60-87-gd87fdfa71a8c
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.60-87-gd87fdfa71a8c)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.60-87-gd87fdfa71a8c)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.60-87-gd87fdfa71a8c/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.60-87-gd87fdfa71a8c
Git Commit: d87fdfa71a8c82a481a41421b387544c7012b21e
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
