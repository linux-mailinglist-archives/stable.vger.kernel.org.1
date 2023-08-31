Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D878EC01
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjHaLax (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjHaLax (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:30:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE8CF3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:30:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a56401b9aso531721b3a.1
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693481449; x=1694086249; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hyOrAsFe0yXN8tNhl5csUn9w/6Qp8ZZlHZeCgnrlDow=;
        b=QMMDKPnyu6YPm4yyDGOrJAPxvpM7A2dTLb3DMSrk4CALJrci79AWsxeeDr01ZH5415
         oPQHKMwBPkyuFAKPmLGXkzjpUriX8q+X9HoGejfJNg37wAInXuVe10speWwb27W0LKqX
         gblKC24twqFTN/GSD1NAY6mCeQ9PpoGnfw4OqgmibsvX7+m3I0DZ8xKTQnvAc7qsof3t
         9BdDxpckgTPb8KyTng6GnFTmFzORx8ixFF48n4ueYRG/n+s0Wc254gFeiKCDqTVcCSI/
         xJGITacgfQe2O+QAZcqMIoi7K+GRtj+D8X6DDIcVzfoKqML4pJycv9UJuJjGp+0uP9S4
         S2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481449; x=1694086249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyOrAsFe0yXN8tNhl5csUn9w/6Qp8ZZlHZeCgnrlDow=;
        b=dlco4fcWodNwNd6PlkTOD4pozP0mGpiB7tncKDfFCXkkvDqjrXMIDQ4QMdTcrj96GO
         o/24x7XjblQwOGUUux0TlURRUkGxfZk31lyl4f1KTE7mAb4iFzGP5xzMUGJXLnmkWdui
         D87ibyS9si0LRlb20jEBnWiqHnYiBfC1p11Ydc3dRnamH13QxsDm3OsKlJhlN9Q1rTgo
         SukPln+zEGxawKmdO7OKpHXsANJlpTakBkAZq5dN7uU8H4c8YnD36Gncp5w/9azwhmaf
         fWoy4aURY+uhRdcPGzkQrK66Mig+bb8U3L+DR5nqpLK1OKLTNBqbcSpD8AEZPE9HQ8+E
         nkVQ==
X-Gm-Message-State: AOJu0YzmH6UPV0ZaLcrROj5uvgQwpEcmt6mQ5azWA9WWrOmlX/t84PLx
        Ih1h/xklkEWu1EZaucXpOFWm+04luAUW1geB+HM=
X-Google-Smtp-Source: AGHT+IGhK2kafz17UUfFfGqMt/3ZSehiT05PigiCu6q3TE+c632JoJiXE1W+wrYEERpC8FZaTj7Pcw==
X-Received: by 2002:a05:6a21:33a1:b0:11f:4707:7365 with SMTP id yy33-20020a056a2133a100b0011f47077365mr5574568pzb.38.1693481449294;
        Thu, 31 Aug 2023 04:30:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b0063b96574b8bsm1139987pfe.220.2023.08.31.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:30:47 -0700 (PDT)
Message-ID: <64f079e7.620a0220.4773d.1da8@mx.google.com>
Date:   Thu, 31 Aug 2023 04:30:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.193
Subject: stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed,
 5 warnings (v5.10.193)
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

stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed, 5 warnings (v=
5.10.193)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.193/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.193
Git Commit: 4566606fe3a43e819e0a5e00eb47deccdf5427eb
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
