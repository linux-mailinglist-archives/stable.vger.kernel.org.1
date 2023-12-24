Return-Path: <stable+bounces-8415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D781DB57
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C74DB211DC
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FF6AA7;
	Sun, 24 Dec 2023 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uHn4cwMt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8CD266
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7812ca492c9so207975085a.0
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703435099; x=1704039899; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K9eAqKTsDXAcCCMzu+wPMgqbLw59QH1+uc+h5UKplVE=;
        b=uHn4cwMtZ0pc5p+cWTZZ6XEto2NPCKmemxH8wIcSzJZ1TUTdtkPh8yLjB/rwo2ft+w
         p3F6GWbaAgCMUnL169oyoebhchUN9AL5rFP1n9avHDUX7y4rco8fVHN6dE7FQyXLRQoZ
         ntNVBqyaVNUd1jDJBOStNVIDm4Ji1ztF/ytvoCP6VC5136HxseOcmVCNjpMUpdoAC3PV
         um1GQ0aIwT8I5XV8fdGr2zKbb8h+MLswFwyYHV98s1e5+YXiJgMaTFDt0G4JC2E30afb
         sIMgvU2R6sz81y95sR1wL6YzjZs/VCPTdvV7NBKQT/usx3yatI8itgV5SBYB2zu9G2wu
         XZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703435099; x=1704039899;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9eAqKTsDXAcCCMzu+wPMgqbLw59QH1+uc+h5UKplVE=;
        b=CnlD35jbAyCUPxU9m2oGQ9cE3QvL8XH3EFBpnShPp9UhN6bFEYGEIxXPbuEOvAxmdF
         dHOJfcpZM6h2aLPXEqrX7JSFbJxU4cVbxzWt9zn4HPmDC4JpYrinUO7jzrcQiUyNiOxW
         tG/Dhip65J/m75eDp7Xrg04MTKeQprWVv9rOEXTK6tSEmuAS8FbIpBTxMsxr9FteCEKW
         +KICtO3xSp3pHnWQJaIbdU32UdPMTgmcLMOM29F0/JJMsVOPgvYQu9kHB1IhvxSsT215
         2C9G2+hzDmGjIhljg6WEsYEIYYvUr9TLjtGpBNpQg5kMyfLZceKqCep6/3oBWORPJqCm
         knWw==
X-Gm-Message-State: AOJu0Yw3X2TyXHDa5A4T0G7U+cgZihaZK4/yWLEQA+gVAlK9kkcFXWHq
	I2pbqce/Kcu/8oGSLl9X7a1KWroxI/qWGKXjf4uJcqBuY4c=
X-Google-Smtp-Source: AGHT+IELiR48xtjVLU1LEk3+i0Gptq0SieEViVIqAkPw30LvJ8X/8j9G3eOU/soTSRob66JMQiH/8w==
X-Received: by 2002:a05:620a:55ba:b0:77f:2496:4988 with SMTP id vr26-20020a05620a55ba00b0077f24964988mr6015441qkn.14.1703435098915;
        Sun, 24 Dec 2023 08:24:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gb10-20020a17090b060a00b0028bc8112629sm7041074pjb.13.2023.12.24.08.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 08:24:58 -0800 (PST)
Message-ID: <65885b5a.170a0220.c63e2.2eed@mx.google.com>
Date: Sun, 24 Dec 2023 08:24:58 -0800 (PST)
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
X-Kernelci-Kernel: v4.14.333-34-ga8bed8aaea9fa
Subject: stable-rc/queue/4.14 build: 16 builds: 1 failed, 15 passed, 1 error,
 27 warnings (v4.14.333-34-ga8bed8aaea9fa)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 1 failed, 15 passed, 1 error, 27 war=
nings (v4.14.333-34-ga8bed8aaea9fa)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.333-34-ga8bed8aaea9fa/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.333-34-ga8bed8aaea9fa
Git Commit: a8bed8aaea9fad141414077aa572a3f391328915
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

