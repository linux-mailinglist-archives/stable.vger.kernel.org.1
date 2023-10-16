Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3547CA4D8
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJPKK2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJPKK1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 06:10:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3AB4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 03:10:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d329a704bso1567436a91.0
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697451023; x=1698055823; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OV0/vp2JLloE16OGp3S3+1gYp9ziEvAvECew4ib32Ws=;
        b=jXQF+oMgmdIoUsgBm3hziQU3HHOOTSJY6HwjInUrXyqVx3zyin60+Buzj89FL3l+jA
         CYwID/93gjuUlq+wlI9xRkHAZi6SB/hDxR9r2I2B0yVJjPu2ukMeke/6bmYkKTQyP0D7
         de8RfZmEC6ynQz/n/i25Se0g82gUHvtsaf5/ncO1QBhfWsBEwWDFNDwnko9EjMKI4UvK
         N46RJ+qrZENt2/ZrPQfMGJf0F8jwtjLW3nWuRCO0mvzCK5hxqRmHw8YbSOMCq2CkZI4J
         MiwEJfC/2s9HghHuMpAHaseP14wtpSAvRo6KOymjwxkVVC5RNuO6SsSbErP1aj+VhPlI
         RNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451023; x=1698055823;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV0/vp2JLloE16OGp3S3+1gYp9ziEvAvECew4ib32Ws=;
        b=ftramGW48nKuOE7zsXatOpuTnFUPXXXGbuuKQwfnLmo3/sTmmUo9sfvgiCdoGeJKo4
         UdSsS8QFnWtMcEMPhcXQSDzfvuybJFxu6nXRywOiHyShfha0ZMLSMDGJTPT0fI1VkaGa
         HN3v1LNQP9nGokmZA6a7ob64qjT6hAjkW9JwRcVuXH1O7G2DcFw2tOE79TJZ3qWbDV1r
         aqhkiOJ+0U7KrZPFkHzH7tHP7FVLoiAleYl2JHeNnyMHPTV5nimxIr7Suo/ZtMo6ejFL
         cy8W3SHNXArNb9J5iFUqTdzmCuk9BMX1R6JoyOr5LwLD2wTloDtT5b8JehwQ1A/gDpWW
         Tj4A==
X-Gm-Message-State: AOJu0YxDh2KRsWg1Rcw4FXes8u7AH6NchX0+ajebo6pxOAJ8WhbEIXCo
        m7SS+jR4m9a+SKTTZMEhlHJu9KC8eKK/w/IU2iPL4Q==
X-Google-Smtp-Source: AGHT+IE/tggILTZQwbnMFEHOx0F4zDXCX/A+5BsWoQx7/sd25JOupkmrvIh6vFRVEke+X4BWujTqSw==
X-Received: by 2002:a17:90b:14a:b0:27d:e73:3077 with SMTP id em10-20020a17090b014a00b0027d0e733077mr10868732pjb.1.1697451023195;
        Mon, 16 Oct 2023 03:10:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090adb8c00b0027d219d3ac6sm4362813pjv.47.2023.10.16.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:10:22 -0700 (PDT)
Message-ID: <652d0c0e.170a0220.cc9bb.c8ac@mx.google.com>
Date:   Mon, 16 Oct 2023 03:10:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-132-g9b707223d2e98
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.58-132-g9b707223d2e98)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.58-132-g9b707223d2e98)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.58-132-g9b707223d2e98/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.58-132-g9b707223d2e98
Git Commit: 9b707223d2e986b8728181d9fb2547d1bbf8c23a
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
