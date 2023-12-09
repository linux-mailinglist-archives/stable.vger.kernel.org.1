Return-Path: <stable+bounces-5087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992980B222
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 06:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7171C20B20
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 05:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E417CA;
	Sat,  9 Dec 2023 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hZELvbcP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5326010EF
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 21:15:48 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9d0d0e083so1996748a34.2
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 21:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702098947; x=1702703747; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i12TGs9JSW3LKqB+BoSHWno9YIhHTZZOPupZtYwOjd8=;
        b=hZELvbcP0MrCZERclLWP+7QONLMlQ+DlzGsc5Vhadw5TOplb8o1KzOOP1UQa3zuwqw
         6NGWcp8pIaa/JXbzMtEjR7JWU/yX3UFD0ADoJ2VZKD0NQ08DaRqVQtxlFAB4rkADGexk
         mNwh3lwyU3njVJ5F9iVgp8drzdI04sLf4Agt6X2sixkgXXqo0Fv5LQJm2KSVHRV5agFp
         vmRhTvAAsfPc97+wZqJZCnbpOxx4Bq/RYga1pmsc4847yJOdxvTmjK9K+gacLCyoUDDu
         100sJhUvxBlMMOJ4KFyX21QmLAao70f628OC3VDVV9i+svSQG4763vbTGDroarhL5xIm
         klSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702098947; x=1702703747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i12TGs9JSW3LKqB+BoSHWno9YIhHTZZOPupZtYwOjd8=;
        b=r84fndA+v95hLSTOSMFNOJt1LR0cfTiXl/3juDm3bX06GVoszWiIUuCTguSLZk6877
         T/3s+CiVinSqMZ2MGs95TWjargAjq3aoAjlXp3p63H2BoJboepY7j/gep/6dtqbe6taE
         3wfWwfgPK/5R1D3P+Rj5JL5Q8bHhI69aHfhAlggOKHIlsh/8xUAEi+b6Rlr/wFIMN2cy
         2m3cvys3j/1ogtcL5ybqbev93efqhoBulSh8JmpY7DyxiIboyM1HONTrP1bcYTArFnrj
         tEjhTo/amgkXBu3wwJNW49HHIA1gB2yrkRRA8IPpKbqTgOJvSyEbxoR/5FEkbQwIaWW8
         JRmQ==
X-Gm-Message-State: AOJu0YzWeAZAOBmxh0AJc0SbZ1hsEM8zvXqORbGoj0lBctDcDHvOUhZs
	JUMb7SBNChVXW0WqPzHfGutlz2MA2SVX+/YKuglXrA==
X-Google-Smtp-Source: AGHT+IGzGDAi2u/Cp6k4aHhBxiCkYQ/fODGL9XE9oVPHIt9WyZbWVYCEKuSS8/tLLgBd1CXKbYjMdA==
X-Received: by 2002:a05:6808:448a:b0:3b9:e076:9061 with SMTP id eq10-20020a056808448a00b003b9e0769061mr1503826oib.113.1702098947265;
        Fri, 08 Dec 2023 21:15:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79d09000000b006ce5066282bsm2466565pfp.34.2023.12.08.21.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 21:15:46 -0800 (PST)
Message-ID: <6573f802.a70a0220.3be3d.9264@mx.google.com>
Date: Fri, 08 Dec 2023 21:15:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.15.142-48-gdbed703bb51c2
Subject: stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed,
 6 warnings (v5.15.142-48-gdbed703bb51c2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 build: 20 builds: 0 failed, 20 passed, 6 warnings (v5.=
15.142-48-gdbed703bb51c2)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F5.1=
5/kernel/v5.15.142-48-gdbed703bb51c2/

Tree: stable-rc
Branch: queue/5.15
Git Describe: v5.15.142-48-gdbed703bb51c2
Git Commit: dbed703bb51c2f7ff36312dc544210731e815729
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:
    i386_defconfig (gcc-10): 1 warning

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 2 warnings
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

    3    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of ne=
gative value [-Wshift-negative-value]
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sectio=
n mismatches

Warnings:
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x45: unreacha=
ble instruction
    drivers/gpu/drm/i915/i915_perf.c:2817:9: warning: left shift of negativ=
e value [-Wshift-negative-value]

---
For more info write to <info@kernelci.org>

