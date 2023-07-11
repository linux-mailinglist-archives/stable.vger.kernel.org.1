Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A5A74FA1C
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 23:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGKVty (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGKVtw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 17:49:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111A170A
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 14:49:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso36617615ad.2
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689112175; x=1691704175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oD0CZWGlgYA9ru7CtlnzgS4vbHl7iH8IGILO4ZI3hRU=;
        b=bMZq3kRsYphRpwW+cOajow6LgmmA4EsOdYpTBJ21Nio76JWmHyl1KgQ94gGxMQabTS
         fPUftG1/Rx8NojpPFVksLNKXIBFnl3Z082DG7eGzaXGSpbjbt5ZN8WuzU8ot+AtinaE8
         fMTADGreb239948Msbvgu4vPh2/rYP+WR++zwCL9jMEyJaUiw/t3ckBUST1Ps3V2fxgw
         M4GXqMAMt1e79oD20w0z5cdypmRwAcFoUeSdftQMl9KVyvloxBRqgIEV75u5m7tKJm7b
         0ZOwlM6ORq584Y7WF4YAUTSVvk7Jv6JSvKodGWya/ZfOB/QYeuBYH7kH2+r684uBVNlO
         BiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689112175; x=1691704175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD0CZWGlgYA9ru7CtlnzgS4vbHl7iH8IGILO4ZI3hRU=;
        b=cQIl7OlRb9I1DM9NPz1YnZd5uZQW1emNhrbYk8fMKQJnj3aGhUiehmTjZRtsmQR9Co
         hkiry0YHaB4VV8oPHyg5r/RU7hk8rbqnfx41GkL3iUiu8di1B+tqXylQi1fa83Ptlkom
         IIg/f/V+KH1n/ZZP2avMlao846Nz72unHIsfPHHHEdbViuxZFhoEyik46JyU3vn7xUaH
         /Qz2zM5NV4xl3hWUTBl3xbwQdQ2jKIGMzSVOrjenhp172ddjACOf8IhvSN4wStQzV41a
         zi3lBaZ6By6ZWAwCSpnja8pCwv/nSVFzokzjqNJN8u232Ca6blNqTJoBZonvVR/gLoNp
         v26A==
X-Gm-Message-State: ABy/qLaBHpioIxoIumPIy5tQXtkjfDc6a6JaYu8yl3xcPNokoFff17W6
        ViC2qSn2+IGqydvnRrYGAN0sYsPO133JgtXqOhLL+g==
X-Google-Smtp-Source: APBJJlEhtQsdvUy1MlsW4mquA0G5IpwkZvIkaYx0TvJ+9AeVbKHbzb7sAa3tGcg4cQ/8eazZBnVy8w==
X-Received: by 2002:a17:903:32c6:b0:1b8:860c:2a7 with SMTP id i6-20020a17090332c600b001b8860c02a7mr20825252plr.28.1689112174911;
        Tue, 11 Jul 2023 14:49:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9bebb7a9dsm2408205pld.90.2023.07.11.14.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:49:34 -0700 (PDT)
Message-ID: <64adce6e.170a0220.63700.575d@mx.google.com>
Date:   Tue, 11 Jul 2023 14:49:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.320-57-gbc1094b21392
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.14.y
Subject: stable-rc/linux-4.14.y build: 14 builds: 1 failed, 13 passed, 1 error,
 25 warnings (v4.14.320-57-gbc1094b21392)
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

stable-rc/linux-4.14.y build: 14 builds: 1 failed, 13 passed, 1 error, 25 w=
arnings (v4.14.320-57-gbc1094b21392)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.320-57-gbc1094b21392/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.320-57-gbc1094b21392
Git Commit: bc1094b213929360a2dd73e3ff406b6e1504e0da
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 5 unique architectures

Build Failure Detected:

arm:
    multi_v5_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:

arm:
    multi_v5_defconfig (gcc-10): 1 error

i386:
    allnoconfig (gcc-10): 3 warnings
    i386_defconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings

mips:

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 5 warnings

Errors summary:

    1    /tmp/kci/linux/build/../arch/arm/probes/kprobes/core.c:555: undefi=
ned reference to `kprobe_handler'

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
    2    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x73: return with modified stack frame
    2    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x0: stack state mismatch: cfa1=3D7+104 cfa2=3D7+8

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
multi_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    /tmp/kci/linux/build/../arch/arm/probes/kprobes/core.c:555: undefined r=
eference to `kprobe_handler'

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x73: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+104 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
5 warnings, 0 section mismatches

Warnings:
    Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' dif=
fers from latest kernel version at 'arch/x86/include/asm/insn.h'
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x73: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+104 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
