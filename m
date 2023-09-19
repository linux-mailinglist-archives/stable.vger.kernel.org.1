Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8406F7A6628
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjISOHR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjISOHQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 10:07:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143D383
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 07:07:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-578d0d94986so74954a12.2
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695132429; x=1695737229; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B/j4HO+wtGdGPHjN1lCnK0sUDEGnWcZ8Q3k7Ph7R8a8=;
        b=iA57B26FYNpeMLJ21KySEMYt09sYghTzo39+culE95qzpDhdzWJ33fPm11KR0AYnze
         awwqpcsx7bsS7m3+G9xsLmxgRzquHop4N0M3q4eEfeA91RUlksBSdkr1aiIA/TpFZ8qP
         nC9qiB50kiNyPWGfBDmo3fVkvnuxb2RL//7YpR9WxPa2/6YqD0XnGPf7igD9czLCtjNJ
         9BNVwja49B8w2BX/g9V8VPHsydF53f/ltjuuhQsqa06oOWfpMtgB4azj5XZSX8qY9eT2
         /ir3+4Tj2XeZtuVR8wCWKilBQzE+D/kriMBU0GkVI1WIiqKHkc0SUgxya2AoPO7uNU5T
         C/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132429; x=1695737229;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/j4HO+wtGdGPHjN1lCnK0sUDEGnWcZ8Q3k7Ph7R8a8=;
        b=QC95a6KVXMFaKSOQ+oNulAAMxB8BHraofRlaykGiAvKTNYyuXM2Tqby13S9uli0JAw
         OzQtH37hqrMofZcyftnWuJLxFBl5HxMzA5/gh36EBFvZ9Pwl9pOD5AIkcnKoCeHRxMWA
         m0xO777HqP61o2uP98o7RBikwnvzdAVJLwtE6eEqTK5d79LQyxvO9mhUHYiLSv7g2Cxj
         bBtp0XxAwCRFv4O26HTjVWXVDPGRZwLazAuAunyZyOGXj8aOMEy2ti3bRVFfvlUYHBEf
         OzreCK80ifKXYP37XDwGbraDE896REXlEqAR6sh2PKXEO+0VLGOPcH7IyGZj2oX8hgn9
         jO+w==
X-Gm-Message-State: AOJu0YwIYYYMpWRU+r/TpfEyXgPc/nYIoVAQf/WAy+zJp7hjBqWONNL0
        xld4m3kfu7/29Hy/gy6zuCy+69aDV0m/j7vk/V43ZA==
X-Google-Smtp-Source: AGHT+IGVFDYgcISDeOpe8D48AaZvuYJh+LyK7V95dElHXQjS+RHll1vbwb1mBhxuqmUsELipTPVtCQ==
X-Received: by 2002:a17:90b:1952:b0:268:14a0:f8a with SMTP id nk18-20020a17090b195200b0026814a00f8amr11317770pjb.39.1695132429090;
        Tue, 19 Sep 2023 07:07:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090b078400b0026b70d2a8a2sm8656781pjz.29.2023.09.19.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:07:08 -0700 (PDT)
Message-ID: <6509ab0c.170a0220.b9fff.d619@mx.google.com>
Date:   Tue, 19 Sep 2023 07:07:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.54
X-Kernelci-Report-Type: build
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.54)
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

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.5=
4)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.54/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.54
Git Commit: a356197db198ad9825ce225f19f2c7448ef9eea0
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
0 warnings, 0 section mismatches

---
For more info write to <info@kernelci.org>
