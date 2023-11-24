Return-Path: <stable+bounces-97-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28237F6C5A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 07:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119391C209FC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595EB15B7;
	Fri, 24 Nov 2023 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PGTh3ovl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92850D53
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 22:37:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so1142399b3a.1
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 22:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700807846; x=1701412646; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mDjJx1bu4tN6hmZhOLzruvyDje3uWTJojJ1l137TxPc=;
        b=PGTh3ovldcZTyAMzbeAkU8ZIl1zX3W1OA5XJ43A+Frw/FlnNTHIuCmFRKsUnLcJT1n
         oXkP1mtaXQOdABa0r1OQgtyq5AbsLhoWz03OoOKwtoTKBjZu+tdSpf8kZPtDqr6OVkPN
         Yeq+17puDCIf6LxXuvDoXdXVVBIogwu/ajf0a521WGw/09NvKLenLhUMyqxg96Jidvu7
         HT0R4Jqoc1draUuWoAzfz3IMETDxIiIkH+T0Qn1LkfK2KfvzCgdDwK14qYk7sZI8NWjW
         0QdnxiHd5qZZmApUs/E8TApTDzNdjyCFkoNeut2CvlDbpdJ9y34KmAG3YBx93LKB9WzR
         pZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700807846; x=1701412646;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDjJx1bu4tN6hmZhOLzruvyDje3uWTJojJ1l137TxPc=;
        b=WWyoBruC5wKMMQ07ELFjbZlgOwcTAaNFdvy+30yryg6yR88otLioX6+8EwxDkkLVoB
         0SXFQGBms0qC8WgUmL3XLSK1fYnCqXBlNGZ1m1mI816NqB+D3EsNBjIsMZFGOE+Anz4o
         5SnFLi91kyXOCgenEDuQRob01M8HDPRex6kH7ufXGnbRpaQra4j332I3eH0beRZmOYSA
         BJ/RdjFDfkxTje3F/oq5XmIUuRoFhmE/63hPUN12+0rgcJLd3C2mmPTfx6v7la5m3Vjj
         79Fu/gvmwJaRuhBDNHdsztPrgdmUWeOJr2dZM94/BY3Gzc69SaRm2eaHbTwhqkWKJIjl
         omTw==
X-Gm-Message-State: AOJu0YzkgAAYUJjZxCJ5TcMsNmJTZzoxiRWNDIkPV/lkuFhDwYstZlUF
	PyUdgO6CYlStJEgAxQG0rmuCqlvIdKhRo/atITw=
X-Google-Smtp-Source: AGHT+IHLVQyIqz9jmH88ufTcFJeSMZDGIlFqq4fFkCsAciGhapSb+KTA6WysOf6JuRtSdota3huHwg==
X-Received: by 2002:a05:6a00:2296:b0:6cb:735c:67af with SMTP id f22-20020a056a00229600b006cb735c67afmr2226072pfe.0.1700807846604;
        Thu, 23 Nov 2023 22:37:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n10-20020a63e04a000000b0059b2316be86sm2381364pgj.46.2023.11.23.22.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 22:37:26 -0800 (PST)
Message-ID: <656044a6.630a0220.f6fe.6154@mx.google.com>
Date: Thu, 23 Nov 2023 22:37:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/4.14
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.330-43-g0cf35e1ba8035
Subject: stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed,
 21 warnings (v4.14.330-43-g0cf35e1ba8035)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.14 build: 16 builds: 0 failed, 16 passed, 21 warnings (v4=
.14.330-43-g0cf35e1ba8035)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
4/kernel/v4.14.330-43-g0cf35e1ba8035/

Tree: stable-rc
Branch: queue/4.14
Git Describe: v4.14.330-43-g0cf35e1ba8035
Git Commit: 0cf35e1ba803556df7ee44fe31f0ac3ed35242fa
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:

arm:

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

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

