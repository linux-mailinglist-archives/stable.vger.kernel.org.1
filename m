Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F657A3A75
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjIQUER (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbjIQUDu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:03:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7EDEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:03:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5780040cb81so2844283a12.1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694981014; x=1695585814; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6BMJScNl6ceJjULWY/0XYuIgAz/GmSiuiN1pnVT1QUM=;
        b=B/BPiPo+0UBU/72BNq8A/V226Z/fG//Lh3ioFL80iDlPo6qE7vzevSezu7d02eC6PA
         vQclZOTERdqLfD2jZk6wagvPkq/w5lD5tNoZmnPU7AZM0bMRJoc2YH/w3cBDE10P+6sj
         Ey3P4w5yjKT+zWFp8a/1uy4ziXRgtOmD2iwkb6UD3nrF+snknd9ZOD7xxwqvI34seV16
         JX0F540FRHVXjPtIJ1eCWq4874CDrT3J7mxs06cV75qKYwOIfmooZoqEmpKU61Mrwt3Z
         a8zc/u+z2VhEtos264dz/w98FnCADu2zr6MXTl+TypCa9AnCpZrjRxFxXNrWTdCJ3FRL
         EHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694981014; x=1695585814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BMJScNl6ceJjULWY/0XYuIgAz/GmSiuiN1pnVT1QUM=;
        b=U2dGO6QFN6NOsUaswE2cwytFI7MjdqABk3zzNel1cil7hxkvdFJi3PYxi22Q+Aeliv
         EtHsR4o/+ga2GxM7DjIoc997gqpWw4UeyVw3DVLQt9GZVh2o3FKj9VQT39CmvjQe9JTK
         s4Q8PH5SYgW2rMkEB/aAF+EEeEVlW7Uv8/aDf+56lRZZGQE8PExVRyH2Yh+WSRsKIlaM
         oPsdHgLQ7DLASwjkzUbNPkw8lgrIjw9bCWEhCmhtiwNPfPaHm6A6xOgvDqD8XWhd/8f+
         I9iVc5T3hJaLF+nyNVF5ysVqdf7M/AZb9Hta4eQ/EpJ1xdtCk/3QXMNMP8nHHK4zbvbZ
         J6fA==
X-Gm-Message-State: AOJu0YwiSm7KtIyvshjVK8dJiHKeL5qLxHb+dNcVZzOnjFsoebFEavIJ
        LRZ6kYcxylwbZNeLfgegachgI02wP7XARyKZ52nhl7aN
X-Google-Smtp-Source: AGHT+IG5wIeGkyizoHOSOLmIlzSaljZ6k8jAytaj8jtHgM8DHWPhZLR6BdRfF67orQAjoFuneZcVxA==
X-Received: by 2002:a17:90b:1e11:b0:274:638d:da9a with SMTP id pg17-20020a17090b1e1100b00274638dda9amr6362491pjb.34.1694981014293;
        Sun, 17 Sep 2023 13:03:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001bda30ecaa6sm6974368plg.51.2023.09.17.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 13:03:33 -0700 (PDT)
Message-ID: <65075b95.170a0220.1958c.8ce7@mx.google.com>
Date:   Sun, 17 Sep 2023 13:03:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.194-407-g794568ce435b
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 6 warnings (v5.10.194-407-g794568ce435b)
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

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 6 warnings (v=
5.10.194-407-g794568ce435b)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.194-407-g794568ce435b/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.194-407-g794568ce435b
Git Commit: 794568ce435b62c8e7f1f22e34fce4e6476de509
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig+arm64-chromebook (gcc-10): 1 warning

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
    1    drivers/gpu/drm/mediatek/mtk_drm_gem.c:255:10: warning: returning =
=E2=80=98int=E2=80=99 from a function with return type =E2=80=98void *=E2=
=80=99 makes pointer from integer without a cast [-Wint-conversion]
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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    drivers/gpu/drm/mediatek/mtk_drm_gem.c:255:10: warning: returning =E2=
=80=98int=E2=80=99 from a function with return type =E2=80=98void *=E2=80=
=99 makes pointer from integer without a cast [-Wint-conversion]

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
