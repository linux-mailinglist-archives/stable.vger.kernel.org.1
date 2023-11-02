Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196597DFB18
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 20:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjKBTtA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 15:48:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D2FB
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 12:48:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso1313813b3a.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698954532; x=1699559332; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L16bHyv0kub97a3cpLas1chBQ8DD/TiZ8JPYJEGsgFQ=;
        b=2Kv9qNuJSVsC1mVARpxGCKqWtXOlSAPinDWhWJyIovM/w2nXODWdrmqM0ZTr4TUens
         Mk93jXTfO5Kq/InmU8kFsLaL80TeZY5/4d1uhyYsWoLAR3+j/Jcp75KrZc56gOP9o/u7
         OpTDG/GnPRoQYVdJA01dumGctql+wZYyYnYXXVLj8pui8CIRUGg3qi9GrXzBD2BZjtzM
         NUWoG5gB4MeqfC13g5R+7dOWYYOuvOXfHYPYKKH8g0G9GffIA/Y8n5X31mdCe37eoiPE
         lkO3Tz0uo1FTPmwMbZ3dj5z3hO+xdylJKl5pv1KmkAUB14wvADNiWnuYoG6JYUIE7cOX
         Po6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698954532; x=1699559332;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L16bHyv0kub97a3cpLas1chBQ8DD/TiZ8JPYJEGsgFQ=;
        b=VnhZldhPjSVdtsfAyK2gFVhChvRbqnEOCkx5iyiM18EgjrvU6P+qtUGfczvPneXmE9
         jTjtkLdNy6F9UzNRnlsIjcZqTo1nXbhUOBWWO0any56AyCRqmzUg1iYqpxlwvEXVMbOc
         EzGv0oWDihpXwl/g5bGvC7g3U1wLuVpT1p9nK3dvyJ2hcTTz7qTT1IJIZ0eCw+CMTzzZ
         qzGQKKWstnFMwC2SXSV5t/40RkzbUoERdznnkid05dpfVNc2UqSX77uTgJkOva8jhDRz
         HSLxr9z3NeD2z3pcG9W6b4PC3RkNHeo+uvVUtYLcEmdhTMYqqsxLe9aPcpTROYjJoEGR
         HsQg==
X-Gm-Message-State: AOJu0Yx6jY4BED8WeAi+n4RHEIv3hxM8fgvihsONYvXFtuwmoJcLIKzc
        28yLBXMh8wKNlGxL8YIVs5uiNdzJ8YwVKSMZjuqKMA==
X-Google-Smtp-Source: AGHT+IHwHUCHwa7sXd9Ux9eCaerUDPyNr5bkr1vxLPBFR1cz8yx8krYpWh9BJTq6HT3F2AGSNb3s3A==
X-Received: by 2002:a05:6a00:391c:b0:6b7:cc4b:21d8 with SMTP id fh28-20020a056a00391c00b006b7cc4b21d8mr17870221pfb.1.1698954532220;
        Thu, 02 Nov 2023 12:48:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78c51000000b006c107a9e8f0sm124750pfd.128.2023.11.02.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:48:51 -0700 (PDT)
Message-ID: <6543fd23.a70a0220.50c00.0b2f@mx.google.com>
Date:   Thu, 02 Nov 2023 12:48:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.328-29-geab4064759fc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.14.y build: 16 builds: 3 failed, 13 passed, 6 errors,
 15 warnings (v4.14.328-29-geab4064759fc)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.14.y build: 16 builds: 3 failed, 13 passed, 6 errors, 15 =
warnings (v4.14.328-29-geab4064759fc)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.328-29-geab4064759fc/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.328-29-geab4064759fc
Git Commit: eab4064759fc1947010dfbccea1bb2941272d398
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
