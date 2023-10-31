Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BD67DD121
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbjJaQDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbjJaQDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 12:03:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545298
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 09:03:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc131e52f1so37708515ad.0
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698768198; x=1699372998; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSk3GobaC6hk/F+hfHAeH8BsG7bOCpdY6rreqmR8q0g=;
        b=fQoAmIXJDCB3PF4w/jihDpdQJsHeYhX98ZohTi6hbuIqs9hYMshXjs+80eDBFiof5b
         sYTTRtWPaJpIncIOjfUkEb1V3tSdaMWC3z5MWHa6YhGyp3UYKKqK298Xn1XVuvA4qc08
         +HLrCVQF86nR1iY5LRdKDdsIGcNqFkfz4IelqDGh3DxRjHKcfboFBsjt1SZRHi7zFK8Z
         LgKqZpOcxD0GTmnsbUAOUd5yqDj7dlEPXfytJlZt0WKFR7L6OhoHnzdSGf124HHjWPQw
         kl2qout6U5WN6TJwFoSl7g7XjekTEzPJnspvasuZJCUmKECSQCbQ6O8T9XbVAeM6s+fB
         mgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698768198; x=1699372998;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSk3GobaC6hk/F+hfHAeH8BsG7bOCpdY6rreqmR8q0g=;
        b=h415bZb8VQvtMh8gCEMcgOxJDd9loJIABOueKCkg2eALuQei432fTJF6ForkbNa0vI
         /h0ZWC9A4CWlE27mS+/SPPXnrDXySxxguidRquSXYI7MOJBkTi3aUlsNV18+V1ImXWUL
         xDZwjd8WyzL8Zp04Hod50zCatjpmx7bacQO/S66rEiz6aM2xszQKFVdNDbdi6sGdgKhM
         qmAYP3fgkXZy+z2aDnEsYz3uEn6Tg7qSWMBVIRHrlv/kLHSHIprs8q63X3C7132SU0d8
         yFNGuWgRhULOHSiXABXXOVWtWPtv/bJ7ufJHPtbHHafErPWuvzzDucoUu9njwp9a8bYu
         Da6A==
X-Gm-Message-State: AOJu0YzLdMVq6zedp6FTD0gA/h51wFb7eg5+VITyQ0VqVnyvSEMSV6SD
        ESQlcfNM0UhhgxGVJ/RE5OVNKvlhpLFBVcCGkoBibw==
X-Google-Smtp-Source: AGHT+IGMHeG+i4InVHwDvHcZBjTl9d9LAAlGiS8E9nV5KOXgzFgQNhqi7Suc2OP72pXlBnjhCyY52w==
X-Received: by 2002:a17:902:f816:b0:1c0:afda:7707 with SMTP id ix22-20020a170902f81600b001c0afda7707mr2815834plb.34.1698768198182;
        Tue, 31 Oct 2023 09:03:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b001cc47c1c29csm1514681plb.84.2023.10.31.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:03:17 -0700 (PDT)
Message-ID: <65412545.170a0220.6b44a.3d6c@mx.google.com>
Date:   Tue, 31 Oct 2023 09:03:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.137-91-gf26ee6f20b58
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y build: 20 builds: 4 failed, 16 passed, 8 errors,
 3 warnings (v5.15.137-91-gf26ee6f20b58)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y build: 20 builds: 4 failed, 16 passed, 8 errors, 3 w=
arnings (v5.15.137-91-gf26ee6f20b58)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.137-91-gf26ee6f20b58/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.137-91-gf26ee6f20b58
Git Commit: f26ee6f20b58702283b5edd6c207f6538ddc79e1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm:
    omap2plus_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:
    omap2plus_defconfig (gcc-10): 2 errors

i386:
    i386_defconfig (gcc-10): 2 errors

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 errors, 1 warning
    x86_64_defconfig+x86-board (gcc-10): 2 errors, 1 warning

Errors summary:

    2    trace_kprobe.c:(.text+0x3228): undefined reference to `kallsyms_on=
_each_symbol'
    2    trace_kprobe.c:(.text+0x29f5): undefined reference to `kallsyms_on=
_each_symbol'
    2    /tmp/kci/linux/build/../kernel/trace/trace_kprobe.c:736: undefined=
 reference to `kallsyms_on_each_symbol'
    1    trace_kprobe.c:(.text+0x2d9b): undefined reference to `kallsyms_on=
_each_symbol'
    1    trace_kprobe.c:(.text+0x25d6): undefined reference to `kallsyms_on=
_each_symbol'

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
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 secti=
on mismatches

Errors:
    trace_kprobe.c:(.text+0x25d6): undefined reference to `kallsyms_on_each=
_symbol'
    trace_kprobe.c:(.text+0x2d9b): undefined reference to `kallsyms_on_each=
_symbol'

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 0 warnings, 0 s=
ection mismatches

Errors:
    /tmp/kci/linux/build/../kernel/trace/trace_kprobe.c:736: undefined refe=
rence to `kallsyms_on_each_symbol'
    /tmp/kci/linux/build/../kernel/trace/trace_kprobe.c:736: undefined refe=
rence to `kallsyms_on_each_symbol'

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 se=
ction mismatches

Errors:
    trace_kprobe.c:(.text+0x29f5): undefined reference to `kallsyms_on_each=
_symbol'
    trace_kprobe.c:(.text+0x3228): undefined reference to `kallsyms_on_each=
_symbol'

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 2 errors, 1 war=
ning, 0 section mismatches

Errors:
    trace_kprobe.c:(.text+0x29f5): undefined reference to `kallsyms_on_each=
_symbol'
    trace_kprobe.c:(.text+0x3228): undefined reference to `kallsyms_on_each=
_symbol'

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
