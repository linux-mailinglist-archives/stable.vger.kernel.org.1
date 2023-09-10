Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BC799DE7
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjIJLts (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIJLtr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 07:49:47 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D341CD9
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 04:49:42 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a9b41ffe11so2677400b6e.2
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694346581; x=1694951381; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jKHoJq8d14zRo3wQI7St7XcsjvnH5P25ItS18i7C0OU=;
        b=2YVjnyu73ZYFFxGzpE4do3K2W8UU9pTcI12aHf0QOUsujEExSInZPZt4JqGFon6XmJ
         ATiuTIZFkJmEyoW9UFk8gek/f00tFxHbaKZzYoW8Bm92VgXDn4BQMNUbh/6vuMP1COW/
         SUnI0dP/5sG2JdBHDvMG4jo8IeQfQqA6njFKrINjUw/3sOFh7NDQI0msoLuLkCdwhPvJ
         Qyj6vePo6tMI3MgIYDbmgY/2J/84XGSecjwGHOsDmpoIi9GoiSR50nE0QYYS3S33NoiR
         rTlAv1k28PZ0fG0Mk/YG2eEaRYE5dxEVPaqmsPShRM/zCROg3lZwp5/GELkqTC48GXvS
         3rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694346581; x=1694951381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKHoJq8d14zRo3wQI7St7XcsjvnH5P25ItS18i7C0OU=;
        b=OQDIO2bBkfYGbRCO64zgpd968M8e8ZoWaK1+DM/cL9YAwPQE65bl0oWDGDL4hJYWOO
         9mjtch4UM8j8UNoLtmRynJWoBoVcljsgTrcQAiyyMDBa4vAv0u9JcyxZmu+kq0mJbcva
         BM8suu1Xk7EgsfhuRn14f6+cI+EZSjvgqdWnsKXX63dkQvhflqGkLlfP57eO4hAT0O4n
         cLVbmrd11UD7ljsCiCSs/C0Gq5YsOvnsGH5p2LgdM+zS8r2JC9Hs7wjyO6zeqcdVhyl2
         G5OGptuc9GmjamUY66DvuxWf2moIJYhlxEq9GtiTrjpuqEqcvsUfSbaAvFTV220hA5NI
         FU4Q==
X-Gm-Message-State: AOJu0YwInnphWte5wHFLKiuDnFbVNlYnxd8ucHvY1qG5yxHXE8FW7bOM
        v+be0PoD3+ufbqzpXQtM7RYJ+jPO/JGTmi5lu/E=
X-Google-Smtp-Source: AGHT+IFbbvoBireeFkTG1ivUjWB0GRg2KAEu9ocQmeavrlSviWf1haaV4xVHsaxTu9qTRr++h8JCzw==
X-Received: by 2002:a05:6808:2110:b0:3a8:6a03:c0c with SMTP id r16-20020a056808211000b003a86a030c0cmr9696640oiw.27.1694346581534;
        Sun, 10 Sep 2023 04:49:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z3-20020a637e03000000b0057754ae4eb7sm1429496pgc.39.2023.09.10.04.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 04:49:40 -0700 (PDT)
Message-ID: <64fdad54.630a0220.195c6.25f6@mx.google.com>
Date:   Sun, 10 Sep 2023 04:49:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.294-192-g5f24cff2de7e
Subject: stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed,
 40 warnings (v4.19.294-192-g5f24cff2de7e)
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

stable-rc/linux-4.19.y build: 19 builds: 3 failed, 16 passed, 40 warnings (=
v4.19.294-192-g5f24cff2de7e)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.294-192-g5f24cff2de7e/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.294-192-g5f24cff2de7e
Git Commit: 5f24cff2de7e70e91fa4c52215ec5325326d393d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 7 warnings
    defconfig+arm64-chromebook (gcc-10): 7 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 2 warnings
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 2 warnings

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 2 warnings

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 3 warnings


Warnings summary:

    13   include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasi=
d_required=E2=80=99 defined but not used [-Wunused-function]
    7    ld: warning: creating DT_TEXTREL in a PIE
    7    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defi=
ned but not used [-Wunused-label]
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

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
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 7 warnings, 0 section m=
ismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 7 warn=
ings, 0 section mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 secti=
on mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasid_req=
uired=E2=80=99 defined but not used [-Wunused-function]

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
3 warnings, 0 section mismatches

Warnings:
    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used [-Wunused-label]
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
