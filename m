Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9F7C9AB6
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOSTo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSTn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:19:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4518AAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:19:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae35773a04so2472834b6e.0
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697393980; x=1697998780; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a6mA2F8mED9/ON7OwUZheCdmHZleiGWu5tUnFCrNYxw=;
        b=vVKat9FrseM8yWoAsrT79b6j4TI1Cms/L+zVevb8hpVoLptrSIuaSdyZw3+TdLGFK2
         wGEluht7rEMasfaol8Gvt8ZmwdFW6uzuGEYuEaHsU3/4wpZr6njytf3isngK4rdr0BHa
         LTsR682+NoyNx4iKFmSgwtZ8Oo61WYpJ8JZHdWKHNfO0dtKWfsaEC84hAB/qXusta3j9
         +ZwIMz7yjow07riFVEnr89Dx6wkidZqGx7N1GyuAPQilsKAkA7Rp4uE0dx/zt57va8DE
         Pq7leKBAv9zwJc7Dfl5WQg27aVEW7+n1AT+X5AhqlFUDS+jv84kvwEmlkJ0pOANRN0H5
         NIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697393980; x=1697998780;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6mA2F8mED9/ON7OwUZheCdmHZleiGWu5tUnFCrNYxw=;
        b=kc1eQG0rBzNjxc4asKFkiMHF/rIhpR3D+sfOTXjVcSr0EmCxktLJCfLfU2xNqFJU03
         DUEnH2HUPqvQfwj4YcT9pXF88jU5s8p5yFhyHT+YqKS9rNbUoDaNuYtWUlyk7A/gLLRP
         9CXd/rnTZYBmqcabybSC1HZoIHaGAgxhfBbBFbs01jwkKfgq7wTC9zneR7ychto/lzeq
         j2SwVa4sNgPka2XPp+XI3bQdKYm7BgDOgz3/16fN7mmyXJJW06+fUC5rhBo9qv7mzmh/
         D7zpiJq+pSF75kXfVr91zd1E1xPpp3P31+XYxdn5ica/jPoVhL45UuU5NlygbMRX9d7k
         i9Gw==
X-Gm-Message-State: AOJu0YwxylwGI2kKIskf5EUNiBZPfROoSdZxoW8jNCqdCoxdR2i1Bvsz
        nyPih/fT8ms/zu10+JDCeZeDynvOioSoCAjwDHR6Fw==
X-Google-Smtp-Source: AGHT+IHuku4l4tDedvatljERlVnCU425XcXHE1Kl4tBBbvAJBtk4Anvr1UmMAvLeCzdqQXvQW7wC3w==
X-Received: by 2002:aca:2409:0:b0:3a7:215c:e34 with SMTP id n9-20020aca2409000000b003a7215c0e34mr33245455oic.15.1697393980182;
        Sun, 15 Oct 2023 11:19:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pv16-20020a17090b3c9000b00263154aab24sm3334489pjb.57.2023.10.15.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 11:19:39 -0700 (PDT)
Message-ID: <652c2d3b.170a0220.53882.9efc@mx.google.com>
Date:   Sun, 15 Oct 2023 11:19:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y build: 19 builds: 0 failed, 19 passed,
 1 warning (v6.1.58)
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

stable/linux-6.1.y build: 19 builds: 0 failed, 19 passed, 1 warning (v6.1.5=
8)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.58/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.58
Git Commit: adc4d740ad9ec780657327c69ab966fa4fdf0e8e
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
