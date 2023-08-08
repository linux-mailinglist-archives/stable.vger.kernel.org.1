Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45B7774E41
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHHWa7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHHWa6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 18:30:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011AFD
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 15:30:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6877eb31261so4582377b3a.1
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691533857; x=1692138657;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JG3nkf6K3h33FglMkdk+FlZEdZXjy10LMYhcpg/sfKU=;
        b=ssqd22FVBGCv4SgLgWTXC3ZmYndDI5GfNn0XCUpZew8YErsiCvufF/qDGNM65BgFOr
         P1gxmPBsAkQznbWav3xwkzSAHy8nF9jwG3aXc8lCZHShYvdHTtbAEmQyJ3NT0ry0Ul5x
         IQWhHbjg9g9DGM1m6ai4lZop3h/wzS/zgCpLmC44VdYxYRkDb2h1ii92TAqOjm0L/cbA
         AxoY3ch6XcG/PyAmmOHRQdL/xGcDHu8A/1he0a9pkvUEneJKUE67+rEZs5gZe2Amt0tK
         UDB4x3A5ekpsQbr9bsCeLD1NWa+vK39g8FoT9vysZfFa2aVehW0zm+05+1MI7MLUbEo/
         mhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691533857; x=1692138657;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG3nkf6K3h33FglMkdk+FlZEdZXjy10LMYhcpg/sfKU=;
        b=HujTMkWmNru7CZbhP01aDqmS0DzWV2BAlcDc111Aaw2nmzsWpI8rOchhYMWVhWeBml
         X8Kt/YPgrcv47f3ysbLQRuKEINDpNihPlb9xkUY3et+dGrGdhcrnhTie5SA8jc/pycHa
         VySjnw/PFV8k/OaZ62Nt6E3xTVkJz7nwDUn8SlaVblQAHxzACZKUNJE3OhPiZO7PMwHS
         tcY+F/eA6sUlvGlyYgZ7WH5e1CKq052blq9aKhXoHaQUcPCfQbKeLaTuoioUQm7VaxFk
         Kq4qBVBWZL8hpNDkDgTRrtpt9aczU2OpRZieIjWZynj1Guv1UyY/i56W4+JS9rTed3RC
         0/dg==
X-Gm-Message-State: AOJu0Ywdt+FuP3LYFRTmTn8MbUMr/Uyj8lsy1MTV8kRHW5Lla7tfzvEd
        1nCYU6cBiBHCBoI9vSvG27wyUCkWdwTWoXvbEqNwPA==
X-Google-Smtp-Source: AGHT+IFa1YLHshEgh1K4haYHJ0e+HMjehxm2qew2veptsmdmemARQrtbkhkXUMOi1mncJNyv6IiOgA==
X-Received: by 2002:a05:6a21:4995:b0:13b:9d80:673d with SMTP id ax21-20020a056a21499500b0013b9d80673dmr851893pzc.48.1691533856969;
        Tue, 08 Aug 2023 15:30:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b001b9dab0397bsm9509470plb.29.2023.08.08.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 15:30:56 -0700 (PDT)
Message-ID: <64d2c220.170a0220.dc454.2d11@mx.google.com>
Date:   Tue, 08 Aug 2023 15:30:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.14.321-205-gfb458be8437f
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
Subject: stable-rc/linux-4.14.y build: 16 builds: 0 failed, 16 passed,
 25 warnings (v4.14.321-205-gfb458be8437f)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.14.y build: 16 builds: 0 failed, 16 passed, 25 warnings (=
v4.14.321-205-gfb458be8437f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.321-205-gfb458be8437f/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.321-205-gfb458be8437f
Git Commit: fb458be8437f3053c5a06e9e7aae2398f6650203
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
    x86_64_defconfig (gcc-10): 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 5 warnings


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
