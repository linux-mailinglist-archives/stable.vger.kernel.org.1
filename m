Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34307F491F
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjKVOkZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 09:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKVOkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 09:40:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9564112
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 06:40:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf80a7be0aso614015ad.1
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700664019; x=1701268819; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sB5h4sRcTqZbQgHsMWPDQ1Zoko+lG0XipOA5BU4rIUE=;
        b=r4Z1sn++Ax57lPnjjWbiBlc2nqwp+Pb/LrO008owYsGvrB5w6i7hVe/sGDDmAxSfBX
         L3JZqq4EzEtLZj2nUMAZEe2VJwsSaMeCVdmv7gDyztQQbYta24zRhHfFsdPCtQQbixDK
         c8l00Tazyo0uFAceUZbcUrhVrmdTP7/FO9Jhrgef3XmtStd2b7SgnuTD0Zbjo4Ov5/w/
         eYGTLebCh20FssGEWKunG34FK+dDcIelqPTNUZn3YLHyig68AHgVpazwM8p/Qee+k5cT
         DvvtzoUunhrRTisUk1vy44ROmSMi2J/AHNYerE5x/UF6XmuFyp7WkHcN47m0OU6ha0X+
         OMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664019; x=1701268819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB5h4sRcTqZbQgHsMWPDQ1Zoko+lG0XipOA5BU4rIUE=;
        b=TYOdgl5znTpLN23pH4COJxMU7XKxBhkRGCViU5+w1nV8BT6UPUqjp8Zgvo9lEemo+/
         GoH2qVgu5YiP1SIxmVYOMnaaPzCJkyWz20Qvss8PvAKJtV9/pPR13uqCiDH0iN4qA4p6
         ZWqjPkelne+SyefAk6A1SvWWaMN9EZCOHqSwge6IuexqmtL8c9hrX8ODM/K7ks5bhDQn
         ZcVBMLMfl8h7oip1NhNhPMWrh07V0czHjXUJIXKJ/JHxKeJ2iY+W9W5lykF3uASTrXi+
         qRhElyWTU0pjuRaVxmQ4+rfzlPHxgF/R+pxOE5x+kg6gmeqN+boLdsLKswq7Ip2eDGO5
         DXHA==
X-Gm-Message-State: AOJu0YxuBChCVCa7I/BREOi7PhkodFIuDzfi82jrzDCdNXoXOAjG+Bei
        XA4tecfeuAECjEeEtsAkl1/Vevzm36I8Lv4aV3Y=
X-Google-Smtp-Source: AGHT+IHWnpNsVpLkgHyc1e/nICzEEtbyGS5OGF14Q020MDViKSEdGpRtcnJ53cnfmEmCmfHVlVaQRQ==
X-Received: by 2002:a17:902:ce8c:b0:1cc:787f:fb7 with SMTP id f12-20020a170902ce8c00b001cc787f0fb7mr2786100plg.19.1700664018720;
        Wed, 22 Nov 2023 06:40:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001bbb7af4963sm9858599plg.68.2023.11.22.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:40:18 -0800 (PST)
Message-ID: <655e12d2.170a0220.962b6.a50a@mx.google.com>
Date:   Wed, 22 Nov 2023 06:40:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-50-gaa3fbf0e1c59
Subject: stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed,
 20 warnings (v4.19.299-50-gaa3fbf0e1c59)
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

stable-rc/queue/4.19 build: 19 builds: 3 failed, 16 passed, 20 warnings (v4=
.19.299-50-gaa3fbf0e1c59)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/queue%2F4.1=
9/kernel/v4.19.299-50-gaa3fbf0e1c59/

Tree: stable-rc
Branch: queue/4.19
Git Describe: v4.19.299-50-gaa3fbf0e1c59
Git Commit: aa3fbf0e1c59ca82ef95e6009142dd913905face
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 7 unique architectures

Build Failures Detected:

riscv:
    allnoconfig: (gcc-10) FAIL
    defconfig: (gcc-10) FAIL
    tinyconfig: (gcc-10) FAIL

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 3 warnings
    defconfig+arm64-chromebook (gcc-10): 3 warnings

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
    x86_64_defconfig+x86-board (gcc-10): 2 warnings


Warnings summary:

    7    ld: warning: creating DT_TEXTREL in a PIE
    6    aarch64-linux-gnu-ld: warning: -z norelro ignored
    4    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    3    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
allnoconfig (riscv, gcc-10) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches

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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warn=
ings, 0 section mismatches

Warnings:
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored
    aarch64-linux-gnu-ld: warning: -z norelro ignored

Section mismatches:
    WARNING: modpost: Found 1 section mismatch(es).

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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 war=
nings, 0 section mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
