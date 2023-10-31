Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A97DD161
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjJaQS4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJaQSz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 12:18:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA36BDA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 09:18:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c10f098a27so1978344b3a.2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698769131; x=1699373931; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i4vOt0nl8FjXoBnZJsYPsByhaeelK1f5U5nGOLBmhSk=;
        b=0WNT3EylDNdLDS5X9hLJzrjijFHl7AZOc0OLLxCZbCZ3lvP5izaH+pzGZmoaHYvyjC
         wBmpP5uvn/zGj6H0GBuK7KpWACgsX1YMBDbM+vihBC05k/JjfdUlTRvsmAymlD93zZBm
         AHgHoe8C4dKzc071gTelRHI1itL6QWGm1xOKjp4wLpniTUqMgYJboGoXPr2J/0MJh7dy
         BwY/x24f0cVfDgK8jLTWOWxP6mTDMTv1x9sLYU7wHRxGEfTaQi8v3sQMJvf8XuX5l7HG
         AyOFyFcXXfMS7CH0F6w08txX5Mjulq3vMDsy4ZG5a5rHgF4kqjRkmACy6JLg8+5/Tg+a
         duFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769131; x=1699373931;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4vOt0nl8FjXoBnZJsYPsByhaeelK1f5U5nGOLBmhSk=;
        b=o6bpurZj5Fh6QK7aP5eNzgDKLZRmN92roaIPKgddWRWsWcBRwHKSJWM2SAGkRA+KG6
         kexh50joubR31s2Rx/RQDWtYsad6Vgba2vbIxdoyp+O49T3b09OryXeEKiYksQBkFwG9
         +az3weGAqb0skVu/iPRWesSF5R8AQuPFdRHUhE+NevCkmpQt6xg8OUBPE1pvCSbBEJCj
         F7AAlioZKp2a2wQ9ggR448ziJJziW23RRrHCpu5/0nTVRDhFppeKBdxgSIaEqu23t+VS
         u6MdC7sC+V/VVqxR8A4vNW+Mtcw+PUr3AjJ1EXSAnGeWwOnru8UtmvUEBQ5WVPa3pcCT
         nmpw==
X-Gm-Message-State: AOJu0YwSJptDQ6Gz/lZ9O2LcBcXHrsQw1P3Ts36TatSemeEPNRcar7X2
        ntFzRrnCe/e1a9CGvxXvYM+XJMDvRlPnynyjm27z7g==
X-Google-Smtp-Source: AGHT+IE7Wkm+WOEQamq1VPzXu0QpbOkGfSqqvcqNCskf4+f956H0qCtfYSW8xhyzJ9w5pq2bMAAGJw==
X-Received: by 2002:a05:6a20:a21f:b0:17b:830c:cb11 with SMTP id u31-20020a056a20a21f00b0017b830ccb11mr8343951pzk.14.1698769131458;
        Tue, 31 Oct 2023 09:18:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k14-20020aa788ce000000b006862b2a6b0dsm1494361pff.15.2023.10.31.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:18:50 -0700 (PDT)
Message-ID: <654128ea.a70a0220.44de4.3eab@mx.google.com>
Date:   Tue, 31 Oct 2023 09:18:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.328-28-g951b0fedfe39
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.14.y build: 16 builds: 3 failed, 13 passed, 6 errors,
 15 warnings (v4.14.328-28-g951b0fedfe39)
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

stable-rc/linux-4.14.y build: 16 builds: 3 failed, 13 passed, 6 errors, 15 =
warnings (v4.14.328-28-g951b0fedfe39)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.328-28-g951b0fedfe39/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.328-28-g951b0fedfe39
Git Commit: 951b0fedfe3934a73709d5a01d3f57d23e879f11
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 6 unique architectures

Build Failures Detected:

i386:
    allnoconfig: (gcc-10) FAIL
    i386_defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:
    allnoconfig (gcc-10): 2 errors, 1 warning
    i386_defconfig (gcc-10): 2 errors, 1 warning
    tinyconfig (gcc-10): 2 errors, 1 warning

mips:

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 3 warnings
    x86_64_defconfig+x86-board (gcc-10): 3 warnings

Errors summary:

    6    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnem=
onic

Warnings summary:

    4    ld: warning: creating DT_TEXTREL in a PIE
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    4    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h=
' differs from latest kernel version at 'arch/x86/include/asm/insn.h'
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
allnoconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 section m=
ismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

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
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 sectio=
n mismatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

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
tinyconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 section mi=
smatches

Errors:
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic
    arch/x86/kernel/head_32.S:57: Error: invalid character '(' in mnemonic

Warnings:
    arch/x86/entry/entry_32.S:480: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

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
