Return-Path: <stable+bounces-8397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36481D534
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680431C20F9D
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB84FC0D;
	Sat, 23 Dec 2023 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JBuhyhOM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C4FC1D
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5945ba54d54so315222eaf.3
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 09:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703351266; x=1703956066; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M1VdN2klhY6clnHaLUHiJ3EW6N8te2XyfUfT8b5ELkU=;
        b=JBuhyhOM+kPXQyNFEn1/YCRWtP0AlvOtEdcta20cndiP0U/epdl1A2U0x+L/4rWVqv
         EfYPp1Nfk21c9zeLyIpdUqRpSecc67QOp4g0ERDNiefyBcUGyyakOdQuVxSdtUjZxNcZ
         fYZnYs2wf4bpAyl5V1m0HHRHOIN9r0ojxrZZrh5WuGlJZYOtEg6JngxQkp5aXJC3HO/D
         KMM2tXgh304Eu5X/hQ/rvoqZyFx87PWI18fipIrAD/VYsuXUf+akITS7srq4ggtqf3SI
         THX6HmGg7kJh2Rrm1QSf4iKkABp3FCMSxoPZOi3IaPUD8TEG6STMz0W7X5Wvpj4J2F8J
         5z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351266; x=1703956066;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1VdN2klhY6clnHaLUHiJ3EW6N8te2XyfUfT8b5ELkU=;
        b=QvUcVjHR/S8fpcECWOWqdpcjX4UGDtykfj7NY9wrEeCF/qxiCQvJWTkGd9grUdYngU
         bMB7qH7S1yg7Na4A+snGRLGb6Gpqe2JAz0W5wA7X0Cw65HTrozBzpL41iBDkVqU1MJAq
         8DzMIYcP/ykRLPal7BjZOld0Whk5XHhIF874m6vL+dbQMt3rJ2sywEn0ReK/5nu1pFXx
         TjFsVCxSwIkRWCsXhQkpdztlr71w5glvglVlavEYGj7phZsk+Tph1uwc0/J/Hlo56TW3
         DZeV8cUE+P8pJrLX06cJqBTJhGsEasA1cwX1Ub+pVBGbk3BVHadUzhzOc+Ufpu8LT6iC
         Ro9A==
X-Gm-Message-State: AOJu0Yzu5cA1mR+3JyZNUVEvsWI9HLVMho+QCtZUeWfJ7iK80ylvdluT
	ZJqT2A1AVlvlOm/votPNuNjc4T4yu+h+vlR6wSjCPMiju0U=
X-Google-Smtp-Source: AGHT+IHEwQH6WgaIQoy/UmmuxoT3JDiLwYPCVcynPyfzqfO0uzsG9Xa5TaPxz1d92CwvG6NvA0xnDw==
X-Received: by 2002:a05:6358:9104:b0:174:cf11:6b99 with SMTP id q4-20020a056358910400b00174cf116b99mr2211975rwq.38.1703351266187;
        Sat, 23 Dec 2023 09:07:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a0002c500b006d9a16ca748sm1349235pft.122.2023.12.23.09.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:07:45 -0800 (PST)
Message-ID: <658713e1.050a0220.3e6d1.2426@mx.google.com>
Date: Sat, 23 Dec 2023 09:07:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.14.333-34-g725244c4b87d
Subject: stable-rc/queue/4.14 build: 16 builds: 1 failed, 15 passed, 1 error,
 27 warnings (v4.14.333-34-g725244c4b87d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 1 failed, 15 passed, 1 error, 27 war=
nings (v4.14.333-34-g725244c4b87d)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.333-34-g725244c4b87d/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.333-34-g725244c4b87d
Git Commit: 725244c4b87d9cd828afef1ff331620d2d876062
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Build Failure Detected:

arm:
    multi_v7_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

arm:
    multi_v7_defconfig (gcc-10): 1 error

i386:
    allnoconfig (gcc-10): 3 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings

mips:

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-board (gcc-10): 3 warnings

Errors summary:

    1    drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many argume=
nts to function =E2=80=98irq_set_lockdep_class=E2=80=99

Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h=
' differs from latest kernel version at 'arch/x86/include/asm/insn.h'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    3    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    2    net/8021q/vlan_core.c:366:47: warning: passing argument 2 of =E2=
=80=98vlan_hw_filter_capable=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]
    2    net/8021q/vlan_core.c:344:47: warning: passing argument 2 of =E2=
=80=98vlan_hw_filter_capable=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]
    2    net/8021q/vlan_core.c:332:47: warning: passing argument 2 of =E2=
=80=98vlan_hw_filter_capable=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]

Section mismatches summary:

    3    WARNING: modpost: Found 1 section mismatch(es).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section =
mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sectio=
n mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    net/8021q/vlan_core.c:332:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:344:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:366:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    net/8021q/vlan_core.c:332:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:344:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]
    net/8021q/vlan_core.c:366:47: warning: passing argument 2 of =E2=80=98v=
lan_hw_filter_capable=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 secti=
on mismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many arguments t=
o function =E2=80=98irq_set_lockdep_class=E2=80=99

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section=
 mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

