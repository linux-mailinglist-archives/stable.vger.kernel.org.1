Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC378ECA1
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244003AbjHaL4w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjHaL4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:56:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3336C5
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:56:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso5328775ad.1
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693483008; x=1694087808; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fgK90A5bVlf3Jb9PlLUBf/SNOLWTKrT4fJpWT5NCqpI=;
        b=ZDWxiMzQ9U/G5LdW7vgKRXl4P5rpJq+8MZN6jAphbINLih5SJps1ri+9KXS2HkF9/D
         xIr9fRrXQW9YdyZoEwcNXG044jejFj/ylxlxhSjoeCB3VRa2bDiRWR/VkKWiIvDgqaCw
         iMPlAnRDILnH0ATUzfGoBGQORXtlOweEKPgdxbJOm3Sj4EMBfo+b3s8RSPZKqvLLKJ7/
         BB/4NHawR6gzw5sjB1q+EiyglgamY6j5+tli1CA+EDhHPumkcXCXArojnS+SqJcZgk1h
         HsSABMcojd77mCZHX2dF1mJA6bZW9BDHRBJNjXUkOvQAZD8ZxXx23X11TlmODqolTU2K
         BAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693483008; x=1694087808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgK90A5bVlf3Jb9PlLUBf/SNOLWTKrT4fJpWT5NCqpI=;
        b=SVjFyTT4GY/27QIe5HNMcQqH+SMfxnyLKKrdy/qepXwjnQV06cWBo8hLCvR6rZXgLi
         tuVkC0IMOOS8BxHGdK1ixQQnny47PmfjSb1DPGMotK6zecFswr7XT48T98niCcztzPPO
         V7LaK86/9te361QwT+6OccdosCMCB9C/Crk/Kio8sV42vrk//3ZjsVODKEg2itCdRL0T
         sISXY9BGyi3kKdSn/hC3pUDgWariPnoj3H00uI2NXV/LEd+Kg3dn3hnx3l+CntagaoAc
         cHtwwukC4Bq0A4p+4vkFCFbKS9qpSHm6c1/0TYSZo/SzEBh1a+jTCwyoSH6O8Zf88Kn2
         j9nQ==
X-Gm-Message-State: AOJu0YzdcVemIPpwtxagPZWH43c6IfNmYdvDOryOEcfBSTqRPDJkdkS2
        b+KQ2yn8LoD96fv1juWpvG6rMLXzmsfr/yVH3PE=
X-Google-Smtp-Source: AGHT+IFlQSMdVCGZks5yFoaev5n2e3+bYN44SSXYiPcX4YJxVhpd6TbNGyYyfDifp9gBl+q2K9mbiA==
X-Received: by 2002:a17:902:d4c9:b0:1c0:d777:3224 with SMTP id o9-20020a170902d4c900b001c0d7773224mr5154755plg.50.1693483007682;
        Thu, 31 Aug 2023 04:56:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001b2069072ccsm1130899plc.18.2023.08.31.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:56:46 -0700 (PDT)
Message-ID: <64f07ffe.170a0220.65cda.1cab@mx.google.com>
Date:   Thu, 31 Aug 2023 04:56:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.50
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.50)
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
1.50)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.50/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.50
Git Commit: a2943d2d9a00ae7c5c1fde2b2e7e9cdb47e7db05
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
