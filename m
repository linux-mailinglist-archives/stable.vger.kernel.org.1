Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B463E7A9A6C
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjIUSj3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjIUSjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 14:39:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABBD3164
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:23:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3adc9770737so804253b6e.3
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695320623; x=1695925423; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JeYAG3NpSNCqOHHLMHQRrJX8n58xFE1gUxos3D/7mcc=;
        b=Pk+w4V2CQzLuSc2GRE2FN7Wp88pSCsodsOWJiIXh6LakqQHppiisnJfEsUsu7mbEOR
         CApdEkmcsSOnjA6H7WfO01YRRpK64cjOPygLFJVcmtSgHm6BiJ7NIoKBt8OwGyH+5vYx
         6D/zD0M0RBVxaWQBk/pfNIZLY8k6yGls0+1yZ0pBfH573CRPaJJZeT8/cf7wO28P75qI
         FBesfhrwZz2dvFOYMDfQdztw+WjUvc6uMQolmyGR1wcQcDdCOta/vSLpBctjGBxMdZPn
         0tdlSySrp2WMQOo+7PcWTXNAp9FqxiZwxfBPQcMd4joIxZ4rac90adU6O63hJ5qArSo5
         2sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320623; x=1695925423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeYAG3NpSNCqOHHLMHQRrJX8n58xFE1gUxos3D/7mcc=;
        b=WkcHSFuYTSLGBNjAzfpvgjGKY8pDSHyQeV5nNT+HhS4yaMMggKtXoEEEAVnX2fr7FC
         WLgdB57ZXmO2Z+f8cMwL2/yUu8szqD6ttkIMzUPryPjFD704Mu0Mpfi+/6P7t6BeGg09
         TRvWtGjL8TV72PllFUaezE1qF//yYrV8XRsTulFlJxjBx59MTOjML/747PFgLY6+QtJ4
         4FubYKPk3Ot4cQN8k7NduHrh5rk2cKDDe02/n7KRSNIrucW8yWVIgiQ4EJlqZf83zfRK
         2kWlTx0kyjM3uiKUcTjgBfOGuwAU0Zi+YQYuyu8SfBfnE7ROgLOGCmbl1taz7w0mqUQs
         HArQ==
X-Gm-Message-State: AOJu0YzFaxC+rpjVhL+GIzEyqjArzgXxmwg3yF0YjjQYPzyqWyiwpcGt
        cGq35X2J+mWmo5sTBbMWMf5o5qq3aoRgA3y/pTOw7w==
X-Google-Smtp-Source: AGHT+IE2Xs8iGIa9B3OweCKABz/FciMiExEUIAcDVjqQJKlLHibbZ8kDKBidzXbGFUOp51D7tjWr+g==
X-Received: by 2002:a05:6a20:72a6:b0:14d:9bd1:6361 with SMTP id o38-20020a056a2072a600b0014d9bd16361mr4502319pzk.11.1695286867197;
        Thu, 21 Sep 2023 02:01:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001b87d3e845bsm916826plb.149.2023.09.21.02.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:01:06 -0700 (PDT)
Message-ID: <650c0652.170a0220.2e6d7.2535@mx.google.com>
Date:   Thu, 21 Sep 2023 02:01:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.196
X-Kernelci-Report-Type: build
Subject: stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed,
 6 warnings (v5.10.196)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.10.y build: 19 builds: 0 failed, 19 passed, 6 warnings (v5.1=
0.196)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.10.y/k=
ernel/v5.10.196/

Tree: stable
Branch: linux-5.10.y
Git Describe: v5.10.196
Git Commit: ff0bfa8f23eb4c5a65ee6b0d0b7dc2e3439f1063
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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
