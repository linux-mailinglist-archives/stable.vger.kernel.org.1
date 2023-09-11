Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F479B670
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbjIKVEO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjIKImS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 04:42:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C4125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 01:42:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fc1bbc94eso666622b3a.3
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694421731; x=1695026531; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spBe6pkvW3gtGtToIN5PmnoDiM2RGuSjPToGWMDEo3U=;
        b=hdSH4DvdIK/6Twk4UC3o197aaNjrmnz54ZrqHA8Dz55PzJpIQg3GQdhrs7jn+IzxKn
         pyEuMigLwXXN6TAjtpVaYFTUegfUY3U4yfdwrnLwduFfyKh/Ir8E7wIRZXROrorBZ+37
         N1vnV5KdFgck4RgKwZw5CH6zHSuXaKQi3hMr3yF8fBtosTzgIxAwPDiFZ442J5MlWqza
         7hBkTVLH659MnvcXeKLSw7VVKF+ShJuK1un/Cjr7hQbMDt0VObgchgZQvJJDrsixaIlg
         xw9wtGVRwqJ2eGN4m+SF8TyG+S8ChntzCTgiw7kuglEHhJXLcUFGpeYSEy9eAK5YEsLW
         0nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421731; x=1695026531;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spBe6pkvW3gtGtToIN5PmnoDiM2RGuSjPToGWMDEo3U=;
        b=hi4URwtXLJeT+Zy3kIwp0OLszY+YRcfvUhr9ctZh4+FQ5CjU2r5yDPL4cS6z5UhEE/
         HjGr4NQHgrg3v/lSAtVs4pX+Y4gAl79NV7zs52VxgmWa4bGlGeDktB2rTVaHeD0vpa1F
         /ctG1GRfVmEAEbc0ICwn0DR2NLaSVGF8ce928AaqrG9PMK5CTzK+gU6NtWEaFGcpgNN0
         rMXVpc9ZDwpaqc3+sMoqZI7FIKejLI9yBAoOgzGR3Y+y9liix80uVqWg57EvH8y57U4i
         JIgPqTYJ9OvcPKiaohUOq8nggrbOb8Ud78WWk0uxXVEQJ8AaBL2BBWseQghekmaan49G
         c1xw==
X-Gm-Message-State: AOJu0YwBSLJTY5uwAk/a5fMocNyc2oTi20w3oIEF+l3asiva1X4/OJu2
        9R9Qz3UmpYxf2Rg236B4zLghhomvjXLrhPEIWwM=
X-Google-Smtp-Source: AGHT+IHWkp6FqxSxdd4kyEIsYinsJysHuzRuFg9OSrc7zNXZfNUlpmhqFdaOiHLjTNOPOksNjlpPuQ==
X-Received: by 2002:a05:6a20:324a:b0:14c:daa9:5e22 with SMTP id hm10-20020a056a20324a00b0014cdaa95e22mr9568699pzc.45.1694421731256;
        Mon, 11 Sep 2023 01:42:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a2ac800b002696aeb72e5sm7625362pjg.2.2023.09.11.01.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:42:10 -0700 (PDT)
Message-ID: <64fed2e2.170a0220.b7fea.2967@mx.google.com>
Date:   Mon, 11 Sep 2023 01:42:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.10.194-314-gda03e749b770
Subject: stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 6 warnings (v5.10.194-314-gda03e749b770)
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

stable-rc/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 6 warnings (v=
5.10.194-314-gda03e749b770)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.194-314-gda03e749b770/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.194-314-gda03e749b770
Git Commit: da03e749b77075d4c85bc92169ca9fb0713dcccf
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
