Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E47EC43A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 14:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbjKON7M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 08:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344028AbjKON7L (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 08:59:11 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A964D13D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:59:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c184b3bbc4so2815903a12.1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700056747; x=1700661547; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZjEk5lgS6VEWJASrYwZhFxneJamph1g7oFx1YTSt9Q=;
        b=FYjtTk4kM09F4UPdu1M/B3gYG37oBNbTNryDPVJ5+NEbTs67Ypgw6QmnzqqdUAkqX4
         aLaqw1+lLAYlzdDovFNGdHJZNOvhcDBRNpuO4K4m8BL7txmFkk5q4jCY2Ldwd/cspfqX
         +gYvs+SEWWBwSfhEHzM2EVHWaefGs0HaH/Gg9mSirtJf03qZabMom/ULiEzXz6rqArye
         Iqs8WnMSD0w9G3b6czMexqdzBR2tXwCv8DoFCcl9YOQ7RuQckS8z7ze6dWbWOZnTOIfT
         i0bQvKsiGTqLGjgVUgdWw2CTYxbyLIzB46CjVSIH6b0yI/S9uxKOPtYiTqawBD8iBOpd
         FLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056747; x=1700661547;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZjEk5lgS6VEWJASrYwZhFxneJamph1g7oFx1YTSt9Q=;
        b=aQSMYt1xnbORwsFo9nMkMm5wiMEEvDpYJwaVcKnTtT+dJG0EsVfIsXgnMGVvLLx7PM
         Kh66A3KUA+Wo3uqCDwV0nOuDyKss48U935hngMgxJF/I8HRHcgtc8+UpJO4aJ0nVo0/e
         YJdew3hh8ERPwgbroNv7SYQn02baOWJsbCVvBIehxjVtiJiiE5hjlN4hrQ4JsMdlVrxz
         Lxf03BZeUtqxnBgk9+e0FxcQM7LxfCYr24TitAiE7D+TSumhwpeGtOh5AjnJEOEWfC23
         ngJ0UrBPmm7JNOCA/1pGJiwgeVYRbv+ZHYywhiYx2JKXyfw/PCcvFk/y+z3sFg7mAqi7
         bMKg==
X-Gm-Message-State: AOJu0YxKBQ2GCK7hz0/GqhpsQa4ccV0jJxDVGORfwmhIdVoMl9Ta0RuF
        lUoeQk+8T7Mi/UekWq73V7DuhfV3OE/259aMkQtMfg==
X-Google-Smtp-Source: AGHT+IFAKoCfMWx3iWNG0W/yXYTE5nSxVMNNUJpkCdVfEAu9lv/nOwajEqfXAwqtxAos6XV0iZ5EQA==
X-Received: by 2002:a05:6a20:4311:b0:154:e793:52b3 with SMTP id h17-20020a056a20431100b00154e79352b3mr15973196pzk.0.1700056746689;
        Wed, 15 Nov 2023 05:59:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p8-20020a056a000a0800b006934a1c69f8sm2852268pfh.24.2023.11.15.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:59:06 -0800 (PST)
Message-ID: <6554ceaa.050a0220.e339.8b69@mx.google.com>
Date:   Wed, 15 Nov 2023 05:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.298-87-g060b297883f5
Subject: stable-rc/linux-4.19.y build: 19 builds: 5 failed, 14 passed,
 15 warnings (v4.19.298-87-g060b297883f5)
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

stable-rc/linux-4.19.y build: 19 builds: 5 failed, 14 passed, 15 warnings (=
v4.19.298-87-g060b297883f5)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.298-87-g060b297883f5/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.298-87-g060b297883f5
Git Commit: 060b297883f5eca43b68a02a7b19bc368b427996
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings

arm:

i386:
    allnoconfig (gcc-10): 2 warnings
    i386_defconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings

mips:

riscv:

x86_64:
    allnoconfig (gcc-10): 2 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 2 warnings


Warnings summary:

    6    ld: warning: creating DT_TEXTREL in a PIE
    3    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    3    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches summary:

    2    WARNING: modpost: Found 1 section mismatch(es).

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section m=
ismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 secti=
on mismatches

Warnings:
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
tinyconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>
