Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045227AC138
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjIWL2C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 07:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIWL2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 07:28:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB111D
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 04:27:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso2988228b3a.2
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695468475; x=1696073275; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DlGhXu+zLBwYS9+DKabhA6y5MqSnCCHnJvpLmTZJ8YQ=;
        b=QO1cm1xP9itXv6nnyDHk0KYskR7n1OCeZ2WzqjniTuf3R3R6wjasCaKKryS1YDbmt+
         6HW6JU2RbftgZ+rQh1yxRO2ZOAIsVhr9H4U5S3TunopvJ/Qnx9LsTNAG2FvgRh7DaYn4
         ZDi8H+d0dQHTCBOknnUQRDnPY69qaIdJiY4OgZ9zAQZK60Nt6A9u9JCqwo1sMmRuF0se
         Z58LXnZ5dnOCVLkgDGm+GKt0RB2wvrdj4ytPFZqnk0FB+Lb6EI8PwKx0yFNefIu829Ac
         y2bx4gkN/6wiKVo3YTl6hhXYQLjFoxh0f8lNjxEvVIrFy+Xl34FDfh/lLvLTNdgdVmHj
         rYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695468475; x=1696073275;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlGhXu+zLBwYS9+DKabhA6y5MqSnCCHnJvpLmTZJ8YQ=;
        b=Wvm3+ckkvDVp7ShWmuewCCtuFSeI4XQGkVubt8166z06kp0CE8qSOhFK82RptXpDg8
         lfLIfqe8+gxZX6nt73G5xjjXFhZ9syCbG1gkMR+fuerpAhxt1o8JFJyv3hLOnRx/lejT
         DdF6RqPGeGLUu8C7Gu7cMap2npBLSS0BwHoIrtrVwrdy8unlv3BaQ6upFtuJVZyv5DmA
         SlhKtXgx5Jr61bvmYQ1vsSl2zrgGsrp9kUL0LQG7SciBKv/oO8+NND81UgdP/hhyO8SB
         P0kAUI68loEqUzeOiMbyfK+Dtkl3fw8AT5WE0mqpwmJJ/ZgGKDDRrfhRzWHhEbcy9MZH
         pKCA==
X-Gm-Message-State: AOJu0YzedQRIjx2i0fr4LhAmaET5gu7JmllDPgA1jgoQtpoVLCREBEEj
        ji7h8vf4s08P1pJIYDoHJmwSu+riblGjkRPalm9lPw==
X-Google-Smtp-Source: AGHT+IGf7fJo1NEyf7OrAEYQkXuv7Wc9j3ScI7N9ZJM5sQC7U3lmTYDx3p6+DJHnHBAfUSuSrIw+6A==
X-Received: by 2002:a05:6a00:139b:b0:68c:3f2:5ff7 with SMTP id t27-20020a056a00139b00b0068c03f25ff7mr2677879pfg.1.1695468474509;
        Sat, 23 Sep 2023 04:27:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k7-20020aa790c7000000b006875df4773fsm4677367pfk.163.2023.09.23.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 04:27:53 -0700 (PDT)
Message-ID: <650ecbb9.a70a0220.fb847.7190@mx.google.com>
Date:   Sat, 23 Sep 2023 04:27:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.197
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 6 warnings (v5.10.197)
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

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 6 warnings (v=
5.10.197)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.197/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.197
Git Commit: 393e225fe8ff80ecc47065235027ce1a7fcbb8e5
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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
