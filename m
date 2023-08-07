Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2E771DEE
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHGKZB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjHGKY5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 06:24:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2A10F6
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 03:24:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f38692b3so4328953b3a.2
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691403890; x=1692008690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IOvS1CqbZuvyQdbr7taElqIpdQkgKLPSCxDQtF8xRlk=;
        b=q93N/Zt3m6sL8c6RPuayt475WCBRtZpy4WWczzltgbLrfnhAOlh+QB37OEn5DzHtoU
         pY8RsLUZYtxVnp80MDcl+tl4EIIfXhbrME2rf8zHsLHn5on6WZIaU+XDYB9Bo4FIxNqX
         hkLRWQxi6vHlnfvqN8/GyLNikksBLwb7YgekUhMzDMmya+CPZVl8u95MbJYuni4A/sIy
         Y1cmwfqvqENGSAOWRkGVGNVLFlwGldoomK/ZZGJ/svSw29xHxnna6w3axYjHwUFkB++l
         S1hL+eN7MVVMC3Yur1DZzf0idoL4U0N2elLaw5+Q9eghMz91Dmn+MdF8dIZWdLGwgZyY
         I7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691403890; x=1692008690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOvS1CqbZuvyQdbr7taElqIpdQkgKLPSCxDQtF8xRlk=;
        b=GvXUw6pPXUZfxdMek+VToC1khNlF5T2UsYOFSOcaaDPCs592eXzETNn7IXKRd3CXwv
         0SlyVozE6Pe1nPZyuqWxsPeFNAUeem22xdbMaPh7X3X1YHQrjF6yGXBvY8qLS90VzFKd
         z2HzDziPGC4OoDrbNiuhCsf9FyzQy4aCRcejFUELbX3NBg64IICzHBPtlSuHqO2mvATv
         TwDPVIVVbnVMaHf1UZLfREAV2S0tNw5oT/TCn/tl/UI43owrfm5PM9EBQQavmwsOforz
         zqVa5im0hiSW3e0BEwAzmqjjLSqY2fOARAiFRy73GAcK8TpOf2He77SrO46qyZYbZvkt
         xdOw==
X-Gm-Message-State: AOJu0YxIzicvpcZIOUUlP+0F/xvKyq1rJ+EOOa8jMb7Lb0ndNWtZ2lNV
        eZkEOsJYy2EIRv8p3Glw36v8IO6kI+NrHQhXYhGyxg==
X-Google-Smtp-Source: AGHT+IHFe7YMJJgPtGJSUaIA+pTBwu4VWacCSK8L0pYsv/bRcn2Qv8/qBAjyca0UJdyySwj4jJVEVA==
X-Received: by 2002:a05:6a20:3c8a:b0:130:11e4:d693 with SMTP id b10-20020a056a203c8a00b0013011e4d693mr11720582pzj.53.1691403890028;
        Mon, 07 Aug 2023 03:24:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b00681783cfc85sm6007585pfh.144.2023.08.07.03.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:24:49 -0700 (PDT)
Message-ID: <64d0c671.620a0220.aa29a.a5c2@mx.google.com>
Date:   Mon, 07 Aug 2023 03:24:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.43-111-g565bca90c30e
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed,
 1 warning (v6.1.43-111-g565bca90c30e)
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

stable-rc/linux-6.1.y build: 20 builds: 0 failed, 20 passed, 1 warning (v6.=
1.43-111-g565bca90c30e)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.43-111-g565bca90c30e/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.43-111-g565bca90c30e
Git Commit: 565bca90c30ecf86c2b3a78473840668ac6621f6
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
