Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936507999A8
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjIIQZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbjIIOwd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 10:52:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2718E
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 07:52:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1e780aa95so21328115ad.3
        for <stable@vger.kernel.org>; Sat, 09 Sep 2023 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694271148; x=1694875948; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QnA/YgAWhYuc+vI7WNT8MFwUUKb018p5lnDJ14tEzFs=;
        b=dpNTvj9tI+98EsKfrYmcLRDxTk3P1/aVVa8S6kMhQKCEA6RQT0zHcvIA2tyH4x5pdv
         HAWPFGRX5IYNYPoYwlkbCodsB7SCzOBW5oXWcpSgUxFqgCVwlfjn4trzuHh/9LaWDB+W
         MTksUHejQ20bM4N2LGu0nZyOjLNIpDJqMBj+gIcfVDuXI1Vnw3/t57P9d7fK9aPR4cFz
         JhyyDEXctRL0RuiGD1ufGJc3YDDY3XTIC1+BzeO4V+MuDyAoQvmxOvczNQCysFUYZHbB
         d7EJT/G/qlS1sQCYoNttJnuf2EITxoHgYRnackmo38zfDhcvnJVaVnSFF9z7nsTebzUs
         L20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694271148; x=1694875948;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnA/YgAWhYuc+vI7WNT8MFwUUKb018p5lnDJ14tEzFs=;
        b=UB+sQ7lXyGwRCveSsbvWZvdNH18gpY7YxCIMRdqNpFzb5Vxl8NEALxLaZLujanNQYw
         IzsKNSrxGyoPtPa4pTMebCQkz4PszHzs8WbNIr9T7zqHNv/lbL9oVaN1Uo4QOsW409uf
         Fssdsm06NjYkksQHoBIrfG/byjeBzHyOl+126o16cl9u8GekJl0NPGe1ah7Hfj3ukwJu
         ceJGmnLgFYiqA8ZXYLWrAq4tpEdq+PYb3XJhDTQPXMaP6WE6qNamDgpLlZhQRioOysOQ
         mwiSl+rLt+/HmrmqhlgUsZaXuu8grjnIqaK5hPMrX8HrmuUqBHk9ex2Xf0uUYejLje21
         ae4A==
X-Gm-Message-State: AOJu0YxktHKFdnPGEjKbQrJVkQv7yWNjVc6vyhBj5cTKDgdwvitQIz0S
        GQIzaTpfM98WtEAWhPq84ZHZ5pX+RAvke/UQNCE=
X-Google-Smtp-Source: AGHT+IHy7p7+RImBuGWGC2AVG+W9VkDAnHSsRcpDf6+kb5y3Rp8Yf6GDOCseiRQdx8TWxv05lm+iCA==
X-Received: by 2002:a17:902:b198:b0:1bb:35b6:448f with SMTP id s24-20020a170902b19800b001bb35b6448fmr4291432plr.15.1694271147784;
        Sat, 09 Sep 2023 07:52:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b001b246dcffb7sm3352131plg.300.2023.09.09.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:52:27 -0700 (PDT)
Message-ID: <64fc86ab.170a0220.d0a46.7fc3@mx.google.com>
Date:   Sat, 09 Sep 2023 07:52:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.19.294-178-g9828e124552d
Subject: stable-rc/linux-4.19.y build: 16 builds: 2 failed, 14 passed,
 36 warnings (v4.19.294-178-g9828e124552d)
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

stable-rc/linux-4.19.y build: 16 builds: 2 failed, 14 passed, 36 warnings (=
v4.19.294-178-g9828e124552d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.294-178-g9828e124552d/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.294-178-g9828e124552d
Git Commit: 9828e124552d9b3cda4a0077c473ef200e4464ad
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL

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

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 warning

x86_64:
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 3 warnings


Warnings summary:

    13   include/linux/pci-ats.h:70:12: warning: =E2=80=98pci_prg_resp_pasi=
d_required=E2=80=99 defined but not used [-Wunused-function]
    7    fs/quota/dquot.c:2608:1: warning: label =E2=80=98out=E2=80=99 defi=
ned but not used [-Wunused-label]
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    5    ld: warning: creating DT_TEXTREL in a PIE
    3    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    2    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

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
