Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35092771ECA
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjHGKuh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjHGKuf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 06:50:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D50E7F
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 03:50:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb7b8390e8so26495475ad.2
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691405432; x=1692010232;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aYzmuLQjMdtdEpt+nkH8jlPSHkll3p+wR0hzs7JR2Q8=;
        b=LMShC9el8DmB1yn82HbtIBKQDxF9DL+UFg0QH32unrQjczb6EM+zEEtB+/2wZnbErr
         VSMDr9oud5JjSzZ6LtECHaDxUt99pTVK4NQxldJkHeupb5WTVSgN43f9FQWcNRabj9HW
         jZ8CLQr9SFUGlxY2jJLTdUSipdlPZ9BuyavhVSZCX/0cMuyCY9LLRd7445x9QIvoNMS+
         21J7FVBD934YowFZuZ5bId6z+2yLmMTFRhgUfjHJ76OdWjAesn/xyoWEMcb3gKvpef9W
         n60FhD/9h5FHZRarTTVxIRXJ6GgTeR0vBmKZsbyRz56w3Qpu7SAhh9t3PP7E233rz76b
         cxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691405432; x=1692010232;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYzmuLQjMdtdEpt+nkH8jlPSHkll3p+wR0hzs7JR2Q8=;
        b=NzfOxsaL7OO1MV2c1jLjs+cvdKnQ0WTA3OnazAdZdzQVOW7tWefpsg1GbY29OPm3se
         0aVJhPN8YPLdllgFfkg4qFtdNSwCrZoiXaEPrhER4Hoi88MKLjle+kwsQa2VsmraOw9l
         U/DC52KjI8r8POMIgLn9DLocjFzaTUnkrEc+n2MZXVPJJF+V5pl2Hw5x/p2zbj0vDsPE
         MbNitD/Fw2ZVFHKc3YCbfwuwgYjnIEy/rSneMXIpBg+L+NLbuJ6/p5fCLWxvcUZtd9GZ
         2KC3uMv73dzRMXth64dymub6tHRn7XqW5Iuvcmjefwbtn2UQqeD4pIzlQ0jSncsp6r7f
         NO8A==
X-Gm-Message-State: AOJu0YxVFlng0j4yutJtczS2QZoPHf8BFCYReS1AQq11YmucK56kEtwQ
        cMCdLsEWuKlmBxHHJWByO/XiQGIMWNMusnoGKa7XKg==
X-Google-Smtp-Source: AGHT+IHCkek7McjM6Fdzt2HX6wgy6OZZlF/V7xPzob2f1SZqog6JJA2Hykey5dxM4AGUv2gbg3yI2Q==
X-Received: by 2002:a17:903:230b:b0:1bc:7420:ea1d with SMTP id d11-20020a170903230b00b001bc7420ea1dmr737342plh.67.1691405432531;
        Mon, 07 Aug 2023 03:50:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy9-20020a170903130900b001bb8be10a84sm6560617plb.304.2023.08.07.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:50:31 -0700 (PDT)
Message-ID: <64d0cc77.170a0220.133ce.b5fe@mx.google.com>
Date:   Mon, 07 Aug 2023 03:50:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.188-183-g686c84f2f1364
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 5 warnings (v5.10.188-183-g686c84f2f1364)
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

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 5 warnings (v=
5.10.188-183-g686c84f2f1364)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.188-183-g686c84f2f1364/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.188-183-g686c84f2f1364
Git Commit: 686c84f2f136412631eb684b064def993a96a8cc
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
