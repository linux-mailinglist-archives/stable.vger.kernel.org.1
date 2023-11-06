Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9497E28DE
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 16:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjKFPjo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 10:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjKFPjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 10:39:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35186100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 07:39:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b44befac59so4287607b3a.0
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699285179; x=1699889979; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R6YvuRJhSGfR5nO0iMyFw7o13UY7dYdKjGy/duKz59k=;
        b=WtOTNW64J+t7s5KxfblYPCwJuhdgu07KqojuahhoSoxnmJBIsdU1Njeoi/a3ftzaJa
         U7GSzR/moUYMgoFnqiSwk5wDYaSkNruiCNWlUvKx2LFsY34lr5xZP2Ug0BxZKHlY+Dbw
         VgUw072PHckGeR0CZUNO6xGMmXUM2VRbxgPpOJaNNBL77/3lVbM5cn138NmYpCw/YSMp
         qaHha9NFfOUUdG2CkwzQKSkhoy8eyXJ63DlDkhnSyjVDPOo228VDOQFm+CaI9stRWces
         Wy/MJG97nmDLqDucNGIWoePvg+2KPw2PxjW8SkQCrxjeX0xpcKyJIgOcMxG/FTW/oXY8
         Yq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699285179; x=1699889979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6YvuRJhSGfR5nO0iMyFw7o13UY7dYdKjGy/duKz59k=;
        b=mQFtP0oYGQv/xIDQ+OBvemJ6/zirbcIoeMM+COCeXAY+nfIesbwfOXSIS3jcn+2f+p
         UlMJvExt5PN9vuTM4YJw8OcvOurp7d4GT8tKpzyVR2sOgVOBguRHd3ilerysW3bNeIto
         We5kQUfJhic7H3uOIbD7IVyZKhd44FLrT/GViRXbh1MYaUuYbmL+3gltQ4BtuvXjRXiA
         i3Q/Yp4qNL0LiL+w7AABNGf1trRPgyK3qYsDBTPg1y46EWoJKNU3ASVlGObfHpKLDmpG
         oeILgo1aYqwAHCO7iNi4Hyx+NDzxzAjvFpEn9lIEej4xsNwUSGmMjhR8oAXmYdUO99Q0
         lMKg==
X-Gm-Message-State: AOJu0YxtZTcdibRw5RNRNkwoVccgytiDwxilTiEM7tuKOEZmTBdW3OHq
        YlLDKc3FDdSphUQqjvGDcdviJQhsk9fY8OKEgYNr9A==
X-Google-Smtp-Source: AGHT+IHyyfoqRdefrQKasyZmZSioyr056AWNSIoddD5g6/kkjhwbXU9hMaD1Lhobp+4iV0LaEeEAyA==
X-Received: by 2002:a05:6a21:3290:b0:17b:2c56:70bc with SMTP id yt16-20020a056a21329000b0017b2c5670bcmr14537288pzb.10.1699285179186;
        Mon, 06 Nov 2023 07:39:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t62-20020a628141000000b0068fe39e6a46sm6040245pfd.112.2023.11.06.07.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:39:38 -0800 (PST)
Message-ID: <654908ba.620a0220.e821d.df04@mx.google.com>
Date:   Mon, 06 Nov 2023 07:39:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.137-129-gec134bfabca01
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed,
 3 warnings (v5.15.137-129-gec134bfabca01)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y build: 20 builds: 0 failed, 20 passed, 3 warnings (v=
5.15.137-129-gec134bfabca01)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.137-129-gec134bfabca01/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.137-129-gec134bfabca01
Git Commit: ec134bfabca018727b246a05cbd7d2da66864974
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
    x86_64_defconfig+x86-board (gcc-10): 1 warning


Warnings summary:

    2    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unr=
eachable instruction
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 1 war=
ning, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
