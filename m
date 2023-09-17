Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5C7A350E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjIQKB7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIQKBt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 06:01:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF059191
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 03:01:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-57759a5bc17so2692208a12.1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694944903; x=1695549703; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FmgZAhmQtA/3Yz3mf0avPPsJVhthi4d//KWQYdi+PNA=;
        b=Z+czM3aJUHBiGD8NbS9WRY7MMLdlqEPCYxuGLi3yp8heTKtgkFc/mBNnTPtFf3ocGW
         trodSaorICNZ8cBA6c33AiKaXZq393e6pq2frgJN/y1XGnc1GohnbJ+my2T6Qoofek6L
         e8U7stAFnlqOxl8SA2oGUYdplJAl8yQYc2AylIMqlkaqqa5ko9GfTUPacnx89M3W5lKv
         gPkcO/RlSZZmX0+TAmzW8lA6GyRj5H3khbeox1buLjrnu9+T/G2pksXKO6JKPfiu0QdQ
         AX1y2sx6FBzy2MNr4BiICC4pvvm+eheKc2Ifp7mH5EkomWAqEXkkn4Qv4fXasXSiZYdE
         Q/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694944903; x=1695549703;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmgZAhmQtA/3Yz3mf0avPPsJVhthi4d//KWQYdi+PNA=;
        b=ORSPHpJqmJqpv+dHYmkssxW/iLtSXrAK7wA73U7SeYuJAU+M1swU1qi+iLkVqWNNB4
         SwSb8j2CJOyv3obcn1jnj/s+NljMlIqpNCKkcHi+/j0v3SCvLnGMm1u+D54jXWvE2BUC
         FoSloui6vnBwCnWYQ1k3q3yYiibCNH8gCTNssp1LNjc+r6QtWdsWGvQaf3s0HP/jv6tN
         +kVYfRvQ0Phkqg05qXsz1yAr410cgZKhgzlIbi5NIO/6Ikc+gbxx7RsDMlaMtbCuaFsJ
         qo8iXk051lLLkk55guwlks7pyxMYC8ainrCqChS6eW8fPODuH782hcn0ult4rIN4oZuz
         HkDw==
X-Gm-Message-State: AOJu0YwQM++3rk9wDHJffQ+K/5LRWbLrv6R4X84uWrw1ePO1JUqjkyDH
        QJiXpzV/UsdUywbd6Im50LRfxd//39oqic8YKDFQkA==
X-Google-Smtp-Source: AGHT+IH3f8Wgp66H9saSSAK6BatvuTLzXd+GG5iL7efWWCk5Zhxnv5Rurb0xpwqMVMeKCqsBEPFAYw==
X-Received: by 2002:a05:6a00:2283:b0:68f:ece2:ac2a with SMTP id f3-20020a056a00228300b0068fece2ac2amr6256853pfe.27.1694944902974;
        Sun, 17 Sep 2023 03:01:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i23-20020aa79097000000b0068fd653321esm5452199pfa.58.2023.09.17.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 03:01:42 -0700 (PDT)
Message-ID: <6506ce86.a70a0220.99030.3add@mx.google.com>
Date:   Sun, 17 Sep 2023 03:01:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.194-406-g8281c551d5a7
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed,
 6 warnings (v5.10.194-406-g8281c551d5a7)
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

stable-rc/linux-5.10.y build: 18 builds: 0 failed, 18 passed, 6 warnings (v=
5.10.194-406-g8281c551d5a7)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.194-406-g8281c551d5a7/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.194-406-g8281c551d5a7
Git Commit: 8281c551d5a75f700029af48ca75d1a340fd47c0
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
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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
