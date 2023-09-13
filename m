Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403F79E34C
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjIMJPP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbjIMJPC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 05:15:02 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8011BF1
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 02:13:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bf0decd032so4844929a34.0
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694596403; x=1695201203; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WCWp3REV4pL0CbpDVNsB7hOiUM+fiCHWOWlcl07QSJM=;
        b=icor21ABSZ7JY8cN0te/UKwVVbS9LIQcYBMmugPWhUV/JmyUiqscIG4wYh/l1gLUYu
         K9RMx/q8J5rXZ2i93sj8BkYFdFNOXaAzlqRCEWJIvbvA1JJgzrLgeKMCJvty6kgwN0W1
         Em7qKNl2SMXLhpoaXQjCjbtgNxpwVMSyo7JZ46bPLvelN16WGGNpXQfic3OoW8CIh8CA
         w8V211Cj6mwbuLaGEIm1q4dsnxI5+VrbHus4pE9xxM9pzUHXC91D3jRxZsFErOtfv2Bl
         O8KQDIvYgX/VahriU9lGdVUh3mLonEydqdIxW58dub7IV/9Twncu16dvz8Thcds/SbOl
         +xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596403; x=1695201203;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCWp3REV4pL0CbpDVNsB7hOiUM+fiCHWOWlcl07QSJM=;
        b=tY/5LHeeCdYPphfOPUXKaZuKEoXgt0iNnNI0xQDyeQc1LyTYXE9heX8A1fbMHlOz7V
         YRnVPNj1hfEviZ8M+I9fhGY4zGB5gLbbMlAxaV/OI8wGTCcb/M5tMVGpWz8oLtkBW8mI
         gDQUVGDmAQJWSVZNVmRrN1o9XcTLoRX6Xqzjc7jrbzWnRIvQEDaioqDGhXqUVlZXtFv4
         eApyyTLHarXcHhOwOYJXmkE6TL/K3Z/wh35fr/7Cq6byhmhMWfjcERQ5QgsWb9bYPfna
         QZW5l7OpmwyGs0eIqrifg+D/7E0KNVCytfw/SU+dgluoiN8TGs9ygykduiEGo5V+sEs4
         dpxQ==
X-Gm-Message-State: AOJu0YxzqTIupo9SHC3JDTGWsxGQUJsjtxjBGAARlhpo5vOn0FnlZJac
        2c56joT8mGjPXapVG4JirSCI81UlHaXPlOgXM8M=
X-Google-Smtp-Source: AGHT+IENl8xi42tFGDqjah5qDqrn4ziWeIAoaWrwD3voFSwyhHuukweNLaSkIpGR/bT2JpxFMlpKFg==
X-Received: by 2002:a9d:7ad4:0:b0:6b9:67e4:eba7 with SMTP id m20-20020a9d7ad4000000b006b967e4eba7mr2252228otn.23.1694596403116;
        Wed, 13 Sep 2023 02:13:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78e58000000b0066a4e561beesm763110pfr.173.2023.09.13.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:13:22 -0700 (PDT)
Message-ID: <65017d32.a70a0220.5b041.10be@mx.google.com>
Date:   Wed, 13 Sep 2023 02:13:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.53
X-Kernelci-Report-Type: build
Subject: stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.53)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.1.5=
3)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-6.1.y/ke=
rnel/v6.1.53/

Tree: stable
Branch: linux-6.1.y
Git Describe: v6.1.53
Git Commit: 09045dae0d902f9f78901a26c7ff1714976a38f9
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
