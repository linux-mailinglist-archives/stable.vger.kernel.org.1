Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509087EC386
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 14:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjKONYv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 08:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjKONYv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 08:24:51 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF911D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:24:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso5897683b3a.3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700054686; x=1700659486; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x96AVEv6UONzBBQS5GjRuvTl7XVqZhd55B3I7Ao3M3o=;
        b=eYddM4i5tY9ejvSTkmrg60950pU+h7CQxmFYuCeRZiQjpL7Xq1gepCYC5K/UL7mKfO
         EQQixU18pSbXzmTgB+9WAhtSMUdYJHa2zt5PSKKvHHkY2TuWziDuqsQq2YN3Zhw2onXq
         unPJcycCdmOSHN0hCsg22b0j28XhVJp2Io457+baLNzNmWZAvZrVAWUewFGIBIH9oL9z
         Q18bDKH/027MUGHUYHS6nYX15anCa7Mr4YGdaYowplN1qfbrVn7mY3verU17nqK+ObTb
         +FPCdlBmtKd0HbE4B6ZS0ka0TJUomTNMGnkLg5pMxlVFMMVhsZRDlgl+rI/bPp0Tht59
         V8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054686; x=1700659486;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x96AVEv6UONzBBQS5GjRuvTl7XVqZhd55B3I7Ao3M3o=;
        b=Xg5MtBSm5xhOqktL1eslwKKgGXJVFw8YsWvL5SmFAcYyzLuO3Sh6j5kqOGwbgXogTg
         QZc5ukLl2ahZTSm5rMB86Q5rKzNdfpjPmyDCyTDiPDNLlLklbz3sMPRjKkF/X9jugcSu
         VC/SYVgXbo2Opz2Fo/TaBTXQrvTpH/bOgdGNjcsGHAW/PE2+vR+fQ0/85OX3AqLwU2Dp
         MHbQ4FH+qEg+5oX8i0wROZJtLepErNihcqQCysRH3wMLfXdHjKkuAwxKrchL08W0Jtz2
         gvWUD3NFWOfeTNBecn9hH4JpeTE4847qBTW19XtE2weFPZ2Nd8/mqCo/cyNjjZGRSK72
         HfVg==
X-Gm-Message-State: AOJu0Yxe1mNJQVyBWJ/wqxsvaJ2iHJKcXT3olKhaCmUk4zAPzSFXTtNE
        9CwarvYxMNdEQg7UBOmUPGYbmQwlkEHiQ/+Q8HgdAQ==
X-Google-Smtp-Source: AGHT+IHfkohyJwUdTAGB0n8pA5qyCsGbrg9YqVlYrIxj20gm+GYL1CRfqPLy6S0KwQeQJZaqQJGu+w==
X-Received: by 2002:a05:6a21:9995:b0:186:251f:733f with SMTP id ve21-20020a056a21999500b00186251f733fmr10368870pzb.41.1700054685747;
        Wed, 15 Nov 2023 05:24:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t8-20020a62ea08000000b006c1221bc58bsm2783077pfh.115.2023.11.15.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:24:44 -0800 (PST)
Message-ID: <6554c69c.620a0220.dc902.88b1@mx.google.com>
Date:   Wed, 15 Nov 2023 05:24:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.138-267-g01a21bc264b6
Subject: stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed,
 10 warnings (v5.15.138-267-g01a21bc264b6)
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

stable-rc/linux-5.15.y build: 20 builds: 2 failed, 18 passed, 10 warnings (=
v5.15.138-267-g01a21bc264b6)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.138-267-g01a21bc264b6/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.138-267-g01a21bc264b6
Git Commit: 01a21bc264b6e32a434dc3b9d5823d6cb5c6018d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning
    vexpress_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

    7    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=
=80=98child=E2=80=99 [-Wunused-variable]
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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    kernel/trace/trace_events.c:996:17: warning: unused variable =E2=80=98c=
hild=E2=80=99 [-Wunused-variable]
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction

---
For more info write to <info@kernelci.org>
