Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CDE77AEA3
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjHMWyX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjHMWyP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 18:54:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912E93
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 15:54:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so2479080b3a.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691967253; x=1692572053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l6h2vL/vdPEe9xn0ExiOGf1beYN5qstXkdgM1FeVnaQ=;
        b=ExhpftQnwLE155qDl56yIIARGxlube15H6ndfcljMtUKaIap+REABWuk2oLsF41wlj
         muX8rWSBmu+aRkZZu/dGS/QnYcKT3OTDDmm4I2Rle9B3bxRocKM8B9cDinVT5cQ5wpci
         AAvZiH55AB4ngpFGPWfxsGnc0sT1EdOdDExfYRhWB9c1LmwmJjJAHI+Y/hn/fXWfkchy
         4q/+Eyzr7rXj6ksv3urhawCKNfIHSwdSJCLfWA8IpZ+sjMmurnLEZEC1gtv5UDKi6QH+
         Qz+6qBMhvX3kiX3SbdAtWC80npzIZ7+cpGBijfcGI0Y2kV36KipTAfHwI0ZxGsI4QwRZ
         nYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691967253; x=1692572053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6h2vL/vdPEe9xn0ExiOGf1beYN5qstXkdgM1FeVnaQ=;
        b=Krm1kYetOspixSWM1Cg/1KBI5UE5KhykKYOJW7cZnU8DzPBrHqTLD6SZ2J1OMHCqz9
         AzildyjbxOoiFbqy/63hfLN4TjMLcXF3gHMlFOV9Sq3APJUAaW5EnElvSQ70Kh52xRlB
         2WZFJK1t0BAWx5EiswNe2Fg1gxYjh8hJA7n7ifCew+UPG83kS01ovzVMdT3mSo3zHFI0
         W/SUgTcjBh1FJM3+AlhWZD3RdD5VFm9U//JamcnFssav0Swh0Qy6GGY9x5c/OAzhmsXe
         sIy8NR73lexyN80XAvimxbBpaMOLB3H8eePPU/c6YnnlXCLjCNeR0/4R+mETkl6puxws
         4ITg==
X-Gm-Message-State: AOJu0Yxa7MZh5kpkkJh32dI8BvbP5iZeZT6iu7qGyo8tutIM47CqKWYv
        WU5Y+BHDY6WyxN247NaCgOtYMGSaZCDeS3uacOU/bi2+
X-Google-Smtp-Source: AGHT+IFB9x41IWMN2ZCXZDdfeOywTnS1EtwPJ5/yJX7xSuBTqCMQTDnK+44e7Jl3OSNG8P7I1QXx0g==
X-Received: by 2002:a05:6a00:23c6:b0:686:5f73:4eac with SMTP id g6-20020a056a0023c600b006865f734eacmr16195793pfc.13.1691967253130;
        Sun, 13 Aug 2023 15:54:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p26-20020a63b81a000000b0055387ffef10sm6976517pge.24.2023.08.13.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 15:54:12 -0700 (PDT)
Message-ID: <64d95f14.630a0220.8c376.afd6@mx.google.com>
Date:   Sun, 13 Aug 2023 15:54:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.45-150-gdbb92b2240ba
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v6.1.45-150-gdbb92b2240ba)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v6=
.1.45-150-gdbb92b2240ba)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.45-150-gdbb92b2240ba/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.45-150-gdbb92b2240ba
Git Commit: dbb92b2240baeb83c338da3c22ea784f13375059
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
    x86_64_defconfig (gcc-10): 1 warning
    x86_64_defconfig+x86-chromebook (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:=
 unexpected end of section
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
1 warning, 0 section mismatches

Warnings:
    arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement: unex=
pected end of section

---
For more info write to <info@kernelci.org>
